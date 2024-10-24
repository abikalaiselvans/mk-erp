 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<body >

<%
try
{
 		String  company  = request.getParameter("company");
		String  branch  = request.getParameter("branch");
		String  office  = request.getParameter("Office");
		String  yr  = request.getParameter("year");
		int  year= Integer.parseInt(yr);
		String  tdsamount  = request.getParameter("tdsamount");
	
		String sql="";
		String reportheader=" TDS EMPLOYEE LIST FOR THE FINANCIAL YEAR "+year + "-" +(year+1);
		sql = "  SELECT FIND_A_TDS_EMPID_LIST("+year+","+tdsamount+") ";
		String emplist =  CommonFunctions.QueryExecute(sql)[0][0];
		
		
		sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_MONTH,b.INT_YEAR,b.INT_MONTHDAYS,b.DOU_WORKDAYS, ";
		sql = sql + " b.DOU_BASIC,b.DOU_ATOTAL1,b.DOU_ATOTAL2,b.DOU_GROSSPAY,b.RTOTAL, ";
		sql = sql + " b.DOU_PF,b.DOU_ESI,b.DOU_ADVANCE,b.DOU_NETSAL,b.DOU_MONTHSAL, ";
		sql = sql + " b.DOU_CPYPF1,b.DOU_CPYPF2,b.DOU_CPYESI,b.DOU_SUM,b.DOU_CTC,b.DOU_ORIGINALCTC, ";
		sql = sql + " b.DOU_LOPDAY,b.DOU_LOP,b.DOU_PENBASIC,b.DOU_COMPANYPF,b.DOU_COMPANYPENSION, ";
		sql = sql + " b.DOU_ADMINCHARGE,b.DOU_EDLI,b.DOU_ADMINCHARGE1,b.DOU_PAYTAX, CONCAT('-')";
		//sql = sql + " ROUND(FUN_PAY_GET_FINANCIAL_SALARY(a.CHR_EMPID,"+year+"),2) ";
		sql = sql + " FROM com_m_staff a, pay_t_salary b ";
		sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID"; 
		sql = sql + " AND (  ";
		sql = sql + "   (  ";
		sql = sql + "    b.CHR_MONTH IN ('April','May','June','July','August','September','October','November','December') ";
		sql = sql + "    AND b.INT_YEAR = "+year;
		sql = sql + "   ) ";
		sql = sql + "   OR  ";
		sql = sql + "   (  ";
		sql = sql + "    b.CHR_MONTH IN ('January','February','March') ";
		sql = sql + "    AND b.INT_YEAR =  "+(year+1);
		sql = sql + "   ) ";
		sql = sql + " ) ";
		//sql = sql + " AND FUN_PAY_GET_FINANCIAL_SALARY(a.CHR_EMPID,"+year+") >= "+tdsamount;
		sql = sql + " AND a.CHR_EMPID IN( "+emplist+" '0' )";
		if(!"0".equals(office))
			sql = sql + "  AND a.INT_OFFICEID="+office;
		if(!"0".equals(company))
			sql = sql + " AND a.INT_COMPANYID="+company;
		if(!"0".equals(branch))
			sql = sql + "  AND a.INT_BRANCHID="+branch;
		sql = sql + " ORDER  BY a.CHR_STAFFNAME ";
		//out.println(sql); 	 
		
		 
 
 
 		String alldata[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE, CHR_ANAME FROM pay_m_allowance WHERE CHR_FLAG ='Y' ORDER BY INT_ALLOWANCEID");
		
		String reportinghead="S.NO,EMPID, STAFF NAME, MONTH, YEAR, BASIC,";
		sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_MONTH,b.INT_YEAR, b.DOU_BASIC, ";
		if(alldata.length>0)
			for(int i=0;i<alldata.length;i++)
			{
				sql = sql +alldata[i][0]+ " ,";
				reportinghead =reportinghead+alldata[i][1]+ " ,";
			}
			
		sql = sql + " b.DOU_ATOTAL1,b.DOU_ATOTAL2,b.DOU_GROSSPAY, b.DOU_PF, b.DOU_PAYTAX,b.DOU_MONTHSAL,CONCAT('-')  ";
		reportinghead =reportinghead+" GROSS ALLOWNACE, REIMBURSEMENT, GROSS, PF, PROFESSION TAX, MANTH SALARY,";
		String col[] =	reportinghead.split(",");
		
		sql = sql + " FROM com_m_staff a, pay_t_salary b ";
		sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID"; 
		sql = sql + " AND (  ";
		sql = sql + "   (  ";
		sql = sql + "    b.CHR_MONTH IN ('April','May','June','July','August','September','October','November','December') ";
		sql = sql + "    AND b.INT_YEAR = "+year;
		sql = sql + "   ) ";
		sql = sql + "   OR  ";
		sql = sql + "   (  ";
		sql = sql + "    b.CHR_MONTH IN ('January','February','March') ";
		sql = sql + "    AND b.INT_YEAR =  "+(year+1);
		sql = sql + "   ) ";
		sql = sql + " ) ";
		sql = sql + " AND a.CHR_EMPID IN( "+emplist+" '0' )";
		if(!"0".equals(office))
			sql = sql + "  AND a.INT_OFFICEID="+office;
		if(!"0".equals(company))
			sql = sql + " AND a.INT_COMPANYID="+company;
		if(!"0".equals(branch))
			sql = sql + "  AND a.INT_BRANCHID="+branch;
		sql = sql + " ORDER  BY a.CHR_STAFFNAME , b.DT_UPDATEDATE";
		 
		int totalcolumn= 5+alldata.length+7;
		 
		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] =  CommonFunctions.QueryExecute(sql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				 
				child.addElement((u+1));
				for(int i=0;i<totalcolumn;i++)
					child.addElement(data[u][i]);
				mn.add(child);;
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	<display:caption><%=reportheader.toUpperCase()%></display:caption>
	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	<%
		 for(int a=0;a<col.length;a++)
		 {
		 %>
		 <display:column title="<%=col[a]%>" sortable="true"><%=temp.elementAt(a)%></display:column>
		 <%
		 }
		 
		%>
	  
	<display:setProperty name="export.excel.filename" value="TDSFilterList.xls"/>
	<display:setProperty name="export.pdf.filename" value="TDSFilterList.pdf"/>
	<display:setProperty name="export.csv.filename" value="TDSFilterList.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

