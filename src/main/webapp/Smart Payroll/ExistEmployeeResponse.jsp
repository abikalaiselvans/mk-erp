<%
try
{
%>

<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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
<title> :: PAYROLL ::</title>


 
  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

<br>
<br>
<%
	String addsql="";
	String repName="";
	String repHeader="";
	String bankcondition="";
	String Office= request.getParameter("Office");
	String Dept= request.getParameter("dept");
	String company = request.getParameter("company");
	String branch = request.getParameter("branch");
	String Resigned = request.getParameter("Resigned");
	
		
	 String sql = " Select CHR_EMPID,CHR_STAFFNAME,DATE_FORMAT(DT_DOJCOLLEGE,'%d-%b-%Y'),  ";
	 sql = sql+" CHR_MOBILE, CHR_EMAILID ,if(CHR_PF='C','PF COMMON',if(CHR_PF='Y','PF YES','PF NO')),CHR_PFNO,if(CHR_ESI='C','ESI COMMON',if(CHR_ESI='Y','ESI YES','ESI NO')),CHR_ESINO From com_m_staff   ";
	 sql = sql+" Where CHR_EMPID IS NOT NULL " ;
	  if(!"Y".equals(Resigned))
		sql = sql+"  AND CHR_TYPE !='T' " ;
		
	 sql = sql +" AND INT_COMPANYID=  "+company;
	 if(!"0".equals(branch))
		sql = sql +"  AND  INT_BRANCHID=  "+branch;
	 if(!"0".equals(Office))
		sql = sql+"  AND INT_OFFICEID="+Office;
	 if(!"0".equals(Dept))
		sql = sql+"  AND INT_DEPARTID= "+Dept;
	 sql = sql + " ORDER BY CHR_STAFFNAME";
	// out.println(sql);
	repName =" EXISTING EMPLOYEE LIST";
	 
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
			mn.add(child);
     } 
  request.setAttribute("table",mn);
  out.println("<br><center><h3> "+repName+" </h3></center><br>");  
%>
  <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Date of Joinning" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Email " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="PF Type" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="PF Number" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="ESI TYPE " sortable="true"><%=temp.elementAt(8)%></display:column>
				    <display:column title="ESI Number " sortable="true"><%=temp.elementAt(9)%></display:column>
					 
					
					<display:setProperty name="export.csv.filename" value="ExistEmployee.csv"/>
					<display:setProperty name="export.excel.filename" value="ExistEmployee.xls"/>
					<display:setProperty name="export.xml.filename" value="ExistEmployee.xml"/>
					<display:setProperty name="export.pdf.filename" value="ExistEmployee.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='ExistEmployee.jsp'> CLOSE</a></center>
 
	 		

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>