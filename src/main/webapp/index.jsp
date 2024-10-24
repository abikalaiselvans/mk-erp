<style type="text/css">
@import url("JavaScript/SmartStyles.css");
</style>
<p>&nbsp;</p>
<script language="javascript">

function Clear() {          
	var Backlen=history.length;
	if (Backlen > 0) history.go(-Backlen);
}

window.onload = function () { Clear(); }
</script>
<p>
  <%@ page import="java.io.*,java.util.*"%>
  <script language="javascript" src="JavaScript/ClearBrowser.js"></script>
  
  <% 

	
	  
 
/*
try
{
	InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("filename.properties");
	String filename = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/hidden.properties");
	FileWriter fw = new FileWriter(filename);
	BufferedWriter bw = new BufferedWriter(fw);
	bw.write("xccxcxcxzczxcxzczxc");
	bw.close();
	fw.close();
	
    if(null == is)
    	response.sendRedirect("JdbcDriveIntialisation.jsp");
	else
		response.sendRedirect("Login.html");		
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
  
*/


 
try
{
	File f = new File("JDBC.properties");
	System.out.println(f.getAbsolutePath());
	if(f.exists())
		response.sendRedirect("Login.jsp");
	else
		response.sendRedirect("JdbcDriveIntialisation.jsp");
}
catch(Exception e)
{

}
 %> 
  
</p>
<p>&nbsp;</p>
