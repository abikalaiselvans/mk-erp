<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
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


<title> :: PAYROLL ::</title>


 
</head>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>
  <%
try
{
	String staffid=request.getParameter("staffid");
	String year=request.getParameter("year");
	String staffname=request.getParameter("staffname");
	
	String sql="";
	sql="SELECT DOU_BONUS FROM m_institution WHERE INT_ID=1";
	String bonuspercentage[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
	sql = " SELECT CHR_MONTH,INT_YEAR, DOU_WORKDAYS, DOU_BASIC FROM pay_t_salary WHERE ";
	sql = sql + " INT_YEAR IN ("+year+") AND CHR_MONTH IN('April','May','June','July','August', 'September','October'";
	sql = sql + " , 'November', 'December') AND CHR_EMPID ='"+staffid+"' ";
	String amount1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
	sql = " SELECT CHR_MONTH,INT_YEAR, DOU_WORKDAYS, DOU_BASIC FROM pay_t_salary WHERE ";
	sql = sql + " INT_YEAR IN ("+(Integer.parseInt(year)+1)+") AND CHR_MONTH IN('January', 'February', 'March' )";
	sql = sql + "AND CHR_EMPID ='"+staffid+"' ";
	String amount2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	out.println("<center><table id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'><tr  bgcolor='#ffffff'><td colspan=5 class='boldEleven' align='center'><b> BONUS REPORT FOR THE YEAR "+year +" - "+(Integer.parseInt(year)+1) +" ");
	
	out.println("<tr  bgcolor='#ffffff'><td colspan=5 class='boldEleven' align='center'><b> Emp Id :: "+staffid+"/  Emp Name :: "+staffname);
	out.println("<tr  bgcolor='#ffffff'>");
	out.println("<td class='boldEleven'><b>S.No");
	out.println("<td class='boldEleven'><b>Month");
	out.println("<td class='boldEleven'><b>Year");
	out.println("<td class='boldEleven'><b>No of Working days");
	out.println("<td class='boldEleven'><b>Basic");
	double sum=0;
	if(amount1.length>0)
	for(int u=0;u<amount1.length;u++)
	{
		if(u%2 == 0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'>"+(u+1));
		out.println("<td class='boldEleven'>"+amount1[u][0]);
		out.println("<td class='boldEleven' align='right'>"+amount1[u][1]);
		out.println("<td class='boldEleven' align='right'>"+amount1[u][2]);
		out.println("<td class='boldEleven' align='right'>"+amount1[u][3]);
		sum = sum+Double.parseDouble(amount1[u][3]);
	}
	
	if(amount2.length>0)
	for(int u=0;u<amount2.length;u++)
	{
		if(u%2 == 0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'>"+(u+1));
		out.println("<td class='boldEleven'>"+amount2[u][0]);
		out.println("<td class='boldEleven' align='right'>"+amount2[u][1]);
		out.println("<td class='boldEleven align='right''>"+amount2[u][2]);
		out.println("<td class='boldEleven' align='right'>"+amount2[u][3]);
		sum = sum+Double.parseDouble(amount2[u][3]);
			
	}
	out.println("<tr  bgcolor='#ffffff'><td colspan=4 class='boldEleven' align='right'><b>Total Basic");
	out.println("<td class='boldEleven' align='right'>"+sum);
	
	out.println("<tr  bgcolor='#ffffff'><td colspan=4 class='boldEleven' align='right'><b>Bonus Amount");
	out.println("<td class='boldEleven' align='right'>"+Math.round(sum/Double.parseDouble(bonuspercentage[0][0])));
	out.println("</table></center>");
}
catch(Exception e)
{
}
%>
</p>
</body>
</html>
