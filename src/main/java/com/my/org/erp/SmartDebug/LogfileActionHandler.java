package com.my.org.erp.SmartDebug;
import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class LogfileActionHandler extends AbstractActionHandler
{
 @SuppressWarnings("deprecation")
public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String action=request.getParameter("actionS");
			String[] downfile = request.getParameterValues("row");
			if(action.equals("DEBLogfile"))
			{
				for (int i = 0; i < downfile.length; i++) 
				{
					 String path = request.getRealPath("/")+"log\\"+downfile[i];
					 File file = new File(path);
					 if(file.exists())
						 file.delete();
				 }
				 response.sendRedirect("Smart Debug/ErrorList.jsp");
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());  
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response); 
			  
		}
	}
}
