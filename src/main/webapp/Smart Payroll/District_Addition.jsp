<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con;
	Statement st;
	ResultSet rs;
	String sql;
	int TxtStateId;
%>
<%
TxtStateId=Integer.parseInt(request.getParameter("TxtStateId"));
	try
	{
		 con = conbean.getConnection();
		 st=con.createStatement();		 
	}
	catch(Exception e){
		
	}
%>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
   
	function Add()
 	{		
		var TxtDistrictName=document.getElementById("TxtDistrictName").value;
		
		if(TxtDistrictName=="")
		{
		  alert("Enter the District Name ")
		  document.frm.TxtDistrictName.focus();		  
		  return false;
		}
		
 	}
 
</script>
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
</head>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="post" name='frm' action="DistrictInsertion.jsp"
	onsubmit="return Add()"><br>
<br>
<table align="center" width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="219" height="103">&nbsp;</td>
		<td colspan="3" valign="top">
		<table border="1" align="center" width="392"  >
			<!--DWLayoutTable-->
			<tr valign="middle">
				<td height="23" colspan="2" align="center" 
					class="tablehead">District - Add</td>
			</tr>
			<tr>
				<td width="119" height="26" valign="middle" class="tabledata">District
				<span class="style3">*</span></strong></td>
				<td width="257" valign="middle"><strong> <input
					type="text" name="TxtDistrictName" id="TxtDistrictName" size="40"
					onkeypress="charOnly('TxtDistrictName','25')"> </strong></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="tabledata">Description</td>
				<td valign="top"><strong> <input type="text"
					name="TxtDistrictDes" size="40"> </strong></td>
			</tr>
			<input type="hidden" name="TxtStateId" value="<%=TxtStateId%>">
		</table>
		</td>
		<td width="239">&nbsp;</td>
	</tr>
	<tr>
		<td height="51">&nbsp;</td>
		<td width="235">&nbsp;</td>
		<td width="56">&nbsp;</td>
		<td width="217">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26">&nbsp;</td>
		<td>&nbsp;</td>
		<td valign="top"><input type="submit" name="Submit"
			value="Submit"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>

<% 
	String msg= request.getParameter("msg");	
	if(msg.equals(null)) msg="";
	if(msg.equals(""))
	   msg="";
	else  {  
	%>
<script language="javascript">
	   alert(<%=msg%>);
	</script>
<% }	
%>
</body>
</html>
