
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<%@ page import="java.sql.*,java.io.*,com.my.org.erp.bean.Attendance.StaffRegistration,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>


<%
	String Rowid=""+request.getParameter("Rowid");
	String emdfile = request.getRealPath("/")+"EMD_File/"+Rowid.trim() +".pdf";
	String emd="../EMD_File/"+Rowid.trim() +".pdf";
	File f = new File(emdfile);	
	if (f.exists())
	{
		%>
		<script language="javascript">
		window.location = "<%=emd%>";
		</script>
		<%
	}
	else
	{
		out.println("<br><br>");
		out.println("<br><br>");
		out.println("<center>");
		out.println("<font class='bolddeepred'>Data not found...</font>");
		out.println("</center>");
		out.println("<br><br>");
		out.println("<br><br>");
	}
%>


