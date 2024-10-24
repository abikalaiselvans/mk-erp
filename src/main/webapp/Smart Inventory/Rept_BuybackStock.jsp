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
		 
		String reportheader=" BUY BACK STOCK  " ; 
		Vector mn = new Vector();
	    Vector child= null;
		sql = sql +"  SELECT FUN_GET_BRANCH_NAME(INT_BRANCHID),  " ; 
		sql = sql +"  FUN_INV_DIVISION(INT_DIVIID),  " ; 
		sql = sql +"  IF(CHR_TYPE='I','Item','Product'),  " ; 
		sql = sql +"  FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID),  " ; 
		sql = sql +"  FUN_INV_PRODUCTDESCRIPTION(CHR_TYPE,CHR_ITEMID),  " ; 
		sql = sql +"  CHR_SERIALNO,  " ; 
		sql = sql +"  DATE_FORMAT(DAT_PURCHASE_WARRANTY_START,'%d-%b-%Y'),  " ; 
		sql = sql +"  DATE_FORMAT(DAT_PURCHASE_WARRANTY_END,'%d-%b-%Y')  " ;  
		sql = sql +"  FROM inv_t_vendorgoodsreceived   " ; 
		sql = sql +"  WHERE CHR_BUYBACK_STOCK ='Y' AND  CHR_FLAG  !='Y' AND CHR_SERIALNO IS NOT NULL  " ; 
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
				child.addElement("<a target='blank' href='Rept_SerialTrackReportPrint.jsp?serial="+data[u][5]+"'>Track</a>");
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
                    <display:column title="DIVISION" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="TYPE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="PRODUCT CODE" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DESCRIPTION" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="SERIAL " sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="WARRANTY START " sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="WARRANTY END " sortable="true"><%=temp.elementAt(8)%></display:column>
                    <display:column title="TRACK " sortable="true"><%=temp.elementAt(9)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_BuybackStock.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_BuybackStock.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_BuybackStock.csv"/>
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
