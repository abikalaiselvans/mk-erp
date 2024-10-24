<%@ page import="java.sql.*,java.io.*,java.util.*"%>
  <%@ page import="com.my.org.erp.common.CommonFunctions"%>
 <%
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	var dojlock= "<%=dojlock%>";
	
	$(function() {
		$( "#fromdt" ).datepicker({ 
		changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
		minDate: "-45D", maxDate: "+0D" 
		});
	});
	
	 
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="javascript" src="../JavaScript/JTime/jquery.timePicker.js"></script>
<link href="../JavaScript/JTime/timePicker.css" rel="stylesheet" type="text/css">



<script language="JavaScript">

function changeState()
{
  var comboLate=document.getElementById("late").checked;
  if(comboLate==true)
  {
    document.getElementById("TxtDay").disabled=true;
    document.getElementById("TxtDay1").disabled=true;
    document.getElementById("TxtDay2").disabled=true;
    document.getElementById("out").disabled=true;
  }
  else
  {
    document.getElementById("TxtDay").disabled=false;
    document.getElementById("TxtDay1").disabled=false;
    document.getElementById("TxtDay2").disabled=false;
    document.getElementById("out").disabled=false;    
  }  
}

function morningTimeOnly()
{
      alert("In morning time");
      if(checkNull("fromdt","Enter From Date"))
      return true;
      else
      return false;
}

//week day 


function Validated()
{
	if( Validate())
		return true;
	else
		return false;
}
	
	
	
