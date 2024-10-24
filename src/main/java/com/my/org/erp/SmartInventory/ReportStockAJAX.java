package com.my.org.erp.SmartInventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/ReportStock")
public class ReportStockAJAX extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
    public void init(ServletConfig config) throws ServletException {        
                     
    }   
    
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
		try{
			String action=request.getParameter("actionS");	
		    
			if(action.equals("INVSalesOrder"))
			{
			/*
			 * 
			 * 
			 * 
			 * Coding here 
			 * 
			 */ 	    
			}	
		 
			
		} catch (Exception e) {
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}			
    }
   
}
    
   