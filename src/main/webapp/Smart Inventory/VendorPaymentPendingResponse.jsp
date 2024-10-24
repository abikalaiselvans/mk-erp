<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.UtilityFunctions"%>
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
 		String reportheader="VENDOR PAYMENT"; 
		String Vendortype = request.getParameter("Vendortype");
		String order=request.getParameter("order");
		String From=request.getParameter("From");
		String To=request.getParameter("To");
		String sql="";
		if("Direct".equals(Vendortype))
		{
			 
			sql = " SELECT b.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME,c.CHR_MOBILE,DATE_FORMAT(b.DAT_ORDERDATE,'%d-%b-%Y'), ";
			sql = sql+ "datediff(now(),b.DAT_ORDERDATE), b.DOU_TOTALAMOUNT,";
			sql = sql+ "(SELECT sum(a.DOU_PAIDAMOUNT) FROM inv_t_vendorpurchasepayment a WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO ) ";
			sql = sql+ " ,b.CHR_VENDORPO FROM inv_t_directpurchase b,  inv_m_vendorsinformation  c     ";
			sql = sql+ " WHERE  b.INT_VENDORID= c.INT_VENDORID";
			sql = sql+ " AND datediff(now(),b.DAT_ORDERDATE)>="+From;
			sql = sql+ "  AND datediff(now(),b.DAT_ORDERDATE) <="+To;
			sql = sql+ " Group by b.CHR_PURCHASEORDERNO ORDER BY "+order;
		
		}
		else if("Purchase".equals(Vendortype))
		{
			sql = " SELECT b.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME,c.CHR_MOBILE,DATE_FORMAT(b.DAT_ORDERDATE,'%d-%b-%Y'), ";
			sql = sql+ "datediff(now(),b.DAT_ORDERDATE), b.DOU_TOTALAMOUNT,";
			sql = sql+ "(SELECT sum(a.DOU_PAIDAMOUNT) FROM inv_t_vendorpurchasepayment a WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO ) ";
			sql = sql+ " ,CONCAT('','-') FROM inv_t_vendorpurchaseorder b,  inv_m_vendorsinformation  c     ";
			sql = sql+ " WHERE  b.INT_VENDORID= c.INT_VENDORID";
			sql = sql+ " AND datediff(now(),b.DAT_ORDERDATE)>="+From;
			sql = sql+ "  AND datediff(now(),b.DAT_ORDERDATE) <="+To;
			sql = sql+ " Group by b.CHR_PURCHASEORDERNO ORDER BY "+order;
		}
		 
		String data[][] =CommonFunctions.QueryExecute(sql);
		Vector mn = new Vector();
	 	Vector child= null;
				
		if(data.length>0)
		{
			double sum=0;
			double sum1=0;
			double sum2=0;
			double diff=0.00;
			for(int u=0;u<data.length;u++)
			{
				
				diff=0.0;
				if("-".equals(data[u][6].trim()) || "null".equals(data[u][6].trim()))
					sum1=0;
				else
					sum1 = Double.parseDouble(data[u][6].trim());	
					
				sum2 = Double.parseDouble(data[u][5].trim())-sum1;
				diff=Double.parseDouble(data[u][5].trim())-sum1;
				
				sum1 = UtilityFunctions.getDoubleplace(sum1);
				sum2 = UtilityFunctions.getDoubleplace(sum2);
				diff = UtilityFunctions.getDoubleplace(diff);
				
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][7]);	
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);	
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);		
				child.addElement(data[u][5]);
				child.addElement(sum1);
				child.addElement(sum2);
				sum = sum+Double.parseDouble(data[u][5].trim()); 
				if(diff>=1)
					mn.add(child); 
			}
			child = new Vector();
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			
			child.addElement("TOTAL");
			Double a = sum;
			child.addElement(""+UtilityFunctions.ConvertExponentialformtoDecimalnumber(a));
			child.addElement("");
			mn.add(child); 
		} 
		
		

		request.setAttribute("table",mn);
		
		
		 
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" ><%=temp.elementAt(0)%></display:column>
					<display:column title="PO. Ref. No"   ><%=temp.elementAt(1)%></display:column>
					<display:column title="Vendor P.O."   ><%=temp.elementAt(2)%></display:column>
					<display:column title="Vendor Name"   ><%=temp.elementAt(3)%></display:column>
					<display:column title="Vendor Mobile"   ><%=temp.elementAt(4)%></display:column>
					<display:column title="PO. Date"   ><%=temp.elementAt(5)%></display:column>
					<display:column title="Days Left"   ><%=temp.elementAt(6)%></display:column>
					<display:column title="Bill Amount"   ><%=temp.elementAt(7)%></display:column>
					<display:column title="Paid Amount"   ><%=temp.elementAt(8)%></display:column>
					<display:column title="Balance Amount"   sortable="true"><%=temp.elementAt(9)%></display:column>
					  
					<display:setProperty name="export.excel.filename" value="PurchasePayment.xls"/>
					<display:setProperty name="export.pdf.filename" value="PurchasePayment.pdf"/>
					<display:setProperty name="export.csv.filename" value="PurchasePayment.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
	System.out.println(e.getMessage() );
}
%>		 
</body>
</html>

