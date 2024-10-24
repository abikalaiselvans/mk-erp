<%@ page import="com.my.org.erp.common.CommonFunctions"%><%
String bid = ""+session.getAttribute("INVBRANCH");
String offid= ""+session.getAttribute("OFFICEID");
String usertype=""+session.getAttribute("USRTYPE");
String empdata[][]= CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T'    ORDER BY CHR_STAFFNAME");
// AND INT_OFFICEID 	=  "+offid+"   
for(int y=0; y<empdata.length;y++)
	out.println("<option  style='height:25' value='"+empdata[y][0]+"' title='"+empdata[y][1]+" / " +empdata[y][0]+ "'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
