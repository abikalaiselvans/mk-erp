<%@ page import="java.sql.*" %>	
<%@ page import="java.io.*" %>
<%@page import="DBConnection.DBCon"%>
 
<%
DBCon sc = new DBCon();
Connection con = sc.getConnection();
InputStream sImage;

ServletOutputStream o = response.getOutputStream();
ResultSet rs =null;
Blob image=null;
PreparedStatement psmnt =null;

try{
psmnt = con.prepareStatement("SELECT IMG_IMAGE FROM com_m_staff WHERE CHR_EMPID= ?");

psmnt.setString(1, "ADMIN");
rs = psmnt.executeQuery();
if (rs.next()) {
image = rs.getBlob(1);
} else {
response.setContentType("text/html");
out.println("<html><head><title>Display Blob Example</title></head>");
out.println("<body><h4><font color='red'>image not found for given id</font></h4></body></html>");
return;
}
response.setContentType("image/gif");
InputStream in = image.getBinaryStream();
int length = (int) image.length();
int bufferSize = 1024;
byte[] buffer = new byte[bufferSize];
while ((length = in.read(buffer)) != -1) {
o.write(buffer, 0, length);
}
in.close();
o.flush();
}
catch(Exception ex){
out.println("error :"+ex);
}

finally {
// close all the connections.
rs.close();
psmnt.close();
con.close();
}

%>
