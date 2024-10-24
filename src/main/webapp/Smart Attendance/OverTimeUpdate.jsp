<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
  	if( checkNull("TxtOt","Enter The Time...") 
		&& checkNull("TxtBatta","Enter The batta ")
			 && checkNull("TxtWashing","Enter The washing ")
			 && checkNull("TxtDes","Enter The Description ")
		
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td width="100">&nbsp;</td>
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
									<div align="center" class="boldEleven"><strong>OverTime
									Update Information</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><span class="article style3"> <font
										color='red'>*</font> </span><span class="changePos">Mandatory</span></div>
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
											<td valign="middle" height="30"  
												class="style5">Staff Id <%
						  
					  		String staffs[]  = request.getParameter("staffid").split("~");
							String staff  = staffs[0];							
						  	String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
						  	String sql ="";
				sql = "SELECT INT_MINS, CHR_BATTA, CHR_WASHING, CHR_DIS FROM att_t_ot where CHR_EMPID = '"+staff+"'";
				sql = sql +" AND  DT_OTDATE = '" +staffs[1] +"'";
				String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValues(sql).split("~") ;
				
				
					  %>
											</td>
											<td class="boldEleven"><strong><strong><%=staff%>
											<input name="staffid" type="hidden" id="staffid"
												value="<%=staffs[0]%>"> </strong></strong></td>
										</tr>
										<tr>
											<td valign="middle" height="25"  
												class="style5">Staf Name</td>
											<td class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
										</tr>
										<tr>
											<td width="133" height="28" valign="middle"
												  class="style5">Date</td>
											<td width="299" class="boldEleven"><%= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(staffs[1])%>
											<input name="date" type="hidden" id="date"
												value="<%=staffs[1]%>"></td>
										</tr>

										<tr>
											<td align="left" height="28" valign="middle"
												  class="bolddeepblue">Over Time
											[Minutes]<font color='red'> *</font><br>
											</td>
											<td><input name="TxtOt" type="text" class="formText135"
												id="TxtOt" onKeyPress=" return numeric_only(event,'TxtOt','6')"  maxlength="5"
												size="40"   value="<%=tableRow[0]%>"></td>
										</tr>
										<tr>
											<td align="left" height="28" valign="middle"
												  class="bolddeepblue">Batta<font color='red'> *</font></td>
											<td><input name="TxtBatta"  id="TxtBatta"type="text" class="formText135"
												onKeyPress=" return numeric_only(event,'TxtBatta','6')" maxlength="5"  size="40"
												  value="<%=tableRow[1]%>"></td>
										</tr>
										<tr>
											<td align="left" height="28" valign="middle"
												  class="bolddeepblue">Washing <font color='red'>*</font></td>
											<td><input name="TxtWashing"  id="TxtWashing" type="text"
												class="formText135"
												onKeyPress=" return numeric_only(event,'TxtWashing','6')" maxlength="5"  size="40"
												  value="<%=tableRow[2]%>"></td>
										</tr>
										<tr>
											<td align="left" height="28" valign="middle"
												  class="bolddeepblue">Description <font color='red'>*</font></td>
											<td><textarea name="TxtDes" cols="40" rows="5" class="formText135" id="TxtDes" onKeyPress="textArea('TxtDes','150')"><%=tableRow[3]%></textarea></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="OverTime"> <input
										name="actionS" type="hidden" id="actionS"
										value="ATTovertimeUpdate"></td>
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
												onClick="redirect('OverTime.jsp')" /></td>
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