
<html>
<head>
<script type="text/JavaScript">
 function timedRefresh(timeoutPeriod) 
 {
	setTimeout("location.reload(true);",timeoutPeriod);
}
</script>
</head>

<%
String flag = ""+request.getParameter("flag");
String sout="";
if("Y".equals(flag))
	sout = "onload=\"JavaScript:timedRefresh(2000);\"" ;
else
	sout="";
 %>

<body onpaste="return false;" <%=sout%>>

<p>This page will refresh every 5 seconds.</p>
<table width="200" border="0">
	<tr>
		<td><a href="AutoRefreshExit.jsp?flag=Y">start</a></td>
		<td><a href="AutoRefreshExit.jsp?flag=N">stop</a></td>
	</tr>
</table>
<p>&nbsp;</p>
<%


	 

        Integer applicationCounter = (Integer)application.getAttribute("applicationCounter");
        if (applicationCounter == null) {
            applicationCounter = new Integer(1);
        } else {
            applicationCounter = new Integer(applicationCounter.intValue() + 1);
        }
        application.setAttribute("applicationCounter", applicationCounter);
		out.println(applicationCounter);
%>

</body>
</html>
