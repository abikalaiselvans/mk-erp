<%@ page import="java.io.*,java.util.*"%>
 <%
	String er="";
	er = ""+request.getParameter("servicebillnumber");
	if(!"null".equals(er))
	{
		%>
		<script language="javascript">
			alert(" Service bill number :: <%=er%>");
			 
		</script>	
		<jsp:forward page="ServiceBillingAdd.jsp" />
		<%
		
	}	
		%>