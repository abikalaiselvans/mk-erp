 <%@ page import="com.my.org.erp.common.CommonFunctions"%><html>
<head>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<%
String dojlock =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];
%>


<script>
  var d1=new Date();
	var day1=d1.getDate();	
	var dojlock= "<%=dojlock%>";
	 
 $(function() {
		$( "#fdate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			minDate: -dojlock, maxDate: "+0D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
	
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="javascript">
 function Validate()
  {
  	if(
	
		checkNull("fdate","Enter the Settlement Day...")
		&& checkNull("ndcamount","Enter the NDC Amount")
		&& checkNull("description","Enter the description...")
		
		
	)
		return true;
	else
		return false;
		
		 
  }
</script>

<title> :: PAYROLL ::</title>


 
 
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
 

<table width="100%" height="412" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">

		
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

					<table width="400" height="124" border="0" align="center"
						  class="bolddeepblue">
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td width="390" height="28" colspan="3" align="center"
								valign="middle" class="boldgre">
							<div align="center">STOP SALARY  HOLD 
							
							<%
							String rowid = request.getParameter("rowid"); 
							String sql ="";
sql ="SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),CHR_MONTH,INT_YEAR, ";
sql = sql +" CHR_DESC,DATE_FORMAT(DAT_LOW,'%d-%m-%Y'),FIND_A_EMPLOYEE_ID_NAME(CHR_AUTHORAISEDBY) ";
sql = sql +"  FROM  pay_t_temporarysuspension  WHERE INT_ROWID= "+rowid;
String empdata[][]= CommonFunctions.QueryExecute(sql);
 
							

							%>
							</div>
							</td>
						</tr>
						 
						<tr>
							<td height="28" valign="middle" class="bolddeepblue">
							<table width="92%" border="0" align="center" cellpadding="3"
								cellspacing="2">
								<tr>
									<td width="41%" class="boldEleven"><span class="style13">Emp Id / Name  </span></td>
									<td width="59%" class="boldEleven"><%= empdata[0][0]%></td>
								</tr>
								<tr>
								  <td class="boldEleven">Month /Year </td>
								  <td class="boldEleven"><%= empdata[0][1] +" - "+ empdata[0][2]%></td>
							  </tr>
								<tr>
								  <td class="boldEleven">Last Working Day </td>
								  <td class="boldEleven"><%= empdata[0][4]%></td>
							  </tr>
								<tr>
								  <td class="boldEleven">Received Date </td>
								  <td class="boldEleven"><input title="dd/mm/yyyy" name="fdate"  id="fdate"  type="text" class="formText135" size="15" maxlength="10" />
								  <script language="JavaScript" type="text/javascript">setCurrentDate('fdate'); </script></td>
							  </tr>
								 
								<tr>
								  <td class="boldEleven">Deduction Amount </td>
								  <td class="boldEleven"><input name="ndcamount" type="text" class="formText135" id="ndcamount" 	size="15" maxlength="10" onKeyPress="return numeric_only(event,'ndcamount','10')"  onpaste="return false;">
								    <span class="style11" width="97"><span class="style13"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
								    <input
										type="hidden" name="filename" value="SalaryHold" />
                                    <strong><font
										color="#000000"><font size="1">
                                    <input
										type="hidden" name="actionS" value="PAYSalaryHoldNDC" />
                                    <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
                                    </font></font></strong></font></font></strong></font></font></strong></font></font></strong></font></font></strong></font></font></strong></font></span></span></td>
							  </tr>
								<tr>
								  <td class="boldEleven">NDC Status </td>
								  <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><input name="ndc" type="radio" value="Y" checked></td>
                                      <td class="boldEleven">Received</td>
                                      <td class="boldEleven"><input name="ndc" type="radio" value="N"></td>
                                      <td class="boldEleven">Pending</td>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
								  <td class="boldEleven">Received Description
								    <p>&nbsp;</p></td>
								  <td class="boldEleven"><textarea name="description" cols="25"
								rows="5" class="formText135" id="description"  onKeyPress="textArea('description','1000')"></textarea></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="29" valign="middle" class="bolddeepblue">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="ButtonHead" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Button" type="Button"
										class="ButtonHead"  value="Close"   accesskey="c" 
										onClick="redirect('Refresh.jsp')"></td>
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

</form>

		</td>
	</tr>
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td height="37">&nbsp;</td>
	</tr>
</table>


 
</body>
</html>
