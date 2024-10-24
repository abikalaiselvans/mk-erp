
<%@ page
	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

    function LoadImage()
    { 
		var fname=document.getElementById("file").value;
    	document.getElementById("Photo").src=document.getElementById("file").value; 	
    }	
	
	function Load()
  	{
  		if((checkNull('file','Select Photo ')))
  		{
			var file = document.getElementById("file").value
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".GIF") ||(Extn == ".gif") ||(Extn == ".JPG") ||(Extn == ".jpg") ||(Extn == ".BMP") ||(Extn == ".bmp"))
			{
				var query="StaffPhotoCopy.jsp?staffid=" +document.getElementById("staffid").value ;
				query = query+"&fileExtn="+Extn;
				document.uploadForm.action=query;
  				//document.uploadForm.submit();
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
<body onpaste="return false;">
<form AUTOCOMPLETE="off" id="form1" name="uploadForm" action=""
	enctype="multipart/form-data" method="post" onSubmit="return Load()">
<table width="327" border="0" cellpadding="1" cellspacing="5"
	class="tabledata">
	<tr>
		<td>Staff Id</td>
		<td><%=request.getParameter("staffid")%> <input type="hidden"
			name="staffid" value="<%=request.getParameter("staffid")%>"></td>
	</tr>
	<tr>
		<td width="90" valign="top">Staff Photo</td>
		<td width="218"><input type="file" name="file" id="file"
			onChange="LoadImage()" /></td>
	</tr>
	<tr>
		<td colspan="2">
		<div align="center"><img src="../StaffPhoto/default.jpg"
			width="100" height="130" border="1" id="Photo" name="Photo"
			title="Image should be 100 x 130 pixel" /></div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<table width="56" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td><input name="Submit" type="submit" class="buttonbold"
					value="Submit"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
