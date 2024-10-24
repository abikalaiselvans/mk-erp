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
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">

 function Validate()
  {
  	 
		
	if( checkNull("ename","Select Staff") 
	&& checkNullSelect("month","Select Month","0") 
	&& checkNullSelect("year","Select Year","0") 
	
  	)
		return true;
	else
		return false;
  }
  
  
  
  
   
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"  onSubmit="return Validate()">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="591" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
					<tbody>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
						</tr>
						<tr>
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block"></td>
							<td width="577" valign="top">
							<table width="577" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center" class="boldEleven"><strong>ATTENDANCE RESET </strong><strong></strong></div>									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color='red'>* </font><span
										class="changePos">Mandatory</span></div>									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"><%@ include
										file="../JavaScript/ajax.jsp"%></div>									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="362" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
                                          <td width="92"><span class="boldEleven">Month<span
												class="bolddeepblue">
                                            <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %>
                                            <font color='red'>*</font></span></span></td>
										  <td width="263"><span class="boldThirteen">
                                            <select
												name="month" id="month" onChange="assign()">
                                              <%@ include file="../JavaScript/Inventory/month.jsp"%>
                                            </select>
                                          </span></td>
									  </tr>
										<tr>
                                          <td><span class="boldEleven">Year <font color='red'>*</font></span></td>
										  <td><span class="boldThirteen">
                                            <select
												name="year" id="year" onChange="assign()">
												<option value="0">Select Month</option>
                                              <%@ include file="../JavaScript/Inventory/year.jsp"%>
                                              <%
                              Calendar c1=new GregorianCalendar(2005,1,6);
                              
                              out.println(c1.getMaximum(Calendar.DAY_OF_MONTH));
                              Calendar cal = new GregorianCalendar(1999, Calendar.FEBRUARY, 1);
                              java.util.Date d = new java.util.Date();
                               
                              
                              out.println(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                              %>
                                            </select>
                                            <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                                        </script>
                                          </span></td>
									  </tr>
									</table>									</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<div align="center"></div>									</td>
								</tr>
								<tr>
								  <td width="49%" height="19"><input name="filename" type="hidden" id="filename" value="AttendanceCalculate">
								    <input name="actionS" type="hidden" id="actionS" value="ATTAttendanceResets">
								    <input name="value" type="hidden" id="value"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit" id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"     /></td>
											<td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')" /></td>
										</tr>
									</table>									</td>
								</tr>
							</table>
							</td>
							<td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
							<td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
							<td colspan="2" rowspan="2" valign="bottom">
							<div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div>
							</td>
						</tr>
						<tr>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
