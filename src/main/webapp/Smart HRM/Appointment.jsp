<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>:: HRM ::</title>


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

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}

-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">

function validateFields()
{

	if(checkNullSelect('appNo','Select Application Number','0'))
	{
		alert("ok");
		document.frmAppointment.action="../SmartLoginAuth";
		document.frmAppointment.submit();
	}
	
	
//	&& checkNull('txtAppDt', 'Enter Application Date')
//	&& checkNull('txtInvDt', 'Enter Interview Date')
//	&& datechk()
}


function datechk()
{
		var d1 = document.frmAppointment.txtAppDt.value.split("-");
		var d2 = document.frmAppointment.txtInvDt.value.split("-");
		var y1 = d1[2];
		var y2 = d2[2];
		
		if (y2<y1)
		{
			alert("Please Enter Correct Date...");
			document.frmAppointment.txtInvDt.focus();
			return false;
		}	
		else if (d2[1]<d1[1])
		{		
			alert("Please Enter Correct Date...");
			document.frmAppointment.txtInvDt.focus();
			return false;
		}
		else if (d2[0]<d1[0])
		{		
			alert("Please Enter Correct Date...");
			document.frmAppointment.txtInvDt.focus();
			return false;
		}
		else
			return true;
}	




//------------ For Ajax Start ------------------------

var req;
var isIE;

function initRequest() 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}


function loadAppData (ctr) 
{
	var f ="../SmartHRM?actionS=AppointmentOrder&ID=" + ctr.value;
	initRequest();
	
	if (ctr.value!=0)
	{
		req.open('Get', f);
    	req.onreadystatechange = processResponse;
	    req.send(null);
	}
	else
	{
		document.getElementById('txtAppName').value = "";
		document.getElementById('txtAppoint').value = "";
		document.getElementById('txtAppDt').value = "";
		document.getElementById('txtSal').value = "";		
	}
}


function processResponse() 
{
    if(req.readyState == 4){
    	
		if (req.status == 200) {
	       var group = req.responseXML.getElementsByTagName("Appointments")[0];
    
			var name = group.childNodes[0].getElementsByTagName("name")[0].childNodes[0].nodeValue;  
			var title = group.childNodes[0].getElementsByTagName("title")[0].childNodes[0].nodeValue;
			var appdate = group.childNodes[0].getElementsByTagName("appdate")[0].childNodes[0].nodeValue;
			var salary= group.childNodes[0].getElementsByTagName("salary")[0].childNodes[0].nodeValue;

			document.getElementById('txtAppName').value = name;
			document.getElementById('txtAppoint').value = title;
			document.getElementById('txtAppDt').value = appdate;
			document.getElementById('txtSal').value = salary;
	     }
    }
}


function clearFields()
{

	document.getElementById('txtAppName').value = "";
	document.getElementById('txtAppoint').value = "";
	document.getElementById('txtAppDt').value = "";
	document.getElementById('txtInvDt').value = "";
	document.getElementById('txtSal').value = "";
	document.getElementById('appNo').focus();
	document.frmAppointment.appNo.options[0].selected=true;
}

