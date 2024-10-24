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
 		String reportheader="CANCELLED INVOICE"; 
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String vendor = request.getParameter("vendor");
		String ref = request.getParameter("ref");
		String delivery = request.getParameter("delivery");
		String saleDate = request.getParameter("saleDate");
		String saleDate2  = request.getParameter("saleDate2");
		saleDate = DateUtil.FormateDateSQL(saleDate);
		saleDate2 = DateUtil.FormateDateSQL(saleDate2);
		 
		String sql ="";
		Vector mn = new Vector();
		Vector child= null;
		
		sql = " SELECT b.CHR_BRANCHNAME,c.CHR_VENDORNAME,a.CHR_PURCHASEORDERNO,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') ,  ";
		sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  ";
		sql = sql + " a.DOU_TOTALAMOUNT,if(a.CHR_CANCEL='Y','CANCELLED',''),a.CHR_CANCELDESC  ";
		sql = sql + " FROM  inv_t_directpurchase a ,   com_m_branch b, inv_m_vendorsinformation c  ";
		sql = sql + " WHERE    a.INT_BRANCHID =b.INT_BRANCHID  ";
		sql = sql + " AND a.INT_VENDORID =c.INT_VENDORID  ";
		sql = sql + " AND a.CHR_CANCEL ='Y'  ";
		sql = sql + " AND a.DAT_ORDERDATE >='"+saleDate+"' ";
		sql = sql + " AND a.DAT_ORDERDATE <='"+saleDate2+"' ";
		if(!"0".equals(Branch)) 
			sql = sql + " AND a.INT_BRANCHID="+Branch;
		if(!"0".equals(division)) 
			sql = sql + " AND  a.INT_DIVIID="+division;
		if(!"0".equals(vendor)) 
			sql = sql + " AND  a.INT_VENDORID="+vendor;
		if(!"0".equals(ref)) 
			sql = sql + " AND  a.CHR_REF='"+ref+"' ";
		sql = sql + " ORDER BY a.DAT_ORDERDATE  ";
		String data[][] =  CommonFunctions.QueryExecute(sql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement("VENDOR PURCHASE");
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				mn.add(child); 
			}
		} 
	 
		
		 
		
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
                    <display:column title="BRANCH"   sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="INVOICE TYPE"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="VENDOR NAME"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="PO"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DATE"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="ME"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="AMOUNT"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CANCEL"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(9)%></display:column>
					
                    <display:setProperty name="export.excel.filename" value="Rept_CancelpurchaseInvoice.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_CancelpurchaseInvoice.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_CancelpurchaseInvoice.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

