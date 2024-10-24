<%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
  function LoadImage()
    { 
		var fname=document.getElementById("F1").value;
    	document.getElementById("Photo").src=document.getElementById("F1").value; 	
    }	
	
 function Load()
  	{
  		if((checkNull('F1','Select Photo ')))
  		{
			var file = document.getElementById("F1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".GIF") ||(Extn == ".gif") ||(Extn == ".jpeg") ||(Extn == ".JPEG") ||(Extn == ".JPG") ||(Extn == ".jpg") ||(Extn == ".BMP") ||(Extn == ".bmp"))
			{
				return true;
			}
			else
			{
				alert("Only possible JPEG,GIF,BMP only");
				return false;
			}
		}
   		else
		{
   			
			return false;
  		}
		
 	}  
	
	
 </script>
<HTml>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>
 
  <BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "emp0.jsp?name=kalai" METHOD="POST" onSubmit="return Load()">
    <table width="420" height="262" border="2" align="center" >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING STAFF PHOTO </B></td></tr>
			   <tr>
			     <td>Staff Id </td>
			     <td><%=request.getParameter("staffid")%> <input type="hidden"
			name="staffid" value="<%=request.getParameter("staffid")%>"> </td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file" onChange="LoadImage()"></td></tr>
			   <tr>
			     <td colspan="2"><div align="center"><img src="../StaffPhoto/default.jpg"
			width="100" height="130" border="1" id="Photo"  name="Photo" title="Image should be 100 x 130 pixel" /></div></td>
		     </tr>
			   <tr><td colspan="2"><p align="right"><INPUT TYPE="submit" VALUE="Send File" ></p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>