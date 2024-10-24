package com.my.org.erp.SmartCommon;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class DistrictActionHandler extends AbstractActionHandler 
{
	
	String stateName, districtName;
	String stateid="",userid="";
	String districtid="";
	
	
	private void DistrictDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DistrictId = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_DISTRICT(?,?,?,?,?,?)}");
			for (int i = 0; i < DistrictId.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, DistrictId[i]);
				acs.setString(3, " ");
				acs.setString(4, " ");
				acs.setString(5, " ");
				acs.setString(6, " ");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	private void DistrictAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			stateid =  request.getParameter("state") ;
			String districtName = request.getParameter("Name");
			String districtDes = request.getParameter("sdescription");
			acs = con.prepareCall("{call  COM_PRO_DISTRICT(?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, districtName);
			acs.setString(4, districtDes);
			acs.setString(5, stateid);
			acs.setString(6, userid);
			if(districtName!=null)					
				acs.execute();
			acs.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void DistrictEdit(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String districtid = request.getParameter("rowid");
			stateid =  request.getParameter("state") ;
			String districtName = request.getParameter("Name");
			String districtDes = request.getParameter("sdescription");
			
			acs = con.prepareCall("{call  COM_PRO_DISTRICT(?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, districtid);
			acs.setString(3, districtName);
			acs.setString(4, districtDes);
			acs.setString(5, "" + stateid);
			acs.setString(6, userid);
			if(districtName!=null)
				acs.execute();
			acs.close();
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
			if ("GENDistrictAdd".equals(action) ) 
			{
				DistrictAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Common/DistrictView.jsp?stateid="+stateid);
			 }
			else if (action.equals("GENDistrictEdit")) 
			{
				DistrictEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Common/DistrictView.jsp?stateid="+stateid);
		 	}
			else if (action.equals("GENdistrictDelete")) 
			{
				stateid =  request.getParameter("state") ;
				DistrictDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Common/DistrictView.jsp?stateid="+stateid);
				 
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
