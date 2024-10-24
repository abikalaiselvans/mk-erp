<html>
<head>
<%
try
{
CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>

<title> ::UPLOAD /  DOWNLOAD</title>

</head>
</html>
 <script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>

 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%> </td>
  </tr>
  <tr>
    <td height="480" align="center"> 
	 
	</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%> </td>
  </tr>
</table>

 
<%
}
catch(Exception e)
{
		out.println(e.getMessage());
}
%>