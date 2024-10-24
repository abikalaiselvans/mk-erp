<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;	
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNullSelect("Department","Select Department","select") && checkNullSelect("Month","Select Month","select")&&(checkNullSelect("Year","Select Year","select"))){
		document.a.submit();
		return true;
	}
	return false;
  }
  
  function mainPage()
  {
   document.a.action="AttendanceMain.jsp";
   document.a.submit();
  } 
 
</script>
<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style11 {font-size: 12px}
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style13 {font-family: Verdana; font-size: 12px; font-weight: bold; }
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" action="../SmartLoginAuth" onsubmit="return Validate()">
<body  onpaste='return false;'>
<table width="100%" border="0">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="83">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="350" align="center" border="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="27" colspan="2" class="BackGround" >Late
							Comers Department Wise</td>
						</tr>
						<tr>
							<td width="177" height="28" valign="middle" class="tabledata">
							Company</td>
							<td width="247"><select name="company" id="company"
								onChange="loadBranch()" class="tabledata" style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="177" height="28" valign="middle" class="tabledata">
							Branch</td>
							<td width="247"><select name="branch" id="branch"
								class="tabledata" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						</tr>

						<tr>
							<td width="177" height="29" valign="middle"><span
								class="tabledata">Department</span></td>
							<td width="247" valign="middle"><span class="style11">
							<select name="Department" class="tabledata">
								<option value="select">Select</option>
								<%
try
	{
		con=conbean.getConnection();
	   	st=con.createStatement();
		rs = st.executeQuery("SELECT * FROM   com_m_depart  ");
	while(rs.next())
	{
%>
								<option value='<%= rs.getString("int_departid") %>'>
								<% out.println(rs.getString("chr_DepartName"));%>
								</option>
								<%
	}
	rs.close();
	}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
%>
							</select> </span></td>
						</tr>
						<tr>
							<td height="28" valign="middle" class="bolddeepblue"><span
								class="tabledata">Month</span></td>
							<td valign="middle"><span class="style11"> <select
								name="month" class="tabledata" id="month">
								<option value="select">Select</option>
								<option value="01">January</option>
								<option value="02">February</option>
								<option value="03">March</option>
								<option value="04">April</option>
								<option value="05">May</option>
								<option value="06">June</option>
								<option value="07">July</option>
								<option value="08">August</option>
								<option value="09">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
							</select> </span></td>
						</tr>
						<tr>
							<td height="28" valign="middle" class="bolddeepblue"><span
								class="tabledata">Year</span></td>
							<td valign="middle"><span class="style11"> <select
								name="year" class="tabledata" id="year">
								<option value="select">Select</option>
								<%
		         for(int i=2000;i<=2020;i++)
		     	 {
		    	   out.println("<option value="+i+">"+i+"</option>");
		     	 }
		     %>
							</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> <input type="hidden" name="filename" value="LateComers">
							<input type="hidden" name="actionS"
								value="ATTLateComersDepartmentList"> </span></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="javascript:history.back();"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td><span class="style8"> <%@ include file="../footer.jsp"%>
		</span></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	</tr>
</table>
<p class="style8"><br>
</p>
</body>
</html>
