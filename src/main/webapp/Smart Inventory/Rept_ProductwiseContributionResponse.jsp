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
		 
		String branchid = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String item = request.getParameter("item");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		fromdate = DateUtil.FormateDateSQL(fromdate);
		todate =  DateUtil.FormateDateSQL(todate);
		String sql ="";
		 
		String reportheader="PRODUCT WISE CONTRIBUTION  FROM  "+fromdate+"- TO "+todate ; 
		Vector mn = new Vector();
	    Vector child= null;

		sql = " SELECT  ";
		sql = sql +" if( b.CHR_TYPE ='I' , 'ITEM' , 'PRODUCT') Ptype, ";
		sql = sql +" if( b.CHR_TYPE ='I' ,  ";
		sql = sql +" (SELECT aa.CHR_ITEMNAME FROM inv_m_item aa WHERE aa.CHR_ITEMID =b.CHR_ITEMID),  ";
		sql = sql +" (SELECT sa.CHR_PRODUCTCODE FROM inv_m_produtlist sa WHERE sa.CHR_PRODUCTID =b.CHR_ITEMID) ) ";
		sql = sql +" productcode, ";
		sql = sql +" if( b.CHR_TYPE ='I' ,  ";
		sql = sql +" (SELECT aa1.CHR_DES FROM inv_m_item aa1 WHERE aa1.CHR_ITEMID =b.CHR_ITEMID),  ";
		sql = sql +" (SELECT sa2.CHR_PRODUCTDESC FROM inv_m_produtlist sa2 WHERE sa2.CHR_PRODUCTID =b.CHR_ITEMID) ) ";
		sql = sql +" productdescription, ";
		sql = sql +" b.CHR_SERIALNO, ";
		sql = sql +" FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch, ";
		sql = sql +" FUN_INV_DIVISION(a.INT_DIVIID) division, ";
		sql = sql +" a.CHR_SALESNO invoice, ";
		sql = sql +" FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) customer,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ME ,";
		sql = sql +" DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') Sdate,  ";
		sql = sql +" DATE_FORMAT(b.DAT_RECIVEDDATE,'%d-%b-%Y') pdate, "; 
		sql = sql +" DATEDIFF(a.DAT_SALESDATE,b.DAT_RECIVEDDATE) age, ";
		sql = sql +" IF ( ";
		sql = sql +" (DATEDIFF(a.DAT_SALESDATE,b.DAT_RECIVEDDATE) > 0), ";
		sql = sql +" ROUND(( (b.DOU_UNITPRICE *(18/100)/365)*DATEDIFF(a.DAT_SALESDATE,b.DAT_RECIVEDDATE)  ),2), ";
		sql = sql +" '' ";
		sql = sql +" )  ";
		sql = sql +" interest, ";

		sql = sql +" b.DOU_UNITPRICE,b.DOU_SALEUNITPRICE,(b.DOU_SALEUNITPRICE-b.DOU_UNITPRICE) contribution, ";
		sql = sql +" (((b.DOU_SALEUNITPRICE-b.DOU_UNITPRICE)/b.DOU_UNITPRICE)*100) contributionpercentage  ";
		
		
		sql = sql +" FROM inv_t_directsales a , inv_t_vendorgoodsreceived b  ";
		sql = sql +" WHERE a.CHR_SALESNO =b.CHR_SALESNO ";
		sql = sql +" AND a.CHR_CANCEL='N' AND b.CHR_FLAG ='Y' ";
		sql = sql +" AND a.DAT_SALESDATE >='"+fromdate+"' ";
		sql = sql +" AND a.DAT_SALESDATE <='"+todate+"' ";
		
		//Itype product or Item
		if("1".equals(itype))
				sql = sql +" AND b.CHR_TYPE ='I' ";
		else if("2".equals(itype))
			sql = sql +" AND b.CHR_TYPE = 'P' ";
		
		//Item code	
		if(!"0".equals(item))
				sql = sql +" AND b.CHR_ITEMID=   '"+item+"' ";		
		
		if(!"0".equals(division))
				sql = sql +" AND a.INT_DIVIID= "+division ;	
		if(!"0".equals(branchid))
			sql = sql +" AND a.INT_BRANCHID=   "+branchid;
			
		sql = sql +" ORDER BY a.DAT_SALESDATE ";
		
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
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				child.addElement(data[u][15]);
				child.addElement(data[u][16]);
				mn.add(child);
					 
			}
		}
			 
 	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 
  

%>


<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="PRODUCT CODE" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DESCRIPTION" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="SERIAL" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="INVOICE" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CUSTOMER" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="ME" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="SALE DATE" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="PURCHASE DATE" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="AGE" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="INTEREST" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="PURCHASE PRICE" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="SALESPRICE" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="CONTRIBUTION" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="CONTRIBUTION PERCENTAGE" sortable="true"><%=temp.elementAt(17)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_ProductwiseContribution.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_ProductwiseContribution.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_ProductwiseSalesReport.csv"/>
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
