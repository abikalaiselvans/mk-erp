<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="conbean1" class="DBConnection.DBCon" />
<link type="text/css" href="menu.css" rel="stylesheet" />
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="menu.js"></script>
<style type="text/css">
* { margin:0;
    padding:0;
}
body { background:#555 url(images/back.jpg); }
#menu { top:30px; }
#copyright {
    margin:100px auto;
    width:80%;
    font:12px 'Trebuchet MS';
    color:#bbb;
    text-indent:20px;
    padding:40px 0 0 0;
}
#copyright a { color:#bbb; }
#copyright a:hover { color:#fff; }
</style>

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
	con =conbean1.getConnection();
	st=con.createStatement(); 
	str="SELECT CHR_MENUPAYROL FROM  m_user  WHERE CHR_USRNAME='"+uname+"'" ;
	rs=st.executeQuery(str); 
	out.println("<div id='menu'>");
	out.println("<ul class='menu'>");
	out.println("");
	
	if(rs.next())
	{
		mnuList=rs.getString("CHR_MENUPAYROL");
		str="SELECT CHR_MENUDES,CHR_MENUNAME,CHR_URL FROM  m_menu_payroll  WHERE  INT_MENUID >0 AND INT_MENUID IN ("+mnuList+") ORDER BY INT_MENUID";
		rsMenu=st.executeQuery(str);
		while(rsMenu.next())
		{
			String mnuType=rsMenu.getString("CHR_MENUDES");
	       	str=(rsMenu.getString("CHR_MENUNAME")).toUpperCase();
			boolean subroot = false; 
	       	if(mnuType.equals("Root"))
			{
				out.println("<li>");
				out.println("<a href='"+rsMenu.getString("CHR_URL")+"' class='parent'><span>"+rsMenu.getString("CHR_MENUNAME")+"</span></a>");
				out.println("<div><ul>");
				while(rsMenu.next())
                {
				 	   if(!rsMenu.getString("CHR_MENUDES").equals("Root"))
					   {
							out.println("<li>");
							out.println("<a href='"+rsMenu.getString("CHR_URL")+"' class='parent'><span>"+rsMenu.getString("CHR_MENUNAME")+"</span></a></li>");
					   }
					   else
					   {
						   break;
					   }

				}
				out.println("</ul></div>");
				
				 
			}	
			else
			{	
				rsMenu.previous();

			}
		}
		rsMenu.close();
	}
	rs.close();
	con.close();
	out.println("</ul>");
	out.println("</div>");
	out.println("<li><a href='#'><span>Help</span></a></li>");

%>


    <!--
        <li><a href="#" class="parent"><span>Home</span></a>
            <div>
				<ul>
                <li><a href="#"><span>Sub Item 1</span></a></li>
                <li><a href="#"><span>Sub Item 2</span></a></li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
            	</ul>
			</div>
        </li>-->
		
        
        
    


<div id="copyright"><a href="http://apycom.com/"></a></div>

</body>
</html>