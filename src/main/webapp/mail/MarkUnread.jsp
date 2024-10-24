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
		//String host = "202.71.144.130";//String host = "192.168.10.15";//		String host = "202.71.144.104";
		String host = mail.exchangeServer;
		String username = (String)session.getValue("ID");
		String password = (String)session.getValue("password");
		String mail_folder=request.getParameter("currentfolder");
	try{
		Store store = sess.getStore("imap");
		store.connect(host,username,password);
		Folder folder = store.getFolder(mail_folder);
		folder.open(Folder.READ_WRITE);
			for(int j=0;j<msgno.length;j++)
				Msgno[j] = Integer.parseInt(msgno[j]);
		javax.mail.Message inbox[]= folder.getMessages(Msgno);
		for(int j=0;j<inbox.length;j++)
		{
			inbox[j].setFlag(Flags.Flag.SEEN, false);
		}

         //for loop closing braces 
	  folder.close(true);
}catch(IndexOutOfBoundsException Excptn)
	{		 
	}
	  if(mail_folder.equals("trash"))
	  {
		  response.sendRedirect("trash.jsp");

	  }
	  else
	  {
		response.sendRedirect("read_mail.jsp");
	  }
	}
%>
