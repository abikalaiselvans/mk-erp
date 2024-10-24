
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="ATTpermissionAdd"; %>
<html>
<head>

<script src="../JavaScript/common/StaffloadAjax.js"></script>
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
  	if(checkNull("ename","Select Staff") && checkNull("fromdt","Enter Date") && checkNull("TxtDay1","Select Day") 
  	&& checkNull("it","Enter From Time")&& checkNull("ot","Enter To Time")&& checkDate("fromdt","fromdt")&& checkTime('it','ot')){
		
		document.frmState.submit();
		return true;
	}
	return false;
  }
  function Validate1()
  {
  	if(checkNull("fromdt","Enter From Date")){
		
		document.frmState.submit();
		return true;
	}
	return false;
  }
   function mainPage()
	{
	    //document.frmState.action="AttendanceMain.jsp";
		//document.frmState.submit();
		//return true;
		history.back(1);
    }
</script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}
.menuBtn {
	width:100%;
}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%>

<table>
	<tr>
		<td>
		<table width="867" border="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="266" height="107">&nbsp;</td>
				<td width="130">&nbsp;</td>
				<td width="58">&nbsp;</td>
				<td width="267">&nbsp;</td>
				<td width="124"></td>
			</tr>
			<tr>
				<td height="34">&nbsp;</td>
				<td colspan="3" valign="top">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<!--DWLayoutTable-->
					<tr>
						<td width="469" height="32" valign="top"><%@ include
							file="../JavaScript/ajax.jsp"%></td>
					</tr>
				</table>
				</td>
				<td></td>
			</tr>
			<tr>
				<td height="24">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td height="219">&nbsp;</td>
				<td colspan="3" align="left" valign="top">
				<table width="463" border="1" cellspacing="2" cellpadding="2"
					 >
					<!--DWLayoutTable-->
					<tr align="center" valign="middle">
						<td height="25" colspan="2"  class="tablehead">Permission</td>
					</tr>
					<tr>
						<td width="153" height="30" valign="middle" class="bolddeepblue">Date</td>
						<td><input name="fromdt" type="text" class="tabledata"
							id="fromdt" onKeyPress="dateOnly(fromdt)" value="" size="15">
						<a href="javascript:cal1.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">Day
						<font color="#FF0000">*</font></td>
						<td width="283" class="bolddeepblue"><input name="ComboDay"
							type="radio" id="TxtDay1" value="F" checked="checked">
						Forenoon <input name="ComboDay" type="radio" id="TxtDay1"
							value="A"> Afternoon</td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">
						From Time<font color="#FF0000"> *</font></td>
						<td align="left" valign="middle" class="bolddeepblue"><input
							name="int" type="text" class="tabledata" id="it"
							onKeyPress="timeOnly('it')"> (HH:MM:SS)</td>
					</tr>
					<tr>
						<td height="26" align="left" valign="middle" class="bolddeepblue">
						To Time <font color="#FF0000">*</font></td>
						<td align="left" valign="middle" class="bolddeepblue"><input
							name="out" type="text" class="tabledata" id="ot"
							onKeyPress="timeOnly('ot')"> (HH:MM:SS)</td>
					</tr>
					<tr>
						<td class="bolddeepblue">Reason</td>
						<td><input name="reason" type="text" class="tabledata"
							onKeyPress="charOnly('reason','20')" size="45"></td>
					</tr>
				</table>
				</td>
				<td></td>
			</tr>
		</table>
		<input type="HIDDEN" name="filename" value="Permission"> <input
			type="HIDDEN" name="actionS" value="<%=actionStu%>">

		<center>
		<table>
			<tr align="center">
				<td align="center" colspan="2">
				<table>
					<tr>
						<td width="56"><input class="buttonbold" type="submit"
							name="Submit" value="Submit"   accesskey="s"    onClick="return Validate()"></td>
						<td width="56"><input class="buttonbold" type="submit"
							name="Submit" value="View" onClick="return Validate1()"></td>
						<td width="56"><input class="buttonbold" type="button"
							name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<script language='JavaScript'>
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;	
			setCurrentDate('fromdt');
	
					
	</script>
		</td>
	</tr>
</table>
</form>
<% 
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
</html>
