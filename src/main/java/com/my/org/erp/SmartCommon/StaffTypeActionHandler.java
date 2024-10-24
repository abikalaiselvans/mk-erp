package com.my.org.erp.SmartCommon;

import java.io.IOException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 
 
public class StaffTypeActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("GENStaffTypeDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  COM_PRO_STAFFTYPE(?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/StaffType.jsp");
			}
			else if ( "GENStaffTypeAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				String slab=request.getParameter("slab");
				if("Y".equals(slab))
					slab="Y";
				else
					slab ="N";
				name=name.trim();
				acs = con.prepareCall("{call  COM_PRO_STAFFTYPE(?,?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, slab);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/StaffType.jsp");//StaffTypeAction.jsp?action1=Add
			} 
			else if (action.equals("GENStaffTypeEdit")) 
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
				CommonFunctions.Execute(sql);
				
				acs = con.prepareCall("{call  COM_PRO_STAFFTYPE(?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, slab);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				
				con.close();    
				response.sendRedirect("Smart Common/StaffType.jsp");
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
