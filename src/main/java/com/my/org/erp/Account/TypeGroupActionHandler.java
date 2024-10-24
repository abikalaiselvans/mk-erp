package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class TypeGroupActionHandler extends AbstractActionHandler 
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
			if ("ACCTypeGroupAdd".equals(action))
			{
				String name=request.getParameter("name");
				String type=request.getParameter("type");
				
				sql = "INSERT INTO accc_m_typegroups  (INT_TYPEID,CHR_TYPEGROUPNAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +""+type+" , ";
				sql = sql +"'"+name+"' , ";
				sql = sql +" '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/TypeGroup.jsp");
			}
			else if ("ACCTypeGroupEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String type=request.getParameter("type");
				
				sql = "UPDATE  accc_m_typegroups  SET  " ;
				sql = sql + "INT_TYPEID="+type+", ";
				sql = sql +"CHR_TYPEGROUPNAME ='"+name+"'   ";
				sql = sql +" WHERE INT_TYPEGROUPID= "+id;
				st.execute(sql);
				
				st.close();
				response.sendRedirect("Smart Accounts/TypeGroup.jsp");
			}
			else if ("ACCTypeGroupDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
				{
					st.execute("DELETE FROM accc_m_typegroups WHERE INT_TYPEGROUPID="+ids[u]);
				}
				st.close();
				response.sendRedirect("Smart Accounts/TypeGroup.jsp");
			}
			
			st.close();
		} 
		catch (Exception e) 
		{
			 
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

}
