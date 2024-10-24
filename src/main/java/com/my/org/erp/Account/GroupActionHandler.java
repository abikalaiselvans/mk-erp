package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class GroupActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			String sql="";
			Statement st = con.createStatement();
			if ("ACCGroupAdd".equals(action))
			{
				String group=request.getParameter("group");
				String Name=request.getParameter("Name");
				sql = "INSERT INTO acc_m_group  (CHR_GROUPNAME,CHR_GROUP,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+Name+"' , ";
				sql = sql +"'"+group+"' , '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Group.jsp");
			}
			else if ("ACCGroupUpdate".equals(action))
			{
				String group=request.getParameter("group");
				String Name=request.getParameter("Name");
				String Row=request.getParameter("row");
				sql = "UPDATE  acc_m_group  SET  " ;
				sql = sql +"CHR_GROUPNAME ='"+Name+"' , ";
				sql = sql +"CHR_GROUP = '"+group+"' WHERE INT_GROUPID= "+Row;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Group.jsp");
			}
			else if ("ACCGroupDelete".equals(action))
			{
				String ids[] = request.getParameterValues("groupid");
				for(int u=0;u<ids.length;u++)
					st.execute("DELETE FROM acc_m_group WHERE INT_GROUPID="+ids[u]);
				
				st.close();
				response.sendRedirect("Smart Accounts/Group.jsp");
			}
			
			st.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

}
