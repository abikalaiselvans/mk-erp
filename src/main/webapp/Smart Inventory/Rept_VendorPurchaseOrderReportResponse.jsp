<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%><head>
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
<%
	try
	{
		java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(Locale.ENGLISH);
		formatter.setMaximumFractionDigits(2);
   		formatter.setMinimumFractionDigits(2); 
		String branchid = session.getAttribute("BRANCHID").toString();
				
		 
		String frmdate = ""+request.getParameter("frmdate");
		String todate = request.getParameter("todate");
		frmdate= DateUtil.FormateDateSQL(frmdate);
		todate= DateUtil.FormateDateSQL(todate);
		
		String sql = "" ;
		String division = ""+request.getParameter("division");
		String detail = ""+request.getParameter("detail");
		String vendor=request.getParameter("vendor");
		String Branch=request.getParameter("Branch");
	 
			
		String refid="";
		String div ="";
		String cust ="";
		String reportheader=" PURCHASE ORDER REPORT ON  :: ("+request.getParameter("frmdate") +" to " +request.getParameter("todate")+" ) "; 
		
		sql = sql + "   SELECT c.CHR_BRANCHNAME ,a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, e.CHR_DIVICODE, ";
		sql = sql + "  DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'), a.CHR_DES, ";
		sql = sql + " a.DOU_AMOUNT, d.CHR_TAXNAME,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT, a.INT_PURCHASESTATUS  ";
		sql = sql + "  FROM  inv_t_vendorpurchaseorder  a, inv_m_vendorsinformation b, com_m_branch c,  ";
		sql = sql + "  inv_m_tax d , inv_m_division e  ";
		sql = sql + "  WHERE a.INT_VENDORID =b.INT_VENDORID AND a.INT_BRANCHID = c.INT_BRANCHID  "; 
		sql = sql + "  AND a.INT_TAXID =d.INT_TAXID  ";
		sql = sql + "  AND a.INT_DIVIID =e.INT_DIVIID ";
		 
		sql = sql + " AND a.DAT_ORDERDATE >='"+frmdate+"'";
		sql = sql + " AND a.DAT_ORDERDATE <='"+todate+"'";
		if(!"0".equals(Branch))
			sql = sql + " AND a.INT_BRANCHID <= "+Branch ;
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID <= "+division ;
		if(!"0".equals(vendor))
			sql = sql + " AND a.INT_VENDORID = "+vendor ;
		  sql = sql + "  ORDER BY INT_PURCHASEORDERID    ";
		 
		
		
		String data[][] =  CommonFunctions.QueryExecute(sql);
		Vector mn = new Vector();
	 	Vector child= null;
		
		
		if(data.length>0)
		{
			double sum1=0.0;
			double sum2=0.0;
			double sum3=0.0;
			
			for(int u=0;u<data.length;u++)
			{
				
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement("<a target='_blank' href='PurchaseorderPrint.jsp?pono="+data[u][1]+"'  target='_blank'>Details</a>");
				
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(formatter.format(Double.parseDouble(data[u][6]) ));
				child.addElement(data[u][7]);
				child.addElement(formatter.format(Double.parseDouble(data[u][8]) ));
				child.addElement(formatter.format(Double.parseDouble(data[u][9]) ));
				 mn.add(child);	
					
				 
				sum1=sum1 + Double.parseDouble(data[u][6]);
				sum2=sum2 + Double.parseDouble(data[u][8]);
				sum3=sum3 + Double.parseDouble(data[u][9]);
			
				
			}
			
			child = new Vector();
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement(" TOTAL ::  ");
			child.addElement(formatter.format(sum1));
			child.addElement("");
			child.addElement(formatter.format(sum2) );
			child.addElement(formatter.format(sum3));
			mn.add(child);	
 			
		}
		 
		 
		 
		request.setAttribute("table",mn);
		 
  //<display:column title="Company" sortable="true" ><%=temp.elementAt(5) </display:column>
%>		 
		 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Purchase No" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Details" media="html" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Vendor Name" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title="Division" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="Order date" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Description" sortable="true" ><%=temp.elementAt(7)%></display:column>
					
					 <display:column title="Amount " sortable="true" style="text-align:right"><%=temp.elementAt(8)%></display:column>
					<display:column title="Tax" sortable="true" style="text-align:right"><%=temp.elementAt(9)%></display:column>
					<display:column title="Tax Amount" sortable="true" style="text-align:right"><%=temp.elementAt(10)%></display:column>
					<display:column title="Total" sortable="true" style="text-align:right"><%=temp.elementAt(11)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_DailyPurchaseOrderReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DailyPurchaseOrderReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DailyPurchaseOrderReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     

<br />	<center>	<a   href='Rept_VendorPurchaseOrderReport.jsp'> CLOSE</a>
</center>

<br /><br />
 
	 		 
<%		 
		 
	}
	catch(Exception e)
	{
		
	}	
	
  %>
 
</body>
</html>
