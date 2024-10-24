<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	int fm;
	int fy;
	int i;	
%>
<%
	fm=Integer.parseInt(request.getParameter("Month"));
	fy=Integer.parseInt(request.getParameter("Year"));
%>
<%
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);
		Properties jdbc = new Properties();
		jdbc.load(input);
		driver = jdbc.getProperty("Driver");
		url =jdbc.getProperty("Url");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
	}
	catch(Exception e)
	{
		//System.out.println(e);
	}
		
	try
	{
	   	st=con.createStatement();
		sql="select  l.*,s.chr_staffname from m_leaveentry l,m_staff s where Int_Month=" + fm +" and Int_Year="+fy+" and l.chr_empid=s.chr_empid";
		rs = st.executeQuery(sql);
		
		
		
	}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
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
<p class="style8">&nbsp;</p>
<p class="style8"><u>Leave Entry Month view</p>

<table width="700" border="0" cellpadding="0" cellspacing="1">
	<tr bgcolor="#666666">
		<td width="4%">
		<div align="center" class="style8 style79"><font color="#FFFFFF">S.No</font><font
			color="#000000">.</font></div>
		</td>
		<td width="9%">
		<div align="center" class="style80"><font color="#FFFFFF">Emp
		ID</font></div>
		</td>
		<td width="16%">
		<div align="center" class="style80"><font color="#FFFFFF">Name</font></div>
		</td>
		<td width="12%">
		<div align="center" class="style80"><font color="#FFFFFF">Date</font></div>
		</td>
		<td width="8%">
		<div align="center" class="style80"><font color="#FFFFFF">Leave
		Type</font></div>
		</td>
	</tr>
	<%
i=1;
while(rs.next())
{
%>
	<tr bgcolor="#CCCCCC">
		<td height="18"><span class="style80"> <% out.println(i); %>
		</span></td>
		<td><span class="style80"> <% out.println(rs.getString("chr_EMPID")); %>
		</span></td>
		<td><span class="style80"> <% out.println(rs.getString("chr_StaffName")); %>
		</span></td>
		<%
       StringTokenizer tok=new StringTokenizer(rs.getString("dt_ldate"));
        StringTokenizer tok1=new StringTokenizer(tok.nextToken(),"-");
       String y1=tok1.nextToken();
       String m1=tok1.nextToken();
       String d1=tok1.nextToken();
%>
		<td><span class="style80"> <% out.println(d1+"-"+m1+"-"+y1); %>
		</span></td>
		<td><span class="style80"> <% out.println(rs.getString("Chr_LeaveType")); %>
		</span></td>
	</tr>
	<%
i=i+1;
}
rs.close();
st.close();
 
%>
</table>
<br>
<br>
<br>
<br>
<td><a href="SmartAttendanceImg.htm"><img
	src="../Images/General/Home.gif" width="70" height="22" border="0"></a>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="LeaveEntryMonth.htm"><img src="../Images/General/Back.gif"
	width="70" height="22" border="0"></a></td>

</body>
</html>
