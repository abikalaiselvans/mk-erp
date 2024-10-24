<%@ page import="java.sql.*,java.util.*,java.io.*" %>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />

<table width="100%" border="0"   class="headerBackground" >
<td>
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
	String uname=""+session.getAttribute("USRID");	
	if(uname.equals("null")) response.sendRedirect("../Login.jsp?loginmsg=Your Login Session has Expired");
%>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <script language="JavaScript" src="../JavaScript/menu.js"></script>
<script language="JavaScript">
<% 	
		 con =conbean1.getConnection();
 		 st=con.createStatement(); 
		 str="select CHR_MENUMARKETING from  m_user  where CHR_USRNAME='"+uname+"'" ;
	     rs=st.executeQuery(str); 
	     if(rs.next())
	     {		
	    	 mnuList=rs.getString("CHR_MENUMARKETING");
	    	 str="Select * from  m_menu_marketing  where  INT_MENUID >0 AND INT_MENUID in ("+mnuList+") order by INT_MENUID";
		     rsMenu=st.executeQuery(str);
%>		   
var menuitems=[ ["",null,null,,null],["",null,null,,null],
<%
		     while(rsMenu.next()){		    	 		 
	       		 String mnuType=rsMenu.getString("CHR_MENUDES");
	       		 str=(rsMenu.getString("CHR_MENUNAME")).toUpperCase();
	       		 if(mnuType.equals("Root")){	       			 
	       			norootmenu=norootmenu+1; 
					if(closetag) {
%>						],  <%					     
					}
					closetag=true;
%>				 ["<%=str%>",null,null,         <%
	       		 }
	       		else if(mnuType.equals("SubRoot")){
	       			if(subclosetag==false){
%>["<%=str%>",null,null, <%
	       			}
	       			subclosetag=true;
	       		}
	       		else if(subclosetag==true){
	       			url=rsMenu.getString("CHR_URL");
%>["<%= str %>","<%= url %>",null],    <%
					if(mnuType.equals("EndSubRoot")){
%>],  <%
					subclosetag=false;
					}
	       		}	       		 
	       		 else{
		       		 lastmname=mnuType;	       			 
					url=rsMenu.getString("CHR_URL");
					%>["<%= str %>","<%= url %>",null],<%
	       		 }
		     }
	     }
%>],["",null,null,null],];
<%
//["",null,null,null],
   top=90;
   norootmenu=norootmenu-1;
// left=(1024-(norootmenu*170))/2;	
   left=0;
%>
var MENU_POS = [{
	// item sizes
	'height': 24,
	'width': 300,
	// menu block offset from the origin:
	//	for root level origin is upper left corner of the page
	//	for other levels origin is upper left corner of parent item
	'block_top': <%= top%>,
	'block_left': <%= left %>,
	// offsets between items of the same level
	'top': 0,
	'left': 125	,
	// time in milliseconds before menu is hidden after cursor has gone out
	// of any items
	'hide_delay': 200,
	'expd_delay': 200,
	'css' : {
		'outer' : ['m0l0oout', 'm0l0oover'],
		'inner' : ['m0l0iout', 'm0l0iover']
	}
},{
	'height': 24,
	'width': 250,
	'block_top': 25,
	'block_left': 0,
	'top': 23,
	'left': 0,
	'css' : {
		'outer' : ['m0l1oout', 'm0l1oover'],
		'inner' : ['m0l1iout', 'm0l1iover']
	}
},{
	'block_top': 5,
	'block_left': 160
}
];
 new menu(menuitems, MENU_POS);	
</script>
</td></tr></table>