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
 <title>:: INVENTORY ::</title>

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
 		String reportheader="CUSTOMER TRANSACTION LEDGER"; 
		String customer = request.getParameter("customer");
		String status = request.getParameter("status");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		
		String sql="";
		sql = sql + " (  ";
		sql = sql + " SELECT  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) CUSTOMER,CONCAT('Sales'), ";
		sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') BILLINGDATE,a.CHR_SALESNO INVOICE,  ";
		sql = sql + " a.DOU_TOTALAMOUNT DT ,CONCAT('0') CT, ";
		sql = sql + " IF( (a.DOU_TOTALAMOUNT-FUN_INV_GET_CUSTOMER_PAIDAMOUNT(a.CHR_SALESNO))=0 ,'Paid', ";
		sql = sql + " 	IF((a.DOU_TOTALAMOUNT-FUN_INV_GET_CUSTOMER_PAIDAMOUNT(a.CHR_SALESNO)) = a.DOU_TOTALAMOUNT ,'Pending' ,'Partial Paid')  ";
		sql = sql + " 	) PaymentStatus ";
		sql = sql + " FROM inv_t_directsales a ";
		sql = sql + " WHERE a.CHR_CANCEL ='N' AND a.INT_SALESSTATUS=1 ";
		sql = sql + " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' ";
		sql = sql + " AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"' ";
		if(!"0".equals(customer))
			sql = sql + " AND a.INT_CUSTOMERID ="+customer;
		sql = sql + " ORDER BY a.DAT_SALESDATE ";
		sql = sql + " ) ";
		sql = sql + " UNION ";
		sql = sql + " ( ";
		sql = sql + " SELECT  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) CUSTOMER,CONCAT('Receipts'), ";
		sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') BILLINGDATE,a.CHR_SALESNO INVOICE,  ";
		sql = sql + " CONCAT('0') DT,FUN_INV_GET_CUSTOMER_PAIDAMOUNT(a.CHR_SALESNO) CT, CONCAT('') ";
		sql = sql + " FROM inv_t_directsales a ";
		sql = sql + " WHERE a.CHR_CANCEL ='N' AND a.INT_SALESSTATUS=1 ";
		sql = sql + " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' ";
		sql = sql + " AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"' ";
		sql = sql + " AND FUN_INV_GET_CUSTOMER_PAIDAMOUNT(a.CHR_SALESNO)>0 ";
		if(!"0".equals(customer))
			sql = sql + " AND a.INT_CUSTOMERID ="+customer;
		sql = sql + " ORDER BY a.DAT_SALESDATE ";
		sql = sql + " ) ";
		 String data[][] =  CommonFunctions.QueryExecute(sql);
		
		Vector mn = new Vector();
	 	Vector child= null;
		
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
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
				mn.add(child); 
			}
		} 
		//Sales Warranty
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Ref"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DATE"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="INVOICE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DT"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="CT"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Status"   sortable="true"><%=temp.elementAt(7)%></display:column>
					 
					 
					<display:setProperty name="export.excel.filename" value="Rept_CTLedger.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_CTLedger.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_CTLedger.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_CTLedger.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

