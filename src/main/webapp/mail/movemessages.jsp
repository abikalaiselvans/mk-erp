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
		String _moveFolder = request.getParameter("foldertomove"); 
		String _moveFolder1 = request.getParameter("foldertomove1");
		
		String current_folder=request.getParameter("currentfolder");
		Store store = sess.getStore("imap");
		store.connect(host,username,password);
		Folder folder = store.getFolder(current_folder);

		Folder MoveFolder=null;
		if((_moveFolder!=null)&&!(_moveFolder.equals("empty")))
			{	
		MoveFolder = store.getFolder(_moveFolder);
			}
		if((_moveFolder1!=null)&&!(_moveFolder1.equals("empty")))
			{
		MoveFolder = store.getFolder(_moveFolder1);
			}
		folder.open(Folder.READ_WRITE);
		for(int j=0;j<msgno.length;j++)
			{ 
			 Msgno[j] = Integer.parseInt(msgno[j]);
			}
		javax.mail.Message inbox[]= folder.getMessages(Msgno);
		
		try{
		folder.copyMessages(inbox, MoveFolder);
		}catch(Exception en){out.println("this is the expn:"+en);}
		//MoveFolder.appendMessages(inbox);

		for(int j=0;j<inbox.length;j++)
		{
			inbox[j].setFlag(Flags.Flag.DELETED, true);
		}
       //for loop closing braces 
	  folder.close(true);
	  if(current_folder.equals("trash"))
	  {
		response.sendRedirect("trash.jsp");
	  }
	  else{
		  response.sendRedirect("read_mail.jsp");
		}
		}
	  %>
