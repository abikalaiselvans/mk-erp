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
 		String reportheader="CONSUMABLE STOCK AND AVERAGE PRICE"; 
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("division");
		String product=request.getParameter("product");
	 
		String sql ="";
		sql = " SELECT  e.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_ITEMID,'PRODUCT',b.CHR_PRODUCTCODE, ";
		sql = sql + " b.CHR_PRODUCTDESC,FUN_INV_DIVISION(a.INT_DIVIID), ";
		sql = sql + " SUM(a.INT_PQTY),SUM(a.INT_SQTY),(SUM(a.INT_PQTY)-SUM(a.INT_SQTY)), ";
		sql = sql + " FUN_GET_AVERAGEPRICE(a.INT_BRANCHID,a.CHR_ITEMID),a.INT_BRANCHID ";
		sql = sql + " FROM inv_t_vendorgoodsreceivedconsumable a ,inv_m_produtlist b,  ";
		sql = sql + " com_m_branch c,   com_m_company e ";
		sql = sql + " WHERE a.CHR_ITEMID=b.CHR_PRODUCTID  ";
		sql = sql + " AND a.INT_BRANCHID =c.INT_BRANCHID  ";
	 
		sql = sql + " AND a.CHR_TYPE ='P' AND a.CHR_CANCEL='N' AND a.CHR_INVOICEBLOCK='N' ";
		sql = sql+ " AND b.CHR_PTYPE='S' ";
		sql = sql + " AND c.INT_COMPANYID = e.INT_COMPANYID ";
		if(!"0".equals(Branch))
				sql = sql+ " AND a.INT_BRANCHID ="+Branch;
		if(!"0".equals(division))
				sql = sql+ " AND a.INT_DIVIID ="+division;
		if(!"0".equals(product))
				sql = sql+ " AND a.CHR_ITEMID ='"+product+"' ";
		sql = sql + " GROUP BY a.INT_BRANCHID,a.CHR_ITEMID  ";
		sql = sql + " ORDER BY b.CHR_PRODUCTCODE, a.INT_BRANCHID ";
		//out.println(sql);
		 
		String data[][] = CommonFunctions.QueryExecute(sql);
		
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
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][2]);
				mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					 
					<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="ITEM / PRODUCT"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="ITEM / PRODUCT CODE" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="NO OF STOCK"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="AVERAGE PRICE"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_Item.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Item.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Item.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>		 
</body>
</html>

