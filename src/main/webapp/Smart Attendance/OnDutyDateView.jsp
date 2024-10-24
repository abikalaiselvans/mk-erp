<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
//  	Variable Declaration
	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String fd;
	String fm;
	String fy;
	String td;
	String tm;
	String ty;
	String fdate;
	String tdate;
	
	int i,toy,foy,tom,fom,tod,fod,dt,fdt1,tdt1;	
%>
<%
//	Datas get from previous form
	String fdate=request.getParameter("fromdt");
	String tdate=request.getParameter("todt");
	
	String date1[]=fdate.split("-");
	String date2[]=tdate.split("-");
	fd=date1[0];
	fm=date1[1];
	fy=date1[2];
	fdate=fy+"-"+fm+"-"+fd;
	td=date2[0];
	tm=date2[1];
	ty=date2[2];
	tdate=ty+"-"+tm+"-"+td;
	fod=Integer.parseInt(fd);
	fom=Integer.parseInt(fm);
	foy=Integer.parseInt(fy);

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
.style78 {font-family: Verdana}
.style79 {font-size: 10px}
.style80 {font-family: Verdana; font-size: 10px; }
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
<br>
<br>
<br>
<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="91" height="42">&nbsp;</td>
		<td width="801" valign="top">
		<table width="800" border="1" align="left" cellpadding="0"
			cellspacing="1"  >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="25" colspan="6"  class="tablehead">OnDuty
				- Date View</td>
			</tr>
			<tr>
				<td width="99" height="32" align="center" valign="middle"
					bgcolor="6E8FBC" class="tablehead">Emp Id</td>
				<td width="185" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Name</td>
				<td width="145" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Date</td>
				<td width="116" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Place</td>
				<td width="131" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Reason</td>
				<td width="100" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Authorized</td>
			</tr>
			<%
try
{
	con=conbean.getConnection();
	   	st=con.createStatement();

	   //	sql="Select a.chr_empid,a.chr_staffname,b.dt_timein,b.dt_timeout,b.chr_PRESENTTYPE from  com_m_staff  a,att_smart_attendance b";
	//	sql=sql+"where b.dt_login>='"+fdate+"'and b.dt_login<='"+tdate+"'and a.chr_empid=b.chr_empid";
		
		
		sql="Select a.chr_staffname,b.* from  com_m_staff  a,att_t_onduty b where b.DT_ODDATE>='"+fdate+"' and b.DT_ODDATE<='"+tdate+"' and a.chr_empid=b.chr_empid";

		//System.out.println(sql);
		rs = st.executeQuery(sql);
	while(rs.next())
	{
	%>

			<tr>
				<td height="20"><span class="style54"> <% out.println(rs.getString("CHR_EMPID")); %>
				</span></td>
				<td><span class="style54"> <% out.println(rs.getString("chr_staffname")); %>
				</span></td>
				<td><span class="style54"> <% out.println(rs.getString("dt_oddate")); %>
				</span></td>
				<td><span class="style54"> <% out.println(rs.getString("chr_place")); %>
				</span></td>
				<td><span class="style54"> <% out.println(rs.getString("chr_reason")); %>
				</span></td>
				<td><span class="style54"> <% out.println(rs.getString("CHR_AUTHNAME")); %>
				</span></td>
			</tr>


			<%

	}
rs.close();
st.close();
 
}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
%>
		</table>
		</td>
		<td width="86">&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<br>
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
