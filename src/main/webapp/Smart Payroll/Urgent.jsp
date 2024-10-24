<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
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
<%
String sql = "Select CHR_EMPID FROM pay_t_salaryallowance  WHERE CHR_MONTH='September' AND INT_YEAR=2007";
String alldata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
String empid = "";
if(alldata.length>1)
{
	for(int u=0;u<alldata.length;u++)
	{
		empid = alldata[u][0];
		sql = "Select A001,A002,A003,A004,A005,A006 FROM pay_t_allowance  WHERE CHR_EMPID='"+empid+"'";		
		String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			sql = " UPDATE pay_t_salaryallowance SET ";
			sql = sql+ " A001 = "+data[0][0] +" , ";
			sql = sql+ " A002 = "+data[0][1] +" , ";
			sql = sql+ " A003 = "+data[0][2] +" , ";
			sql = sql+ " A004 = "+data[0][3] +" , ";
			sql = sql+ " A005 = "+data[0][4] +" , ";
			sql = sql+ " A006 = "+data[0][5] +" WHERE CHR_MONTH='September' AND INT_YEAR=2007 AND CHR_EMPID='"+empid+"'";		
			com.my.org.erp.common.CommonFunctions.Execute(sql);

		}
	}
}	

out.println("Allowance Update<br>");





sql = "Select CHR_EMPID FROM pay_t_salaryrecovery  WHERE CHR_MONTH='September' AND INT_YEAR=2007";
String recdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
empid = "";
if(recdata.length>1)
{
	for(int u=0;u<recdata.length;u++)
	{
		empid = recdata[u][0];
		sql = "Select R001,R002 FROM pay_t_recovery  WHERE CHR_EMPID='"+empid+"'";		
		String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			sql = " UPDATE pay_t_salaryrecovery SET ";
			sql = sql+ " R001 = "+data[0][0] +" , ";
			sql = sql+ " R002 = "+data[0][1] +" WHERE CHR_MONTH='September' AND INT_YEAR=2007 AND CHR_EMPID='"+empid+"'";		
			com.my.org.erp.common.CommonFunctions.Execute(sql);
			
		}
	}
}	
out.println("Recovery Update<br>");
//pay_t_salaryrecovery,pay_t_salaryallowance,pay_t_salary
%>
</body>
</html>
