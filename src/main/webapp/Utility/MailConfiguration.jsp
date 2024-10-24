 <%@ page import="java.sql.*,java.io.*,java.util.*"%>
 <%
 try
 {
 %>
<html>
<head>
 <%@include file="Redirect.jsp" %>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
	if(	
		checkNull("technicalheader","Enter Technical Header") 
		&& checkNull("technicalfooter","Enter Tecnical Footer") 
		&& checkNull("productheader","Enter Product Footer") 
		&& checkNull("productfooter","Enter Product Footer") 
		 
		)
			return true;
	else
		return false;
  }
 </script>

<title> :: UTILITY :: </title>


 
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
									<div align="center" class="boldEleven"><strong>Mail Configuration
									
									<%
									
String  data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_TECHHEADER,CHR_TECHNICALREMOVE,CHR_TECHFOOTER ,CHR_PRODUCTHEADER ,CHR_PRODUCTREMOVE,CHR_PRODUCTFOOTER FROM email_m_emailconfiguration  WHERE INT_ID=1");
					 
									%>
									
									 </strong><span class="article style3"></span></div>
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
									<table width="455" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
										  <td width="142" valign="top"  
												class="boldEleven">Technical Header </td>
										  <td width="213" valign="top" class="boldEleven"><textarea name="technicalheader" cols="50" rows="5" id="technicalheader"><%=data1[0][0]%></textarea></td>
									  </tr>
										<tr>
										  <td valign="top"  
												class="boldEleven">Technical Footer </td>
										  <td valign="top" class="boldEleven"><textarea name="technicalfooter" cols="50" rows="5" id="technicalfooter"><%=data1[0][2]%></textarea></td>
									  </tr>
										<tr>
										  <td valign="top"  
												class="boldEleven">&nbsp;</td>
										  <td valign="top" class="boldEleven">&nbsp;</td>
									  </tr>
										<tr>
										  <td valign="top"  
												class="boldEleven">Product Header </td>
										  <td valign="top" class="boldEleven"><textarea name="productheader" cols="50" rows="5" id="productheader"><%=data1[0][3]%></textarea></td>
									  </tr>
										<tr>
										  <td valign="top"  
												class="boldEleven">Product Footer </td>
										  <td valign="top" class="boldEleven"><textarea name="productfooter" cols="50" rows="5" id="productfooter"><%=data1[0][5]%></textarea></td>
									  </tr>
									</table>
									</td>
								</tr>

								<tr>
									<td height="19" colspan="2">
									<div align="center"> 									</div>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="MailSetting"> 
									<input
										name="actionS" type="hidden" id="actionS"
										value="UTIMailConfigurationAdd"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Update"
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
<%
}
catch(Exception e)
{
}
%>