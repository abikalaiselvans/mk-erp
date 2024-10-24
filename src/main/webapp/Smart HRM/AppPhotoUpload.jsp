  <%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
    <%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
  function LoadImage()
    { 
		var fname=document.getElementById("F1").value;
    	document.getElementById("Photo").src=document.getElementById("F1").value; 	
    }	
	
 function Load()
  	{
  		if(  checkNull('F1','Select Photo ') &&  findSize('F1','File should be less than 20Kb')  )
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
	
function findSize(ctr,msg) 
{
    var fileInput =  document.getElementById(ctr);
    try
	{
		var s = fileInput.files[0].size;
		// 1 MB = 1048579 bytes  20kb = 20480
		if( s <= 20480)
			return true;
		else
		{
			alert(msg);
			return false;
		}	
        //alert(fileInput.files[0].size); // Size returned in bytes.
    }
	catch(e)
	{
        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
        var e = objFSO.getFile( fileInput.value);
        var fileSize = e.size;
        alert(fileSize);    
		return false;
    }
}


	
 </script>
<HTml>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>
 
  <BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "AppPhotoCopy.jsp?appCode=<%=request.getParameter("appCode")%>" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING APPLICANT PHOTO </B></td></tr>
			   <tr>
			     <td><b>Applicatnt Code/Name </b></td>
			     <td><b> <%= CommonFunctions.QueryExecute("SELECT CHR_APPCODE,CHR_APPNAME FROM  hrm_m_application WHERE INT_APPID="+request.getParameter("appCode"))[0][0]%> / 
	  <%= CommonFunctions.QueryExecute("SELECT CHR_APPCODE,CHR_APPNAME FROM  hrm_m_application WHERE INT_APPID="+request.getParameter("appCode"))[0][1]%><b></td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file" onChange="LoadImage()"></td></tr>
			   <tr>
			     <td colspan="2"><div align="center" class="boldElevenlink">( file should be  100 x 100 format with 20Kb in size) </div></td>
		     </tr>
			   <tr>
			     <td colspan="2"><div align="center"><img src="../images/logo.jpg" width="100" height="130" border="1" id="Photo"  name="Photo" title="Image should be 100 x 130 pixel" /></div></td>
		     </tr>
			   <tr><td colspan="2"><p align="right"><INPUT TYPE="submit" VALUE="Upload File" >
			   </p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>