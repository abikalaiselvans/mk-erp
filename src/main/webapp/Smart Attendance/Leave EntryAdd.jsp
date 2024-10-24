
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%String actionStu="ATTleaveAdd"; %>
<%!Connection con=null;
ResultSet rs;
Statement st;
String sql;%>
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
  function Validate()
  {
  	if(checkNull("ename","Select Staff") && checkNullSelect("Leavetype","Select Leave Type","select") && checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkDate("fromdt","todt")){
		
		document.frmState.submit();
		return true;
	}
	return false;
  }
  function check()
  {
  	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") && checkNullSelect("Leavetype","Enter From Date"))  	
  {
		
		document.frmState.submit();
		return true;
	}
	return false;
  }
  function mainPage()
	{
	    //document.frmState.action="AttendanceMain.jsp";
		//document.frmState.submit();
		//return true;
		history.back(1);
    }
</script>


<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.menuBtn {
	width:100%;
}
.style17 {color: #FF0000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth"><br>
<br>
<br>
<table>
	<tr>
		<td>
		<table width="870" border="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="263" height="31"></td>
				<td width="174"></td>
				<td width="58"></td>
				<td width="241"></td>
				<td width="1"></td>
				<td width="107"></td>
			</tr>
			<tr>
				<td height="35"></td>
				<td colspan="3" valign="top">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<!--DWLayoutTable-->
					<tr>
						<td width="474" height="33" valign="top"><%@ include
							file="../JavaScript/ajax.jsp"%></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="26">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td height="160">&nbsp;</td>
				<td colspan="4" align="left" valign="top">
				<table width="463" border="1" cellspacing="2" cellpadding="2"
					 >
					<!--DWLayoutTable-->
					<tr>
						<td height="25" colspan="2" valign="top" 
							class="tablehead">
						<div align="center">Leave Entry</div>
						</td>
					</tr>
					<tr>
						<td height="19" class="bolddeepblue">Leave Type <strong>
						<span class="style17">*</span> </strong></td>
						<td><select name="Leavetype" class="tabledata">
							<option value="select">Select</option>
							<%
                  try
		{	
			st=null;//con.createStatement();
			sql="SELECT * FROM ATT_M_LEAVETYPE";
			rs=st.executeQuery(sql);
			while(rs.next())
			{
			%>
							<option value="<%=rs.getString("CHR_LEAVENAME")%>"><%=rs.getString("CHR_LEAVENAME")%></option>
							<%}
			}
		catch(SQLException e){}
	%>
						</select></td>
					</tr>
					<tr>
						<td width="153" height="30" valign="middle" class="bolddeepblue">From</td>
						<td><input name="fromdt" type="text" class="tabledata"
							id="fromdt" onKeyPress="dateOnly('fromdt')" value="" size="15">
						<a href="javascript:cal1.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="30" align="left" valign="middle" class="bolddeepblue">
						<p class="style8">To</p>
						</td>
						<td align="left" valign="middle"><input name="todt"
							type="text" class="tabledata" id="todt"
							onKeyPress="dateOnly('todt')" value="" size="15"> <a
							href="javascript:cal2.popup();"><img
							src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
							alt="Click Here to Pick up the date"></a></td>
					</tr>
					<tr>
						<td height="29" align="left" valign="middle" class="bolddeepblue">
						Day</td>
						<td width="283" class="tabledata"><input name="ComboDay"
							id="TxtDay" type="radio" value="Full Day" CHECKED> Full
						Day <input name="ComboDay" type="radio" id="TxtDay1"
							value="Forenoon"> Forenoon <input name="ComboDay"
							type="radio" id="TxtDay2" value="Afternoon"> Afternoon</td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="24">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td height="32">&nbsp;</td>
				<td colspan="3" align="center" valign="middle">
				<table>
					<tr>
						<br>
						<td width="56"><input type="submit" name="Submit"
							value="Submit" onClick="return Validate()" class="buttonbold"></td>
						<td width="56"><input type="submit" name="Submit"
							value="View" onClick="return check()" class="buttonbold"></td>
						<td width="56"><input type="button" name="Submit"
							 value="Close"   accesskey="c"  onClick="mainPage()" class="buttonbold"></td>
					</tr>
				</table>
				</td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<input type="HIDDEN" name="filename" value="LeaveEntry"> <input
			type="HIDDEN" name="actionS" value="<%=actionStu%>">

		<center>
		<table>
			<tr align="center">
				<td align="center" colspan="2"></td>
			</tr>


		</table>
		<script language='JavaScript'>
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
	</script> <% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
		<CENTER>
		<table width="23%" border="1" cellspacing="2" cellpadding="2"
			 >

			<tr>
				<td align="center" class="tabledata"><%=msg%></td>
			</tr>
			<% } %>
		</table>
		</CENTER>
		<br>
		<br>
		<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
