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
	
	 
 
String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY CHR_ACODE");
String salaryband="   ";
for(int u=0; u<AllowanceData.length;u++)
	salaryband = salaryband+"  a."+AllowanceData[u][0]+"+ "; 
salaryband=salaryband.trim();
salaryband = salaryband.substring(0,salaryband.length()-1);			


sql =  "SELECT a.INT_RIVISIONID,a.CHR_EMPID,b.CHR_STAFFNAME, ";
sql = sql +" d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_CATEGORYNAME,b.CHR_REPTO, ";
sql = sql +" a.INT_BASIC,a.INT_INCREMENT,("+salaryband+"), ";
sql = sql +" (a.INT_BASIC+a.INT_INCREMENT+"+salaryband+"), ";
sql = sql +" DATE_FORMAT(a.DAT_EFFECT,'%d-%b-%Y'),a.CHR_MONTH,a.INT_YEAR,b.CHR_TYPE , ";
sql = sql +" DATE_FORMAT(b.DT_DOJCOLLEGE,'%d-%b-%Y'), datediff(now(),b.DT_DOJCOLLEGE)/365, ";
sql = sql +" (select  DATE_FORMAT(DATE_ADD(a.DAT_EFFECT, INTERVAL 365 DAY),'%d-%b-%Y')) ";

sql = sql +" FROM pay_t_rivision a ,com_m_staff b , com_m_office  d,com_m_depart e, com_m_employeecategory  f ";
sql = sql +" WHERE a.CHR_EMPID= b.CHR_EMPID  ";
sql = sql +" AND b.INT_OFFICEID = d.INT_OFFICEID ";
sql = sql +" AND b.INT_DEPARTID  = e.INT_DEPARTID ";
sql = sql +" AND b.CHR_CATEGORY= f.INT_EMPLOYEECATEGORYID ";
sql = sql +" AND b.INT_COMPANYID=  "+company;
if(!"-1".equals(branch))
		sql = sql +"  AND b.INT_BRANCHID=  "+branch;
if(!"0".equals(Office))
		sql = sql +"  AND b.INT_OFFICEID=  "+Office;
sql = sql +" AND a.INT_YEAR= "+Year;
sql = sql +" AND a.CHR_MONTH='"+repmon+"' ";                
sql = sql +" ORDER BY b.CHR_STAFFNAME  ";
//out.println(sql); 

	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String cpdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
	if(data.length>0)
	{
		out.println("<center> <table width='90%'   id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" colspan=30><b><center> "+cpdata[0][0]+"</center>");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" colspan=30><b><center> REVISION REPORT FOR THE MONTH OF "+repmon+"-"+Year+"</center>");
		out.println("<tr bgcolor='#ffffff'><td class=\"boldEleven\" ><b> S.No");
		out.println("<td class=\"boldEleven\" ><b> Emp Id");
		out.println("<td class=\"boldEleven\" ><b> Name");
		out.println("<td class=\"boldEleven\" ><b> Office");
		out.println("<td class=\"boldEleven\" ><b> Depat");
		out.println("<td class=\"boldEleven\" ><b> Category");
		out.println("<td class=\"boldEleven\" ><b> Reporting To");
		
		out.println("<td class=\"bolddeepred\" ><b> Last Effective Date");
		out.println("<td class=\"bolddeepred\" ><b> Last Basic");
		out.println("<td class=\"bolddeepred\" ><b> Last Increment");
		out.println("<td class=\"bolddeepred\" ><b> Last Allowance");
		out.println("<td class=\"bolddeepred\" ><b> Last Gross");
		 
		
		out.println("<td class=\"boldEleven\" ><b> Basic");
		out.println("<td class=\"boldEleven\" ><b> Increment");
		out.println("<td class=\"boldEleven\" ><b> Allowance");
		out.println("<td class=\"boldEleven\" ><b> Gross");
		out.println("<td class=\"boldEleven\" ><b> Effective Date");
		out.println("<td class=\"boldEleven\" ><b> Month");
		out.println("<td class=\"boldEleven\" ><b> Year");
		out.println("<td class=\"boldEleven\" ><b> Type");
		out.println("<td class=\"boldEleven\" ><b> Date of Joinning");
		out.println("<td class=\"boldEleven\" ><b> Year of Exp");
		 out.println("<td class=\"boldEleven\" ><b> Next Effective Date");
		
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1'><td class=\"boldEleven\" >"+(u+1));
			else
				out.println("<tr class='MRow2'><td class=\"boldEleven\" >"+(u+1));	
				
			if("T".equals(data[u][14]))
				out.println("<td class=\"boldEleven\" >"+data[u][1]+"<font class='bolddeepred'>***</font>");
			else
				out.println("<td class=\"boldEleven\" >"+data[u][1]);	
				
				
			out.println("<td class=\"boldEleven\" >"+data[u][2]);
			out.println("<td class=\"boldEleven\" >"+data[u][3]);
			out.println("<td class=\"boldEleven\" >"+data[u][4]);
			out.println("<td class=\"boldEleven\" >"+data[u][5]);
			out.println("<td class=\"boldEleven\" >"+data[u][6]);
			
			//Last effective Date
			if(Integer.parseInt(data[u][0]) >1)
			{
				
				sql = "  SELECT  DATE_FORMAT(a.DAT_EFFECT,'%d-%b-%Y'), a.INT_BASIC,a.INT_INCREMENT,("+salaryband+"), ";
				sql = sql+ "(a.INT_BASIC+a.INT_INCREMENT+"+salaryband+")  FROM pay_t_rivision a ,com_m_staff b  ";
				sql = sql +" WHERE a.CHR_EMPID= b.CHR_EMPID  AND a.CHR_EMPID='"+data[u][1]+"'  AND a.INT_RIVISIONID= "+(Integer.parseInt(data[u][0])-1);
				//out.println(sql);
				String pdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.println("<td class=\"boldEleven\"  bgcolor='#6666CC'>"+pdata[0][0]);
				out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][1]);
				out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][2]);
				out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][3]);
				out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][4]);
			}
			else
			{
				out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
				out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
				out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
				out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
				out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
			}
			
			out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][7]);
			out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][8]);
			out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][9]);
			out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][10]);
			out.println("<td class=\"boldEleven\" >"+data[u][11]);
			out.println("<td class=\"boldEleven\" >"+data[u][12]);
			out.println("<td class=\"boldEleven\" >"+data[u][13]);
			
			if("T".equals(data[u][14]))
				out.println("<td class=\"boldEleven\"   align=right>Resigned");
			else
				out.println("<td class=\"boldEleven\"   align=right>&nbsp;");
				
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][15]);
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][16]);
			out.println("<td class=\"boldEleven\"   align=right>"+data[u][17]);
	
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
<!--<table width="184" align="center" cellpadding="15" cellspacing="0">
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

--><br>
 
<%@ include file="../footer.jsp"%>
</body>
</html>
