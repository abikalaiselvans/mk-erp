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
 

 	String reportheader="BALANCE SHEET INFORMATIONS "; 
	String fromdate= request.getParameter("fromdate");
	String todate= request.getParameter("todate");
	String d1 =  DateUtil.FormateDateSQL(fromdate);
	String d2 =   DateUtil.FormateDateSQL(todate);
	String branch= request.getParameter("branch");
 	String sql="";
	sql = "";
	
	sql = sql + " ( ";
	sql = sql + " SELECT CONCAT(CHR_INCOMEREFNO), FUN_GET_BRANCH_NAME(a.INT_BRANCHID), "; 
	sql = sql + " DATE_FORMAT(a.DAT_INCOME,'%d-%b-%Y'), CONCAT(''),a.CHR_DESC,a.DOU_AMOUNT  income,CONCAT('')  ";
	sql = sql + " FROM mgt_t_pettycash_income a, mgt_m_pettycash b  "; 
	sql = sql + " WHERE  a.DAT_INCOME >='"+d1+"'  ";
	sql = sql + " AND a.DAT_INCOME <='"+d2+"'  ";
	if(!"0".equals(branch))
		sql = sql + " AND a.INT_BRANCHID ="+branch;
	sql = sql + " ORDER BY a.DAT_INCOME   ";
	sql = sql + " ) ";
	sql = sql + " UNION ";
	sql = sql + " ( ";
	sql = sql + " SELECT CONCAT(CHR_EXPENSEREFNO ), FUN_GET_BRANCH_NAME(a.INT_BRANCHID), "; 
	sql = sql + " DATE_FORMAT(a.DAT_EXPENSE,'%d-%b-%Y'),b.CHR_NAME,a.CHR_DESC,CONCAT(''),a.DOU_AMOUNT expense   ";
	sql = sql + " FROM mgt_t_pettycash_expenses a, mgt_m_pettycash b   ";
	sql = sql + " WHERE a.INT_CATEGORYID = b.INT_CATEGORYID  "; 
	if(!"0".equals(branch))
		sql = sql + " AND a.INT_BRANCHID ="+branch;

	sql = sql + " AND a.DAT_EXPENSE >='"+d1+"'  ";
	sql = sql + " AND a.DAT_EXPENSE <='"+d2+"'  ";
	sql = sql + " ORDER BY a.DAT_EXPENSE   ";
	sql = sql + " ) ";
	
	sql = sql + " UNION  ";
	sql = sql + " ( SELECT  CONCAT('-'),CONCAT('-'),CONCAT('-'),CONCAT('-'),CONCAT('-'),  ";
	if(!"0".equals(branch))
	{
		sql = sql + " FUN_MGT_BALANCESHEET_BRANCH('"+branch+"','INCOME','"+d1+"','"+d2+"')  income, "; 	
		sql = sql + " FUN_MGT_BALANCESHEET_BRANCH('"+branch+"' ,'EXPENSES','"+d1+"','"+d2+"') expense  ";
	}
	else
	{
		sql = sql + " FUN_MGT_BALANCESHEET('INCOME','"+d1+"','"+d2+"')  income, "; 	
		sql = sql + " FUN_MGT_BALANCESHEET('EXPENSES','"+d1+"','"+d2+"') expense  ";
	}
	sql = sql + " ) ";
	//out.println(sql);
	
	String data[][] = CommonFunctions.QueryExecute(sql);
    Vector mn = new Vector();
	Vector child= null;
    if(data.length>0)
	for(int u=0; u<data.length;u++)
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
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	
  
  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title=" "   sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="BRANCH "   sortable="true"><%=temp.elementAt(2)%></display:column>
                    <display:column title="DATE "   sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="HEAD "   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DESCRIPTION" sortable="true" ><%=temp.elementAt(5)%></display:column>
                    <display:column title="INCOME" sortable="true" ><%=temp.elementAt(6)%></display:column>
                    <display:column title="EXPENSES" sortable="true" ><%=temp.elementAt(7)%></display:column>
                    
					<display:setProperty name="export.excel.filename" value="BalanceSheet.xls"/>
					<display:setProperty name="export.pdf.filename" value="BalanceSheet.pdf"/>
					<display:setProperty name="export.csv.filename" value="BalanceSheet.csv"/>
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
