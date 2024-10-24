<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: ATTENDANCE ::</title>


</head>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" class="body">
<center>
<table width="90%" height="308">
	<tr>
		<td width="127" height="302">
		<div align="center">
		<%
		String message= "";
		String empid=""+session.getAttribute("EMPID");
		message=com.my.org.erp.alert.AlertFuntion.ScrollingMessage();
		double target=com.my.org.erp.alert.MEAlertFuntion.METargetAlert(empid);
		double achieve=com.my.org.erp.alert.MEAlertFuntion.METargetCollection(empid) ;
		if(target >0.0)
		{
		%>
		<script language="javascript">
			alert(" THIS MONTH TARGET -><%=target%>(In Lakhs) AND  ACHIEVE FOR THE MONTH -> <%=achieve%>");
		</script>
		<%
	 		out.println("<center><font class='bolddeepred'>");
			out.println("TARGET FOR THE MONTH  : "+com.my.org.erp.alert.MEAlertFuntion.METargetAlert(empid)+"(In lakhs)");
			out.println("ACHIEVE FOR THE MONTH : "+achieve+"");
			out.println("</font> </center>");
		}	
		 
		 
	%> <marquee> <h5><%=message%></h5> </marquee>
	<br>
	<%
	  message=com.my.org.erp.alert.AlertFuntion.YearCompletionList();
	  %>
	   <marquee class="copyright"> <%=message%> </marquee>
		</div>
	  </td>
	</tr>
</table>
</center>
</body>
</html>
