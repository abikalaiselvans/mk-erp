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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body >
<%


try
{		 
	  
	String fdate = request.getParameter("saleDate");
	String tdate = request.getParameter("saleDate2");
	String date1 = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fdate); 
	String date2 = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(tdate);
	String sql = "";
	String reportheader="SALES WARRANTY EXPIRY DETAILS";
	Vector mn = new Vector();
	Vector child= null; 
	sql = "SELECT c.CHR_GROUPNAME,d.CHR_ITEMNAME,d.CHR_DES,a.CHR_SALESNO, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_SERIALNO,b.CHR_WARRANTY,datediff(now(),a.DAT_SALESDATE)/365, ";
	sql = sql + " DATE_FORMAT(DATE_ADD(DAT_SALESDATE, INTERVAL (b.CHR_WARRANTY*365) DAY),'%d-%m-%Y'), ";
	sql = sql + " FIND_A_CUSTOMER_NAME(e.INT_CUSTOMERID ),e.CHR_MOBILE ";
	sql = sql + " FROM inv_t_directsales a,inv_t_swapsalesserialno b,inv_m_itemgroup c,inv_m_item d,inv_m_customerinfo e ";
	sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESNO ";
	sql = sql + " AND  DATE_ADD( a.DAT_SALESDATE, INTERVAL (b.CHR_WARRANTY*365) DAY )  >=  (SELECT DATE_SUB( '"+date1+"', INTERVAL 10 DAY )   ) ";
	sql = sql + " AND  DATE_ADD( a.DAT_SALESDATE, INTERVAL (b.CHR_WARRANTY*365) DAY )  <=  (SELECT DATE_ADD( '"+date2+"' , INTERVAL 10 DAY )   ) ";
	sql = sql + " AND b.CHR_TYPE='I'  ";
	sql = sql + " AND b.CHR_ITEMID = d.CHR_ITEMID   ";
	sql = sql + " AND c.INT_ITEMGROUPID = d.INT_ITEMGROUPID ";
	sql = sql + " AND a.INT_CUSTOMERID=e.INT_CUSTOMERID  ";
	sql = sql + " ORDER BY   a.DAT_SALESDATE ";
	 
	 String WData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(WData.length>0)
	{
	 	
		
		for(int u=0;u<WData.length;u++)
		{
			child = new Vector();
			child.addElement((u+1));
			child.addElement("ITEM" );
			child.addElement(WData[u][0]); 
			child.addElement(WData[u][1]); 
			child.addElement(WData[u][2]); 
			child.addElement(WData[u][3]); 
			child.addElement(WData[u][4]); 
			child.addElement(WData[u][5]); 
			child.addElement(WData[u][6]); 
			child.addElement(WData[u][7]); 
			child.addElement(WData[u][8]); 
			child.addElement(WData[u][9]); 
			child.addElement(WData[u][10]); 
			mn.add(child);
		}
	}
	out.println("<tr class='MRow1'><td class='boldEleven' colspan='12' align='center' ><b> PRODUCT DETAILS</b></td></tr>");
	
	
	
	
	
	sql =   " SELECT c.CHR_NAME,d.CHR_PRODUCTCODE,d.CHR_PRODUCTDESC,a.CHR_SALESNO, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_SERIALNO,b.CHR_WARRANTY, ";
	sql = sql + " datediff(now(),a.DAT_SALESDATE)/365,  ";
	sql = sql + " DATE_FORMAT(DATE_ADD(DAT_SALESDATE, INTERVAL (b.CHR_WARRANTY*365) DAY),'%d-%m-%Y'),  ";
	sql = sql + " FIND_A_CUSTOMER_NAME(e.INT_CUSTOMERID ),e.CHR_MOBILE   ";
	sql = sql + " FROM inv_t_directsales a,inv_t_swapsalesserialno b,inv_m_productgroup c,inv_m_produtlist d,inv_m_customerinfo e   ";
	sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESNO   ";
	sql = sql + " AND  DATE_ADD( a.DAT_SALESDATE, INTERVAL (b.CHR_WARRANTY*365) DAY )  >=  (SELECT DATE_SUB('"+date1+"', INTERVAL 10 DAY )   )   ";
	sql = sql + " AND  DATE_ADD( a.DAT_SALESDATE, INTERVAL (b.CHR_WARRANTY*365) DAY )  <=  (SELECT DATE_ADD( '"+date2+"' , INTERVAL 10 DAY )   )   ";
	sql = sql + " AND b.CHR_TYPE='P'   ";
	sql = sql + " AND b.CHR_ITEMID = d.CHR_PRODUCTID    "; 
	sql = sql + " AND c.INT_PRODUCTGROUPID = d.INT_PRODUCTGROUPID   ";
	sql = sql + " AND a.INT_CUSTOMERID=e.INT_CUSTOMERID   "; 
	sql = sql + " ORDER BY   a.DAT_SALESDATE ";
	
	String WData1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(WData1.length>0)
	{
	 	
		for(int u=0;u<WData1.length;u++)
		{
			child = new Vector();
			child.addElement((u+1));
			child.addElement("PRODUCT" );
			child.addElement(WData1[u][0]); 
			child.addElement(WData1[u][1]); 
			child.addElement(WData1[u][2]); 
			child.addElement(WData1[u][3]); 
			child.addElement(WData1[u][4]); 
			child.addElement(WData1[u][5]); 
			child.addElement(WData1[u][6]); 
			child.addElement(WData1[u][7]); 
			child.addElement(WData1[u][8]); 
			child.addElement(WData1[u][9]); 
			child.addElement(WData1[u][10]); 
			mn.add(child);
			 
		}
	} 
	 
request.setAttribute("table",mn);	  
 
 
 %>
 
 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="TYPE"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="GROUP" sortable="true" ><%=temp.elementAt(2)%></display:column>
 					<display:column title="ITEM/PRODUCT" sortable="true" ><%=temp.elementAt(3)%></display:column>
 					<display:column title="DESC" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title=">SALES NO" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="SALE DATE" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="SERIAL NO" sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="SALE WARRANTY"  style="text-align:right" sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="LIFE DIFFERENCE"  style="text-align:right" sortable="true" ><%=temp.elementAt(9)%></display:column>
					<display:column title="EXPIRY DATE" sortable="true" ><%=temp.elementAt(10)%></display:column>
					<display:column title="CUSTOMER" style="text-align:right" sortable="true" ><%=temp.elementAt(11)%></display:column>
					<display:column title="CUSTOMER MOBILE" style="text-align:right" sortable="true" ><%=temp.elementAt(12)%></display:column>
					  
					<display:setProperty name="export.excel.filename" value="WarrantyExp.xls"/>
					<display:setProperty name="export.pdf.filename" value="WarrantyExp.pdf"/>
					<display:setProperty name="export.csv.filename" value="WarrantyExp.csv"/>
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
