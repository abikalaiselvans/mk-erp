<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<% // declare a connection by using Connection interface Connection connection = null;
/* Create string of connection url within specified format with machine 
name, port number and database name. Here machine name id localhost 
and database name is mahendra. */
String connectionURL = "jdbc:mysql://localhost:3306/smartcampus";
/*declare a resultSet that works as a table resulted by execute a specified 
sql query. */
ResultSet rs = null;
// Declare statement.
PreparedStatement psmnt = null;
// declare InputStream object to store binary stream of given image.
InputStream sImage;
try {
// Load JDBC driver "com.mysql.jdbc.Driver"
Class.forName("com.mysql.jdbc.Driver").newInstance();
/* Create a connection by using getConnection() method that takes 
parameters of string type connection url, user name and password to 
connect to database. */
connection = DriverManager.getConnection(connectionURL, "root", "mythra");
/* prepareStatement() is used for create statement object that is 
used for sending sql statements to the specified database. */
psmnt = connection.prepareStatement("select IMG_IMAGE from com_m_staff where CHR_EMPID=?");
psmnt.setString(1, "ADMIN"); // here integer number '11' is image id from the table
rs = psmnt.executeQuery();
if(rs.next()) {
byte[] bytearray = new byte[1048576];
int size=0;
sImage = rs.getBinaryStream(1);
response.reset();
response.setContentType("image/jpeg");
while((size=sImage.read(bytearray))!= -1 ){
response.getOutputStream().write(bytearray,0,size);
}
}
}
catch(Exception ex){
out.println("error :"+ex);
}
finally {
// close all the connections.
rs.close();
psmnt.close();
connection.close();
}
%>