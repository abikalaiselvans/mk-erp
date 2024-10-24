<%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
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
		if( checkNull('F1','Select Document ') &&  findSize('F1','File should be less than 20Kb') )
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
	catch(err)
	{
		alert(err)
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
		if( s <= 20480)
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
        if( parseInt(fileSize)  <= 40960)
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

<title> :: PAYROLL ::</title>


 
<%
String rowid = ""+request.getParameter("rowid");
String rptodata1[][] =CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,b.INT_EXITID FROM com_m_staff a, pay_t_exitinterview b  WHERE a.CHR_EMPID =b.CHR_EMPID AND b.CHR_STATUS='Y' AND b.INT_EXITID = "+rowid+"  ");
%>
  <BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "CopyExitInterview.jsp?staffid=<%=rptodata1[0][0]%>" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING SCANNED COPY OF EXIT INTERVIEW </B></td></tr>
			   <tr>
			     <td>&nbsp;</td>
			     <td>&nbsp;</td>
		     </tr>
			   <tr>
			     <td><b>Staff Id / Name</b></td>
			     <td><b>
 <%=rptodata1[0][0]%>  / <%=rptodata1[0][1]%></td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file" onChange="LoadImage()"></td></tr>
			   <tr>
			     <td colspan="2"><div align="center" class="boldElevenlink">( file should be doc format &amp; 20Kb in size) </div></td>
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
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>