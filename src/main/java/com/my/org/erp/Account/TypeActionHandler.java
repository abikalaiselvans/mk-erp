package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class TypeActionHandler extends AbstractActionHandler 
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
			if ("ACCTypeAdd".equals(action))
			{
				String type=request.getParameter("type");
				
				sql = "INSERT INTO accc_m_type  (CHR_TYPENAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+type+"' , ";
				sql = sql +" '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Type.jsp");
			}
			else if ("ACCTypeEdit".equals(action))
			{
				String id=request.getParameter("id");
				String type=request.getParameter("type");
				sql = "UPDATE  accc_m_type  SET  " ;
				sql = sql +"CHR_TYPENAME ='"+type+"'   ";
				sql = sql +" WHERE INT_TYPEID= "+id;
				st.execute(sql);
				
				st.close();
				response.sendRedirect("Smart Accounts/Type.jsp");
			}
			else if ("ACCTypeDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
				{
					st.execute("DELETE FROM accc_m_type WHERE INT_TYPEID="+ids[u]);
				}
				st.close();
				response.sendRedirect("Smart Accounts/Type.jsp");
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
