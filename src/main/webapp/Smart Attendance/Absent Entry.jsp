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


 <%
String dojlock=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>

</head>

<script language="javascript" src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	/*var d1=new Date();
	var day1=d1.getDate();	
	
	$(function() {
		$( "#fromdt" ).datepicker({ minDate: "-"+(day1-1), maxDate: "+"+(31-day1) });
	});  
	 
	
	
	$(function() {
		$( "#todt" ).datepicker({ minDate: "-"+(day1-1), maxDate: "+"+(31-day1) });
	});  */
	
	
	var dojlock= "<%=dojlock%>";
	 $(function() {
		$( "#fromdt" ).datepicker({ minDate: -dojlock, maxDate: "+8D" });
	});
	
	
	$(function() {
		$( "#todt" ).datepicker({ minDate: -dojlock, maxDate: "+8D" });
	});
	
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">






<script language="JavaScript">

 function Validate()
  {
  	
	var d1 = document.getElementById('fromdt').value;
	var d2 = document.getElementById('todt').value;
	var dd1 = d1.split("-");
	var dd2 = d2.split("-");
	var ds = compute(dd1[0],dd1[1],dd1[2]) ;
	if(ds=="Sunday")
	{
		alert("You are selecting Sunday");
		return false;
		
		
	}
	
	if(d1 != d2)
	{
	 	alert("Kindly select same date");
		return false;
	}
	
	var dd1 = d1.split("-");
	var dd2 = d2.split("-");
	var cm = dd1[1];
	var cy = dd1[2];
	 
	var sm = document.getElementById('smonth').value;
	var sy = document.getElementById('syear').value;
	var datelock = document.getElementById('dtflag').value;
	var l = true;
	if(datelock == "Y")
	{
		
		if((cm == sm) && (cy==sy))
			l = true;
		else
		{
			alert("Sorry, Attendance does not mark previous month...");
			l= false;
			return false;
		}
		
			
	}
	else
		l= true;
		
	
	if( (l) && checkNull("ename","Select Staff") 
	&& checkNull("fromdt","Select Date") 
	&& checkNull("todt","Select Date") 
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
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
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
									<div align="center" class="boldEleven"><strong>ABSENT ATTENDANCE</strong> /<span class="bold1"> UNPLANNED LEAVE </span></div>									</td>
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
											<td width="92" valign="middle"  
												class="boldEleven">From <font color='red'>*<span
												class="bolddeepblue"> <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %> </span></font></td>
											<td width="263" class="boldEleven"><input
												title="dd/mm/yyyy"  
												  name="fromdt"
												type="text" class="formText135" readonly id="fromdt" value="" size="15">
											<!--<a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>--> <script
												language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frm'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			setCurrentDate('fromdt');  	
			
		//-->
	  </script> ( dd-mm-yyyy )</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">To <font color='red'>*</font>											</td>
											<td class="boldEleven"><input title="dd/mm/yyyy"
												   name="todt"
												type="text" class="formText135" id="todt" readonly  value="" size="15">
											<!--<a href="javascript:cal2.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a> --><script
												language='JavaScript'>
		<!--
			var cal2 = new calendar1(document.forms['frm'].elements['todt']);
			cal2.year_scroll = true;
			cal2.time_comp = false;	
			setCurrentDate('todt');		 
		//-->
	  </script> ( dd-mm-yyyy )</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">Day <font color='red'>*</font></td>
											<td>
											<table width="232" border="0" cellspacing="1" cellpadding="1">
												<tr>
													<td width="20"><span class="bolddeepblue"> <input
														name="ComboDay" type="radio" value="Full Day" checked> 
													</span></td>
													<td width="47" class="boldEleven">Full Day</td>
													<td width="20" class="boldEleven"><span
														class="bolddeepblue"> <input name="ComboDay"
														type="radio" value="Forenoon"> 
													</span></td>
													<td width="52" class="boldEleven">Forenoon</td>
													<td width="20" class="boldEleven"><span
														class="bolddeepblue"> <input name="ComboDay"
														type="radio" value="Afternoon"> 
													</span></td>
													<td width="54" class="boldEleven">Afternoon</td>
												</tr>
											</table>											</td>
										</tr>
									</table>									</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<div align="center"></div>									</td>
								</tr>
								<tr>
								  <td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="StaffAbsent">
								    <input
										name="actionS" type="hidden" id="actionS" value="ATTAbsentAdd"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('Absent View.jsp')" /></td>
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
