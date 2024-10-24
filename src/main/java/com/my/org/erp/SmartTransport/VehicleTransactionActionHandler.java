package com.my.org.erp.SmartTransport;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class VehicleTransactionActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			if ("MGTVehicleTransactionEdit".equals(action))
			{ 
				String id=request.getParameter("id");
				String vehicle= request.getParameter("vehicle");
				String entrydate= request.getParameter("entrydate");
				String accessories[]= request.getParameterValues("accessories");
				String s="";
				for(int u=0;u<accessories.length;u++)
					s = s+accessories[u]+",";
				String desc= request.getParameter("desc");
				String price= request.getParameter("price");
				//vechicleid,dat,accessid,des,amount,userid 
				CallableStatement cs = con.prepareCall("{call AUTO_PRO_TRANSACTION(?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, vehicle);
				cs.setString(4, com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(entrydate));
				cs.setString(5, s);
				cs.setString(6, desc);
				cs.setString(7, price);
				cs.setString(8, user); 
				cs.execute();
				response.sendRedirect("Smart Management/VehicleTransaction.jsp");
			}
			else if ("MGTVehicleTransactionAdd".equals(action))
			{
				 
				String vehicle= request.getParameter("vehicle");
				String entrydate= request.getParameter("entrydate");
				String accessories[]= request.getParameterValues("accessories");
				String s="";
				for(int u=0;u<accessories.length;u++)
					s = s+accessories[u]+",";
				String desc= request.getParameter("desc");
				String price= request.getParameter("price");
				//vechicleid,dat,accessid,des,amount,userid 
				CallableStatement cs = con.prepareCall("{call AUTO_PRO_TRANSACTION(?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, vehicle);
				cs.setString(4, com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(entrydate));
				cs.setString(5, s);
				cs.setString(6, desc);
				cs.setString(7, price);
				cs.setString(8, user); 
				cs.execute();
				response.sendRedirect("Smart Management/VehicleTransactionAction.jsp?action1=Add");
			}
			else if ("MGTVehicleTransactionDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call AUTO_PRO_TRANSACTION(?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) 
				{
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.addBatch();
				}
				cs.executeBatch();
				response.sendRedirect("Smart Management/VehicleTransaction.jsp");
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
