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

import com.my.org.erp.bean.Department;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DepartmentActionHandler extends AbstractActionHandler 
{

	String courseName;
	int courseId;

	private void DepartList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			ArrayList<Department> departmentList = new ArrayList<Department>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM   com_m_depart   ORDER BY CHR_DEPARTNAME");
			while (rs.next()) 
			{
				int departId = rs.getInt(1);
				String departName = rs.getString(2);
				String desp = rs.getString(3);
				Department department = new Department(departId, departName,desp);
				departmentList.add(department);
			}
			HttpSession session = request.getSession();
			session.setAttribute("departmentList", departmentList);
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	

	private void DepartDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DepartId = request.getParameterValues("OptDepartName");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?)}");
			for (int i = 0; i < DepartId.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, DepartId[i]);
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

	
	
	
	private void DepartAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String departName = request.getParameter("TxtDepartName");
			String departDes = request.getParameter("TxtDepartDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, departName);
			cs.setString(4, departDes);
			cs.setString(5, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	
	private void DepartEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String departId = request.getParameter("departId");
			String departName = request.getParameter("TxtDepartName");
			String departDes = request.getParameter("TxtDepartDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, departId);
			cs.setString(3, departName);
			cs.setString(4, departDes);
			cs.setString(5, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			String querypath = request.getParameter("path");
			action = action.trim();
			action = action.substring(7);
			action = action.trim();
	
			if (action.equals("departDelete")) 
			{
				DepartDelete(request, response);
				DepartList(request, response);
				 
				querypath = request.getParameter("qp");
				 
				response.sendRedirect("Common/DepartmentView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
	 		}
			else if (action.equals("departAdd")) 
			{
				DepartAdd(request, response);
				DepartList(request, response);
				 
				response.sendRedirect("Common/DepartmentView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
			} 
			else if (action.equals("departEdit")) 
			{
				DepartEdit(request, response);
				DepartList(request, response);
				 
				response.sendRedirect("Common/DepartmentView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
			} 
			else if (action.equals("departList")) 
			{
				DepartEdit(request, response);
				DepartList(request, response);
				 
				response.sendRedirect("Common/DepartmentView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
			}
			 
 
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());

		}
	}

}
