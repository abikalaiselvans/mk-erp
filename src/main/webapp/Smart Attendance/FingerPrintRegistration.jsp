<%@ page import="java.sql.*,java.util.*,java.io.*"%>
 
 <link href="../JavaScript/Styles.css" rel="stylesheet" type="text/css">
 <script language="javascript">
 function windownormalsize()
 {
	newWindow = window.open("Main.jsp","self","top");
	newWindow.focus( );
	//javascript:self.close()
	//window self top parent
 }
 </script>

<style type="text/css">
<!--
body {
	background-color: #dee7ff;
}
-->
</style>
<title> :: ATTENDANCE ::</title>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<table width="100%" height="100%">
<tr><td height="710" align="center" valign="middle">
  <table height="70%" align="center" cellpadding="2" cellspacing="10">
	<tr>
		<td align="center" valign="middle" bgcolor="#FF0000">
		 
 <applet  code=FingerPrintRegistration.class width=600 height=500 align="absmiddle" archive="jsdk.jar,sample.jar,mysqlconnect.jar">
 </applet>		</td>
	</tr>
	<tr>
		<td align="center"><input type="button" class="tMLAscreenHead" onClick="javascript:self.close()"  value="Close"   accesskey="c" ></td>
	</tr>
</table>
 </td></tr>
 </table>