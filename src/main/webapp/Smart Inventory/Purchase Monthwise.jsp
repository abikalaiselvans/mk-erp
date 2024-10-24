<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="indexinv.jsp"%>
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
<title>:: INVENTORY ::</title> <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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
<script language="JavaScript">
  function Validate()
  {
  	if(checkNullSelect("Month","Select Month","select")&& checkNullSelect("Year","Select Year","select")
  	&&checkNullSelect("vendorId","Select Vendor","select")
  	){
		document.a.submit();
		return true;
	}
	return false;
  }
  function mainPage()
  {
	    document.a.action="AttendanceMain.jsp";
		document.a.submit();
		return true;
  }
	  
 
</script>
<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style10 {font-family: Verdana; font-size: 12px; font-weight: bold; }
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth"
	onSubmit="return Validate()">
<body >
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td height="100">&nbsp;</td>
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
					<table width="450" border="0" align="center"  
						cellpadding="1" cellspacing="1">
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="26" colspan="4"   class="tablehead">Purchase
							- MonthWise</td>
						</tr>
						<tr>
							<td height="25" width="200" valign="middle" class="tabledata"><span
								class="tabledata">Month</span></td>
							<td width="253" colspan="2" valign="middle" class="formText135"><select
								name="Month">
								<option value="select">Select</option>
								<option value="1">January</option>
								<option value="2">February</option>
								<option value="3">March</option>
								<option value="4">April</option>
								<option value="5">May</option>
								<option value="6">June</option>
								<option value="7">July</option>
								<option value="8">Auguest</option>
								<option value="9">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
							</select></td>
						</tr>
						<tr>
							<td height="25" width="200" valign="middle" class="tabledata"><span
								class="tabledata">Year</span></td>
							<td colspan="2" valign="middle" class="formText135""><select
								name="Year">
								<option value="select">Select</option>
								<option value="2000">2000</option>
								<option value="2001">2001</option>
								<option value="2002">2002</option>
								<option value="2003">2003</option>
								<option value="2004">2004</option>
								<option value="2005">2005</option>
								<option value="2006">2006</option>
								<option value="2007">2007</option>
								<option value="2008">2008</option>
								<option value="2009">2009</option>
								<option value="2010">2010</option>
								<option value="2011">2011</option>
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014">2014</option>
								<option value="2015">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
							</select></td>
						</tr>
						<tr>
							<td class="tabledata">Select Vendor</td>
							<td class="formText135">
							<%
			  			Connection con1;
						ResultSet rs1;
			  			con1 = conbean.getConnection();
      					Statement st1 = con1.createStatement();      			
						rs1 = st1.executeQuery("SELECT * FROM INV_M_VENDORSINFO");
			  		%> <select name="vendorId" id="vendorId">
								<option value="select">Select</option>
								<option value="all">All</option>
								<%
							while(rs1.next())
							out.println("<option value='"+rs1.getString("INT_VENDORID") +"'>"+rs1.getString("CHR_VENDORNAME")+" </option>");
					   %>
							</select></td>
						</tr>
						<tr>
							<td class="tabledata" colspan="2">
							<table width="100" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold13" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold13" type="Button"
										name="Submit2"  value="Close"   accesskey="c" 
										onclick="javascript:history.back();"></td>
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
		<input type="hidden" name="filename" value="Report"> <input
			type="hidden" name="actionS" value="INV_purchaseMonthwise"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="135">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
