<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%
String dojlock =CommonFunctions.QueryExecute("SELECT  INT_CESSATIONDATELOCK  FROM pay_m_basicsettings  WHERE INT_ID=1")[0][0];

%>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 
 
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

<script>
var dojlock = "<%=dojlock%>";
	$(function() {
		var dates = $( "#date, #pfdate" ).datepicker({
			defaultDate: "+1w",
			//changeMonth: true,
			
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			minDate: -<%=dojlock%>, maxDate: "+20D" ,showOn: "button",
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
	
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 -->
</style>	
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

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <body  onpaste="return false;" >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="Cessation" action="../SmartLoginAuth" onSubmit="return validate()">
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
							<td height="20" colspan="2">
							<div align="center" class="boldEleven"><span
								class="boldEleven"><strong>EMPLOYEE CESSATION </strong></span><strong></strong></div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						 
						<tr>
							<td height="19" colspan="2">
							<table width="337" border="0" align="center" cellpadding="2"
								cellspacing="0">
								<tr>
								  <td valign="middle"  
										class="boldEleven">Emp Id / Name
										<%
										String staffid = request.getParameter("staffid");
										String sql ="";
sql = " SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID), ";
sql = sql +" DATE_FORMAT(DAT_APPPLYDATE,'%d-%b-%Y') , DATE_FORMAT(DAT_LASTDATE,'%d-%m-%Y'), ";
sql = sql +" (DAT_LASTDATE <= DATE(NOW())), ";
sql = sql +" (  (MONTH(NOW()) = MONTH(DAT_LASTDATE)) AND (YEAR(NOW()) = YEAR(DAT_LASTDATE))   ) ,CHR_MODE  ";
sql = sql +" FROM pay_t_resignationletter WHERE CHR_EMPID='"+staffid+"' ";

 String datas[][] =  CommonFunctions.QueryExecute(sql);
										
										%>										 </td>
								  <td>
								  <%=datas[0][0]%>
								  <input name="ename" type="hidden" id="ename" value="<%=staffid%>"></td>
							  </tr>
								<tr>
								  <td valign="middle"  
										class="boldEleven">LWD</td>
								  <td class="errormessage"><%=datas[0][2]%></td>
							  </tr>
								<tr>
									<td width="140" valign="middle"  
										class="boldEleven">Type of Cessation</td>
									<td width="180">
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
									<option value="Double Entry Problem">Double Entry Problem</option>
									</select>									 </td>
								</tr>
								<tr>
									<td valign="middle"   class="boldEleven">Date
									of Cessation<font color="#CC0000">*</font></td>
									<td><input name="date" type="text" class="formText135"
										id="date" maxlength="11" readonly value="<%=datas[0][2]%>">	 </td>
								</tr>
								<tr>
								  <td valign="top"   class="boldEleven">PF Date
								  of Cessation<font color="#CC0000">*</font></td>
								  <td><input name="pfdate" type="text" class="formText135"
										id="pfdate" maxlength="11"  readonly="readonly"  value="<%=datas[0][2]%>">                                    </td>
							  </tr>
								<tr>
									<td valign="top"   class="boldEleven">Reason<font color="#CC0000">*</font></td>
									<td><textarea name="reason" cols="25" rows="5"
										class="formText135" id="reason" onKeyPress="textArea('reason','500')">RESIGNED</textarea></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2" align="left"class="boldred">
                            <%
							out.println("<br><b>Note *</b>");
							out.println("<br>Please check date of Joining <= date of Resigning ");
							out.println("<br>Attendance register should be mark for the month of resigning date");
							out.println("<br>Should be change whose are reporting to him or her");
							 
							%>
							
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffCessation" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffCessationMove" />
							  <input name="mode" type="hidden" id="mode" value="<%=datas[0][5]%>">
							</div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56">
			<%
			if("1".equals(datas[0][3]))
				out.println("<input type='submit' name='Submit' id='submit_btn' class='buttonbold14' value='Submit' />");
			else
				out.println("<font class='errormessage'>Check LWD</font>");	
			%>
									
									</td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('ResignationView.jsp')" /></td>
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
		<td height="23"><div align="center" class="bolddeepred">
							<div align="center">
							<%
					  String er=request.getParameter("er");
					  
					  if(!(er == null))
					  {
					  
					  	out.println(er);
						out.println("<script language='javascript'>alert('"+er+"')</script>");
						
					}
					  
					  %>
					   </div>
							</div></td>
	</tr>
	<tr>
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>

<script language="javascript">
function validate() 
{
    if(
	    checkNull("ename","Select Employee ") 
		&& checkNull("cessation","Type of Cessation ")
		&& checkNull("date","Date of Cessation")
		&& checkNull("pfdate","PF-Date of Cessation")
		&& checkNull("reason","Reason")
		 
	)
	{
    	
		return true;
	}
    else
    	return false;
}

  
</script>
 