<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="ATTondutyAdd"; %>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("ename","Select Staff") && checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkNull("holiname","Enter Place Name")&& checkDate("fromdt","todt")){
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
	    //document.frmState.action="AttendanceMain.jsp";
		//document.frmState.submit();
		//return true;
		history.back(1);
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
	onLoad="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <br>
<br>
<br>
<table>
	<tr>
		<td>
		<table width="868" border="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="260" height="49">&nbsp;</td>
				<td width="466">&nbsp;</td>
				<td width="10">&nbsp;</td>
				<td width="114">&nbsp;</td>
			</tr>
			<tr>
				<td height="36">&nbsp;</td>
				<td colspan="2" valign="top">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<!--DWLayoutTable-->
					<tr>
						<td width="468" height="34" valign="top"><%@ include
							file="../JavaScript/ajax.jsp"%></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="24">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="221"></td>
				<td align="left" valign="top">
				<table width="463" border="1" cellspacing="2" cellpadding="2"
					 >
					<!--DWLayoutTable-->
					<tr>
						<td height="25" colspan="2" valign="top" 
							class="tablehead">
						<div align="center">OnDuty Information</div>
						</td>
					</tr>
					<tr>
						<td width="153" height="30" valign="middle" class="bolddeepblue">From<span
							class="bolddeepblue style17">*</span></td>
						<td><input name="fromdt" type="text" class="tabledata"
							id="fromdt" onKeyPress="dateOnly('fromdt')" value="" size="15">
						<a href="javascript:cal1.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="30" align="left" valign="middle" class="tabledata">
						<p class="style8">To<span class="style17">*</span></p>
						</td>
						<td align="left" valign="middle"><input name="todt"
							type="text" class="tabledata" id="todt"
							onkeypress="dateOnly('todt')" value="" size="15"> <a
							href="javascript:cal2.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">Day<span
							class="style17">*</span></td>
						<td width="283" class="bolddeepblue"><input name="ComboDay"
							type="radio" value="Full Day" CHECKED> Full Day <input
							name="ComboDay" type="radio" value="Forenoon"> Forenoon
						<input name="ComboDay" type="radio" value="Afternoon">
						Afternoon</td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">Place
						<span class="style17">*</span></td>
						<td align="left" valign="middle"><input name="TxtPlace"
							type="text" class="tabledata" id="holiname"
							onKeyPress="charOnly('holiname','25')" size="40"></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">Reason</td>
						<td><input name="TxtReason" type="text" class="tabledata"
							onKeyPress="charOnly('TxtReason','25')" size="40"></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">Authorised
						By</td>
						<td><input name="TxtAuthorised" type="text" class="tabledata"
							onKeyPress="charOnly('TxtAuthorised','25')" size="40"></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="36"></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="42"></td>
				<td valign="top" align="center">
				<table>
					<tr>
						<td width="56"><input type="submit" name="Submit"
							class="buttonbold" value="Submit"   accesskey="s"    onClick="return Validate()"></td>
						<td width="56"><input type="submit" name="Submit"
							class="buttonbold" value="View" onClick="return Validate1()"></td>
						<td width="56"><input type="button" name="Submit"
							class="buttonbold"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<input type="HIDDEN" name="filename" value="OnDuty"> <input
			type="HIDDEN" name="actionS" value="<%=actionStu%>">

		<center>
		<table>
			<tr align="center">
				<td align="center" colspan="2"></td>
			</tr>

		</table>
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

		<br>
		<br>
		<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
