<%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
  
 function Load()
  	{
  		 
		if(  findSize('F1','File should be less than 1MB') && checkNull('F1','Select PDF document ')  )
  		{
			var file = document.getElementById("F1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if((Extn == ".PDF") ||(Extn == ".pdf") )
			{
				return true;
			}
			else
			{
				alert("Only possible PDF only");
				return false;
			}
		}
   		else
		{
   			
			return false;
  		}
		
 	}  
	
function findSize(ctr,msg) 
{
    var fileInput =  document.getElementById(ctr);
    try
	{
		var s = fileInput.files[0].size;
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
        alert(fileSize);    
		return false;
    }
}
 </script>
<html>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
<BODY> <FORM name="frm"  ENCTYPE="multipart/form-data" ACTION= "InstallationUpdationUploadDocs.jsp?salesno=<%=request.getParameter("salesno")%>&salesid=<%=request.getParameter("salesid")%>" METHOD="POST" onSubmit="return Load()">
                <br><br><br>
           
		   
		   <table border="0" align="center" cellpadding="5" cellspacing="5"  >
          	   <tr> <td colspan="2"><p align= "center"><B>  UPLOADING INSTALLATION DETAIL </B><strong>DOCUMENTS</strong></td></tr>
			   
			   <tr>
		         <td>&nbsp;</td>
		         <td>&nbsp;</td>
	         </tr>
			     <tr>
			     <td><b>Invoice Number </b></td>
			     <td><b><%=request.getParameter("salesno")%> <b></td>
		     </tr>
			   <tr>
			     <td align="left" valign="top"><b>Shipping Address</b></td>
			     <td align="left" valign="top">
				 <%
				 String sql = " SELECT b.INT_CUSTOMERID , a.CHR_SHIPPING,a.CHR_SHIPPINGADDRESS  ";
				sql = sql + " FROM inv_t_directsales a,inv_m_customerinfo b, inv_m_division c    ";
				sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID    ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID    ";
				sql = sql + " AND a.CHR_INSTALLATION='Y'    ";
				sql = sql + " AND a.CHR_SALESNO ='"+request.getParameter("salesno")+"'";
				String perdata[][]=CommonFunctions.QueryExecute(sql); 
				  
				  sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][0];
	String vendor[][] =  CommonFunctions.QueryExecute(sql);
							  
						  	if("S".equals(perdata[0][1]))
							{
								
						
								 if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						if(!"-".equals(vendor[0][4]))	
							out.println(vendor[0][4]+",<br>");	
						if(!"-".equals(vendor[0][5]))	
							out.println(vendor[0][5]+",<br>");	
							if(!"-".equals(vendor[0][6]))	
							out.println(vendor[0][6]+",<br>");
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");									
										
						 																			
										
						 
							}
							else
							{
								out.println(perdata[0][2]);
							} 
							
						  %>
                              
				  </td>
		     </tr>
			   <tr>
			     <td>&nbsp;</td>
			     <td>&nbsp;</td>
		     </tr>
		 
			   <tr><td><b>Choose the file To Upload:</b></td>
			   <td><INPUT NAME="F1" id="F1"  TYPE="file" ></td></tr>
			   <tr>
			     <td colspan="2"><div align="center" class="boldElevenlink">( file should be PDF format and size within 1MB) </div></td>
		     </tr>
			   
			   <tr><td colspan="2"><p align="center"><INPUT TYPE="submit" VALUE="Upload File" >
			   </p></td></tr>
    </table>
            
     </FORM>
</BODY>
</HTML>