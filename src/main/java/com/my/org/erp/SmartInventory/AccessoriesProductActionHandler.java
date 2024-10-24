package com.my.org.erp.SmartInventory;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class AccessoriesProductActionHandler extends AbstractActionHandler 
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
			 
			if ("INVAccessoriesProductAdd".equals(action))
			{
				String Group=request.getParameter("Group");
				String name=request.getParameter("name");
				String desc =request.getParameter("desc");
				String amount =request.getParameter("amount");
				
				
				sql = "INSERT INTO inv_m_accessoriesproduct  (INT_GROUPID,CHR_PRODUCTNAME,CHR_DESC,DOU_AMOUNT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+Group+"' , ";
				sql = sql +"'"+name+"' , ";
				sql = sql +"'"+desc+"' , ";
				sql = sql +""+amount+" , '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				con.close();   
				response.sendRedirect("Smart Inventory/AccessoriesProduct.jsp");
			}
			else if ("INVAccessoriesProductEdit".equals(action))
			{
				String id=request.getParameter("id");
				String amount =request.getParameter("amount");
				String Group=request.getParameter("Group");
				String name=request.getParameter("name");
				String desc =request.getParameter("desc");
				 
				sql = "UPDATE  inv_m_accessoriesproduct  SET  " ;
				sql = sql +"INT_GROUPID ='"+Group+"' , ";
				sql = sql +"CHR_PRODUCTNAME ='"+name+"' , ";
				sql = sql +"DOU_AMOUNT ="+amount+" , ";
				sql = sql +"CHR_DESC = '"+desc+"' WHERE INT_PRODUCTID= "+id;
				st.execute(sql);
				st.close();
				con.close();   
				response.sendRedirect("Smart Inventory/AccessoriesProduct.jsp");
			}
			else if ("INVAccessoriesProductDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
					st.execute("DELETE FROM inv_m_accessoriesproduct WHERE INT_PRODUCTID="+ids[u]);
				st.close();
				con.close();   
				response.sendRedirect("Smart Inventory/AccessoriesProduct.jsp");
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
