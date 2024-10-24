<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>Untitled Document</title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/ISD.js"></script>

</head>

<body  onpaste='return false;'>
<table width="100%" border="0" cellspacing="4" cellpadding="3">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<div class="Center_panel">
            <div class="banner">
              <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#D9E3EF">

                <tr>
                  <td>
                    <table width="64%" border="0" align="center" cellpadding="2" cellspacing="2">
                      <tr>
                        <td width="35%">&nbsp;</td>
                        <td width="36%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="2" class="boldgre"><div align="center" class="style3 style4">ISD CODES </div></td>
                      </tr>
                      <tr>
                        <td class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SEARCH : </td>
                        <td class="boldEleven"><table width="80" border="0" cellspacing="2" cellpadding="2">
                            <tr>
                              <td><input   name="search" type="radio" value="N" checked="checked" onClick="document.getElementById('searchvalue').value='N'" /></td>
                              <td>&nbsp;Name</td>
                              <td><input  name="search" type="radio" value="C" onClick="document.getElementById('searchvalue').value='C'"/></td>
                              <td>Code</td>
                              <td><input name="searchvalue" type="hidden" id="searchvalue" value="N" /></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td class="boldthikass">Enter City Name/Code:</td>
                        <td class="boldEleven"><input name="textfield" type="text" class="formText135" size="25"    onkeyup="LoadISD(this)"/></td>
                      </tr>

                      <tr>
                        <td colspan="2" class="boldEleven">	<div id="GroupTable" style="OVERFLOW:auto;width:100%;height:auto" class="boldEleven"></div><div id="er"></div>												</td>
                      </tr>
                      <tr>
                        <td colspan="2" class="boldEleven">&nbsp;<div id="totalrec"></div></td>
                      </tr>
                    </table>
                                                     
                  </td>
                </tr>
              </table>
            </div>
            
          </div>
	 </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
