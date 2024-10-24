package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class StaffTypeActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("ATTStaffTypeDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call  COM_PRO_STAFFTYPE(?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/StaffType.jsp");
			}
			else if ( "ATTStaffTypeAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				String slab=request.getParameter("slab");
				if("Y".equals(slab))
					slab="Y";
				else
					slab ="N";
				name=name.trim();
				CallableStatement cs = con.prepareCall("{call  COM_PRO_STAFFTYPE(?,?,?,?,? )}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, slab);
				cs.setString(5, user);
				cs.execute();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/StaffTypeAction.jsp?action1=Add");
			} 
			else if (action.equals("ATTStaffTypeEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String type=request.getParameter("type");
				String slab=request.getParameter("slab");
				if("Y".equals(slab))
					slab="Y";
				else
					slab ="N";
				String sql = " UPDATE com_m_staff SET CHR_TYPE='"+name+"' WHERE CHR_TYPE='"+type+"'";
				com.my.org.erp.common.CommonFunctions.Execute(sql);
				
				CallableStatement cs = con.prepareCall("{call  COM_PRO_STAFFTYPE(?,?,?,?,? )}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, slab);
				cs.setString(5, user);
				cs.execute();
				cs.close();
				
				con.close();   
				response.sendRedirect("Smart Attendance/StaffType.jsp");
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
