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


 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<%
try
{
	String sql="";
	String company="";
	String branch="";
	String Office="";
	String cpy="";
	String bra="";
	String off="";
	String orderby="";
	 
	company = request.getParameter("company");
	branch = request.getParameter("branch");
	Office = request.getParameter("Office");
	orderby = request.getParameter("orderby");
	
	if(!"-1".equals(branch))
		bra = " AND a.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		off = " AND a.INT_OFFICEID=  "+Office;
	
	sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,DATE_FORMAT(a.DT_DOB,'%e-%M-%Y'), ";
	sql = sql +" b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,a.CHR_EMAILID,a.CHR_MOBILE,a.CHR_ESINO  ";
	sql = sql +" FROM  com_m_staff  a,com_m_company b,com_m_branch c, com_m_office  d ";
	sql = sql +" WHERE a.INT_COMPANYID= b.INT_COMPANYID ";
	sql = sql +" AND a.INT_BRANCHID= c.INT_BRANCHID ";
	sql = sql +" AND a.INT_OFFICEID=d.INT_OFFICEID ";
	sql = sql +" AND a.INT_COMPANYID=  "+company;
	sql = sql +bra;
	sql = sql +off;
	sql = sql +" ORDER BY  "+orderby;

	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String cpdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
	if(data.length>0)
	{
		out.println("<center> <table   id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" colspan=13><b><center> "+cpdata[0][0]+"</center>");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" colspan=13><b><center> ESI NUMBER REPORT </center>");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" ><b> S.No");
		out.println("<td class=\"boldEleven\" ><b> Employee Id");
		out.println("<td class=\"boldEleven\" ><b> Employee Name");
		out.println("<td class=\"boldEleven\" ><b> Father Name");
		out.println("<td class=\"boldEleven\" ><b> Date of Birth");
		out.println("<td class=\"boldEleven\" ><b> Company");
		out.println("<td class=\"boldEleven\" ><b> Branch");
		out.println("<td class=\"boldEleven\" ><b> Office");
		out.println("<td class=\"boldEleven\" ><b> Emailid");
		out.println("<td class=\"boldEleven\" ><b> Mobile");
		out.println("<td class=\"boldEleven\" ><b> ESI Number");
		 

		for(int u=0;u<data.length;u++)
		{
			out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" >"+(u+1));
			out.println("<td class=\"boldEleven\" >"+data[u][0]);
			out.println("<td class=\"boldEleven\" >"+data[u][1]);
			out.println("<td class=\"boldEleven\" >"+data[u][2]);
			out.println("<td class=\"boldEleven\" >"+data[u][3]);
			out.println("<td class=\"boldEleven\" >"+data[u][4]);
			out.println("<td class=\"boldEleven\" >"+data[u][5]);
			out.println("<td class=\"boldEleven\" >"+data[u][6]);
			out.println("<td class=\"boldEleven\" >"+data[u][7]);
			out.println("<td class=\"boldEleven\" >"+data[u][8]);
			out.println("<td class=\"boldEleven\" >"+data[u][9]);
		}
		out.println("</table></center>");
	}
	else
	{
		out.println("<center> <table id='myTable' cellpadding=5 cellspacing=1   border=1 >");
		out.println("<tr><td class=\"boldEleven\" colspan=12><b><center>Data not found</center>");
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
			onClick="windowSave('ESINumber.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('ESINumber.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('ESINumber.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>

<br>
 
<%@ include file="../footer.jsp"%>
</body>
</html>
