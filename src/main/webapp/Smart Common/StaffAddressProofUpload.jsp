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
	try
	{
	
		if(   checkNullSelect('adressproof','Select Adress Proof','0')
			  && checkNull('F1','Select Address proof ')
			  && findSize('F1','File should be less than 100Kb')
		  )
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

	
	
function findSize(ctr,msg) 
{
    var fileInput =  document.getElementById(ctr);
    try
	{
		var s = parseInt(fileInput.files[0].size);
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
        if( parseInt(fileSize)  <= 1048579)
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



<BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "StaffAddressProofCopy.jsp" METHOD="post" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING STAFF ADDRESS PROOF </B></td></tr>
			   <tr>
			     <td><strong>Address Proof</strong></td>
			     <td><select name="adressproof" id="adressproof" class="formText135" >
<option value="0">Select</option>

<%
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ADDRESSPROOFID,CHR_PROOFCODE, CHR_PROOFNAME FROM com_m_addressproof  ORDER BY CHR_PROOFNAME");
for(int h=0;h<data.length;h++)
	out.print("<option value='"+data[h][1]+"'>"+data[h][2]+"</option>");
		
  %>
</select></td>
		     </tr>
			   <tr>
			     <td><b>Staff Id / Name </b></td>
			     <td><b><%=request.getParameter("staffid")%>  / <%=CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+request.getParameter("staffid")+"'")[0][0]%><b>
		         <input name="staffid" type="hidden" id="staffid" value="<%=request.getParameter("staffid")%>"></td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file" onChange="LoadImage()"></td></tr>
			   <tr>
			     <td colspan="2"><div align="center"><span class="boldElevenlink">( file should be  800 X 600 Dimension 100 Kb in size) </span></div></td>
		     </tr>
			   <tr>
			     <td colspan="2"><div align="center"><img src="../StaffPhoto/default.jpg"
			width="100" height="130" border="1" id="Photo"  name="Photo" title="Image should be 100 x 130 pixel" /></div></td>
		     </tr>
			   <tr><td colspan="2"><p align="right"><INPUT TYPE="submit" VALUE="Upload File" >
			   </p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>