  <%@ page import="java.sql.*,java.io.*,java.util.*"%>
 <%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}


-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="500"
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
					<td><table width="100%" border="0" cellspacing="2" cellpadding="2">
                      <tr>
                        <td colspan="7"><div align="center" class="bold1">
                          <div align="center">ATTENDANCE REPORTS </div>
                        </div></td>
                      </tr>
                      <tr>
                        <td width="1"  class="boldEleven">&nbsp;</td>
                        <td width="11"  class="bold1">&nbsp;</td>
                        <td width="115"  class="bold1"><div align="center">STAFF</div></td>
                        <td width="11" class="bold1">&nbsp;</td>
                        <td width="98" class="bold1"><div align="center">ATTENDANCE </div></td>
                        <td width="12" class="bold1">&nbsp;</td>
                        <td width="128" class="bold1"><div align="center">LEAVE</div></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">1.</td>
                        <td   height="20" class="boldEleven"><a href="Rept_JAttendanceMonth.jsp" target="_blank">Attendance</a>&nbsp;</td>
                        <td  class="boldEleven">1.</td>
                        <td  class="boldEleven"><a href="Rept_JAdminODMonth.jsp" target="_blank">On Duty</a></td>
                        <td class="boldEleven">1.</td>
                        <td class="boldEleven"><a href="Rept_JLossOfPay.jsp" target="_blank">Loss of Pay Leave List</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">2.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JAbsentMonth.jsp" target="_blank">Absentees</a></td>
                        <td class="boldEleven">2.</td>
                        <td class="boldEleven"><a href="Rept_JAdminLeaveMonth.jsp" target="_blank">Leave</a></td>
                        <td class="boldEleven">2.</td>
                        <td class="boldEleven"><a href="Rept_JLeaveReport.jsp" target="_blank">Consolidate Leave List</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">3.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JLateComersMonth.jsp" target="_blank">Late Comers</a></td>
                        <td class="boldEleven">3.</td>
                        <td class="boldEleven"><a href="Rept_JAdminPermissionMonth.jsp" target="_blank">Permission</a></td>
                        <td class="boldEleven">3.</td>
                        <td class="boldEleven"><a href="Rept_JLeaveList.jsp" target="_blank">Yearwise Leave List&nbsp;</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">4.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JAttendanceMonth.jsp" target="_blank">On Duty</a></td>
                        <td class="boldEleven">4.</td>
                        <td class="boldEleven"><a href="Rept_JAdminHolidayMonth.jsp" target="_blank">Holiday</a></td>
                        <td class="boldEleven">4.</td>
                        <td class="boldEleven"><a href="Rept_JLeaveList.jsp" target="_blank">Individual Leave List</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">5.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JLeaveMonth.jsp" target="_blank">Leave</a></td>
                        <td class="boldEleven">5.</td>
                        <td class="boldEleven"><a href="Rept_JAdminOTMonth.jsp" target="_blank">Over Time</a></td>
                        <td class="boldEleven">5.</td>
                        <td class="boldEleven"><a href="Rept_JMonthwiseUserAttendance.jsp" target="_blank">Monthwise User Attendance</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">6.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JPermissionMonth.jsp" target="_blank">Permission</a></td>
                        <td class="boldEleven">6.</td>
                        <td class="boldEleven"><a href="Rept_JAdminCommonHolidayReport.jsp" target="_blank">Common Holiday</a></td>
                        <td class="boldEleven">6.</td>
                        <td class="boldEleven"><a href="Rept_JUserBalanceLeaveStatus.jsp" target="_blank">User Balance Leave Status</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">7.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JOTMonth.jsp" target="_blank">Over Time</a></td>
                        <td class="boldEleven">7.</td>
                        <td class="boldEleven"><a href="Rept_JAdminEDMonth.jsp" target="_blank">Extra day</a></td>
                        <td class="boldEleven">7.</td>
                        <td class="boldEleven"><a href="Rept_JStaffMonthwiseAttendance.jsp" target="_blank">Monthwise Attendance Report</a></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">8.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JExtraDaysMonth.jsp" target="_blank">Extra Days</a></td>
                        <td class="boldEleven">8.</td>
                        <td class="boldEleven"><a href="Rept_JInvidualStaffMonthwiseAttendance.jsp" target="_blank">Individual Attendance </a></td>
                        <td class="boldEleven"></td>
                        <td class="boldEleven"></td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">9.</td>
                        <td height="20" class="boldEleven"><a href="Rept_JAttendanceAll.jsp" target="_blank">All</a></td>
                        <td class="boldEleven"></td>
                        <td class="boldEleven"></td>
                        <td class="boldEleven"></td>
                        <td class="boldEleven"></td>
                      </tr>
                    </table>					</td>
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
		<td> </td>
	</tr>
</table>
 
<%@ include file="../footer.jsp"%>
</body>
 
</html>
