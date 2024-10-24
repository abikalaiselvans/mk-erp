<%!
	String empid;
	String empname;
	String empdes;
	String empdep;
	String intime;
	String outtime;	
	String tothours;
	String shiftcode;
	String shifttime;
	String msg;	
	
	String SAtype=null;
%>
<%
	
%>
<%
    empid=""+request.getParameter("empid");
	empname=""+request.getParameter("empname");
	empdep=""+request.getParameter("depname");
	empdes=""+request.getParameter("desname");
	intime=""+request.getParameter("intime");
	outtime=""+request.getParameter("outtime");
	tothours=""+request.getParameter("tothours");
	shiftcode=""+request.getParameter("shiftcode");
	shifttime=""+request.getParameter("shifttime");
	msg=""+request.getParameter("message");
	if(empid.equals("null")) empid="";
	if(empname.equals("null")) empname="";
	if(empdes.equals("null")) empdes="";
	if(empdep.equals("null")) empdep="";
	if(intime.equals("null")) intime="";
	if(outtime.equals("null")) outtime="";
	if(tothours.equals("null")) tothours="";
	if(shiftcode.equals("null")) shiftcode="";
	if(shifttime.equals("null")) shifttime="";
	if(msg.equals("null")) msg="";	
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
<!--
    function validateFields()
    {
   	 if(checkNull('pinno','Enter Pin No'))
   	   return true;
   	 else{
   	   return false;	  
   	 }
    }
    function LoadVerifyWindow()
	{
		window.showModelessDialog("../FingerPrint/FingerPrintVerify.jsp","_blank","dialogHeight:300,dialogWidth :300,scrollbars = no")
	}
//-->
</script>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" bgcolor="#C3E1F2">
<form  AUTOCOMPLETE = "off"   name='frmSAttentance' method="post" action="IntimeOuttime.jsp"
	onsubmit="return validateFields()">
<center>
<table width="100%" height="100%" border="0">
	<!--DWLayoutTable-->
	<tr align="center" valign="middle" bgcolor="#336699" height="6%">
		<td colspan="3" bgcolor="#003366"><b><font color="#AFFAFB"
			size="4">ATTENDANCE </font></b></td>
	</tr>
	<tr height="60%">
		<td align="center"><img src="../Image/Smart Attendance/URU.gif"
			align="middle"></td>
		<td valign="middle" align="center" colspan="2">
		<table border="0" width="500">
			<tr>
				<td align="left" width="50"><font class="style1">
				Employee Id</font></td>
				<td>:</td>
				<td><%= empid %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Employee Name</font></td>
				<td>:</td>
				<td><%= empname %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Department</font></td>
				<td>:</td>
				<td><%= empdep %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Designation </font></td>
				<td>:</td>
				<td><%= empdes %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Shift Code</font></td>
				<td>:</td>
				<td><%= shiftcode %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Shift Time </font></td>
				<td>:</td>
				<td><%= shifttime %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> In Time </font></td>
				<td>:</td>
				<td><%= intime %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Out Time </font></td>
				<td>:</td>
				<td><%= outtime %></td>
			</tr>
			<tr>
				<td align="left"><font class="style1"> Total Hours </font></td>
				<td>:</td>
				<td><%= tothours %></td>
			</tr>
		</table>
		</td>
	</tr>
	<%		
		SAtype=""+session.getValue("SAType");
		if(SAtype.equals("B")){
%>
	<tr height="8%" bgcolor="#003366">
		<td><%=SAtype %></td>
		<td><font size="5" color="#00FF00"><%= msg %> </font></td>
		<td align="right"><input type="button" value="Exit"
			onclick="javascript:self.close();"></td>
	</tr>
	<script language="javascript">
		<!--
			LoadVerifyWindow()
		//-->
		</script>
	<%	
		session.putValue("SAType","BB");
		}
		else{
%>
	<tr height="3%" bgcolor="#003366">
		<td><%=SAtype %> <b><font size="5" color="#FFFFFF">Enter
		Your 4 Digit pin no :</font></b> <input type="text" name="pinno" id='pinno'
			size="4" tabindex="1" onKeyPress="numericValue('pinno','4')">
		<input type="hidden" name="tablename" value="Multi"> <input
			type="hidden" name="file" value="Multi EntryWindow.jsp"> <input
			type="submit" value="OK"></td>
		<td><font size="5" color="#00FF00"><%= msg %> </font></td>
		<td align="right"><input type="button" value="Exit"
			onclick="javascript:self.close();"></td>
	</tr>
	<%
		}
%>

</table>
</center>
</form>
<script language="javascript">
<!--
	document.getElementById("pinno").focus();
//-->
</script>
</body>
</html>
