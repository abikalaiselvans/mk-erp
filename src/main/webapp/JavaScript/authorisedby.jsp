<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<select name="authorised"  id="authorised" class="formText135" style="width:200" > 
<option value="0">Select</option>
<%
String authdata[][]= CommonFunctions.QueryExecute("SELECT  CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_REP='Y' AND CHR_TYPE != 'T' ORDER BY CHR_STAFFNAME ");
for(int h=0;h<authdata.length;h++)
if(authdata[h][0].trim().equals(session.getAttribute("EMPID")))
	out.print("<option selected='selected' value='"+authdata[h][0]+"'>"+ authdata[h][1]+" - "+authdata[h][0]+"</option>");
else
	out.print("<option value='"+authdata[h][0]+"'>"+ authdata[h][1]+" - "+authdata[h][0]+"</option>");
%>

</select>