
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 

<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkDate("fromdt","todt")){
		document.frmState.action="../SmartLoginAuth";
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

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}
.menuBtn {
	width:100%;
}
.thead{font-family:Verdana,Helvetica,Sans-serief; font-size:12px; color:#003366; font-weight:bold;}
.tdata{font-family:Verdana,Helvetica,Sans-serief; font-size:12px; color:#0099cc; font-weight:bold;}

-->
</style>
<%@ include file="index.jsp"%>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td height="100">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="310"
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

					<table width="450" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="25" colspan="2" class="BackGround" >LeaveEntry
							DateWise</td>
						</tr>

						<tr>
							<td width="162" height="28" valign="middle" class="tabledata">
							Company</td>
							<td width="100"><select name="company" id="company"
								onChange="loadBranch()" class="tabledata" style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="tabledata">
							Branch</td>
							<td width="100"><select name="branch" id="branch"
								class="tabledata" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						</tr>

						<tr>
							<td width="162" height="30" valign="middle" class="bolddeepblue">From</td>
							<td><input name="fromdt" type="text" class="tabledata"
								id="fromdt" value="" size="15"> <a
								href="javascript:cal1.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
						</tr>
						<tr>
							<td height="30" align="left" valign="middle" class="bolddeepblue">To</td>
							<td align="left" valign="middle"><input name="todt"
								type="text" class="tabledata" id="todt" value="" size="15">
							<a href="javascript:cal2.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a> <input
								type="hidden" name="filename" value="Report"> <input
								type="hidden" name="actionS" value="COM_ATTleaveEntryList">
							<input type="hidden" name="view" value="datewise"></td>
						</tr>
						<tr>
							<td height="30" colspan="2" align="left" valign="middle"
								class="bolddeepblue">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value=" Submit "
										onClick="return Validate()"></td>
									<td width="56"><input class="buttonbold" type="Button"
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
		<td></td>
	</tr>
	<tr>
		<td height="60" valign="top"><script language='JavaScript'>
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
