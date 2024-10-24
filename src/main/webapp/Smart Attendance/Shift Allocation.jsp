<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%String actionStu="ATTshiftAdd"; %>
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String sql_Select_Query1="SELECT * FROM ATT_M_SHIFT";
	public void releaseJDBCResource() 	
	{
		try
		{
			rst.close();
			pstm.close();
			 

		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  { 
  	if(checkNull("ename","Select Staff") && checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkNullSelect("shift","Select Shift","select")&& checkDate("fromdt","todt")){	
		document.frmState.submit();
		return true;
	}
	return false;
	}
	  function Validate1()
  {
  	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkDate("fromdt","todt")){
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
.menuBtn {
	width:100%;
}
.style17 {color: #FF0000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="post" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <br>
<br>
<br>
<br>
<center>
<table border="0">
	<tr align="center">
		<td valign="top" align="center" width="500">
		<div align="center"><%@ include file="../JavaScript/ajax.jsp"%>
		</div>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table width="500" border="1" cellspacing="2" cellpadding="2"
			  height="152">
			<tr valign="middle">
				<td height="29" colspan="2" align="center" class="BackGround"
					 >Shift Allocation</td>
			</tr>
			<tr>
				<td valign="middle" class="bolddeepblue">From</td>
				<td height="35" valign="middle"><input name="fromdt"
					type="text" class="tabledata" id="fromdt"
					onkeypress="dateOnly('fromdt')" value="" size="25"> <a
					href="javascript:cal1.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a></td>
			</tr>
			<tr>
				<td align="left" valign="middle" class="bolddeepblue">To</td>
				<td align="left" valign="middle" height="36"><input name="todt"
					type="text" class="tabledata" id="todt"
					onkeypress="dateOnly('todt')" value="" size="25"> <a
					href="javascript:cal2.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a></td>
			</tr>
			<tr>
				<td width="232" valign="middle" class="bolddeepblue"><strong
					class="bolddeepblue">Shift Master <font color="#ff0000">*</font></strong></td>
				<td width="248" height="40" valign="middle"><select
					name="shift" class="tabledata">
					<option value="select">Select</option>
					<%
            try
	{		
		con =conbean.getConnection();
		pstm = con.prepareStatement(sql_Select_Query1);
		rst = pstm.executeQuery();
		while(rst.next())
		{%>
					<option value='<%=rst.getString("CHR_SHIFTCODE")%>'><%=rst.getString("chr_SHIFTNAME")%></option>
					<%}
		releaseJDBCResource();
		}catch(Exception ex)
	{
		//System.out.println(ex);
	}
	releaseJDBCResource();
%>
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="HIDDEN" name="filename" value="ShiftAllocation"> <input
	type="HIDDEN" name="actionS" value="<%=actionStu %>">
<table>
	<tr>
		<td width="56"><input class="buttonbold" type="submit"
			name="Submit" value="Submit"   accesskey="s"    onClick="return Validate()"></td>
		<td width="56"><input class="buttonbold" type="submit"
			name="Submit" value="View" onClick="return Validate1()"></td>
		<td width="56"><input class="buttonbold" type="submit"
			name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
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
<table width="23%" border="1" cellspacing="2" cellpadding="2"
	 >
	<tr>
		<td align="center" class="tabledata"><%=msg%></td>
	</tr>
	<% } %>
</table>
</center>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
