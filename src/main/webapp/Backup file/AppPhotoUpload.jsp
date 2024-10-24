<%@ page
	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

    function LoadImage()
    { 
		var fname=document.getElementById("file").value;
    	document.getElementById("Photo").src=fname; 	
    }
		
	function Load()
  	{
   		
		if((checkNull('file','Select Photo ')))
  		{
			var file = document.getElementById("file").value
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".gif") ||(Extn == ".GIF")||(Extn == ".JPG")||(Extn == ".jpg") ||(Extn == ".bmp"))
			{
				var query="AppPhotoCopy.jsp?appCode=" +document.getElementById("appCode").value;
				query = query+"&fileExtn="+Extn;
				document.uploadForm.action=query;
  				document.uploadForm.submit();
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
//   			alert("inside false");
			return false;
  		}
		
 	}  
 </script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
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
<body onpaste="return false;" bgcolor="#b7e9ff">
<form AUTOCOMPLETE="off" id="form1" name="uploadForm"
	enctype="multipart/form-data" method="post">
<table width="327" border="0" align="center" cellpadding="1"
	cellspacing="5" class="tabledata">
	<tr>
		<td>Application Code /Name</td>
		<td><input type="hidden" name="appCode"
			value="<%=request.getParameter("appCode")%>"> <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_APPCODE,CHR_APPNAME FROM  hrm_m_application WHERE INT_APPID="+request.getParameter("appCode"))[0][0]%>
		/ <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_APPCODE,CHR_APPNAME FROM  hrm_m_application WHERE INT_APPID="+request.getParameter("appCode"))[0][1]%>
		</td>
	</tr>
	<tr>
		<td width="90" valign="top">Applicant Photo</td>
		<td width="218"><input type="file" name="file" id="file"
			onChange="LoadImage()" /></td>
	</tr>
	<tr>
		<td colspan="2">
		<div align="center"><img src="../images/logo.jpg" name="Photo"
			width="120" height="100" border="1" id="Photo" /></div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<table width="56" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td><input name="Submit" type="submit" class="tMLAscreenHead"
					value="Submit" accesskey="s" onClick="return Load()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>