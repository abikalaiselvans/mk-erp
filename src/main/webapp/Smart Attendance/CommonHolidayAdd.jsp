<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="ATTholidayAdd"; %>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  
  
  function Validate()
  {
  	//if( "true" != confirm("Please cofirm the date"))
		//return false;
	
	var d1 = document.getElementById('fromdt').value;
	var dd1 = d1.split("-");
	var ds = compute(dd1[0],dd1[1],dd1[2]) ;
	if(ds=="Sunday")
	{
		alert("You are selecting Sunday");
		return false;
	}
	
	
	if(	 checkNull("fromdt","Enter From Date") 
		&& checkNull("holiname","Enter Holiday Name"))
		{
			return true;
		}
		else
		{
			return false;
		}	
  }
   

</script>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style16 {	font-size: 24px;
	color: #666666;
}


-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   method="post" name='frmState' action="../SmartLoginAuth" 	onSubmit="return Validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	>
<%@ include file="index.jsp"%>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="450"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1" type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table align="center">
						<tr>
							<td>
							<div align="center"><span class="bold1">Common Holiday</span></div>
							<table width="469" border="0" align="center">
								  
								<tr>
									<td height="136" align="left" valign="top">
									<table width="463" border="0" cellpadding="2" cellspacing="2"
										  class="bolddeepblue">
										<!--DWLayoutTable-->
										<tr>
											<td width="211" height="30" valign="middle"
												class="boldEleven">Date</td>
											<td width="238" class="boldEleven"><input name="fromdt" type="text" class="formText135"
												id="fromdt" onKeyPress="dateOnly('fromdt')" value=""
												size="15" readonly> <a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a></td>
										</tr>
										<tr>
											<td height="29" align="left" valign="top" class="boldEleven">Holiday
											Name <font color="#CC0000">*</font></td>
											<td align="left" valign="middle" class="boldEleven"><textarea
												name="holiname" cols="30" rows="5" class="formText135"
												id="holiname" onKeyPress="charOnly('holiname','25')"></textarea></td>
										</tr>
										<tr>
											<td height="2" colspan="2"></td>
										</tr>
									</table>
									<table>
										<tr>
											<td></td>
										</tr>
									</table>
									<input type="HIDDEN" name="filename" value="Holiday"> <input
										type="HIDDEN" name="actionS" value="ATTCommonHolidayAdd"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="left" valign="middle" class="">
							<table align="center" cellpadding="3" cellspacing="3">
								<tr align="center">
									<td width="56"><input class="buttonbold" type="submit" id="Submit" 	name="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Close" id="Close"  value="Close"   accesskey="c"  onClick="redirect('CommonHoliday.jsp')">
									</td>
								</tr>
							</table>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			setCurrentDate('fromdt');
			
		//-->
	</script></td>
	</tr>
</table>
 
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
