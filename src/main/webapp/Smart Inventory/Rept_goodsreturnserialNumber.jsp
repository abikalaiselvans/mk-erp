<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>


<meta http-equiv="refresh" content="300"/>
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
		 
		 
		String sql ="";
		 
		String reportheader=" GOODS RETURN SERIAL NUMBER" ; 
		Vector mn = new Vector();
	    Vector child= null;
		sql = " SELECT FUN_GET_BRANCH_NAME(b.INT_BRANCHID) branch, 	";
		sql = sql +"  if( b.CHR_TYPE ='I' , 'ITEM' , 'PRODUCT') Ptype, 	"; 
		sql = sql +"  FUN_INV_PRODUCTCODE(b.CHR_TYPE,b.CHR_ITEMID) Pcode, 	";
		sql = sql +"  FUN_INV_PRODUCTDESCRIPTION(b.CHR_TYPE,b.CHR_ITEMID) Pdesc, 	";
		sql = sql +"  IF(a.CHR_CANCEL='N',a.CHR_SALESNO,CONCAT(a.CHR_SALESNO,'***')),  	";
		sql = sql +"  FUN_INV_DIVISION(a.INT_DIVIID) division,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') Sdate,   	";
		sql = sql +"  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) customer,b.CHR_SERIALNO,b.DOU_UNITPRICE,b.CHR_WARRANTY,  	";
		sql = sql +"  FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ME  	";
		sql = sql +" FROM inv_t_directsales a , inv_t_swapsalesserialno b 	";
		sql = sql +" WHERE b.CHR_SERIALNO is NOT NULL AND a.CHR_SALESNO = b.CHR_SALESNO 	 	";
		sql = sql +"  AND a.INT_SALESSTATUS =1  AND b.CHR_GRTFLAG='Y'   	";
		 //out.println(sql);
		String data[][] = CommonFunctions.QueryExecute(sql);
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
				child.addElement("<a target='blank' href='Rept_SerialTrackReportPrint.jsp?serial="+data[u][8]+"'>"+data[u][8]+"</a>");
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				mn.add(child);
					 
			}
		}
			 
 	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 
  

%>


<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="TYPE" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="PRODUCT CODE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="DESCRIPTION" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="SALE NO" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="SALE DATE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CUSTOMER" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="SERIAL" sortable="true"><%=temp.elementAt(9)%></display:column>
                    <display:column title="SERIAL" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="UNIT PRICE" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="WARRANTY" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="ME" sortable="true"><%=temp.elementAt(13)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_GoodsReturnSerialNumber.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_GoodsReturnSerialNumber.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_GoodsReturnSerialNumber.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a></center><br /><br />


 
<%	 		
					
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
	  	
  %>
 </body>
</html>
