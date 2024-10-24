<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
<jsp:directive.page import="com.my.org.erp.SmartInventory.Product" />
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<meta http-equiv="pragma" content="nocache">
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvStockAjax.js"></script>

<body    >
<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>
	  <%
	  try
	  {
		String id = request.getParameter("id");
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String sql="";
		sql="";
		sql =" SELECT d.CHR_NAME,e.CHR_DIVICODE,a.CHR_SALESORDERNO ,a.DOU_PAIDAMOUNT,";
		sql = sql+" b.DOU_TOTALAMOUNT,DATE_FORMAT(b.DAT_SALESDATE ,'%d-%b-%Y'),"; 
		sql = sql+" DATE_FORMAT(a.DAT_PAYMENTDATE ,'%d-%b-%Y'),DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE),f.CHR_STAFFNAME,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ";
		sql = sql+"  FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d, ";
		sql = sql+"  inv_m_division e  , com_m_staff f";
		sql = sql+"  WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO "; 
		sql = sql+"  AND b.INT_CUSTOMERID = c.INT_CUSTOMERID AND b.CHR_REF = f.CHR_EMPID";
		sql = sql+"  AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID   AND e.INT_DIVIID=b.INT_DIVIID "; 
		sql = sql+ " AND a.INT_BRANCHID= "+Branch;
		
		if(!"0".equals(division))
			sql = sql+ " AND b.INT_DIVIID= "+division;
		else
			sql = sql+" AND b.INT_DIVIID IN(1,2,3,4) ";	
		
		sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
		sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
		sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+id;
		
		 
		
		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		out.println("<table width='90%'  id='myTable' class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center' >");
		if(data.length>0)
		{
			
			 
			out.println("<tr bgcolor='#ffffff'><td colspan=10><center><font class='boldEleven'><b>AVERAGE COLLECTION  ("+com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month))+" - "+year+" )  Report </b></font></center></td>");
			out.println("<td><a title=\"Excel\" href=javascript:;	onClick=\" CreateExcelSheet()\">Export</a></td>");
			out.println("<Tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No</b></td><td class='boldEleven'><b>Customer Group</b></td>");
			out.println("<td class='boldEleven'><b>Customer Name</b></td>");
			out.println("<td class='boldEleven'><b>Division</b></td>");
			out.println("<td class='boldEleven'><b>INVOICE No</b></td>");
			out.println("<td class='boldEleven'><b>INV Amount</b></td>");
			out.println("<td class='boldEleven'><b>Paid Amount</b></td>");
			out.println("<td class='boldEleven'><b>INV Date</b></td>");
			out.println("<td class='boldEleven'><b>Paid Date</b></td>");
			out.println("<td class='boldEleven'><b>Days Left</b></td>");
			out.println("<td class='boldEleven'><b>Emp Ref</b></td>");
			
			for(int u=0;u<data.length;u++)
			{
				out.println("<tr  bgcolor='#ffffff' ><td class='boldEleven'>"+(u+1));	
				out.println("<td class='boldEleven'>"+data[u][0].trim());
				out.println("<td class='boldEleven'>"+data[u][9].trim());
				out.println("<td class='boldEleven'>"+data[u][1].trim());
				out.println("<td class='boldEleven'>"+data[u][2].trim());
				out.println("<td class='boldEleven' align='right'>"+data[u][3].trim());
				out.println("<td class='boldEleven' align='right'>"+data[u][4].trim());
				out.println("<td class='boldEleven'>"+data[u][5].trim());
				out.println("<td class='boldEleven'>"+data[u][6].trim());
				out.println("<td class='boldEleven' align='right'>"+data[u][7].trim());
				out.println("<td class='boldEleven' >"+data[u][8].trim());
			}
		}
		else
		{
			out.println("<tr  bgcolor='#ffffff'><td colspan=10><center><font class='boldred'>Data not found...</font></center></td>");
		}
		out.println("</table>");
	  }
	  catch(Exception e)
	  {
	  	out.println(e.getMessage());
	  }
		
	   %>
</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>
			  </td>
  </tr>
  <tr>
	  <td height="20">&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
