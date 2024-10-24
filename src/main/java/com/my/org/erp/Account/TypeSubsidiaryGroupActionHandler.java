package com.my.org.erp.Account;

import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class TypeSubsidiaryGroupActionHandler extends AbstractActionHandler 
{
	
	 
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String group=request.getParameter("group");
			switch(EnumActionName.TYPESUBSIDIARYGROUPACTION.valueOf(action))
			{

					case ACCSubsidiaryGroupAdd: 
										Add(request,response);
										 
										response.sendRedirect("Smart Accounts/TypeSubsidiaryGroupAction.jsp?action1=Create&group="+group);
										break;
		
					case ACCSubsidiaryGroupEdit:  
										Edit(request,response);
										 
										response.sendRedirect("Smart Accounts/TypeSubsidiaryGroup.jsp");
										break;
										
					case ACCSubsidiaryGroupDelete:  					
										Delete(request,response);
										 
										response.sendRedirect("Smart Accounts/TypeSubsidiaryGroup.jsp");
										break;
					 
			}
			
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}
	
	

	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String subsidiarygroupname=request.getParameter("name");
			String subgroupid=request.getParameter("group");
			CallableStatement cs=con.prepareCall("{call ACC_PRO_SUBSIDIARYGROUP(?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "");
			cs.setString(3, subsidiarygroupname);
			cs.setString(4, subgroupid);
			cs.setString(5, com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPEGROUPID FROM accc_m_typesubgroups WHERE  INT_TYPESUBGROUPID="+subgroupid)[0][0]);
			cs.setString(6, com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPEID FROM accc_m_typesubgroups WHERE  INT_TYPESUBGROUPID="+subgroupid)[0][0]);
			cs.setString(7, userid);
			cs.execute();
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	public void Edit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String id=request.getParameter("id");
			String subsidiarygroupname=request.getParameter("name");
			String subgroupid=request.getParameter("group");
			CallableStatement cs=con.prepareCall("{call ACC_PRO_SUBSIDIARYGROUP(?,?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, id);
			cs.setString(3, subsidiarygroupname);
			cs.setString(4, subgroupid);
			cs.setString(5, com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPEGROUPID FROM accc_m_typesubgroups WHERE  INT_TYPESUBGROUPID="+subgroupid)[0][0]);
			cs.setString(6, com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TYPEID FROM accc_m_typesubgroups WHERE  INT_TYPESUBGROUPID="+subgroupid)[0][0]);
			cs.setString(7, userid);
			cs.execute();
			
			 
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	public void Delete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String ids[] = request.getParameterValues("id");
			CallableStatement cs=con.prepareCall("{call ACC_PRO_SUBSIDIARYGROUP(?,?,?,?,?,?,?)}");
			for(int i=0;i<ids.length;i++)
			{
				cs.setString(1, "DELETE");
				cs.setString(2, ids[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, "");
				cs.addBatch();
			}
			cs.executeBatch();
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	

}
