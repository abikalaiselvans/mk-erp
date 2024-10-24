<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
  	if(checkNull("outTime","Enter Out Time ")&&checkNull("inTime", "Enter In Time"))
  	{	
		return true;
	}
		return false;
  }
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
.style5 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td width="100" height="77">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="StaffManualAttendancefrm" action="../SmartLoginAuth"
			onSubmit="return Validate()">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
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
									Manual Attendance Update Information</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color='red'>* </font><span
										class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="362" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="92" height="28" valign="middle"
												  class="style5">Staff Id <%
					  		String staffs[]  = request.getParameter("staffid").split("~");
							String staff  = staffs[0];
							String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
						  	String sql="SELECT DT_TIMEIN,DT_TIMEOUT,CHR_LATE,CHR_TYPE FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID='"+staff+"'";
							sql = sql +" AND DT_LOGIN='"+staffs[1]+"' ";
							String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValues(sql).split("~") ;
							String fullDay,FDay,ADay;
							fullDay="";FDay="";ADay="";
							String dtype=""+tableRow[3];
							if(dtype.equals("P"))
								fullDay="checked";
							else if(dtype.equals("F"))
								FDay="checked";
							else if(dtype.equals("A"))
								ADay="checked";
						%>
											</td>
											<td width="263" class="boldEleven"><%=staff%> <input
												name="staffid" type="hidden" id="staffid"
												value="<%=staffs[0]%>"></td>
										</tr>
										<tr>
											<td valign="middle" height="25"  
												class="style5">Staf Name</td>
											<td class="boldEleven"><%=staffname%></td>
										</tr>
										<tr>
											<td align="left" height="25" valign="middle"
												  class="bolddeepblue">Date</td>
											<td class="boldEleven"><%=staffs[1]%><input name="Date"
												type="hidden" id="Date" value="<%=staffs[1]%>"></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">In Time <font color='red'>*</font></td>
											<td class="boldEleven"><input type="text"
												value="<%=tableRow[0]%>" name="inTime" class="bolddeepblue"
												id="inTime" onKeyPress="timeOnly('inTime')">(HH:MM:SS)</td>
										</tr>
										<tr>
											<td align="left" height="25" valign="middle"
												  class="bolddeepblue">Out Time <font
												color='red'>*</font></td>
											<td class="boldEleven">
											<%
						   String outtime=tableRow[1];
						   if(tableRow[1].trim().equals("-")) outtime="";
						  %> <input type="text" value="<%=outtime%>" name="outTime"
												onkeypress="timeOnly('outTime')" class="bolddeepblue"
												id="outTime">(HH:MM:SS)</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">Day Type</td>
											<td>
											<table>
												<tr>
													<td width="20"><span class="bolddeepblue"> <input
														name="ComboDay" id="TxtDay" type="radio" value="P"
														<%=fullDay %>> </span></td>
													<td width="50"><span class="bolddeepblue">Full
													Day</span></td>
													<td width="20"><span class="bolddeepblue"> <input
														name="ComboDay" type="radio" id="TxtDay1" value="F"
														<%=FDay %>> </span></td>
													<td width="52"><span class="bolddeepblue">Forenoon</span></td>
													<td width="20"><span class="bolddeepblue"> <input
														name="ComboDay" type="radio" id="TxtDay2" value="A"
														<%=ADay %>> </span></td>
													<td width="80"><span class="bolddeepblue">Afternoon</span></td>
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">Late</td>
											<td class="boldEleven">
											<%
						  String l =tableRow[2];
						  if ((l.equals("")) || (l.equals("null"))|| (l.equals("-")))
						  	l= "";
							
						 if(l.equals("L"))
						 	out.println("<input name='Late' type='checkbox' value='L' checked='checked' />");		
						 else
							 out.println("<input name='Late' type='checkbox' value='L'  />");		
						  %>
											</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="StaffManualAttendance">
									<input name="actionS" type="hidden" id="actionS"
										value="ATTStaffManualAttendanceUpdate"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Update" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:history.back()" /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="19" colspan="2">&nbsp;</td>
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
		<td height="61">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>