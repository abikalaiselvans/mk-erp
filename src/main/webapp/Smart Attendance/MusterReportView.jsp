<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String fm;
	int fy;
	int j,mth;
	String day[]=new String[32];

	
%>
<%
	fm=request.getParameter("Month");
	//System.out.println(fm);
	fy=Integer.parseInt(request.getParameter("Year"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


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

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style79 {font-size: 10px}
.style80 {font-family: Verdana; font-size: 14px; }
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
</head>
<body  onpaste='return false;'>
<table border="1">
	<tr>
		<td colspan="39">
		<center><b>Muster Reports</b></center>
		</td>
	</tr>
	<tr>
		<td>
		<div align="center" class="style80">S.No</strong>
		<td width="20%">
		<div align="center" class="style80">Emp ID</div>
		</td>
		<td width="30%">
		<div align="center" class="style80">Name</div>
		</td>
		<%
/*
 switch(fm){
			case "January":
			case "March":
			case "May":
			case "July":
			case "August":
			case "October":
			case "December":
				 for(int i=1;i<32;i++){
				out.println("<td width='9%'>"+i+"</td>");
				}
				break;
			case "April":
			case "June":
			case "September":
			case "November": 
				for(int i=1;i<31;i++){
				out.println("<td>"+i+"</td>");
				}
				break;
			case "February":
				if(fy%4 ==0)
				{
				for(int i=1;i<30;i++)
				{
				out.println("<td>"+i+"</td>");
				}}
				else
				for(int i=1;i<29;i++)
				{
				out.println("<td>"+i+"</td>");
				}
				break;
				
}*/
%>
		<td width="9%">
		<div align="center" class="style80">P</strong>
		<td width="9%">
		<div align="center" class="style80">L</strong>
		<td width="9%">
		<div align="center" class="style80">H</div>
		</td>
		<td width="9%">
		<div align="center" class="style80">OD</div>
		</td>
		<td width="9%">
		<div align="center" class="style80">LD</div>
		</td>
		<td width="9%">
		<div align="center" class="style80">TD</div>
		</td>
	</tr>
	<%
sql="select a.INT_DEPARTID,b.chr_staffname,c.DT_HOLIDATE ";
sql=sql+" from   com_m_depart   a, com_m_staff  b,att_t_holiday c";
sql=sql+ " where a.int_departid=b.int_departid and c.chr_month='"+fm+"' ";
	
st=null;//con.createStatement();
rs=st.executeQuery(sql);
j=1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+j+"</td>");
		out.println("<td>"+rs.getString("CHR_EMPID")+"</td>");
		out.println("<td>"+rs.getString("CHR_STAFFNAME")+"</td>");
		out.println("<td>"+rs.getString("dt_holidate")+"</td>");
		out.println("</tr>");
		j++;
		}

%>
	</tr>
</table>