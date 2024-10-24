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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return,purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<title>:: CONVEYANCE ::</title>

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
 		String reportheader="EXPORT ADVANCE TO TALLY "; 
		String sql ="";
		 
		String fromdate = ""+request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		 
		Vector mn = new Vector();
	 	Vector child= null;
		 
	 
		
		sql = sql + " SELECT a.INT_ADVANCEID,a.CHR_EMPID,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID), DATE_FORMAT(a.DAT_ENTRYDATE ,'%d-%b-%Y') ,a.DOU_AMOUNT,";
		sql = sql + " CONCAT(a.CHR_EMPID, ' ', FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID), ' ', DATE_FORMAT(a.DAT_ENTRYDATE ,'%d-%b-%Y'), ' ', a.CHR_DESC)," ;
		sql = sql + "  b.CHR_DEPOSITNAME ";
		sql = sql + " FROM conveyance_m_advance a, com_m_deposit_to b WHERE a.DOU_AMOUNT>1  AND a.INT_DEPOSITID = b.INT_DEPOSITID ";
		sql = sql + " AND DAT_ENTRYDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
		sql = sql + " AND  DAT_ENTRYDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";  
		sql = sql + " ORDER BY INT_ADVANCEID";
		//out.println(sql);
			
				 
		String data[][] = CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			 
			for(int u=0;u<data.length;u++)
			{
				 
				child = new Vector();
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
		System.out.println(mn);
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="TRXN"   sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="SALESINVOICENO"   sortable="true"></display:column>
					<display:column title="SALESINVOICENO" sortable="true"></display:column>
					<display:column title="LEDGERCODE"   sortable="true"></display:column>
					<display:column title="1STLEDGERNAMEPARTYLEDG"   sortable="true">Travelling Expense</display:column>
					<display:column title="CUSTOMERGSTINNO"   sortable="true"></display:column>
					<display:column title="PAYMENTMODE"   sortable="true"></display:column>
					<display:column title="PAYMENTREFNUMBER"   sortable="true"></display:column>
					<display:column title="CHEQUE_DD_DATE"   sortable="true"></display:column>
					<display:column title="ISSUE_ENTRYDATE"  sortable="true"></display:column>
					
					<display:column title="NARRATION"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="INVOICE_NETAMOUNT" style="text-align:right"   sortable="true"></display:column>
					<display:column title="2NDLEDGERNAME"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="TTYPE"   sortable="true">+</display:column>
					<display:column title="PAIDAMOUNT"  style="text-align:right"  sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="SYSTEM_ENTRYDATE"  style="text-align:right" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="TRAN_TYPE"   sortable="true"></display:column>  
					<display:column title="STATUS"   sortable="true"></display:column>  	
		 	
					<display:setProperty name="export.excel.filename" value="Rept_Tally_ConveyanceAdvance_Template.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Tally_ConveyanceAdvance_Template.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Tally_ConveyanceAdvance_Template.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_Tally_Advance.jsp'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>		 
</body>
</html>

