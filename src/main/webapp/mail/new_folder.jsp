<%@ page language="java"  import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,java.sql.*" %> 
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application" />
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<%!String[]  mon={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};%>

<%
String userid=(String)session.getValue("UserID");
String foldername=request.getParameter("foldername");
Connection con=null;
Statement stmt=null;
%>


<%
int cnt=0;
String host = mail.exchangeServer;
		String username = (String)session.getValue("ID");
		String password = (String)session.getValue("password");
String redirect=request.getParameter("redirect");
out.println("The redirect is:"+redirect);
// Create empty properties
Properties props = new Properties();

// Get session
Session sess = Session.getDefaultInstance(props, null);

// Get the store
Store store = sess.getStore("imap");
store.connect(host, username, password);
Folder folder = store.getFolder(foldername);
String error="The folder name <b>"+foldername+"</b> already exists<br><br> Please Try some other name";
if(folder.exists())
 {
	if(redirect!=null){ %>
		<jsp:forward page="newfolder.jsp" >
		<jsp:param name="error" value="<%=error%>"/>
		</jsp:forward>
	<%}else{%>

			<jsp:forward page="read_mail.jsp" >
			<jsp:param name="error" value="<%=error%>"/>
			</jsp:forward>
<%		}
	}
else{             folder.create(0);
try	{
		if(pool.getSize()==0){
			pool.setSize(10);
			pool.initializePool();
		}
		con=pool.getConnection();
		stmt = con.createStatement();
		stmt.executeUpdate("insert into tblmail_folder values("+userid+",'"+foldername+"')");
		Vector vector = (Vector) session.getValue("FolderName");
		if(vector==null)
		{
			vector= new Vector();
		}
		vector.addElement(foldername);
		session.putValue("FolderName",vector);
		if(redirect!=null)
		{
			response.sendRedirect(redirect);
		}
		else
		{%>
		<jsp:forward page="read_mail.jsp"/>	
		<%}
}catch(Exception e){out.println("error"+e);}
finally{
if(stmt!=null)
	{
stmt.close();
}
if(con!=null)
	{
pool.releaseConnection(con);
}
}
}


// Get folder
%>
