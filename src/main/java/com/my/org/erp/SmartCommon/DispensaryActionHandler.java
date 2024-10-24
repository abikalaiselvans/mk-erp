package com.my.org.erp.SmartCommon;

import java.io.IOException;
 
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DispensaryActionHandler extends AbstractActionHandler {
	

	
	
	@SuppressWarnings("unused")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String sql="";
			if (action.equals("GENDispensaryAdd")) 
			{
				String dispname = request.getParameter("Name");
				String address = request.getParameter("addresss");
				String country = ""+request.getParameter("country");
				String state = ""+request.getParameter("state");
				String district = ""+request.getParameter("district");
				String city = ""+request.getParameter("city");
				String pin = ""+request.getParameter("pin");
				String phone = ""+request.getParameter("phone");
				  
				asql = " INSERT INTO com_m_dispensary ";
				asql = asql + " ( ";
				asql = asql +" CHR_DESPNAME,CHR_ADDRESS, INT_CITYID,INT_DISTRICTID,INT_STATEID, ";
				asql = asql+ " INT_COUNTRYID ,INT_PINCODE,INT_PHONE, ";
				asql = asql+ " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
				asql = asql+ " VALUES (";
				asql = asql +" ?,?, ?,?,?, ";
				asql = asql+ " ? ,?,?, ";
				asql = asql+ " ?,DATE(NOW()),'Y'  ";
				asql = asql+ " ) ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,dispname );
				apstm.setString(2,address );
				apstm.setString(3,city  );
				apstm.setString(4,district  );
				apstm.setString(5,state );
				apstm.setString(6,country );
				apstm.setString(7,pin );
				if (phone.matches("((-|\\+)?[0-9]+(\\.[0-9]+)?)+"))
					apstm.setString(8,phone );
				else
					apstm.setString(8,"0" );
				apstm.setString(9,auserid );
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				response.sendRedirect("Smart Common/DispensaryView.jsp?path=ATT");
			}
			else if (action.equals("GENDispensaryDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				asql = "DELETE FROM com_m_dispensary WHERE INT_DESPID=?" ;
				apstm = con.prepareStatement(asql);
				for(int u=0;u<ids.length;u++)
				{
					apstm.setString(1,ids[u] );
					apstm.addBatch();
				}
				apstm.executeBatch();
				System.out.println(""+apstm);
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Common/DispensaryView.jsp?path=ATT");
			} 
			else if (action.equals("GENDispensaryEdit")) 
			{
				
				String dispensaryid = request.getParameter("id");
				String dispname = request.getParameter("Name");
				String address = request.getParameter("addresss");
				String country = ""+request.getParameter("country");
				String state = ""+request.getParameter("state");
				String district = ""+request.getParameter("district");
				String city = ""+request.getParameter("city");
				String pin = ""+request.getParameter("pin");
				String phone = ""+request.getParameter("phone");
				
				asql = " UPDATE com_m_dispensary SET ";
				asql = asql +" CHR_DESPNAME=?,CHR_ADDRESS=?, INT_CITYID=?,INT_DISTRICTID=?,INT_STATEID=?, ";
				asql = asql+ " INT_COUNTRYID=? ,INT_PINCODE=?,INT_PHONE=?, ";
				asql = asql+ " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'";
				asql = asql+ " WHERE INT_DESPID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,dispname );
				apstm.setString(2,address );
				apstm.setString(3,city  );
				apstm.setString(4,district  );
				apstm.setString(5,state );
				apstm.setString(6,country );
				apstm.setString(7,pin );
				apstm.setString(8,phone );
				apstm.setString(9,auserid );
				apstm.setString(10,dispensaryid );
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				response.sendRedirect("Smart Common/DispensaryView.jsp?path=ATT");
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
