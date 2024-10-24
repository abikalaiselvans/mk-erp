<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>

<title>:: STAFF ::</title>

 <%@include file="Redirect.jsp" %>


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {font-size: 12px}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	class="body">

<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<b>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>
	   
	  
	    <div align="center">
	      <% 

 String staff1=""+session.getAttribute("EMPID");
            String status=""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_ACCEPTSTATUS from pay_t_resignationletter where CHR_EMPID='"+staff1+"'","CHR_ACCEPTSTATUS");
            String desc=""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_REJECTDESCRIPTION from pay_t_resignationletter where CHR_EMPID='"+staff1+"'","CHR_REJECTDESCRIPTION");

if(status.equals("N"))
	out.println("<font color='blue'>Your Resignation is still under consideration please contact your reporting head. </font>");
else if(status.equals("Y"))
	out.println("<font color='Green'>Your Resignation is accepted </font>");
else if(status.equals("R"))
	out.println("<font color='Red'>Your Resignation is rejected. </font>");

out.println("<br>");

if(status.equals("N"))
	out.println( "");
else if(status.equals("Y"))
	out.println("Description :: "+desc);
else if(status.equals("R"))
	out.println("Description :: "+desc);
	
 
%>
        </div></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
</table>
</body>

</html>
