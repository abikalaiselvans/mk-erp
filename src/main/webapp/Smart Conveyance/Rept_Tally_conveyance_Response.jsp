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
 		String reportheader="EXPORT CONVEYANCE TO TALLY "; 
 		String date=request.getParameter("date");
		String sql="";
		 
		sql=" SELECT IF(b.CHR_TYPE = 'T',CONCAT(a.CHR_EMPID,' *** '),a.CHR_EMPID), b.CHR_STAFFNAME,sum(a.DOU_TRAVEL),sum(a.DOU_TRAIN),sum(a.DOU_AUTO),sum(a.DOU_LUNCH),sum(a.DOU_TELEPHONE),";
		sql=sql + "  sum(a.DOU_OTHERAMT),";
		sql=sql + "(sum(a.DOU_TRAVEL)+sum(a.DOU_TRAIN)+sum(a.DOU_AUTO)+sum(a.DOU_LUNCH)+sum(a.DOU_TELEPHONE)+sum(a.DOU_OTHERAMT))"; 
		sql = sql + " ,sum(a.DOU_TOTAL),DATE_FORMAT(MIN(DAT_CONDATE),'%e-%M-%Y'), DATE_FORMAT(MAX(DAT_CONDATE),'%e-%M-%Y')";
		sql = sql + "  ,FIND_A_BANKGROUP_NAME(b.CHR_BANK) ,b.CHR_ACCNO, b.CHR_IFSC, d.CHR_OFFICENAME,e.CHR_DEPARTNAME, f.CHR_CATEGORYNAME, ";
		sql = sql + "  FUN_GET_CONVEYANCE_ADVANCE_DEDUCTION(a.CHR_EMPID,'"+date+"') ,  ";
		sql = sql + "  (SUM(a.DOU_TOTAL) -FUN_GET_CONVEYANCE_ADVANCE_DEDUCTION(a.CHR_EMPID,'"+date+"')   ),";
		//sql = sql + "  CONCAT( ' Empid:', a.CHR_EMPID,  ' Name:',b.CHR_STAFFNAME,  ' Conveyance Date:',DATE_FORMAT(MAX(DAT_CONDATE),'%e-%M-%Y'),  ' Emp Bank:', FIND_A_BANKGROUP_NAME(b.CHR_BANK) , ' Emp A/C Number:',b.CHR_ACCNO,  'IFSC:',b.CHR_IFSC,  ' Office:',d.CHR_OFFICENAME,  ' Depart:',e.CHR_DEPARTNAME, ' Category:', f.CHR_CATEGORYNAME) ,";
		sql = sql +"  CONCAT(' Empid:', a.CHR_EMPID,  ' Name:',b.CHR_STAFFNAME,' Conveyance for the month of ',UPPER(MONTHNAME('"+date+"')) ,' ',YEAR('"+date+"')),   ";
		sql = sql + " DATE_FORMAT(DAT_CLEARINGDATE ,'%d-%b-%Y')  ";
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b, com_m_office d, com_m_depart e , com_m_employeecategory  f";
		sql = sql + "  WHERE a.CHR_EMPID=b.CHR_EMPID	  ";
		sql = sql + "  AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y'  AND b.INT_OFFICEID =d.INT_OFFICEID ";
		sql = sql + "  AND b.INT_DEPARTID= e.INT_DEPARTID ";
		sql = sql + "  AND b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID AND a.DAT_ACCDATE='"+date+"' ";
		sql = sql + "  GROUP BY a.CHR_EMPID	 ORDER BY  b.CHR_STAFFNAME";
		out.println(sql);
		
		Vector mn = new Vector();
	 	Vector child= null;
				 
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
				child.addElement(data[u][17]);
				child.addElement(data[u][18]);
				child.addElement(data[u][19]);
				child.addElement(data[u][20]);
				child.addElement(data[u][21]);
				mn.add(child); 
			}
		}
				 
		 
		request.setAttribute("table",mn);
		System.out.println(mn);
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="TRXN"   sortable="true"></display:column>
					<display:column title="SALESINVOICENO"   sortable="true"></display:column>
					<display:column title="SALESINVOICENO" sortable="true"></display:column>
					<display:column title="LEDGERCODE"   sortable="true"></display:column>
					<display:column title="1STLEDGERNAMEPARTYLEDG"   sortable="true">Travelling Expense</display:column>
					<display:column title="CUSTOMERGSTINNO"   sortable="true"></display:column>
					<display:column title="PAYMENTMODE"   sortable="true"></display:column>
					<display:column title="PAYMENTREFNUMBER"   sortable="true"></display:column>
					<display:column title="CHEQUE_DD_DATE"   sortable="true"></display:column>
					<display:column title="ISSUE_ENTRYDATE"  sortable="true"></display:column>
					
					<display:column title="NARRATION"   sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="INVOICE_NETAMOUNT" style="text-align:right"   sortable="true"></display:column>
					<display:column title="2NDLEDGERNAME"   sortable="true">CASH</display:column>
					<display:column title="TTYPE"   sortable="true">+</display:column>
					<display:column title="PAIDAMOUNT"  style="text-align:right"  sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="SYSTEM_ENTRYDATE"  style="text-align:right" sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="TRAN_TYPE"   sortable="true"></display:column>  
					<display:column title="STATUS"   sortable="true"></display:column>  	
		 	
					<display:setProperty name="export.excel.filename" value="Rept_Tally_conveyance_Template.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Tally_conveyance_Template.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Tally_conveyance_Template.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_Tally_conveyance.jsp'> CLOSE</a>
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

