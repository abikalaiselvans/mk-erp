<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
try
{
%>
<html>
<head>
<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='DEB' ")[0][0]%></title>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript"> //loadServer()

/*function assign(source) {
  checkboxes = document.getElementsByName('row');
  for each(var checkbox in checkboxes)
    checkbox.checked = source.checked;
}*/
function assign()
{
	//var nocheck=document.frm1.row;
	//alert("work112"+document.frm1.row);
	var val=document.getElementById("all").checked;
	var row2 = document.getElementsByTagName('input');
	//var vro=document.getElementById("row");
	if(val==false)
	{
		for(i=0;i<=row2.length;i++)
		{
			row2[i].checked=false;
		}
	}
	else
	{
		for(i=0;i<=row2.length;i++)
		{		
			row2[i].checked=true;
		}
	}
}



 </script>

 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id ="frm1" method="post" action="../SmartLoginAuth">

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%> </td>
  </tr>
  <tr>
    <td   align="center"><p>&nbsp;</p>
     
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><table width="90%"  border="0" align="center"
			cellpadding="2" cellspacing="2" class="TableDesign"  
			 >
          <tr  >
            <td height="31"  ><div align="center" class="whiteMedium">ERROR LOG FILE LIST</div></td>
          </tr>
          
          <tr class="MRow1">
            <td align="center" valign="top" >
            <div id="table" style="OVERFLOW:auto;width:100%;height:300px"  >  
		<%
		File folder = new File(request.getRealPath("")+"/log/");
		String link="";
		 %>
		 
		 <%
		File[] listOfFiles = folder.listFiles();
		int row1=0;
		if(listOfFiles.length>0)
		{
			 
			out.println("<table width='100%' class='boldEleven'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'> <td class='boldEleven' align='center'><b>S.No</b></td> ");
			out.println("<td class='boldEleven' align='center'><b>File Name</b></td> ");
			out.println("<td class='boldEleven' align='center'><b>Size</b></td> ");
			out.println("<td class='boldEleven' align='center'><b>Date</b></td> ");
			out.println("<td class='boldEleven' align='center'><b>Download</b></td> ");
			out.println("<td class='boldEleven' align='center'><b>  ");
			out.println("<input name='filename' type='hidden' value='Logfile' /> ");
		  	out.println("<input name='actionS' type='hidden' value='DEBLogfile' /> ");
		  	out.println("<input type='submit' id='sub' name='sub' value='Delete'> ");
			out.println("<td class='boldEleven' align='center'><b><input type='checkbox' id='all' name='all' onClick='assign()'>Select All</b></td> ");
			 
			out.println("</tr> ");
			
			for (int i = 0; i < listOfFiles.length; i++) 
			{
				if (listOfFiles[i].isFile()) 
				{
					row1++;
					String fileName = listOfFiles[i].getName();
					File files = new File(request.getRealPath("")+"/log/"+"/"+fileName);
					String downfile = fileName;
					long filesize = files.length();
					long filesizeInKB = filesize / 1024;
					int mid= fileName.lastIndexOf(".");
					String extn=fileName.substring(mid,fileName.length());
					SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy hh:mm:ss aaa");
					link ="../DownloadlogdeleteFile?sessionid="+session.getId()+"&downfile="+downfile;
					if(i%2==0)
						out.println("<tr class='MRow1'>");
					else
		    			out.println("<tr class='MRow2'>");
		 
					
					out.println("<td class='boldEleven'>"+row1+".</td>");
					out.println("<td class='boldEleven'>"+fileName+"</td>");
					out.println("<td class='boldEleven' align='right'>"+filesizeInKB+"KB</td>");
					out.println("<td class='boldEleven'>"+sdf.format(files.lastModified())+"</td>");
					out.println("<td class='boldEleven'><a  href='../DownloadlogFile?sessionid="+session.getId()+"&downfile="+downfile+"' style='text-decoration:none'><font color='Blue'>Download</font></a></td>");
					out.println("<td class='boldEleven'><input type='checkbox' name='row'  id='row' value='"+downfile+"'></td>");
					out.println("<td class='boldEleven'><a  href='"+link+"' style='text-decoration:none'><font color='Blue'>Delete</font></a></td>");
					out.println("</tr>");
				}	
			}
			out.println("</table>");
		}
		%>
        </div> 
              <br></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><table   border="0" align="center" cellpadding="1" cellspacing="1">
        <tr>
          <td width="56"><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Debugmain.jsp')">
		  </td>
        </tr>
      </table>   </td>
      </tr>
      
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%> </td>
  </tr>
</table>
 
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</form>
</body>
</html>

 


