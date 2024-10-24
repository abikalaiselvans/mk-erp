<%@ page language="java"  import="java.util.*,java.sql.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %> 
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application" />
<%

Vector Folder_Name = (Vector)session.getValue("FolderName");
//out.println("Folder_Name-->"+Folder_Name);
Enumeration enume = Folder_Name.elements();
Properties props = new Properties();
Session sess = Session.getDefaultInstance(props, null);
String host = mail.exchangeServer;
String username = (String)session.getValue("ID");
String password = (String)session.getValue("password");
String name=request.getParameter("newname");
out.println("name-->"+name);
String oname=request.getParameter("oldname");
out.println("oldname-->"+oname);
Store store = sess.getStore("imap");
store.connect(host, username, password);
Connection con=null;
Statement stmt = null;
		
try	{
		if(pool.getSize()==0){
			pool.setSize(1);
			pool.initializePool();
		}
		  con=pool.getConnection();
		  stmt = con.createStatement();
		
		 
		 Folder folder = store.getFolder(oname);

		 Folder folder_n = store.getFolder(name);
		// folder.close(true);
		 boolean flag=folder.renameTo(folder_n);
		 if(flag==true)
		{
			 //out.println("Inside If ");
			  int i=stmt.executeUpdate("update tblmail_folder set folder_name ='"+name+"' where folder_name='"+oname+"'");

			  Vector vector = (Vector) session.getValue("FolderName");
			 vector.removeElement(oname);
			 vector.addElement(name);
			 session.putValue("FolderName",vector);
		}
		 out.println(flag);
		}catch (Exception e)
		{
			out.println("Anand::::"+e);
		}
		finally{
		if(stmt!=null) stmt.close();
		if (con!=null) pool.releaseConnection(con);
		}

		response.sendRedirect("Manage_Folders.jsp");
%>


