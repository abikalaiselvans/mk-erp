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
 		String reportheader="CHANGE WARRANTY"; 
		String Branch = request.getParameter("Branch");
		String itype = request.getParameter("itype");
		String item = request.getParameter("item");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String itemname="";
		String sql="";
		if("1".equals(itype))
		{
			sql = "";
			sql = sql + " SELECT g.CHR_COMPANYNAME,h.CHR_BRANCHNAME,a.CHR_TYPE,a.CHR_ITEMID,f.CHR_GROUPNAME,e.CHR_ITEMNAME,e.CHR_DES,a.CHR_SERIALNO,a.CHR_SALESNO, " ;
			sql = sql + " a.DOU_UNITPRICE,a.CHR_QUALITY,a.CHR_PURCHASE_WARRANTY ,a.CHR_WARRANTY, " ;
			sql = sql + " b.DAT_SALESDATE,b.DOU_TOTALAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),d.CHR_DIVICODE " ;
			sql = sql + " FROM inv_t_vendorgoodsreceived a,inv_t_directsales b,inv_m_customerinfo c,inv_m_division d,inv_m_item e,inv_m_itemgroup f,com_m_company g,com_m_branch h " ;
			sql = sql + " WHERE a.CHR_SALESNO =b.CHR_SALESNO AND b.INT_CUSTOMERID =c.INT_CUSTOMERID AND b.INT_DIVIID = d.INT_DIVIID AND a.CHR_TYPE='I' " ;
			sql = sql + " AND a.CHR_ITEMID=e.CHR_ITEMID AND e.INT_ITEMGROUPID= f.INT_ITEMGROUPID  AND g.INT_COMPANYID = h.INT_COMPANYID AND a.INT_BRANCHID = h.INT_BRANCHID " ;
			sql = sql + " AND b.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"' ";
			sql = sql + " AND b.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' " ;
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID ="+Branch;
			if(!"0".equals(item))
				sql = sql + " AND  a.CHR_ITEMID ="+item;
			sql = sql + " AND a.CHR_WARRANTY != a.CHR_PURCHASE_WARRANTY ORDER BY a.DAT_RECIVEDDATE,a.CHR_TYPE,a.CHR_ITEMID" ;
			//out.println(sql);
			itemname=" ITEM ";
		}
		else
		{
			sql = "";
			sql = sql + " SELECT g.CHR_COMPANYNAME,h.CHR_BRANCHNAME,a.CHR_TYPE,a.CHR_ITEMID,f.CHR_NAME,e.CHR_PRODUCTCODE,e.CHR_PRODUCTDESC,a.CHR_SERIALNO, " ;
			sql = sql + " a.CHR_SALESNO,a.DOU_UNITPRICE,a.CHR_QUALITY,a.CHR_PURCHASE_WARRANTY,a.CHR_WARRANTY , " ;
			sql = sql + "b.DAT_SALESDATE,b.DOU_TOTALAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),d.CHR_DIVICODE FROM inv_t_vendorgoodsreceived a , " ;
			sql = sql + "inv_t_directsales b  , inv_m_customerinfo c,inv_m_division d,inv_m_produtlist e,inv_m_productgroup f,com_m_company g ,com_m_branch h  " ;
			sql = sql + "WHERE a.CHR_SALESNO =b.CHR_SALESNO " ;
			sql = sql + " AND b.INT_CUSTOMERID =c.INT_CUSTOMERID  AND b.INT_DIVIID = d.INT_DIVIID AND a.CHR_TYPE='p' 	AND a.CHR_ITEMID=e.CHR_PRODUCTID " ;
			sql = sql + "AND e.INT_PRODUCTGROUPID= f.INT_PRODUCTGROUPID AND g.INT_COMPANYID = h.INT_COMPANYID AND a.INT_BRANCHID = h.INT_BRANCHID  " ;
			sql = sql + " AND b.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
			sql = sql + " AND b.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"'  " ;
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID ="+Branch;
			if(!"0".equals(item))
				sql = sql + " AND  a.CHR_ITEMID ="+item;
			sql = sql + " AND a.CHR_WARRANTY != a.CHR_PURCHASE_WARRANTY ORDER BY a.DAT_RECIVEDDATE,a.CHR_TYPE,a.CHR_ITEMID " ;
			itemname=" PRODUCT "; 
		}
		//out.println(sql);
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);		
				child.addElement(itemname);	
				child.addElement(data[u][4]);		
				child.addElement(data[u][5]);		
				child.addElement(data[u][6]);		
				child.addElement(data[u][7]);		
				child.addElement(data[u][8]);		
				child.addElement(data[u][13]);		
				child.addElement(data[u][14]);		
				child.addElement(data[u][15]);		
				child.addElement(data[u][16]);		
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
					<display:column title="Branch"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Item/Product"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Item/Product Group"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Item/Product Name"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Item/Description"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Serial No"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Sales No"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Sales Date"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Total Amount"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Customer Name"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Division"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Purchase Warranty"   sortable="true"><%=temp.elementAt(13)%></display:column>
					 <display:column title="Sales Warranty"   sortable="true"><%=temp.elementAt(14)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_WarrantyChangeinSaleWise.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_WarrantyChangeinSaleWise.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_WarrantyChangeinSaleWise.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_WarrantyChangeinSaleWise.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>

