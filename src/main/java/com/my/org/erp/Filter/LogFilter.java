package com.my.org.erp.Filter;

import java.io.IOException; 
    
import javax.servlet.Filter; 
import javax.servlet.FilterChain; 
import javax.servlet.FilterConfig; 
import javax.servlet.ServletException; 
import javax.servlet.ServletRequest; 
import javax.servlet.ServletResponse; 
import javax.servlet.http.HttpServletRequest;   
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
public class LogFilter implements Filter 
{

	  @SuppressWarnings("unused")
	  private FilterConfig config = null;
	  public void init(FilterConfig config) throws ServletException 
	  {
	    this.config = config;
	  }

	  public void destroy() 
	  {
	    config = null;
	  }

	  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
	  {
		  
		  
	    
	    HttpServletRequest  req = (HttpServletRequest) request;
	    HttpServletResponse  res = (HttpServletResponse) response; 
	    
		 
		boolean f =isAuthenticated((HttpServletRequest)request);
		String action = req.getParameter("filename");
		// System.out.println(""+f);
		// System.out.println(""+action);
		//if( f )
			chain.doFilter(request, response);  
		//else
			//res.sendRedirect("Login.jsp?msg=Not a valid user" );
		 
		
		 
		/*
	    if (request instanceof HttpServletRequest) 
	    {
	      name = ((HttpServletRequest)request).getRequestURI();
	    }
	    config.getServletContext().log(name + ": " + (after - before) + "ms"); 
		*/  
	    
	    
	    
		  	/*HttpServletRequest request = (HttpServletRequest) req; 
			HttpServletResponse response = (HttpServletResponse) res; 
			String action = request.getParameter("filename");
			String Type = ""+request.getParameter("username");
			
			 System.out.println(""+( isAuthenticated(request) || action.equalsIgnoreCase("Login")  || Type.equals("MKS")));
			if( isAuthenticated(request) || action.equalsIgnoreCase("Login")  || Type.equals("MKS"))
				chain.doFilter(request, response);  
			else
				response.sendRedirect("Login.jsp?msg=Not a valid user" );*/
		
	    
	    
	    
	    
	  }
	  
	  public static boolean isAuthenticated(HttpServletRequest request)
	  {
	      HttpSession session = request.getSession();
	      Object object = session.getAttribute("USRID");
	      return object != null;
	  }
}


 