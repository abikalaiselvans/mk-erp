package com.my.org.erp.SmartHRM;
import java.io.IOException;
import java.sql.Connection;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.HRM.JobDemand;

public class DemandActionHandler extends AbstractActionHandler
{
	 
	String userid="";
	String empid="";
	
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				userid=""+session.getAttribute("USRID");
				empid=""+session.getAttribute("EMPID");
				if(action.equals("HRMdemandDelete"))
				{					
					 
					JobDemand j = new JobDemand();
					Map map=request.getParameterMap();
					BeanUtils.populate(j,map);
					JobDemandDelete(con, j, request, response,  userid);
					con.close();   
					response.sendRedirect("Smart HRM/DemandEntryView.jsp");
				}
				else if(action.equals("HRMdemandAdd"))
				{					
					JobDemand j = new JobDemand();
					Map map=request.getParameterMap();
					BeanUtils.populate(j,map);
					JobDemandAdd(con, j, request, response,  userid);
					con.close();   
					response.sendRedirect("Smart HRM/DemandEntryView.jsp");
				}
				else if(action.equals("HRMdemandEdit"))
				{					
					JobDemand j = new JobDemand();
					Map map=request.getParameterMap();
					BeanUtils.populate(j,map);
					JobDemandEdit(con, j, request, response,  userid);
					con.close();   
					response.sendRedirect("Smart HRM/DemandEntryView.jsp");
				}
				else if(action.equals("HRMdemandAccept"))
				{					
					JobDemand j = new JobDemand();
					Map map=request.getParameterMap();
					BeanUtils.populate(j,map);
					JobDemandAccept(con, j, request, response,  userid);
					con.close();   
					response.sendRedirect("Smart HRM/Demand.jsp");
				}
				else if(action.equals("HRMdemandAcceptCancel"))
				{					

				    String rowid = request.getParameter("rowid");
				    asql =" UPDATE hrm_m_jobdemand SET  CHR_APPROVED=?,CHR_APPROVEDDESC=?, CHR_STATUS =? WHERE INT_JOBDEMANDID=?  ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,null);
					apstm.setString(2, null);
					apstm.setString(3, "N");
					apstm.setString(4, rowid);
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart HRM/DemandEntryView.jsp");
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
	
	
	
	private void JobDemandAdd(Connection con, JobDemand d ,HttpServletRequest request,HttpServletResponse response ,String userid)throws ServletException, IOException
	{
		try
		{			
			acs = con.prepareCall("{call HRM_PRO_DEMAND(?,?,?,?,?,?,?,?,?,?,?,? )}");
			acs.setString(1, "INSERT");		
			acs.setString(2, "");
			acs.setString(3, d.getOffice());
			acs.setString(4, d.getJobgrade());
			acs.setString(5, d.getJobTitle());
			acs.setString(6, ""+d.getDemand());
			acs.setString(7, d.getDemandraisedby());
			acs.setString(8, ""+d.getDemandescription());
			acs.setString(9, "" );
			acs.setString(10, "");
			acs.setString(11, "N");
			acs.setString(12, userid);
			// System.out.println(""+acs);
		    acs.execute();
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
	
	
	
	private void JobDemandEdit(Connection con, JobDemand d ,HttpServletRequest request,HttpServletResponse response ,String userid)throws ServletException, IOException
	{
		try
		{	
			
			acs = con.prepareCall("{call HRM_PRO_DEMAND(?,?,?,?,?,?,?,?,?,?,?,? )}");
			acs.setString(1, "UPDATE");		
			acs.setString(2, d.getRowid());
			acs.setString(3, d.getOffice());
			acs.setString(4, d.getJobgrade());
			acs.setString(5, d.getJobTitle());
			acs.setString(6, ""+d.getDemand());
			acs.setString(7, d.getDemandraisedby());
			acs.setString(8, ""+d.getDemandescription());
			acs.setString(9, "" );
			acs.setString(10, "");
			acs.setString(11, "N");
			acs.setString(12, userid);
			// System.out.println(""+acs);
		    acs.execute();
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
	
	private void JobDemandDelete(Connection con, JobDemand d ,HttpServletRequest request,HttpServletResponse response ,String userid)throws ServletException, IOException
	{
		try
		{			
			String []rowid= request.getParameterValues("rowid");	
			acs = con.prepareCall("{call HRM_PRO_DEMAND(?,?,?,?,?,?,?,?,?,?,?,? )}");
			for(int i=0;i<rowid.length;i++)
			{
				acs.setString(1, "DELETE");		
				acs.setString(2, rowid[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "" );
				acs.setString(7, "" );
				acs.setString(8, "" );
				acs.setString(9, "" );
				acs.setString(10, "" );
				acs.setString(11, "" );
				acs.setString(12, userid);
				// System.out.println(""+cs);
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
	
	
	 
 
	private void JobDemandAccept(Connection con, JobDemand d ,HttpServletRequest request,HttpServletResponse response ,String userid)throws ServletException, IOException
	{
		try
		{	
			
			acs = con.prepareCall("{call HRM_PRO_DEMAND(?,?,?,?,?,?,?,?,?,?,?,? )}");
			acs.setString(1, "ACCEPT");		
			acs.setString(2, d.getRowid());
			acs.setString(3, d.getOffice());
			acs.setString(4, d.getJobgrade());
			acs.setString(5, d.getJobTitle());
			acs.setString(6, ""+d.getDemand());
			acs.setString(7, d.getDemandraisedby());
			acs.setString(8, ""+d.getDemandescription());
			acs.setString(9, d.getDemandacceptedby() );
			acs.setString(10, d.getAcceptdescription());
			acs.setString(11, d.getDemandstatus());
			acs.setString(12, userid);
			System.out.println(""+acs);
		    acs.execute();
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
	
	
}

