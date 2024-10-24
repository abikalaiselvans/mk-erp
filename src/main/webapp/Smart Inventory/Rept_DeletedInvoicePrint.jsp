<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.io.*,java.util.*"%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />



<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <body >
 
	<% 
	try
	{
	 String type= ""+request.getParameter("type");
	 String saleDate= request.getParameter("saleDate");
	 String saleDate2= request.getParameter("saleDate2");
	 saleDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
	 saleDate2=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate2);
	 String daterange= request.getParameter("daterange");
	 String Branch= ""+request.getParameter("Branch");
	 String branchid = ""+session.getAttribute("BRANCHID");
	 if(!"null".equals(Branch))
	 	branchid=Branch;
		
	 String tablename="";
	 String sqldaterange="";
	 String sql="";
	 String reportheader=" DELETED INVOICE DETAILS  "; 
	 Vector mn = new Vector();
	 Vector child= null; 			 
				
				
	 if("Y".equals(daterange))
			sqldaterange=" AND  DAT_DELETEDATE >='"+saleDate+"' AND DAT_DELETEDATE<='"+saleDate2+"' ";
	
	 if("1".equals(type))
	 {
	  		sql="SELECT CHR_PURCHASEORDERNO,CHR_DES,DATE_FORMAT(DAT_DELETEDATE,'%d-%b-%Y') FROM inv_t_invoicedelete WHERE INT_BRANCHID="+branchid;
			sql = sql+sqldaterange;
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					
					child = new Vector();
					child.addElement((u+1));
					child.addElement("PURCHASE ORDER");
					child.addElement(data[u][0]);
					child.addElement(data[u][1]);
					child.addElement(data[u][2]);
					mn.add(child); 
					 
				}
			}
			 
	 }		
	 else 
	 {
	 		sql="SELECT CHR_SALESNO,CHR_DES,DATE_FORMAT(DAT_DELETEDATE,'%d-%b-%Y'),CHR_INVOICEMODE FROM inv_t_directsalesdelete WHERE INT_BRANCHID="+branchid;
			sql = sql+sqldaterange;
			if("2".equals(type))
				sql =sql+" AND CHR_INVOICEMODE = 'DIRECT SALE'";
			else if("3".equals(type))	
				sql =sql+" AND CHR_INVOICEMODE = 'DIRECT BILLING'";
			else if("4".equals(type))	
				sql =sql+" AND CHR_INVOICEMODE = 'SERVICE BILLING'";
					
			 
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					
					child = new Vector();
					child.addElement((u+1));
					
					if("2".equals(type))
						child.addElement("DIRECT SALE");
					else if("3".equals(type))	
						child.addElement("DIRECT BILLING");
					else if("4".equals(type))	
						child.addElement("SERVICE BILLING");
					child.addElement(data[u][0]);
					child.addElement(data[u][1]);
					child.addElement(data[u][2]);
					mn.add(child); 
					
					
					 
				}
			}
			 
			 
	 }
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVOICE TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="INVOICE NUMBER" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DESCRIPTION" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="DATE" sortable="true"><%=temp.elementAt(4)%></display:column>
					  
					<display:setProperty name="export.excel.filename" value="Rept_DeletedInvoice.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DeletedInvoice.pdf"/>
					<display:setProperty name="export.cvs.filename" value="Rept_DeletedInvoice.cvs"/>
					<display:setProperty name="export.pdf"  value="true" />
					
					
					 
					 
</display:table>     
<br />	<center>	<a href='Rept_DeletedInvoice.jsp'> CLOSE</a></center><br /><br />


 
<%		 			
	 
	 }
	 catch(Exception e)
	 {
	 }	
	  %>
	  
</body>
</html>
