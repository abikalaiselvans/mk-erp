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
		
	sql = " SELECT b.CHR_EMPID,a.CHR_STAFFNAME, a.CHR_PF,a.CHR_PFNO , ";
	sql = sql +" b.DOU_WORKDAYS,b.DOU_BASIC,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,e.CHR_OFFICENAME  ";
	sql = sql +" FROM com_m_staff a, pay_t_salary b,com_m_company c,com_m_branch d, com_m_office  e ";
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
		out.println("<tr><td class=\"boldEleven\" colspan=13><b><center> "+cpdata[0][0]+"</center>");
		out.println("<tr><td class=\"boldEleven\" colspan=13><b><center> PF REPORT FOR THE MONTH OF "+repmon+"-"+Year+"</center>");
		out.println("<tr><td class=\"boldEleven\" ><b> S.No");
		out.println("<td class=\"boldEleven\" ><b> Emp Name");
		out.println("<td class=\"boldEleven\" ><b> Office");
		out.println("<td class=\"boldEleven\" ><b> PF Number");
		out.println("<td class=\"boldEleven\" ><b> PF Wages");
		out.println("<td class=\"boldEleven\" ><b> Pen Wages");
		out.println("<td class=\"boldEleven\" ><b> Employee Contri(12%)");
		out.println("<td class=\"boldEleven\" ><b> Employer PF Contri(3.67%)");
		out.println("<td class=\"boldEleven\" ><b> Employer Pension Contri(8.33%)");
		out.println("<td class=\"boldEleven\" ><b> Admin Charges(1.1%)");
		out.println("<td class=\"boldEleven\" ><b> EDLI Charges(0.5%)");
		out.println("<td class=\"boldEleven\" ><b> ADMIN Charges(0.01%)");
		double A=0.0;
		double B=0.0;
		double C=0.0;
		double D=0.0;
		double E=0.0;
		double F=0.0;
		double G=0.0;
		double H=0.0;
		double SUMA=0.0;
		double SUMB=0.0;
		double SUMC=0.0;
		double SUMD=0.0;
		double SUME=0.0;
		double SUMF=0.0;
		double SUMG=0.0;
		double SUMH=0.0;
		double basic=0.0;
		double d1=0.0;
		
		for(int u=0;u<data.length;u++)
		{
			
			out.println("<tr>");
			basic=0.0;
			d1=0.0;
			out.println("<td class=\"boldEleven\" >"+(u+1));
			out.println("<td class=\"boldEleven\" >"+data[u][1].trim());
			out.println("<td class=\"boldEleven\" >"+data[u][8].trim());
			out.println("<td class=\"boldEleven\" >"+data[u][3].trim());
			basic=Math.round(Double.parseDouble(data[u][5].trim()));
			A = basic;
			B = basic;
			 
			out.println("<td class=\"boldEleven\" align='right'>"+(basic));
			if(basic>6500)
			{
				out.println("<td class=\"boldEleven\" align='right'>6500");
				B=6500;
			}	
			else
			{
				out.println("<td class=\"boldEleven\" align='right'>"+basic);
			}
				
			C=Double.parseDouble(MathFunction.keep2Digit((A*0.12)));
			out.println("<td class=\"boldEleven\" align='right'>"+C);
			
			E= Double.parseDouble(MathFunction.keep2Digit((8.33/100)*B	));
			D= Double.parseDouble(MathFunction.keep2Digit((3.67/100)*A	));
			
			if(basic>6500)
			{
				E=541;
				d1 =Double.parseDouble(MathFunction.keep2Digit(((8.33/100)*A	)-E));
				out.println("<td class=\"boldEleven\" align='right'> "+CommonFunctions.Round(D+d1));//("+(D+"+"+d1)+")
			}
			else
			{
				out.println("<td class=\"boldEleven\" align='right'>"+D);
			}
			
			
			
			out.println("<td class=\"boldEleven\" align='right'>"+E);
			
			F= CommonFunctions.Round((1.1/100)*A	);
			out.println("<td class=\"boldEleven\" align='right'>"+F);
			
			G= CommonFunctions.Round((0.5/100)*B	);
			out.println("<td class=\"boldEleven\" align='right'>"+G);
			
			H= CommonFunctions.Round((0.01/100)*B	);
			out.println("<td class=\"boldEleven\" align='right'>"+H);
			SUMA=SUMA+A;
			SUMB=SUMB+B;
			SUMC=SUMC+C;
			SUMD=SUMD+D;
			SUME=SUME+E;
			SUMF=SUMF+F;
			SUMG=SUMG+G;
			SUMH=SUMH+H;
		}
		out.println("<tr>");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" >&nbsp;");
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMA));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMB));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMC));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMD));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUME));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMF));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMG));
		out.println("<td class=\"boldEleven\" align='right'><b>"+CommonFunctions.Round(SUMH));	
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
<%
/*java.text.NumberFormat f = new java.text.DecimalFormat("0.00");
out.println(f.format(1.5555));
out.println(f.format(1.0001));
java.util.Locale[] locales=com.my.org.erp.General.General.CountryNames();
for (int i = 0; i < locales.length; i++) 
{
	String iso = locales[i].getCountry();
	String name = locales[i].getDisplayCountry();
	out.println(iso+"<br>");
}*/			
%>
<%@ include file="../footer.jsp"%>
</body>
</html>
