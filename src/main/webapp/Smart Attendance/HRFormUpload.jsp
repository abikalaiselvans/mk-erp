<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%
try
{
%>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

    function LoadImage()
    { 
		var fname=document.getElementById("file").value;
    	document.getElementById("Photo").src=fname; 	
    }	
	function Load()
  	{
  		if((checkNull('file','Select File name ')))
  		{
			var file = document.getElementById("file").value
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".doc") || (Extn == ".docx"))
			{
				var query="HRFormCopy.jsp";
				query = query+"?fileExtn="+Extn;
				document.uploadForm.action=query;
  				//document.uploadForm.submit();ssssssss
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
 </script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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
<body  onpaste="return false;" bgcolor="#b7e9ff">
<form  AUTOCOMPLETE = "off"   id="form1" name="uploadForm" action=""
	enctype="multipart/form-data" method="post" onSubmit="return Load()">
<table width="327" border="0" cellpadding="1" cellspacing="5"
	class="tabledata">
	 
	<tr>
		<td width="90" valign="top">HR File </td>
		<td width="218"><input type="file" name="file" id="file"
			onChange="" /></td>
	</tr>
	<tr>
		<td height="137" colspan="2">
		<div align="center"></div>
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
<%
}
catch(Exception e)
{
}
%>