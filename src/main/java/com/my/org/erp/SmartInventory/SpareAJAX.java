package com.my.org.erp.SmartInventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/Spare")
public class SpareAJAX extends HttpServlet
{ 
	

	private static final long serialVersionUID = 1L;
	 
    public SpareAJAX() 
    {
		super();
		 
		 
	}
    
    public void init(ServletConfig config) throws ServletException 
    {        
        try
        {
          
        }
        catch(Exception e)
        {
        	 
        	 
        }   
    }   
 
    
 
    
    
    
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
		try
        {
			String action=request.getParameter("actionS");	
			action=action.trim();
			 
			 
			if(action.equals("LoadSpareGroup")) 
			{	
				SpareMethod.LoadSpareGroup(request, response);
			} 
			else if(action.equals("LoadSpare"))
			{
				SpareMethod.LoadSpare(request,response);		
			}
			else if(action.equals("loadSparePurchase"))
			{
				SpareMethod.loadSparePurchase(request,response);		
			}
			else if(action.equals("LoadSpareAssign"))
			{
				SpareMethod.LoadSpareAssign(request,response);		
			}
			
			 
 		} 
		catch (Exception e) 
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}			
    }
    

}
 



