
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="ATTmanualAdd"; %>
<html>
<head>

<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
	function changeState()
{
  var comboLate=document.getElementById("late").checked;
  if(comboLate==true)
  {
    document.getElementById("TxtDay").disabled=true;
    document.getElementById("TxtDay1").disabled=true;
    document.getElementById("TxtDay2").disabled=true;
    document.getElementById("ot").disabled=true;
  }
  else
  {
    document.getElementById("TxtDay").disabled=false;
    document.getElementById("TxtDay1").disabled=false;
    document.getElementById("TxtDay2").disabled=false;
    document.getElementById("ot").disabled=false;    
  }  
}	
  function Validate()
  {
  	if(checkNull("ename","Select Staff") && checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkNull("it","Enter In Time")&& checkDate("fromdt","todt")&& checkTime('it','ot')){
		document.frmState.submit();		
		return true;
	}	
	return false;
  }
  function Validate1()
  {
  	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkDate("fromdt","todt")){
		document.frmState.submit();
		return true;
	}
	return false;
  }
  function mainPage()
	{
	    document.frmState.action="AttendanceMain.jsp";
		document.frmState.submit();
		return true;
    }

  
</script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.menuBtn {
	width:100%;
}
.style17 {color: #FF0000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="loadStaff()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <br>
<br>
<br>
<table>
	<tr>
		<td>
		<table width="883" border="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="262" height="49"></td>
				<td width="133">&nbsp;</td>
				<td width="62"></td>
				<td width="267"></td>
				<td width="137"></td>
			</tr>
			<tr>
				<td height="35"></td>
				<td colspan="3" valign="top">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<!--DWLayoutTable-->
					<tr>
						<td width="467" height="33" valign="top"><%@ include
							file="../JavaScript/StaffNew.jsp"%></td>
					</tr>
				</table>
				</td>
				<td></td>
			</tr>
			<tr>
				<td height="26"></td>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td height="189"></td>
				<td colspan="3" align="left" valign="top">
				<table width="472" border="1" cellspacing="2" cellpadding="2"
					 >
					<!--DWLayoutTable-->
					<tr align="center" valign="middle">
						<td height="25" colspan="2"  class="tablehead">Manual
						Attendance</td>
					</tr>
					<tr>
						<td width="126" height="30" valign="middle" class="bolddeepblue">From</td>
						<td width="326" valign="middle"><input name="fromdt"
							type="text" class="tabledata" id="fromdt"
							onKeyPress="dateOnly('fromdt')" value="" size="15"> <a
							href="javascript:cal1.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="30" align="left" valign="middle" class="bolddeepblue">To</td>
						<td align="left" valign="middle"><input name="todt"
							type="text" class="tabledata" id="todt"
							onKeyPress="dateOnly('todt')" value="" size="15"> <a
							href="javascript:cal2.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">Day
						<span class="style17"> *</span></td>
						<td valign="middle" class="bolddeepblue"><input
							type="checkbox" id="late" name="ChkLate" value="L"
							onClick="changeState()"> Late <input name="ComboDay"
							id="TxtDay" type="radio" value="P" CHECKED> Full Day <input
							name="ComboDay" type="radio" id="TxtDay1" value="F">
						Forenoon <input name="ComboDay" type="radio" id="TxtDay2"
							value="A"> Afternoon</td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">In
						Time <font color="#FF0000">*</font></td>
						<td valign="middle" class="bolddeepblue"><input name="int"
							type="text" class="tabledata" id="it" onKeyPress="timeOnly('it')">
						(HH:MM:SS)</td>
					</tr>
					<tr>
						<td height="26" align="left" valign="middle" class="bolddeepblue">Out
						Time</td>
						<td valign="middle" class="bolddeepblue"><input name="out"
							type="text" class="tabledata" id="ot" onKeyPress="timeOnly('ot')">
						(HH:MM:SS) </font></span></strong></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="32"></td>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td height="39"></td>
				<td colspan="3" align="center" valign="middle">
				<table>
					<tr>
						<td width="56"><input class="buttonbold" type="submit"
							name="Submit" value="Submit"   accesskey="s"    onClick="return Validate()"></td>
						<td width="56"><input class="buttonbold" type="submit"
							name="Submit" value="View" onClick="return Validate1()"></td>
						<td width="56"><input class="buttonbold" type="submit"
							name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
					</tr>
				</table>
				</td>
				<td></td>
			</tr>
		</table>
		<input type="HIDDEN" name="actionS" value="<%=actionStu %>"> <input
			type="HIDDEN" name="filename" value="ManualAttendance">
		<center>
		<table>
			<tr align="center">

				<td align="center" colspan="2"></td>
			</tr>
		</table>
		</center>
		<br>
		<br>
		<script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmState'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
			setCurrentDate('fromdt');
			setCurrentDate('todt');			
	
		//-->
	</script> <% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
		<CENTER>
		<table width="23%" border="1" cellspacing="2" cellpadding="2"
			 >

			<tr>
				<td align="center" class="tabledata"><%=msg%></td>
			</tr>
			<% } %>
		</table>
		</CENTER>
		<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
