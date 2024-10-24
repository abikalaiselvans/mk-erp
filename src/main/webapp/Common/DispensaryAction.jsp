<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript"
	src="../JavaScript/Attendance/AttendanceAjax.js"></script>


</head>
<body onpaste="return false;" leftmargin="0" rightmargin="0"
	topmargin="0">

<%@ include file="insert.jsp"%>

<form AUTOCOMPLETE="off" name="casesheet" method="post"
	action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="82"></td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">DISPENSARY INFORMATION</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Dispensary Place <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input type="type"
									name="dispname" id="dispname" class="formText135"
									onBlur="TxtTrim(this),CheckUnique(this,'soValid','com_m_dispensary','CHR_DESPNAME')"
									onKeyUp="upperMe(this),TxtTrim(this),CheckUnique(this,'soValid','com_m_dispensary','CHR_DESPNAME')"
									maxlength=50 size='35'>
								<div id="soValid"></div>
								</td>
							</tr>



							<tr>
								<td height="17" valign="top" class="boldEleven">Address</td>
								<td colspan="2" align="left" class="bolddeepblue"><textarea
									name="address" cols="30" rows="5" class="formText135"
									id="address"></textarea></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Pin code</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									name="pincode" type="text" class="formText135" id="pincode"
									onKeyPress="numericValue('pincode','6')" value="0" size="15"
									maxlength="6"></td>
							</tr>
							<tr>
								<td width="167" height="17" valign="top" class="boldEleven">Phone</td>
								<td width="207" colspan="2" align="left" class="bolddeepblue"><input
									name="phone" type="text" class="formText135" id="phone"
									onKeyPress="numericValue('phone','16')" value="0" size="15"
									maxlength="19"></td>
							</tr>

							<tr>
								<td height="30" colspan="3" valign="top"><input
									type="hidden" name="filename" value="Dispensary" /> <input
									type="hidden" name="actionS" value="COMDispensaryAdd" /> <input
									name="path" type="hidden" id="path" value="<%=path%>">
								<td>
							</tr>
							<tr>
								<td height="30" colspan="3" valign="top">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="submit"
											id="submit" class="buttonbold" value="Submit" accesskey="s">
										</td>
										<td width="56">
										<div align="center"><input name="close" type="button"
											class="buttonbold" value="Close" accesskey="c"
											onClick="redirect('../Common/DispensaryView.jsp?path=ATT')">
										</div>
										</td>
									</tr>
								</table>
								<td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
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
		<td></td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>


</form>
</body>
</html>
