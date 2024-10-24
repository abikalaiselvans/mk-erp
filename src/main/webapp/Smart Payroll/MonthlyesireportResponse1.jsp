<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
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

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<%
	String sql="";
	String company="";
	String branch="";
	String Office="";
	String cpy="";
	String bra="";
	String off="";
	String Month="";
	String Year="";
	company = request.getParameter("company");
	branch = request.getParameter("branch");
	Office = request.getParameter("Office");
	Month = request.getParameter("Month");
	Year = request.getParameter("Year");
	String repmon = DateUtil.getMonth(Integer.parseInt( Month));
	if(!"-1".equals(branch))
		bra = " AND a.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		off = " AND a.INT_OFFICEID=  "+Office;
		
	sql = " SELECT b.CHR_EMPID,a.CHR_STAFFNAME, a.CHR_ESI,a.CHR_ESINO, b.DOU_WORKDAYS,";
	sql = sql +" b.DOU_BASIC,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,e.CHR_OFFICENAME ,floor(b.DOU_GROSSPAY),floor((b.DOU_ESI)), ";
	sql = sql +" floor((b.DOU_CPYESI)) FROM com_m_staff a, pay_t_salary b,com_m_company c,com_m_branch d, com_m_office  e ";
	sql = sql +" WHERE a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y' ";
	sql = sql +" AND b.CHR_EMPID=a.CHR_EMPID ";
	sql = sql +" AND a.INT_OFFICEID=  e.INT_OFFICEID ";
	sql = sql +" AND a.INT_COMPANYID= c.INT_COMPANYID ";
	sql = sql +" AND a.INT_BRANCHID= d.INT_BRANCHID ";
	sql = sql +" AND b.CHR_MONTH ='"+repmon+"' ";
	sql = sql +" AND b.INT_YEAR = "+Year;
	sql = sql +off;
	sql = sql +" AND a.INT_COMPANYID=  "+company;
	sql = sql +bra;
	//out.println(sql);
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String cpdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
	if(data.length>0)
	{
		out.println("<center> <table id='myTable' cellpadding=1 cellspacing=0   border=1 >");
		out.println("<tr><td class=\"boldEleven\" colspan=8><b><center> "+cpdata[0][0]+"</center>");
		out.println("<tr><td class=\"boldEleven\" colspan=8><b><center> ESI REPORT FOR THE MONTH OF "+repmon+"-"+Year+"</center>");
		out.println("<tr><td class=\"boldEleven\" ><b> S.No");
		out.println("<td class=\"boldEleven\" ><b> ESI Number");
		out.println("<td class=\"boldEleven\" ><b> Emp Name");
		out.println("<td class=\"boldEleven\" ><b> Office");
		out.println("<td class=\"boldEleven\" ><b> Wages");
		out.println("<td class=\"boldEleven\" ><b> Employee ESI(1.75%)");
		out.println("<td class=\"boldEleven\" ><b> Employer ESI(4.75%)");
		double sumA=0.0;
		double sumB=0.0;
		double sumC=0.0;
		for(int u=0;u<data.length;u++)
		{
			out.println("<tr>");
			out.println("<td class=\"boldEleven\" >"+(u+1));
			out.println("<td class=\"boldEleven\" >"+data[u][3].trim());
			out.println("<td class=\"boldEleven\" >"+data[u][1].trim());
			
			//if(!"C".equals(data[u][2].trim()))
				//out.println("<td class=\"boldEleven\" align=right>No");
			//else
				//out.println("<td class=\"boldEleven\" align=right>Common");
			
			
			/*if(!"C".equals(data[u][2].trim()))
			{
				out.println("<td class=\"boldEleven\" align=right>&nbsp;");
				out.println("<td class=\"boldEleven\" align=right>&nbsp;");
				out.println("<td class=\"boldEleven\" align=right>&nbsp;");
				out.println("<td class=\"boldEleven\" align=right>&nbsp;");
			}
			else
			{*/
				out.println("<td class=\"boldEleven\" >"+data[u][8].trim());
				out.println("<td class=\"boldEleven\" align=right>"+data[u][9].trim());
				sumA = sumA+Double.parseDouble(data[u][9]);
				out.println("<td class=\"boldEleven\" align=right>"+data[u][10].trim());
				sumB = sumB+Double.parseDouble(data[u][10]);
				out.println("<td class=\"boldEleven\" align=right>"+data[u][11].trim());
				sumC = sumC+Double.parseDouble(data[u][11]);
			/*}*/	
			
		}	
	 
		out.println("<tr>");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		//out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" align='right'><b>"+Math.round(sumA));
		out.println("<td class=\"boldEleven\" align='right'><b>"+Math.round(sumB));
		out.println("<td class=\"boldEleven\" align='right'><b>"+Math.round(sumC));
		 out.println("</table></center>");
	}
	else
	{
		out.println("<center> <table id='myTable' cellpadding=5 cellspacing=1   border=1 >");
		out.println("<tr><td class=\"boldEleven\" colspan=12><b><center>Data not found</center>");
		out.println("</table></center>");
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
