<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String sql_Select_Query ="SELECT * FROM m_institution";

	public void releaseJDBCResource() 	
	{
		try
		{
			rst.close();
			pstm.close();
			 

		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
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
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style12 {color: #FFFFFF}
.style13 {
	color: #0000FF;
	font-weight: bold;
}
.style14 {font-family: "Times New Roman", Times, serif}
.style15 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; font-weight: bold; }
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   method="post" action="User_Insertion.jsp">
<body  onpaste='return false;'>
<table width="900" height="800" border="0" cellpadding="0"
	cellspacing="0" bordercolor="#DE4100">
	<tr>
		<td height="71" colspan="19">
		<div align="right">
		<TABLE width="1008" border=0 align="left" cellPadding=0 cellSpacing=1>
			<TBODY>
				<TR>
					<TD width="13%" rowspan="2">
					<div align="center"><img src="../Image/Logo.gif" width="90"
						height="98"></div>
					</TD>
					<td width="40%">
					<p align=center><font color="green" size="5"><B> <%
	//Loading JDBC Connection Information
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);	
		Properties jdbc = new Properties();
		jdbc.load(input);
		String driver = jdbc.getProperty("Driver");
		String url =jdbc.getProperty("Url");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		//Database Connectivity
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();

		while(rst.next())
		{
			out.println("<option>"+rst.getString("chr_NAME")+"</option>");		
		}
		releaseJDBCResource();

	}catch(Exception ex)
	{
		//System.out.println(ex);
	}

%>
					
					</TD>
					<p align="right" class="style13"><span class="style14"><a
						href="Mainscreen.htm" target="_parent"><span class="style15"></span></a><span
						class="style15"><a href="Mainscreen.htm" target="_parent">Home</a></span></span></p>
					</TD>
					<TD width="1%">
					<p>&nbsp;</p>
					<p align="center"><span class="style14"><span
						class="style15">|<br>
					</span></span></p>
					</TD>
					<TD width="6%">
					<p>&nbsp;</p>
					<p align="left"><span class="style14"><a
						href="../Login.htm" target="_parent"><span class="style15"></span></a><span
						class="style15"><a href="../Login.htm" target="_parent">Logout</a></span></span></p>
					</TD>
					<TD width="6%">
					<div align="right"></div>
					</TD>
					<TD width="16%" rowspan="2"><img
						src="../Images/General/Logu.gif" width="151" height="89"></TD>
				</TR>
				<TR>
					<TD colspan="3">&nbsp;</TD>
					<TD width="6%">&nbsp;</TD>
				</TR>
				<TR>
					<TD height="37" colspan="7">
					<TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>

						<TBODY>
							<TR>


								<TD width="155" bgcolor="#FFFFFF">&nbsp;</TD>
								<TD width="140" height="33" bgcolor="#FFFFFF">
								<div align="center" class="style12">
								<div align="center"><a href="Allowance.htm"
									Target="mainFrame"><img
									src="../Images/Smart%20Payroll/Allowances.gif" width="140"
									height="26" border="0"></a></div>
								</div>
								</TD>
								<TD width=163 bgcolor="#FFFFFF">
								<div align="center" class="style12">
								<div align="center"><a href="Recovery.htm"
									Target="mainFrame"><img
									src="../Images/Smart%20Payroll/Recovery.gif" width="140"
									height="26" border="0"></a></div>
								</div>
								</TD>
								<TD width=168 bgcolor="#FFFFFF">
								<div align="center"><a href="SaleryEntry.htm"
									target="mainFrame"><img
									src="../Images/Smart%20Payroll/Salary%20Entry.gif" width="140"
									height="26" border="0"></a></div>
								</TD>
								<TD width=142 bgcolor="#FFFFFF">
								<div align="center" class="style12">
								<div align="center"><a href="Advance.htm"
									Target="mainFrame"><img
									src="../Images/Smart%20Payroll/Advance.gif" width="140"
									height="26" border="0"></a></div>
								</div>
								</TD>
								<TD width=180 bgcolor="#FFFFFF">
								<div align="center" class="style12">
								<div align="center"></div>
								</div>
								<div align="center"><a href="Salary%20Cal.htm"
									Target="mainFrame"><img
									src="../Images/Smart%20Payroll/Salary%20Cal.gif" width="140"
									height="26" border="0"></a></div>
								<div align="center"></div>
								</TD>
							</TR>
						</TBODY>


					</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>
		</td>
	</tr>
	<tr>
		<td height="19" colspan="19"></td>
	</tr>
	<tr>
		<td width="347" height="372" rowspan="7"></td>
		<td width="347" height="372" rowspan="6" valign="top"
			background="../if">
		<p>&nbsp;</p>
		<td width="112" rowspan="6" valign="top" background="../if">&nbsp;</td>
		<td width="7" valign="top" background="../if">&nbsp;</td>
		<td colspan="10" valign="top" background="../if">&nbsp;</td>
		<td colspan="3" valign="top" background="../if">
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		</td>
		<td width="7" rowspan="6" valign="top" background="../if">
		<p>&nbsp;</p>
		<td width="345" rowspan="7" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" background="../if">&nbsp;</td>
		<td width="7" valign="top" background="../if">&nbsp;</td>
		<td width="7" valign="top" background="../if">&nbsp;</td>
		<td width="7" valign="top" background="../if">&nbsp;</td>
		<td colspan="7" valign="top" background="../if">&nbsp;</td>
		<td width="7" height="3" valign="top" background="../if">&nbsp;</td>
		<td colspan="2" valign="top" background="../if">
		<form  AUTOCOMPLETE = "off"   name="form2" method="post" action=""></form>
		</td>
	</tr>
	<tr>
		<td colspan="4" valign="top" background="../if">&nbsp;</td>
		<td colspan="7" valign="top" background="../if">&nbsp;</td>
		<td height="6" valign="top" background="../if">&nbsp;</td>
		<td colspan="2" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td height="19" colspan="13" valign="top" background="../if">&nbsp;</td>
		<td width="7" valign="top" background="../if">&nbsp;</td>
		<td colspan="2" valign="top" background="../if">&nbsp;</td>
		<td width="4" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="18" rowspan="15">
		<div align="left"></div>
		</td>

		<td width="10" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="10" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="347" height="19" valign="top" background="../if">&nbsp;</td>
	</tr>
</table>
</body>
</form>
</html>
