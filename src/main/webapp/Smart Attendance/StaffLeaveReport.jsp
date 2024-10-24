<%@ page import="java.sql.*,java.io.*,java.util.*"%>
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
function morningTimeOnly()
{
      alert("In morning time");
      if(checkNull("fromdt","Enter From Date"))
      return true;
      else
      return false;
}

//week day 

	
function Validate()
  {
  	
	var d1 = document.getElementById('fromdt').value;
	var d2 = document.getElementById('todt').value;
	if( checkNull("ename","Select Staff") 
		&& checkNull("todt","Enter To Date") 
	  	&& checkDate("fromdt","todt"))
			return true;
		else
			return false;
	
  }
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"><br>
		<br>
		</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="StaffManualAttendanceEditfrm" method="post"
			action="StaffLeaveReportresponse.jsp">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="591" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
					<tbody>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
						</tr>
						<tr>
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block"></td>
							<td width="577" valign="top">
							<table width="577" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center" class="boldEleven"><strong>Staff
									Leave Information</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color="#FF0000">* </font><span
										class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"><%@ include
										file="../JavaScript/ajax.jsp"%></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="397" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="77" valign="middle"  
												class="boldEleven">From<span class="bolddeepblue">
											<%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %> </span></td>
											<td width="313" class="boldEleven"><input name="fromdt" 
												type="text" class="formText135" id="fromdt"
												onKeyPress="numericHypenOnly('fromdt','9')" value=""
												size="15" readonly="readonly"> 
											<a
												href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a> <script
												language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['StaffManualAttendanceEditfrm'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			setCurrentDate('fromdt');
			 	
			
		//-->
	</script> <span class="boldEleven">( dd-mm-yyyy ) </span></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">To</td>
											<td class="boldEleven"><input name="todt" type="text"
												class="formText135" id="todt"
												onKeyPress="numericHypenOnly('todt','9')" value="" size="15"
												readonly="readonly"> 
											<a
												href="javascript:cal2.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a> <script
												language='JavaScript'>
		<!--
			var cal2 = new calendar1(document.forms['StaffManualAttendanceEditfrm'].elements['todt']);
			cal2.year_scroll = true;
			cal2.time_comp = false;
			setCurrentDate('todt');
			 	
			
		//-->
	</script> <span class="boldEleven">( dd-mm-yyyy ) </span></td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td height="19" colspan="2">
									<div align="center">
									 
									</div>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19">&nbsp; 
								  </td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:redirect('AttendanceMain.jsp')" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
							<td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
							<td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
							<td colspan="2" rowspan="2" valign="bottom">
							<div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div>
							</td>
						</tr>
						<tr>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>

					</tbody>
				</table>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>