</script>		


 
<script language="javascript" src="../JavaScript/commonAJAX.js"></script>
<style type="text/css">
<!--
.style3 {color: #000000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body  onpaste="return false;" onLoad="document.frmAppointment.appNo.focus()" >
<form  AUTOCOMPLETE = "off" method="get" name="frmAppointment" action ="../SmartLoginAuth">
<%@ include file="indexhrm.jsp"%>	
<table width="100%" height="293" align="center">
  <tr>
    <td>
	
	 
	</td>
  </tr>

  <!--DWLayoutTable-->
  <tr>
    <td height="21" colspan="6" align="center">  
  <tr>
    <td height="21" colspan="6" align="center">  

  <tr>
    <td height="80" colspan="6" align="center">    
        <table width="800" height="92" border="1" align="center" cellpadding="0" cellspacing="0"    >
          <!--DWLayoutTable-->
          <tr align="center" valign="middle"   background="">
            <td height="28"     class="tablehead"><span class="style3">Appointment Order </span></td>
          </tr>
           
          <tr class="BackGround">
            <td height="31" class="BackGround" >
            <table width="722" border="0" align="center" cellpadding="1" cellspacing="1">
              <tr>
                <td width="152" class="bold1"><span class="style3">Application Number </span></td>
                <td width="189" class="bold1"><span class="style3">
                  <select name="appNo" class="formText135" id="appNo" tabindex="1" onChange="loadAppData(this)">
					<option value="0">Select</option>
					
					<%
						String sql = "SELECT a.INT_APPID,c.CHR_APPCODE,c.CHR_APPNAME  FROM hrm_t_jobperformance a , hrm_m_application c WHERE a.CHR_APPLICATIONSTATUS='Q'  AND a.INT_APPID = c.INT_APPID  AND  a.INT_APPID   NOT IN ( SELECT b.INT_APPID FROM hrm_t_appoinment b) ";
						String AppData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
						for (int i=0; i<AppData.length; i++)
							out.println("<option value= '" +AppData[i][0]+ "'>" +AppData[i][1]+" /  " +AppData[i][2]+ "</option>");
					
					 %>
                    
                    
                  </select>
                </span></td>
                <td width="142" class="bold1"><span class="style3">Applicant Name </span></td>
                <td width="226" class="bold1"><input name="txtAppName" type="text" class="formText135" id="txtAppName" style="color:blue" readonly>
                <input type="hidden" name="hEmpId" id="hEmpId">
                </td>
                
              </tr>
            </table></td>
          </tr>
          <tr class="BackGround">
            <td height="31" class="BackGround" ><table width="100%" border="0" align="left" cellpadding="5" cellspacing="5">
              <tr>
              <td height="35" align="left">
			  <table width="723" border="0" align="center" cellpadding="1" cellspacing="1">
              <tr>
                <td width="150" height="30" class="boldEleven">Application Date </td>
				<td width="190"><input name="txtAppDt" type="text" class="boldEleven" id="txtAppDt" style="color:blue" onKeyPress="numericHypenOnly('txtAppDt', '9')" size="12" maxlength="10" readonly></td>
                <td width="143" class="boldEleven">Designation </td>
				<td width="227"><input name="txtAppoint" type="text" class="formText135" id="txtAppoint" style="color:blue" readonly></td>
				</tr>

				<tr>
				  <td height="35" align="left" class="boldEleven">Interview Date </td> 
					<td><input name="txtInvDt" type="text" class="formText135" id="txtInvDt" tabindex="2" onKeyPress="numericHypenOnly('txtInvDt', '9')" size="12" maxlength="10" readonly>
					<a href="javascript:cal2.popup();"><img src="../JavaScript/img/cal.gif" width="16" border="0" alt="Click here to Select the Date" /></a></td>
					<td height="27" align="left" class="boldEleven">Salary </td> 
					<td><input name="txtSal" type="text" class="formText135" id="txtSal" style="color:blue" onKeyPress="numericHypenOnly('txtAppDt', '9')" size="12" maxlength="15" readonly></td>
					</tr>
			  
 			    <tr>
 			      <td height="35" align="left" class="boldEleven">Status</td>
 			      <td><input type="checkbox" name="ChkStatus" id="ChkStatus" value="I" tabindex="4">
                    <span class="boldEleven">Issued</span></td>
 			      <td height="27" align="left" class="boldEleven"></td>
 			      <td>&nbsp;</td>
 			      </tr>
 			    <tr>
 			      <td height="35" align="left" class="boldEleven">Authority Name </td> 
					<td height="27" colspan="3">
					<select name="txtAuthority" class="formText135" id="txtAuthority"  >
					<%					

						sql = "SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_REP='Y' AND CHR_TYPE !='T' ";
						String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
						for (int i=0; i<Data.length; i++)
							out.println("<option value= '" +Data[i][0]+ "'>" +Data[i][0]+" /  " +Data[i][1]+ "</option>");
					
					 %>
                    </select>
					
					
					</td>
					</tr>


    <tr>
      <td height="20" colspan="6">    
    <tr>
      <td height="20" colspan="6"><table  border="0" align="center" cellpadding="2" cellspacing="2">
        <tr>
          <td  width="56"><input name="Save" type="button" class="tMLAscreenHead" id="Save" value="Save" onClick="validateFields()" tabindex="5"></td>
          <td  width="56"><input name="Clear" type="Button" class="tMLAscreenHead" id="Clear" value="Clear" tabindex="6" onClick="clearFields()"></td>
          <td  width="56"><input class="tMLAscreenHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')" tabindex="7"></td>
          <td  width="56"><input name="filename" type="hidden" id="filename" value="Appointment">
              <input name="actionS" type="hidden" id="actionS" value="HRMAppointmentAdd"></td>
        </tr>
      </table>    
</table></td></tr>
</table></td></tr></table><br><br>
      <%@ include file="../footer.jsp"%></td>
  </tr></table>

<script language="javascript">
  var cal1=new calendar1(document.getElementById('txtAppDt'));
  cal1.year_scroll=true;
  cal1.time_comp=false;

  var cal2=new calendar1(document.getElementById('txtInvDt'));
  cal2.year_scroll=true;
  cal2.time_comp=false;
  setCurrentDate('txtInvDt');

</script>
</form>
</body>
</html>