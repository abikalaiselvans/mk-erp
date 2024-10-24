<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>


<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

<script>
	$(function() {
		var dates = $( "#date, #pfdate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			minDate: -20, maxDate: "+2D" ,showOn: "button",
			onSelect: function( selectedDate ) {
				var option = this.id == "date" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});
	</script> 
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />

 

 
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="Cessation" action="../SmartLoginAuth"  onSubmit="return validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="563" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center"><strong><strong>Employee
							Cessation</strong><strong> Details </strong> <%
				   	String staff =request.getParameter("staffid");
                   	String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
					boolean flag =com.my.org.erp.SmartPayroll.StaffRegistration.cessationRecordExist(staff.trim()) ;
				   	if(flag==false)
					   response.sendRedirect("EmployeeCessation.jsp?staffid="+staff);
				   	String sql="";
				   	sql="SELECT DT_TERM_DATE,CHR_REASON,CHR_TER_TYPE,DAT_PFRESIGNDATE from pay_m_emp_termination "
						+" where CHR_EMPID='"+staff+"'";
				   	String cesValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				   	String msDate=DateUtil.FormateDateSys(cesValue[0][0]);
					String pfDate=DateUtil.FormateDateSys(cesValue[0][3]);
					 
			   %> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="19">
							<table width="377" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff id</td>
									<td class="boldEleven"><%=staff%> <input name="staffid"
										type="hidden" id="staffid" value="<%=staff%>"></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff name</td>
									<td class="boldEleven"><%=staffname %></td>
								</tr>
								<tr>
									<td width="140" valign="middle"  
										class="boldEleven">Type of cessation</td>
									<td width="170" class="boldEleven"> 
										
										<select name="cessation"  id="cessation">
									<option value="Abscond">Abscond</option>
									<option value="Terminate">Terminate</option>
									<option value="Resigned" selected="selected">Resigned</option>
									<option value="Long Leave">Long Leave</option>
									<option value="Better Opportunity">Better Opportunity</option>
									<option value="Foriegn Job">Foriegn Job</option>
									<option value="Family Problem">Family Problem</option>
									<option value="Start a business">Start a business</option>
									<option value="Personal Problem">Personal Problem</option>
									<option value="Health Problem">Health Problem</option>
									<option value="Higher Education">Higher Education</option>
									<option value="Manger Problem">Manger Problem</option>
									</select>
									<script language="javascript">setOptionValue('cessation','<%=cesValue[0][2] %>')</script>
										
								  </td>
								</tr>
								<tr>
									<td valign="middle"   class="boldEleven">Date
									of cessation<font color="#CC0000"> *</font></td>
									<td class="boldEleven"><input name="date" type="text"
										class="formText135" id="date" maxlength="11"
										value="<%=msDate %>" readonly="readonly">  </td>
								</tr>
								<tr>
                                  <td valign="top"   class="boldEleven">PF Date
                                    of cessation<font color="#CC0000"> *</font></td>
								  <td><input name="pfdate" type="text" class="formText135"
										id="pfdate" maxlength="11" value="<%=pfDate%>"  readonly="readonly">
                                       
                                  </td>
							  </tr>
								<tr>
									<td valign="top"   class="boldEleven">Reason</td>
									<td class="boldEleven"><textarea name="reason" cols="25"
										rows="5" class="formText135" id="reason"  onKeyPress="textArea('reason','500')"><%=cesValue[0][1] %></textarea></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
						</tr>
						<tr>
							<td height="19">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffCessation" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffCessationUpdate" /></div>
							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('EmployeeCessation.jsp')" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>

			</tbody>
		</table>
		</td>
	</tr>

	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>


<script language="javascript">
function validate() 
{
    if(checkNull("cessation","Type of Cessation ")
	&& checkNull("date","Date of Cessation")
	&& checkNull("pfdate","PF-Date of Cessation")
	&& checkNull("reason","Reason")
	 
	)
    	return true;
    else
    	return false;
}

  
</script>