package com.my.org.erp.SmartHRM;

import java.io.IOException;
import java.sql.PreparedStatement;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 

public class FinalInterviewActionHandler extends AbstractActionHandler 
{
	
	 

	String userid=null;
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			userid=""+session.getAttribute("USRID");
			 
			
			if (action.equals("HRMFinalInterviewUpdate") || action.equals("HRMFinalInterviewUpdates")) 
			{
				ThirdInterviewAdd( request, response);
				con.close();   
				response.sendRedirect("Smart HRM/HRThirdInterview.jsp");
			}
			if (action.equals("HRMThirdInterviewDelete")  ) 
			{
				thirdInterviewDelete( request, response);
				con.close();   
				response.sendRedirect("Smart HRM/HRThirdInterview.jsp");
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


 

	
 
	
	
 
	
	
	

	
	private void ThirdInterviewAdd(  HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		
		try 
		{ 
			
			String rowid = request.getParameter("rowid");
			String Status = request.getParameter("Status");
			String fsalary = request.getParameter("fsalary");
			String salaryingrossortakehome = request.getParameter("salary");
			String fcomments = request.getParameter("fcomments");
			 
			
			PreparedStatement pstm ;
			String sql=" ";
			sql = " UPDATE  hrm_t_interview SET ";
			sql = sql + " CHR_CANDIDATESTATUS=?,CHR_FINALINTERVIEWSTATUS='Y', CHR_SALARYFIXATION=?,DOU_SALARYFIXATION=?," +
					" CHR_FINALCOMMENTS=?,DAT_FINALINTERVIEWDATE=NOW() " +
					" ";
			 
			sql = sql + " WHERE INT_INTERVIEWID =?";
			
			
			
			pstm = con.prepareStatement(sql);
			pstm.setString(1,Status);
			pstm.setString(2,salaryingrossortakehome);
			pstm.setString(3,fsalary);
			pstm.setString(4,fcomments);
			pstm.setString(5,rowid);
			pstm.execute();
			pstm.close();
			 
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	
	
	
 
	
	
	private void thirdInterviewDelete(  HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		
		try 
		{ 
  

			String rowids[] = request.getParameterValues("rowid");
			PreparedStatement pstm ;
			String sql=" ";
			
			sql = " UPDATE  hrm_t_interview SET ";
			sql = sql + " CHR_CANDIDATESTATUS='N', CHR_FINALINTERVIEWSTATUS='N', CHR_SALARYFIXATION=null,DOU_SALARYFIXATION =null,CHR_FINALCOMMENTS=null ";
			sql = sql + " WHERE INT_INTERVIEWID =?   AND CHR_FINALSTATUS  ='N'";
			pstm = con.prepareStatement(sql);
			
			for(int i=0;i<rowids.length;i++)
			{
				 
				pstm.setString(1,rowids[i]);
				// System.out.println(""+pstm);
				pstm.addBatch();
				
			}
			pstm.executeBatch();
			pstm.close();
			 
			
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
