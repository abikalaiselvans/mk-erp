<%@ page isErrorPage="true" %>

<%
	String name=(String)session.getValue("name");
	String nana=String.valueOf(name.charAt(0));
	nana=nana.toUpperCase();
	String sss=name.substring(1,name.length());
%>
<html>
  <body  onpaste="return false;" bgcolor="#F0FFFF">
   <%@ include file="mailtop2.html"%>
   <br><br>
      <table align="center">
	  <tr>
		<td >
				<font face=veradana size=3 color=#996745><b>Welcome</b> </font> <font color=red face=veradana size=3 >
				<b><%=nana+sss%></b></font><font face="veradana" size=3 color=#996745><b>&nbsp;&nbsp;to Ayush Mail </b></font>
				</td>
	  </tr>
	     <tr>
		     <td align="center"><font color="#FF0000" size=3><b>Your mail account has not been activated,Please contact <a href="mailform.jsp"><font >webmaster@ayushhealth.com</font></a></b></font></td>
		 </tr>
	  </table>
  </body>
</html>