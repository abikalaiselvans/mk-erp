<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body >
<p>
  <%
String PRNumber = request.getParameter("PRNumber");
String sql="";
sql = " SELECT CHR_APPROVEDDESCRIPTION , DATE_FORMAT(DAT_APPROVEDDATE,'%d-%b-%Y') ";
sql = sql + " FROM inv_t_purchaserequest  ";
sql = sql + " WHERE CHR_APPROVEDSTATUS ='R' AND CHR_POREQUESTNO='"+PRNumber+"' ";
String Data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(Data.length>0)
{
%>
<table class="BackGround1" cellspacing="0" cellpadding="0" width="60%"
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
      <td><table width="569" height="186" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="2"><div align="center" class="boldgre">
              <div align="center">PURCHASE REQUEST </div>
          </div></td>
        </tr>
        <tr>
          <td width="187" class="boldEleven">Request Number </td>
          <td width="380" class="boldEleven"><%=PRNumber%></td>
        </tr>
        <tr>
          <td class="boldEleven">Date</td>
          <td class="boldEleven"><%=Data[0][1]%></td>
        </tr>
        <tr>
          <td class="boldEleven">Reson</td>
          <td class="boldEleven"><%=Data[0][0]%></td>
        </tr>
        <tr>
          <td class="boldEleven">&nbsp;</td>
          <td class="boldEleven">&nbsp;</td>
        </tr>
      </table></td>
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
<p>&nbsp;</p>
<%
}
%>
</p>

<p>&nbsp;</p>
</body>
</html>
