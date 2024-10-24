<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
  	if( checkNull("out","Enter Place Name...") 
		&& checkPermissionTime('it','out','2')
	){
	
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
		<td height="53">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="onDutyAddfrm" action="../SmartLoginAuth"
			onSubmit="return Validate()">
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
									<div align="center" class="boldEleven"><strong>Permission
									Update Information</strong></div>
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
											<td valign="middle"   class="style5">Staff
											Id <%
					  		String staffs[]  = request.getParameter("staffid").split("~");
							String staff  = staffs[0];
						  	String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
						  	String sql ="";
							sql = "SELECT CHR_PTYPE,DT_PDATE, DT_TIME_FROM, DT_TIME_TO,CHR_PTYPE,CHR_REASON FROM ATT_T_PERMISSION";									
							sql = sql +" WHERE CHR_EMPID = '"+staff+"'";
							sql = sql +" AND  DT_PDATE = '" +staffs[1] +"'";
							sql = sql +" AND DT_TIME_FROM = '" +staffs[2] +"'";
							String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValues(sql).split("~") ;
							String c2="";
							String c3="";
							if(tableRow[0].equals("F"))
								c2 ="checked";
							if(tableRow[0].equals("A"))
								c3 ="checked";
					%>
											</td>
											<td class="boldEleven"><strong><strong><%=staff%>
											<input name="staffid" type="hidden" id="staffid"
												value="<%=staffs[0]%>"> </strong></strong></td>
										</tr>
										<tr>
											<td valign="middle"   class="style5">Staf
											Name</td>
											<td class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
										</tr>
										<tr>
											<td width="92" valign="middle"  
												class="bolddeepblue">Date</td>
											<td width="263" class="boldEleven"><%=staffs[1]%> <input
												name="date" type="hidden" id="date" value="<%=staffs[1]%>"></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="tabledata">
											<p class="style8"><span class="bolddeepblue">Day <font
												color="#FF0000">*</font></span></p>
											</td>
											<td>
											<table width="100" border="0" cellspacing="1" cellpadding="1">
												<tr>
													<td><span class="bolddeepblue"> <input
														name="ComboDay" type="radio" id="TxtDay1" value="F"
														<%=c2%>> </span></td>
													<td><span class="bolddeepblue">Forenoon</span></td>
													<td><span class="bolddeepblue"> <input
														name="ComboDay" type="radio" id="radio" value="A" <%=c2%>>
													</span></td>
													<td><span class="bolddeepblue">Afternoon</span></td>
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">From Time<font color="#FF0000">
											*</font></td>
											<td><span class="bolddeepblue"><%=tableRow[2]%> <input
												name="int" type="hidden" class="tabledata" id="it"
												onKeyPress="timeOnly('it')" value="<%=tableRow[2]%>">
											(HH:MM:SS) </span></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">To Time <font color="#FF0000">*</font>
											</td>
											<td><span class="bolddeepblue"> <input name="out"
												type="text" class="tabledata" id="ot"
												onKeyPress="timeOnly('ot')" value="<%=tableRow[3]%>">
											(HH:MM:SS) </span></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="bolddeepblue">Reason</td>
											<td><input name="reason" type="text" class="tabledata"
												onKeyPress="charOnly('reason','20')"
												value="<%=tableRow[5]%>" size="45"></td>
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
										type="hidden" id="filename" value="StaffPermission"> <input
										name="actionS" type="hidden" id="actionS"
										value="ATTStaffPermissionUpdate"></td>
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
												onClick="redirect('Permission.jsp')" /></td>
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
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>