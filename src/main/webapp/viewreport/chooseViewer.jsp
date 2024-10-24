<%@ page contentType="text/html; charset=utf-8"%>

<%
  /* 
  * This file allows the user to choose the type of report viewer that they
  * would like to use.
  */
%>

<html>
<head>
<!-- #include file=../utilities.jsp -->
<link rel="stylesheet" type="text/css" name="stylelink"
	href="../tutss.css">
</head>
<body  onpaste='return false;'>
<h4>
<% 
	       out.print("Choose a viewer"); 
	    %>
</h4>
<hr />
<%  out.print("<form name=\"chooseViewerForm\" action=\"");
            out.print("jrcSetup.jsp\"");      
            out.print(" method=\"post\">");
        %>
<p>Which viewer would you like to use?</p>
<select name="viewerToLaunch">
	<option selected value="pageViewer">Java Report Page Viewer</option>
	<option value="partViewer">Java Report Part Viewer</option>
	<option value="drillViewer">Java Report Part Viewer with
	drilldown</option>
</select>
<p><input name="sa" type="submit" class="button" value='Next'></p>
<%  out.print("</form>"); %>
<hr />
<p align="right"></p>
</body>
<p align="right"><a
	href="../source.jsp?name=/viewreport/chooseViewer.jsp" TARGET="_blank">View
Source</a></p>
</html>
