package com.my.org.erp.SmartMarketing;

import java.io.IOException; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
public class StageActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			
			if (action.equals("MKTStageDelete")) 
			{
				
				String ids[] = request.getParameterValues("id");
				asql = " DELETE FROM mkt_m_stage WHERE INT_STAGEID =?";
				apstm = con.prepareStatement(asql);
				for (int i = 0; i < ids.length; i++) 
				{
					apstm.setString(1, ids[i]);
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Marketing/Stage.jsp");
			}
			else if (action.equals("MKTStageAdd")) 
			{
				String name=request.getParameter("name");
				String percentage=request.getParameter("percentage");
				String html5colorpicker=request.getParameter("html5colorpicker");
				String active=request.getParameter("active");
				if(!"Y".equals(active))
					active = "N";
				//name,percentage,html5colorpicker,active
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_STAGE(?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, percentage);
				acs.setString(5, html5colorpicker);
				acs.setString(6, active);
				acs.setString(7, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Marketing/Stage.jsp");
			} 
			else if (action.equals("MKTStageEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String percentage=request.getParameter("percentage");
				String html5colorpicker=request.getParameter("html5colorpicker");
				String active=request.getParameter("active");
				if(!"Y".equals(active))
					active = "N";
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_STAGE(?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, percentage);
				acs.setString(5, html5colorpicker);
				acs.setString(6, active);
				acs.setString(7, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Marketing/Stage.jsp");
				
			}
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}
