<%@ page import="java.sql.*,java.util.*,java.io.*"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title> :: RESIGNED :: </title>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
 <br>
 <br>
 <br>
 <br>
 <br>
 <br>
 
<div align="center">


<% 
try
{			
	 
File folder = new File(request.getRealPath("")+"/Resigned/Form/");
File[] listOfFiles = folder.listFiles();
int u=0;
String extn="";
String fileName="";

	out.println("<table width='40%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'><td class='boldEleven' align='center' colspan='3'><b>DOWNLOAD THE FORMS </b></td>");
	for (int i = 0; i < listOfFiles.length; i++) 
		if (listOfFiles[i].isFile()) 
		{
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
			extn="";
			fileName = listOfFiles[i].getName();
			int mid= fileName.lastIndexOf(".");
			fileName=fileName.substring(0,mid);
			out.println("<td class='boldEleven'>"+(u+1)+".</td>" );
			out.println("<td class='boldEleven'>"+fileName.toUpperCase()+" </td>" );
			out.println("<td class='boldEleven'><a target='_blank'  href='../Resigned/Form/"+listOfFiles[i].getName()+"'> Download</a></td>" );
			u=u+1;
		}	
	out.println("</table>"); 		
}
catch(Exception e)
{
}
		%>
                              </div> 
</body>
</html>
