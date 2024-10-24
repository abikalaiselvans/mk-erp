package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class CourierActionHandler extends AbstractActionHandler
{
	
	enum ACTION {INVcourierList,INVcourierAdd,INVcourierEdit,INVcourierDelete; } 
	 
	 
	public void CourierAdd(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
		 
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("CourierName");
			asql=" INSERT INTO inv_m_courier "; 
			asql = asql + " (CHR_COURIERNAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?, DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,userid);
			apstm.execute();
			apstm.close();
			
			
			
		}catch(Exception e)
		{
			
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 
		}
	}
	public void CourierEdit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("CourierName");
			String rowid=request.getParameter("CourierId");
			
			asql=" UPDATE inv_m_courier SET ";
			asql = asql + " CHR_COURIERNAME=?, CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_COURIERID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,userid);
			apstm.setString(3,rowid);
			apstm.execute();
			apstm.close();
			
			
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	public void CourierDelete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_courier   WHERE INT_COURIERID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
			apstm.close();
			
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String action=request.getParameter("actionS");
			switch(ACTION.valueOf(action))
			{

					 
		
					case INVcourierAdd:  
										CourierAdd(request,response);
										con.close();    
										response.sendRedirect("Smart Inventory/Courier.jsp");
										break;
										
					case INVcourierEdit:  					
										CourierEdit(request,response);
										con.close();    
										response.sendRedirect("Smart Inventory/Courier.jsp");
										break;
					case INVcourierDelete:  					
										CourierDelete(request,response);
										con.close();   
										response.sendRedirect("Smart Inventory/Courier.jsp");
										break;
			}
			
			
		
			
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