function Validate()
{
	try
	{
  		var d1 = document.getElementById('fromdt').value;
		var dd1 = d1.split("-");
		var ds = compute(dd1[0],dd1[1],dd1[2]) ;
		if(ds=="Sunday")
		{
			alert("You are selecting Sunday");
			return false;
		}
		
		var cm = dd1[1];
		var cy = dd1[2];
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
		
		var vlate=document.getElementById('late').checked;  	
 		var optType=document.getElementById('TxtDay').checked;
 		var optType1=document.getElementById('TxtDay1').checked;
 		var optType2=document.getElementById('TxtDay2').checked;
  	
		if(vlate==true) 
  		{
	  		if( 
				(l) 
				&& checkNull("ename","Select Staff") 
				&& checkNull("int","Enter In Time")
			   )
				return true;
			else
				return false;
		} 
		else if(optType==true)
		{
			if(
				checkNull("ename","Select Staff") 
				&& checkNull("fromdt","Enter From Date") 
				&& checkNull("int","Enter In Time")
				&& checkTime('int','out')
				)
				return true;
			else
				return false;
		} 
		else if(optType1==true)
		{
	
			if(	checkNull("ename","Select Staff") 
				&& checkNull("fromdt","Enter From Date") 
				&& checkNull("int","Enter In Time")
			 )
				return true;
			else
				return false;
		}
		else if(optType1==true || optType2==true)
		{	
			if(checkNull("ename","Select Staff") 
				&& checkNull("fromdt","Enter From Date") 
				&& checkNull("int","Enter In Time")
		 	)
				return true;
			else
				return false;
		}	
	}
	catch(err)
	{
		alert(err);
		return false
	}
  }
  
  
   
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

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td  ><%@ include file="index.jsp"%><br>
		<br>
		</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="StaffManualAttendanceEditfrm" method="post" action="../SmartLoginAuth" onSubmit="return Validated()">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td width="72%"><table width="591" border="0" align="center" cellpadding="0"
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
		              <td colspan="2"><div align="center" class="boldEleven"><strong> Attendance Information</strong></div></td>
		              </tr>
		            <tr>
		              <td colspan="2"><div align="right"><font color="#FF0000">* </font><span
										class="changePos">Mandatory</span></div></td>
		              </tr>
		            <tr>
		              <td colspan="2"><div align="center">
		                <%@ include
										file="../JavaScript/ajax.jsp"%>
		                </div></td>
		              </tr>
		            <tr>
		              <td colspan="2"></td>
		              </tr>
		            <tr>
		              <td height="19" colspan="2"><table width="468" border="0" align="center" cellpadding="1"
										cellspacing="1">
		                <tr>
		                  <td width="77" valign="middle"  
												class="boldEleven">From<span class="bolddeepblue">
		                    <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %>
		                    </span></td>
		                  <td width="313" class="boldEleven"><input name="fromdt"
												type="text" class="formText135" id="fromdt"
												onKeyPress="numericHypenOnly('fromdt','9')" readonly value=""
												size="15"  >
		                    <script
												language='JavaScript'>
		<!--
			 
			setCurrentDate('fromdt');
			 	
			
		//-->
	          </script>
		                    ( dd-mm-yyyy ) </td>
		                  </tr>
		                <tr>
		                  <td align="left" valign="middle"  
												class="boldEleven">Day <font color=#FF0000>*</font></td>
		                  <td class="boldEleven"><table width="99%" border="0" cellspacing="1" cellpadding="1">
		                    <tr>
		                      <td width="24" class="boldEleven"><span
														class="bolddeepblue">
		                        <input type="checkbox"
														id="late" name="ChkLate" value="L" onClick="changeState()">
		                        </span></td>
		                      <td width="84" class="boldEleven">Late</td>
		                      <td width="20" class="boldEleven"><span
														class="bolddeepblue">
		                        <input name="ComboDay"
														id="TxtDay" type="radio" value="P" checked>
		                        </span></td>
		                      <td width="55" class="boldEleven">Full Day</td>
		                      <td width="20" class="boldEleven"><span
														class="bolddeepblue">
		                        <input name="ComboDay"
														type="radio" id="TxtDay1" value="F">
		                        </span></td>
		                      <td width="59" class="boldEleven">Forenoon</td>
		                      <td width="20" class="boldEleven"><span
														class="bolddeepblue">
		                        <input name="ComboDay"
														type="radio" id="TxtDay2" value="A">
		                        </span></td>
		                      <td width="61" class="boldEleven">Afternoon</td>
		                      </tr>
		                    </table></td>
		                  </tr>
		                <tr>
		                  <td align="left" valign="middle"  
												class="boldEleven">In Time <font color="#FF0000">*</font></td>
		                  <td class="boldEleven"><input name="int" type="text" class="formText135" id="int"
												  value="09:00:00" size="12" maxlength="8">
		                    (HH:MM:SS)</td>
		                  </tr>
		                <tr>
		                  <td align="left" valign="middle"  
												class="boldEleven">Out Time <font color="#FF0000">*</font></td>
		                  <td class="boldEleven"><input name="out" type="text" class="formText135" id="out"
												  value="18:30:00" size="12" maxlength="8">
		                    (HH:MM:SS)
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
		document.getElementById('out').value="18:30:00";
		alert("To Time should be greater than the From Time");
  	}
  	else 
  	{
    	$(this).removeClass("error");
  	}
}); 
  </script>
		                    </font></strong></span></td>
		                  </tr>
		                <tr>
		                  <td align="left" valign="middle"  
												class="bolddeepblue">&nbsp;</td>
		                  <td>&nbsp;</td>
		                  </tr>
		                </table></td>
		              </tr>
		            <tr>
		              <td height="19" colspan="2"><div align="center">
		                <%
					  		
							String er=(""+request.getParameter("er")).trim();
							if(! er.equals("null"))
							{
								
								String val[] = er.split("~");
								out.println("<div id='onduty' style='OVERFLOW:auto;width:500px;height:100px' >");
								out.println("<center><table>");
								out.println("<tr class='MRow1'>");
								out.println("<td colspan=3 class='bolddeepred'>Already Entered the following...");
								out.println("<tr class='MRow1'>");
								out.println("<td width='250' class ='boldEleven' ><b>Staffid</b><td width='250' class ='boldEleven' ><b>Date</b><td width='250' class ='boldEleven' ><b>Description</b>");
								for(int u=0; u<val.length; u++)
								{
									
									if(u%2==1)
										out.println("<tr class='MRow1'>");
									else
										out.println("<tr  class='MRow2'>");	
									String values[] = val[u].split(",");
									out.println("<td width='250' class ='boldEleven' >"+values[1]);
									out.println("<td width='250' class ='boldEleven' >"+values[0]);
									out.println("<td width='250' class ='boldEleven' >"+values[2]);
									
								}
								out.println("</center></table></div>");
							}	
					  %>
		                </div></td>
		              </tr>
		            <tr>
		              <td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="StaffManualAttendance">
		                <input name="actionS" type="hidden" id="actionS"
										value="ATTStaffManualAttendanceAdd"></td>
		              <td width="51%">&nbsp;</td>
		              </tr>
		            <tr>
		              <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
		                <tr>
		                  <td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"     /></td>
		                  <td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('Manual Attendance.jsp')" /></td>
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
		    <td width="28%"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		      <tr>
		        <td colspan="2" align="center" class="bold1">UPLOAD LATE ENTRY</td>
		        </tr>
		      <tr>
		        <td width="24%"><img src="../Image/report/msexcel-mysql1.jpg" width="60" height="60"></td>
		        <td width="76%"><a href="javascript:UploadWindow('UploadLateAttendance.jsp')"   title="Clear Datas" ><font class="boldEleven"> Upload Late Entry</font></a></td>
		        </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><a href="../Testing Upload/Late_Entry.xls" target="_blank" ><font class="boldEleven"> Sample</font></a></td>
		        </tr>
	        </table></td>
	      </tr>
		  </table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>