<%@ page import="java.io.*,java.util.*,java.lang.String"%>
<%@ include file="index.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.my.org.erp.bean.payroll.Recovery"%>
<html>
<head>
<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 }
-->
</style> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" type="text/javascript">
	
	function Validate()
  {
  
  	if(checkNullSelect( "reportType","Select Export Type" ,'0'))	
		return true;
	else
	return false;
  }
</script>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript">

    </script>
<body  onpaste='return false;'>

<form  AUTOCOMPLETE = "off"   name="a" method="get" action="../SmartLoginAuth"
	onsubmit="return Validate();">
  <p>
   <%
	String empid =request.getParameter("empid");
	%> 
  </p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table class="BackGround" cellspacing="0" cellpadding="0" width="344"
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
            <td width="412"><table width="330" border="0" cellspacing="2" cellpadding="2"
						 >
                <!--DWLayoutTable-->
                <tr align="center" valign="middle">
                  <td height="45" colspan="2"  class="BackGround"><div align="center">
                    <p>Resignation Letter cum Experience Certificate  </p>
                    </div></td>
                  </tr>
                <tr  height="30">
                  <td width="112" valign="middle" class="bolddeepblue"><div align="right" class="boldEleven">
                    <div align="left">Export Type <span class="bolddeepred">*</span></div>
                  </div></td>
                  <td width="204" height="24" valign="middle" >
				    
			           
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
  <select name="reportType" id="reportType" style="width:170px;" >
    <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
    <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
    <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
    <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
    <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
    <option value="rtf" selected title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
    <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
    <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
  </select>
              
		                      </td>
                  </tr>
				  <tr><td><input name="filename" type="hidden" id="filename"
										value="Rept_JExportResigningLetter">
                 <input name="actionS"
										type="hidden" id="actionS"
										value="PAYRept_JExportResigningLetter">
                  <input name="rptfilename1" type="hidden" id="rptfilename1" value="ResigningLetter_lesser6Monthsnew"> 
                  <input name="rptfilename2" type="hidden" id="rptfilename2" value="ResigningLetter_greater6Monthsnew">
                  <input name="empid" type="hidden" id="empid" value="<%=request.getParameter("empid")%>"></td></tr>
                <tr height="30">
                  <td height="40" colspan="2" valign="middle" class="bolddeepblue"><table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
                            <tr>
                              <td width="61"><input name="Submit2" type="submit"
										class="buttonbold" id="submit" value="Submit"   accesskey="s"   ></td>
                              <td width="60"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
                            </tr>
                    </table></td>
                  </tr>
            </table></td>
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
      </table></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
 
	<%@ include file="../footer.jsp"%>
</table>
<br>

</form>
</body>
</html>
