package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class DepartmentActionHandler extends AbstractActionHandler 
{
	String userid = "" ;
	private void DepartDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DepartId = request.getParameterValues("id");
			String depid = "";
			String sql = "DELETE FROM mkt_m_depart WHERE INT_DEPARTID=?";		
			PreparedStatement pstm = null;
			for (int i = 0; i < DepartId.length; i++) {
				depid = DepartId[i];
				depid.trim();
				pstm = con.prepareStatement(sql);
				pstm.setString(1, depid);				
				pstm.execute();
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

	private void DepartAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String sql="";
			String departName = request.getParameter("Name");
			String departDes = request.getParameter("sdescription");
			String active=request.getParameter("active");
			System.out.println("active.."+active);
			if("".equals(active) || !(null==active))
				active="Y";
			else
				active="N";
			sql = "INSERT INTO mkt_m_depart(CHR_DEPARTNAME,CHR_DESC,CHR_STATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)VALUES(?,?,?,?,DATE(NOW()),'Y')";
			PreparedStatement pstm = con.prepareStatement(sql);
			pstm.setString(1, departName);
			pstm.setString(2, departDes);
			pstm.setString(3, active);
			pstm.setString(4, ""+userid);
			System.out.println(""+pstm);
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
	
	private void DepartEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String sql=" ";
			String departId = request.getParameter("id");
			String departName = request.getParameter("Name");
			String departDes = request.getParameter("sdescription");
			String active=request.getParameter("active");
			
			if("".equals(active) || !(null==active))
				active="Y";
			else
				active="N";
			
			sql = " UPDATE mkt_m_depart  SET ";
			sql = sql + "  CHR_DEPARTNAME =?,CHR_DESC=?,";
			sql = sql + " CHR_STATUS=?,";
			sql = sql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'  ";
			sql = sql + "  WHERE INT_DEPARTID= "+departId;
			apstm = con.prepareStatement(sql);
			apstm.setString(1,departName);
			apstm.setString(2,departDes);
			apstm.setString(3,active);
			apstm.setString(4,userid);
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

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			 
			if (action.equals("MKTDepartmentDelete")) 
			{
				DepartDelete(request, response);
				con.close();    
				response.sendRedirect("Smart Marketing/MktDepartmentView.jsp");
			}
			else if (action.equals("MKTDepartmentAdd")) 
			{
				DepartAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Marketing/MktDepartmentView.jsp");
			} 
			else if (action.equals("MKTDepartmentEdit")) 
			{
				DepartEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Marketing/MktDepartmentView.jsp");
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
