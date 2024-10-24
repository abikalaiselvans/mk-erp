<%@ page language="java"  import="java.util.*,java.sql.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %> 
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application" />
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<%!Statement stmt=null; 
Connection con=null;
%>

<%

Vector Folder_Name = (Vector)session.getValue("FolderName");
Enumeration enume = Folder_Name.elements();
Properties props = new Properties();
Session sess = Session.getDefaultInstance(props, null);
String host = mail.exchangeServer;//String host = "192.168.10.15";//String host = "202.71.144.104";
String username = (String)session.getValue("ID");
String password = (String)session.getValue("password");
Store store = sess.getStore("imap");
String userid=(String)session.getValue("UserID");
Enumeration enumer = request.getParameterNames();
store.connect(host, username, password);
try	{
		if(pool.getSize()==0){
			pool.setSize(10);
			pool.initializePool();
		}
		 Connection con=pool.getConnection();
		  stmt = con.createStatement();
		 Vector vector = (Vector) session.getValue("FolderName");
		  while (enumer.hasMoreElements())
		{
		String folder_name=request.getParameter((String)enumer.nextElement());
		Folder folder = store.getFolder(folder_name);
    	folder.delete(true);
		int i=stmt.executeUpdate("delete from tblmail_folder  where folder_name='"+folder_name+"' and login_id='"+userid+"'");
		vector.removeElement(folder_name);
		}
			 session.putValue("FolderName",vector);
		
		}catch (Exception e){out.println("error"+e);}
		
		finally
		{	
			try
			{
				if(stmt!=null){stmt.close();}
				if (con!=null){	pool.releaseConnection(con);}
			}
			catch(Exception e)
			{
				out.println("Connection close error:"+e);
			}
		}
		
		response.sendRedirect("Manage_Folders.jsp");
%>


