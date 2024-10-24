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


<title> :: ATTENDANCE ::</title>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
  
 <style type="text/css">
<!--
.style3 {font-size: 36px}
-->
 </style>
</head>

<script language="javascript">
function loadClear()
{
	document.getElementById('cardno').value="";
	document.getElementById('cardno').focus();
}
</script>
<script type="text/javascript">
var count=0;
function startTime()
{
	try
    {
		count=count+1; 
		if(count>=3)
			document.getElementById('cardno').focus();
		var today=new Date()
		var h=today.getHours()
		var m=today.getMinutes()
		var s=today.getSeconds()
		m=checkTime(m)
		s=checkTime(s)
		t=setTimeout('startTime()',500)
	}
	catch(err)
	{
		alert(err.description)
	}
}

function checkTime(i)
{
if (i<10) 
  {i="0" + i}
 
  return i
}
</script>
 

<body  onpaste="return false;" onLoad="loadClear(),startTime()"     >
 <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0"  >
  <tr>
  
  <td bgcolor="014E8D">
	<div align="center"><span class="tableTITLE1"><font size="8">ATTENDANCE</font>	    </span></div>		</td>
</tr>  
  <tr>
    <td>

      <table width="548" height="289"   border="0" align="center" cellpadding="0" cellspacing="0"  >
  <tr>
    <td width="99" rowspan="5"   align="center" valign="middle"><img src="../Image/scanner.gif" width="180" height="250"></td>
    <td width="449" height="168"   align="center">  <img src="../Image/main/1.jpg"></td>
  </tr>
  <tr>
    <td height="18" valign="top">
	  
	    
	      <div align="center">
	        <%
	String type=""+request.getParameter("type");
	String title="";
	if("SWS".equals(type)  )
		title="Single Entry With Shift";
	else if("SWOS".equals(type)  )
		title="Single Entry Without Shift";
	else if("MWS".equals(type)  )
		title="Multi Entry With Shift";
	else if("MWOS".equals(type)  )
		title="Multi Entry Without Shift";
	%>	
	          <b><%=title%></b></div></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="41" valign="top"><form AUTOCOMPLETE="OFF" action="proximityresponse.jsp" method="post" name="frm" id="frm">
      <div align="center">
        <table width="100" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="41">
<input name="cardno" type="text"  id="cardno" style="color:#DCE4F9;  background-color:#DCE4F9;   border:#DCE4F9" maxlength="13">
              <input name="type" type="hidden" value="<%=type%>">		  </td>
            </tr>
        </table>
      </div>
    </form>    </td>
  </tr>
  <tr>
    <td height="18"  valign="top"><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td><input name="Button" type="button" class="buttonbold13"  value="Close"   accesskey="c"  onClick="javascript:window.close()"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top">&nbsp;</td>
  </tr>
  
  <tr>
    <td width="99"   align="center" valign="middle">&nbsp;</td>
    <td height="18"  valign="top"><div align="center"></div></td>
  </tr>
</table></td>
  </tr>
</table>
</body>
</html>
