<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
 
<%
try
{
%>
<html>
<head>

<title> ::UPLOAD /  DOWNLOAD</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
</html>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript"> loadServer() </script>

 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%> </td>
  </tr>
  <tr>
    <td height="350" align="center"><p>&nbsp;</p>
    <table width="90%" border="0" cellpadding=2 cellspacing=1 bgcolor='c0c0c0'>
        <tr>
          <td class="bold1"><div align="center">S.No</div></td>
          <td class="bold1"><div align="center">Name</div></td>
          <td class="bold1"><div align="center">Size</div></td>
          <td class="bold1"><div align="center">Type</div></td>
          <td class="bold1"><div align="center">Date</div></td>
          <td class="bold1"><div align="center">Download</div></td>
        </tr>
		
		<%
		File folder = new File(request.getRealPath("")+"/Smart UploadDownload//Upload//"+request.getParameter("path")+"/");
		File[] listOfFiles = folder.listFiles();
		int row=0;
		for (int i = 0; i < listOfFiles.length; i++) 
			if (listOfFiles[i].isFile()) 
			{
				row++;
				String fileName = listOfFiles[i].getName();
				File files = new File(request.getRealPath("")+"/Smart UploadDownload//Upload//"+request.getParameter("path")+"/"+fileName);
				String downfile = request.getParameter("path")+"/"+fileName;
				long filesize = files.length();
                long filesizeInKB = filesize / 1024;

				int mid= fileName.lastIndexOf(".");
  				String extn=fileName.substring(mid,fileName.length());
				SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy hh:mm:ss aaa");

				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'>"+row+".</td>");
				out.println("<td class='boldEleven'>"+fileName+"</td>");
				out.println("<td class='boldEleven' align='right'>"+filesizeInKB+"KB</td>");
				out.println("<td class='boldEleven' align='center'>"+extn+"</td>");
				out.println("<td class='boldEleven'>"+sdf.format(files.lastModified())+"</td>");
				out.println("<td class='boldEleven'><a  href='../DownloadFile?sessionid="+session.getId()+"&downfile="+downfile+"' style='text-decoration:none'><font color='Blue'>Download</font></a></td>");
				out.println("</tr>");
				
			}	

		%>
        
          
          
          
          
          
          
        
		  
      </table> 
      <p>&nbsp;</p>
      <table   border="0" align="center" cellpadding="1"
									cellspacing="1">
        <tr>
          <td width="56"><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('uploadMain.jsp')"></td>
        </tr>
      </table>      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%> </td>
  </tr>
</table>
 
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

 


