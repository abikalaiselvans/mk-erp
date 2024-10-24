<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%> 
  <!-- Theme style -->
  <link rel="stylesheet" href="../resources/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="../resources/dist/css/skins/_all-skins.min.css">

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 
	
function Load()
{

	try
	{  		 
		if(   checkNull('F1','Select Photo ')   )
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
	catch(err)
	{
		alert(err);
		return false;
	}	
}  
	
 
 
	
	
function LoadImage(fileid) 
{
 try 
 {
 	var fileSize = 0;
 	if(checkNull('F1','Select Photo') )
	{ 
		var file = document.getElementById("F1").value;
		var fileExtn = file.lastIndexOf(".");
		var Extn=file.substring(fileExtn);
		if((Extn == ".GIF") ||(Extn == ".gif") ||(Extn == ".jpeg") ||(Extn == ".JPEG") ||(Extn == ".JPG") ||(Extn == ".jpg") ||(Extn == ".BMP") ||(Extn == ".bmp"))
		{
		}
		else
		{
			alert("Only possible JPEG,GIF,BMP only");
			document.getElementById('F1').focus();
		}
		
		
		/*//for IE
		if ($.browser.msie) 
		{
			 
			var objFSO = new ActiveXObject("Scripting.FileSystemObject"); var filePath = $("#" + fileid)[0].value;
			var objFile = objFSO.getFile(filePath);
			var fileSize = objFile.size; //size in kb
			if( fileSize > 102400)
			{
				alert("Your file size File > 100k");
				document.getElementById('F1').focus();
			}
			 
		}
		//for FF, Safari, Opeara and Others
		else 
		{
			fileSize = $("#" + fileid)[0].files[0].size //size in kb
			if( fileSize > 102400)
			{
				alert("Your file size File > 100k");
				document.getElementById('F1').focus();
			}
		}
		*/
		
		
	}
	
 	  
 }
 catch (e) 
 {
 	 alert(e);
		 
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


<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">


		<div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Photo Upload Form</h3>
            </div>
             
			 <div class="box-body">
                 <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "StaffPhotoCopy.jsp?staffid=<%=request.getParameter("staffid")%>" METHOD="POST" onSubmit="return Load()">
                 
           	   		<table border="0" align="center" cellpadding="2" cellspacing="2"  >
					   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING STAFF PHOTO </B></td></tr>
					   <tr>
						 <td><b>Staff Id / Name</b></td>
						 <td><b><%=request.getParameter("staffid")%>  / <%=CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+request.getParameter("staffid")+"'")[0][0]%><b></td>
					 </tr>
					   <tr><td><b>Choose the file To Upload:</b></td>
					   <td><INPUT NAME="F1" id="F1"  TYPE="file" onChange="LoadImage('F1')"></td></tr>
					   <tr>
						 <td colspan="2"><div align="center" class="boldElevenlink">( file should be  100 X 100 Dimension &amp; size &lt;=100Kb ) </div></td>
					 </tr>
					   <tr>
						 <td colspan="2"><div align="center"><img src="../uploadfiles/StaffPhoto/default.jpg"
					width="100" height="130" border="1" id="Photo"  name="Photo" title="Image should be 100 x 130 pixel" /></div></td>
					 </tr>
					   <tr><td colspan="2"><p align="right"><INPUT class="btn btn-info pull-right" TYPE="submit" VALUE="Upload File" >
					   </p></td></tr>
					</table>
            
		 		</FORM>
                 
              </div>
              
            </form>
          </div>
 </div>		  
</BODY>
</HTML>