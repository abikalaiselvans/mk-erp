<%@ page contentType="text/html; charset=utf-8"%>

<%
  /* 
  * This page allows the user to choose the file format that they want to
  * export the chosen report to.
  */
%>


<html>
<head>
<link rel="stylesheet" type="text/css" name="stylelink"
	href="../tutss.css" />
</head>
<body  onpaste='return false;'>
<h4>
<%  out.print("Choose an export format"); %>
</h4>
<hr />
<%  String[] formats = {"Crystal Report","Word","Excel","Rich Text","HTML (Not yet supported)","Acrobat","Excel Data Only","Plain Text","Editable RTF", "CSV"};
            session.setAttribute("formats", formats);
        %>
<form name="chooseFormatForm" action="setupExportVariables.jsp"
	method="post">
<p>Choose the format that you want to export to: <br>
<br>
<select name="exportFormat">
	<%  for(int i=0; i<=9; i++){
	                              // Don't print out the HTML option as it is not currently supported.
	                              if ((i != 4)&&(i > 2)&&(i !=6)&&(i !=7)){
	                                out.println("<option value=\"" + i + "\">" + formats[i]);
                                  }
                                }
                            %>
</select> <br>
<br>
<input name="sa" type="submit" class="button" value='Next' /></p>
</form>
<hr />
</body>
<p align="right"><a
	href="../source.jsp?name=/exportreport/chooseFormat.jsp"
	TARGET="_blank">View Source</a></p>
</html>
