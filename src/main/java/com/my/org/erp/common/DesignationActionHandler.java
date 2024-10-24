package com.my.org.erp.common;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.Designation;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DesignationActionHandler extends AbstractActionHandler 
{

	String courseName;
	int courseId;

	private void DesigList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			ArrayList<Designation> designationList = new ArrayList<Designation>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
			while (rs.next()) 
			{
				int desigId = rs.getInt(1);
				String desigName = rs.getString(2);
				String desp = rs.getString(3);
				Designation desig = new Designation(desigId, desigName, desp);
				designationList.add(desig);
			}
			HttpSession session = request.getSession();
			session.setAttribute("designationList", designationList);
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	
	private void DesigDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DesigId = request.getParameterValues("OptDesigName");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DESIGNATION (?,?,?,?,?)}");
			for (int i = 0; i < DesigId.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, DesigId[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.addBatch();
			}
			cs.executeBatch();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	
	private void DesigAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String desigName = request.getParameter("TxtDesigName");
			String desigDes = request.getParameter("TxtDesigDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DESIGNATION (?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, desigName);
			cs.setString(4, desigDes);
			cs.setString(5, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	

	private void DesigEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String desigId = request.getParameter("desigId");
			String desigName = request.getParameter("TxtDesigName");
			String desigDes = request.getParameter("TxtDesigDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DESIGNATION (?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, desigId);
			cs.setString(3, desigName);
			cs.setString(4, desigDes);
			cs.setString(5, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	
	 
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			String querypath = request.getParameter("path");
			String ac =action;
			action = action.substring(7);
			action = action.trim();
			
			if (ac.equals("COM_ATTdesigList")) 
			{
				DesigList(request, response);
				 
				response.sendRedirect("Common/DesignationView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
			}
			else if (ac.equals("COM_ATTdesigDelete")) 
			{
				DesigDelete(request, response);
				DesigList(request, response);
				 
				querypath = request.getParameter("qp");
				 
				response.sendRedirect("Common/DesignationView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
	 		 
			}
			else if (ac.equals("COM_ATTdesigAdd")) 
			{
				DesigAdd(request, response);
				DesigList(request, response);
				 
				response.sendRedirect("Common/DesignationView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
			} 
			else if (ac.equals("COM_ATTdesigEdit")) 
			{
				DesigEdit(request, response);
				DesigList(request, response);
				 
				response.sendRedirect("Common/DesignationView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
				 
			}
			 
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}
