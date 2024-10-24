<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%
Connection con=null;
Statement stm=null;
ResultSet rst=null;
con=conbean.getConnection();
stm=con.createStatement();
String qly="SELECT * FROM m_institution   ";                   
rst=stm.executeQuery(qly);
 
while(rst.next())
{
	out.println("<center> <h3>" + rst.getString(2)+"</h3><center>");	
}
 
%>



