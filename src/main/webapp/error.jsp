<%@ page isErrorPage="true"%>
<%@ page import="java.io.PrintWriter;"%>
<html>
<head>
<title>Error Page</title>

<link href="JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table class="BackGround" cellspacing="0" cellpadding="0" width="800"
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
              <td width="412"><table width="800" border="0" align="center" cellpadding="0" cellspacing="0" >
                  <!--DWLayoutTable-->
                  <tr align="center" valign="middle">
                    <td height="28" colspan="2" ><span class="style1">Exception Information</span></td>
                  </tr>
                  <tr align="center" valign="middle">
                    <td height="28" colspan="2" ><% exception.printStackTrace(new PrintWriter(out));%></td>
                  </tr>
                  <tr align="center" valign="middle">
                    <td height="28" colspan="2" ><table width="608" border="0" cellspacing="2" cellpadding="2">
                      <tr>
                        <td><span class="bold1">Exception Class:</span></td>
                        <td><span class="bolddeepred"><%= exception.getClass() %></span></td>
                      </tr>
                      <tr>
                        <td><span class="bold1">Message</span></td>
                        <td><span class="bolddeepred"><%= exception.getMessage() %></span></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr align="center" valign="middle">
                    <td height="28" colspan="2" class="BackGround"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>

                  <tr>
                    <td height="28" colspan="2" valign="middle" class="bolddeepblue"><table width="100" border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td><a href="javascript:window.history.back(0)">Back</a></td>
                          <td><a href="index.jsp">Login</a></td>
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
