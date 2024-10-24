package com.my.org.erp.SmartPayroll;

import java.io.IOException;
 
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;


public class PFCliamStatusActionHandler extends AbstractActionHandler {
	 

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			//HttpSession session=request.getSession();			
			//String userid=""+session.getAttribute("USRID");
			String sql="";
			Statement st = con.createStatement();
			if (action.equals("PAYPFCliamStatusAdd")) 
			{
				String empid=request.getParameter("empid");
				String comments = request.getParameter("comments");
				String pfdate = request.getParameter("pfdate");
				PreparedStatement pstm ;
				sql=" UPDATE com_m_staff SET CHR_PFCLAIMSTATUS=? , CHR_PFCLIAMDESCRIPTION=?,DAT_PFCLIAMDATE=? WHERE CHR_EMPID=? ";
				pstm = con.prepareStatement(sql);
				pstm.setString(1,"Y");
				pstm.setString(2, comments);
				pstm.setString(3,DateUtil.FormateDateSQL(pfdate));
				pstm.setString(4,empid);
				pstm.execute(); 
				pstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/PFCliamStatusView.jsp");
			}
			
			else if("PAYPFCliamStatusUpdate".equals(action)) 
			{
				String empid=request.getParameter("empid");
				String comments = request.getParameter("comments");
				String pfdate = request.getParameter("pfdate");
				PreparedStatement pstm ;
				sql=" UPDATE com_m_staff SET CHR_PFCLAIMSTATUS=? , CHR_PFCLIAMDESCRIPTION=?,DAT_PFCLIAMDATE=? WHERE CHR_EMPID=? ";
				pstm = con.prepareStatement(sql);
				pstm.setString(1,"Y");
				pstm.setString(2, comments);
				pstm.setString(3,DateUtil.FormateDateSQL(pfdate));
				pstm.setString(4,empid);
				pstm.execute(); 
				pstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/PFCliamStatusView.jsp");
			}
			
			else if("PAYPFCliamStatusDelete".equals(action)) 
			{
				
				String rowids[] = request.getParameterValues("rowid");
				PreparedStatement pstm ;
				sql=" UPDATE com_m_staff SET CHR_PFCLAIMSTATUS=? , CHR_PFCLIAMDESCRIPTION=?,DAT_PFCLIAMDATE=? WHERE CHR_EMPID=? ";
				pstm = con.prepareStatement(sql);
				
				for(int i=0;i<rowids.length;i++)
				{
					 
					pstm.setString(1,"N");
					pstm.setString(2, null);
					pstm.setString(3,null);
					pstm.setString(4,rowids[i]);
					pstm.addBatch();
					
				}
				pstm.executeBatch();
				pstm.close();
				con.close();    
				response.sendRedirect("Smart Payroll/PFCliamStatusView.jsp");
			}
			
			
			st.close();
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
