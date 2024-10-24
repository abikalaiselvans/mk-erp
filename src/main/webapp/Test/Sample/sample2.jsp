<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.sample.Sample"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<%
		String filename = request.getRealPath("/")+"persons.txt";
		List pDetails = null;
		FileInputStream fis = null;
		ObjectInputStream in = null;
		try 
		{
			fis = new FileInputStream(filename);
			in = new ObjectInputStream(fis);
			pDetails = (ArrayList) in.readObject();
			in.close();
		} 
		catch (IOException ex) 
		{
			System.out.println(ex.getMessage());
			ex.printStackTrace();
			
		} 
		catch (ClassNotFoundException ex) 
		{
			System.out.println(ex.getMessage());
			ex.printStackTrace();
		}
		// print out the size
		out.println("Person Details Size: " + pDetails.size());
		
		
		 for( Object p: pDetails)
        {
			Sample person1 = (Sample)p;
            out.println("<br>"+person1.getName() +"/"+person1.getAge()+"/"+person1.getDepartment());
        } 
		System.out.println();
		
%>

</body>
</html>
