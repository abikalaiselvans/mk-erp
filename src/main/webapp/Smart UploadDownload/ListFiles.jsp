<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title> ::UPLOAD /  DOWNLOAD</title>
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
    <td height="380" align="center"><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top">
            <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                <tr>
                  <td colspan="2" class="bold1"><div align="center"> LIST FILES </div></td>
                </tr>
                <tr>
                  <td colspan="2" class="boldEleven">
				  
				  <% 
			
String dirname = request.getRealPath("/")+"Smart UploadDownload/Upload";
File f1 = new File(dirname);
out.println("<center>");
out.println("<table width='80%'>");
out.println("<tr>");
out.println("<td class='boldEleven'><b>S.No</b></td>");
out.println("<td class='boldEleven'><b>Folder Name</b></td>");
out.println("<td class='boldEleven'><b>View The File</b></td>");
out.println("</tr>");
if (f1.isDirectory()) 
{
	 
	String s[] = f1.list();
	for (int i=0; i < s.length; i++) 
	{
		File f = new File(dirname + "/" + s[i]);
		if (f.isDirectory()) 
		{
			out.println("<tr>");
			out.println("<td class='boldEleven'>"+(i+1)+"</td>");
			out.println("<td class='boldEleven'>"+s[i]+"</td>");
			out.println("<td class='boldEleven'><a href='ListFilesResponse.jsp?path=" + s[i]+"'>click</a></td>");
			out.println("</tr>");
			 
		}
		
		 
	}
} 
 out.println("</table>");
 out.println("</center>");
 
 

		%>
			      </td>
                </tr>
              <tr>
                  <td class="boldEleven"><b> </b>                      </td>
                  <td class="boldEleven">&nbsp;</td>
              </tr>
              
              <tr>
                  <td colspan="2" class="boldEleven">
                    <table   border="0" align="center" cellpadding="1"
									cellspacing="1">
                      <tr>
                        <td width="56"><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('uploadMain.jsp')"></td>
                      </tr>
                  </table></td>
                </tr>
                    </table></td><td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table>	</td>
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

