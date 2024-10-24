<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>:: Smart Campus ::</title>
  <%@ include file="JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="654" height="150" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td width="150" rowspan="7"><img src="Image/report/server.gif" height="150" width="150"></td>
      <td width="550" class="boldEleven">&nbsp;</td>
    </tr>
    <tr>
      <td class="boldEleven">&nbsp;</td>
    </tr>
    <tr>
      <td class="boldEleven">SmartCampus.... Unable to serve you 
      &nbsp;</td>
    </tr>
    <tr>
      <td class="boldEleven">Unfortunately  the <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_WEBSITE FROM m_company")[0][0] %> server has acted out in an unexpected way. &nbsp;</td>
    </tr>
    <tr>
      <td class="boldEleven">Hopefully  it will return to its helpful self if you try again in a few seconds. </td>
    </tr>
    <tr>
      <td class="boldEleven">&nbsp;</td>
    </tr>
    <tr>
      <td class="boldEleven"><div align="right"><a href="Login.jsp">click here to return </a></div></td>
    </tr>
  </tbody>
</table>
</body>
</html>
