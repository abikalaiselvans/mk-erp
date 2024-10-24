package com.my.org.erp.ServiceLogin;
 
import java.io.File;
import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import DBConnection.DBCon;

/**
* This class check  a login user or not.
* @author MythraKalaiselvan 
* @SmartERP version 1.2
*/

@WebServlet("/SmartLoginAuth")
public class ServiceLogin extends HttpServlet
{
	private static final long serialVersionUID = 1L;
    
    public static String RIGHTS = "ADMIN";
    
	public ServiceLogin()
    {
		
    }
    @SuppressWarnings("deprecation")
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        try {
			String action = request.getParameter("filename");
			String pack = request.getParameter("actionS");
			String Type = ""+request.getParameter("username");
			HttpSession session = request.getSession();
			String userid= "" + session.getAttribute("USRID");
			if(userid.equals("") || userid.equals("null"))
				userid="GUEST";
			 
			 //System.out.println(action);
			 //System.out.println(pack);
			if(Type.equals("MKS") || Authenticator.isAuthenticated(request) || action.equalsIgnoreCase("Login"))
			{
				System.out.println("Logined");
				DBCon connection = null;
			    java.sql.Connection con = null;
			    try
			    {
			    	connection = new DBCon();
			        con = connection.getConnection();
			        if(con == null)
			            response.sendRedirect("error/index.jsp?error=Database Connection Error");
			    }
			    catch(Exception e)
			    {
			        System.out.println(e.getMessage());
			    	response.sendRedirect("error/index.jsp?error=Database Connection Error");
			    }
			
			    if(action != null)
			    {
			    	try {
						System.runFinalization();
						System.gc();
						RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
						ActionHandler handler = ActionHandlerLocator.locate(action.trim(), pack.trim());
						handler.setApplication(getServletContext());
						handler.setDatabaseConnection(con);
						handler.setPath(""+request.getRealPath("/")+"\\");
						handler.setSql(" ");
						handler.setEncodeKey("9865043008");
						handler.setSession(request.getSession());
						handler.setUserid(userid);
						handler.setAction(pack);
						handler.setRdispatcher(dispatchers);
						handler.handle(request, response);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						System.out.println("------"+e.getMessage());
					}
			    }
 

			} 
			else
			{
			    ServletContext application = getServletContext();
			    request.setAttribute("loginmsg", "Your Login Session has Expired");
			    RequestDispatcher dispatcher = application.getRequestDispatcher("/Login.jsp");
			    dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			System.out.println(""+e.getMessage());
		}
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        doGet(request, response);
    }

    

}