<%@ page language="java" import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement" %>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application"/>
<%!
	Connection con=null;
	Statement stmt=null;

	boolean flag=false;
%>
<%
String login_id = (String)session.getValue("UserID");
	
	if(login_id==null)
		{
		response.sendRedirect("/default.jsp");
		}
int aid=Integer.parseInt(request.getParameter("aid"));
String fname=request.getParameter("fname");
String lname=request.getParameter("lname");
String nname=request.getParameter("nname");
String p_email=request.getParameter("p_email");
String w_email=request.getParameter("w_email");
String o_email=request.getParameter("o_email");
String p_phone=request.getParameter("p_phone");
String b_phone=request.getParameter("b_phone");
String mobile=request.getParameter("mobile");
String fax=request.getParameter("fax");
String paddress=request.getParameter("paddress");
String pcity=request.getParameter("pcity");
String pstate=request.getParameter("pstate");
String pcountry=request.getParameter("pcountry");
String baddress=request.getParameter("baddress");
String bcity=request.getParameter("bcity");
String bstate=request.getParameter("bstate");
String bcountry=request.getParameter("bcountry");
String bday=request.getParameter("bdate");
String bmonth=request.getParameter("bmonth");
String byear=request.getParameter("byear");
String bdate=bday+bmonth+byear;



try{
if (pool.getSize()==0)
	{
		pool.setSize(10);
		pool.initializePool();
	}
con=pool.getConnection();
stmt =con.createStatement();
stmt.executeUpdate("update tbladdress_book set fname='"+fname+"',lname='"+lname+"',nname='"+nname+"',p_email='"+p_email+"',w_email='"+w_email+"',o_email='"+o_email+"',p_phone='"+p_phone+"',b_phone='"+b_phone+"',mobile='"+mobile+"',fax='"+fax+"',paddress='"+paddress+"',pcity='"+pcity+"',pstate='"+pstate+"',pcountry='"+pcountry+"',baddress='"+baddress+"',bcity='"+bcity+"',bstate='"+bstate+"',bcountry='"+bcountry+"', bdate='"+bdate+"',login_id='"+login_id+"' where aid="+aid);
flag=true;
//out.println("<center><font face=arial size=2 color=red>Address Book Updated</font></center>");
}
catch(Exception e)
{
	out.println(e);
}
finally
		{
			if(stmt!=null) stmt.close();
			
			try
			{
				if (con!=null){	pool.releaseConnection(con);}
			}
			catch(Exception e)
			{	
				out.println(e);
			}
		}
%>
<%
if(flag==true)
{
	response.sendRedirect("view_address.jsp?mesg=Address book updated successfully");
}
%>
