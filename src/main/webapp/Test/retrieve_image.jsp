<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<%  

try 
{
	
	String connectionURL = "jdbc:mysql://localhost:3306/smartcampus";
	ResultSet rs = null;
	PreparedStatement psmnt = null;
	InputStream sImage;

	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", .mythra.mart");
	out.println(""+connection);
	Statement st1=con.createStatement();
  	String strQuery = "select IMG_IMAGE from com_m_staff where CHR_EMPID='ADMIN'";
    ResultSet rs1 = st1.executeQuery(strQuery);

/*
	psmnt = connection.prepareStatement("select IMG_IMAGE from com_m_staff where CHR_EMPID=?");
	psmnt.setString(1, "ADMIN");
	out.println(""+psmnt);  
	rs = psmnt.executeQuery();
	if(rs.next()) 
	{
		 byte[] bytearray = new byte[1048576];
		int size=0;
		sImage = rs.getBinaryStream(1);
		response.reset();
		response.setContentType("image/jpeg");
		while((size=sImage.read(bytearray))!= -1 )
		{
			response.getOutputStream().write(bytearray,0,size);
		} 
	}
	
	rs.close();
	psmnt.close();
	connection.close();*/
}
catch(Exception ex)
{
	out.println("error :"+ex);
}
 
%>