<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
String dojlock=CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM m_institution WHERE INT_ID=1 ")[0][0];
String dtpermission=CommonFunctions.QueryExecute(" SELECT INT_DTLOCKPERMISSION FROM att_m_basicsettings WHERE INT_ID=1 ")[0][0];
String dtleave=CommonFunctions.QueryExecute(" SELECT INT_DTLOCKLEAVE FROM att_m_basicsettings WHERE INT_ID=1 ")[0][0];
String leaveexceedflag=CommonFunctions.QueryExecute(" SELECT CHR_LEAVEEXCEED FROM att_m_basicsettings WHERE INT_ID=1 ")[0][0];
String lempid=CommonFunctions.QueryExecute(" SELECT FIND_A_EMPLOYEE_ID_NAME('"+session.getAttribute("EMPID")+"') ")[0][0];
%>
<%@include file="Redirect.jsp" %>

<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	var dojlock= "<%=dojlock%>";
	$(function() {
		$( "#Pfromdt" ).datepicker({ 
		
			changeMonth: true,changeYear: true,
			maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
		minDate: -7, maxDate: <%=dtpermission%> });
	});
	
	
	$(function() {
		$( "#Lfromdate" ).datepicker({
		
			changeMonth: true,changeYear: true,
			maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
		minDate: -7, maxDate: <%=dtleave%> });
	});
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="javascript" src="../JavaScript/JTime/jquery.timePicker.js"></script>
<link href="../JavaScript/JTime/timePicker.css" rel="stylesheet" type="text/css">


<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
<!--

<%
 if("A".equals(leaveexceedflag))
 	leaveexceedflag = "Hi, "+lempid+" ,your entry going to ABSENT due to unavailable leave balance" ;
 else
	leaveexceedflag = "Hi, "+lempid+" ,your entry going to NEGATIVE leave due to unavailable leave balance" ;	
%>
 function checkleavecredit()
 {
 	var e = parseFloat(document.getElementById('EValue').value);
	var t = parseFloat(document.getElementById('AValue').value);
	var v = parseFloat(document.getElementById('leavevalue').value);
	var b= e-t;
	if(b>=v)
		return true;
	else
	{
		var rs=confirm("<%=leaveexceedflag%>");
		if (rs==true)
  		 	return true;
		else
			return false;
	}
	
 }

