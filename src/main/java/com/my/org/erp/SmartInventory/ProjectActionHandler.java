package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class ProjectActionHandler extends AbstractActionHandler
{
	
	enum ACTION {INVcolorList,INVProjectAdd,INVProjectEdit,INVProjectDelete; } 
	 
	 
	public void ProjectAdd(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
		 
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("projectname");
			String status = request.getParameter("status");

			asql=" INSERT INTO inv_m_project "; 
			asql = asql + " (CHR_PROJECTNAME,CHR_STATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?,?, DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,status);
			apstm.setString(3,userid);
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
	public void ProjectEdit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("projectname");
			String rowid=request.getParameter("projectid");
			String status=request.getParameter("status");
			asql=" UPDATE inv_m_project SET ";
			asql = asql + " CHR_PROJECTNAME=?,CHR_STATUS=?, CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_PROJECTID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,status);
			apstm.setString(3,userid);
			apstm.setString(4,rowid);
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
	public void ProjectDelete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{

			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_project   WHERE INT_PROJECTID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
			apstm.close();
			
			 
			
		}catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String action=request.getParameter("actionS");
			switch(ACTION.valueOf(action))
			{

					 
		
					case INVProjectAdd:  
										ProjectAdd(request,response);
										con.close();    
										response.sendRedirect("Smart Inventory/ProjectView.jsp");
										break;
										
					case INVProjectEdit:  					

										ProjectEdit(request,response);
										con.close();    
										response.sendRedirect("Smart Inventory/ProjectView.jsp");
										break;
					case INVProjectDelete:  					
										ProjectDelete(request,response);
										con.close();   
										response.sendRedirect("Smart Inventory/ProjectView.jsp");
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
