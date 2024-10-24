<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
	/*try
	{
		String filename = "C:/Program Files/Lib/Finger.properties";
		FileWriter fw = new FileWriter(filename);
		BufferedWriter bw = new BufferedWriter(fw);
		String fline="Welcome  ";
		bw.write(fline);
		bw.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}	*/
%> 
 <link href="../JavaScript/Styles.css" rel="stylesheet" type="text/css">
 <script src="../JavaScript/comfunction.js"></script>
 <script language="javascript">
  function windowfulsize()
 {
	newWindow = window.open("FingerPrintRegistration.jsp","","fullscreen,toolbar=yes,scrollbars=no,status=no");
	newWindow.focus();
	redirectauto('AttendanceMain.jsp');
 }
  </script>
 


<title> :: ATTENDANCE ::</title>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="windowfulsize()">
 <%@ include file="index.jsp"%>
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
	<tr>
		<td height="300">&nbsp;</td>
	</tr>
	<tr>
		<td height="44">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>

 
 