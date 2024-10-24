package com.my.org.erp.SmartInventory;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class AccessoriesActionHandler extends AbstractActionHandler 
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
			 
			if ("INVAccessoriesAdd".equals(action))
			{
				String name=request.getParameter("name");
				String Narration =request.getParameter("desc");
				sql = "INSERT INTO inv_m_accessoriesgroup  (CHR_GROUPNAME,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+name+"' , ";
				sql = sql +"'"+Narration+"' , '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				con.close();   
				response.sendRedirect("Smart Inventory/AccessoriesEntry.jsp");
			}
			else if ("INVAccessoriesEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String Narration =request.getParameter("desc");
				 
				sql = "UPDATE  inv_m_accessoriesgroup  SET  " ;
				sql = sql +"CHR_GROUPNAME ='"+name+"' , ";
				 
				sql = sql +"CHR_DESC = '"+Narration+"' WHERE INT_GROUPID= "+id;
				st.execute(sql);
				st.close();
				con.close();   
				response.sendRedirect("Smart Inventory/AccessoriesEntry.jsp");
			}
			else if ("INVAccessoriesDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
					st.execute("DELETE FROM inv_m_accessoriesgroup WHERE INT_GROUPID="+ids[u]);
				st.close();
				con.close();   
				response.sendRedirect("Smart Inventory/AccessoriesEntry.jsp");
			}
			
			st.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

}
