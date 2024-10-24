
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>


<title> :: PAYROLL ::</title>


 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("ename","Select Staff") && checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkNull("holiname","Enter Holiday Name")&& checkDate("fromdt","todt")){
		document.frmState.action="HolidayInsertion.jsp";
		document.frmState.submit();
		return true;
	}
	return false;
  }
  function View()
  {
    document.frmState.action="HolidayView.jsp";
	document.frmState.submit();
	
  }
</script>
 

<title> :: PAYROLL ::</title>


 
<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}


-->
</style>


</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="HolidayInsertion.jsp"
	onsubmit="return Validate()"><%@ include file="index.jsp"%>
<br>
<br>
<br>
<table>
	<tr>
		<td>
		<table width="869" border="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="258" height="45">&nbsp;</td>
				<td width="165">&nbsp;</td>
				<td width="46">&nbsp;</td>
				<td width="47">&nbsp;</td>
				<td width="193">&nbsp;</td>
				<td width="134">&nbsp;</td>
			</tr>
			<tr>
				<td height="36">&nbsp;</td>
				<td colspan="4" valign="top">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					 >
					<!--DWLayoutTable-->
					<tr>
						<td width="466" height="34" valign="top"><%@ include
							file="../JavaScript/ajax.jsp"%></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="28">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="128"></td>
				<td colspan="4" align="left" valign="top">
				<table width="463" border="1" cellspacing="2" cellpadding="2"
					 >
					<!--DWLayoutTable-->
					<tr align="center">
						<td height="25" colspan="2" valign="top" class="tablehead"
							 >Holiday</td>
					</tr>
					<tr>
						<td width="153" height="30" valign="middle" class="tabledata">From</td>
						<td><input type="text" name="fromdt" id="fromdt" value=""
							size="15" onKeyPress="alphaNumeric('fromdt','10')"> <a
							href="javascript:cal1.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="30" align="left" valign="middle" class="tabledata">To</td>
						<td align="left" valign="middle"><input type="text"
							name="todt" id="todt" value="" size="15"
							onkeypress="alphaNumeric('todt','10')"> <a
							href="javascript:cal2.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="tabledata">Holiday
						Name <font color="#CC0000">*</font></td>
						<td align="left" valign="middle"><input name="holiname"
							id="holiname" type="text" size="40"
							" onkeypress="charOnly('holiname','25')"></td>
					</tr>
				</table>
				</td>
				<td></td>
			</tr>
			<tr>
				<td height="11"></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td height="26"></td>
				<td>&nbsp;</td>
				<td align="left" valign="top"><input type="submit"
					name="Submit"  value="Add"   accesskey="s"   class="menuBtn"></td>
				<td valign="top"><input name="button" type="button"
					onclick="View()" value="View" class="menuBtn"></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<br>
		<script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmState'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
		//-->
	</script> <%@ include file="../footer.jsp"%>
</body>
</form>
</html>
