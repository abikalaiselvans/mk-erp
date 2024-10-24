<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
 
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>


<body   >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
					<td>
					<table cellspacing="2" cellpadding="2" width="99%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">SALES INSTALLATION 
									
									
									<%
				 						
String sql = " ";
String salesid = request.getParameter("salesid");
sql = " SELECT a.INT_INSTALLATIONID,a.CHR_SALESNO,   ";
sql = sql + " DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y'),   ";
sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),'<br>',c.CHR_ADDRESS1,'<br>',c.CHR_ADDRESS2,'<br>',c.CHR_MOBILE),d.CHR_DIVICODE,   ";
sql = sql + " b.CHR_CONTACTDETAILS,b.CHR_CONTACTNO,   ";
sql = sql + " a.CHR_SERIALNO,a.CHR_WARRANTY,DATE_FORMAT(a.DAT_INSTALLATION,'%d-%b-%Y %h:%i:%s'),a.CHR_EMPID,a.CHR_STATUS,a.CHR_REASON,b.INT_DIVIID  ";
sql = sql + " FROM inv_t_directsales_installation a, inv_t_directsales b, inv_m_customerinfo c,inv_m_division d   ";
sql = sql + " WHERE a.CHR_SALESNO  = b.CHR_SALESNO    ";
sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID   ";
sql = sql + " AND b.INT_DIVIID =d.INT_DIVIID   ";
sql = sql + " AND a.CHR_POSTPONE_FLAG ='N'   ";
sql = sql + " AND a.INT_INSTALLATIONID = "+salesid+" ";
//out.println(sql);
 String perdata[][]=CommonFunctions.QueryExecute(sql); 
				
									%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
                              <td width="23%" valign="top" class="bold1"><div align="left">Sale .No</div></td>
							  <td width="22%" valign="top" class="boldEleven"><div align="left"><%=perdata[0][1]%></div></td>
							  <td width="27%" valign="top" class="bold1"><div align="left">Sale Date</div></td>
							  <td width="28%" valign="top" class="boldEleven"><div align="left"><%=perdata[0][2]%></div></td>
						  </tr>
							<tr>
                              <td valign="top" class="bold1"><div align="left">CustomerName &amp; Address</div></td>
							  <td valign="top" class="boldEleven"><div align="left">
                                  <%=perdata[0][3]%>
                              </div></td>
							  <td valign="top" class="bold1"><div align="left">Contact Person  </div></td>
							  <td valign="top" class="boldEleven"><div align="left"><%=perdata[0][5]%></div></td>
						  </tr>
							
							<tr>
							  <td valign="top" class="bold1">Division</td>
							  <td valign="top" class="boldEleven"><%=perdata[0][4]%></td>
							  <td class="bold1">Contact Phone </td>
							  <td class="boldEleven"><%=perdata[0][6]%></td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Assign Date &amp; Time </td>
							  <td valign="top" class="boldEleven"><%=perdata[0][9]%></td>
							  <td class="bold1">Updation Date and Time <span class="bolddeepred">*</span></td>
							  <td class="boldEleven">
							   <span class="boldEleven">
							    
								<input tabindex="2" name="updationdate" readonly type="text" class="formText135" id="updationdate" size="25" >
							    </span> <span class="boldEleven">
								
								 
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				 
				setCurrentDateandTime('updationdate'); 
		//-->
                                </script>
								
								
								<script language="javascript">

 

$('#updationdate').datetimepicker({
	numberOfMonths: 1,
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	minDate: 0,
	maxDate: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true
});
</script>
							    </span>							  </td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Status <span class="bolddeepred">*</span></td>
							  <td valign="top" class="boldEleven"><table width="112" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="boldEleven"><input name="status" type="radio" value="Y" checked></td>
                                  <td class="boldEleven">Closed</td>
                                  <td class="boldEleven"><input name="status" type="radio" value="P"></td>
                                  <td class="boldEleven">Postponed</td>
                                </tr>
                              </table></td>
							  <td rowspan="4" align="left" valign="top" class="bold1">Description <span class="bolddeepred">*</span>
                                <input name="filename" type="hidden" value="SalesInstallation" />
                                <input name="actionS"
									type="hidden" value="INVSalesInstallationUpdate" />
                                <input name="salesid" type="hidden" id="salesid" value="<%=salesid%>">
                                <input name="division" type="hidden" id="division" value="<%=perdata[0][13]%>">
                                <input name="salesno" type="hidden" id="salesno" value="<%=perdata[0][1]%>"></td>
							  <td rowspan="4" class="boldEleven"><textarea name="description" cols="22" rows="5" id="description" onKeyPress=" textArea('description','1900')"></textarea></td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Reason <span class="bolddeepred">*</span></td>
							  <td valign="top" class="boldEleven">
							  <select name="reason" id="reason">
								  <option value="0" selected="selected">Select Reason</option>
								  <option value="1">Customer not available</option>
								  <option value="2">Customer Address incorrect</option>
								  <option value="3">Customer place Auditing</option>
								  <option value="4">Power Failure</option>
								  <option value="5">Product not available</option>
								  <option value="6">Others</option>
								  <option value="7" >Call closed</option>
							    </select>	
								<script language="javascript">setOptionValue('reason','<%=perdata[0][12]%>')</script>						  </td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Serail Number </td>
							  <td valign="top" class="bolddeepred"><%=perdata[0][7]%></td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Warranty</td>
							  <td valign="top" class="bolddeepred"><%=perdata[0][8]%> - yrs</td>
						  </tr>
							 
							
							
							 

							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="250" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td width="60">
										 <input name='Submit' id='Submit' type='submit'class='buttonbold13' value='Updation' >										 										</td>
										<td width="60"><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('InstallationUpdationView.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
</table>
<script language="JavaScript">

function Validate()
  {

	 
	 	
	if( 
	
	 checkNull( "updationdate","Enter Updation date and time" )
	 && checkNullSelect( "reason","Select The reason", '0' )
	 && checkNull( "description","Enter the Description" )
 	
	)
		return true;
	else
		return false;				
		
 } 	
 
  
 
  
	
  
</script> 
<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>