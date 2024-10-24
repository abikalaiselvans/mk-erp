<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: CONVEYANCE ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style4 {color: #FF0000}
-->
</style>
</head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Conveyance.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>

<script language="javascript">
function validate()
{
	if(checkNullSelect('paydate','Select paydate','0'))
		return true;
	else
		return false;
}
</script>
<body  onpaste='return false;'>

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate() ">
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
		<table class="BackGround" cellspacing="0" cellpadding="0" width="588"
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
								class="boldThirteen">Conveyance Advance Changes </span></td>
						</tr>

						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3">
							<table width="256" border="0" align="center" cellpadding="3"
								cellspacing="1">
								<tr>
									<td width="82" class="boldEleven">Date <span class="style4">*</span> </td>
								    <td width="159" class="boldEleven">
									 
									
<select name="paydate" class="formText135" id="paydate">
<option value="0">Select</option>
<%
	String sql=" SELECT DATE_FORMAT(DAT_ACCDATE,'%Y-%m-%d'), DATE_FORMAT(DAT_ACCDATE,'%e-%M-%Y'),COUNT(*) FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y' GROUP BY DAT_ACCDATE ORDER BY DAT_ACCDATE DESC LIMIT 0,2";
	String Data[][] =  CommonFunctions.QueryExecute(sql);
	for(int u=0;u<Data.length;u++)
		out.println("<option value='"+Data[u][0]+"'>"+Data[u][1] + " - [ " +Data[u][2]+" ] </option>");
%>
</select>									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3">
							
							 <input name='filename' type='hidden' value='ConveyanceAdvance'> 
		 <input name='actionS' type='hidden' value='CONConveyanceAdvanceDEDChanges'> 
		
							</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold13" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold13" type="button"
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
	//System.out.println(e.getMessage());
}
%>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
