<script type="text/javascript">
function Redirect()
{
    top.location="../Login.jsp?loginmsg=Session expired";
}

 setTimeout('Redirect()', 3000);
 </script>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />

<table width="99%" height="500" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td height="416" align="center"  class="bolddeepred">
	<br><center>
    
     
	 <%=request.getParameter("msg")%> </center> <br>
	 </td>
    </tr>
  </tbody>
</table>
 