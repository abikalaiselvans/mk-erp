<%@ page import="java.io.*,java.util.*" %>
<%@page import="com.my.org.erp.common.CommonInfo"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html>
<head>

<title>:: HRM ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 
 </style>
  <link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>
 <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="1001"><%@ include file="indexhrm.jsp"%>	</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="229" align="center"><TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
        </TR>
        <TR>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
        </TR>
        <TR>
          <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
          <TD width=425 valign="top">
          
          
          
          <form action="../SmartLoginAuth" method="post">

<table width="326" align="center" cellpadding="2" cellspacing="2">
<tr>
  <td colspan="2"><center>OFFER LETTER</center></td>
  </tr>
<tr class="boldEleven">
<td class="boldEleven">Application Id
  <input name="filename" type="hidden" id="filename" value="Rept_JStaffOfferLetter">
  <input name="actionS" type="hidden" id="actionS" value="HRMRept_JStaffOfferLetter">
  <input name="rptfilename" type="hidden" id="rptfilename" value="Hrmofferletternew"></td>
<td>
<select name="appid" id="appid" class="formText135"  style="width:170px;">
<%
String sql = "";
sql = " SELECT a.INT_APPID, CONCAT(a.CHR_APPCODE, '/',a.CHR_APPNAME)  FROM hrm_m_application a, hrm_t_offerletter  b  WHERE a.INT_APPID = b.INT_APPID AND b.CHR_ACCEPT ='Y'  ORDER BY a.CHR_APPNAME ";
String apptdata[][] =  CommonFunctions.QueryExecute(sql);
if(apptdata.length>0)
	for(int u=0;u<apptdata.length;u++)
		out.print("<option value='"+apptdata[u][0]+"'>"+apptdata[u][1]+"</option>"); 
 
%>
</select>

 </td>
</tr>
<tr>
  <td align="left"><span class="boldEleven">Export Type</span></td>
  <td align="center"><script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#export").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
        </script>
              <select name="export" class="formText135" id="export" style="width:170px;" >
                 <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
    <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
    <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
    <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
    <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
    <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
    <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
    <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
              </select></td>
</tr>
<tr>
  <td colspan="2" align="center"><table width="120" border="0" cellspacing="5" cellpadding="5">
    <tr>
      <td><input type="submit" class="formTableOuterDesign" value="Submit"/></td>
      <td><input name="Close" type="button"   class="formTableOuterDesign" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('HRMmain.jsp')"></td>
    </tr>
  </table></td>
  </tr>
</table>
</form>
          </TD>
          <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
          <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
          <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
        </TR>
        <TR>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
      </TBODY>
    </TABLE></td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>

<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
 </body>
</html>
