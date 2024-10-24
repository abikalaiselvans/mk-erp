 <%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
 
 <%@include file="Redirect.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

   
	
	function Load()
  	{
  		if((checkNull('file','Select File ')))
  		{
			var file = document.getElementById("file").value
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".xls") ||(Extn == ".XLS")  )
			{
				var query="PFAccountNumberExcelCopy.jsp?ids=PFACCOUTNUMBER&fileExtn="+Extn;
				document.uploadForm.action=query;
  				return true;
			}
			else
			{
				alert("Only possible xls , XLS only");
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <body  onpaste="return false;" >
<form  AUTOCOMPLETE = "off"   id="form1" name="uploadForm" action="" 	enctype="multipart/form-data" method="post" onSubmit="return Load()">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="327" border="0" align="center" cellpadding="1" cellspacing="5"
	class="tabledata">
	 
	<tr>
	  <td valign="top">&nbsp;</td>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top">&nbsp;</td>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top">&nbsp;</td>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td width="90" valign="top">Upload Xls File </td>
		<td width="218"><input type="file" name="file" id="file"   /></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;		</td>
	</tr>
	<tr>
		<td colspan="2">
		<table width="56" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td><input name="Submit" type="submit" class="buttonbold"
					value="Upload"></td>
			</tr>
		</table>		</td>
	</tr>
</table>
</form>
</body>
