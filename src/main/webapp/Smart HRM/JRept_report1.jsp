<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%
try
{
%>

<style type="text/css">
<!--
@import url("JavaScript/SmartStyles.css");
-->
</style>
 <link href="DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>


<html>
<body>
<form action="reports1">
<%-- ${param.file }<br> --%>
<%session.setAttribute("map",request.getAttribute("map"));
session.setAttribute("query",request.getAttribute("query"));
%>


<center>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <table class="BackGround1" cellspacing="0" cellpadding="0" width="300"
			align="center" border="0">
    <tbody>
      <tr>
        <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="Image/General/TLCorner.gif" width="7" /></td>
        <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="Image/General/TRCorner.gif" width="7" /></td>
      </tr>
      <tr>
        <td height="6"><spacer height="1" width="1" type="block" /></td>
      </tr>
      <tr>
        <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        <td width="6"><spacer height="1" width="1" type="block" /></td>
        <td width="412" valign="top"><table width="278">
          <tr>
            <td colspan="2"><input type="hidden" name="file" value="${file }"/></td>
          </tr>
          <tr>
            <td class="boldEleven">Export Type:</td>
            <td><script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#export").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
        </script>
              <select name="export" id="export" style="width:170px;" >
                <option value="csv" title="DropDown - Image/icons/csv.jpg">CSV </option>
                <option value="xls" title="DropDown - Image/icons/excel.jpg">Excel </option>
                <option value="html" title="DropDown - Image/icons/html.jpg">Html </option>
                <option value="pdf" title="DropDown - Image/icons/pdf.jpg" selected>Pdf </option>
                <option value="rtf" title="DropDown - Image/icons/rtf.jpg">Rtf </option>
              </select></td>
          </tr>
          <tr>
            <td colspan="2" align="center"><input type="submit" value="Submit" class="buttonbold13" /></td>
          </tr>
          <tr>
            <td colspan="2" align="center"><c:if test="${download != null }"> <a href="${download}">Download File</a> </c:if></td>
          </tr>
        </table></td>
        <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
        <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      </tr>
      <tr>
        <td colspan="2" rowspan="2"><img height="7"
						src="Image/General/BLCorner.gif" width="7" /></td>
        <td height="6"><spacer height="1" width="1" type="block" /></td>
        <td colspan="2" rowspan="2"><img height="7"
						src="Image/General/BRCorner.gif" width="7" /></td>
      </tr>
      <tr>
        <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
      </tr>
    </tbody>
  </table>
  </center>

</form>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
</body>
</html>