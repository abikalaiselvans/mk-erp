<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html xmlns="http://www.w3.org/1999/xhtml">
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
<p>
  <%@ include file="index.jsp"%>
  <br>

 <%
		int byear=0,cyear=0;
		String form2A="0.00",form3A="0.00",form4A="0.00",form4bA="0.00";
		String form2M="0.00",form3M="0.00",form4M="0.00",form4bM="0.00";
		String form2J="0.00",form3J="0.00",form4J="0.00",form4bJ="0.00";
		String form2L="0.00",form3L="0.00",form4L="0.00",form4bL="0.00";
		String form2U="0.00",form3U="0.00",form4U="0.00",form4bU="0.00";
		String form2S="0.00",form3S="0.00",form4S="0.00",form4bS="0.00";
		String form2O="0.00",form3O="0.00",form4O="0.00",form4bO="0.00";
		String form2N="0.00",form3N="0.00",form4N="0.00",form4bN="0.00";
		String form2D="0.00",form3D="0.00",form4D="0.00",form4bD="0.00";
		String form21="0.00",form31="0.00",form41="0.00",form4b1="0.00";
		String form2F="0.00",form3F="0.00",form4F="0.00",form4bF="0.00";
		String form2R="0.00",form3R="0.00",form4R="0.00",form4bR="0.00";
		String cyend="",byend="";
		 
		double form2t=0.00,form3t=0.00,form4t=0.00,form4bt=0.00;
		String comid=request.getParameter("company");
		String branchid=request.getParameter("branch");
		String officeid=request.getParameter("Office");
		String year=request.getParameter("Year");
		String cpy  ="";
		String bid  ="";
		String off="";
		String yer="";
		if(!"-1".equals(comid))
			cpy =" AND b.INT_COMPANYID = "+comid;
		
		if(!"-1".equals(branchid))
			bid ="  AND b.INT_BRANCHID = "+branchid;
		
		if(!"0".equals(officeid))
			off ="  AND b.INT_OFFICEID = "+officeid;
		byear=(Integer.parseInt(year)-1);
		cyear=Integer.parseInt(year);
		cyend=year.substring(2,4);
		byend=((""+byear).trim()).substring(2,4);
			String sql="";
	sql=" SELECT b.CHR_EMPID, b.CHR_PFNO,a.CHR_EMPNAME ";
	sql = sql+"	FROM  com_m_staff b,pay_t_salary a ";                               
	sql = sql+"	WHERE b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y'";
	sql = sql+"	"+cpy;
	sql = sql+"	"+bid;
	sql = sql+"	"+ off;
	sql = sql+" AND a.CHR_EMPID=b.CHR_EMPID group BY a.CHR_EMPID";
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
	sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
	sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
	sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
	sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
	sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
	sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
	sql = sql + " AND a.INT_COMPANYID="+comid;
	String datac[][]=CommonFunctions.QueryExecute(sql);
	
	  
	for(int i=0;i<data.length;i++)
	{
	
		form2A="0.00";form3A="0.00";form4A="0.00";form4bA="0.00";
		form2M="0.00";form3M="0.00";form4M="0.00";form4bM="0.00";
		form2J="0.00";form3J="0.00";form4J="0.00";form4bJ="0.00";
		form2L="0.00";form3L="0.00";form4L="0.00";form4bL="0.00";
		form2U="0.00";form3U="0.00";form4U="0.00";form4bU="0.00";
		form2S="0.00";form3S="0.00";form4S="0.00";form4bS="0.00";
		form2O="0.00";form3O="0.00";form4O="0.00";form4bO="0.00";
		form2N="0.00";form3N="0.00";form4N="0.00";form4bN="0.00";
		form2D="0.00";form3D="0.00";form4D="0.00";form4bD="0.00";
		form21="0.00";form31="0.00";form41="0.00";form4b1="0.00";
		form2F="0.00";form3F="0.00";form4F="0.00";form4bF="0.00";
		form2R="0.00";form3R="0.00";form4R="0.00";form4bR="0.00";
	
	
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='Apirl' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data1.length>0)
	{
	   form2A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][1]));form3A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][2]));form4A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][3]));form4bA=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='May' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data2.length>0)
	{
	   form2M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][1]));form3M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][2]));form4M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][3]));form4bM=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='June' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data3[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data3.length>0)
	{
	   form2J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][1]));form3J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][2]));form4J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][3]));form4bJ=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='July' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data4[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data4.length>0)
	{
	   form2L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][1]));form3L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][2]));form4L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][3]));form4bL=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='August' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data5[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data5.length>0)
	{
	   form2U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][1]));form3U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][2]));form4U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][3]));form4bU=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='September' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data6[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data6.length>0)
	{
	   form2S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][1]));form3S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][2]));form4S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][3]));form4bS=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='October' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data7[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data7.length>0)
	{
	   form2O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][1]));form3O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][2]));form4O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][3]));form4bO=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='November' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data8[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data8.length>0)
	{
	   form2N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][1]));form3N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][2]));form4N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][3]));form4bN=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='December' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
	String data9[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data9.length>0)
	{
	   form2D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][1]));form3D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][2]));form4D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][3]));form4bD=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='January' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
	String data10[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data10.length>0)
	{
	   form21=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][1]));form31=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][2]));form41=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][3]));form4b1=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='February' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
	String data11[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data11.length>0)
	{
	   form2F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][1]));form3F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][2]));form4F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][3]));form4bF=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][4])); 
	}
	sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
	sql = sql+"	FROM pay_t_salary a ";                               
	sql = sql+"	WHERE a.CHR_EMPID ='"+data[i][0]+"' ";
	sql = sql+" AND a.CHR_MONTH ='March' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
	String data12[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data12.length>0)
	{
	   form2R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][1]));form3R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][2]));form4R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][3]));form4bR=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][4])); 
	}
	out.println("<table width='649' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#999999'>");
	out.println("<tr>");
	out.println("<th colspan='8' scope='col'>");
	out.println("<p align='left' class='bold1'><strong>Form No.3A(Revised) Contribution card for the Currency Period from 1st April "+byear+" to 31st March "+cyear+"<br />(FOR UNEXEMPTED ESTABLISHMENTS ONLY)</strong></p>");
	out.println("<p align='left' class='bold1'><strong>Name and address of the Establishment: "+datac[0][0]+".,</strong><br /><strong>"+datac[0][1]+","+datac[0][2]+"-"+datac[0][3]+"</strong></p>");
	
	out.println("<table width='680' border='0' align='center' cellpadding='0' cellspacing='0'>");
    out.println("<tr>");
    out.println("<th width='192' height='34' class='boldEleven' scope='col'><div align='left' class='boldEleven'><span class='bold1'>1.</span> Account No.");
    out.println("</div></th>");
    out.println("<th width='143' class='boldEleven' scope='col'><div align='left'><strong>"+data[i][1]+"</strong></div></th>");
    out.println("<th width='215' class='boldEleven' scope='col'> <div align='left' class='style38'><span class='bold1'><strong>4</strong>.</span>Statutory rate of Contribution</div></th>");
    out.println("<th width='130' scope='col'>&nbsp;12%</th>");
    out.println("</tr>");
	out.println("<tr>");
    out.println("<th height='35' class='boldEleven' scope='row'><p align='left' class='boldEleven'><span class='bold1'>2.</span>Name/surname (in Block Capitals)</p></th>");
    out.println("<td class='bold1'>"+data[i][2]+"</td>");
    out.println("<td class='boldEleven'><p align='left' class='boldEleven'><span class='bold1'><strong>5</strong>.</span>Voluntary higher rate of employee's contribution if any</p></td>");
    out.println("<td>&nbsp;</td>");
    out.println("</tr>");
	out.println("<tr>");
    out.println("<th height='32' class='boldEleven' scope='row'><div align='left' class='style3'><span class='bold1'>3.</span><span class='style32 style39'><span class='boldEleven style43'>Father's/Husband's Name:</span></span></div></th>");
    out.println("<td class='boldEleven'>&nbsp;</td>");
    out.println("<td class='boldEleven'><div align='left' class='style38'><span class='bold1'><strong>6</strong>.</span><span class='boldEleven style43'>Employer contribution on Hig wages to EPF(ER) y/n</span> </div></td>");
    out.println("<td>&nbsp;</td>");
    out.println("</tr>");
	out.println("<tr>");
    out.println("<th height='19' class='boldEleven' scope='row'>&nbsp;</th>");
    out.println("<td class='boldEleven'>&nbsp;</td>");
    out.println("<td class='boldEleven'><div align='left' class='style38'>");
    out.println("<p><span class='bold1'><strong>7</strong>.</span><span class='boldEleven style43'>Voluntary contribution to pension y/n</span></p>");
    out.println("</div></td>");
    out.println("<td>&nbsp;</td>");
    out.println("</tr>");
	out.println("</table><p align='center'></p></th>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<th colspan='8' class='boldEleven' scope='col'><strong>");
	out.println("<table width='621' border='0' cellspacing='0' cellpadding='0'><tr>");
	out.println("<th width='116' scope='col'><strong>Months</strong></th>");
	out.println("<th width='174' scope='col'><strong>Worker's share</strong></th>");
	out.println("<th width='224' scope='col'><strong>Employer's share </strong></th>");
	out.println("<th width='107' scope='col'><strong>Remarks</strong></th>");
	out.println("</tr>");
	out.println("</table></th>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<th height='117' colspan='8' scope='col'><table width='645' border='0' align='right' cellpadding='0' cellspacing='0'>");
	out.println("<tr>");
    out.println("<th width='63' height='110' class='boldEleven style32 style40' scope='col'>&nbsp;</th>");
    out.println("<th width='71' class='boldEleven style32 style35' scope='col'><p>&nbsp;</p>");
    out.println("<p>&nbsp;</p>");
    out.println("<p class='boldEleven'>Amount Of Wages </p></th>");
    out.println("<th width='71' class='boldEleven style32 style35' scope='col'><p>&nbsp;</p>");
    out.println("<p>&nbsp;</p>");
    out.println("<p>&nbsp;</p>");
    out.println("<p class='boldEleven'>EPF</p></th>");
    out.println("<th width='71' class='boldEleven style32 style35' scope='col'><p>&nbsp;</p>");
    out.println("<p>&nbsp;</p>");
    out.println("<p class='boldEleven'>EPF&amp;8-1/3% if any </p></th><th width='36' class='boldEleven style32 style35' scope='col'>&nbsp;</th>");
    out.println("<th width='71' class='boldEleven style32 style35' scope='col'><p>&nbsp;</p>");
    out.println("<p>&nbsp;</p>");
    out.println("<p class='boldEleven'>Pension fund contri 8-1/3% </p></th>");
    out.println("<th width='83' class='boldEleven style32 style35' scope='col'>&nbsp;</th>");
    out.println("<th width='76' class='boldEleven' scope='col'><div align='center' class='boldEleven'>No. Of days/period of non contributiong service if any </div></th><th width='103' class='boldEleven' scope='col'>&nbsp;</th>");
    out.println("</tr>");
	out.println("</table></th>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<th class='bold1' scope='col' width='150'><div align='center'>1</div></th>");
	out.println("<th class='bold1' scope='col' width='70'><div align='center'>2</div></th>");
	out.println("<th class='bold1' scope='col' width='70'><div align='center'>3(A)</div></th>");
	out.println("<th class='bold1' scope='col' width='70'><div align='center'>4(A)</div></th>");
	out.println("<th class='bold1' scope='col' width='70'><div align='center'>4(B)</div></th>");
	out.println("<th class='bold1' scope='col' width='70'><div align='center'>5</div></th>");
	out.println("<th colspan='2' class='bold1' scope='col'><div align='center'>7</div></th>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<th scope='col' width='150'><span class='bold1'><div align='left'>Mar<font color='white'>`</font>paid<font color='white'>`</font>in<font color='white'>`</font>April'"+byear+"</span><br>");
    out.println("<span class='bold1'><div align='right'>May-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Jun-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Jul-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Aug-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Sep-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Oct-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Nov-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Dec-"+byend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Jan-"+cyend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Feb-"+cyend+"</span><br>");
    out.println("<span class='bold1'><div align='right'>Mar-"+cyend+"</span><br></th>");
	out.println("<th scope='col' width='70'><span class='bold1'><div align='right'>"+form2R+"</span><br>");
	 out.println("<span class='bold1'><div align='right'>"+form2A+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form2M+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2J+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2L+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2U+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2S+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2O+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2N+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2D+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form21+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form2F+"</span><br>");
    out.println("</th>");
	out.println("<th scope='col' width='70'><span class='bold1'><div align='right'>"+form3R+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form3A+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form3M+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3J+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3L+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3U+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3S+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3O+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3N+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3D+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form31+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form3F+"</span><br>");
    out.println("</th>");
	out.println("<th scope='col' width='70'><span class='bold1'><div align='right'>"+form4R+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form4A+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form4M+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4J+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4L+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4U+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4S+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4O+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4N+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4D+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form41+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4F+"</span><br>");
    out.println("</th>");
	out.println("<th scope='col' width='70'><span class='bold1'><div align='right'>"+form4bR+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form4bA+"</span><br>");
	out.println("<span class='bold1'><div align='right'>"+form4bM+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bJ+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bL+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bU+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bS+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bO+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bN+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bD+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4b1+"</span><br>");
    out.println("<span class='bold1'><div align='right'>"+form4bF+"</span><br>");
    out.println("</th>");
	out.println("<th scope='col'>&nbsp;</th>");
	out.println("<th scope='col'>&nbsp;</th>");
	out.println("<th scope='col'><p class='boldEleven'>a)Date of eaving service if any</p><p>&nbsp;</p><p><span class='boldEleven'>b)Reasons of leaving service if any</span>  </p></th>");
	out.println("</tr>");
	out.println("<tr>");
	
	form2t=Double.parseDouble(form2A)+Double.parseDouble(form2M)+Double.parseDouble(form2J)+Double.parseDouble(form2L)+Double.parseDouble(form2U)+Double.parseDouble(form2S)+Double.parseDouble(form2O)+Double.parseDouble(form2N)+Double.parseDouble(form2D)+Double.parseDouble(form21)+Double.parseDouble(form2F)+Double.parseDouble(form2R);
	form3t=Double.parseDouble(form3A)+Double.parseDouble(form3M)+Double.parseDouble(form3J)+Double.parseDouble(form3L)+Double.parseDouble(form3U)+Double.parseDouble(form3S)+Double.parseDouble(form3O)+Double.parseDouble(form3N)+Double.parseDouble(form3D)+Double.parseDouble(form31)+Double.parseDouble(form3F)+Double.parseDouble(form3R);
	form4t=Double.parseDouble(form4A)+Double.parseDouble(form4M)+Double.parseDouble(form4J)+Double.parseDouble(form4L)+Double.parseDouble(form4U)+Double.parseDouble(form4S)+Double.parseDouble(form4O)+Double.parseDouble(form4N)+Double.parseDouble(form4D)+Double.parseDouble(form41)+Double.parseDouble(form4F)+Double.parseDouble(form4R);
	form4bt=Double.parseDouble(form4bA)+Double.parseDouble(form4bM)+Double.parseDouble(form4bJ)+Double.parseDouble(form4bL)+Double.parseDouble(form4bU)+Double.parseDouble(form4bS)+Double.parseDouble(form4bO)+Double.parseDouble(form4bN)+Double.parseDouble(form4bD)+Double.parseDouble(form4b1)+Double.parseDouble(form4bF)+Double.parseDouble(form4bR);
	
	out.println("<th width='110' class='bold1' scope='col'><div align='left'>Total</div></th>");
	out.println("<th width='88'scope='col' class='bold1' width='70'><div align='right'>"+form2t+"</th>");
	out.println("<th width='88' scope='col' class='bold1' width='70'><div align='right'>"+form3t+"</th>");
	out.println("<th width='88' scope='col' class='bold1' width='70'><div align='right'>"+form4t+"</th>");
	out.println("<th width='96' scope='col' class='bold1' width='70'><div align='right'>"+form4bt+"</th>");
	out.println("<th width='33' scope='col' class='bold1'><div align='right'>&nbsp;</th>");
	out.println("<th width='52' scope='col' class='bold1'><div align='right'>&nbsp;</th>");
	out.println("<th width='76' scope='col' class='bold1'><div align='right'>&nbsp;</th>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<th colspan='8' scope='col'><p align='left'><span class='boldEleven'>Certified that the total amount of contribution (both shares) indicated in this card i.e,<strong> Rs. &nbsp;"+(form3t+form4t)+"</strong> has already been remitted in full in EPF A/C No. 1 and pension Fund A/C No. 10 R <strong>&nbsp;&nbsp;&nbsp;&nbsp;"+form4bt+"</strong> vide below </p>");
	out.println("<p align='left' class='style3'><span class='boldEleven'>Certified that the difference between the total of the contributions shown under columns(3) and 4(a) &amp; 4(b) of the above table and that arrived at on the total wages shown in col(2) at the prescribed rate is sloely due to rounding off of contribution to the nearest rupee under the rules.<strong></strong></span><br><span class='bold1'><div align='right'>For "+datac[0][0]+",</p>");
	out.println("<p align='left' class='boldEleven'>dated ________ <span class='bold1'><div align='right'>Authorised signatory </span></p>");
	out.println("<p align='left' class='boldEleven'>(See paragraphs 35 and 42 of the employee' Provident Funds Scheme, 1952)<br>");
	out.println("(See paragraph 19 of the Employee's Pension Scheme 1995)<br>");
	out.println("<p align='left' class='boldEleven'>Note:- In respect of Form 3(A) sent to the Regional Office during the course of the Currency period for the purpose of final settlement of the accounts of the member who had left service details of date and reason for leaving service.<br>");
	out.println("Should be furnished under column 7(A)(B)<br>");
	out.println("In respect of those who are not members of the Pension Fund the employers share of contribution to the EPF will be 8-1/3 or 10% as the may be and is to be shown under Column 4(a)</p>");
	out.println("</tr>");
	out.println("</table>");
	out.println("<table border=0 ><tr><td height='25'>&nbsp;</td></tr></table>");}
%>
		<table width="184" align="center" cellpadding="15" cellspacing="0">
             <tr>
		   <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
             <td class="boldEleven"><div align="center"><a  title="Excel" href=javascript:; onClick="CreateExcelSheet()"><img src="../Image/report/Excel.png" width="15" height="14" border="0"></a> </div></td>
		       
		       <td class="boldEleven"><div align="center"><a title="Text" href=javascript:; onClick="windowSave('Form3a.txt')"><img src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div></td>
		       <td class="boldEleven"><div align="center"><a title="Document" href=javascript:; onClick="windowSave('Form3a.doc')"><img src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
		       <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:; onClick="windowSave('Form3a.html')"><img src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
			   
           </tr>
</table>
		<%	
	
  %>
</body>
</html>
