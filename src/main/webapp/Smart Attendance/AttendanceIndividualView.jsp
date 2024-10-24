<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String OptEmpId;
	String month;
	String year;
	int i;	
%>
<%
	OptEmpId=request.getParameter("ename");
	month=request.getParameter("Month");
	year=request.getParameter("Year");	
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
.style77 {font-size: 12px}
.style78 {
	font-family: Verdana;
	font-size: 10px;
}
.style79 {
	font-size: 10px;
	font-weight: bold;
}
-->
</style>
</head>

<body  onpaste='return false;'>
<br>
<br>
<br>
<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="89" height="97">&nbsp;</td>
		<td width="800" valign="top">
		<table width="800" border="1" cellpadding="0" cellspacing="1"
			 >
			<tr align="center" valign="top">
				<td height="29" colspan="8"  class="tablehead"><b>Attendance
				Individual View</b></td>
			</tr>
			<tr>
				<td width="9%" height="30" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Emp ID</td>
				<td width="22%" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Name</td>
				<td width="12%" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Login Date</td>
				<td width="9%" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Time in</td>
				<td width="9%" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Time Out</td>
				<td width="8%" valign="middle" bgcolor="6E8FBC" class="tablehead">
				Remarks</td>
			</tr>
			<%
try
{
	con=conbean.getConnection();
   	st=con.createStatement();
	sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_LOGIN,B.DT_TIMEIN,B.DT_TIMEOUT,B.CHR_PRESENTTYPE ";
	sql=sql+" FROM  com_m_staff  A,ATT_SMART_ATTENDANCE B WHERE B.CHR_LOGMONTH='"+month+"' AND B.INT_LOGYEAR="+year+" AND A.CHR_EMPID=b.chr_empid and A.CHR_EMPID='"+OptEmpId+"'";
	rs = st.executeQuery(sql);
if(rs.next())
{
%>
			<tr>
				<td height="20">
				<% out.println(rs.getString("chr_EMPID")); %>
				</td>
				<td>
				<% out.println(rs.getString("chr_StaffName")); %>
				</td>
				<%
       StringTokenizer tok=new StringTokenizer(rs.getString("dt_LOGIN"));
        StringTokenizer tok1=new StringTokenizer(tok.nextToken(),"-");
       String y=tok1.nextToken();
       String m=tok1.nextToken();
       String d=tok1.nextToken();
       %>
				<td>
				<% out.println(d+"-"+m+"-"+y); %>
				</td>
				<td>
				<% out.println(rs.getString("dt_timein")); %>
				</td>
				<td>
				<%
		   String outtime=rs.getString("dt_timeout");
			while(rs.next()){
				if(rs.getString("DT_LOGIN")!=null) outtime=rs.getString("dt_timeout");
			}
		  	out.println(outtime); 
		  %>
				</td>

				<td>
				<% out.println(rs.getString("CHR_PRESENTTYPE")); %>
				</td>
			</tr>
			<%
}}
catch(Exception e)
{
    //System.out.println(e);
}
//rs.close();
st.close();
 
%>
		</table>
		</td>
		<td width="89">&nbsp;</td>
	</tr>
</table>
<br>
<br>
<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="209" height="72">&nbsp;</td>
		<td width="94" valign="top" background="../if">
		<div align="left"></div>
		</td>
		<td width="334">&nbsp;</td>
		<td width="93" valign="top" background="../if">
		<div align="right"></div>
		</td>
		<td width="250">&nbsp;</td>
	</tr>
</table>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
