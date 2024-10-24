 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%
try
{
%> 
<html>
<head>

<title> :: PAYROLL ::</title>



 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 
 
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 



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
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <body  onpaste="return false;"  >
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
								class="boldEleven"><strong>NDC </strong></span><strong>
							ACCOUNTS DEPARTMENT </strong></div>							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						 
						<tr>
							<td height="19" colspan="2">
							 <%

							  String rowid = request.getParameter("Rowid");
							  String sql = " SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),DATE_FORMAT(DAT_ACCOUNTS_DATE,'%d-%m-%Y %H:%m:%s'),CHR_ACCOUNTS_DESC,CHR_ACCOUNTS,CHR_EMPID,DOU_ACCOUNTS   FROM   pay_t_emp_ndc   WHERE INT_NDCID ="+rowid;
							  
							  String Data[][] = CommonFunctions.QueryExecute(sql);
							  String acceptdate =Data[0][1];
							   
							  if("-".equals(acceptdate))
							  	acceptdate="";
   
							 %>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table width="337" border="0" align="center" cellpadding="2"
								cellspacing="0">
								<tr>
								  <td valign="top"   class="boldEleven">Staff ID/ Name </td>
								  <td class="boldEleven"><%=Data[0][0]%>
							      <input name="Rowid" type="hidden" id="Rowid" value="<%=rowid%>"></td>
							  </tr>
								<tr>
								  <td width="123" valign="top"   class="boldEleven"> Accept Date<font color="#CC0000"> *</font></td>
								  <td width="206" class="boldEleven">

<input name="acceptdate" type="text" class="formText135"  readonly="readonly" id="acceptdate" value="<%=acceptdate%>" size="25" maxlength="11">
<script language="JavaScript"> 
	if("" == "<%=acceptdate%>")
		setCurrentDateandTime('acceptdate'); 
</script>	

<script language="javascript">
 
$('#acceptdate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	minDate: -2, maxDate: "+1D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true
});

 
</script>								</td>
							  </tr>
								<tr>
								  <td valign="top"   class="boldEleven">Status <font color="#CC0000">*</font></td>
								  <td class="boldEleven">
								  <select name="status" id="status" style="width:150">
								  	<option value="0">Select Status</option>
									<option value="N">Pending</option>
								  	<option value="Y">Closed</option>
								  </select>
								  <script language="javascript">setOptionValue('status','<%=Data[0][3]%>')</script>								  </td>
							  </tr>
								<tr>
								  <td valign="top"   class="boldEleven">Payment  <font color="#CC0000">*</font></td>
								  <td class="boldEleven"><input name="amount" type="text" class="formText135" id="amount" onKeyPress="return numeric_only(event,'amount','12')"  maxlength="7"  value="<%=Data[0][5]%>"></td>
							  </tr>
								<tr>
									<td valign="top"   class="boldEleven">Reason<font color="#CC0000"> *</font></td>
									<td class="boldEleven"><textarea name="reason" cols="26" rows="5"
										class="formText135" id="reason" onKeyPress="textArea('reason','500')"><%=Data[0][2]%></textarea></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2" align="center" class="bolddeepred">
                              <center>
                                
                                 
<%

boolean aflag = false;
sql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+Data[0][4]+"' ";
String advdata[][] = CommonFunction.doubleRecordSetArray(sql);
double advance=0.0;
double dtection=0.0;
if(advdata.length>0)
	advance=Double.parseDouble(advdata[0][0]);


sql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+Data[0][4]+"' ";
String detectdata[][] = CommonFunction.doubleRecordSetArray(sql);
if(detectdata.length>0)
	dtection=Double.parseDouble(detectdata[0][0]);

if((advance-dtection)>0)
{
	out.println("Please close the Employee "+Data[0][0]+"  Advance Amount Rs."+(advance-dtection));
	aflag = true;
}	
 
sql = " select count(*) from conveyance_t_conveyance a, com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_STATUS='N' and a.CHR_EMPID  = '"+Data[0][4]+"' group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
String conveyance[][] = CommonFunctions.QueryExecute(sql);
if(conveyance.length>0)
	out.println("Please close conveyance...");
%>
                                
                            </center></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="NDC" /> 
							<input name="actionS"
								type="hidden" id="actionS" value="PAYNDCAccountsAccept" />
							</div>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56">
									
<%
//if(!aflag)
	//out.println("<input type='submit' name='Submit' id='submit_btn' class='buttonbold14' value='Submit' />");
%>
									
<input type='submit' name='Submit' id='submit_btn' class='buttonbold14' value='Submit' />
</td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('NDC_Accounts.jsp')" /></td>
								</tr>
							</table>							</td>
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
		<td height="40"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>

<script language="javascript">
function validate() 
{
    if(
		checkNull("acceptdate","Entr the Accept Date")
		&& checkNullSelect("status","Select Status",'0')
		&& checkNull("amount","Enter the Amount")
		&& checkNull("reason","Enter the description")

	 
	)
    	return true;
    else
    	return false;
}

  
</script>
 <%
if(aflag)
	out.println("<script language='javascript'>alert(\" Please close the Employee "+Data[0][0]+"   Advance Amount Rs. " +(advance-dtection)+" \" );</script>");

}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>