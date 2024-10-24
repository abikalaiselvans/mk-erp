<%@ page import="java.sql.*,java.util.*,java.io.*"%>
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js">
</script>
<script language="javascript">
function disable()
{
	document.getElementById('Empid').disabled= true;
	document.getElementById('Name').disabled= true;
}
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="disable()">
<p><%@ include file="index.jsp"%></p>
<form  AUTOCOMPLETE = "off"   action="AttendanceAllResponse.jsp" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
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
					<table width="450" border="0" cellspacing="0" cellpadding="3"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">Attendance
							Report</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="20" valign="middle" class="boldEleven">Office</td>
							<td valign="top" class="boldEleven">
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
							<td height="19" valign="middle" class="boldEleven">Department</td>
							<td valign="top" class="boldEleven"><select name="dept"
								id="dept" class="formText135" onChange="init()">
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
							<td width="132" height="19" valign="middle" class="boldEleven">Month<font
								color='red'>&nbsp;</font></td>
							<td width="268" valign="top" class="boldEleven"><select
								name="month" id="month" class="formText135">
								 
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
							</select></td>
						</tr>
						<tr>
							<td class="boldEleven">Year</td>
							<td class="boldEleven"><select name="year" id="year"
								class="formText135">
								 
								<%
			      for(int i=2000;i<=2050;i++)
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
          </script></td>
						</tr>
						<tr>
							<td class="boldEleven">Order by</td>
							<td class="boldEleven"><select name="sorting">
								<option value="a.CHR_EMPID ">Empid</option>
								<option value="b.CHR_STAFFNAME">Staff Name</option>
								<option value="a.DOU_PRESENT">Present</option>
								<option value="a.DOU_ONDUTY">Onduty</option>
								<option value="a.DOU_SUNDAY">Sunday</option>
								<option value="a.DOU_HOLIDAY">Holiday</option>
								<option value="a.DOU_LEAVE">Leave</option>
								<option value="a.DOU_ABSENT">Absent</option>
								<option value="a.INT_LATE">Late</option>
								<option value="a.INT_PERMISSION">Permission</option>
								<option value="a.DOU_EXTRADAYS">Extra Day</option>
								<option value="a.DOU_EXTRAHOURS">Extra Hours</option>
								<option value="a.DOU_TOTALDAYS">Total days</option>
							</select></td>
						</tr>
						<tr>
							<td class="boldEleven"><span class="boldEleven">Sorted
							By </span></td>
							<td class="boldEleven"><select name="ss">
								<option value="asc">Ascending</option>
								<option value="desc">Descending</option>
							</select></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="100%" border="0" align="center" cellpadding="2"
								cellspacing="0">
								<tr>
									<td class="boldEleven"><input name="Empid" type="checkbox"
										id="Empid" checked></td>
									<td class="boldEleven">Empid</td>
									<td class="boldEleven"><input name="Name" type="checkbox"
										id="Name" checked></td>
									<td class="boldEleven">Staff Name</td>
									<td class="boldEleven"><input name="Present"
										type="checkbox" id="Present"></td>
									<td class="boldEleven">Present</td>
									<td class="boldEleven"><input name="Onduty"
										type="checkbox" id="Onduty"></td>
									<td class="boldEleven">Onduty</td>
									<td class="boldEleven"><input name="Sunday"
										type="checkbox" id="Sunday"></td>
									<td class="boldEleven">Sunday</td>
								</tr>
								<tr>
									<td class="boldEleven"><input name="Holiday"
										type="checkbox" id="Holiday"></td>
									<td class="boldEleven">Holiday</td>
									<td class="boldEleven"><input name="Leave" type="checkbox"
										id="Leave"></td>
									<td class="boldEleven">Leave</td>
									<td class="boldEleven"><input name="Absent"
										type="checkbox" id="Absent"></td>
									<td class="boldEleven">Absent</td>
									<td class="boldEleven"><input name="Late" type="checkbox"
										id="Late"></td>
									<td class="boldEleven">Late</td>
									<td class="boldEleven"><input name="Permission"
										type="checkbox" id="Permission"></td>
									<td class="boldEleven">Permission</td>
								</tr>
								<tr>
									<td class="boldEleven"><input name="Extraday"
										type="checkbox" id="Extraday"></td>
									<td class="boldEleven">Extra Day</td>
									<td class="boldEleven"><input name="Extrahours"
										type="checkbox" id="Extrahours"></td>
									<td class="boldEleven">Extra Hours</td>
									<td class="boldEleven"><input name="totaldays"
										type="checkbox" id="totaldays"></td>
									<td class="boldEleven">Total days</td>
									<td class="boldEleven"><input name="Allday"
										type="checkbox" id="Allday"></td>
									<td class="boldEleven">All Day</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="14" colspan="2" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('AttendanceMain.jsp')"></td>
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
</table>
</form>
<p><%@ include file="../footer.jsp"%></p>
</body>
</html>
