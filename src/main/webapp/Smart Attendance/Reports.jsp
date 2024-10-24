<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
%>
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="800"
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
					<td><table width="100%" border="1" cellpadding="3" cellspacing="1" bordercolor="#9900CC">
                      <tr>
                        <td colspan="7"><div align="center" class="bold1">
                          <div align="center">ATTENDANCE REPORTS </div>
                        </div></td>
                      </tr>
                      <tr>
                        <td class="bold1"><div align="center">Attendance General</div></td>
                        <td class="bold1"><div align="center">Administrator</div></td>
                        <td class="bold1"><div align="center">Shift</div></td>
                        <td class="bold1"><div align="center">Finger Print</div></td>
                        <td class="bold1"><div align="center">Proxymity</div></td>
                        <td class="bold1"><div align="center">Leave</div></td>
                        <td align="center" class="bold1">CONSOLIDATE GRAPH</td>
                      </tr>
                      <tr>
                        <td width="101" class="boldEleven"><a href="AttendanceMonth.jsp" target="_blank">Attendance</a>&nbsp;</td>
                        <td width="90" class="boldEleven"><a href="AdminODMonth.jsp" target="_blank">On Duty</a></td>
                        <td width="55" class="boldEleven"><a href="TimeInOutShift.jsp">Shift</a>&nbsp;</td>
                        <td width="81" class="boldEleven"><a href="ProximityIssueStaffInfo.jsp" target="_blank"><a href="Finger Print Reports.jsp" target="_blank">Finger Print</a> </td>
                        <td width="67" class="boldEleven"><a href="ProximityIssueStaffInfo.jsp" target="_blank">Issued</a></td>
                        <td width="104" class="boldEleven"><a href="LOP.jsp" target="_blank">LOP</a>&nbsp;</td>
                        <td width="104" class="boldEleven"><a href="Rept_GraphLocationwise.jsp" target="_blank">Location wise</a></td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="AbsentMonth.jsp" target="_blank">Absentees</a></td>
                        <td class="boldEleven"><a href="AdminLeaveMonth.jsp" target="_blank">Leave</a></td>
                        <td class="boldEleven"><a href="TimeInOutDate.jsp" target="_blank">Date</a></td>
                        <td class="boldEleven"><a href="RegisterStaffInfo.jsp" target="_blank">Registered</a></td>
                        <td class="boldEleven"><a href="ProximityNotIssueStaffInfo.jsp" target="_blank">Not-Issued</a></td>
                        <td class="boldEleven"><a href="LeaveReport.jsp" target="_blank">Consolidate Leave</a></td>
                        <td class="boldEleven"><a href="Rept_GraphEmployeeWise.jsp" target="_blank">Employee Wise</a></td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="LateComersMonth.jsp" target="_blank">Late Comers</a></td>
                        <td class="boldEleven"><a href="AdminPermissionMonth.jsp" target="_blank">Permission</a></td>
                        <td class="boldEleven"><a href="TimeInOutIndividualReportfirst.jsp" target="_blank">Individual</a></td>
                        <td  class="boldEleven"><a href="NonRegisterStaffInfo.jsp" target="_blank">NonRegistered</a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven"><a href="LeaveList.jsp" target="_blank">Leave List</a></td>
                        <td class="boldEleven"><a href="Rept_GraphEmployeeWiseFinancialyear.jsp" target="_blank">Financial Employee Wise</a></td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="OnDutyMonth.jsp" target="_blank">On Duty</a></td>
                        <td class="boldEleven"><a href="AdminHolidayMonth.jsp" target="_blank">Holiday</a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven"><a href="FingerPrintImageReport.jsp" target="_blank">Image</a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven"><a href="StaffLeaveReport.jsp" target="_blank">Individual Leave</a></td>
                        <td class="boldEleven"><a href="Rept_LineGraph.jsp" target="_blank">Line Graph</a></td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="LeaveMonth.jsp" target="_blank">Leave</a></td>
                        <td class="boldEleven"><a href="AdminOTMonth.jsp" target="_blank">Over Time</a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven"><a href="StaffLeaveReportIndividual.jsp" target="_blank">Individual Leave Balance</a></td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="PermissionMonth.jsp" target="_blank">Permission</a></td>
                        <td class="boldEleven"><a href="CommonHolidayReport.jsp" target="_blank">Common Holiday</a></td>
                        <td class="boldEleven"><a href="NonRegisterStaffInfo.jsp" target="_blank"></a></td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="OTMonth.jsp" target="_blank">Over Time</a></td>
                        <td class="boldEleven"><a href="AdminEDMonth.jsp" target="_blank">Extra day</a></td>
                        <td class="boldEleven"><a href="FingerPrintImageReport.jsp" target="_blank"></a></td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="LeaveMonth.jsp" target="_blank">Extra Days</a></td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="AttendanceAll.jsp" target="_blank">All</a></td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven"><a href="MusterRollMonth.jsp" target="_blank">Muster Roll</a></td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
                        <td  class="boldEleven">&nbsp;</td>
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
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><!--<table width="15" border="1" align="center" cellpadding="3" cellspacing="1" bordercolor="#9900CC">
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td width="178"  class="bold1"><div align="center">Staff</div></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="StaffPersonalInfo.jsp" target="_blank">Personal    Informations</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="StaffPFNumberInfo.jsp" target="_blank">PF Number Information</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="StaffOfficialInfo.jsp" target="_blank">Official Informations</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="StaffAddressInfo.jsp" target="_blank">Address Informations</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="Photonotavailable.jsp" target="_blank">Photo Not Available</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="Profilenotavailable.jsp" target="_blank">Profile Not Available</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="GrossPay.jsp" target="_blank">Gross Pay</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="SummaryEmployeereports.jsp" target="_blank">Employee Summary Report</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="ReportingTo.jsp" target="_blank">Reporting To</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="Rept_CertificationCompleted.jsp" target="_blank">Certification Completed</a></td>
        </tr>
        <tr>
          <td  class="boldEleven"><a href="Rept_CertificationNotCompleted.jsp" target="_blank">Certification not Completed</a></td>
        </tr>
      </table>--></td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td><table border="0" align="center" cellpadding="2"
										cellspacing="2">
          <tr>
            <td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('AttendanceMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>
 
<%@ include file="../footer.jsp"%>
</body>
 
</html>

<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>