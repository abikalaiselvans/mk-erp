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
 		
		String division= request.getParameter("division");
		String type = request.getParameter("type");
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String customerid = request.getParameter("customerid");
		String branchid = request.getParameter("branchid");
		String reportheader=" SALES FLOW -"+CommonFunctions.QueryExecute("SELECT CHR_DIVICODE FROM inv_m_division WHERE   INT_DIVIID="+division)[0][0] + "/"+month+"-"+year; 
	 	String sql ="  ";
		if("1".equals(type) )
		{
			sql = "  SELECT CONCAT('SALES'),FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch, ";
			sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) division,  ";
			sql = sql + "  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql + "  MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE), ";
			sql = sql + "  DOU_AMOUNT,DOU_TAXAMOUNT, a.DOU_TOTALAMOUNT   amount ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)   ";
			sql = sql + "  FROM inv_t_directsales a  ";
			sql = sql + "  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql + "  AND MONTHNAME(a.DAT_SALESDATE) ='"+month+"' ";
			sql = sql + "  AND YEAR(a.DAT_SALESDATE) ="+year;
			sql = sql + "  AND a.INT_CUSTOMERID = "+customerid;
			sql = sql + "  AND a.INT_DIVIID ="+division;
			sql = sql + "  AND a.INT_BRANCHID ="+branchid;
			sql = sql + "  ORDER BY  a.DAT_SALESDATE ";
			
  			
		}
		else if("2".equals(type))
		{
		
			sql = "  SELECT CONCAT('SERVICE'),FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch,  ";
			sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) division,   ";
			sql = sql + "  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),  ";
			sql = sql + "  MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE),  ";
			sql = sql + "  DOU_AMOUNT,DOU_SERVICE_AMOUNT, a.DOU_NETAMOUNT   amount ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)   "; 
			sql = sql + "  FROM inv_t_servicebilling a   ";
			sql = sql + "  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1   ";
			sql = sql + "  AND MONTHNAME(a.DAT_SALESDATE) ='"+month+"' ";
			sql = sql + "  AND YEAR(a.DAT_SALESDATE) ="+year;
			sql = sql + "  AND a.INT_CUSTOMERID = "+customerid;
			sql = sql + "  AND a.INT_DIVIID ="+division;
			sql = sql + "  AND a.INT_BRANCHID ="+branchid;
			sql = sql + "  ORDER BY  a.DAT_SALESDATE ";
			 
  

		}
		else if("0".equals(type))
		{
		
		
			sql = "( ";
			sql = sql + "  SELECT CONCAT('SALES'),FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch, ";
			sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) division,  ";
			sql = sql + "  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql + "  MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE), ";
			sql = sql + "  DOU_AMOUNT,DOU_TAXAMOUNT, a.DOU_TOTALAMOUNT   amount ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)   ";
			sql = sql + "  FROM inv_t_directsales a  ";
			sql = sql + "  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
			sql = sql + "  AND MONTHNAME(a.DAT_SALESDATE) ='"+month+"' ";
			sql = sql + "  AND YEAR(a.DAT_SALESDATE) ="+year;
			sql = sql + "  AND a.INT_CUSTOMERID = "+customerid;
			sql = sql + "  AND a.INT_DIVIID ="+division;
			sql = sql + "  AND a.INT_BRANCHID ="+branchid;
			sql = sql + "  ORDER BY  a.DAT_SALESDATE "; 
			sql = sql + "  )";
			
			sql = sql + " UNION ";
			sql = sql + " (   ";
			sql = sql + "  SELECT CONCAT('SERVICE'),FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch,  ";
			sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) division,   ";
			sql = sql + "  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),  ";
			sql = sql + "  MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE),  ";
			sql = sql + "  DOU_AMOUNT,DOU_SERVICE_AMOUNT, a.DOU_NETAMOUNT   amount ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)   "; 
			sql = sql + "  FROM inv_t_servicebilling a   ";
			sql = sql + "  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1   ";
			sql = sql + "  AND MONTHNAME(a.DAT_SALESDATE) ='"+month+"' ";
			sql = sql + "  AND YEAR(a.DAT_SALESDATE) ="+year;
			sql = sql + "  AND a.INT_CUSTOMERID = "+customerid;
			sql = sql + "  AND a.INT_DIVIID ="+division;
			sql = sql + "  AND a.INT_BRANCHID ="+branchid;
			sql = sql + "  ORDER BY  a.DAT_SALESDATE ";
			 
			sql = sql + "    ) ";

		}
		
		// out.println(sql);
 		
		 
		String data[][] =  CommonFunctions.QueryExecute(sql);
		Vector mn = new Vector();
	 	Vector child= null;
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement("<a target='_blank' href='SwapSaleSerialView.jsp?salno="+data[u][4]+"'>Details</a>");
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				mn.add(child); 
			}
		} 
		request.setAttribute("table",mn);
		 
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
		<display:caption><%=reportheader.toUpperCase()%></display:caption>
		<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
		<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
		<display:column title="TYPE"   sortable="true"><%=temp.elementAt(1)%></display:column>
		<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(2)%></display:column>
		<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(3)%></display:column>
		<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(4)%></display:column>
		<display:column title="INVOICE"    sortable="true"><%=temp.elementAt(5)%></display:column>
		<display:column title="DETAILS" media ='html'   sortable="true"><%=temp.elementAt(6)%></display:column>
		<display:column title="DATE"   sortable="true"><%=temp.elementAt(7)%></display:column>
		<display:column title="MONTH"   sortable="true"><%=temp.elementAt(8)%></display:column>
		<display:column title="YEAR"   sortable="true"><%=temp.elementAt(9)%></display:column>
		<display:column title="AMOUNT"   sortable="true"><%=temp.elementAt(10)%></display:column>
		<display:column title="Tax AMOUNT"   sortable="true"><%=temp.elementAt(11)%></display:column>
		<display:column title="NET AMOUNT"   sortable="true"><%=temp.elementAt(12)%></display:column>
		<display:column title="M.E"   sortable="true"><%=temp.elementAt(13)%></display:column>
		
		<display:setProperty name="export.excel.filename" value="Rept_Flow.xls"/>
		<display:setProperty name="export.pdf.filename" value="Rept_Flow.pdf"/>
		<display:setProperty name="export.csv.filename" value="Rept_Flow.csv"/>
		<display:setProperty name="export.pdf"  value="true" />
		 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>

