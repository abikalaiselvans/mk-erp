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
 

 	String reportheader="STAFF TRANSFER LIST ";
	String id = request.getParameter("ename");
	String sql="";
	sql = " SELECT a.CHR_EMPID ,a.CHR_STAFFNAME, ";
	sql = sql +" FUN_GET_COMPANY(b.INT_FROM_COMPANYID) fromcompany ,FUN_GET_COMPANY(b.INT_TO_COMPANYID) tocompany, ";
	sql = sql +" FUN_GET_BRANCH(b.INT_FROM_BRANCHID) frombranch, FUN_GET_BRANCH(b.INT_TO_BRANCHID) tobranch, ";
	sql = sql +" FUN_GET_DEPARTNAME(b.INT_FROM_DEPARTID) fromdepart, FUN_GET_DEPARTNAME(b.INT_TO_DEPARTID) todepart, ";
	sql = sql +" FUN_GET_DESIGNAME(b.INT_FROM_DESIGID) fromdesig   , FUN_GET_DESIGNAME(b.INT_TO_DESIGID) todesig, ";
	sql = sql +" FUN_GET_OFFICENAME(b.INT_TO_OFFICEID) fromoffice, FUN_GET_OFFICENAME(b.INT_TO_OFFICEID) tooffice, ";
	sql = sql +" FUN_GET_LOCATION(b.INT_FROM_LOCATIONID) fromlocation, FUN_GET_LOCATION (b.INT_TO_LOCATIONID) tolocation, ";
	sql = sql +" FUN_GET_CATEGORYNAME(b.INT_FROM_CATEGORY) fromcategory, FUN_GET_CATEGORYNAME(b.INT_TO_CATEGORY) tocategory, ";
	sql = sql +" IF(b.INT_FROMATTENDANCECYCLE='1','1-31','20th-19th') fromcycle, ";
	sql = sql +" IF(b.INT_ATTENDANCECYCLE='1','1-31','20th-19th') tocycle, ";
	sql = sql +" FIND_A_EMPLOYEE_ID_NAME(b.CHR_FROM_REPTO) fromreporting, ";
	sql = sql +" FIND_A_EMPLOYEE_ID_NAME(b.CHR_TO_REPTO) toreporting, ";
	sql = sql +" DATE_FORMAT(b.DT_TRANSFERDATE,'%d-%b-%Y'), ";
	sql = sql +" DATE_FORMAT(b.DT_RELEAVINGFROM,'%d-%b-%Y'), ";
	sql = sql +" b.CHR_REASON  ";
	sql = sql +" FROM com_m_staff a, pay_m_emp_transfer b  ";
	sql = sql +" WHERE a.CHR_EMPID =b.CHR_EMPID ";
	sql = sql +" AND a.CHR_EMPID = '"+id+"'";
	sql = sql +" ORDER BY  a.CHR_STAFFNAME ";
	//out.println(sql); 
 	 
     String data[][] = CommonFunctions.QueryExecute(sql);
     Vector mn = new Vector();
	 Vector child= null;
     for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			child.addElement(data[u][1]);
			child.addElement(data[u][2]);
			child.addElement(data[u][3]);
			child.addElement(data[u][4]);
			child.addElement(data[u][5]);
			child.addElement(data[u][6]);
			child.addElement(data[u][7]);
			child.addElement(data[u][8]);
			child.addElement(data[u][9]);
			child.addElement(data[u][10]);
			child.addElement(data[u][11]);
			child.addElement(data[u][12]);
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			child.addElement(data[u][15]);
			child.addElement(data[u][16]);
			child.addElement(data[u][17]);
			child.addElement(data[u][18]);
			child.addElement(data[u][19]);
			child.addElement(data[u][20]);
			child.addElement(data[u][21]);
			child.addElement(data[u][22]);
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	 
  
  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMP ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="EMP NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="FROM COMPANY" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="TO COMPANY" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="FROM BRANCH" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="TO BRANCH" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="FROM DEPARTMENT" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="TO DEPARTMENT" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="FROM DESIGNATION" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="TO DESIGNATION" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="FROM OFFICE" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="TO OFFICE" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="FROM LOCATION" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="TO LOCATION" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="FROM CATEGORY" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="TO CATEGORY" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="FROM CYLCE" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="TO CYCLE" sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="FROM REPORTING" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="TO REPORTING" sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="TRANSFER DATE" sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="RELEAVING DATE" sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="REASON" sortable="true"><%=temp.elementAt(23)%></display:column>
					
					
					<display:setProperty name="export.excel.filename" value="Rept_TransferResponse.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_TransferResponse.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_TransferResponse.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='Rept_Staff.jsp'> CLOSE</a></center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
 
