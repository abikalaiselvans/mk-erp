package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ResignationActionHandler extends AbstractActionHandler 
{
	HttpSession session=null;
	private PreparedStatement ps=null;
	private String REPORT_TO="",RESIGN_REASON="",RESIGN_DATE="",STAFF_ID="";
	private String sql="",CURRENT_DATE="",RESIGN_STATUS="";
	
	public void Resign(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			session			= request.getSession();
			STAFF_ID		= ""+session.getAttribute("EMPID");
			REPORT_TO		= request.getParameter("repto");
			CURRENT_DATE	= DateUtil.getCurrentDBDate();
			RESIGN_DATE		= request.getParameter("fromdt");
			RESIGN_REASON	= request.getParameter("reason");
			
			sql="INSERT INTO pay_t_resignationletter(CHR_EMPID,CHR_REPORTINGTO";
			sql=sql+",DAT_APPPLYDATE,DAT_LASTDATE,CHR_DESCRIPTION,CHR_USRNAME" +
					",DT_UPDATEDATE,CHR_UPDATESTATUS)";
			sql=sql+" VALUES(?,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, STAFF_ID);
			ps.setString(2, REPORT_TO);
			ps.setString(3, CURRENT_DATE);
			ps.setString(4, DateUtil.FormateDateSQL(RESIGN_DATE));
			ps.setString(5, RESIGN_REASON);
			ps.setString(6, ""+session.getAttribute("USRID"));
			ps.setString(7, CURRENT_DATE);
			ps.setString(8, "Y");
			ps.execute();
			ps.close();
			 
		} 
		
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	public void ResignAcceptence(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			STAFF_ID		= request.getParameter("staff");
			RESIGN_REASON	= request.getParameter("reason");
			RESIGN_STATUS	= request.getParameter("status");
			sql="UPDATE PAY_T_RESIGNATIONLETTER SET CHR_ACCEPTSTATUS=?,";
			sql=sql+"CHR_REJECTDESCRIPTION=? WHERE CHR_EMPID=?";
			ps=con.prepareStatement(sql);
			ps.setString(2, RESIGN_REASON);
			ps.setString(1, RESIGN_STATUS);
			ps.setString(3, STAFF_ID);
			
			ps.execute();
		} 
		catch (SQLException e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
		catch (NullPointerException e) 
		{
			
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}
	
	public void ResignAcceptenceEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			STAFF_ID		= request.getParameter("id");
			RESIGN_REASON	= request.getParameter("reason");
			RESIGN_STATUS	= request.getParameter("status");
			String replacement	= request.getParameter("replacement");
			
			sql="UPDATE PAY_T_RESIGNATIONLETTER SET CHR_ACCEPTSTATUS=?,CHR_REPLACEMENT=?,";
			sql=sql+"CHR_REJECTDESCRIPTION=? WHERE INT_RESIGNLETTERID=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, RESIGN_STATUS);
			ps.setString(2, replacement);
			ps.setString(3, RESIGN_REASON);
			ps.setString(4, STAFF_ID);
			ps.execute();
			ps.close();
			 
		} 
		catch (SQLException e) 
		{
			 System.out.println(e.getMessage());
		}
		catch (NullPointerException e) 
		{
			
			 System.out.println(e.getMessage());
		}
	}
	
	public void ResignAcceptenceDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String id[]		= request.getParameterValues("staffid");
			
			sql="DELETE FROM PAY_T_RESIGNATIONLETTER WHERE INT_RESIGNLETTERID=?";
			ps=con.prepareStatement(sql);
			for(int i=0;i<id.length;i++)
			{
			ps.setString(1, id[i]);
			ps.execute();
			}
		} 
		catch (SQLException e) 
		{
			 System.out.println(e.getMessage());
		}
		catch (NullPointerException e) 
		{
			
			 System.out.println(e.getMessage());
		}
	}
	
	
	
	public void ResignationLetter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			session			= request.getSession();
			STAFF_ID		= ""+session.getAttribute("EMPID");
			REPORT_TO		= request.getParameter("repto");
			CURRENT_DATE	= DateUtil.getCurrentDBDate();
			RESIGN_DATE		= request.getParameter("fromdt");
			RESIGN_REASON	= request.getParameter("reason");
			
			sql="INSERT INTO pay_t_resignationletter(CHR_EMPID,CHR_REPORTINGTO";
			sql=sql+",DAT_APPPLYDATE,DAT_LASTDATE,CHR_DESCRIPTION,CHR_USRNAME" +
					",DT_UPDATEDATE,CHR_UPDATESTATUS)";
			sql=sql+" VALUES(?,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, STAFF_ID);
			ps.setString(2, REPORT_TO);
			ps.setString(3, CURRENT_DATE);
			ps.setString(4, DateUtil.FormateDateSQL(RESIGN_DATE));
			ps.setString(5, RESIGN_REASON);
			ps.setString(6, ""+session.getAttribute("USRID"));
			ps.setString(7, CURRENT_DATE);
			ps.setString(8, "Y");
			ps.execute();
			ps.close();
			 
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
			String actions=""+request.getParameter("actionS");
			if(actions.equals("PAYResignationStaff"))
			{
				Resign(request,response);
				response.sendRedirect("Staff/Userframe.jsp");
			}
			else if(actions.equals("PAYResignationStaffs"))
			{
				Resign(request,response);
				response.sendRedirect("Smart Payroll/ResignationView.jsp");
			}
			
			else if(actions.equals("PAYResignationAcceptance"))
			{
				ResignAcceptence(request,response);
				response.sendRedirect("Smart Payroll/ResignationView.jsp");
			}
			else if(actions.equals("PAYResignationAcceptanceEdit"))
			{
				ResignAcceptenceEdit(request,response);
				response.sendRedirect("Smart Payroll/ResignationView.jsp");
			}
			else if(actions.equals("PAYResignationAcceptanceDelete"))
			{
				ResignAcceptenceDelete(request,response);
				response.sendRedirect("Smart Payroll/ResignationView.jsp");
			}
			else if(actions.equals("PAYResignationLetter"))
			{
				ResignationLetter(request,response);
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
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
