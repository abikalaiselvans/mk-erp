 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<link rel="icon" type="image/ico" href="../images/animated_favicon1.gif" ></link>
<link rel="shortcut icon" href="../images/animated_favicon1.gif"></link>

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
<style type="text/css">
<!--
.style3 {
font-size: 8.5px;

}


.style4 {
font-size: 8.5px; color:#FF0000;

}
-->
</style>
</head>

<body  onpaste='return false;'>
<p>
<%
	try
	{
		String Company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String Office=request.getParameter("Office");
		String Month=request.getParameter("Month");
		String month =com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(Month));
		String Year=request.getParameter("Year");
		String noofmonth=request.getParameter("noofmonth");
		int nootm = Integer.parseInt(noofmonth);
		String agemonth = Year+"-"+Month+"-"+nootm;
		String mor="";
		String eve="";
		int day=1;
		String sql="";
		boolean flag = true;
		sql = "SELECT b.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(b.DT_DOB,'%d-%b-%Y'),floor(DATEDIFF('"+agemonth+"',b.DT_DOB)/365),c.CHR_DESIGNAME,";
		
		for(int u=1;u<=nootm;u++)
		{
			sql = sql+"a.CHR_MORNING"+u +", a.CHR_EVENING"+u+ " , ";
		}
		sql = sql +" a.CHR_MONTH,a.INT_YEAR FROM att_t_register a, com_m_staff b,com_m_desig c ,pay_t_salary d ";
		sql = sql +" WHERE a.CHR_MONTH='"+month+"' AND  a.INT_YEAR="+Year;
		sql = sql +" AND d.CHR_MONTH='"+month+"' AND  d.INT_YEAR="+Year;
		sql = sql +" AND b.CHR_EMPID = a.CHR_EMPID ";
		sql = sql +" AND b.CHR_EMPID = d.CHR_EMPID ";
		sql = sql +" AND c.INT_DESIGID = b.INT_DESIGID ";
		if(!"0".equals(branch))
			sql = sql +" AND b.INT_BRANCHID ="+branch;
		if(!"0".equals(Office))
		 	sql = sql +" AND b.INT_OFFICEID ="+Office;
		sql = sql +" ORDER BY b.CHR_STAFFNAME  ";
		//out.println(sql);
		 
		 
		String data[][]=  CommonFunctions.QueryExecute(sql);
		String daysat="";
		for(int i=1;i<=nootm;i++)
		{
			sql = "SELECT DAYNAME('"+Year+"-"+Month+"-"+i+"')";
			String days[][]= CommonFunctions.QueryExecute(sql);
			if("Saturday".equals(days[0][0].trim()))
				daysat=daysat+i+",";
		}
		String satdata[] = daysat.split(",");			
			if(data.length>0)
			{
		%>
<br><center>
<a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
</center>			
<br>
<table width="80%" class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' align="center">
	<tr bgcolor="#FFFFFF">
		<td align='center'><span class="style3">S.No</span></td>
		<td align='center'><span class="style3">E.Code</span></td>
		<td align='center'><span class="style3">Name of the Person
		Employment </span></td>
		<td align='center'><span class="style3">Date of entry into
		service </span></td>
		<td align='center'><span class="style3">Age/Date of Birth
		</span></td>
		<td align='center'><span class="style3">Designation</span></td>
		<td align='center' colspan="3"><span class="style3">Leave
		Credit at the Beginning of the month </span></td>
		<td colspan="3" align='center'><span class="style3">Leave
		availed duriong the Month </span></td>
		<td align='center' colspan="3"><span class="style3">Leave
		Balance </span></td>
		<%
		out.println("<td colspan='"+nootm+"' align='center'><span class='style3'>Daily Hours of work including overtime(If Any)</td>");
	%>

		<td align='center'><span class="style3">Total hours
		ofovertime worked </span></td>
		<td align='center'><span class="style3">Total hours of
		work done during the month </span></td>
		<td align='center'><span class="style3">Total number of
		maternity Leave Availed </span></td>

	</tr>
	<tr bgcolor="#FFFFFF">
		<td align='center'><span class="style3">&nbsp;</span></td>
		<td align='center'><span class="style3">&nbsp;</span></td>
		<td align='center'><span class="style3">&nbsp;</span></td>
		<td align='center'><span class="style3">&nbsp;</span></td>
		<td align='center'><span class="style3">&nbsp;</span></td>
		<td align='center'><span class="style3">&nbsp;</span></td>
		<td align='center'><span class="style3">Sick Leave </span></td>
		<td align='center'><span class="style3">Casual Leave </span></td>
		<td align='center'><span class="style3">Holidays with
		Wayes </span></td>
		<td align='center'><span class="style3">Sick Leave </span></td>
		<td align='center'><span class="style3">Casual Leave</span></td>
		<td align='center'><span class="style3">Holidays with
		Wayes</span></td>
		<td align='center'><span class="style3">Sick Leave </span></td>
		<td align='center'><span class="style3">Casual Leave</span></td>
		<td align='center'><span class="style3">Holidays with
		Wayes</span></td>
		<%
		out.println("<td colspan='"+nootm+"'>&nbsp;</td>");
	%>
		<td><span class="style3">&nbsp; </span></td>
		<td><span class="style3">&nbsp; </span></td>
		<td><span class="style3">&nbsp; </span></td>

	</tr>
	<tr bgcolor="#FFFFFF">
		<td align='center'><span class="style3">(1)</span></td>
		<td align='center'><span class="style3">(2)</span></td>
		<td align='center'><span class="style3">(2)</span></td>
		<td align='center'><span class="style3">(3)</span></td>
		<td align='center'><span class="style3">(4)</span></td>
		<td align='center'><span class="style3">(5)</span></td>
		<td align='center'><span class="style3">(6)</span></td>
		<td align='center'><span class="style3">(7)</span></td>
		<td align='center'><span class="style3">(8)</span></td>
		<td align='center'><span class="style3">(9)</span></td>
		<td align='center'><span class="style3">(10)</span></td>
		<td align='center'><span class="style3">(11)</span></td>
		<td align='center'><span class="style3">(12)</span></td>
		<td align='center'><span class="style3">(13)</span></td>
		<td align='center'><span class="style3">(14)</span></td>
		<%
		out.println("<td  align='center' colspan='"+nootm+"'>&nbsp;</td>");
	%>
		<td align='center'><span class="style3">(15)</span></td>
		<td align='center'><span class="style3">(16)</span></td>
		<td align='center'><span class="style3">(17)</span></td>

	</tr>
	<tr bgcolor="#FFFFFF">
		<td><span class="style3">&nbsp;</span></td>
		<td><span class="style3">&nbsp;</span></td>
		<td><span class="style3">&nbsp;</span></td>
		<td><span class="style3">&nbsp;</span></td>
		<td><span class="style3">&nbsp;</span></td>
		<td><span class="style3">&nbsp;</span></td>
		<td colspan="3"><span class="style3">&nbsp;</span></td>
		<td colspan="3"><span class="style3">&nbsp;</span></td>
		<td colspan="3"><span class="style3">&nbsp;</span></td>
		<%
		for(int i=1;i<=nootm;i++)
			if(i<10)
				out.println("<td width='50' align='center'><span class='style3'>0"+i+"</td>");
			else
				out.println("<td width='50' align='center'><span class='style3'>"+i+"</td>");
	%>
		<td><span class="style3"> &nbsp;</span></td>
		<td><span class="style3">&nbsp; </span></td>
		<td><span class="style3">&nbsp; </span></td>

	</tr>
	<%
		for(int u=0;u<data.length;u++)
		 {
			out.println("<tr bgcolor='#FFFFFF'><td ><span class='style3'>"+(u+1)+".</span></td>");
			out.println("<td ><span class='style3'>"+data[u][0]+"</span></td>");
			out.println("<td><span class='style3'>"+data[u][1]+"</span></td>");
			out.println("<td><span class='style3'>&nbsp;</span></td>");
			
			out.println("<td align='center'><span class='style3'>"+data[u][3]+"&nbsp;&nbsp;/&nbsp;&nbsp;"+data[u][2]+"</span></td>");
			out.println("<td align='center'><span class='style3'>"+data[u][4]+"</span></td>");
			 
			//leave credit
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");//12
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");//12
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");//12
			//Leave Avail
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");
			//leave Balance
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");//12
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");//12
			out.println("<td align='center'><span class='style3'>&nbsp;</span></td>");//12
			//Attendance
			day=4;
			for(int i=1;i<=nootm;i++)
			{
				flag = true;
				for(int k=0;k<satdata.length;k++)
					if( i == Integer.parseInt(satdata[k]))
						flag = false;
				
				mor=data[u][i+day].trim();
				eve=data[u][i+day+1].trim();
				day=day+1;
				/*if(flag)
				{
					
				}
				else
				{
					out.println("<td  align='center'><span class='style3'>8</span></td>");	
				}*/	
								
				if(("SUN".equals(mor)) && ("SUN".equals(eve) ))
					out.println("<td bgcolor='E9EAF3' align='center'><span class='style4'><b>S</span></b></td>");
				else if(("NA".equals(mor)) && ("NA".equals(eve) ))
					out.println("<td  align='center'  bgcolor='#E9B08B'>-</td>");
				else if(("ABS".equals(mor)) && ("ABS".equals(eve) ))
					out.println("<td  align='center' bgcolor='#E9B08B'>-</td>");
				else if(("HOL".equals(mor)) && ("HOL".equals(eve) ))
					out.println("<td  align='center'><span class='style3'><b>H</b></span></td>");		
				else if(("LEA".equals(mor)) && ("LEA".equals(eve) ))
					out.println("<td  align='center'><span class='style4'><b>L</b></span></td>");		
				else
					out.println("<td  align='center'><span class='style3'>8</span></td>");	
					
					
			}	
			out.println("<td  align='center'><span class='style3'>0</span></td>");
			out.println("<td align='center'><span class='style3'>0</span></td>");
			out.println("<td align='center'><span class='style3'>0</span></td>");	
			out.println("</tr>");
		 }	
	%>


</table>

<%
  		}
		else
		{
			out.println("data not found...");
		}
	}
	catch(Exception e)
	{
	}		
%>
</p>
</body>
</html>
