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
 
<title> :: COMMON ::</title>




<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<%
try
{
%>
 
<body  onpaste='return false;'><br> 
<%
 

String reportheader=" ABORT CASES ";
String company = request.getParameter("company");
String branch = request.getParameter("branch");
String Office = request.getParameter("Office");
String dept = request.getParameter("dept");
 
String fromdate = request.getParameter("fromdate");
String todate = request.getParameter("todate");
fromdate = DateUtil.FormateDateSQL(fromdate);
todate = DateUtil.FormateDateSQL(todate);
 
String sql="";
sql = sql +"  SELECT b.CHR_OFFICENAME,c.CHR_DEPARTNAME,d.CHR_DESIGNAME,e.CHR_CATEGORYNAME,COUNT(*) , ";
sql = sql +"  FUN_A_RESIGNNER_COUNT(a.INT_OFFICEID,a.INT_DEPARTID,a.INT_DESIGID,e.INT_EMPLOYEECATEGORYID,'"+fromdate+"','"+todate+"') ";
sql = sql +"  FROM com_m_staff a, com_m_office b, com_m_depart c, com_m_desig d, com_m_employeecategory e ";
sql = sql +"  WHERE a.INT_OFFICEID = b.INT_OFFICEID ";
sql = sql +"  AND a.INT_DEPARTID =c.INT_DEPARTID ";
sql = sql +"  AND a.INT_DESIGID = d.INT_DESIGID ";
sql = sql +"  AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID ";
sql = sql +"  AND a.DT_DOJCOLLEGE >='"+fromdate+"' ";
sql = sql +"  AND a.DT_DOJCOLLEGE <='"+todate+"' ";
if(!"0".equals(company))
	sql = sql +" AND a.INT_COMPANYID="+company;
if(!"0".equals(branch))
	sql = sql +" AND a.INT_BRANCHID="+branch;
if(!"0".equals(Office))
	sql = sql +" AND a.INT_OFFICEID="+Office;

sql = sql +"  GROUP BY a.INT_OFFICEID,a.INT_DEPARTID,a.INT_DESIGID,e.INT_EMPLOYEECATEGORYID ";

String data[][] = CommonFunctions.QueryExecute(sql);
Vector mn = new Vector();
Vector child= null;
for(int u=0; u<data.length;u++)
{
	child = new Vector();
	child.addElement((u+1)+".");
	child.addElement(data[u][0]);
	child.addElement(data[u][1]);
	child.addElement(data[u][2]);
	child.addElement(data[u][3]);
	child.addElement(data[u][4]);
	child.addElement(data[u][5]);
	mn.add(child);
} 
request.setAttribute("table",mn); 
%>


<center>
<display:table   id="_table" name="table"   export="true" pagesize="25">
		<display:caption><%=reportheader.toUpperCase()%></display:caption>
		<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
		<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
		<display:column title="OFFICE" sortable="true"><%=temp.elementAt(1)%></display:column>
		<display:column title="DEPARTMENT" sortable="true"><%=temp.elementAt(2)%></display:column>
		<display:column title="DESIGNATION" sortable="true"><%=temp.elementAt(3)%></display:column>
		<display:column title="CATEGORY" sortable="true"><%=temp.elementAt(4)%></display:column>
		<display:column title="JOINNER" sortable="true"><%=temp.elementAt(5)%></display:column>
		<display:column title="RESIGNNER" sortable="true"><%=temp.elementAt(6)%></display:column>
		
		<display:setProperty name="export.excel.filename" value="Rept_Poorrecruitment .xls"/>
		<display:setProperty name="export.pdf.filename" value="Rept_Poorrecruitment.pdf"/>
		<display:setProperty name="export.csv.filename" value="Rept_Poorrecruitment.csv"/>
		<display:setProperty name="export.pdf"  value="true" />
					 
</display:table> 
</center>			
<br />	<center>	<a href='Poor recruitment.jsp'> CLOSE</a></center>
			

 
</body>
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</html>
