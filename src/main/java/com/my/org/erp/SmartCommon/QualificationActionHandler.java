package com.my.org.erp.SmartCommon;
import java.io.IOException;
import java.sql.SQLException; 
 
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler; 

public class QualificationActionHandler extends AbstractActionHandler
{
	 
	String userid = "" ;
	private void QualificationDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] qualificationid = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_QUALIFICATION(?,?,?,?,?)}");
			for (int i = 0; i < qualificationid.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, qualificationid[i]);
				acs.setString(3, "a");
				acs.setString(4, "a");
				acs.setString(5, "1");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close();
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void QualificationEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String qualification =  (request.getParameter("Name"));
			String qualificationdesc = request.getParameter("qualificationdesc");
			String qualificationid = request.getParameter("id");
			asql = " UPDATE com_m_qualification SET " ;
			asql = asql +" CHR_QUALIFICATIONNAME=?,CHR_QUALIFICATIONDES=?,";
			asql = asql +" CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS= 'Y' ";
			asql = asql +" WHERE INT_QUALIFICATIONID=? "; 
			apstm = con.prepareStatement(asql);
			apstm.setString(1,qualification );
			apstm.setString(2,qualificationdesc );
			apstm.setString(3,userid );
			apstm.setString(4,qualificationid );
			apstm.execute();
			apstm.close();
			con.close();
			
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
			 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
			 
		}
	}

	
	
	private void QualificationAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String qualification =  (request.getParameter("Name"));
			String qualificationdesc = request.getParameter("qualificationdesc");
			asql = " INSERT INTO com_m_qualification (" ;
			asql = asql +" CHR_QUALIFICATIONNAME,CHR_QUALIFICATIONDES,";
			asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql +" VALUES (?,?,?,DATE(NOW()),'Y')";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,qualification );
			apstm.setString(2,qualificationdesc );
			apstm.setString(3,userid );
			System.out.println(""+apstm);
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
	
	
	
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session = request.getSession();
				userid = ""+session.getAttribute("USRID");
				 		
				 if(action.equals("GENQualificationDelete"))
				 {					
					QualificationDelete(request, response);
					con.close();   
					response.sendRedirect("Smart Common/Qualification.jsp");
				 }
				 else if(action.equals("GENQualificationAdd"))
				 {					
					QualificationAdd(request, response);
					con.close();   
					response.sendRedirect("Smart Common/Qualification.jsp");
					
				}
				else if(action.equals("GENQualificationEdit"))
				{					
					QualificationEdit(request, response);
					con.close();   
					response.sendRedirect("Smart Common/Qualification.jsp");
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
