
<%
try
{
%>
<jsp:useBean id = "aBean" class = "com.my.org.erp.bean.examples.MyBean" scope = "page" \/> 


<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>