 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />

<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />

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
		 str="select CHR_MENUINVENTORY from  m_user  where CHR_USRNAME='ADMIN'" ;
	     rs=st.executeQuery(str); 
		 String h="";
	     if(rs.next())
	     {		
		 	 boolean currentflag = false;
			 boolean nextflag = false;
			 h = h+ "<div id='container'  style='width:200px'>";
		 	 
	    	 mnuList=rs.getString("CHR_MENUINVENTORY");
		     str="Select * from  m_menu_asset  where INT_MENUID in ("+mnuList+") order by INT_MENUID";
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
				 	h = h+ "\n<li class=\"dropdown\" ><a data-toggle=\"dropdown\" href='#'>"+str+"</a></li>" ;
				 else if(currentflag && nextflag == false)  
				 	h = h+ "\n<li class=\"dropdown\" ><a data-toggle=\"dropdown\" href='#'>"+str+"<i class='icon-arrow'></i></a>";
				 
				 if(currentflag == false && nextflag == false)  
				 	s = s + "\n<li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li> ";
				 
				 
				 
				 if( (currentflag == false && nextflag  )  || rsMenu.isLast() )
				 {
				 	
					s = s + "\n<li><a href='"+rsMenu.getString("CHR_URL")+"'>"+str+"</a></li> ";
					h = h+ "\n<ul  class='dropdown-menu'>"+s+"\n</ul>" ;
					h = h+ "\n</li>" ;
					s="";
				 }	
				 
				  
				   
				  if(!rsMenu.isLast())
				 	rsMenu.previous();
				  
				  	
		     }
		   
			h = h+ "</div>" ;
	     }
		 
		 out.println(h);
%> 

<script src="js/index.js"></script>