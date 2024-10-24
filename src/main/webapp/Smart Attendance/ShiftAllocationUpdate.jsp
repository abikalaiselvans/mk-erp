<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
 if(checkNullSelect("shift","Select Shift Name ","0"))
 return true;
 else
 return false;
}
function close()
{
//month=October&year=2008&stafftid=MSSJUL2006000002
}
</script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
.style5 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- onLoad="document.getElementById('TxtHname').focus()" -->
<%@ include file="index.jsp"%>
<form name="shift" meyhod="post" action="../SmartLoginAuth" onsubmit="return validate()">
<table width="86%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td width="841">&nbsp;</td>
	</tr>
	
	<tr>
	  <td height="33"><p>&nbsp;</p>
      </td>
  </tr>
	<tr>
	  <td><table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <tr>
          <td width="594">&nbsp;</td>
        </tr>
        <tr>
          <td><table width="591" border="0" align="center" cellpadding="0"
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
                  <td width="577" valign="top"><table width="577" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td colspan="2"><div align="center" class="tablesubhead"><strong>Shift
                          Allocation Update Information</strong></div></td>
                      </tr>
                      <tr>
                        <td colspan="2"><div align="right"><span class="errormessage">*</span> <span class="changePos">- Mandatory </span></div></td>
                      </tr>
                      <tr>
                        <td colspan="2"><table width="348" border="0" align="center" cellpadding="1"
										cellspacing="1">
                          <tr>
                            <td valign="middle"   class="boldEleven">&nbsp;Staff
                              Id
                              <%
					  		String staffs[]  = request.getParameter("allocation").split("~");
							String staff  = staffs[0];
							
						  	String staffname=""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_STAFFNAME from com_m_staff where CHR_EMPID='"+staff+"'","CHR_STAFFNAME");

						  	//System.out.println("\n\nStaff : "+ staff);

%>                            </td>
                            <td height="30" class="boldEleven"><strong><strong><%=staff%>
                    <input name="staffid" type="hidden" id="staffid" value="<%=staffs[0]%>">
					<input name="month" type="hidden" id="month" value="<%=staffs[1]%>">
					<input name="year" type="hidden" id="year" value="<%=staffs[2]%>">
                            </strong></strong></td>
                          </tr>
                          <tr>
                            <td height="30" valign="middle"  
												class="boldEleven">&nbsp;Staff Name</td>
                            <td class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
                          </tr>
                          <tr>
                            <td height="30" width="161" valign="middle"
												  class="boldEleven">&nbsp;Date</td>
                            <td width="180" class="boldEleven"><strong><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(staffs[4])%></strong>
                                <input type="hidden" name="Odate" value="<%=staffs[4]%>">                            </td>
                          </tr>
                          <tr>
                            <td height="30" align="left" valign="middle"
												  class="boldEleven">&nbsp;Shift
                              Master <span class="errormessage">*</span></td>
                            <!--                          <td><input name="TxtHname" type="text" class="tabledata" id="TxtHname" onKeyPress="charOnly('TxtHname','25')" size="40" maxlength="25"  value="<%//=tableRow[2]%>"></td> -->
                            <td><select name="shift" id="shift" class="tabledata">
                                <option value="0">Select</option>
                                <%
                                String sql="select int_shiftid,chr_shiftname from att_m_shift";
                                String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
                                for(int i=0;i<data.length;i++)
                                {
                                	if(staffs[3].equals(data[i][0]))
                                	out.println("<option value='"+data[i][0]+"' selected >"+data[i][1]+"</option>");
                                	else
                                    	out.println("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>");                                		
                                }
                                %>
                                
                              </select>                                                  </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td colspan="2"></td>
                      </tr>
                      <tr>
                        <td height="19" colspan="2">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="ShiftAllocation">
                            <input
										name="actionS" type="hidden" id="actionS"
										value="ATTshiftUpdate"></td>
                        <td width="51%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                            <tr>
                              <td width="56"><input type="submit" name="btSubmit"
												id="submit_btn" class="buttonbold" value="Update" onclick="return validate()"/></td>
                              <td width="56"><input type="button" name="btnsubmit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('ShiftAllocation.jsp')" /></td>
                            </tr>
                        </table></td>
                      </tr>
                  </table></td>
                  <td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
                  <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
                </tr>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
                  <td height="6"><spacer height="1" width="1" type="block" /></td>
                  <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
                </tr>
                <tr>
                  <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
                </tr>
              </tbody>
          </table></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td><p>&nbsp;</p>
      </td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table></form>
<%@ include file="../footer.jsp"%>