function validateFields()
{

 try
	{
		var f1 = document.onlineleavefrm.ApplyLeave1.checked;
		var f2 = document.onlineleavefrm.ApplyLeave2.checked;
		if(f1 == true || f2 ==true)
		{
			if(f2 == true)
				{
					if(checkNullSelect("LeaveType","Select LeaveType...","select") 
					&& checkNull("lreason","Enter Leave Reason.. ") 
					&& checkNull("Lfromdate","Enter From Date...") 
					&& checkleavecredit()
					)
						return true;
					else	
						return false;
				}
				else
				if(f1 == true)
				{
					if(  checkNull("Pfromdt","Enter the permission date")
					&& checkNull("int","Enter In Time") 
					&& checkNull("out","Enter Out Time")
					 && checkPermissionTime('int','out','2')
					  && checkNull("preason","Enter permission Reason")
					)
						return true;
					else	
						return false;
				}
				else
					return false;
		}
		else
		{
		 	alert("Select any one Permission / Leave ")		;
		 	return false;
		}
	}
	catch(err)
	{
		alert(err)
		return false;
	} 
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->



</script>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
			
			
try
{
			String userid = ""+session.getAttribute("USRID");
			String sql ="";
			sql = "SELECT * FROM M_USER WHERE CHR_USRNAME = '"+userid+"'";
			String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,a.CHR_EMPID,a.CHR_TYPE FROM m_user a, com_m_staff b WHERE a.CHR_EMPID=b.CHR_EMPID  AND  a.CHR_USRNAME='"+userid+"'");
			String staff  =Data[0][1];
			String ptype = Data[0][2];
			String staffname= Data[0][0];
			 
			
%>
 
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="onlineleavefrm" onSubmit="return validateFields()">
<table width="858" border="0" align="center" cellpadding="1"
	cellspacing="1">
	<tr>
		<td width="753" height="20">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="810" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
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
					<td valign="top">
					<table width="801" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="100%">
							<div align="center" class="boldEleven"><strong>LEAVE / PERMISSION </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="article style3"> * </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="602" border="0" align="center" cellpadding="1"
								cellspacing="1">
								 
								<tr>
								  <td colspan="3" class="boldEleven"><table width="395" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                      <td class="bold1">Emp Id </td>
                                      <td><strong><strong><%=staff%>
                                            <input
										name="staffid" type="hidden" id="staffid" value="<%=staff%>">
                                      </strong></strong></td>
                                      <td class="bold1">Name</td>
                                      <td><strong><strong><%=staffname%></strong></strong></td>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
								  <td colspan="3" class="boldEleven"><table width="184" border="0" align="center" cellpadding="0"
										cellspacing="0">
                                    <tr class="boldEleven">
                                      <td width="20"><input name="ApplyLeave" type="radio" class="formText135"
												id="ApplyLeave1" value="P"></td>
                                      <td width="61" class="boldEleven">Permission</td>
                                      <td width="20" class="boldEleven"><input name="ApplyLeave" type="radio" class="formText135"
												id="ApplyLeave2" value="L"></td>
                                      <td width="33" class="boldEleven">Leave</td>
                                      <td width="50"><input name="filename" type="hidden"
												id="filename" value="StaffPermission">
                                          <input
												name="actionS" type="hidden" id="actionS"
												value="STAStaffuserPermissionleave"></td>
                                    </tr>
                                  </table></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="19" class="boldEleven">
							<table width="800" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="24">&nbsp;</td>
									<td width="364">
									<fieldset><legend class="boldEleven">&nbsp;&nbsp;&nbsp;<strong>Permission</strong>&nbsp;&nbsp;&nbsp;</legend>
									<table width="318" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="70" valign="middle" class="boldEleven"  
												>Date</td>
											<td width="241" class="boldEleven"><input name="Pfromdt" type="text"
												class="formText135" id="Pfromdt"
												 readonly="readonly" value="" size="15" /> 
										  <script
												language='JavaScript' type="text/javascript">
		<!--
			 
			setCurrentDate('Pfromdt');
			 	
			
		//-->
	                        </script></td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">
											<p class="style8"><span >Day</span></p>
										  </td>
											<td class="boldEleven">
											<table width="146" border="0" cellspacing="0" cellpadding="0">
												<tr>
													 
													<td width="21" class="boldEleven"><span
														> <input name="PComboDay"
														type="radio" id="TxtDay1" value="PFN" checked /> 
													</span></td>
													<td width="52" class="boldEleven"><span
														>Forenoon</span></td>
													<td width="21" class="boldEleven"><span
														> <input name="PComboDay"
														type="radio" id="radio" value="PAN" /> </span></td>
													<td width="67" class="boldEleven"><span
														>Afternoon</span></td>
												</tr>
											</table>
										  </td>
										</tr>
										<tr>
											<td align="left" valign="middle" class="boldEleven"  
												>From Time</td>
											<td class="boldEleven"><span > 
											  <input name="int"
												type="text" class="formText135" id="int" value="09:00:00" size="15"
												 readonly="readonly"  /> 
										  </span></td>
										</tr>
										<tr>
											<td align="left" valign="middle" class="boldEleven"  
												>To Time</td>
										  <td class="boldEleven"><span > 
										    <input name="out"
												type="text" class="formText135" id="out" value="11:00:00" size="15"
												 readonly="readonly" /> 
											</span>
											  <script language="javascript">$("#int, #out").timePicker();
    
 var oldTime = $.timePicker("#int").getTime();

 $("#int").change(function() {
  if ($("#out").val()) { // Only update when second input has a value.
     var duration = ($.timePicker("#out").getTime() - oldTime);
    var time = $.timePicker("#int").getTime();
     $.timePicker("#out").setTime(new Date(new Date(time.getTime() + duration)));
    oldTime = time;
  }
});
 
 $("#out").change(function() 
 {
  	if($.timePicker("#int").getTime() > $.timePicker(this).getTime()) 
	{
    	$(this).addClass("error");
		document.getElementById('out').value="";
		alert("To Time should be greater than the From Time");
  	}
  	else 
  	{
    	$(this).removeClass("error");
  	}
}); 
</script>
											  <span > (</span><span class="boldElevenlink"> * only 1.5-hours</span><span >) </span>
                                              <script language="javascript">
 $("#int, #out").timePicker();
    
 var oldTime = $.timePicker("#int").getTime();

 $("#int").change(function() {
  if ($("#out").val()) { // Only update when second input has a value.
     var duration = ($.timePicker("#out").getTime() - oldTime);
    var time = $.timePicker("#int").getTime();
     $.timePicker("#out").setTime(new Date(new Date(time.getTime() + duration)));
    oldTime = time;
  }
});
 
 $("#out").change(function() 
 {
  	if($.timePicker("#int").getTime() > $.timePicker(this).getTime()) 
	{
    	$(this).addClass("error");
		document.getElementById('out').value="";
		alert("To Time should be greater than the From Time");
  	}
  	else 
  	{
    	$(this).removeClass("error");
  	}
}); 
                                              </script></td>
										</tr>
										<tr>
											<td align="left" valign="top" class="boldEleven"  
												>Reason</td>
											<td valign="top" class="boldEleven"><textarea  name="preason" cols="45" onKeyUp="textArea('preason','500')"
												rows="5" class="formText135" id="preason"></textarea></td>
										</tr>
									</table>
									</fieldset>
									</td>
									<td width="28">&nbsp;</td>
									<td width="360">
									<fieldset class="bolddeepred"><legend
										class="boldEleven">&nbsp;&nbsp;&nbsp;<strong>
									Leave</strong>&nbsp;&nbsp;&nbsp;</legend>
									<table width="342" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="94"   class="boldEleven">Leave
											Name 
											</td>
											<td width="241"   class="boldEleven"><select
												name="LeaveType" class="formText135" id="LeaveType"
												onChange="makeGetRequest(this)" style="width:150">
												<option value="select">select</option>
												<%
												String readData[][] =  CommonFunctions.QueryExecute("SELECT CHR_SYMBOL,CHR_LEAVENAME  FROM att_m_leavetype  ORDER BY CHR_LEAVENAME");
								  	for(int u=0; u<readData.length; u++)
										out.println("<option value='"+readData[u][0]+"'>" +readData[u][1] +"</option>");
									
								  %>	</select>
											<div id="description"></div>
											</td>
										</tr>
										<tr>
											<td   class="boldEleven">Date</td>
											<td   class="boldEleven"><input
												name="Lfromdate" type="text" class="formText135"
												id="Lfromdate" size="15" maxlength="10"
												readonly="readonly"  />  <script
												language='JavaScript' type="text/javascript">
		<!--
			 
			setCurrentDate('Lfromdate');
		//-->
	                        </script></td>
										</tr>
										 
										<tr>
											<td   class="boldEleven">Day</td>
											<td   class="boldEleven">
											<table width="93%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="9%" class="boldEleven"><input
														name="LComboDay" type="radio" id="LComboDay" value="Full Day" checked onClick="fullclick()" /></td>
													<td width="24%" class="boldEleven">Full Day</td>
													<td width="9%" class="boldEleven"><input
														name="LComboDay" type="radio" id="LComboDay" value="Forenoon"  onClick="forenoonclick()" /></td>
													<td width="24%" class="boldEleven">Forenoon</td>
													<td width="9%" class="boldEleven"><input
														name="LComboDay" type="radio" id="LComboDay"
														value="Afternoon"  onClick="afternoonclick()" /></td>
													<td width="25%" class="boldEleven">Afternoon
													<script language="javascript">
													function fullclick()
													{
														document.getElementById('leavevalue').value="1.0";
													}
													
													function forenoonclick()
													{
														document.getElementById('leavevalue').value="0.5";
													}
													function afternoonclick()
													{
														document.getElementById('leavevalue').value="0.5";
													}
													</script>
												    <input name="leavevalue" type="hidden" id="leavevalue" value="1.0"></td>
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td valign="top"   class="boldEleven"><span
												>Reason</span></td>
											<td valign="top"   class="boldEleven"><textarea
												name="lreason"  onKeyUp="textArea('lreason','100')" cols="45" rows="5" class="formText135"
												id="lreason"></textarea></td>
										</tr>
									</table>
									</fieldset>
									</td>
									<td width="24">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="2"></td>
						</tr>
						<tr>
							<td height="38">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Apply"></td>
									<td width="56"><input name="Submit3" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('ifStaffLeaveStatus.jsp')"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
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
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
</table>
</form>
 


<script language="JavaScript">


function createRequestObject() 
{
    var tmpXmlHttpObject;
    if (window.XMLHttpRequest) 
    { 
        tmpXmlHttpObject = new XMLHttpRequest();
	  }
    else if (window.ActiveXObject) 
    { 
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return tmpXmlHttpObject;
}


var http = createRequestObject();
function makeGetRequest(wordId) 
{
	var f ='LeaveInsert.jsp?id=' + wordId.value;
	f = f+"&staffid=<%=staff%>" 
	 http.open('get', f);
    http.onreadystatechange = processResponse;
    http.send(null);
}

function processResponse() 
{
    if(http.readyState == 4){
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;
    }
}


</script>

<%
}
catch(Exception  er)
{
}

%>
