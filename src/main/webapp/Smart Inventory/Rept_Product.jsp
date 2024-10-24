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
 		String reportheader="PRODUCT "; 
		String sql =" SELECT a.CHR_NAME,b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,IF(b.INT_ACTIVE =1,'Active','Inactive') ,  ";
 		sql = sql +" IF(b.CHR_PTYPE ='S' ,'Consumable Product', IF(b.CHR_PTYPE ='F','Full Product','Combinational Product ') ) , b.CHR_HSNCODE, LENGTH(b.CHR_HSNCODE) ";
  		sql = sql +" FROM inv_m_productgroup  a , inv_m_produtlist b    ";
  		sql = sql +" WHERE a.INT_PRODUCTGROUPID =b.INT_PRODUCTGROUPID   ";
  		sql = sql +" ORDER BY b.CHR_PRODUCTCODE  ";
 		
		
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
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="PRODUCT GROUP"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="PRODUCT NAME"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="ACTIVE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="TYPE"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="HSNCODE"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="HSNCODE - LENGTH"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_Product.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Product.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Product.csv"/>
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

