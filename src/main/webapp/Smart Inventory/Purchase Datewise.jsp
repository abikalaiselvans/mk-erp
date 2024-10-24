<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<html>
<head>

<title>:: INVENTORY ::</title> <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkDate("fromdt","todt")&& checkNullSelect("vendorId","Select Vendor",'select'))
  	{
		document.frmState.submit();
		return true;
	}
	return false;
  }
  function mainPage()
  {
	    document.frmState.action="AttendanceMain.jsp";
		document.frmState.submit();
		return true;
  }
  
</script>
<style type="text/css">
<!--
.menuBtn {
	width:100%;
}
.thead{font-family:Verdana,Helvetica,Sans-serief; font-size:12px; color:#003366; font-weight:bold;}
.tdata{font-family:Verdana,Helvetica,Sans-serief; font-size:12px; color:#0099cc; font-weight:bold;}
.style3 {
	color: #202B78;
	font-weight: bold;
	font-size: 12px;
}

-->
</style>
</head>
<%@ include file="indexinv.jsp"%>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth"
	onsubmit="return Validate()">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td height="100">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
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
					<table width="450" border="0" align="center" cellpadding="1"
						cellspacing="1"  >
						<!--DWLayoutTable-->
						<tr align="center">
							<td height="25" colspan="2" valign="middle"><span
								class="style3">Purchase Details - DateWise</span></td>
						</tr>
						<tr>
							<td width="200" height="30" valign="middle" class="tabledata">From</td>
							<td><input name="fromdt" type="text" class="formText135"
								id="fromdt" value="" size="15"> <a
								href="javascript:cal1.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
						</tr>
						<tr>
							<td width="200" height="25" align="left" valign="middle"
								class="tabledata">To</td>
							<td align="left" valign="middle"><input name="todt"
								type="text" class="formText135" id="todt" value="" size="15">
							<a href="javascript:cal2.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a> <input
								type="hidden" name="filename" value="Report"> <input
								type="hidden" name="actionS" value="INVpurchaseDateWise">
							</td>
						</tr>
						<tr>
							<td class="tabledata">Select Vendor</td>
							<td>
							<%
			  			Connection con1;
						ResultSet rs1;
			  			con1 = conbean.getConnection();
      					Statement st1 = con1.createStatement();      			
						rs1 = st1.executeQuery("SELECT * FROM INV_M_VENDORSINFO");
			  		%> <select name="vendorId" id="vendorId">
								<option value="select">Select</option>
								<option value="all">All</option>
								<%
							while(rs1.next())
							out.println("<option value='"+rs1.getString("INT_VENDORID") +"'>"+rs1.getString("CHR_VENDORNAME")+" </option>");
					   %>
							</select></td>
						</tr>
						<tr>
							<td colspan="2" class="tabledata">
							<table border="0" align="center" cellpadding="1" cellspacing="1">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold13" value=" Submit "></td>
									<td width="56"><input class="buttonbold13" type="Button"
										name="Submit2"  value="Close"   accesskey="c" 
										onClick="javascript:history.back();"></td>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="135"><script language='JavaScript'>
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
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
