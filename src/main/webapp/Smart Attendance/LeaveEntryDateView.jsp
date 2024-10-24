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
	String fd;
	String fm;
	String fy;
	String td;
	String tm;
	String ty;
	String fdate;
	String tdate;
	int i;	
%>
<%
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

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
.style81 {font-family: Verdana; font-size: 14px; }
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<center>
<table width="1000" border="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="994" height="67" align="center" valign="middle" ss>
		<table width="676" border="1"  >
			<tr>
				<td width="76" height="30" align="center" 
					class="tablehead">S.No
				<td width="86" align="center" valign="middle" 
					class="tablehead">Emp ID</td>
				<td width="250" align="center" valign="middle" 
					class="tablehead">Name</td>
				<td width="79" align="center" valign="middle" 
					class="tablehead">Date</td>
				<td width="151" align="center" valign="middle" 
					class="tablehead">Leave Type</td>
			</tr>
			<%
try
	{
		con=conbean.getConnection();
	   	st=con.createStatement();
		sql="select  l.*,s.chr_staffname from ATT_T_LEAVE l, com_m_staff  s where dt_ldate>='" + fdate +"' and dt_ldate<='"+tdate+"' and l.chr_empid=s.chr_empid";
		rs = st.executeQuery(sql);
i=1;
while(rs.next())
{
%>
			<tr>
				<td height="27" align="center" valign="middle">
				<% out.println(i); %>
				</td>
				<td align="center" valign="middle">
				<% out.println(rs.getString("chr_EMPID")); %>
				</td>
				<%
       StringTokenizer tok=new StringTokenizer(rs.getString("dt_ldate"));
       StringTokenizer tok1=new StringTokenizer(tok.nextToken(),"-");
       String y1=tok1.nextToken();
       String m1=tok1.nextToken();
       String d1=tok1.nextToken();
%>
				<td align="center" valign="middle">
				<% out.println(rs.getString("chr_EMPID")); %>
				</td>
				<td align="center" valign="middle">
				<% out.println(d1+"-"+m1+"-"+y1); %>
				</td>
				<td align="center" valign="middle">
				<% out.println(rs.getString("Chr_LeaveType")); %>
				</td>
				<TD>
				<%
i=i+1;
}
rs.close();
st.close();
 
}
catch(Exception npe)
{
//System.out.println(npe);
}
%>
				</TD>
			</tr>
		</table>
		</td>

	</tr>
</table>
</center>


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
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
