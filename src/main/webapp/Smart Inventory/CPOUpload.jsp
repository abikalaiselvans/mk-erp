<%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 	
function Load()
{

	try
	{  		 
		//&&  findSize('F1','File should be less than 160Kb')
		
		if(   checkNull('F1','Select file ')   )
  		{
			var file = document.getElementById("F1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".pdf") ||(Extn == ".PDF") )
			{
				return true;
			}
			else
			{
				alert("Only pdf only");
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
		// 1 MB = 1048579 bytes  20kb = 20480
		if( s <= 163840)
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
        if( parseInt(fileSize)  <= 163840)
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

<title> </title>

 
  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "CPOCopys.jsp?staffid=<%=request.getParameter("pono")%>&fileExtn=.pdf" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING CUSTOMER PURCHASE ORDER </B></td></tr>
			   <tr>
			     <td>&nbsp;</td>
			     <td>&nbsp;</td>
		     </tr>
			   <tr>
			     <td><b>QUOTATION Number </b></td>
			     <td> <%=request.getParameter("pono")%> </td>
		     </tr>
			    
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file"  ></td></tr>
			   <tr>
			     <td colspan="2"><div align="center" class="boldElevenlink">( file should be 160Kb in size) </div></td>
		     </tr>
			  
			   <tr><td colspan="2"><p align="right"><INPUT TYPE="submit" VALUE="Upload File" >
			   </p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>