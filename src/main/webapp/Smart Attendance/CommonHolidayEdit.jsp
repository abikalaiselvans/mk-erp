<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="ATTholidayAdd"; %>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  
  
  function Validate()
  {
  	
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


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
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
												class="boldEleven">Date
												<%
													String holidayid=request.getParameter("holiday");
													String sql="SELECT  DATE_FORMAT(DT_HOLIDATE,'%d-%m-%Y') ,CHR_HOLIDESC FROM  att_t_commonholiday  WHERE INT_ID="+holidayid;
													String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
												%>
										  </td>
											<td width="238"><input name="fromdt" type="text" class="formText135"
												id="fromdt"  value="<%=data[0][0]%>"
												size="15" readonly> 
                                                <a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>
											 </td>
										</tr>
										<tr>
											<td height="29" align="left" valign="top" class="boldEleven">Holiday
											Name <font color="#CC0000">*</font></td>
											<td align="left" valign="middle"><textarea
												name="holiname" cols="30" rows="5" class="formText135"
												id="holiname" onKeyPress="charOnly('holiname','250')"><%=data[0][1]%></textarea></td>
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
										type="HIDDEN" name="actionS" value="ATTCommonHolidayUpdate">
									<input name="holidayid" type="hidden" id="holidayid" value="<%=holidayid%>"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="left" valign="middle" class="">
							<table align="center" cellpadding="3" cellspacing="3">
								<tr align="center">
									<td width="56"><input class="buttonbold" type="submit"
										name="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c"  onClick="redirect('CommonHoliday.jsp')">
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
			//setCurrentDate('fromdt');
			
		//-->
	</script></td>
	</tr>
</table>

<%
}
catch(Exception e)
{
}
%>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
