<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
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

<title>Untitled Document</title>
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style4 {color: #FF0000; font-weight: bold; }
-->
</style>
</head>
<script type="text/javascript">
var c=0;
function startTime()
{
	var today=new Date();
	var h=today.getHours();
	var m=today.getMinutes();
	var s=today.getSeconds();
	
	var d=new Date()
	var day=d.getDate()
	if(day<10) day="0"+day;
	var month=d.getMonth() + 1
	if(month<10) month="0"+month;
	var year=d.getFullYear()
	
	// add a zero in front of numbers<10
	m=checkTime(m);
	s=checkTime(s);
	increment();
	if(c>=5)
		window.close();
	t=setTimeout('startTime()',5000);
}

function increment()
{
	c= c+1;
}

function checkTime(i)
{
	if (i<10)
  	{
  		i="0" + i;
  	}
	return i;
}
</script>
<body  onpaste='return false;'>
<table width="368" border="0" align="center" cellpadding="0" cellspacing="2" bgcolor="#0066CC">
  <tr>
    <td><DIV align="center" class="style1">
      <h3>Tech Updates/Special   Offers From <br>Mythra IT Solutions Pvt.   Ltd</h3>
    </DIV></td>
  </tr>
  <tr>
    <td><table width="368" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><img src="../images/logo.jpg" width="159" height="49"></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><span class="style4">You are successfully unsubscribed our communications. In future If you wish to subcribe please send mail a to </span></td>
      </tr>
      <tr>
        <td><table cellspacing="0" cellpadding="0">
          <TR>
            <TD class="style4">&nbsp;</TD>
          </TR>
          <TR>
            <TD class="style4"><div align="left">For Technical Updates / Technology   Information&rsquo;s &nbsp; <A href="mailto:#)">techupdate@test.net</A></div></TD>
          </TR>
          <TR>
            <TD class="style4"><div align="left">For Offers on Various Products/Services   <A href="#">offers@test.net</A></div></TD>
          </TR>
        </table>        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><div align="center"><span class="style4">With subject line &quot;SUBSCRIBE&quot; </span></div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><div align="center"><span class="style4">Thank you !!!!!.</span></div></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
