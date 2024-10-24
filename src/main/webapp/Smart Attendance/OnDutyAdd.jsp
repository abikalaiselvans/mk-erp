<%@ page import="java.sql.*,java.io.*,java.util.*"%>
  <%
String dojlock=com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
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
			 minDate: "-50D", maxDate: "+0D" 
			 });
	});
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">





<script language="JavaScript">
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
			
		if( 	(l) 
				&& checkNull("ename","Select Staff...") 
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
	</tr>
	<tr>
		<td width="100" height="29">&nbsp;</td>
	</tr>
	<tr>
		<td height="371">
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
									<div align="center" class="boldEleven"><strong>ONDUTY</strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color='red'>* </font><span
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
									<table width="362" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="92" valign="middle"  
												class="boldEleven">From <font color='red'>* <span
												class="bolddeepblue"> <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %> </span> </font></td>
											<td width="263" class="boldEleven"><input
												title="dd/mm/yyyy" readonly
												onKeyPress="numericHypenOnly('fromdt','9')" name="fromdt"
												type="text" class="formText135" id="fromdt" value=""
												size="15"> 
											<!--<a href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>--> <script
												language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frm'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			setCurrentDate('fromdt');  	
			
		//-->
	</script> ( dd-mm-yyyy )</td>
										</tr>
										 
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">Day <font color='red'>*</font></td>
											<td>
											<table width="232" border="0" cellspacing="1" cellpadding="1">
												<tr>
													<td width="20"><span class="bolddeepblue"> <input
														name="ComboDay" type="radio" value="Full Day" checked>
													</span></td>
													<td width="47" class="boldEleven"><span
														class="boldEleven">Full Day </span></td>
													<td width="20" class="boldEleven"><span
														class="bolddeepblue"> <input name="ComboDay"
														type="radio" value="Forenoon"> </span></td>
													<td width="52" class="boldEleven"><span
														class="boldEleven">Forenoon</span></td>
													<td width="20" class="boldEleven"><span
														class="bolddeepblue"> <input name="ComboDay"
														type="radio" value="Afternoon"> </span></td>
													<td width="54" class="boldEleven"><span
														class="boldEleven">Afternoon</span></td>
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">Place <font color='red'>*</font></td>
											<td><input name="TxtPlace" type="text" class="formText135"
												id="TxtPlace" 
												size="40" maxlength="25"></td>
										</tr>
										<tr>
											<td align="left" valign="top"  
												class="boldEleven">Reason <font color='red'>*</font></td>
											<td> 
												<textarea name="TxtReason" cols="30" rows="5" class="formText135" id="TxtReason" onKeyUp="textArea('TxtReason','250')"></textarea>
										  </td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">Authorised By <font color='red'>*</font></td>
										  <td> 
												
										<select name="TxtAuthorised" id="TxtAuthorised" class="formText135" size="5">
										<option value="">Select</option>
										<%
										//SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE INT_OFFICEID=  "+session.getAttribute("OFFICEID")+"  AND  CHR_HOLD!='Y'  AND CHR_TYPE!='T'  ORDER BY CHR_STAFFNAME
	String empdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff  WHERE   CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_REP='Y' ORDER BY CHR_STAFFNAME");
	for(int y=0; y<empdata.length;y++)
		out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
										%>
										</select></td>
										</tr>
									</table>
									</td>
								</tr>

								 
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="StaffOnDuty"> <input
										name="actionS" type="hidden" id="actionS" value="ATTOnDutyAdd"></td>
									<td width="51%">&nbsp;</td>
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
												onClick="redirect('OnDuty.jsp')" /></td>
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
		<td></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>