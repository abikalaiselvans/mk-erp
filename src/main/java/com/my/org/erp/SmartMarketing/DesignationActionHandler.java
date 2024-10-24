package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DesignationActionHandler extends AbstractActionHandler 
{

	String userid = "" ;
	private void DesigDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DesigId = request.getParameterValues("id");
			String desid = "";
			String sql = "DELETE FROM mkt_m_desig WHERE INT_DESIGID=?";		
			PreparedStatement pstm = null;
			for (int i = 0; i < DesigId.length; i++) {
				desid = DesigId[i];
				desid.trim();
				pstm = con.prepareStatement(sql);
				pstm.setString(1, desid);				
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

	private void DesigAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String sql="";
			String desigName = request.getParameter("Name");
			String desigDes = request.getParameter("sdescription");
			String active=request.getParameter("active");
			if("".equals(active) || !(null==active))
				active="Y";
			else
				active="N";
			sql = "INSERT INTO mkt_m_desig(CHR_DESIGNAME,CHR_DESC,CHR_STATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)VALUES(?,?,?,?,DATE(NOW()),'Y')";
			PreparedStatement pstm = con.prepareStatement(sql);
			pstm.setString(1, desigName);
			pstm.setString(2, desigDes);
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
	
	private void DesigEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String sql=" ";
			String desigId = request.getParameter("id");
			String desigName = request.getParameter("Name");
			String desigDes = request.getParameter("sdescription");
			String active=request.getParameter("active");
			if("".equals(active) || !(null==active))
				active="Y";
			else
				active="N";
			
			sql = " UPDATE mkt_m_desig  SET ";
			sql = sql + "  CHR_DESIGNAME =?,CHR_DESC=?,";
			sql = sql + " CHR_STATUS=?,";
			sql = sql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'  ";
			sql = sql + "  WHERE INT_DESIGID= "+desigId;
			apstm = con.prepareStatement(sql);
			apstm.setString(1,desigName);
			apstm.setString(2,desigDes);
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
			 
			if (action.equals("MKTDesignationDelete")) 
			{
				DesigDelete(request, response);
				con.close();    
				response.sendRedirect("Smart Marketing/MktDesignationView.jsp");
	 		 
			}
			else if (action.equals("MKTDesignationAdd")) 
			{
				DesigAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Marketing/MktDesignationView.jsp");
			} 
			else if (action.equals("MKTDesignationEdit")) 
			{
				DesigEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Marketing/MktDesignationView.jsp");
			}
			 
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
}
