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
		if( s <= 40960)
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

<title> :: MARKETING ::</title>

 
  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "SFAUploadCopys.jsp?staffid=<%=request.getParameter("rowid")%>&fileExtn=.pdf" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="2" cellspacing="2"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING
               
               <%
			   String sql ="";
			   String rowid = request.getParameter("rowid");
			   sql = " SELECT d.CHR_NAME,b.CHR_ALIAS,b.CHR_CONTACTPERSON,c.CHR_CALLTYPE,a.CHR_DESC ";
			   sql = sql + " FROM mkt_t_daillycalls a, mkt_m_customerinfo b, mkt_k_calltype c , mkt_m_customername d";
			   sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID  ";
			   sql = sql + " AND a.CHR_CALLTYPE=c.INT_CALLTYPEID AND b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID";
			   sql = sql + " AND INT_CALLID = "+rowid;
			   //out.println(sql);
			   String ctdata[][]= CommonFunctions.QueryExecute(sql);
			   %>
                 </B></td></tr>
			   <tr>
			     <td><b>Agenda</b></td>
			     <td><b><%=ctdata[0][0]%> <b></td>
		     </tr>
			   <tr>
			     <td><b>Company / Contact</b></td>
			     <td><%=ctdata[0][1]%> /<%=ctdata[0][2]%></td>
		     </tr>
			   <tr>
			     <td>Call Type</td>
			     <td><%=ctdata[0][3]%></td>
		     </tr>
			   <tr>
			     <td>Description</td>
			     <td><%=ctdata[0][4]%></td>
		     </tr>
			   <tr>
			     <td>&nbsp;</td>
			     <td>&nbsp;</td>
		     </tr>
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file"  ></td></tr>
			   <tr>
			     <td colspan="2"><div align="center" class="boldElevenlink">( file should be pdf format &amp; 40Kb in size) </div></td>
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