 
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
	
%>
<% 
	
%>
<html>
<head>

<title> :: UTILITY :: </title>
<%@include file="Redirect.jsp" %>	


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>
<form name="frm" method="post" action="SetRights.jsp">
 <br><br>
<%
try
{

		  Connection con ;
		  Statement st=null; 
		  ResultSet rs; 
		  String sql=null;
		  String userName=null;
		  String mnuVal=null;
		  String fname;
		  userName=""+request.getParameter("UserName");
		  fname=""+request.getParameter("fname");
		  String chkName[]  = request.getParameterValues("mnuSel");
		   
		  if(chkName.length>0)
		  {
		  	for(int i=0;i<chkName.length;i++)
			{
			  if(i==0) 
				  mnuVal=chkName[i];
			  else
				  mnuVal=mnuVal+","+chkName[i];	  			  
		  	}	
		  	
		  	sql ="update  m_user  set "+fname+"=' "+mnuVal+"' where CHR_EMPID='"+userName +"'";
		  }
		  else
		 	sql ="update  m_user  set "+fname+"='0' where CHR_EMPID='"+userName +"'";
		
		con =conbean.getConnection();
		st=con.createStatement();
		st.execute(sql); 
		st.close();
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<p align='center' class='tablesubhead'>User Rights updated Sucessfully</p>");
		out.println("<br>");
		 
		out.println("<p align='center' class='boldThirteen'>Do you set Rights for another user : <a href='UserRights.jsp'>YES</a>/<a href='Userframe.jsp'>NO</a>");
		out.println("<br>");
		out.println("<br>");
		  
}
catch(Exception e)
{
	out.println(e.getMessage());
}		  
		 %>
 </form>
 </body>
</html>

