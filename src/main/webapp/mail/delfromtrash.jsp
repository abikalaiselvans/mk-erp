<%@ page language="java"  import="java.io.*, java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<%String userid=(String)session.getAttribute("UserID");
if(userid==null)
	{%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
		}else{
Properties props = new Properties();

// Get session
		String [] msgno=request.getParameterValues("msgno");
		int [] Msgno= new int [msgno.length];
		Session sess = Session.getDefaultInstance(props, null);
		String host = mail.exchangeServer;
		String username = (String)session.getValue("ID");
		String password = (String)session.getValue("password");
		Store store = sess.getStore("imap");
		store.connect(host,username,password);
		Folder folder = store.getFolder("Trash");
		folder.open(Folder.READ_WRITE);
		for(int j=0;j<msgno.length;j++)
		Msgno[j] = Integer.parseInt(msgno[j]);
		javax.mail.Message inbox[]= folder.getMessages(Msgno);
		for(int j=0;j<inbox.length;j++)
		{
			inbox[j].setFlag(Flags.Flag.DELETED, true);
		}

         //for loop closing braces 
	  folder.close(true);
response.sendRedirect("trash.jsp");
}
%>
