 <%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
  <%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 
	
 function Load()
  	{
  		try
		{ 
			if(checkNull('F1','Select file ') &&   findSize('F1','File should be less than 2MB')  )
			{
				var file = document.getElementById("F1").value;
				var fileExtn = file.lastIndexOf(".");
				var Extn=file.substring(fileExtn);
				if((Extn == ".PDF") || (Extn == ".pdf") )
				{
					return true;
				}
				else
				{
					alert("Only possible PDF only");
					return false;
				}
			}
			else
			{
				
				return false;
			}
		}
		catch(err)
		{
			alert(err);
			return false;
		}
 	}  
	
function findSize(ctr,msg) 
{
    var fileInput =  document.getElementById(ctr);
    try
	{
		var s = parseInt(fileInput.files[0].size);
		// 1 MB = 1048579 bytes
		if( s <= 2097158)
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
         if( parseInt(fileSize)  <= 2097158)
			return true;
		else
		{
			alert(fileSize);
			return false;
		}	 
    }
}



	
 </script>
<HTml>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<title> :: COMMON ::</title>


 
  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "StafffullFileCopy.jsp?staffid=<%=request.getParameter("staffid")%>" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING STAFF INFORMATIONS </B></td></tr>
			   <tr>
			     <td><b>Staff Id / Name</b></td>
			     <td><b><%=request.getParameter("staffid")%>  / <%=CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+request.getParameter("staffid")+"'")[0][0]%><b></td>
		     </tr>
			   <tr>
			     <td colspan="2" class="boldred"><div align="center"><span class="boldElevenlink">( file should be   2Mb in size) </span></div></td>
		     </tr>
			   <tr>
			     <td colspan="2" class="boldred"><div align="center" class="bolddeepred">
			       <div align="center"><strong>* Put Resume,certificates, address proof  are in one pdf file.  </strong></div>
			     </div></td>
		     </tr>
			   <tr>
			     <td>&nbsp;</td>
			     <td>&nbsp;</td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file" ></td></tr>
			   
			   <tr><td colspan="2"><p align="right"><INPUT TYPE="submit" VALUE="Upload File" >
			   </p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>