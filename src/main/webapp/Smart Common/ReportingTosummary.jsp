<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>

<%
try
{
%>
<html>
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


  


  
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
 
 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
 
  
		<%
		 
		 String sql="";
		
		sql = " SELECT FIND_A_EMPLOYEE_ID_NAME(a.CHR_REPTO),b.CHR_BRANCHNAME,c.CHR_OFFICENAME,d.CHR_DEPARTNAME,  ";
		sql = sql + " a.CHR_GENDER, COUNT(*) FROM com_m_staff a,com_m_branch b , com_m_office c, com_m_depart d  ";
		sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
		sql = sql + " AND a.INT_OFFICEID =c.INT_OFFICEID  "; 
		sql = sql + " AND a.INT_DEPARTID = d.INT_DEPARTID   ";
		sql = sql + " AND a.CHR_TYPE !='T'  ";
		sql = sql + " AND a.CHR_HOLD!='Y'   ";
		sql = sql + " GROUP BY a.CHR_REPTO,a.INT_BRANCHID,a.INT_OFFICEID,a.INT_DEPARTID,a.CHR_GENDER  ";
		sql = sql + " ORDER BY a.CHR_REPTO, b.CHR_BRANCHNAME,c.CHR_OFFICENAME,d.CHR_DEPARTNAME,a.CHR_GENDER  ";
		String data[][]= CommonFunctions.QueryExecute(sql);
		 
			 
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
				child.addElement(data[u][5]);
				mn.add(child);
		 } 
	   
		 
		request.setAttribute("table",mn);
 		
		
	%>
	

<display:table   id="_table" name="table"    export="true" pagesize="25">

        <display:caption><%="REPORTING TO SUMMARY " %></display:caption>
        <display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
         
        <display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
        <display:column title="ID /NAME" sortable="true"><%=temp.elementAt(1)%></display:column>
        <display:column title="BRANCH " sortable="true"><%=temp.elementAt(2)%></display:column>
        <display:column title="OFFICE" sortable="true"><%=temp.elementAt(3)%></display:column>
        <display:column title="DEPARTMENT " sortable="true"><%=temp.elementAt(4)%></display:column>
        <display:column title="GENDER " sortable="true"><%=temp.elementAt(5)%></display:column>
        <display:column title="COUNT" sortable="true"><%=temp.elementAt(6)%></display:column>
        <display:setProperty name="export.csv.filename" value="ReportingTo.csv"/>
        <display:setProperty name="export.excel.filename" value="ReportingTo.xls"/>
        <display:setProperty name="export.xml.filename" value="ReportingTo.xml"/>
        <display:setProperty name="export.pdf.filename" value="ReportingTo.pdf"/>
        <display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
	
      
<br />
 									<center>	<a href=' '> CLOSE</a></center>


 
</body>
<%
}
catch(Exception e)
{
}
%>
