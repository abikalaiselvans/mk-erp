package com.my.org.erp.SmartAset;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;
@WebServlet("/Asset")
public class AssetAjax extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public  void doGet(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
		try
			{
				String action=request.getParameter("actionS");
				if(Authenticator.isAuthenticated(request))
				{ 
					if("loadItemData".equals(action) )
					{	
						AssetMethod.loadItemData(request,response);			    
					}
					else if("LoadAssetEntry".equals(action) )
					{	
						AssetMethod.LoadAssetEntry(request,response);			    
					}
					else if(action.equals("loadUniqueSerialNumber"))//
					{	
						AssetMethod.loadUniqueSerialNumber(request, response);
					}
					else if(action.equals("LoadAssetTrack"))//
					{	
						AssetMethod.LoadAssetTrack(request, response);
					}
					else if(action.equals("getAssetStockValue"))//
					{	
						AssetMethod.getAssetStockValue(request, response);
					}
					else if(action.equals("loadAssetSerialNumber"))//
					{	
						AssetMethod.loadAssetSerialNumber(request, response);
					}
				}
				else
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
    
