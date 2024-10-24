<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{
%>  
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<link href="../JavaScript/css/maven-base.css" rel="stylesheet" type="text/css">
<html>
<head>

<title> :: COMMON ::</title>


 
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

  
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 
<%
 
	 
	String cmpy=request.getParameter("company");
	String branch=request.getParameter("branch");
	String Office = request.getParameter("Office");
	String dept = request.getParameter("dept");
	String sorting = request.getParameter("sorting");
	String ss = request.getParameter("ss");
	String sql = "";
	 
	sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_STAFFFNAME ,  FUN_GET_BRANCH_WITH_COMPANY_NAME(a.INT_BRANCHID),   ";
	sql = sql +" a.CHR_GENDER , DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), a.CHR_MOBILE,   ";
	sql = sql +" b.CHR_BANKGROUPNAME,CONCAT('A/c : ',a.CHR_ACCNO)  , UPPER(a.CHR_IFSC)     "; 
 	sql = sql +" FROM com_m_staff a, com_m_bankgroup b WHERE a.CHR_TYPE!='T'   ";
	sql = sql +" AND a.CHR_BANK =b.INT_BANKGROUPID  ";
	sql = sql +" AND a.CHR_HOLD !='Y'   ";

	if(!"0".equals(cmpy))
	 	sql = sql +" AND  a.INT_COMPANYID= "+cmpy;
	if(!"0".equals(branch))
	 	sql = sql +" AND  a.INT_BRANCHID= "+branch;
	
	if(!"0".equals(Office))
	 	sql = sql +" AND  a.INT_OFFICEID= "+Office;
		 
	 if(!"0".equals(dept))
		 sql = sql +" AND  a.INT_DEPARTID= "+dept;
	sql = sql+"  ORDER BY "+ sorting +" "+ss;	 
    //out.println(sql);
	
	
	
	 
	  
	 String data[][] =CommonFunctions.QueryExecute(sql);
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
			mn.add(child);
     } 
 
	
	request.setAttribute("table",mn);
	 
	%>
	
	 			
				
				<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%="STAFF BANK INFORMATION"%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Empid" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Father Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Comapany" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Gender" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Date of Joining" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Mobile" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Bank" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Account Number" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="IFSC Code" sortable="true"><%=temp.elementAt(10)%></display:column>
					 
					<display:setProperty name="export.csv.filename" value="Rept_StaffBankInformations.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_StaffBankInformations.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_StaffBankInformations.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_StaffBankInformations.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
				</display:table> 
		
		
	 
 

<br />
									<center>	<a href='Rept_StaffBankInformations.jsp'> CLOSE</a>
									</center>
 <br />

 

<br />
 
 
 <%
 }
 catch(Exception e)
 {
 	System.out.println(e.getMessage());
	out.println(e.getMessage());
 }
 %>