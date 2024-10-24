 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />
   <link rel="stylesheet" href="styles.css">
   <script src="jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
   
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
		     str="Select * from  m_menu_attendance  where INT_MENUID >0 AND INT_MENUID in ("+mnuList+") order by INT_MENUID";
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
 				 }	
 				  
				 if(currentflag && nextflag)  
				 	out.println("\n <li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li>");
				 else if(currentflag && nextflag == false)  
				 	out.println("\n <li class='active'><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a>");
				 
				 if(currentflag == false && nextflag == false)  
				 	s = s + "\n <li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li> ";
				 
				 
				 
				 if( (currentflag == false && nextflag  )  || rsMenu.isLast() )
				 {
				 	if(!rsMenu.isLast())
					{
						s = s + "\n <li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li> ";
						out.println("\n<ul>"+s+"</ul>");
						s="";
					}
					else
					{
						out.println("\n<ul>"+s+"</ul>");	
					}
				 }	
				 
				  
				   
				  if(!rsMenu.isLast())
				 	rsMenu.previous();
				  
				  	
		     }
		     out.println("</ul>");
			 out.println("</div>");
	     }
%> 

 <br />
    <br />  
 
   <br />