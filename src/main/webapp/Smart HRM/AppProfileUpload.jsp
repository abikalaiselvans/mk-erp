 <%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
 <%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
  
 function Load()
  	{
  		if( checkNull('F1','Select Document file') && findSize('F1','File should be less than 100Kb')  )
  		{
			var file = document.getElementById("F1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".DOC") ||(Extn == ".doc"))
			{
				return true;
			}
			else
			{
				alert("Please Upload Document (*.doc) Files only");
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
		// 1 MB = 1048579 bytes
		if( s <= 1048579)
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

<title>:: HRM ::</title>

 
  <BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "ApplicantProfileCopy.jsp?rowid=<%=request.getParameter("appCode")%>" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING APPLICANT PROFILE</B></td></tr>
			   <tr>
			     <td><b>Applicant </b></td>
			     <td><b><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_APPCODE,CHR_APPNAME FROM  hrm_m_application WHERE INT_APPID="+request.getParameter("appCode"))[0][0]%> / 
	  <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_APPCODE,CHR_APPNAME FROM  hrm_m_application WHERE INT_APPID="+request.getParameter("appCode"))[0][1]%>
	 <b></td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file"  ></td></tr>
			   <tr>
			     <td colspan="2"><div align="center">
			       <div align="center"><span class="boldElevenlink">( file should be  .doc format with100Kb in size) </span></div>
</div></td>
		     </tr>
			   <tr><td colspan="2"><p align="right"><INPUT TYPE="submit" VALUE="Upload File" >
			   </p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>