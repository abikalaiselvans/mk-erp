<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<%
String dojlock=CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM m_institution WHERE INT_ID=1 ")[0][0];
String empid = ""+session.getAttribute("EMPID");
String dsql = "SELECT IF( DATEDIFF(NOW(),DT_DOJCOLLEGE) >= 30 ,15,DATEDIFF(NOW(),DT_DOJCOLLEGE)) from com_m_staff WHERE CHR_EMPID ='"+empid+"'";
String dts = CommonFunctions.QueryExecute(dsql)[0][0];

String selfmarking="R" ;
String actionS ="STAStaffAttendanceMarkingRegister";
String rData[][] = CommonFunctions.QueryExecute("SELECT CHR_ATTENDANCE_SELFMARKING FROM att_m_basicsettings WHERE INT_ID=1 ");
if(rData.length>0)
	selfmarking = rData[0][0];
	
if("I".equals(selfmarking))	
	actionS ="STAStaffAttendanceMarkingIndividual";

%>
<%@include file="Redirect.jsp" %>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	var dojlock= "<%=dojlock%>";
	$(function() {
		$( "#fromdt" ).datepicker({ 
		
			changeMonth: true,changeYear: true,
			maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
		    maxDate: 0 });
	});
	
	 
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="javascript">
function  validate()
{
	try
	{
		if( checkNull('fromdt' ,'Enter the date') )
		  	return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit="return validate()" >
<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#dce4f9" class="BackGround">
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
      <td width="400" valign="top"><table width="90%" border="0" align="center" class="boldEleven"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle" class="tabledata">
          <td height="32" colspan="2" class="copyright"> 
            Attendance
            Marking<strong>
            <input type="hidden" name="filename" value="StaffAttendanceMarking">
            <input type="hidden" name="actionS" value="<%=actionS%>">
            <input name="empid" type="hidden" id="empid" value="<%=empid%>">
            <input name="selfmarking" type="hidden" id="selfmarking" value="<%=selfmarking%>">
            </strong></td>
        </tr>
        <tr>
          <td height="32" valign="middle" class="bolddeepblue">Date <span class="errormessage">*</span></td>
          <td valign="middle" align="left">
          <input name="fromdt" type="text" class="formText135" id="fromdt" readonly value="" size="15" /> 
		<script language='JavaScript' type="text/javascript">setCurrentDate('fromdt');</script></td>
        </tr>
        <tr>
          <td height="32" valign="middle" class="bolddeepblue">Day Type<span class="errormessage"> *</span></td>
          <td valign="middle" align="left"><table width="75%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="9%" class="boldEleven"><input name="LComboDay" type="radio" id="LComboDay" value="Full Day" checked /></td>
              <td width="24%" class="boldEleven">Full Day</td>
              <td width="9%" class="boldEleven"><input name="LComboDay" type="radio" id="LComboDay" value="Forenoon" /></td>
              <td width="24%" class="boldEleven">Forenoon</td>
              <td width="9%" class="boldEleven"><input name="LComboDay" type="radio" id="LComboDay" value="Afternoon" /></td>
              <td width="25%" class="boldEleven">Afternoon
                </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td width="122" height="32" valign="middle" class="bolddeepblue">Attendance Type <span class="errormessage">*</span></td>
          <td width="228" valign="middle" align="left">
          <select name="type"  id="type" class="formText135">
		                <option value="ABS">Absent</option>
		                <option value="PRE" selected>Present </option>
		                <option value="HOL">Holiday</option>
                        <option value="SUN">Sunday</option>
						<option value="PRE">Weekoff ( Consider as present )</option>
						<option value="PRE">Compoff ( Consider as Present )</option>
		                </select></td>
        </tr>
        <tr>
          <td colspan="2" valign="middle" class="bolddeepblue"><table width="100" border="0" align="center" cellpadding="2"
								cellspacing="2">
            <tr>
              <td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
              <td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										 onClick="redirect('iframeStaffMain.jsp')"></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
      <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
    </tr>
    <tr>
      <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
  </tbody>
</table>

</form>

</body>


</html>
