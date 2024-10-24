<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
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
	
	$(function() {
		$( "#fromdt" ).datepicker({ minDate: -30, maxDate: "+0D" });
	});
	
	
 $(function() {
		$( "#todt" ).datepicker({ minDate: -30, maxDate: "+0D" });
	});
	
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript">
  
  
  function Validate()
  {
  	
	var d1 = document.getElementById('fromdt').value;
	var d2 = document.getElementById('todt').value;
	var dd1 = d1.split("-");
	var dd2 = d2.split("-");
	var ds = compute(dd1[0],dd1[1],dd1[2]) ;
	if(ds=="Sunday")
	{
		alert("You are selecting Sunday");
		return false;
	}
	
	if(d1 != d2)
	{
	 	alert("Kindly select same date");
		return false;
	}
	
	var cm = dd1[1];
	var cy = dd1[2];
	var sm = document.getElementById('smonth').value;
	var sy = document.getElementById('syear').value;
	
	var l = false;
	if((cm == sm) && (cy==sy))
		l = true;
	else
	{
		alert("Confirm with your date");
		l= false;
	}
	
	var dl = document.getElementById('dtflag').value;
	if(dl == "N")
		l = true;
	
	if(!l)
	{
		document.getElementById('fromdt').focus();
		return false;
	}	
	
	if(	 (l)
		&& checkNull("ename","Select Staff") 
		&& checkNull("fromdt","Enter From Date") 
		&& checkNull("todt","Enter To Date") 
  		&& checkNull("hdescription","Enter Holiday Description")
		&& checkDate("fromdt","todt"))
		{
			return true;
		}
		else
		{
			return false;
		}	
  }
   

</script>
 

<title> :: ATTENDANCE ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" 	onLoad="init()">
<%@ include file="index.jsp"%>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   method="post" name='frmState' action="../SmartLoginAuth" 	onSubmit="return Validate()">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="500"
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
					<table width="100%" align="center">
						<tr>
							<td>
							<div align="center"><span class="bold1">Holiday</span></div>
							<table width="100%" border="0" align="center">
								<!--DWLayoutTable-->
								<tr>
									<td width="463" height="36" valign="top">
									<table width="100%" border="0" align="center" cellpadding="0"
										cellspacing="0"  >
										<!--DWLayoutTable-->
										<tr>
											<td width="466"  valign="top" class="bolddeepblue"><div align="center">
											  <%@ include
												file="../JavaScript/ajax.jsp"%>
											  </div></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td height="136" align="left" valign="top"><table width="463" border="0" cellpadding="2" cellspacing="2"
										  class="bolddeepblue">
										<!--DWLayoutTable-->
										 
										<tr>
										  <td height="30" colspan="2" valign="middle"
												class="boldEleven"><strong>Common Holiday - Select All Saff.</strong> <font color="#CC0000">*</font></td>
									  </tr>
										<tr>
										  <td height="30" colspan="2" valign="middle"
												class="boldEleven"><strong>Individual
										  Holiday-Select Particular Staff</strong> <font color="#CC0000">*</font> </td>
									  </tr>
										<tr>
											<td width="204" height="30" valign="middle"
												class="boldEleven">From 
											  <input name="Holiday"
												type="hidden" value="E"> <%
							  	
							String logintype[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAT_LOCK FROM m_institution");
							out.println("<input name=\"dtflag\" type=\"hidden\" value=\""+logintype[0][0]+"\" id=\"dtflag\">");
							
							String dat[][] = com.my.org.erp.common.CommonFunctions.DateExpansion();
							out.println("<input name=\"smonth\" type=\"hidden\" value=\""+dat[0][4]+"\" id=\"smonth\">");
							out.println("<input name=\"syear\" type=\"hidden\"  value=\""+dat[0][3]+"\" id=\"syear\">");
							  %>										  </td>
											<td class="boldEleven"><input name="fromdt" type="text" class="formText135"
												id="fromdt" onKeyPress="dateOnly('fromdt')" value=""
												size="15" readonly="readonly"> 
											 (dd-mm-yyyy)</td>
										</tr>
										<tr>
											<td height="30" align="left" valign="middle"
												class="boldEleven">To</td>
										  <td align="left" valign="middle" class="boldEleven"><input name="todt"
												type="text" class="formText135" id="todt"
												onKeyPress="dateOnly('todt')" value="" size="15"  readonly="readonly"> 
										    (dd-mm-yyyy)</td>
										</tr>
										<tr>
											<td height="29" align="left" valign="top" class="boldEleven">Holiday
											Name <font color="#CC0000">*</font></td>
											<td align="left" valign="middle" class="boldEleven"><textarea
												name="hdescription" cols="30" rows="5" class="formText135"
												id="hdescription" onKeyUp="textArea('hdescription','250')"></textarea></td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
									</table>
									<table>
										<tr>
											<td></td>
										</tr>
									</table>
	 
<input type="HIDDEN" name="filename" value="Holiday"> <input
										type="HIDDEN" name="actionS" value="ATTholidayAdd"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="left" valign="middle" class="">
							<table align="center" cellpadding="3" cellspacing="3">
								<tr align="center">
									<td width="56"><input class="buttonbold" type="submit"
										name="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c"  onClick="redirect('Holiday.jsp')">
									</td>
								</tr>
							</table>
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
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmState'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;	
			setCurrentDate('fromdt');
			setCurrentDate('todt');			
		//-->
	</script></td>
	</tr>
</table>
</table>
<%@ include file="../footer.jsp"%>
</body>
 
</html>
