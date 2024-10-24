<%
try
{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Untitled Document</title>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><applet code="com.my.org.erp.Mailer.Clock.class" width=300 height=300>
    </applet></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
		out.println(e.getMessage());
		System.out.println(e.getMessage());
}
%>