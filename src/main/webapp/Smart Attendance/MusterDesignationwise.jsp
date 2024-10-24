<%@ page import="java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.my.org.erp.bean.Designation"%>
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
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNullSelect("Designation","Select The Designation","select")){
		//document.a.submit();
		return true;
	}
	return false;
  }
  function mainPage()
  {
     document.M_Design.action="../RemoveSession";
   	 document.M_Design.submit();
  }
 
</script>
<%
	String viewType=request.getParameter("view");
%>
</head>

<form  AUTOCOMPLETE = "off"   name="M_Design" action="../SmartLoginAuth">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td height="100">&nbsp;</td>
	</tr>
	<tr>
		<td height="152">
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

					<table width="450" border="0" align="center"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="26" colspan="2" valign="top" 
								class="BackGround"><%=viewType %> Details - Designation
							Wise</td>
						</tr>
						<tr>
							<td width="204" height="28" valign="middle" class="bolddeepblue">
							Company</td>
							<td width="230"><select name="company" id="company"
								onChange="loadBranch()" class="bolddeepblue" style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="204" height="28" valign="middle" class="bolddeepblue">
							Branch</td>
							<td width="230"><select name="branch" id="branch"
								class="bolddeepblue" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						</tr>

						<tr>
							<td width="204" height="32" valign="middle" class="bolddeepblue">Select
							the Designation</td>
							<td width="230" valign="middle"><select name="Designation"
								class="bolddeepblue">
								<option value="select">Select</option>
								<%
            ArrayList designationList=(ArrayList) session.getAttribute("designationList");
  			for(int i=0;i<designationList.size();i++)
  			{
  				Designation designation= (Designation)designationList.get(i);

		%>
								<option value="<%= designation.getDesigId() %>">
								<% out.println(designation.getDesigName()); %>
								</option>
								<%
			}
		%>
							</select></td>
						</tr>
						<tr>
							<td height="32" valign="middle" class="bolddeepblue"><span
								class="bolddeepblue">Month</span></td>
							<td valign="middle"><strong class="tabledata"> <font
								size="1"><font size="1"> <%@ include
								file="../JavaScript/month.jsp"%> </font></font> </strong></td>
						</tr>
						<tr>
							<td height="33" valign="middle" class="bolddeepblue">Year</td>
							<td valign="middle"><strong class="tabledata"> <input
								type="hidden" name="filename" value="MusterMonth"> <%@ include
								file="../JavaScript/year.jsp"%> <input
								type="hidden" name="actionS" value="ATTMUSTERMONTHDESIG">
							</strong></td>
						</tr>
						<tr>
							<td height="33" colspan="2" valign="middle" class="bolddeepblue">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input class="buttonbold" type="submit"
										name="Submit" value="Submit"   accesskey="s"    onclick="return Validate()">

									</td>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onclick="redirect('Muster Details.jsp')"></td>

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
		<td></td>
	</tr>
	<tr>
		<td height="39">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>

</body>
</form>
</html>
