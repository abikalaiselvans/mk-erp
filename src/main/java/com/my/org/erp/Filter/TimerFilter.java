package com.my.org.erp.Filter;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
/*<filter>
<filter-name>timerFilter</filter-name>
<filter-class>com.my.org.erp.Filter.TimerFilter</filter-class>
</filter>
<filter-mapping>
<filter-name>timerFilter</filter-name>
<url-pattern></url-pattern>
</filter-mapping> */
public class TimerFilter implements Filter 
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
	 
	if( f)
		chain.doFilter(request, response);  
	else
		res.sendRedirect("Login.jsp?msg=Not a valid user" );
	 
	
	 
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



