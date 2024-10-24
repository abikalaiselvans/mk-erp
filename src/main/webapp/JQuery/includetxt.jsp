<%@ page import="java.io.*" %>
<%
BufferedReader input = new BufferedReader(new FileReader("C://rose.txt"));
String line = "";
while ((line = input.readLine()) != null) {
out.println(line);
}
input.close();
%> 
