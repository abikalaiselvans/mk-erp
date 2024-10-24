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
		String account=request.getParameter("account");
			
		String refid="";
		String div ="";
		String cust ="";
		String reportheader=" PURCHASE REPORT ON  :: ("+request.getParameter("frmdate") +" to " +request.getParameter("todate")+" ) "; 
		
		sql = " SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,c.CHR_NAME,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,  ";
		sql = sql + " f.CHR_DIVICODE,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),g.CHR_PAYMENTNAME,a.CHR_ACCOUNTFLAG,  ";
		sql = sql + " a.DOU_AMOUNT,h.CHR_TAXNAME,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_VENDORPO ,DATE_FORMAT(a.DAT_ACTUALINWARD,'%d-%b-%Y') ";
		sql = sql + " FROM inv_t_directpurchase a, inv_m_vendorsinformation  b,inv_m_vendorsgroup c,com_m_company d, com_m_branch e,  ";
		sql = sql + " inv_m_division f,inv_m_paymentterms g,inv_m_tax h  ";
		sql = sql + " WHERE a.INT_VENDORID=b.INT_VENDORID  ";
		sql = sql + " AND b.INT_GROUPID = c.INT_GROUPID  ";
		sql = sql + " AND d.INT_COMPANYID =e.INT_COMPANYID  ";
		sql = sql + " AND a.INT_BRANCHID = e.INT_BRANCHID  ";
		sql = sql + " AND a.INT_DIVIID = f.INT_DIVIID   ";
		sql = sql + " AND a.INT_PAYMENTTERMID = g.INT_PAYMENTTERMID   ";
		sql = sql + " AND a.INT_TAXID = h.INT_TAXID  ";
		sql = sql + " AND a.DAT_ORDERDATE >='"+frmdate+"'";
		sql = sql + " AND a.DAT_ORDERDATE <='"+todate+"'";
		if(!"0".equals(Branch))
			sql = sql + " AND a.INT_BRANCHID <= "+Branch ;
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID <= "+division ;
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID <= "+division ;
		if(!"0".equals(vendor))
			sql = sql + " AND a.INT_VENDORID = "+vendor ;
		if(!"0".equals(account))
			sql = sql + " AND a.CHR_ACCOUNTFLAG = '"+account+"' " ;
			
		sql = sql + " ORDER BY a.DAT_ORDERDATE  ";
		//out.println(sql); 
		
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
				child.addElement("<a target='_blank' href='ViewDirectPurchase.jsp?gdreceiveno="+data[u][0]+"'  target='_blank'>Details</a>");
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				if("Y".equals(data[u][8]))
					child.addElement("Received");
				else
					child.addElement("Not Received");
				
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				
				 
				mn.add(child);	
					
				 
				sum1=sum1 + Double.parseDouble(data[u][9]);
				sum2=sum2 + Double.parseDouble(data[u][11]);
				sum3=sum3 + Double.parseDouble(data[u][12]);
			
				
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
				child.addElement("");
				 
				child.addElement("TOTAL :: ");
				child.addElement(formatter.format(sum1));
				child.addElement(""); 
				child.addElement(formatter.format(sum2));
				child.addElement(formatter.format(sum3));
				child.addElement("");  
				mn.add(child);	
				 
				 
			 
			
			
			
		}
		 
		 
		 
		request.setAttribute("table",mn);
		 
  //<display:column title="Company" sortable="true" ><%=temp.elementAt(5) </display:column>
%>		 
		 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Purchase No" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Details" media="html" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Vendor Name" sortable="true" ><%=temp.elementAt(3)%></display:column>
					<display:column title="Vendor PO" sortable="true"><%=temp.elementAt(15)%></display:column>
					 
					<display:column title="Branch" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Division" sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="Purchase date" sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="Actual Inward " sortable="true" style="text-align:right"><%=temp.elementAt(16)%></display:column>
					<display:column title="TOTAL AMOUNT " sortable="true" style="text-align:right"><%=temp.elementAt(14)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_DailyPurchaseReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DailyPurchaseReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DailyPurchaseReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     

<br />	<center>	<a   href='Rept_DailyPurchaseReport.jsp'> CLOSE</a></center>

<br /><br />
 
	 		 
<%		 
		 
	}
	catch(Exception e)
	{
		
	}	
	
  %>
 
</body>
</html>
