<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

 function Validate()
  {
  	var cm = document.getElementById('month').value;
	var cy = document.getElementById('year').value;
	
	var sm = document.getElementById('smonth').value;
	var sy = document.getElementById('syear').value;
	var datelock = document.getElementById('dtflag').value;
	var l = true;
	if(datelock == "Y")
	{
		
		if((cm == sm) && (cy==sy))
			l = true;
		else
		{
			alert("Sorry, Attendance does not mark previous month...");
			l= false;
			return false;
		}
		
			
	}
	else
		l= true;
		
	
	
	
	
	if( 
			(l) 
			&& checkNull("ename","Select Staff") 
			&& checkNullSelect("present","Select present",'Select') 
			&& checkNullSelect("onduty","Select onduty",'Select') 
			&& checkNullSelect("sunday","Select sunday",'Select') 
			&& checkNullSelect("holiday","Select holiday",'Select') 
			&& checkNullSelect("leave","Select leave",'Select') 
			&& checkNullSelect("absent","Select absent",'Select') 
			&& checkNullSelect("late","Select late",'Select') 
			&& checkNullSelect("permission","Select permission",'Select') 
			&& checkNullSelect("extradays","Select extradays",'Select') 
			&& checkNullSelect("attendancecycle","Select Attendance Cycle",'0') 
			
		)
			return true;
		else
			return false;
  }

  function assign()
  {
  	var m = document.getElementById('month').value;
	var y = document.getElementById('year').value;
	var m1=parseInt(m)-1;
	var y1= parseInt(y);
	document.getElementById('value').value=daysInMonth(m1, y1);
	
  }
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init(),assign()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
		<td width="100"></td>
		<td width="100"></td>
	</tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  
  </tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="591" border="0" align="center" cellpadding="0"
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
							<td width="577" valign="top">
							<table width="577" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center" class="boldEleven"> ATTENDANCE MANUAL INPUTS <br>
									</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color="#FF0000">* </font><span
										class="changePos">Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"><%@ include file="../JavaScript/ajax.jsp"%></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2"><table width="474" border="0" align="center" cellpadding="2"
										cellspacing="2" class="boldEleven">
										<tr>
											<td width="85" class="boldEleven">Month<span
												class="bolddeepblue"> 
										  <font color="#FF0000">*</font>
										  <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %> 
										  </span></td>
											<td width="143" class="boldEleven"><span class="boldThirteen"> 
											  <select name="month" id="month" onChange="assign()" style="width:100">
												<%@ include file="../JavaScript/Inventory/month.jsp"%>
										  </select> </span></td>
											<td width="143" class="boldEleven">Year<font color="#FF0000"> *</font></td>
											<td width="143" class="boldEleven"><span class="boldThirteen">
											  <select name="year" id="year" onChange="assign()" style="width:100">
											    <%@ include file="../JavaScript/Inventory/year.jsp"%>
											    <%
                              Calendar c1=new GregorianCalendar(2005,1,6);
                              out.println(c1.getMaximum(Calendar.DAY_OF_MONTH));
                              Calendar cal = new GregorianCalendar(1999, Calendar.FEBRUARY, 1);
                              java.util.Date d = new java.util.Date();
                              System.out.println(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                              %>
										    </select>
 <script language='JavaScript' type="text/javascript">
<!--			
		var d=new Date()
		var month1=d.getMonth() + 1
		if(month1<10) month1="0"+month1;
		var year1=d.getFullYear();
		setOptionValue('month',month1);
		setOptionValue('year',year1);							
//-->
 </script>
											</span></td>
							          </tr>
										 
										<tr>
										  <td class="boldEleven">Present<font color="#FF0000"> *</font></td>
										  <td class="boldEleven">
										  <select name="present" class="formText135" id="present" style="width:100">
										  	<option value="Select">Select Present</option>
										   <%
										   for(double j=0;j<31;j=j+0.5)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
										   </select>
										  </td>
										  <td class="boldEleven">Onduty<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="onduty" class="formText135" id="onduty" style="width:100">
										    <option value="Select">Select Onduty</option>
										    <%
										   for(double j=0;j<31;j=j+0.5)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
									      </select></td>
							          </tr>
										<tr>
										  <td class="boldEleven">Sunday<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="sunday" class="formText135" id="sunday" style="width:100">
                                            <option value="Select">Select Sunday</option>
                                            <%
										   for(int j=0;j<31;j=j+1)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
                                          </select></td>
										  <td class="boldEleven">Holiday<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="holiday" class="formText135" id="holiday" style="width:100">
										    <option value="Select">Select Holiday</option>
										    <%
										   for(double j=0;j<31;j=j+0.5)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
									      </select></td>
							          </tr>
										<tr>
										  <td class="boldEleven">Leave<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="leave" class="formText135" id="leave" style="width:100">
                                            <option value="Select">Select Leave</option>
                                            <%
										   for(double j=0;j<31;j=j+0.5)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
                                          </select></td>
										  <td class="boldEleven">Absent<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="absent" class="formText135" id="absent" style="width:100">
										    <option value="Select">Select Absent</option>
										    <%
										   for(double j=0;j<31;j=j+0.5)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
									      </select></td>
							          </tr>
										<tr>
										  <td class="boldEleven">Late<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="late" class="formText135" id="late" style="width:100">
                                            <option value="Select">Select Late</option>
                                            <%
										   for(int j=0;j<31;j=j+1)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
                                          </select></td>
										  <td class="boldEleven">Permission<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="permission" class="formText135" id="permission" style="width:100">
										    <option value="Select">Select Permission</option>
										    <%
										   for(int j=0;j<31;j=j+1)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
									      </select></td>
							          </tr>
										<tr>
										  <td class="boldEleven">Extra days<font color="#FF0000"> *</font></td>
										  <td class="boldEleven"><select name="extradays" class="formText135" id="extradays" style="width:100">
                                            <option value="Select">Select Extra Days</option>
                                            <%
										   for(double j=0;j<31;j=j+0.5)
										   		out.println("<option value='"+j+"'>"+j+" - Days </option>");
										   %>
                                          </select></td>
										  <td class="boldEleven">Attendance Cycle <span class="boldred">*</span></td>
										  <td class="boldEleven"><select name="attendancecycle" id="attendancecycle" class="formText135" style="width:100">
										    <option value="0"  selected="selected">Select Attendance Cycle</option>
										    <option value="1">1-31</option>
										    <option value="2">20th to 19th</option>
									      </select></td>
							          </tr>
										<tr>
										  <td class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
										  <td class="boldEleven">&nbsp;</td>
							          </tr>
									</table>
								  </td>
								</tr>

								<tr>
									<td height="19" colspan="2">
									<div align="center"></div>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="ManualInput">
									<input name="actionS" type="hidden" id="actionS"
										value="ATTManualInput"> 
									<input name="value"
										type="hidden" id="value"></td>
									<td width="51%">
									 		 
									 </td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56">
											<input type="submit" name="Submit" id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    onClick="return Validate()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('AttendanceMain.jsp')" /></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
							<td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
							<td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
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
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
		</table>
		</form>
		</td>
		 
		<td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		    <td><img src="../Image/report/msexcel-mysql1.jpg" width="60" height="60"></td>
		    <td><span class="bolddeepblue"><a   title="Clear Datas" href="javascript:UploadWindow('UploadAttendance.jsp')">Upload Attendance</a></span></td>
	      </tr>
		  <tr>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
	      </tr>
		   
	    </table></td>
	</tr>
	 
</table>
<script language="javascript">
	function UploadWindow(query)
	{  
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}
</script>


<%@ include file="../footer.jsp"%>