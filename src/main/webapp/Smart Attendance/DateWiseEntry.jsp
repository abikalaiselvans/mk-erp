 <%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%> 
  <%
String dojlock=  CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
 

<script>
  
  var dojlock= "<%=dojlock%>";
	 
	
	
	$(function() {
		var dates = $( "#fromdt, #todt" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			defaultDate: "+1w",
			minDate: "-35D", maxDate: "+5D",
			numberOfMonths: 1,
			 
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdt" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});
	
</script>
	
 
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript">

 
	
function Validate()
{
	try
	{
		 
		if(
			 checkNull("ename","Select Staff") 
			&& checkNull("fromdt","Enter From Date") 
			&& checkNull("todt","Enter To Date") 
			&& DateCompares ('fromdt','todt', 'Fromdate shoul not be greaterthan the  To Date')
			&& checkDateSelection()
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


function checkDateSelection()
{
	try
	{
		var d1 = document.getElementById('fromdt').value;
		var d2 = document.getElementById('todt').value;
		var dd1 = d1.split("-");
		var dd2 = d2.split("-");
		var fm = dd1[1];
		var fy = dd1[2];
		var tm = dd2[1];
		var ty = dd2[2];
		
		var sm = document.getElementById('smonth').value;
		var sy = document.getElementById('syear').value;
		var datelock = document.getElementById('dtflag').value;

		if(datelock == "Y")
		{
		
			if((fm == sm) && (fy==sy))
				return true;
			else
			{
				alert("Sorry, Attendance does not mark previous month...");
				return false;
			}
		}
		else
		{
			if((fm == tm) && (fy==ty)) 
				return true;
			else
			{
				alert("Sorry, from date & to date should be in same Month & Year");
				return false;
			}
		}
		
		
	 
	 	
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}


 </script>

<title> :: ATTENDANCE ::</title>


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
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" 	action="../SmartLoginAuth" onSubmit="return Validate()">
		<table width="598" border="0" align="center" cellpadding="1" 	cellspacing="1">
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
									<div align="center" class="boldEleven"><strong>DATE WISECONTINUOUS PRESENT ENTRY  </strong> </div>
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
									<table width="397" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="77" valign="middle"  
												class="boldEleven">From<span class="bolddeepblue">
											<%
							  	
							String logintype[][]= CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] =  CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %> </span></td>
											<td width="313" class="boldEleven"><input name="fromdt" type="text" class="formText135" id="fromdt" readonly value="" size="15" > 
											 <span class="boldEleven">( dd-mm-yyyy ) </span>
											 <script language="javascript">setCurrentDate('fromdt')</script>
											 </td>
										</tr>
										<tr>
											<td align="left" valign="middle"  
												class="boldEleven">To</td>
											<td class="boldEleven"><input name="todt" type="text" class="formText135" id="todt" readonly  value="" size="15"> 
											   <span class="boldEleven">( dd-mm-yyyy ) </span>
											   <script language="javascript">setCurrentDate('todt')</script>
											   </td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td height="19" colspan="2">
									 
									</td>
								</tr>
								<tr>
									<td width="49%" height="19"> <input name="filename"
										type="hidden" id="filename" value="StaffPresent">
                                      <input
										name="actionS" type="hidden" id="actionS" value="ATTStaffPresentAdd"></td>
									<td width="51%">&nbsp;</td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit" id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('Manual Attendance.jsp')" /></td>
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
							<td height="6"> </td>
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