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
<title>-</title>

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
 		String  empid   = request.getParameter("empid");
		String  yr  = request.getParameter("year");
		int  year= Integer.parseInt(yr);
		String sql="";
		String empname =  CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+empid+"')")[0][0];
		String reportheader=empname+" TDS -  LIST FOR THE FINANCIAL YEAR "+year + "-" +(year+1);
		 
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
		sql = sql + " AND a.CHR_EMPID IN('"+empid+"' )";
		 
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
		 for(int a=0;a<col.length-1;a++)
		 {
		 %>
		 <display:column title='<%=col[a]%>' sortable="true"><%=temp.elementAt(a)%></display:column>
		 <%
		 }
		 
		%>
	  
	<display:setProperty name="export.excel.filename" value="TDSFilterList.xls"/>
	<display:setProperty name="export.pdf.filename" value="TDSFilterList.pdf"/>
	<display:setProperty name="export.csv.filename" value="TDSFilterList.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Staff_tds.jsp'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
	out.println(""+e.getMessage());
}
%>		 
</body>
</html>

