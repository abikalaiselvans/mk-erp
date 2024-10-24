<html>
<head>

<title> :: TRANSPORT ::</title>
</html>
 

<link rel="stylesheet" type="text/css" href="../JavaScript/styles.css">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%> </td>
  </tr>
  <tr>
    <td height="480"><TABLE width=572 border=0 align=center cellPadding=0 cellSpacing=0
					bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" width="1"
								type="block" /></TD>
          <TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/TRCorner.gif" width=7></TD>
        </TR>
        <TR>
          <TD height=6><SPACER height="1" width="1" type="block" /></TD>
        </TR>
        <TR>
          <TD class=BorderLine width=1><SPACER height="1" width="1"
								type="block" /></TD>
          <TD width=8><SPACER height="1" width="1" type="block" /></TD>
          <TD width=554 valign="top"><table width="540" border="0" align="center" cellpadding="0"
								cellspacing="0">
              <tr>
                <td width="100%" colspan="2"><div align="center"></div></td>
              </tr>
              <tr>
                <td colspan="2"><div align="right"></div></td>
              </tr>
              <tr>
                <td colspan="2"></td>
              </tr>
              <tr>
                <td height="19" colspan="2">
				<form   method="post" name="frm" id="frm" action="Rept_InsuranceTransactionSelectionResponse.jsp"> 
                  <table width="442" border="0" align="center" cellpadding="3" cellspacing="3">
                    <tr>
                      <td class="boldEleven">Office</td>
                      <td class="boldEleven"><select name="offices" class="formText135" id="offices"  >
                          <option value="0">All</option>
                          <%
		String sql ="SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office ORDER BY CHR_OFFICENAME ";
		String officeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<officeData.length;u++)
			out.println("<option value='"+officeData[u][0]+"'>"+officeData[u][1]+"</option>");

	%>
                      </select></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Remainder</td>
                      <td class="boldEleven"><select name="reminder" class="formText135" id="reminder" onChange="LoadInsuranceTransaction('0')">
                          <option value="0">All</option>
                          <%
		sql ="SELECT INT_REMINDERID,CHR_REMINDERNAME FROM vehicle_m_insurancereminder ORDER BY CHR_REMINDERNAME";
		String reminderData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<reminderData.length;u++)
			out.println("<option value='"+reminderData[u][0]+"'>"+reminderData[u][1]+"</option>");

	%>
                      </select></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">From</td>
                      <td class="boldEleven"><input name="frmdate" type="text" class="formText135"
										id="frmdate" onKeyPress="dateOnly('frmdate')" size="15">
                        <a href="javascript:cal1.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click Here to Pick up the date"></a></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">To</td>
                      <td class="boldEleven"><input name="todate" type="text" class="formText135"
										id="todate" onKeyPress="dateOnly('todate')" size="15">
                          <a href="javascript:call2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click Here to Pick up the date"></a>
                          <script
										language="JavaScript">			
<!--
			var cal1 = new calendar1(document.forms['frm'].elements['frmdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call2 = new calendar1(document.forms['frm'].elements['todate']);
			call2.year_scroll = true;
			call2.time_comp = false;		
			setCurrentDate('frmdate');
			setCurrentDate('todate');			
			
//-->	
                          </script></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Insurance Issuer </td>
                      <td><select name="Issuer" class="formText135" id="Issuer">
                          <option value="0" selected="selected">All</option>
                          <%
		sql ="SELECT INT_ISSUERID,CHR_ISSUERNAME FROM vehicle_m_insuranceissuer   ";
		String issuerData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<issuerData.length;u++)
			out.println("<option value='"+issuerData[u][0]+"'>"+issuerData[u][1]+"</option>");

	%>
                        </select></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Policy Status </td>
                      <td class="boldEleven"><select name="pstatus" class="formText135" id="pstatus">
                        <option value="0" selected="selected">All</option>
                        <option value="Y">Live</option>
						<option value="N">Not live</option>
                      </select></td>
                    </tr>
                    <tr>
                      <td height="25" class="boldEleven">Vechicle Status </td>
                      <td class="boldEleven"><select name="vstatus" class="formText135" id="vstatus">
                        <option value="0" selected="selected">All</option>
                        <option value="Y">Live</option>
                        <option value="N">Not live</option>
                      </select></td>
                    </tr>
                    <tr>
                      <td colspan="2"><table width="140" border="0" align="center" cellpadding="2"
										cellspacing="2">
                        <tr>
                          <td width="56"><input name="Submit" type="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
                          <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Transportmain.jsp')" tabindex="31" /></td>
                        </tr>
                      </table></td>
                      </tr>
                  </table>
                    </form>
                </td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
          </table></TD>
          <TD noWrap width=8><SPACER height="1" width="1" type="block" /></TD>
          <TD class=BorderLine width=1><SPACER height="1" width="1"
								type="block" /></TD>
        </TR>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/BLCorner.gif" width=7></TD>
          <TD height=6><SPACER height="1" width="1" type="block" /></TD>
          <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7
								src="../Image/General/BRCorner.gif" width=7></div></TD>
        </TR>
        <TR>
          <TD class=BorderLine height=1><SPACER height="1" width="1"
								type="block" /></TD>
        </TR>
      </TBODY>
    </TABLE>
      <p>&nbsp;</p>
      </td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%> </td>
  </tr>
</table>

 


