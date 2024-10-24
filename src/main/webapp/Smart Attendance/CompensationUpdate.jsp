<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
.style5 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="document.getElementById('TxtHname').focus()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td width="100" height="70">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frmHoliUpdate" action="../SmartLoginAuth">
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
									<div align="center" class="boldEleven"><strong>Compensation
									Update Information</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>

								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="439" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td valign="middle"   class="style5">Staff
											Id <%
					  		String staffs[]  = request.getParameter("staffid").split("~");
							String staff  = staffs[0];
							//System.out.println("\n\nSTAFF : "+ staff);
							
						  	String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());

						  	//System.out.println("\n\nStaff : "+ staff);


						  	String sql ="";
						sql = "SELECT CHR_EMPID, DT_HOLIDATE, CHR_HOLINAME FROM att_t_compensation ";
						sql = sql+ "WHERE CHR_EMPID = '"+staff+"'";
						sql = sql +" AND  DT_HOLIDATE = '" +staffs[1] +"'";
						//System.out.println("\n\n"+sql);
						String dd = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(staffs[1]);
						
						
						String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValues(sql).split("~") ;

				%>
											</td>
											<td height="30" class="boldEleven"><strong><strong><%=staff%>
											<input name="staffid" type="hidden" id="staffid"
												value="<%=staffs[0]%>"> </strong></strong></td>
										</tr>
										<tr>
											<td height="30" valign="middle"  
												class="style5">Staf Name</td>
											<td class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
										</tr>
										<tr>
											<td height="30" width="92" valign="middle"
												  class="style5">Date</td>
											<td width="340" class="boldEleven"><strong><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(staffs[1])%></strong>
											<input type="hidden" name="Odate" value="<%=staffs[1]%>">
											</td>
										</tr>
										<tr>
											<td height="30" align="left" valign="middle"
												  class="bolddeepblue">Description
											</td>
											<td><input name="TxtHname" type="text" class="tabledata"
												id="TxtHname" onKeyPress="charOnly('TxtHname','25')"
												size="40" maxlength="25" value="<%=tableRow[2]%>"></td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="Compensation"> <input
										name="actionS" type="hidden" id="actionS"
										value="ATTCompensationUpdate"></td>
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
												onClick="redirect('Compensation.jsp')" /></td>
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