<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
function Validate()
  {
	
  	if(checkNullSelect( "reportType","Select Export Type" ,'0'))	
			return true;
  	else
 			return false;	
  }
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<body  onpaste='return false;'><%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="a" action="../SmartLoginAuth" onSubmit="return Validate()">

<table width="100%">
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
<tr><td>

<table width="300" border="0" align="center" cellpadding="0"
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
      <td width="577" valign="top"><table width="350" align="center" border="0"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle" class="tabledata">
          <td height="32" colspan="2" class="boldEleven"><%
		String comId=request.getParameter("compId");
		String branchId=request.getParameter("branchId");
		out.println("<input type='hidden' name='company' value='"+comId+"'>");
		out.println("<input type='hidden' name='branch' value='"+branchId+"'>");	
		String empid = ""+session.getAttribute("EMPID");
	  %>
           Report</td>
        </tr>
      
         
        <tr>
          <input name="empid" type="hidden" id="empid" value="<%=empid%>">
          <td height="30" class="boldEleven">Export Type <font
																class="bolddeepred" align="absmiddle">*</font></td>
          <td width="61%" class="boldEleven"><script language="javascript" type="text/javascript">
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
            <select name="reportType" id="reportType" style="width:170px;">
              <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
              <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
              <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
              <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
              <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
              <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
              <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
              <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
              </select></td>
          <br>
          <br>
          
</tr>
                      
        <tr>
          <td height="33" align="left" valign="top" class="boldEleven">Year </td>
          <td valign="middle"><strong>
            <select name="year"
								id="year" class="formText135">
              
              <%@include file="../JavaScript/years.jsp" %>
            </select>
            <script language="JavaScript">
                             var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						 
						setOptionValue('year',year1);
                                </script>
          </strong></td>
        </tr>
        <tr>
          <td class="boldEleven">&nbsp;</td>
          <td class="boldEleven"><input name="filename" type="hidden" id="filename"
										value="Rept_JuserBalanceLeaveStatus">
            <input name="actionS"
										type="hidden" id="actionS"
										value="ATTRept_JuserBalanceLeaveStatus">
            <input name="rptfilename" type="hidden" id="rptfilename" value="userBalanceLeaveStatus"></td>
          
        </tr> 
        <tr>
          <td height="33" colspan="2" valign="middle" class="bolddeepblue"><table width="100" border="0" align="center" cellpadding="2"
								cellspacing="2">
            <tr>
              <td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
              <td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="javascript:history.back();"></td>
            </tr>
          </table>
                </td>
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
</td></tr>
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
