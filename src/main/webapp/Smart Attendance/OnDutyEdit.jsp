  <%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:directive.page import="com.my.org.erp.ServiceLogin.DateUtil" />
<%
try
{
%>
<html>
<head>
 
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
function Validate()
{
	try
	{
		if( 
			checkNull("fromdt","Enter Date") 
			&& checkNull("TxtPlace","Enter Place Name...") 
			&& checkNull("TxtReason","Enter Reason...") 
			&& checkNull("TxtAuthorised","Enter Authorised Name...") 
		
		)
			return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}		
}

 
  
   

 
 
 	 	
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 <%@ include file="index.jsp"%>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100">
		</td>
	</tr>
	<tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
	<td height="299">
	<table width="600" border="0" align="center" cellpadding="1"
		cellspacing="1">
		<tr>
			<td width="594" height="15">
			  
			</td>
		</tr>
		<tr>
			<td>
			
			<form action="../SmartLoginAuth" method="post"   name="frm" id="frm"  AUTOCOMPLETE = "off" onSubmit=" return Validate()">
			<table width="100" border="0" align="center" cellpadding="0"
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
						<td class="BorderLine" width="1"><spacer height="1" width="1"
							type="block" /></td>
						<td width="6"><spacer height="1" width="1" type="block"></td>
					  <td width="577" valign="top"><table width="500" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="100%"><div align="center" class="boldEleven"><strong>ONDUTY </strong></div></td>
                        </tr>
                        <tr>
                          <td><div align="right"><span class="article style3">
                              <%

String sql ="";
String rowid = request.getParameter("rowid");
sql = " SELECT a.INT_ONDUTYID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_ODDATE,'%d-%m-%Y'),a.CHR_TYPE,a.CHR_TYPE,a.CHR_PLACE, a.CHR_REASON, a.CHR_AUTHNAME FROM att_t_onduty a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID AND  a.INT_ONDUTYID="+rowid;
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

//INT_EXTRADAYSID,CHR_EMPID,DT_EXTRADATE,CHR_DAYTYPE,CHR_DESC,INT_VALUE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS
%>
                            * </span><span class="changePos">Mandatory</span></div></td>
                        </tr>
                        <tr>
                          <td><table width="95%" border="0" align="center" cellpadding="3" cellspacing="3">
                              <tr>
                                <td width="100" class="boldEleven">EMPID</td>
                                <td width="229" class="boldEleven"><%=readData[0][1]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Name</td>
                                <td class="boldEleven"><%=readData[0][2]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Date </td>
                                <td><span class="boldEleven">
                                  <input name="fromdt" type="text" class="formText135" 
												id="fromdt" readonly value="<%=readData[0][4]%>"
												size="15">
                                  <a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a></span>
                                    <script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frm'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			 
			 
			 		
		//-->
	                    </script>                                </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Day Type</td>
                                <td>
								
								<%
								 
								String c1=""; 
								String c2="";
								String c3="";
								
								if("Full Day".equals(readData[0][6]))
									c1 = " checked = 'checked' " ;
								if("Forenoon".equals(readData[0][6]))
									c2 = " checked = 'checked' " ;
								if("Afternoon".equals(readData[0][6]))
									c3 = " checked = 'checked' " ;
								%>
								<table width="232" border="0" cellspacing="1" cellpadding="1">
                                  <tr>
                                    <td width="20"><span class="bolddeepblue">
                                      <input
														name="ComboDay" type="radio" value="Full Day" <%=c1%> >
                                    </span></td>
                                    <td width="47" class="boldEleven">Full Day </td>
                                    <td width="20" class="boldEleven"><span
														class="bolddeepblue">
                                      <input name="ComboDay"
														type="radio" value="Forenoon"  <%=c2%> >
                                    </span></td>
                                    <td width="52" class="boldEleven">Forenoon</td>
                                    <td width="20" class="boldEleven"><span
														class="bolddeepblue">
                                      <input name="ComboDay"
														type="radio" value="Afternoon"  <%=c3%> >
                                    </span></td>
                                    <td width="54" class="boldEleven">Afternoon</td>
                                  </tr>
                                </table></td>
                              </tr>
                               
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">Place <font color='red'>*</font></td>
                                <td><input name="TxtPlace" type="text" class="formText135"
												id="TxtPlace" onKeyPress="charOnly('holiname','25')" value="<%=readData[0][7]%>"
												size="40" maxlength="25"></td>
                              </tr>
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">Reason <font color='red'>*</font></td>
                                <td><textarea name="TxtReason" cols="30" rows="5" class="formText135" id="TxtReason" onKeyUp="textArea('TxtReason','250')"> <%=readData[0][8]%></textarea>
                                </td>
                              </tr>
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">Authorised By <font color='red'>*</font></td>
                                <td><select name="TxtAuthorised" id="TxtAuthorised" class="formText135" size="5">
                                    <option value="">Select</option>
                                    <%
									//SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE INT_OFFICEID=  "+session.getAttribute("OFFICEID")+"  AND  CHR_HOLD!='Y'  AND CHR_TYPE!='T'  ORDER BY CHR_STAFFNAME
	String empdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff  WHERE   CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_REP='Y' ORDER BY CHR_STAFFNAME");
	for(int y=0; y<empdata.length;y++)
		out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
                                  
										%>
                                  </select><script language="javascript">setOptionValue('TxtAuthorised','<%=readData[0][9]%>')</script>
                                </td>
                              </tr>
                              
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven"> <font color="#FF0000">&nbsp;</font></td>
                                <td class="boldEleven"><span class="bolddeepblue">
                                  </span></td>
                              </tr>
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">&nbsp; </td>
                                <td class="boldEleven"><span class="bolddeepblue">
                                  </span></td>
                              </tr>
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">&nbsp; </td>
                                <td class="boldEleven">&nbsp;                                 </td>
                              </tr>
                              
                          </table></td>
                        </tr>
                        <tr>
                          <td></td>
                        </tr>
                        <tr>
                          <td></td>
                        </tr>
                        <tr>
                          <td height="28"><table border="0" align="center" cellpadding="1" cellspacing="1">
                              <tr>
                                <td width=56><input name="update" type="Submit"
											class="buttonbold" id="update"  
											value="Update">
                                <td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('OnDuty.jsp')"
											 value="Close"   accesskey="c" ></td>
                                <td> 
                                    <input name="rowid" type="hidden" id="rowid" value="<%=readData[0][0]%>">
                                     
                                     
                                                                         
                                                                        <input name="filename"
										type="hidden" id="filename" value="StaffOnDuty">
                                                                        <input
										name="actionS" type="hidden" id="actionS" value="ATTOnDutyUpdate"></td>
                              </tr>
                          </table></td>
                        </tr>
                      </table></td>
						<td nowrap="nowrap" width="6"><spacer height="1" width="1"
							type="block" /></td>
						<td width="1" class="BorderLine"><spacer height="1" width="1"
							type="block" /></td>
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
						<td class="BorderLine" height="1"></td>
					</tr>
				</tbody>
			</table>
			</form>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
 }
 catch(Exception es)
 {
 	//System.out.println(es.getMessage());
 }
 %>
 