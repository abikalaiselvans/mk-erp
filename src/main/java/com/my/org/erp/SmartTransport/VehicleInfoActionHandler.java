package com.my.org.erp.SmartTransport;

import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class VehicleInfoActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			if ("TRSVehicleInfoAdd".equals(action))
			{
				String vehicletype= request.getParameter("vehicletype");
				String vehiclemake= request.getParameter("vehiclemake");
				String vehiclemodel= request.getParameter("vehiclemodel");
				String varriant= request.getParameter("varriant");
				String color= request.getParameter("color");
				String fueltype= request.getParameter("fueltype");
				String regnumber= request.getParameter("regnumber");
				String monthname= request.getParameter("monthname");
				String year= request.getParameter("year");
				String cc= request.getParameter("cc");
			 	String insurancenumber= request.getParameter("insurancenumber");
				String insurancedate= request.getParameter("insurancedate");
				String comments= request.getParameter("comments");
				String chasenumber= request.getParameter("chasenumber");
				String batterynumber= request.getParameter("batterynumber");
				String keynumber= request.getParameter("keynumber");
				 
				acs = con.prepareCall("{call AUTO_PRO_VEHICLEINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, vehicletype);
				acs.setString(4, vehiclemake);
				acs.setString(5, vehiclemodel);
				acs.setString(6, varriant);
				acs.setString(7, color);
				acs.setString(8, fueltype);
				acs.setString(9, regnumber);
				acs.setString(10,monthname);
				acs.setString(11, year);
				acs.setString(12, cc);
				acs.setString(13, insurancenumber);
				acs.setString(14, com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(insurancedate));
				acs.setString(15,comments);
				acs.setString(16, chasenumber);
				acs.setString(17, batterynumber);
				acs.setString(18, keynumber); 
				acs.setString(19,"Y"); 
				acs.setString(20,user);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Transport/VehicleInfoAction.jsp?action1=Add");
			}
			else if ("TRSVehicleInfoEdit".equals(action))
			{
				String id=request.getParameter("id");
				String vehicletype= request.getParameter("vehicletype");
				String vehiclemake= request.getParameter("vehiclemake");
				String vehiclemodel= request.getParameter("vehiclemodel");
				String varriant= request.getParameter("varriant");
				String color= request.getParameter("color");
				String fueltype= request.getParameter("fueltype");
				String regnumber= request.getParameter("regnumber");
				String monthname= request.getParameter("monthname");
				String year= request.getParameter("year");
				String cc= request.getParameter("cc");
			 	String insurancenumber= request.getParameter("insurancenumber");
				String insurancedate= request.getParameter("insurancedate");
				String comments= request.getParameter("comments");
				String chasenumber= request.getParameter("chasenumber");
				String batterynumber= request.getParameter("batterynumber");
				String keynumber= request.getParameter("keynumber");
				acs = con.prepareCall("{call AUTO_PRO_VEHICLEINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, vehicletype);
				acs.setString(4, vehiclemake);
				acs.setString(5, vehiclemodel);
				acs.setString(6, varriant);
				acs.setString(7, color);
				acs.setString(8, fueltype);
				acs.setString(9, regnumber);
				acs.setString(10,monthname);
				acs.setString(11, year);
				acs.setString(12, cc);
				acs.setString(13, insurancenumber);
				acs.setString(14, com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(insurancedate));
				acs.setString(15,comments);
				acs.setString(16, chasenumber);
				acs.setString(17, batterynumber);
				acs.setString(18, keynumber); 
				acs.setString(19,"Y"); 
				acs.setString(20,user);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Transport/VehicleInfoAction.jsp?action1=Add");
			}
			else if ("TRSVehicleInfoDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call AUTO_PRO_VEHICLEINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.setString(8, "");
					acs.setString(9, "");
					acs.setString(10, "");
					acs.setString(11, "");
					acs.setString(12, "");
					acs.setString(13, "");
					acs.setString(14, "");
					acs.setString(15, "");
					acs.setString(16, "");
					acs.setString(17, "");
					acs.setString(18, "");
					acs.setString(19, "");
					acs.setString(20, "");
					
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				response.sendRedirect("Smart Transport/VehicleInfo.jsp");
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
