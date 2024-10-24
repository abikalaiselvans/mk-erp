
<%
try
{
%>

<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
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


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<%
try
{
	
	 
	String company = request.getParameter("company");
	String branch=request.getParameter("branch");
	String Office=request.getParameter("Office");
	String Category = request.getParameter("Category");
	String dept=request.getParameter("dept");
	String month=request.getParameter("month");
	
	 
	 
	 String sql="";
 
		  
	sql = " SELECT CHR_EMPID,CHR_STAFFNAME,DT_DOJCOLLEGE ,((datediff(now(),DT_DOJCOLLEGE))/365) ";
	sql = sql +" FROM com_m_staff WHERE CHR_TYPE!='T' AND CHR_HOLD !='Y'  ";
	if("-1".equals(company))
		sql = sql +" AND INT_COMPANYID ="+company;
	if("-1".equals(branch))
		sql = sql +" AND INT_BRANCHID ="+branch;
	
	if("0".equals(Office))
		sql = sql +" AND INT_OFFICEID ="+Office;
	
	if("0".equals(dept))
		sql = sql +" AND INT_DEPARTID ="+dept;
	
	if("0".equals(Category))
		sql = sql +" AND CHR_CATEGORY ='"+Category+"' ";
	
	if("0".equals(month))
		sql = sql +" AND MONTH(DT_DOJCOLLEGE) ="+month;
	
	out.println(sql);
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data.length>0)
	{
		out.println("<center> <table width='90%'   id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		 
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" colspan=30><b><center> EMPLOYEE EXPEIRENCE LIST</center>");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" ><b> S.No");
		out.println("<td class=\"boldEleven\" ><b> Emp Id");
		out.println("<td class=\"boldEleven\" ><b> Name");
		out.println("<td class=\"boldEleven\" ><b> Date of Joinning");
		out.println("<td class=\"boldEleven\" ><b> Experience ");
		 
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'><td class=\"boldEleven\" >"+(u+1));
			else
				out.println("<tr class='MRow2'><td class=\"boldEleven\" >"+(u+1));	
			 
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][0]);
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][1]);
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][2]);
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][3]);
			out.println("</tr >");
			 
		}
		out.println("</table></center>");
	}
	else
	{
		out.println("<center> <table id='myTable' cellpadding=5 cellspacing=1   border=1 >");
		out.println("<tr><td class=\"boldEleven\" colspan=10><b><center>Data not found</center>");
		out.println("</table></center>");
	}	
	
}
catch(Exception e)
{
}	
%>

 
<br>
<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('Monthlypf.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Monthlypf.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Monthlypf.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>

<br>
 
<%@ include file="../footer.jsp"%>
</body>
</html>

<%
}
catch(Exception e)
{
	
}
%>
