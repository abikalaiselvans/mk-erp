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
 

 	String reportheader="ABSTARCT INFORMATIONS "; 
	String fromdate= request.getParameter("fromdate");
	String todate= request.getParameter("todate");
	String branch= request.getParameter("branch");
	
	String d1 =  DateUtil.FormateDateSQL(fromdate);
	String d2 =   DateUtil.FormateDateSQL(todate);
 	String sql="";
	sql = "";
	 	
	sql = sql + " ( ";
	sql = sql + "  SELECT CONCAT(''),  CONCAT(''),CONCAT('OPEN BALANCE AS ON "+fromdate+"'),CONCAT(''),FUN_MGT_BALANCESHEET_BRANCH('"+branch+"', 'OPENBALANCE','"+d1+"','"+d2+"' ),CONCAT(''),CONCAT(''),CONCAT('') ,CONCAT(''),CONCAT('')";
	sql = sql + " ) ";
	
	sql = sql + " UNION ";
	
	sql = sql + " ( ";
	sql = sql + " SELECT DATE_FORMAT(a.DAT_INCOME,'%d-%b-%Y') ,CONCAT(a.CHR_INCOMEREFNO), CONCAT('INCOME'), CONCAT('-'),(a.DOU_AMOUNT)  income,CONCAT('') ,CONCAT(''),CONCAT(''),a.CHR_DESC ,FUN_GET_BRANCH_NAME(a.INT_BRANCHID)";
	sql = sql + " FROM mgt_t_pettycash_income a  ";
	sql = sql + " WHERE  a.INT_INCOMEID >=0  ";
	sql = sql + " AND  a.DAT_INCOME >='"+d1+"'  ";
	sql = sql + " AND a.DAT_INCOME <='"+d2+"'  ";
	if(!"0".equals(branch))
		sql = sql + " AND a.INT_BRANCHID = "+branch;
	sql = sql + " ) ";
	
	sql = sql + " UNION ";
	
	sql = sql + " ( ";
	sql = sql + " SELECT DATE_FORMAT(a.DAT_EXPENSE,'%d-%b-%Y') , CONCAT(CHR_EXPENSEREFNO), CONCAT('EXPENSE'), b.CHR_NAME,CONCAT('') ,a.DOU_AMOUNT  expense , IF(a.CHR_TYPE='E','Employee','Others') ,IF(a.CHR_TYPE='E',FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),a.CHR_EMPID),a.CHR_DESC ,";
	sql = sql + " FUN_GET_BRANCH_NAME(a.INT_BRANCHID) FROM mgt_t_pettycash_expenses a, mgt_m_pettycash b   ";
	sql = sql + " WHERE a.INT_CATEGORYID = b.INT_CATEGORYID  "; 
	sql = sql + " AND  a.DAT_EXPENSE >='"+d1+"'  ";
	sql = sql + " AND a.DAT_EXPENSE <='"+d2+"' "; 
	if(!"0".equals(branch))
		sql = sql + " AND a.INT_BRANCHID = "+branch;
	sql = sql + " ORDER BY b.CHR_NAME  ";
	sql = sql + " ) ";
	
	sql = sql + " UNION ";
	
	sql = sql + " ( ";
	sql = sql + " SELECT CONCAT(''), CONCAT(''),CONCAT('SUM'),CONCAT(''), (FUN_MGT_BALANCESHEET_BRANCH('"+branch+"','OPENBALANCE','"+d1+"','"+d2+"' ) +  FUN_MGT_BALANCESHEET_BRANCH('"+branch+"','INCOME','"+d1+"','"+d2+"' )  ) inc,FUN_MGT_BALANCESHEET_BRANCH('"+branch+"','EXPENSES','"+d1+"','"+d2+"' ) ex ,";
	sql = sql + " CONCAT(''),CONCAT('') ,CONCAT('') ,CONCAT('') ) ";
	 
	sql = sql + "  UNION ";
	
	sql = sql + " ( ";
 	sql = sql + " SELECT CONCAT(''), CONCAT('-'),CONCAT('CLOSING BALANCE AS ON "+todate+"'),CONCAT(''), ( FUN_MGT_BALANCESHEET_BRANCH('"+branch+"','OPENBALANCE','"+d1+"','"+d2+"' ) + FUN_MGT_BALANCESHEET_BRANCH('"+branch+"','BALANCE','"+d1+"','"+d2+"' ) ) ,CONCAT(''),CONCAT(''),CONCAT(''),CONCAT('') ,CONCAT('')";
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
			child.addElement(data[u][7]);  
			child.addElement(data[u][8]); 
			child.addElement(data[u][9]); 
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	
  
  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="DATE "   sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="VOUCHER "   sortable="true"><%=temp.elementAt(2)%></display:column>
                    <display:column title="INCOME/EXPENSES " sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="TYPE " sortable="true"><%=temp.elementAt(4)%></display:column>
                    <display:column title="AMOUNT "   style="text-align:right"  sortable="true"><%=temp.elementAt(5)%></display:column>
                    <display:column title="EXPENSES "   style="text-align:right"  sortable="true"><%=temp.elementAt(6)%></display:column>
                    <display:column title="EMP / OTHERS " sortable="true"><%=temp.elementAt(7)%></display:column>
                    <display:column title="ID / NAME " sortable="true"><%=temp.elementAt(8)%></display:column>
                    <display:column title="NARRATION " sortable="true"><%=temp.elementAt(9)%></display:column>
                    <display:column title="LOCATION " sortable="true"><%=temp.elementAt(10)%></display:column>
                       
					<display:setProperty name="export.excel.filename" value="Rept_PettyCashBalanceSheetProfitResponse.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_PettyCashBalanceSheetProfitResponse.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_PettyCashBalanceSheetProfitResponse.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center><a style="text-align:right" href='ManagementMain.jsp'> CLOSE</a>
</center>
  
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</html>
