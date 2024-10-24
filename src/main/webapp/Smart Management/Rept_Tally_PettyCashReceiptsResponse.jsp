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
 
<title> :: MANAGEMENT ::</title>



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
 
<body  onpaste='return false;'><br> 
<%
 

 	String reportheader="INCOME/RECEIPTS INFORMATIONS "; 
	String branch=request.getParameter("branch");
	String paymentmode=request.getParameter("paymentmode");
	String fromdate=request.getParameter("fromdate");
	String todate=request.getParameter("todate");
 	String sql="";
	sql = "  ";// CONCAT('Branch:', FUN_GET_BRANCH_NAME(a.INT_BRANCHID), '  Ref No: ',CHR_INCOMEREFNO, '  Desc: ', a.CHR_DESC),
	sql = sql + " SELECT a.INT_INCOMEID,a.CHR_INCOMEREFNO ,FUN_GET_BRANCH_NAME(a.INT_BRANCHID), a.CHR_DESC,";
	sql = sql + " DATE_FORMAT(a.DAT_INCOME,'%d-%b-%Y'), b.CHR_NAME,a.DOU_AMOUNT,FIND_A_EMPLOYEE_ID_NAME_BY_USERID(a.CHR_USRNAME), c.CHR_DEPOSITNAME  ";
	sql = sql + " FROM mgt_t_pettycash_income a, mgt_m_pettycash b , com_m_deposit_to c ";
	sql = sql + " WHERE a.INT_SOURCEID = b.INT_CATEGORYID  AND  a.INT_PAYMENTMODE = c.INT_DEPOSITID";
	sql = sql + " AND a.DAT_INCOME >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
	sql = sql + " AND a.DAT_INCOME <= '" +DateUtil.FormateDateSQL(todate)+"' ";        
	 
	if(!"0".equals(branch))
		sql = sql + " AND a.INT_BRANCHID = "+branch;
	if(!"0".equals(paymentmode))
		sql = sql + " a.INT_PAYMENTMODE = "+paymentmode;
	  
	sql = sql + "   ORDER BY a.INT_INCOMEID  ";
	//out.println(sql);
	String data[][] = CommonFunctions.QueryExecute(sql);
    Vector mn = new Vector();
	Vector child= null;
    for(int u=0; u<data.length;u++)
	{
	     	child = new Vector();
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]); 
				child.addElement(data[u][4]); 
				child.addElement(data[u][5]); 
				child.addElement(data[u][6]);  
				child.addElement(data[u][7]); 
				child.addElement(data[u][8]); 
				child.addElement(""); 
				child.addElement(""); 
				child.addElement(""); 
				child.addElement(""); 
				child.addElement(""); 
				child.addElement(""); 
				child.addElement(""); 
				child.addElement(""); 
			 
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	
  //<display:column title="2NDLEDGERNAME"   sortable="true">PETTY CASH EXPENSES</display:column>
  
 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="TRXN"   sortable="true">R<%=temp.elementAt(0)%></display:column>
					<display:column title="SALESINVOICENO"   sortable="true"></display:column>
					<display:column title="SALESINVOICENO" sortable="true"></display:column>
					<display:column title="LEDGERCODE"   sortable="true"></display:column>
					<display:column title="1STLEDGERNAMEPARTYLEDG"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="CUSTOMERGSTINNO"   sortable="true"></display:column>
					<display:column title="PAYMENTMODE"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PAYMENTREFNUMBER"   sortable="true"></display:column>
					<display:column title="TALLY_DATE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="ISSUE_ENTRYDATE"  sortable="true"></display:column>
					
					<display:column title="NARRATION"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="INVOICE_NETAMOUNT" style="text-align:right"   sortable="true"></display:column>
					<display:column title="2NDLEDGERNAME"   sortable="true">PETTY CASH EXPENSES</display:column>
					<display:column title="TTYPE"   sortable="true">+</display:column>
					<display:column title="PAIDAMOUNT"  style="text-align:right"  sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="SYSTEM_ENTRYDATE"  style="text-align:right" sortable="true"></display:column>
					<display:column title="TRAN_TYPE"   sortable="true">EJ</display:column>  
					<display:column title="STATUS"   sortable="true"></display:column>  	
		 	
					<display:setProperty name="export.excel.filename" value="Rept_Tally_PettyCashExpenses_Template.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Tally_PettyCashExpenses_Template.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Tally_PettyCashExpenses_Template.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
					 
</display:table> 
      
<br />	<center>	<a href='ManagementMain.jsp'> CLOSE</a>
</center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>
