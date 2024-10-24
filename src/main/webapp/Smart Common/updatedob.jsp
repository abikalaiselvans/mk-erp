<%@ page import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	CommonFunctions.Execute("call lockCheckDOB( )") ;
}
catch(Exception e)
{
	out.println(e.getMessage());
	
	 
}
%>
