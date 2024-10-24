<html>
<head>
<%
try
{
%>
<title>:: STAFF ::</title>

 
</head>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<body  onpaste='return false;'>
 
 
<p><br>
  <br>
  <br>
  <br>
</p>
<p>&nbsp; </p>
<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
      <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block" /></td>
      <td width="412"><table width="95%" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle">
          <td height="28" colspan="2"  class="BackGround">Error  
            Information            </td>
        </tr>
        <tr>
          <td height="28" colspan="2" valign="middle" class="bolddeepblue"><div align="center" class="bolddeepred">
            
              <div align="center"> 
                <%=""+request.getParameter("error") %>
 
              </div>
          </div></td>
        </tr>
        <tr>
          <td height="28" colspan="2" valign="middle" class="bolddeepblue"><table width="100" border="0" align="center" cellpadding="2" cellspacing="2">
            <tr>
              <td><a href="javascript:window.history.back(0)">Back</a></td>
              
            </tr>
          </table></td>
          </tr>
        <tr>
          <td width="138" height="28" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td width="228" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td height="28" colspan="2" valign="middle" class="tabledata"><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
  </tbody>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
