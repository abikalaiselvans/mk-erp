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
<%
try
{
%>
 
<body ><br> 
<%
 

 	String reportheader="PO INFORMATIONS  ";
	String serials = request.getParameter("serials");
	String serial[] = serials.split(",");
	serials ="";
	if(serial.length >0)
		 for(int u=0;u<serial.length;u++)
		 	serials = serials +"'"+serial[u].trim() +"' ,";
			
	String sql="";
	Vector mn = new Vector();
	Vector child= null;
	if(serial.length >0)
	{
		sql = "     ";
		sql = sql + " SELECT a.CHR_PURCHASEORDERNO ref,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),a.DOU_TOTALAMOUNT,  ";
		sql = sql + " a.CHR_VENDORPO,a.CHR_POREQUESTNO,b.CHR_PURCHASEORDERNO ,FIND_A_VENDOR_NAME(a.INT_VENDORID) ";
		sql = sql + "  FROM inv_t_directpurchase a, inv_t_vendorpurchaseorder b  ";
		sql = sql + " WHERE a.CHR_CANCEL ='N'   ";
		sql = sql + " AND a.CHR_POREQUESTNO =b.CHR_POREQUESTNO  ";
		sql = sql + " AND a.INT_VENDORID =b.INT_VENDORID  ";
		sql = sql + " AND a.CHR_POREQUESTNO IN  ( "+serials+" '0') ";
		sql = sql + "  ORDER BY a.CHR_PURCHASEORDERNO ";
		//out.println(sql);
        String data[][] =CommonFunctions.QueryExecute(sql);
		 
		if(data.length>0)
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1)+".");
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
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					
	<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
	<display:column title="PO Number " sortable="true"><%=temp.elementAt(1)%></display:column>
	<display:column title="DATE " sortable="true"><%=temp.elementAt(2)%></display:column>
	<display:column title="AMOUNT " media="html" sortable="true"><%=temp.elementAt(3)%></display:column>
	<display:column title="VENDOR REF NO " sortable="true"><%=temp.elementAt(4)%></display:column>
    <display:column title="PURCHASE REQUEST " sortable="true"><%=temp.elementAt(5)%></display:column>
	<display:column title="VPO NUMBER " sortable="true"><%=temp.elementAt(6)%></display:column>
    <display:column title="VENDOR" sortable="true"><%=temp.elementAt(7)%></display:column>
	<display:setProperty name="export.excel.filename" value="PODetailsAgainstPR.xls"/>
	<display:setProperty name="export.pdf.filename" value="PODetailsAgainstPR.pdf"/>
	<display:setProperty name="export.csv.filename" value="PODetailsAgainstPR.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	
					
</display:table> 
			
<br />	<center>	<a href='PODetailsAgainstPR.jsp'> CLOSE</a></center>
			

 
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 
 