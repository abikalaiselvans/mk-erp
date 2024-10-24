<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%
try
{
%>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>:: INVENTORY :: </title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style><link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/LoadBranchAjax.js"></script> 
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script>
 $(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeYear: true,
			changeMonth: true,maxDate: "+0D" ,
			numberOfMonths: 1,
			showOn: "button",
				buttonImage: "../JavaScript/jquery/images/calendar.gif",
				buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdate" ? "minDate" : "maxDate",
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
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript">
function Validate()
  {
  var r1=document.getElementById('mr').checked;
    var r2=document.getElementById('mnr').checked;
    	if(checkNullSelect( "company","Select Company" ,'0')  
	 	&&checkNull("fromdate","Enter the From Date")
		&&checkNull("todate","Enter the To Date")
		&& DateCompares ('fromdate','todate', 'Fromdate shoul not be greaterthan the  To Date')
		&& checkNullSelect( "reportType","Select Export Type" ,'0') )	
		return true;
		else if(r1="" && r2=="")
		{
		
		}
	else
	return false;
}
</script>
<script language="javascript">

function disable()
{
	document.getElementById('pf').disabled = true;
	document.getElementById('esi').disabled = true;
	document.getElementById('cpyesi').disabled = true;
	document.getElementById('cpypf').disabled = true;
	document.getElementById('ctc').disabled = true;
	document.getElementById('empid').disabled = true;
	document.getElementById('empname').disabled = true;
	document.getElementById('basic').disabled = true;
	document.getElementById('rivisiondate').disabled = true;
	document.getElementById('officename').disabled = true;
	document.getElementById('depts').disabled = true;
	
}
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

</head>
<body  onpaste="return false;" >
<%@ include file="indexinv.jsp"%>

<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
		<td height="200">
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
					<table width="369" height="300" border="0" cellpadding="2" cellspacing="0"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround">STAFF PRODUCT ASSET </td>
						</tr>

						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td valign="top" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr>
						<td width="142" height="28" valign="middle" class="boldEleven">
							Company <span class="bolddeepred">*</span> </td>
							<td width="219"><select name="company" id="company"
								onBlur="loadBranch()" 
								class="formText135" style="width:200px">
								<option value="0">Select Company</option>
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
						  </select></td>
						</tr>
						<tr>
							<td width="142" height="28" valign="middle" class="boldEleven">
							Branch <span class="bolddeepred">*</span> </td>
							<td width="219"><select name="branch" id="branch"
								class="formText135" style="width:200px">
								<option value="0">All</option>
						  </select></td>
						</tr>	
							
						<tr class="bolddeepblue">
							<td width="142" height="24" valign="middle" class="style3"><span class="boldEleven">Office</span> <span class="bolddeepred">*</span> </td>
							<td width="219" valign="top" class="bolddeepblue">
							<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office">
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
						</tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="style3"><span class="boldEleven">Department</span> <span class="bolddeepred">*</span> </td>
							<td valign="top" class="bolddeepblue"><select name="Dept"
								id="Dept" class="formText135">
								<option value="0">All</option>
								<%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] =  CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="boldEleven">Material Status <span class="bolddeepred">*</span></td>
						  <td valign="top" class="bolddeepblue"><span class="boldEleven">
						   <label>
						    <input name="radiobutton" checked="checked" type="radio" value="All">
						    All</label>
						    <label>
						    <input name="radiobutton"  type="radio" value="Not Return">
						    Not Return</label>
							  <label>
						    <input name="radiobutton" type="radio" value="Return">
						    Return</label>
						  </span></td>
					  </tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="boldEleven">From Date <span class="bolddeepred">*</span></td>
						  <td valign="top" class="bolddeepblue"><span class="boldEleven">
						    <input   
												name="fromdate" type="text" class="formText135"
												id="fromdate" size="15" maxlength="10" readonly
												  />
						     <script language='JavaScript' type="text/javascript">
			setCurrentDate('fromdate');
	                              </script>
						  </span></td>
					  </tr>
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">To Date <span class="bolddeepred">*</span></td>
							<td valign="top" class="bolddeepblue"><span class="boldEleven">
							  <input readonly 
												name="todate" type="text" class="formText135" id="todate"  
												size="15" maxlength="10"  />
												  <script
												language='JavaScript' type="text/javascript">
			setCurrentDate('todate');
	                              </script>
							</span></td>
						</tr>
						<tr class="bolddeepblue">
						  <td height="24" valign="middle" class="style4"><span class="boldEleven">Export Type</span> <span class="bolddeepred">*</span> </td>
						  <td valign="top" class="bolddeepblue"><span class="boldEleven">
						    <select name="reportType" id="reportType">
                              <option value="0">Select Export Type</option>
                              <option value="csv">CSV</option>
                              <option value="xls">Excel</option>
                              <option value="html">HTML</option>
                              <option value="pdf">PDF</option>
                              <option value="txt">Text</option>
                              <option value="rtf">Word</option>
                              <option value="xml">XML</option>
                          </select>
						  </span></td>
					  </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue"><span class="boldEleven">
							  <input name="filename" type="hidden" id="filename"
										value="Rept_JStaffProductAsset">
                              <input name="actionS"
										type="hidden" id="actionS"
										value="INVRept_JStaffProductAsset">
                              <input name="rptfilename" type="hidden" id="rptfilename" value="staffProductAsset">
                            </span></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Rept_JInventory.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
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
					<td colspan="2" rowspan="2"><img height="11"
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
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>