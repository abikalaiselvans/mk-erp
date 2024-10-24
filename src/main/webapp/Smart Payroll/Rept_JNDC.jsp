<%@ include file="index.jsp"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='PAY' ")[0][0]%></title>
 
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript">
function mainPage()
{
	    document.f1.action="Payrollmain.jsp";
		document.f1.submit();
		return true;
}
function Validate()
{
	if(  
			checkNullSelect( "reportType","Select Export Type" ,'0') 
			
		  )
			return true;
		else
			return false;	
}
	
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>

 <link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>


<form  AUTOCOMPLETE = "off"   name="f1" action="../SmartLoginAuth" onSubmit="return Validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<br>
		
				<% String hLinkName = request.getParameter("hLinkName");
				String heading = request.getParameter("heading");
				
				%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="80">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="307"
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

					<table width="280" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" class="BackGround" > <%=heading%> </td>
						</tr>
						<tr>
						  <td width="95" height="19" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td width="185"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr>
						  <td height="28" valign="middle" class="bolddeepblue style1"><span class="boldEleven">Export Type</span> <span class="bolddeepred">*</span> </td>
						  <td valign="middle">
                          
                          <script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#reportType").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
</script>
  <select name="reportType" id="reportType" style="width:150px;" >
    <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
    <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
    <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
    <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
    <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
    <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
    <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
    <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
  </select>						  </td>
					  </tr>
						<tr>
						  <td valign="middle" height="19" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit"
										name="Submit2" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold14" type="Button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
								</tr>
							</table>
							<input name="rptfilename2" type="hidden" id="rptfilename2" value="abortCase">
							<input name="rptfilename3" type="hidden" id="rptfilename3" value="needFinalClose">
							</div>							</td>
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
		<td>
		<table width="150" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				<td><input type="hidden" name="filename" value="Rept_JNDCReports">
				<input type="hidden" name="actionS" value="PAYRept_JNDCReports">
		
				<input name="hLinkName" type="hidden" id="rptfilename" value=<%=hLinkName%>>
				<input name="rptfilename" type="hidden" id="rptfilename" value="NDC">
				<input name="rptfilename1" type="hidden" id="rptfilename1" value="revisionList"></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
</table>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
