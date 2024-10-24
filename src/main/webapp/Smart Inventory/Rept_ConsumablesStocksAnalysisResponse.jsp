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
		
		sql = " SELECT  e.CHR_COMPANYNAME,c.CHR_BRANCHNAME,'PRODUCT',b.CHR_PRODUCTCODE,  ";
		sql = sql + " b.CHR_PRODUCTDESC,d.CHR_DIVICODE,   ";
		sql = sql + " a.CHR_PURCHASEORDERNO,a.INT_PQTY, a.DOU_UNITPRICE,a.CHR_SALESNO,a.INT_SQTY,a.DOU_SALESUNITPRICE,a.DOU_AVGPRICE ,a.INT_STOCK,if(a.CHR_CANCEL='Y','CANCELLED','' )";
		sql = sql + " FROM inv_t_vendorgoodsreceivedconsumable a ,inv_m_produtlist b,    ";
		sql = sql + " com_m_branch c, inv_m_division d, com_m_company e   ";
		sql = sql + " WHERE a.CHR_ITEMID=b.CHR_PRODUCTID    ";
		sql = sql + " AND a.INT_BRANCHID =c.INT_BRANCHID    ";
		sql = sql + " AND a.INT_DIVIID =d.INT_DIVIID    AND a.CHR_INVOICEBLOCK='N' ";
		sql = sql + " AND a.CHR_TYPE ='P'   ";
		sql = sql + " AND b.CHR_PTYPE='S'   ";
		if(!"0".equals(Branch))
				sql = sql+ " AND a.INT_BRANCHID ="+Branch;
		if(!"0".equals(division))
				sql = sql+ " AND a.INT_DIVIID ="+division;
		if(!"0".equals(product))
				sql = sql+ " AND a.CHR_ITEMID ='"+product+"' ";
				
		
		sql = sql + " AND c.INT_COMPANYID = e.INT_COMPANYID   ";
		sql = sql + " ORDER BY a.INT_ROWID  "; 
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
					<display:column title="PURCHASE NUMBER"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="IN QTY"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PRICE "   sortable="true"><%=temp.elementAt(9)%></display:column>					
					<display:column title="SALES NUMBER"   sortable="true"><%=temp.elementAt(10)%></display:column>					
					<display:column title="OUT QTY" sortable="true"><%=temp.elementAt(11)%></display:column>					
					<display:column title="SALE PRICE" sortable="true"><%=temp.elementAt(12)%></display:column>					
					<display:column title="AVG PRICE" sortable="true"><%=temp.elementAt(13)%></display:column>					
					<display:column title="STOCK" sortable="true"><%=temp.elementAt(14)%></display:column>					
                    <display:column title="CANCEL" sortable="true"><%=temp.elementAt(15)%></display:column>					
					
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

