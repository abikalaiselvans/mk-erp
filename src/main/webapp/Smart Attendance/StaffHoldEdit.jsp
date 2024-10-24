<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
 
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
$(function() {
		$( "#fromdt" ).datepicker({ 
			minDate: 0, 
			maxDate: 7,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif" 
			});
	});
	 
	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 

function Validate()
  {
  	try
	{
		var d1 = document.getElementById('dbdate').value;
		var d2 = document.getElementById('fromdt').value;
		
		if(  checkNull("fromdt","Enter To Date")  )
			return true;
		else
			return false;
		
	}
	catch(err)
	{
		alert(err.description);
		return false;
	}	   
	  
  }
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	 >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"><%@ include file="index.jsp"%><br>
		<br>
		</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" 	action="../SmartLoginAuth" onSubmit="return Validate()" >
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
									Hold
									<%
										String staffid=request.getParameter("staffid");
										String sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,date_format(b.DAT_HOLD,'%d-%m-%Y'),b.INT_ID  FROM com_m_staff a ,att_t_hold b  WHERE a.CHR_EMPID=b.CHR_EMPID AND b.CHR_STATUS='N' AND a.CHR_EMPID='"+staffid+"'";
										 
	 									String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
									%>
									
									</strong></div>									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color="#FF0000">* </font><span
										class="changePos">Mandatory</span></div>									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"> </div>									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="397" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
										  <td valign="middle"  
												class="boldEleven">Staff Id </td>
										  <td class="boldEleven"><%=staffid%></td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">Staff Name </td>
										  <td class="boldEleven"><%=data[0][1]%></td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">Hold Date </td>
										  <td class="boldEleven"><%=data[0][2]%><input id="holddate"  name="holddate" type="hidden" value="<%=data[0][2]%>"></td>
									  </tr>
										<tr>
											<td width="77" valign="middle"  
												class="boldEleven">Unhold Date <span class="bolddeepblue">
											 </span></td>
											<td width="313" class="boldEleven"><input name="fromdt"
												type="text" value="<%=data[0][2]%>"  id="fromdt"
												size="15" readonly="readonly">   
												 
												</td>
										</tr>
									</table>									</td>
								</tr>

								<tr>
									<td height="19" colspan="2">
									<div align="center">									</div>									</td>
								</tr>
								<tr>
								  <td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="StaffHold">
								    <input name="actionS" type="hidden" id="actionS"
										value="ATTStaffUnHold">
								    <input name="staffid" type="hidden" id="staffid" value="<%=staffid%>">
									<input name="Rowid" type="hidden" id="Rowid" value="<%=data[0][3]%>">
									<input name="dbdate" type="hidden" id="dbdate" value="<%=data[0][2]%>"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56">
											<input type="submit" name="Submit" class="buttonbold" value="Un Hold"/></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('StaffHoldview.jsp')" /></td>
										</tr>
									</table>									</td>
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