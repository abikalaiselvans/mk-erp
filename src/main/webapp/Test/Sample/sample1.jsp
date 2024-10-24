<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<form name="form1" method="get" action="../../SampleServlet">
<table width="40%" border="1" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td>Name</td>
    <td>
      <input name="name" type="text" id="name">    </td>
    </tr>
  <tr>
    <td>Age</td>
    <td><select name="age" id="age">
	<%
		for(int u=0;u<100;u++)
			out.println("<option value='"+(u)+"'>"+u+"</option>");
	%>
    </select>    </td>
    </tr>
  <tr>
    <td>Blood group </td>
    <td>
	<select name="blood" id="blood">
	<%
		String fileName = request.getRealPath("/")+"blood.txt";
		java.io.FileReader fr = new java.io.FileReader(fileName);
		java.io.BufferedReader br = new java.io.BufferedReader(fr);
		String strfline ="";
		String sline="";	
		while((strfline=br.readLine())!= null )	
		{
			 out.println("<option value='"+(strfline)+"'>"+strfline+"</option>");
		}
		br.close();
		fr.close();
	%>
    </select>    </td>
    </tr>
  <tr>
    <td>Department</td>
    <td><jsp:include page="department.jsp" flush="true" /></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td colspan="2"><table width="200" border="0" align="center" cellpadding="3" cellspacing="0">
      <tr>
        <td><input type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
        <td><input type="reset" name="Submit2" value="Clear"></td>
      </tr>
    </table></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
</table>
</form>
</body>
</html>
