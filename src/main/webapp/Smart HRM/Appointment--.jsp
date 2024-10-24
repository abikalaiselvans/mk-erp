
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

	if(checkNullSelect('appNo','Select Application Number','0')
		&& checkNull('txtAppDt', 'Enter Application Date')
		&& checkNull('txtInvDt', 'Enter Interview Date')
		&& datechk())
	{
		alert("ok");
//		document.frmAppointment.action="";
//		document.frmAppointment.submit();
		
	}
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
	document.getElementById('appNo').focus();
	document.frmAppointment.appNo.options[0].selected=true;
}

</script>


 
<script language="javascript" src="../JavaScript/commonAJAX.js"></script>
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="document.frmAppointment.appNo.focus()">
<form  AUTOCOMPLETE = "off" method="get" name="frmAppointment">

<table width="100%" height="293" align="center">
	<tr>
		<td><%@ include file="indexhrm.jsp"%></td>
	</tr>

	<!--DWLayoutTable-->
	<tr>
		<td height="21" colspan="6" align="center">
	<tr>
		<td height="21" colspan="6" align="center">
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="800" height="92" border="1" align="center"
			cellpadding="0" cellspacing="0"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   background="">
				<td height="28"  
					class="tablehead"><span class="style3">Appointment
				Order </span></td>
			</tr>

			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="612" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
						<td width="166" class="bold1"><span class="style3">Application
						Number </span></td>
						<td width="135" class="bold1"><span class="style3"> <select
							name="appNo" id="appNo" onChange="loadAppData(this)" tabindex="1">
							<option value="0">Select</option>

							<%
						String sql = "SELECT INT_APPID, CHR_APPCODE FROM hrm_m_application";
						String AppData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
						for (int i=0; i<AppData.length; i++)
							out.println("<option value= '" +AppData[i][0]+ "'>" +AppData[i][1]+ "</option>");
					
					 %>


						</select> </span></td>
						<td width="141" class="bold1"><span class="style3">Applicant
						Name </span></td>
						<td width="157" class="bold1"><input type="text"
							name="txtAppName" id="txtAppName" style="color:blue" readonly></td>

					</tr>
				</table>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="100%" border="0" align="left" cellpadding="5"
					cellspacing="5">
					<tr>
						<td height="35" align="left">With reference to your
						application dated&nbsp;&nbsp; <input type="text" name="txtAppDt"
							id="txtAppDt" tabindex="2" maxlength="10" size="12"
							onKeyPress="numericHypenOnly('txtAppDt', '9')" style="color:blue"
							readonly> <!--<a href="javascript:cal1.popup();"><img src="../JavaScript/img/cal.gif" width="16" border="0" alt="Click here to Select the Date" /></a>&nbsp; -->
						&nbsp;and the subsequent interview you had with us/our Central</td>
					</tr>

					<tr>
						<td align="left" height="25">Recruitment Committee
						on&nbsp;&nbsp; <input type="text" name="txtInvDt" id="txtInvDt"
							onKeyPress="numericHypenOnly('txtInvDt', '9')" maxlength="10"
							size="12" tabindex="3" readonly><a
							href="javascript:cal2.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" border="0"
							alt="Click here to Select the Date" /></a>&nbsp;&nbsp;we are pleased
						to appoint you as a/an&nbsp;&nbsp;<input type="text"
							name="txtAppoint" id="txtAppoint" style="color:blue" readonly>
						.</td>
					</tr>
					<tr>
						<td height="30" align="left">2. Your salary will be Rs. <input
							type="text" name="txtSal" id="txtSal" tabindex="3" maxlength="15"
							size="12" onKeyPress="numericHypenOnly('txtAppDt', '9')"
							style="color:blue" readonly>&nbsp;per month, from the
						date of your joining duty.</td>
					</tr>
					<tr>
						<td align="left">
						<div align="left">3. During the period of probation, we can
						terminate your appointemt without notice. Afer confirmation, the
						Service of the employee</div>
						</td>
					</tr>
					<tr>
						<td height="20" align="left">may be terminated on either side
						by giving one month's notice or one month's pay in lieu of notice.
						Such notice pay wheret due may be</td>
					</tr>
					<tr>
						<td height="20" align="left">deducted from the dues to which
						the employee would be eligible on such termination.
						</div>
						</td>
					</tr>
					<tr>
						<td height="30" align="left">4. It is Understood that during
						the period of your probation you will not be entitled to Leave of
						any kind with pay.</td>
					</tr>
					<tr>
						<td height="20" align="left">5. On Confirmation, you will be
						entitled to the benefits of Provident Fund, Gratutity, Leave,
						etc., according to the Rules in force from</td>
					</tr>
					<tr>
						<td height="10" align="left">time to time.</td>
					</tr>
					<tr>
						<td height="30" align="left">6. We are attaching hereto a
						duplicat copy of this letter bearing endorsement as under.</td>
					</tr>
					<tr>
						<td height="20" align="left">"I ACCEPT THE APPOINTMENT ON THE
						TERMS MENTIONED ABOVE." Kindly return this copy to us, duly signed
						by you.</td>
					</tr>
					<tr>
						<td height="30" align="right">Yours faithfully,</td>
					</tr>
					<tr>
						<td height="30" align="left">"I ACCEPT THE APPOINTMENT ON THE
						TERMS MENTIONED ABOVE."</td>
					</tr>



				</table>
				</td>
			</tr>
		</table>
	<tr>
		<td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
	</tr>
	<tr>
		<td height="17" colspan="6">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input name="Save" type="button"
					class="tMLAscreenHead" id="Save" value="Save"
					onClick="validateFields()" tabindex="4"></td>
				<td width="56"><input name="Clear" type="Button"
					class="tMLAscreenHead" id="Clear" value="Clear" tabindex="5"
					onClick="clearFields()"></td>
				<td width="56"><input class="tMLAscreenHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"
					tabindex="6"></td>
				<td width="56"><input name="filename" type="hidden"
					id="filename" value="StaffRegistration"> <input
					name="actionS" type="hidden" id="actionS"
					value="COM_ATTStaffRegistrationDelete"></td>
			</tr>
		</table>
	<tr>
		<td height="17" colspan="6">
		<center><font color="#FF0000"> <%@ include
			file="../footer.jsp"%></center>
</table>
</form>
<script language="javascript">
  var cal1=new calendar1(document.getElementById('txtAppDt'));
  cal1.year_scroll=true;
  cal1.time_comp=false;

  var cal2=new calendar1(document.getElementById('txtInvDt'));
  cal2.year_scroll=true;
  cal2.time_comp=false;
  setCurrentDate('txtInvDt');

</script>

</body>
</html>
