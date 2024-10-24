  <%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>


</head>
 
<body  onpaste="return false;" >

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post"  >
<table width="900" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%
try
{
	
	 
 %>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
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
					<td width="7"><spacer height="1" width="1" type="block" /></td>
					<td width="575">
					<table width="100%" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround"><span
								class="boldThirteen">CONVEYANCE REPORT</span></td>
						</tr>

						 
						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3"><table width="100%" border="0" align="center" cellpadding="3" cellspacing="4">
                             
							 <%
							 if("S".equals(session.getAttribute("USRTYPE"))) {
							 %>
							  <tr>
                                <td>&nbsp;</td>
                                <td><a href="ListConveyanceAll.jsp">Conveyance Employee with CTC</a></td>
                              </tr>
							  <tr>
                                <td>&nbsp;</td>
                                <td><a href="AllemployeeListConveyanceAll.jsp">All Employee with CTC</a></td>
                              </tr>
							  <%}%>
                              <tr>
                                <td>&nbsp;</td>
                                <td><a href="ListConveyancee.jsp">Individual Employee  </a></td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td><a href="Rept_Conveyances.jsp" target="_blank">Conveyance</a></td>
                              </tr>
                              
                            </table>							</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="72" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Conveyancemain.jsp')"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td width="135" height="2"></td>
							<td width="225"></td>
						</tr>
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
</table>
<%
}
catch(Exception e)
{
	 
}
%>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
