
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>


<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>


<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("ename","Select Staff")&& checkNullSelect("Month","Select Month","select")&&(checkNullSelect("Year","Select Year","select"))){
		document.frmState.action="../SmartLoginAuth";
		document.frmState.submit();
		return true;
	}
	return false;
  }
  
  
 function mainPage()
  {
	    document.ATT_Indidual_Rep.action="AttendanceMain.jsp";
		document.ATT_Indidual_Rep.submit();
		return true;
  }
</script>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}


-->
</style>


</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">

<form  AUTOCOMPLETE = "off"   name="frmState" action="../SmartLoginAuth" c
	id="ATT_Indidual_Rep" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="85">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" height="166" border="1" align="center"
			  class="bolddeepblue">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="4" align="center" valign="middle"
					class="tabledata"><%@ include file="../JavaScript/ajax.jsp"%>
				</td>
			</tr>
			<tr align="center" valign="middle">
				<td height="29" colspan="4" valign="top" 
					class="tablehead">Attendance Individual</td>
			</tr>
			<tr valign="top">
				<td height="18" colspan="4" class="tabledata" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
			</tr>
			<tr valign="top">
				<td height="18" colspan="4" class="tabledata" align="center">
				<table width="162" border="0" cellspacing="0" cellpadding="0">
					<tr class="bolddeepblue">
						<td width="36" valign="middle"><input name="Report"
							type="radio" value="Month" checked></td>
						<td width="60" valign="middle" class="tabledata">Month</td>
						<td width="1" valign="middle"><input type="radio"
							name="Report" value="Date"></td>
						<td width="65" valign="middle" class="tabledata">Date</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="56" height="28" valign="middle" class="bolddeepblue"><span
					class="style13">Month</span></td>
				<td width="97" valign="middle"><select name="Month"
					class="tabledata" style="width:100">
					<option value="select">Select</option>
					<option>January</option>
					<option>February</option>
					<option>March</option>
					<option>April</option>
					<option>May</option>
					<option>June</option>
					<option>July</option>
					<option>August</option>
					<option>September</option>
					<option>October</option>
					<option>November</option>
					<option>December</option>
				</select></td>
				<td width="43">From</td>
				<td width="150" valign="middle"><font size="1"><strong><font
					color="#000000"><font size="1"> <input name="fromdt"
					type="text" class="tabledata" id="fromdt" value="" size="15">
				<a href="javascript:cal1.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> </font></font></strong></font> <font size="1"><strong><font
					color="#000000"><font size="1"> </font></font></strong></font></td>
			</tr>
			<tr>
				<td height="29" valign="middle" class="bolddeepblue"><span
					class="style13">Year</span></td>
				<td valign="middle"><span class="style11" width="97"> <select
					name="Year" class="tabledata" style="width:100">
					<option value="select">Select</option>
					<option>2000</option>
					<option>2001</option>
					<option>2002</option>
					<option>2003</option>
					<option>2004</option>
					<option>2005</option>
					<option>2006</option>
					<option>2007</option>
					<option>2008</option>
					<option>2009</option>
					<option>2010</option>
					<option>2011</option>
					<option>2012</option>
					<option>2013</option>
					<option>2014</option>
					<option>2015</option>
					<option>2016</option>
					<option>2017</option>
					<option>2018</option>
					<option>2019</option>
					<option>2020</option>
				</select> </span></td>
				<td valign="top">Date</td>
				<td valign="middle"><font size="1"><strong><font
					color="#000000"><font size="1"> <input name="todt"
					type="text" class="tabledata" id="todt" value="" size="15">
				<a href="javascript:cal2.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> <input type="hidden"
					name="filename" value="Attendance"> <input type="hidden"
					name="actionS" value="ATTAttendanceSheet"> </font></font></strong></font></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="56"><input name="Submit" type="submit"
					class="buttonbold" value="Submit"   accesskey="s"   ></td>
				<td width="56"><input name="Button" type="Button"
					class="buttonbold"  value="Close"   accesskey="c" 
					onClick="javascript:history.back();"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['ATT_Indidual_Rep'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['ATT_Indidual_Rep'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
			setCurrentDate('fromdt');
			setCurrentDate('todt');			
	
		//-->
	</script></form>
<%@ include file="../footer.jsp"%>
</body>
</html>
