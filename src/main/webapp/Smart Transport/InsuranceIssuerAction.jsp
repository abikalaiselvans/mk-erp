<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript">
function validateFields()
{
  if(checkNull('Name','Enter Issuer Name')
  
  )
  	return true;
  else
  	return false;
}
</script>

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<form name="frm" method="post" action="../SmartLoginAuth" 	onsubmit="return validateFields()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	>

<%@ include file="index.jsp"%>
<table width="100%" border="0">
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td><TABLE width=400 border=0 align=center cellPadding=0 cellSpacing=0
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
              <TD width=554 valign="top"><table width="400" border="0" align="center" cellpadding="0"
								cellspacing="0">
                  <tr>
                    <td width="100%" colspan="2"><div align="center"><span class="tablesubhead">INSURANCE ISSUER
					
	                      <%   
			String action=""+request.getParameter("submit2");
			String id=""+request.getParameter("id");
			String actionS="";
			String buttonValue="";
			String Name="";
			String TxtAdd1="";
			String TxtAdd2="";
			String city="";
			String state="";
			String pin="";
			String phone="";
			String fax="";
			String email="";
			String website ="";
			if(action.equals("Add"))
			{
				actionS="TRSInsuranceIssuerAdd";	
				buttonValue="Add";	 
				id="0";	 
				Name="";
				TxtAdd1="";
				TxtAdd2="";
				city="";
				state="";
				pin="";
				phone="";
				fax="";
				email="";
				website ="";
			}
			else
			{
				String sql ="SELECT CHR_ISSUERNAME,CHR_ADDRESS1,CHR_ADDRESS2,CHR_CITY,CHR_STATE,CHR_PINCODE,CHR_PHONENO,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS FROM vehicle_m_insuranceissuer   WHERE INT_ISSUERID="+id;
				String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				for(int u=0;u<10;u++)
					if("-".equals(data[0][u]))
						data[0][u] ="";
				Name=data[0][0];
				TxtAdd1=data[0][1];
				TxtAdd2=data[0][2];
				city=data[0][3];
				state=data[0][4];
				pin=data[0][5];
				phone=data[0][6];
				fax=data[0][7];
				email=data[0][8];
				website =data[0][9];
				actionS="TRSInsuranceIssuerEdit";
				buttonValue="Update";
			}	
	%>
	 
					 </span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><div align="right"><span class="boldElevenlink">* </span><span class="changePos">Mandatory</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table width="310" border="0" align="center" cellpadding="3" cellspacing="3">

                        <tr>
                          <td width="134" class="boldEleven">ISSUER Name <span
									class="bolddeepred">* </span></td>
                          <td width="242"   align="left"><input name="Name"
									type="text" class="formText135" id="lname" value="<%=Name%>"
									size="40" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Address1</td>
                        <td   align="left"><input name="TxtAdd1"
									type="text" class="formText135" id="street" value="<%=TxtAdd1%>"
									size="40" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Address2</td>
                        <td   align="left"><input name="TxtAdd2"
									type="text" class="formText135" id="street" value="<%=TxtAdd2%>"
									size="40" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">City</td>
                        <td   align="left"><input name="city" type="text"
									class="formText135" id="city"
									onkeypress="charOnly('city','50')" value="<%=city%>" size="40" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">State</td>
                        <td   align="left"><input name="state"
									type="text" class="formText135" id="state" onKeyPress="charOnly('state','50')" value="<%=state%>"
									size="40" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Pin Code</td>
                        <td   align="left"><input name="pin" type="text"
									class="formText135" id="pin"
									onkeypress="numericValue('pin','6')" value="<%=pin%>" size="40" maxlength="6" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven" valign="top">Phone</td>
                        <td   align="left"><input
									name="phone" type="text" class="formText135" id="phone"
									onkeypress="phoneValue('phone','50')" value="<%=phone%>" size="40" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Fax</td>
                        <td   align="left"><input name="fax" type="text"
									class="formText135" id="fax"
									onkeypress="numericValue('fax','50')" value="<%=fax%>" size="40" maxlength="30" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Email</td>
                        <td   align="left"><input name="email"
									type="text" class="formText135" id="email" value="<%=email%>" size="40"
									maxlength="30"   /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Website</td>
                        <td   align="left"><input name="website"
									type="text" class="formText135" value="<%=website%>" size="40" maxlength="30"
									  /></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                        <tr>
                          <td>
		<input name="filename" type="hidden" id="filename" value="InsuranceIssuer">
		<input name="id" type="hidden" id="id" value="<%=id%>">
                              <input name="actionS" type="hidden" id="actionS" value="<%=actionS%>"></td>
                          <td width="56"><input type="submit" name="Submit" id="submit_btn" class="buttonbold" value="<%=buttonValue%>" tabindex="30" /></td>
                          <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Insurancemaster.jsp')" tabindex="31" />
                          </td>
                        </tr>
                    </table></td>
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
        </TABLE></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
   <%@ include file="../footer.jsp"%>
</body>
</form>
</html>
