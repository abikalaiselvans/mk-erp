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
  		if(  checkNullSelect('adressproof','Select Adress Proof','0')
		     && checkNull('file','Select Photo ')
		   )
  		{
			var file = document.getElementById("file").value
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".GIF") ||(Extn == ".gif") ||(Extn == ".JPG") ||(Extn == ".jpg") ||(Extn == ".BMP") ||(Extn == ".bmp"))
			{
				var query="StaffAddressProofCopy.jsp?staffid=" +document.getElementById("staffid").value+"&aid="+ document.getElementById("adressproof").value;
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
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
<body onpaste="return false;" bgcolor="#b7e9ff">
<form AUTOCOMPLETE="off" id="form1" name="uploadForm" action=" "
	enctype="multipart/form-data" method="post" onSubmit="return Load()">
<table width="327" border="0" cellpadding="1" cellspacing="5"
	class="tabledata">
	<tr>
		<td>Staff Id</td>
		<td><%=request.getParameter("staffid")%> <input type="hidden"
			name="staffid" value="<%=request.getParameter("staffid")%>"></td>
	</tr>
	<tr>
		<td valign="top">Address Proof</td>
		<td><select name="adressproof" id="adressproof"
			class="formText135">
			<option value="0">Select</option>

			<%
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ADDRESSPROOFID,CHR_PROOFCODE, CHR_PROOFNAME FROM com_m_addressproof  ORDER BY CHR_PROOFNAME");
for(int h=0;h<data.length;h++)
	out.print("<option value='"+data[h][1]+"'>"+data[h][2]+"</option>");
		
  %>
		</select></td>
	</tr>
	<tr>
		<td width="90" valign="top">Staff Profile</td>
		<td width="218"><input type="file" name="file" id="file"
			onChange="LoadImage()" /></td>
	</tr>
	<tr>
		<td height="110" colspan="2">
		<div align="center"><img src="../StaffPhoto/default.jpg"
			width="100" height="130" border="1" id="Photo" name="Photo" /></div>
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
