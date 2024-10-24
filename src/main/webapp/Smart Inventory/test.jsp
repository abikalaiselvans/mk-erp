<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.Context"%>
<%
 try{
	 // Obtain our environment naming context
	Context initCtx = new InitialContext();
	out.println("Enter<br>");
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	
	// Look up our data source
	out.println("Data Sourse<br>");
	DataSource ds = (DataSource)
	  envCtx.lookup("jdbc/JTest");
	
	out.println("Data Sourse Conn<br><hr>"+initCtx.getNameInNamespace()+"<hr><br>");	
	// Allocate and use a connection from the pool
	Connection conn = ds.getConnection();
	out.println("Data Connection Conn<br>");	
	Statement st=conn.createStatement();
	ResultSet rs=st.executeQuery("Select * from com_m_staff");
	while(rs.next())
	{
		//System.out.println("Field 1 :"+rs.getString(2));
	}
	conn.close();
 }
 catch(Exception e)
 {
	 out.println("Error :"+e.getMessage());
	 e.printStackTrace();	
 }
%>

