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
 		String reportheader="CUSTOMER QUOTATION"; 
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String customer = request.getParameter("customer");
		String ref = request.getParameter("ref");
		String status = request.getParameter("status");
		String cancel = request.getParameter("cancel");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String itemname="";
		String sql="";
		
		sql = sql + " SELECT FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), ";
		sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID ),  ";
		sql = sql + " DATE_FORMAT(a.DAT_QUOTATIONDATE,'%d-%b-%Y'), ";
		sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), a.DOU_TOTALAMOUNT, ";
		sql = sql + " a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO, ";
		sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.CHR_DES, ";
		sql = sql + " IF(a.CHR_STATUS='Y','Executed','Pending') ,IF(a.CHR_CANCEL='Y','Cancelled','Live') ";
		sql = sql + " FROM  inv_t_customerquotation  a ,inv_m_customerinfo b ";
		sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
		if(!"0".equals(Branch))
			sql = sql + " AND a.INT_BRANCHID ="+Branch;
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID ="+division;
		if(!"0".equals(customer))
			sql = sql + " AND b.INT_CUSTOMERID ="+customer;
		if(!"0".equals(ref))
			sql = sql + " AND a.CHR_REF ="+ref;
		if(!"0".equals(status))
			sql = sql + " AND a.CHR_STATUS ='"+status+"'";
		if(!"0".equals(cancel))
			sql = sql + " AND a.CHR_CANCEL ='"+cancel+"'";
		
		sql = sql + " AND a.DAT_QUOTATIONDATE <='"+DateUtil.FormateDateSQL(todate)+"' ";
		sql = sql + " AND a.DAT_QUOTATIONDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' " ;
		sql = sql + " ORDER BY a.CHR_QUOTATIONNO ";
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
				child.addElement(data[u][7]);		
				child.addElement(data[u][8]);		
				child.addElement(data[u][9]);		
				child.addElement(data[u][10]);		
				child.addElement(data[u][11]);	
				child.addElement(data[u][12]);		
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
					<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="QUOTATION NUMBER"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="QUOTATION DATE"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="REQUEST DATE"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="TOTAL AMOUNT"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CONTACT"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="CONTACT NUMBER"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="M.E"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="DESRIPTION"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="STATUS"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="CANCEL"   sortable="true"><%=temp.elementAt(13)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_Quotation.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Quotation.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Quotation.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_Quotation.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

