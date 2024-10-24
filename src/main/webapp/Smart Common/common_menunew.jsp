<!doctype html>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />

<html lang=''>
<head>
   <meta charset='utf-8'>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Menu_styles.css">
   <script src="../JavaScript/jquery/jquery-1.7.1.js"  type="text/javascript"></script>
   <script src="Menu_script.js"></script>
<%
	Connection con ;
	Statement st=null; 
	ResultSet rs;
	ResultSet rsMenu;
	
	String str=null;
	String mnuList=null;
	boolean closetag=false;
	String lastmname=null;
	int norootmenu=0;
	int top=0;
	int left=0;
	String uname=""+session.getAttribute("USRID");
	if(uname.equals("null")) response.sendRedirect("../Login.jsp?loginmsg=Your Login Session has Expired");

%>
 
	<%
	 	 con =conbean1.getConnection();
 		 st=con.createStatement(); 
		 str="select CHR_MENUCOMMON from  m_user  where CHR_USRNAME='"+uname+"'" ;
	     rs=st.executeQuery(str); 
	     if(rs.next())
	     {		
		 	 boolean currentflag = false;
			 boolean nextflag = false;
			 out.println("<div id='cssmenu'>");
		 	 out.println("<ul>");
	    	 mnuList=rs.getString("CHR_MENUCOMMON");
		     str="Select * from  m_menu_common  where  INT_MENUID >0 AND INT_MENUID in ("+mnuList+") order by INT_MENUID";
			 rsMenu=st.executeQuery(str);
			 String s ="";
			 boolean first = true;
			 
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
				 
			 
				  
				  	
		     }
		     out.println("</ul>");
			 out.println("</div>");
	     }
	%>	 
  
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
