<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String sql_Select_Query ="select * from m_staff";

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

<script language="javascript">
	
				function validate()
	
					{
				
						var Sname=document.getElementById("sn").value
						var Sid=document.getElementById("Sid").value
    					var Year=document.getElementById("yr").value
    					var Month=document.getElementById("mo").value
						var Aamount=document.getElementById("aa").value
    					var Noints=document.getElementById("noi").value
    					var Dmonth=document.getElementById("dm").value
						var Dstatus1=document.getElementById("p").value
						var Dstatus2=document.getElementById("cl").value
						var Bamount=document.getElementById("ba").value
						var Binst=document.getElementById("bl").value
												
  					    submitOK="true"
  					     if (Sname=="select")
  					      {

								alert("Select Name")

								document.a.stname.focus()

                 					         submitOK="false"

							 }
							
							else if (Sid=="select")

 							 {

								alert(" Select Staff Id")

								document.a.stid.focus()

                 					         submitOK="false"

							 }
							
							else if (Year=="")

 							 {

								alert(" Enter Year")

								document.a.year.focus()

                 					         submitOK="false"

							 }
							 
							 else if (Month=="")

 							 {

								alert(" Enter Month")

								document.a.month.focus()

                 					         submitOK="false"

							 }
							 else if (Aamount=="")

 							 {

								alert(" Enter Advance Amount")

								document.a.advance.focus()

                 					         submitOK="false"

							 }
    							
							else if (Noints=="")

 							 {

								alert(" Enter No.of.Installment")

								document.a.instal.focus()

                 					         submitOK="false"

							 }
							 
							 else if (Dmonth=="")

 							 {

								alert(" Enter Dur/Month")

								document.a.due.focus()

                 					         submitOK="false"

							 }
							 
							 else if (Dstatus1=="")
						
 							 {
 
								alert(" Select Present or Closed")

								document.a.nam.focus()

                 					         submitOK="false"

							 }
							 
							 else if (Bamount=="")

 							 {

								alert(" Enter Balance Amount")

								document.a.bal.focus()

                 					         submitOK="false"

							 }
							 else if (Binst=="")

 							 {

								alert(" Enter Installment")

								document.a.binstal.focus()

                 					         submitOK="false"

							 }
							 							 		                    
						
						    if (submitOK=="false")
	
							 {
			
								 return false

 							 }
 	
		
					}	
			</script>




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
.style14 {color: #FFFFFF; font-weight: bold; }
-->
</style>



<script type="text/javascript">
function check(nam)
{
document.getElementById("answer").value=nam
}
</script>
</head>


<form  AUTOCOMPLETE = "off"   name="a" method="post" action="PayAdvanceAdd.jsp"
	onSubmit="return validate()">


<body  onpaste='return false;'>

<table width="870" border=0>
	<tr>
		<td width="216" rowspan="3" valign="top" background="../if">
		<div align="center"></div>
		</td>
		<td width="274" colspan="3" valign="top" background="../if">
		<table width="290" border="1" cellspacing="2" cellpadding="2">
			<tr>
				<td>Staff Name
				<div align="center"></div>
				</td>
				<td><select name="stname" id="sn">
					<option value="select">Select</option>
					<%

	//Loading JDBC Connection Information
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);	
		Properties jdbc = new Properties();
		jdbc.load(input);
		String driver = jdbc.getProperty("Driver");
		String url =jdbc.getProperty("UrlCol");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		//Database Connectivity
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();

		while(rst.next())
		{
			out.println("<option>"+rst.getString("chr_STAFFNAME")+"</option>");		
		}
		releaseJDBCResource();

	}catch(Exception ex)
	{
		//System.out.println(ex);
	}
		releaseJDBCResource();
%>

				</select></td>
			</tr>
			<tr>
				<td>Staff Id</td>
				<td><select name="stid" id="Sid">
					<option value="select">Select</option>
					<%

	//Loading JDBC Connection Information
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);	
		Properties jdbc = new Properties();
		jdbc.load(input);
		String driver = jdbc.getProperty("Driver");
		String url =jdbc.getProperty("UrlCol");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		//Database Connectivity
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();

		while(rst.next())
		{
			out.println("<option>"+rst.getString("chr_EMPID")+"</option>");		
		}
		releaseJDBCResource();

	}catch(Exception ex)
	{
		//System.out.println(ex);
	}
		releaseJDBCResource();
%>

				</select></td>
			</tr>
			<tr>
				<td>Year</td>
				<td><input type="text" name="year" id="yr"> </select></td>
			</tr>
			<tr>
				<td>Month</td>
				<td><input type="text" name="month" id="mo"></td>
			</tr>
			<tr>
				<td width="144">Advance Amount</td>
				<td width="126"><input type="text" name="advance" id="aa"></td>
			</tr>
			<tr>
				<td>No.Of.Installment</td>
				<td width="126"><input type="text" name="instal" id="noi"></td>
			</tr>
			<tr>
				<td>
				<div align="left">Due/Month</div>
				</td>
				<td><input type="text" name="due" id="dm"></td>
			</tr>
			<tr>
				<td>Due Status
				<td width="126"><input name="nam" type="radio"
					onclick="check(this.value)" value="p" id="p"> Present <input
					name="nam" type="radio" onclick="check(this.value)" value="c"
					id="cl">Closed</td>

				<td><input type="hidden" name="status" id="answer" size="20">
			</tr>
			<tr>
				<td>Balance Amount</td>
				<td width="126"><input type="text" name="bal" id="ba"></td>
			</tr>
			<tr>
				<td>Balance Installment</td>
				<td width="126"><input type="text" name="binstal" id="bl"></td>
			</tr>
		</table>
		</td>
		<td width="10" rowspan="2" valign="top" background="../if">
		<div align="right"></div>
		</td>
	</tr>
	<tr>
		<td colspan="3" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td width="67" valign="top" background="../if">&nbsp;</td>
		<td width="67" valign="top" background="../if"><input
			type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
		<td width="136" valign="top" background="../if">&nbsp;</td>
		<td valign="top" background="../if">&nbsp;</td>
	</tr>
</table>
<br>
<br>
</body>
</form>
</html>
