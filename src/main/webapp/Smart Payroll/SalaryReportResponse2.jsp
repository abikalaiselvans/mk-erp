<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
   

<%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>


<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%
	 
	String office= ""+request.getParameter("Office");
	String dept= ""+request.getParameter("dept");
	String type= ""+request.getParameter("type");
	String month= ""+request.getParameter("month");
	String year= ""+request.getParameter("year");
	String repmon = DateUtil.getMonth(Integer.parseInt( month));
	String company= ""+request.getParameter("company");
	String branch= ""+request.getParameter("branch");
	String Category= ""+request.getParameter("Category");
	String empid= ""+request.getParameter("empid");
	String empname= ""+request.getParameter("empname");
	String basic= ""+request.getParameter("basic");
	String wdays= ""+request.getParameter("wdays");
	String pf= ""+request.getParameter("pf");
	String esi= ""+request.getParameter("esi");
	String mess= ""+request.getParameter("mess");
	String advance= ""+request.getParameter("advance");
	String netpay= ""+request.getParameter("netpay");
	String monhpay= ""+request.getParameter("monhpay");
	String cpyesi= ""+request.getParameter("cpyesi");
	String cpypf= ""+request.getParameter("cpypf");
	String bank= ""+request.getParameter("bank");
	String acno= ""+request.getParameter("acno");
	String ctc= ""+request.getParameter("ctc");
	String resigned= ""+request.getParameter("resigned");
	String hold= ""+request.getParameter("hold");
	String PFNumber= ""+request.getParameter("PFNumber");
	String ESINumber= ""+request.getParameter("ESINumber");
	String pfdoj= ""+request.getParameter("pfdoj");
	String sql =""; 
	
	
	
	String allowancefield[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
	String sumgrossallowancefield="";
	String sumothersallowancefield="";
	String allowancefields="";
	String  allowancename="";
	if(allowancefield.length>0)
	{
		for(int u=0;u<allowancefield.length;u++)
		{
			if("Y".equals(allowancefield[u][2]))
				sumgrossallowancefield =sumgrossallowancefield+ " g."+allowancefield[u][0]+"+";
			else
				sumothersallowancefield =sumothersallowancefield+ " g."+allowancefield[u][0]+"+";
				
			allowancefields =allowancefields+ " g."+allowancefield[u][0]+",";
			 allowancename = allowancename+ "  "+allowancefield[u][1]+",";
		}
 	}
	
	String recoveryfield[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
	String sumrecoveryfield="";
	String recoveryfields="";
	 String recoveryname="";
	if(recoveryfield.length>0)
	{
		for(int u=0;u<recoveryfield.length;u++)
		{
			sumrecoveryfield =sumrecoveryfield+ " g."+recoveryfield[u][0]+"+";
			recoveryfields =recoveryfields+ " g."+recoveryfield[u][0]+",";
			 recoveryname =recoveryname+ "  "+recoveryfield[u][1]+",";
			
		}
 	}
	// sql = " SELECT a.CHR_EMPID,
	 sql = " SELECT IF( PAY_FUN_GET_TERMINATE(a.CHR_EMPID ),CONCAT(a.CHR_EMPID,'****'),IF(PAY_FUN_GET_TEMPORARYSUSPENSION(a.CHR_EMPID )=1,CONCAT(a.CHR_EMPID,'####'),a.CHR_EMPID)), ";
	  
	sql = sql + " a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_CATEGORYNAME,a.CHR_TYPE, ";
	sql = sql + " g.DOU_WORKDAYS,FORMAT(g.DOU_BASIC,2), ";
	sql = sql + allowancefields ;
	sql = sql + " ( " +sumgrossallowancefield +" 0 )  , " ;
	sql = sql + " ( " +sumothersallowancefield +" 0 ) ,  " ;
	sql = sql + " ( g.DOU_BASIC + " +sumgrossallowancefield +" 0 ) , " ; 
	sql = sql + recoveryfields ;
	sql = sql + " ( " +sumrecoveryfield +" 0 ) ,   " ; 
	sql = sql + " g.DOU_PAYTAX,DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y'), ";
	sql = sql + " CONCAT(b.CHR_PFNUMBER,a.CHR_PFNO),g.DOU_PF,a.CHR_ESINO,g.DOU_ESI, ";
	sql = sql + " g.DOU_MESS,g.DOU_ADVANCE,g.DOU_TOTALRECOVERY,g.DOU_NETSAL,g.DOU_MONTHSAL, ";
	sql = sql + " g.DOU_CPYPF1,g.DOU_CPYPF2,g.DOU_CPYESI,g.DOU_CTC,FIND_A_BANKGROUP_NAME(a.CHR_BANK),CONCAT('A/c No . ', a.CHR_ACCNO) ";
	sql = sql + " ,'"+repmon+"' ,'"+year+"' ";
	sql = sql + "  FROM com_m_staff a,com_m_company b, com_m_branch c,com_m_office d,com_m_depart e,com_m_employeecategory f,pay_t_salary g ";//,com_m_bank h 
	sql = sql + " WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
	sql = sql + " AND a.INT_BRANCHID =c.INT_BRANCHID ";
	sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID ";
	sql = sql + " AND a.INT_DEPARTID =e.INT_DEPARTID ";
	sql = sql + " AND a.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID ";
	sql = sql + " AND a.CHR_EMPID  = g.CHR_EMPID ";//AND a.CHR_BANK = h.INT_BANKID
	sql = sql + " AND g.CHR_MONTH ='"+repmon+"'  ";
	sql = sql+ "  AND g.INT_YEAR="+ year+" ";
	String lastday = CommonFunctions.QueryExecute("select day(LAST_DAY('"+year+"-"+(month)+"-21')) ")[0][0];
	sql = sql+ "  AND a.DT_DOJCOLLEGE<='"+year+"-"+month+"-"+lastday+"'";
	if(!"0".equals(company))
		sql = sql + "   AND a.INT_COMPANYID="+company;
	if(!"0".equals(branch))
		sql = sql + "  AND a.INT_BRANCHID="+branch;
	if(!"0".equals(Category))
 		sql = sql + "  AND a.CHR_CATEGORY='"+Category +"' ";	
	if(!"Y".equals(resigned))
		sql = sql + "  AND a.CHR_TYPE!='T' ";
	if(!"Y".equals(hold))
		sql = sql + "  AND a.CHR_HOLD!='Y'   ";	
	
	if(!"0".equals(office))
		sql = sql + "  AND a.INT_OFFICEID="+office;
	if(!"0".equals(dept))
		sql = sql + "  AND a.INT_DEPARTID= "+dept;
	
	if(!"0".equals(type))
		if("CONSOLIDATE".equals(type))
			sql = sql +" AND a.CHR_TYPE='CONSOLIDATE' ";
		else
			sql = sql +" AND a.CHR_TYPE !='CONSOLIDATE' ";
	
	
	sql = sql + "  GROUP BY a.CHR_EMPID  ";
	//out.println(sql);
	 
	 
	 int columncount = CommonFunctions.intGetColumnCount(sql);
	 
	 
	 String data[][] =CommonFunctions.QueryExecute(sql);
	 Vector mn = new Vector();
	 Vector child= null;
     for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			for(int j=0;j<columncount;j++)
				child.addElement(data[u][j]);
			mn.add(child);
     } 
 
	mn.add(child);
	request.setAttribute("table",mn);
	 
	String filesaveas="Salaryreport_"+repmon+"_"+year;
	out.println("<br><center><h1>SALARY CALCULATION  ( "+repmon+" - "+year+" ) </h1></center><br>"); 


sql = " S.NO,EMP ID, STAFF NAME,COMPANY,BRANCH,OFFICE,DEPARTMENT,CATEGORY,STAFF TYPE, ";
sql = sql+ " NO  OF WORKING DAYS,BASIC,"+allowancename+" GROSS ALLOWANCE,OTHER ALLOWANCE,GROSS , ";
sql = sql+ recoveryname + "TOTAL RECOVERY,   PROFESSIONAL TAX , PF/ESI DOJ,  PF NUMBER, PF AMOUNT,ESI NUMBER,ESI AMOUNT, ";
sql = sql+ " MESS,ADVANCE,TOTAL RECOVERY,NET SALARY,MONTH SALARY, COMPANY PF -1, COMPANY PF -2, COMPANY ESI,CTC, ";
sql = sql+ " Bank, A/c : No , MONTH,YEAR  ";
 String rdata[] = sql.split(","); 
 
  
%>

<display:table   id="_table" name="table"    export="true">
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
								 <%
								for(int j=0;j<=columncount;j++)
								{
								%>
									<display:column title="<%= rdata[j].toUpperCase()%>" sortable="true"><%=temp.elementAt(j)%></display:column>
								<%
								}
					 
								%>
					<display:setProperty name="export.csv.filename" value="Salary_Report.csv"/>
					<display:setProperty name="export.excel.filename" value="Salary_Report.xls"/>
					<display:setProperty name="export.xml.filename" value="Salary_Report.xml"/>
					<display:setProperty name="export.pdf.filename" value="Salary_Report.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
<br />
									<center>	<a href='Salary Report.jsp'> CLOSE</a></center>
<br /><br />

<%	 
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>