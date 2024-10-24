<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
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
<body >
 
 
<div>
<%
	try
	{
		 
		String reportheader="CHEQUE BOUNCE "; 
		String sql="";
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("division");
		String pname="Product";
		sql = " SELECT a.CHR_SALESORDERNO,g.CHR_BRANCHNAME,f.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),c.CHR_PAYMENTNAME,FIND_A_BANKNAME_NAME(d.INT_BANKID),  ";
		sql = sql+ " a.CHR_PAYNO,DATE_FORMAT(a.DAT_PAYMENTDATE,'%d-%b-%Y'),a.DOU_PAIDAMOUNT,a.CHR_PAYEMENTCOLLECTEDBY, ";
		sql = sql+ " DATE_FORMAT(a.CHR_CHKDATE,'%d-%b-%Y'), ";
		sql = sql+ " a.CHR_DESCRIPTION ";
		sql = sql+ " FROM inv_t_customersalespaymentchequereturn a ,inv_m_customerinfo b, ";
		sql = sql+ " inv_m_paymentterms c,com_m_bank d, inv_t_directsales e,inv_m_division f,com_m_branch g ";
		sql = sql+ " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID ";
		sql = sql+ " AND a.INT_PAYMENTTERMID = c.INT_PAYMENTTERMID ";
		sql = sql+ " AND a.CHR_BANKNAME=d.INT_BANKID ";
		sql = sql+ " AND a.CHR_SALESORDERNO=e.CHR_SALESNO ";
		sql = sql+ " AND e.INT_DIVIID=f.INT_DIVIID AND e.INT_BRANCHID=g.INT_BRANCHID";
		if(!"0".equals(division))
				sql = sql+ " AND e.INT_DIVIID="+division;
		
		if(!"0".equals(Branch))
				sql = sql+ " AND e.INT_BRANCHID="+Branch;
		sql = sql+ " ORDER BY  a.CHR_SALESORDERNO ";
		//out.println(sql);
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
				mn.add(child);
		} 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>
  
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVOICE NUMBER" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="CUSTOMER NAME" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PAYMENT MODE" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="BANK" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="CHEQUE NUMBER" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="PAYMENT DATE" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PAID AMOUNT" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="COLLECTED BY" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="CHEQUE DATE" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="REASON" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_chequebounce.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_chequebounce.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_chequebounce.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center><br /><br />


 
<%		 
		 
 	
		 
		 
 
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>
</body>
</html>
