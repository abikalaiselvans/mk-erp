<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<html>
<head>
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


<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

function disable()
{
	document.getElementById('pf').disabled = true;
	document.getElementById('esi').disabled = true;
	document.getElementById('cpyesi').disabled = true;
	document.getElementById('cpypf').disabled = true;
	document.getElementById('ctc').disabled = true;
	document.getElementById('empid').disabled = true;
	document.getElementById('empname').disabled = true;
	document.getElementById('basic').disabled = true;
	document.getElementById('rivisiondate').disabled = true;
	document.getElementById('officename').disabled = true;
	document.getElementById('depts').disabled = true;
	

}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="disable()">
<%@ include file="index.jsp"%>
<!--SalaryReportResponse.jsp 
-->
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="OriginalSalaryResponse.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="200">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
					<table width="600" border="0" cellspacing="0" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">Original
							Salary Report</td>
						</tr>

						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td width="132" height="24" valign="middle" class="bolddeepblue"><strong>Office</strong></td>
							<td width="268" valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office">
								<option value="0">All</option>
								<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><strong>Department</strong></td>
							<td valign="top" class="bolddeepblue"><select name="Dept"
								id="Dept" class="formText135">
								<option value="0">All</option>
								<%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><strong>Order
							By </strong></td>
							<td valign="top" class="bolddeepblue"><select name="orderby"
								id="orderby" class="formText135">
								<option value=" a.CHR_EMPID ">Emp Id</option>
								<option value=" a.CHR_STAFFNAME ">Emp Name</option>
								<option value=" g.CHR_COMPANYNAME ">Company Name</option>
								,,
								<option value=" f.CHR_BRANCHNAME ">Branch Name</option>
								<option value=" b.CHR_OFFICENAME ">Office Name</option>
								<option value=" c.CHR_DEPARTNAME ">Department Name</option>
								<option value=" h.CHR_BANKNAME ">Bank Name</option>
								<option value=" a.DT_DOB ">Date of Birth</option>
								<option value="a.DT_DOJCOLLEGE ">Date of joinning</option>
								%>
							</select></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="100%" class="boldEleven">
									<table width="100%" border="0" align="center" cellpadding="0"
										cellspacing="0">
										<tr>
											<td colspan="6">&nbsp;</td>
										</tr>
										<tr>
											<td width="4%"><input name="empid" type="checkbox"
												readonly="readonly" id="empid" value="Y" checked></td>
											<td width="24%" class="boldEleven">Empid</td>
											<td width="4%"><input name="pf" type="checkbox" id="pf"
												value="Y" checked></td>
											<td width="27%" class="boldEleven">PF</td>
											<td width="3%"><input name="doj" type="checkbox"
												id="doj" value="Y"></td>
											<td width="38%" class="boldEleven">Date of Joining</td>
										</tr>
										<tr>
											<td><input name="empname" type="checkbox" id="empname"
												value="Y" checked></td>
											<td class="boldEleven">Emp Name</td>
											<td><input name="esi" type="checkbox" id="esi" value="Y"
												checked></td>
											<td class="boldEleven">ESI</td>
											<td><input name="dob" type="checkbox" id="dob" value="Y"></td>
											<td class="boldEleven">Date of Birth</td>
										</tr>
										<tr>
											<td><input name="basic" type="checkbox" id="basic"
												value="Y" checked></td>
											<td class="boldEleven">Basic</td>
											<td><input name="cpyesi" type="checkbox" id="cpyesi"
												value="Y" checked></td>
											<td class="boldEleven">Company ESI</td>
											<td><input name="dow" type="checkbox" id="dow" value="Y"></td>
											<td class="boldEleven">Date of wedding</td>
										</tr>
										<tr>
											<td><input name="bank" type="checkbox" id="bank"
												value="Y"></td>
											<td class="boldEleven">Bank Name</td>
											<td><input name="cpypf" type="checkbox" id="cpypf"
												value="Y" checked></td>
											<td class="boldEleven">Company PF</td>
											<td><input name="gender" type="checkbox" id="gender"
												value="Y"></td>
											<td class="boldEleven">Gender</td>
										</tr>
										<tr>
											<td><input name="acno" type="checkbox" id="acno"
												value="Y"></td>
											<td class="boldEleven">Account No.</td>
											<td><input name="ctc" type="checkbox" id="ctc" value="Y"
												checked></td>
											<td class="boldEleven">CTC</td>
											<td><input name="depts" type="checkbox" id="depts"
												value="Y" checked></td>
											<td class="boldEleven">Department Name</td>
										</tr>
										<tr>
											<td class="boldEleven"><input name="fname"
												type="checkbox" id="fname" value="Y"></td>
											<td class="boldEleven">Father Name</td>
											<td class="boldEleven"><input name="office"
												type="checkbox" id="office" value="Y"></td>
											<td class="boldEleven">Office Name</td>
											<td class="boldEleven"><input name="desig"
												type="checkbox" id="desig" value="Y"></td>
											<td class="boldEleven">Designation Name</td>
										</tr>
										<tr>
											<td class="boldEleven"><input name="bg" type="checkbox"
												id="bg" value="Y"></td>
											<td class="boldEleven">Blood Group</td>
											<td class="boldEleven"><input name="email"
												type="checkbox" id="email" value="Y"></td>
											<td class="boldEleven">Email</td>
											<td class="boldEleven"><input name="qualification"
												type="checkbox" id="qualification" value="Y"></td>
											<td class="boldEleven">Qualification</td>
										</tr>
										<tr>
											<td><input name="mobile" type="checkbox" id="mobile"
												value="Y"></td>
											<td class="boldEleven">Mobile</td>
											<td><input name="paddress" type="checkbox" id="paddress"
												value="Y">
											<DIV align="center"></DIV>
											</td>
											<td class="boldEleven">Permanent Address</td>
											<td><input name="caddress" type="checkbox" id="caddress"
												value="Y"></td>
											<td>
											<DIV align="center" class="boldEleven">
											<div align="left">Communication Address</div>
											</DIV>
											</td>
										</tr>
										<tr>
											<td><input name="cpyname" type="checkbox" id="cpyname"
												value="Y"></td>
											<td class="boldEleven">Company Name</td>
											<td class="boldEleven"><input name="bname"
												type="checkbox" id="bname" value="Y"></td>
											<td class="boldEleven">Branch Name</td>
											<td class="boldEleven"><input name="experience"
												type="checkbox" id="experience" value="Y"></td>
											<td class="boldEleven">Experience</td>
										</tr>
										<tr>
											<td><input name="rivisiondate" type="checkbox"
												id="rivisiondate" value="Y" checked></td>
											<td class="boldEleven">Rivision Date</td>
											<td class="boldEleven"><input name="advamount"
												type="checkbox" id="advamount" value="Y"></td>
											<td class="boldEleven">Advance Amount</td>
											<td class="boldEleven"><input name="officename"
												type="checkbox" id="officename" value="Y" checked></td>
											<td class="boldEleven">Office Name</td>
										</tr>
										<tr>
											<td><input name="resigned" type="checkbox" id="resigned"
												value="Y"></td>
											<td class="boldEleven">Resigned People</td>
											<td class="boldEleven">&nbsp;</td>
											<td class="boldEleven">&nbsp;</td>
											<td class="boldEleven">&nbsp;</td>
											<td class="boldEleven">&nbsp;</td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
