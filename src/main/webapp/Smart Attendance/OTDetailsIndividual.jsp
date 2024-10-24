
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>


<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>


<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("ename","Select Staff")&& checkNullSelect("Month","Select Month","select")&&(checkNullSelect("Year","Select Year","select"))){
		document.frmState.action="../SmartLoginAuth";
		document.frmState.submit();
		return true;
	}
	return false;
  }
 function mainPage()
  {
   document.frmLate.action="AttendanceMain.jsp";
   document.frmLate.submit();
   return true;
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


</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" name="frmLate" id="frmLate">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="270" valign="bottom">
		<table width="350" height="150" border="0" align="center"
			  class="bolddeepblue">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" class="tablehead">
				<td width="346" height="29" class="BackGround" >O.T.
				Details Individual</td>
			</tr>
			<tr valign="top">
				<td height="18" class="tabledata" align="center">
				<table width="100%" border="1" cellpadding="1" cellspacing="1"
					  class="bolddeepblue">
					<tr>
						<td colspan="2" align="center"><%@ include
							file="../JavaScript/ajax1.jsp"%></td>
					</tr>
					<tr>
						<td width="162" height="28" valign="middle" class="bolddeepblue">
						Company</td>
						<td width="100px"><select name="company" id="company"
							onChange="loadBranch()" class="bolddeepblue" style="width:200px">
							<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
						</select></td>
					</tr>
					<tr>
						<td width="162" height="28" valign="middle" class="bolddeepblue">
						Branch</td>
						<td width="100px"><select name="branch" id="branch"
							class="bolddeepblue" style="width:200px">
							<option value="-1">All</option>
						</select></td>
					</tr>

					<tr>
						<td width="148">From</td>
						<td width="186"><font size="1"><strong><font
							color="#000000"><font size="1"> <input
							name="fromdt" type="text" class="tabledata" id="fromdt" value=""
							size="15"> <a href="javascript:cal1.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a> </font></font></strong></font></td>
					</tr>
					<tr>
						<td>Date</td>
						<td><font size="1"><strong><font
							color="#000000"><font size="1"> <input name="todt"
							type="text" class="tabledata" id="todt2" value="" size="15">
						<a href="javascript:cal2.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a> </font></font></strong></font></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="58">
		<table width="149" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<!--DWLayoutTable-->
			<tr>
				<td width="51"><input name="Submit" type="submit"
					class="buttonbold" value="Submit"   accesskey="s"   >
				<td width="51"><input name="Button" type="Button"
					class="buttonbold"  value="Close"   accesskey="c" 
					onClick="javascript:history.back()"></td>
				<td width="17" valign="top">
				<div align="center"><input type="hidden" name="filename"
					value="OTDetails"> <input type="hidden" name="actionS"
					value="ATTOTDetailsIndidualList"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="41">&nbsp;</td>
	</tr>
	<%@ include file="../footer.jsp"%>
</table>

</form>

<script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmLate'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmLate'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
			setCurrentDate('fromdt');
			setCurrentDate('todt');			
	
		//-->
	</script>


</body>

</html>
