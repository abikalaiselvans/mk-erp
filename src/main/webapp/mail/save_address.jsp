<%@ page language="java" import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement,java.util.Enumeration,java.util.Hashtable" %>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application"/>
<%
String userid=(String)session.getValue("UserID");
if(userid==null)
	{%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
		}else{%>

<%!
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;
	boolean flag=false;
%>

<%

String mode = request.getParameter("address");

if((mode!=null) && mode.equals("quick"))
{
		try
		{
			if (pool.getSize()==0)
			{
				pool.setSize(10);
				pool.initializePool();
			}
			con=pool.getConnection();
			stmt =con.createStatement();
			String login_id = (String)session.getValue("UserID");
			if(login_id==null)
			{
			response.sendRedirect("/default.jsp");
			}
	
			String fname=request.getParameter("fname");
			String lname=request.getParameter("lname");
			String nname=request.getParameter("nname");
			String p_email=request.getParameter("p_email");
			
			rs=stmt.executeQuery("select p_email,nname,login_id from tbladdress_book where (p_email='"+p_email.toLowerCase()+"' and nname='"+nname.toLowerCase()+"' and login_id='"+login_id+"')");
								
			if(rs.next())
			
				{ 				
				response.sendRedirect("view_address.jsp?mesg=E-MailID and Nick Name are same! Already Registered :Try Another One!!");
				}
				else 
				{
					rs=stmt.executeQuery("select login_id,p_email from tbladdress_book where (login_id='"+login_id+"' and p_email='"+p_email.toLowerCase()+"')");
					if(rs.next())
					{
						response.sendRedirect("view_address.jsp?mesg= E-Mail ID Already Registered :Try Another One!!");
					}
					else
					{
							rs=stmt.executeQuery("select login_id,nname from tbladdress_book where (login_id='"+login_id+"' and nname='"+nname.toLowerCase()+"')");
							if(rs.next())
							{
							response.sendRedirect("view_address.jsp?mesg=Nick Name Already Registered :Try Another One!!");
							}
								else
								{
								stmt.executeUpdate("insert into tbladdress_book(aid,fname,lname,nname,p_email,login_id) values(AID.NEXTVAL,'"+fname+"','"+lname+"','"+nname.toLowerCase()+"','"+p_email.toLowerCase()+"',"+login_id+")");
								flag=true;
								}
							
						}	
					}
				
				
		//out.println("<center><font face=arial size=2 color=red>Address Book Inserted</font></center>");
		//out.println("<br><center><font face=verdana size=2 color=blue><A HREF=/ayushman_mail/address/view_address.jsp>View Contacts</a></font></center>");
		//out.println("<br><center><font face=verdana size=2 color=blue><A HREF=/ayushman_mail/address/insert_address.jsp>Insert Addresses</a></font></center>");
				
		}
		catch(Exception e)
		{
		out.println(e);
		}
		finally
		{
			stmt.close();
			try
			{
			if (con!=null)
			{	
				pool.releaseConnection(con);
			}
			}
			catch(Exception e)
			{	
			out.println(e);
			}
		}
	
	if(flag==true)
	{
	//response.sendRedirect("view_address.jsp?mesg=Address book inserted successfully");
		response.sendRedirect("insert_address.jsp?mesg=Address book inserted successfully");
	}
	 
}
else
	{	
		%>
		<%!
		String[] param_names={"nname","fname","lname","p_email","w_email","o_email","p_phone","b_phone","mobile","fax","paddress","pcity","pstate","pcountry","baddress","bcity","bstate","bcountry","bdate","bmonth","byear"};
		%>
		<%
			String login_id = (String)session.getValue("UserID");
			

			if(login_id==null)
			{
				response.sendRedirect("/default.jsp");
			}
			Enumeration enumer=request.getParameterNames();
			Hashtable values = new Hashtable();
			String param_name="";
			while(enumer.hasMoreElements())
			{
				param_name=(String)enumer.nextElement();
				values.put(param_name,request.getParameter(param_name));
			}
   
			try
				{
					if (pool.getSize()==0)
					{
						pool.setSize(10);
						pool.initializePool();
					}
					con=pool.getConnection();
					stmt =con.createStatement();

					String main_query="insert into tbladdress_book";
					String table_fields="(aid";
					String table_values="(AID.NEXTVAL";
					String value="";
					String birth_date="";

					for(int i=0;i<param_names.length;i++)
					{
						value=(String)values.get(param_names[i]);

						if(!(value).equals(" "))
						{
							if((param_names[i].equals("bdate"))||(param_names[i].equals("bmonth")))
							{
			
							birth_date=birth_date+value;
			
							}
							else
							if(param_names[i].equals("byear"))
							{
	
							table_fields=table_fields+",bdate";
							birth_date=birth_date+value;
							table_values=table_values+",'"+birth_date+"'";
				
							}
							else
							{
								table_fields=table_fields+","+param_names[i];
								table_values=table_values+",'"+value+"'";
							}
						}
	
					}

				//	out.println(main_query+table_fields+",login_id) values "+table_values+","+login_id+")");
				stmt.executeUpdate(main_query+table_fields+",login_id) values "+table_values+","+login_id+")");
				//out.println("<center><font face=arial size=2 color=red>Address Book Inserted</font></center>");
				//ut.println("<br><center><font face=verdana size=2 color=blue><A HREF=/ayushman_mail/address/view_address.jsp>View Contacts</a></font></center>");
				//out.println("<br><center><font face=verdana size=2 color=blue><A HREF=/ayushman_mail/address/insert_address.jsp>Insert Addresses</a></font></center>");

				}
				catch(Exception e)
				{
					out.println(e);
				}
				finally
				{
					stmt.close();
					try
					{
						if (con!=null){	pool.releaseConnection(con);}
					}
					catch(Exception e)
					{	
						out.println(e);
					}
				}
				if(flag==true)
				{
					response.sendRedirect("view_address.jsp");
				}
	}
		}
%>