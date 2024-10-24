 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />

<!doctype html>
<html lang=''>
<head>
   <meta charset='utf-8'>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="styles.css">
   <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
   <title>CSS MenuMaker</title>
</head>

   
<br /><br /> 
<%
	Connection con ;
	Statement st=null; 
	ResultSet rs;
	ResultSet rsMenu;
	
	String str=null;
	String url=null;
	String mnuList=null;
	boolean closetag=false;
	boolean subclosetag=false;
	String lastmname=null;
	int norootmenu=0;
	int top=0;
	int left=0;
	int dynwidth=0;
 //9865043008
 		 con =conbean1.getConnection();
 		 st=con.createStatement(); 
		 str="select CHR_MENUATTENDANCE from  m_user  where CHR_USRNAME='ADMIN'" ;
	     rs=st.executeQuery(str); 
	     if(rs.next())
	     {		
		 	 boolean currentflag = false;
			 boolean nextflag = false;
			 out.println("<div id='cssmenu'>");
		 	 out.println("<ul>");
	    	 mnuList=rs.getString("CHR_MENUATTENDANCE");
		     str="Select * from  m_menu_attendance  where  INT_MENUID >0 AND INT_MENUID in ("+mnuList+") order by INT_MENUID";
			 out.println(str);
		     rsMenu=st.executeQuery(str);
			 String s ="";
			 boolean first = true;
			 System.out.println("");
			 System.out.println("");
			 
		     while(rsMenu.next())
			 {		    	 		 
	       		 String mnuType=rsMenu.getString("CHR_MENUDES");
	       		 str=(rsMenu.getString("CHR_MENUNAME")).toUpperCase();
	       		 
				 if(mnuType.equals("Root"))
				 	currentflag = true;
				 else 
	       		 	currentflag = false;
	       		
				 
				 if(!rsMenu.isLast())
				 {	 
	       		 	rsMenu.next();
				    mnuType=rsMenu.getString("CHR_MENUDES");
				  	if(mnuType.equals("Root"))
				 		nextflag = true;
				 	else 
	       		 		nextflag = false;
						
					rsMenu.previous();	
					 
 				 }	
 				  
				  //System.out.println(rsMenu.getString("INT_MENUID")+"/"+ currentflag +"/" + nextflag +"/" +rsMenu.isLast());
				// System.out.println("============================");
				 
				 System.out.println(rsMenu.getString("INT_MENUID"));
				 
				 //root  root 
				 if(currentflag && nextflag)  
				 	out.println("\n <li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li>");
				 //root  !=root
				 else if(currentflag && nextflag == false)  
				 	out.println("\n<li class='active has-sub'><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a> <ul>");
				 //! = root  root
				 else if(currentflag == false && nextflag)  
				    out.println("\n<li class='active'><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li></ul></li>");
				 //!=root  	 // !=root
			  	 else if(currentflag == false && nextflag == false)  
				  out.println("\n<li class='active'><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li>");
				 
				 
				 
				 
				 if(   rsMenu.isLast() )
				 {
				 	 
						mnuType=rsMenu.getString("CHR_MENUDES");
				  		if(!mnuType.equals("Root"))
						 out.println("\n</ul></li>");	
				 
				 }	
				 
				  
				   
				 //if(!rsMenu.isLast())
				  //rsMenu.previous();
				  
				  	
		     }
		     out.println("<br><br></ul>");
			 out.println("</div>");
	     }
%> 
 