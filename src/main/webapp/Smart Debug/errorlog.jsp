<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date date = new java.util.Date(); 
String updatedate = "" + datetime.format(date);
DataInputStream dis = new DataInputStream(new BufferedInputStream(new FileInputStream(request.getRealPath("")+"/log/"+updatedate+".txt")));
String line;
while ((line = dis.readLine()) != null) 
{
	out.println(line+"<br><br>");
}
dis.close();
 %>