<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>

<title> :: COMMON ::</title>
<%@ include file="index.jsp"%>

 
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



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"  ></script>

 
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />


<script language="javascript">
$(function() {
		var dates = $( "#fdate, #tdate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "fdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	
</script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form  AUTOCOMPLETE = "off"   action="Rept_ServicecardcountResponse.jsp" method="post" name="frm">
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
							<td height="18" colspan="3"  class="BackGround">SERVICE CARD COUNT</td>
						</tr>
						<tr class="bolddeepblue">
							<td width="138" height="19" valign="middle" class="boldEleven">Company</td>
							<td valign="top" class="boldEleven"><select name="company"
								id="company" onChange="loadBranch()" class="formText135"
								style="width:200px">
								<option value="0">All</option>
								<%                  
     					 
     					String	branch1[][]=CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ORDER BY CHR_COMPANYNAME");
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
							<td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="19" valign="middle" class="boldEleven">Branch</td>
							<td valign="top" class="boldEleven"><span class="tabledata">
							<select name="branch" id="branch" class="formText135"
								style="width:200px">
								<option value="0">All</option>
							</select> </span></td>
							<td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="19" valign="middle" class="boldEleven">Office</td>
							<td valign="top" class="boldEleven">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office" style="width:200px">
								<option value="0">All</option>
								<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
							</select></td>
							<td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="19" valign="middle" class="boldEleven">Department</td>
							<td valign="top" class="boldEleven"><select name="dept"
								id="dept" class="formText135" style="width:200px">
								<option value="0">All</option>
								<%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
							<td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
						  <td height="19" valign="middle" class="boldEleven">Category</td>
						  <td valign="top" class="boldEleven"><select name="category"
								id="category" class="formText135" style="width:200px">
                            <option value="0">All</option>
                            <%
		sq="SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME FROM   com_m_employeecategory   ORDER BY  CHR_CATEGORYNAME";
		String category[][] = CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<category.length;u++)
			out.print("<option value='"+category[u][0]+"'>"+category[u][1]+"</option>"); 
	%>
                          </select></td>
						  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="19" valign="middle" class="boldEleven">Order by </td>
						  <td valign="top" class="boldEleven"><select name="orderby"
								class="formText135" id="orderby" style="width:200px">
                            <option value="a.CHR_STAFFNAME">Staff Name</option>
                            <option value="a.DT_DOJCOLLEGE">Joining  Date</option>
                          </select></td>
						  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="19" valign="middle" class="boldEleven">Including Resigned </td>
						  <td valign="top" class="boldEleven">
						  <select name="resigned" id="resigned" class="formText135">
						  <option value="0">All</option>
						  <option value="Y">Yes</option>
						  <option value="N">No</option>
						  </select>
						  </td>
						  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr class="bolddeepblue">
							<td height="19" valign="middle" class="boldEleven">From</td>
							<td valign="top" class="boldEleven">
<input  name="fdate" id="fdate"  type="text" class="formText135" size="22" maxlength="10"  readonly="readonly"  											title="dd-mm-yyyy"  tabindex="7"/></td>
							<td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="19" valign="middle" class="boldEleven">To</td>
							<td width="233" valign="top" class="boldEleven">
<input title="dd/mm/yyyy"   name="tdate" id="tdate" type="text" class="formText135" size="22" maxlength="10"  readonly="true" tabindex="52"/>
<script language="javascript">setCurrentDate('fdate');setCurrentDate('tdate');</script></td>
							<td width="61" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							</td>
						</tr>
						<tr>
							<td height="28" colspan="3" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Rept_Staff.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td colspan="2"></td>
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
