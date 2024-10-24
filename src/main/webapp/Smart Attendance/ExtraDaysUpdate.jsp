<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:directive.page import="com.my.org.erp.ServiceLogin.DateUtil" />
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="70" width="100">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frmExDtUpdate" action="../SmartLoginAuth"
			onLoad="document.frmExDtUpdate.TxtDes.focus()">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
				<td>&nbsp;</td>
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
									<div align="center" class="boldEleven"><strong>Extra
									Days Update Information</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><span class="article style3"> *
									</span><span class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="439" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td height="30" valign="middle"  
												class="style5">Staff Id <%
						  
					  		String staffs[]  = request.getParameter("staffid").split("~");
							String staff  = staffs[0];							
						  	String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
						  	String sql ="";

					sql = "SELECT DT_EXTRADATE, CHR_DIS FROM att_t_extradays where CHR_EMPID = '"+staff+"'";
					sql = sql +" AND  DT_EXTRADATE = '" +staffs[1] +"'";
					String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValues(sql).split("~") ;
					String Edate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(tableRow[0]);
//					//System.out.println("\n\n\tStaff ID : "+ staff);
				
				%>
											</td>



											<td class="boldEleven"><strong>staff<strong>
											<input name="staffid" type="hidden" id="staffid"
												value="<%=staff%>"></strong></td>
										</tr>
										<tr>
											<td height="30" valign="middle"  
												class="style5">Staff Name</td>
											<td class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
										</tr>
										<tr>
											<td height="30" width="92" valign="middle"
												  class="bolddeepblue">Date</td>
											<td width="263" class="boldEleven"><%=Edate%> <!-- 						<input type="text"  title="dd/mm/yyyy" value="<%=Edate%>" onKeyPress="numericHypenOnly('TxtUdate','9')" name="TxtUdate" id="TxtUdate" size="15"> -->
											<input name="TxtOdate" type="hidden" id="TxtOdate"
												value="<%=tableRow[0]%>"></td>

										</tr>
										<tr>
											<td height="30" align="left" valign="middle"
												  class="bolddeepblue">Description</td>
											<td><input name="TxtDes" type="text"
												onKeyPress="charOnly('TxtDes','150')"
												value="<%=tableRow[1]%>" size="40" maxlength="35"></td>
										</tr>

									</table>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="ExtraDays"> <input
										name="actionS" type="hidden" id="actionS"
										value="ATTExtraDaysUpdate"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="Submit" class="buttonbold" value="Update" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('ExtraDays.jsp')" /></td>
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