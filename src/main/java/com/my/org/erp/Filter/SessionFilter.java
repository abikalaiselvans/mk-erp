package com.my.org.erp.Filter;

import java.io.IOException; 
import java.util.ArrayList; 
import java.util.StringTokenizer;   
import javax.servlet.Filter; 
import javax.servlet.FilterChain; 
import javax.servlet.FilterConfig; 
import javax.servlet.ServletException; 
import javax.servlet.ServletRequest; 
import javax.servlet.ServletResponse; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;   

import com.my.org.erp.common.CommonFunctions;

public class SessionFilter implements Filter 
{       
	private ArrayList<String> urlList;       
	String avoid_urls=null; 
	public void destroy() {     }       
	
	public void doFilter(ServletRequest req, ServletResponse res,  FilterChain chain) throws IOException, ServletException 
	{           
		HttpServletRequest request = (HttpServletRequest) req;         
		HttpServletResponse response = (HttpServletResponse) res;         
		String url = request.getServletPath();         
		boolean allowedRequest = false;  
		
		//thirunelveli-627006,bharathi st
		/*int slashIndex = url.lastIndexOf('/');
		int dotIndex = url.lastIndexOf('.', slashIndex);
		String filename ;
		if (dotIndex == -1)
		{
		  filename  = url.substring(slashIndex + 1);
		}
		else
		{
		  filename  = url.substring(slashIndex + 1, dotIndex);
		}

		
		
		if(urlList.contains(url)) 
		{             
			allowedRequest = true;         
		} 
		
		
		if (!allowedRequest) 
		{             
			HttpSession session = request.getSession(false); 
			if (null == session.getAttribute("EMPID")) 
			{                 
				response.sendRedirect("index.jsp"); 
			}         
		}
		*/
		
		
		chain.doFilter(req, res);     
	}       
	
	public void init(FilterConfig config) throws ServletException 
	{         
		String urls = config.getInitParameter("avoid-urls");         
		StringTokenizer token = new StringTokenizer(urls, ",");           
		avoid_urls=urls;
		urlList = new ArrayList<String>();           
		while (token.hasMoreTokens()) 
		{             
			urlList.add(token.nextToken());           
		}    
	} 
}