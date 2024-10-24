 <%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
 
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
	if(	checkNull("fromdt","Enter Date") 
		&& chkemail("email")
		)
			return true;
	else
		return false;
  }
 </script>

<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
 
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
	</tr>
	<tr>
		<td width="100" height="51">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
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
									<div align="center" class="boldEleven"><strong>Mail Setting </strong><span class="article style3"></span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><span class="article style3">*
									</span><span class="changePos">Mandatory</span></div>
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
										  <td valign="middle"  
												class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">File Upload </td>
										  <td class="boldEleven"><a href="javascript:FlyerUpload()">Click</a></td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">Send Which Group </td>
										  <td class="boldEleven"><select name="group" id="group">
                                            <option value="0">All</option>
                                            <%
			  String sdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  email_m_customergroup ORDER BY CHR_GROUPNAME ");
			  for(int u=0;u<sdata.length;u++)
			  	out.println("<option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                                          </select>
<script language="javascript">										  
function FlyerUpload()
	{
			var f ="FlyerUpload.jsp";
			newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
			newWindow.focus();
		
	}	
	</script>										  </td>
									  </tr>
										<tr>
											<td width="142" valign="middle"  
												class="boldEleven">Date<span class="bolddeepblue">										    </td>
											<td width="213" class="boldEleven">
											
											
	<input name="fromdt" type="text" class="tabledata" id="fromdt"  value="" size="25" readonly>

											<a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a> <script
												language='JavaScript'>
								<!--
								var cal1 = new calendar1(document.forms['frm'].elements['fromdt']);
								cal1.year_scroll = true;
								cal1.time_comp = true;
								setCurrentDateandTime('fromdt');			
								//-->
								</script></td>
										</tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">Mailid From </td>
										  <td class="boldEleven"><input name="email" type="text" class="formText135" id="email" value=" " size="25" maxlength="30" onKeyPress="isEmailID('email','30')" ></td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
									  </tr>
										<tr>
										  <td valign="middle"  
												class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
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
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="MailSetting"> 
									<input
										name="actionS" type="hidden" id="actionS"
										value="UTIMailSettingAdd"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												  /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('Userframe.jsp')"  /></td>
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
		<td> </td>
	</tr>
</table>