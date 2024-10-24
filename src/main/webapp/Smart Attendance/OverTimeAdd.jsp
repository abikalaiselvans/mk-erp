<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%> 
 <%
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>

<%String actionStu="ATTovertimeAdd"; %>
<html>
<head>

<title> :: ATTENDANCE ::</title>


<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	 var dojlock= "<%=dojlock%>";
	$(function() {
		$( "#fromdt" ).datepicker({ minDate: -dojlock, maxDate: "+8D" });
	});
	
	$(function() {
		$( "#todt" ).datepicker({ minDate: -dojlock, maxDate: "+8D" });
	});
	
	
	 
	
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript">  

function Validate()
{
	try
	{
		if(  checkNull("ename","Select Staff") 
		     && checkNull("fromdt","Enter From Date") 
			 && checkNull("todt","Enter To Date") 
             && checkNull("overtime","Enter The Over Time ")
			 && checkNull("batta","Enter The batta ")
			 && checkNull("washing","Enter The washing ")
			 && checkNull("Txtdes","Enter The Txtdes ")
			 && checkDate("fromdt","todt")
		)
			return true;
		else
			return false;
    }
	catch(err)
	{
		alert(err)
		return false;
	}
  
}	  
  
  
  

</script>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<form  AUTOCOMPLETE = "off"   method="get" name='frmState' action="../SmartLoginAuth" onSubmit="return Validate()">
<%@ include
	file="index.jsp"%> <br>
<br>
<table align="center">
	<tr>
		<td height="297">
		<div align="center"><br>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="469" border="0" align="center">
						<!--DWLayoutTable-->
						<tr>
							<td width="463" height="136">
							<table width="100%" border="0" cellpadding="0" cellspacing="0"
								 >
								<!--DWLayoutTable-->
								<tr>
									<td width="466" height="34" valign="top" class="bolddeepblue">
									<%@ include file="../JavaScript/ajax.jsp"%>
									</td>
								</tr>
							</table>
							<table width="463" border="0" cellpadding="2" cellspacing="2"
								  class="bolddeepblue">
								<!--DWLayoutTable-->
								<tr align="center">
									<td height="25" colspan="2" valign="top" class="BackGround"
										 >Over Time</td>
								</tr>
								<tr>
									<td width="201" height="30" valign="middle"
										class="bolddeepblue">From</td>
								  <td width="293"><input name="fromdt" type="text"
										class="formText135" id="fromdt"  
										value="" size="15" readonly="readonly">  </td>
								</tr>
								<tr>
									<td height="30" align="left" valign="middle"
										class="bolddeepblue">To</td>
									<td align="left" valign="middle"><input name="todt"
										type="text" class="formText135" id="todt"
										 readonly="readonly"  value="" size="15"> </td>
								</tr>
								<tr>
									<td height="29" align="left" valign="middle" class="boldEleven">Over
									Time <font color="#CC0000">*</font></td>
									<td align="left" valign="middle" class="boldEleven"><input name="overtime"
										type="text" class="formText135" id="overtime"  
										onKeyPress=" return numeric_only(event,'overtime','6')"     size="20" maxlength="5"> 
										<input
										type="radio" name="otType" value="hours" checked="checked">
									In Hours <input type="radio" name="otType" value="mins">
								  In Mins</td>
								</tr>

								<tr>
									<td height="29" align="left" valign="middle" class="boldEleven">Batta<font
										color="#CC0000"> <font color="#CC0000">*</font></font></td>
									<td align="left" valign="middle"><input name="batta"
										type="text" class="formText135" id="batta"
										onKeyPress=" return numeric_only(event,'batta','6')"  maxlength="5" size="20"></td>
								</tr>
								<tr>
									<td height="29" align="left" valign="middle" class="boldEleven">Washing<font
										color="#CC0000"> <font color="#CC0000">*</font></font></td>
									<td align="left" valign="middle"><input name="washing"
										type="text" class="formText135" id="washing"
										onKeyPress=" return numeric_only(event,'washing','6')" maxlength="5"    size="20"></td>
								</tr>
								<tr>
									<td height="29" align="left" valign="top" class="boldEleven">Description<font
										color="#CC0000"> <font color="#CC0000">*</font></font></td>
								  <td align="left" valign="middle"><textarea name="Txtdes" cols="20" rows="5" class="formText135" id="Txtdes" onKeyPress="textArea('Txtdes','150')"></textarea>
										
										<input type="HIDDEN" name="filename" value="OverTime"> <input
	type="HIDDEN" name="actionS" value="<%=actionStu %>"> <br>
<script language='JavaScript'>
		<!--
			 
			setCurrentDate('fromdt');
			setCurrentDate('todt');			
		//-->
	</script></td>
								</tr>

								 

								<tr>
									<td height="29" colspan="2" align="left" valign="middle"
										class="">
									<table align="center">
										<tr align="center">
											<td width="56"><input class="buttonbold" type="submit"
												name="Submit" value="Submit"   accesskey="s"    onClick="return Validate()"></td>
											<td width="56"><input class="buttonbold" type="button"
												name="Submit"  value="Close"   accesskey="c" 
												onClick="redirect('OverTime.jsp')"></td>
										</tr>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		<center>
		</div>
		</td>
	</tr>
</table>

</table>
 
<%@ include file="../footer.jsp"%></form>
</body>

</html>
