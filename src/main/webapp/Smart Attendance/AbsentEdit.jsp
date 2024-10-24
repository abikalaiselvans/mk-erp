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
  	if( 
		checkNull("fromdt","Enter the Date...")  ) 
	
		return true;
	else
		return false;
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
                          <td width="100%"><div align="center" class="boldEleven"><strong>ABSENT ATTENDANCE </strong></div></td>
                        </tr>
                        <tr>
                          <td><div align="right"><span class="article style3">
                              <%

String sql ="";
String rowid = request.getParameter("rowid");
sql = " SELECT a.INT_ABSENTID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_ABSENTDATE,'%d-%m-%Y'),a.CHR_TYPE,a.CHR_DAYTYPE FROM att_t_absent a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_ABSENTID="+rowid;
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

//INT_EXTRADAYSID,CHR_EMPID,DT_EXTRADATE,CHR_DAYTYPE,CHR_DESC,INT_VALUE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS
%>
                            * </span><span class="changePos">Mandatory</span></div></td>
                        </tr>
                        <tr>
                          <td><table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
                              <tr>
                                <td width="173" class="boldEleven">EMPID</td>
                                <td width="227" class="boldEleven"><%=readData[0][1]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Name</td>
                                <td class="boldEleven"><%=readData[0][2]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Date<font color='red'>*</font></td>
                                <td class="boldEleven"><span class="boldEleven">
                                  <input name="fromdt" type="text" class="formText135" 
												id="fromdt" onKeyPress="dateOnly('fromdt')" value="<%=readData[0][4]%>"
												size="15" readonly="readonly">
                                  <a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a></span>
                                <script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frm'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			 
			setCurrentDate('fromdt');
			 		
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
								
								<table width="259" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td class="boldEleven"><input name="ComboDay"
							id="ComboDay" type="radio" value="Full Day" <%=c1%> ></td>
                                              <td class="boldEleven">Full
						Day</td>
                                              <td class="boldEleven"><input name="ComboDay" type="radio" id="ComboDay"
							value="Forenoon" <%=c2%> ></td>
                                              <td class="boldEleven">Forenoon</td>
                                              <td class="boldEleven"><input name="ComboDay"
							type="radio" id="ComboDay" value="Afternoon"  <%=c3%> ></td>
                                              <td class="boldEleven">Afternoon</td>
                                            </tr>
                                  </table>
										  
										  
								 
                                </td>
                              </tr>
                               
                              <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
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
											class="buttonbold" id="update" onClick="return Edit()"
											value="Update">
                                <td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('Absent View.jsp')"
											 value="Close"   accesskey="c" ></td>
                                <td> 
                                    <input name="rowid" type="hidden" id="rowid" value="<%=readData[0][0]%>">
                                     
                                    <input name="filename" type="hidden"
			id="filename" value="StaffAbsent">
                                    <input name="actionS"
			type="hidden" id="actionS" value="ATTAbsensUpdate">                                    </td>
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
 