<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>

<title> :: PAYROLL ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript">
function validate()
{
	try
	{
		  
		  if(
				checkNull("advamount","Enter Advance Amount") 
				&& checkNullSelect('Month','Select Month','0')
				&& checkNullSelect('Year','Select Year','0')
			)
			{
				var balance=document.getElementById("balance").value;
			   	var advamount=document.getElementById("advamount").value;
			   	var am1= parseInt(advamount);
			   	var am2= parseInt(balance);
			   	if(am1>am2)
			   	{
					alert("Invalid Amount");
					document.getElementById("advamount").focus();
					return false;
			   	}
				else return true;
			}
			else
				return false;
			
			
	}
	catch(err)
	{
		alert(err);
		return false;
	}			
}



function cashreturn()
{
	try
	{
		 if(
				checkNull("advamount","Enter Advance  amount") 
				&& checkNullSelect('Month','Select Month','0')
				&& checkNullSelect('Year','Select Year','0')
			)
			{
				var balance=document.getElementById("balance").value;
				var advamount=document.getElementById("advamount").value;
				var staffid=document.getElementById("staffid").value;
				var Month=document.getElementById("Month").value;
				var Year=document.getElementById("Year").value;
				var am1= parseInt(advamount);
				var am2= parseInt(balance);
				if(am1>am2)
				{
					alert("Invalid Amount");
					document.getElementById("advamount").focus();
				}
				else if(checkNull("advamount","Enter Advance ") )
				{
					var ul="../SmartLoginAuth?filename=EmpAdvance&actionS=PAYAdvanceCashReturn&staffid="+staffid+"&balance="+balance+"&advamount="+advamount+"&Month="+Month+"&Year="+Year;
					location = ul;
				}
			}
		
		
	}
	catch(err)
	{
		alert(err);
		 
	}	 
	 
}
</script>
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

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="advance" action="../SmartLoginAuth" onSubmit="return validate()"
	method="post">
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
		<table width="500" border="0" align="center" cellpadding="0"
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
					<td width="7"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					
					
					<table width="500" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center"><strong>Staff Advance
							Deduction <%
				   	String staffid =request.getParameter("staffid");
				   	String sql="SELECT  A.CHR_EMPID,A.CHR_STAFFNAME from  com_m_staff  A where a.CHR_EMPID='"+staffid+"'";
				   	String perinfo[][] = CommonFunction.RecordSetArray(sql);
				   	sql="SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"' ";
				   	String advdata[][] = com.my.org.erp.common.CommonFunction.doubleRecordSetArray(sql);
					double advance=0.0,dtection=0.0;
					advance=Double.parseDouble(advdata[0][0]);
					sql="SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"' ";
					String detectdata[][] = com.my.org.erp.common.CommonFunction.doubleRecordSetArray(sql);
					dtection=Double.parseDouble(detectdata[0][0]);
					//out.print(advance);
					//out.print(dtection);
					%> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><font color='red'>* </font><span
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
							<td height="19">&nbsp;</td>
						</tr>
						<tr>
							<td height="19">
							
							
							<table width="278" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="119" align="left" valign="middle"
										  class="boldEleven">Staff id</td>
									<td width="145" class="boldEleven"><%=perinfo[0][0]%></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Staff Name</td>
									<td class="boldEleven"><%=perinfo[0][1]%></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Balance</td>
									<td class="boldEleven"><%=(advance-dtection)%> 
									<input type="hidden" name="staffid"  id="staffid"  value="<%=perinfo[0][0]%>">
									<input name="balance" type="hidden" id="balance" value="<%=(advance-dtection)%>"></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Month</td>
									<td class="boldEleven"><%@ include
										file="../JavaScript/month.jsp"%></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Year</td>
									<td class="boldEleven"><%@ include
										file="../JavaScript/year.jsp"%></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Deduction  Amount</td>
									<td class="boldEleven"><input name="advamount" type="text"
										class="formText135" id="advamount"
										 onKeyPress="return numeric_only(event,'advamount','10')"  size="10"
										maxlength="8"></td>
								</tr>
								 
								

							</table>
							
							
							
							
							</td>
						</tr>
						<tr>
							<td height="19"></td>
						</tr>
						<tr>
							<td height="19">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="EmpAdvance" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffAdvanceRecovery" /></div>
							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="75"><input type="submit" name="Submit"
										id="submit_btn" class="ButtonHead" value="Advance Recovery" /></td>
									<td width="75"><input name="retruncsh" type="button" class="ButtonHead" id="retruncsh" onClick="cashreturn()" value="Cash Retun"></td>
									<td width="75"><input type="button" name="submit"
										class="ButtonHead"  value="Close"   accesskey="c" 
										onClick="redirect('Advance.jsp')" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="7"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2">
					<div align="right">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</div>
					</td>
					<td height="13"><spacer height="1" width="1" type="block"></td>
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
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>