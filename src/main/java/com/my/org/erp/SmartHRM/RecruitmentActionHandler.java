package com.my.org.erp.SmartHRM;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class RecruitmentActionHandler extends AbstractActionHandler{
	String categoryName,categoryDes;
	int categoryId;
	
	private void hrmDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			
			HttpSession session=request.getSession();			
			@SuppressWarnings("unused")
			String userId=""+session.getAttribute("USRID");			
			String []jobId=request.getParameterValues("OptJobId");		
			CallableStatement cs=con.prepareCall("{call HRM_PRO_RECRUITMENT(?,?,?,?,?,?,?,?)}");
			for(int i=0;i<jobId.length;i++)
			{	
				cs.setString(1, "DELETE");
				cs.setString(2,jobId[i]);
				cs.setString(3, "1");
				cs.setString(4, "1");
				cs.setString(5, "1");
				cs.setString(6, "1");
				cs.setString(7, "1");
				cs.setString(8, "1");
				cs.addBatch();				
			}
			cs.executeBatch();
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	private void hrmAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			String jobId=request.getParameter("jobTitle").trim();
			String TxtTest=request.getParameter("TxtTest").trim();
			String TxtInterview=request.getParameter("TxtInterview").trim();
			String TxtMedical=request.getParameter("TxtMedical").trim();
			String TxtReference=request.getParameter("TxtReference").trim();
			String TxtGD=request.getParameter("TxtGD").trim();
			CallableStatement cs = con.prepareCall("{call HRM_PRO_RECRUITMENT(?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");		
			cs.setString(2, jobId);
			cs.setString(3, TxtTest);
			cs.setString(4, TxtInterview);
			cs.setString(5, TxtMedical);			
			cs.setString(6, TxtReference);
			cs.setString(7, TxtGD);			
			cs.setString(8, userId);
			cs.execute();										
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	
	private void hrmEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
				HttpSession session=request.getSession();
				String userid=""+session.getAttribute("USRID");
				String jobId=request.getParameter("OptJobTitle").trim();
				String TxtTest=request.getParameter("TxtTest").trim();
				String TxtInterview=request.getParameter("TxtInterview").trim();
				String TxtMedical=request.getParameter("TxtMedical").trim();
				String TxtReference=request.getParameter("TxtReference").trim();
				String TxtGD=request.getParameter("TxtGD").trim();
				CallableStatement cs=con.prepareCall("{call HRM_PRO_RECRUITMENT(?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, jobId);
				cs.setString(3, TxtTest);
				cs.setString(4, TxtInterview);
				cs.setString(5, TxtMedical);
				cs.setString(6, TxtReference);
				cs.setString(7, TxtGD);
				cs.setString(8, userid);
				cs.execute();		
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
				if(action.equals("HRMrecruitmentAdd"))
				{					
					String jobId=request.getParameter("jobTitle").trim();
					if(com.my.org.erp.common.CommonFunctions.RecordExist(con, "SELECT COUNT(*) FROM hrm_m_jobperformance WHERE INT_JOBID="+jobId))
					{
						con.close();   
						response.sendRedirect("error/index.jsp?error=DUPLICAT KEY fof "+jobId+" Already Entered ");	
					}
					else
					{
						hrmAdd(request, response);	
						con.close();   
						response.sendRedirect("Smart HRM/RecruitmentView.jsp");
					}
					
				}
				else if(action.equals("HRMRecruitmentDelete"))
				{
					hrmDelete(request, response);
					con.close();   
					response.sendRedirect("Smart HRM/RecruitmentView.jsp");
				}
				else if(action.equals("HRMRecruitmentEdit"))
				{
					hrmEdit(request, response);
					con.close();   
					response.sendRedirect("Smart HRM/RecruitmentView.jsp");
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

