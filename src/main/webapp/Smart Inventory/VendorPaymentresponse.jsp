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
 		String reportheader="VENDOR PAYMENT"; 
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String vendorid = request.getParameter("vendorid");
		String Vendortype = request.getParameter("Vendortype");
		String Chequedt=request.getParameter("Chequedt");
		String sql="";
		String fdt=DateUtil.FormateDateSQL(fromdate);
		String tdt=DateUtil.FormateDateSQL(todate);
		String mode="";
		if("Direct".equals(Vendortype))
		{
			mode = "DIRECT PURCHASE PAYMENT ";
			sql = " SELECT a.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME,c.CHR_MOBILE,b.DOU_TOTALAMOUNT,b.DAT_ORDERDATE , ";
			sql = sql+ "d.CHR_PAYMENTNAME,";
			sql = sql+ " (SELECT  e.CHR_BANKGROUPNAME FROM com_m_bankgroup e  WHERE e.INT_BANKGROUPID =a.INT_BANKID  ) , ";
			sql = sql+ "  a.CHR_DDNUMBER,a.DAT_DDDATE,a.DAT_PAYMENTDATE,a.DOU_PAIDAMOUNT ";
			sql = sql+ " FROM inv_t_vendorpurchasepayment a ,inv_t_directpurchase b,  inv_m_vendorsinformation  c,  ";
			sql = sql+ "inv_m_paymentterms d  WHERE a.CHR_PURCHASEORDERNO = b.CHR_PURCHASEORDERNO ";
			sql = sql+ "AND b.INT_VENDORID= c.INT_VENDORID ";
			sql = sql+ "AND d.INT_PAYMENTTERMID= a.INT_PAYMENTTERMID ";
			 
			if(!vendorid.equals("0"))
				sql = sql+ "  AND b.INT_VENDORID="+vendorid;
			
			sql = sql+ " AND a.CHR_INVOICEFOR ='D' ";
			if("1".equals(Chequedt))
			{
				sql = sql+ " AND  a.DAT_DDDATE >='"+fdt+"'";
				sql = sql+ " AND  a.DAT_DDDATE <='"+tdt+"'";
				sql = sql+ " ORDER BY a.DAT_DDDATE ";
			}
			else
			{
				sql = sql+ " AND  a.DAT_PAYMENTDATE >='"+fdt+"'";
				sql = sql+ " AND  a.DAT_PAYMENTDATE <='"+tdt+"'";
				sql = sql+ " ORDER BY a.DAT_PAYMENTDATE ";
			}
				
			 
		}
		else if("Purchase".equals(Vendortype))
		{
			mode = "PURCHASE ORDER PAYMENT ";
			 
			sql = " SELECT a.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME,c.CHR_MOBILE,b.DOU_TOTALAMOUNT,b.DAT_ORDERDATE , ";
			sql = sql+ "d.CHR_PAYMENTNAME,";
			sql = sql+ " (SELECT  e.CHR_BANKGROUPNAME FROM com_m_bankgroup e  WHERE e.INT_BANKGROUPID =a.INT_BANKID  ) , ";
			sql = sql+ "  a.CHR_DDNUMBER,a.DAT_DDDATE,a.DAT_PAYMENTDATE,a.DOU_PAIDAMOUNT ";
			sql = sql+ " FROM inv_t_vendorpurchasepayment a ,inv_t_vendorpurchaseorder b,  inv_m_vendorsinformation  c,  ";
			sql = sql+ "inv_m_paymentterms d  WHERE a.CHR_PURCHASEORDERNO = b.CHR_PURCHASEORDERNO ";
			sql = sql+ "AND b.INT_VENDORID= c.INT_VENDORID ";
			sql = sql+ "AND d.INT_PAYMENTTERMID= a.INT_PAYMENTTERMID ";
			 
			sql = sql+ " AND a.CHR_INVOICEFOR ='D' ";
			if(!vendorid.equals("0"))
				sql = sql+ "  AND b.INT_VENDORID="+vendorid;
			
			if("1".equals(Chequedt))
			{
				sql = sql+ " AND  a.DAT_DDDATE >='"+fdt+"'";
				sql = sql+ " AND  a.DAT_DDDATE <='"+tdt+"'";
				sql = sql+ " ORDER BY a.DAT_DDDATE ";
			}
			else
			{
				sql = sql+ " AND  a.DAT_PAYMENTDATE >='"+fdt+"'";
				sql = sql+ " AND  a.DAT_PAYMENTDATE <='"+tdt+"'";
				sql = sql+ " ORDER BY a.DAT_PAYMENTDATE ";
			}
		}
		out.println(sql);	
		String data[][] =CommonFunctions.QueryExecute(sql);
		Vector mn = new Vector();
	 	Vector child= null;
		 		
		if(data.length>0)
		{
			double sum=0.0;
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
				sum = sum+Double.parseDouble(data[u][10].trim());
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
			child.addElement("");
			child.addElement("");
			child.addElement("TOTAl :");
			child.addElement(sum);
			mn.add(child); 
		} 
		
		request.setAttribute("table",mn);
		
		 
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="PO. Ref. No"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Vendor Name"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Vendor Mobile"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Bill Amount"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PO. Date"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Payment Mode"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Bank"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Cheque / DD / Other Details"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Cheque Date"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Entry Date"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Paid Amount"   sortable="true"><%=temp.elementAt(11)%></display:column>
					
					  
					
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
}
%>		 
</body>
</html>

