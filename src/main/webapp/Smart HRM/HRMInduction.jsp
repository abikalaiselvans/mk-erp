<%@ page import="java.sql.*,java.io.*,java.util.*" %>

<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/AJAXFunctionStaff.js"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/HRM/JobDespAjax.js"></script>

<title>:: HRM ::</title>


 

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style3 {color: #FF0000}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off" name="form1" method="post" action="../SmartLoginAuth" >
<%@ include file="indexhrm.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0">
   <tr>
    <td valign="top"><table width="886" border="0" align="center" cellpadding="2" cellspacing="2">
      <tr>
        <td width="71" height="580"></td>
        <td width="801"><TABLE width=782 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
              <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
            </TR>
            <TR>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
            </TR>
            <TR>
              <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
              <TD width=545 valign="top"><table width="761" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td colspan="2"><div align="center"><span class="boldThirteen">HRM INDUCTION</span></div></td>
                  </tr>
                  <tr>
                   </tr>
                  <tr>
                    <td colspan="2"><table width="278" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="288" class="boldEleven"><table width="238" border="0" align="center" cellpadding="2" cellspacing="0">
                            <tr>
                              <td width="100" class="boldEleven">Job Code</td>
                             
                    <td><select name="jobCode" id="jobCode" class="tabledata" onChange="loadTitleValues(this)">
					<option value="-1">Select</option>         
              		<!-- 
              		
              		hi
              		 -->
              		 <%
						String sql="SELECT CHR_JOBCODE FROM hrm_m_jobdesign";	
						String sval[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						int i;
						for(i=0;i<sval.length;i++)
						{
  							out.println("<option value='"+sval[i][0]+"'>"+sval[i][0]+"</option>");
  						}
  					 %>
              		 
              		 
              		 
  				</select>
                    </td>
                        </tr>
                            <tr>
                              <td width="100" class="tabledata">Job Title</td>
                              <td> <input name="title" id="title" type="text" class="tabledata"  value="" size="25" readonly/> </td>                  
                              
                            </tr>
                            <tr>
                              <td width="108" class="boldEleven">&nbsp;</td>
                              <td colspan="2" class="boldEleven">&nbsp;</td>
                            </tr>
                          </table></td>
                          </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                        <tr>
                          <td height="152"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td width="98%" height="144"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="2" bordercolor="#D4D0C8" class="boldEleven">
                                  <tr>
                                    <td colspan="4"><div align="center"><span class="tabledata"><strong>Job Profile</strong></span></div></td>
                                  </tr>
                                  <tr>
                                    <td width="117">&nbsp;</td>
                                    <td width="258">&nbsp;</td>
                                    <td width="146">&nbsp;</td>
                                    <td width="203"><input type="hidden" name="marry2" />
                                        <span class="boldThirteen">
                                        <input type="hidden" name="stype" />
                                      </span></td>
                                  </tr>
                                  <tr>
                                    <td class="tabledata">Job Grade</td>
                                                                
                                    <td><input name="grade" id="grade" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                    <td><span class="tabledata">Promotion</span></td>
                                    <td><input name="promotion" id="promotion" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                  </tr>
                                  <tr>
                                    <td>Job Purpose</td>
                                    <td><input name="purpose" id="purpose" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                    <td><span class="tabledata">Hazards</span></td>
                                    <td><input name="hazards" id="hazards" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                  </tr>
                                  <tr>
                                    <td class="tabledata">Duties</td>
                                    <td><input name="duties" id="duties" type="text" class="tabledata" value="" size="25" readonly/></td>
                                    <td><span class="tabledata">Reporting To</span></td>
                                    <td><input name="report" id="report" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                  </tr>
                                  <tr>
                                    <td height="19" class="tabledata">Authority</td>
                                    <td><input name="authority" id="authority" type="text" class="tabledata" value="" size="25" readonly/></td>
                                    <td>Responsibilities</td>
                                    <td><input name="response" id="response" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                  </tr>
                              </table></td>
                            </tr>
                          </table></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                 
                      </tr>
                  <tr>
                    <td height="169" colspan="2"><table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFF00">
                        <tr>
                          <td height="161"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td width="50%"><table width="98%" border="0" align="center" cellpadding="1" cellspacing="2" bordercolor="#D4D0C8" class="boldEleven">
                                <tr>
                                  <td colspan="4"><div align="center"><strong>Company Mission</strong></div></td>
                                  
                                </tr>
                                <tr>
                                  <td width="67">&nbsp;</td>
                                  <td width="215">&nbsp;</td>
                                </tr>
                                <tr>
                                <!-- 
                                hi 2
                                 -->
                                 <%
  				 					String sql1="SELECT * FROM hrm_m_mission";	
									String sval1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
  								  %>
                                  <td class="tabledata">Mission</td>
                                  <td><input name="mission" type="text" class="tabledata" value="<%=sval1[0][1] %>" size="25" readonly/></td>
                                </tr>
                                <tr>
                                  <td>Objectives</td>
                                  <td><input name="objectives" type="text" class="tabledata" value="<%=sval1[0][2] %>" size="25" readonly/></td>
                                </tr>
                                <tr>
                                  <td class="tabledata">Working Hours </td>
                                  <td><input name="workinghour" type="text" class="tabledata"  value="<%=sval1[0][3] %>" size="25" readonly/></td>
                                </tr>
                                <tr>
                                  <td class="tabledata">Holidays</td>
                                  <td><input name="holidays" type="text" class="tabledata"  value="<%=sval1[0][4] %>" size="25" readonly/></td>
                                </tr>
                                <tr>
                                  <td class="tabledata">Benefits</td>
                                  <td><input name="Benefits" type="text" class="tabledata"  value="<%=sval1[0][5] %>" size="25" readonly/></td>
                                </tr>
                              </table></td>
                              <td width="50%" height="155"><table width="101%" height="159" border="0" align="center" cellpadding="1" cellspacing="2" bordercolor="#D4D0C8" class="boldEleven">
                                <tr>
                                  <td height="30" colspan="4"><div align="center"><strong>ComPensation</strong></div></td>
                                </tr>
                                <tr>
                                  <td height="20" class="tabledata">&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                                <tr>
                                  <td width="44" height="20" class="tabledata">Scale</td>
                                  <td width="153"><input name="scale" id="scale" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                </tr>
                                <tr>
                                  <td height="19">D.A</td>
                                  <td><input name="DA" id="DA" type="text" class="tabledata" value="" size="25" readonly/></td>
                                </tr>
                                <tr>
                                  <td height="20" class="tabledata">H.R.A</td>
                                  <td><input name="HRA" id="HRA" type="text" class="tabledata"  value="" size="25" readonly/></td>
                                </tr>
                                <tr></tr>
                              </table></td>
                            </tr>
                          </table></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="2" colspan="2"></td>
                  </tr>
                  <tr>
                    <td height="34" colspan="2"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td width="56">
						  <input type="button" name="submit" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"/></td>
                        </tr>
                    </table></td>
                  </tr>
              </table></TD>
              <TD noWrap width=5><SPACER height="1" width="1" 
                        type="block" /></TD>
              <TD class=BorderLine width=2><SPACER height="1" width="1" type="block" /></TD>
            </TR>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
              <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
            </TR>
            <TR>
              <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
          </TBODY>
        </TABLE></td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
</body>
</form>
</html>