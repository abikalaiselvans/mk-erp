<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

function changeState()
{
  var comboLate=document.getElementById("late").checked;
  if(comboLate==true)
  {
    document.getElementById("TxtDay").disabled=true;
    document.getElementById("TxtDay1").disabled=true;
    document.getElementById("TxtDay2").disabled=true;
    document.getElementById("ot").disabled=true;
  }
  else
  {
    document.getElementById("TxtDay").disabled=false;
    document.getElementById("TxtDay1").disabled=false;
    document.getElementById("TxtDay2").disabled=false;
    document.getElementById("ot").disabled=false;    
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
		
	
	
	
	
	if( (l) && checkNull("ename","Select Staff") )
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



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init(),assign()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
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
									<div align="center" class="boldEleven"><strong>   CONTINUOUS ATTENDANCE </strong><br>
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
									<div align="center"><%@ include
										file="../JavaScript/ajax.jsp"%></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="318" border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="119"><span class="boldEleven">Month <font color="#FF0000">*</font><span
												class="bolddeepblue"> 
											  <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %> </span></span></td>
											<td width="81"><span class="boldThirteen"> 
											  <select name="month" id="month" onChange="assign()">
												<%@ include file="../JavaScript/Inventory/month.jsp"%>
										  </select> </span></td>
										</tr>
										<tr>
											<td><span class="boldEleven">Year<font color="#FF0000"> *</font></span></td>
											<td><span class="boldThirteen"> <select name="year" id="year" onChange="assign()">
												<%@ include file="../JavaScript/Inventory/year.jsp"%>
												<%
                              Calendar c1=new GregorianCalendar(2005,1,6);
                              
                              out.println(c1.getMaximum(Calendar.DAY_OF_MONTH));
                              Calendar cal = new GregorianCalendar(1999, Calendar.FEBRUARY, 1);
                              java.util.Date d = new java.util.Date();
                               
                              
                              System.out.println(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                              %>
											</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                            </script> </span></td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td height="19" colspan="2">
									<div align="center"><font color="#FF0000">*</font><span class="boldElevenlink"> Sunday not mark </span></div>
									</td>
								</tr>
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="StafContinuousAttendance">
									<input name="actionS" type="hidden" id="actionS"
										value="ATTContinuousEntry"> <input name="value"
										type="hidden" id="value"></td>
									<td width="51%">
									<!--<a  href="javascript:UploadWindow('UploadAttendance.jsp')">Upload Excel file for attendance Register </a>--></span>
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
									 
									 </td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('ContinuousEntryView.jsp')" /></td>
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
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>