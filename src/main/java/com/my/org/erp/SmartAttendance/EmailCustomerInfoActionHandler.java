package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

 
public class EmailCustomerInfoActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			
			if (action.equals("ATTEmailCustomerGroupDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call COM_PRO_EMAILCUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.setString(9, "");
					cs.setString(10, "");
					cs.setString(11, "");
					cs.setString(12, "");
					cs.setString(13, "");
					cs.setString(14, "");
					cs.setString(15, "");
					cs.setString(16, "");
					cs.setString(17, "");
					cs.setString(18, "");
					cs.setString(19, "");
					cs.setString(20, "");
					cs.setString(21, "");
					cs.setString(22, "");
					cs.setString(23, "");
					cs.setString(24, "");
					cs.setString(25, "");
					cs.setString(26, "");
					
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/EmailCustomerInfo.jsp");
			}
			else if (action.equals("ATTEmailCustomerInfoAdd")) 
			{
				String name=request.getParameter("name");
				String cname=request.getParameter("cname");
				String address1=request.getParameter("address1");
				String address2=request.getParameter("address2");
				String address3=request.getParameter("address3");
				String city=request.getParameter("city");
				String district=request.getParameter("district");
				String state=request.getParameter("state");
				String country=request.getParameter("country");
				String pincode=request.getParameter("pincode");
				String fax=request.getParameter("fax");
				String email=request.getParameter("email");
				String website=request.getParameter("website");
				String active=request.getParameter("active");
				String group=request.getParameter("group");
				String department=request.getParameter("department");
				String designation=request.getParameter("designation");
				
				String phone1=request.getParameter("phone1");
				if("".equals(phone1))
					phone1="0";
				String Extn1=request.getParameter("Extn1");
				if("".equals(Extn1))
					Extn1="0";
				String phone2=request.getParameter("phone2");
				if("".equals(phone2))
					phone2="0";
				String Extn2=request.getParameter("Extn2");
				if("".equals(Extn2))
					Extn2="0";
				String mobile1=request.getParameter("mobile1");
				if("".equals(mobile1))
					mobile1="0";
				String mobile2=request.getParameter("mobile2");
				if("".equals(mobile2))
					mobile2="0";
				
				//department,designation,phone1,Extn1,phone2,Extn2,mobile1,mobile2
				if("on".equals(active) || "".equals(active))
					active="Y";
				else
					active="N";
				name=name.trim();
				CallableStatement cs = con.prepareCall("{call COM_PRO_EMAILCUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, cname);
				cs.setString(5, department);
				cs.setString(6, designation);
				cs.setString(7, address1);
				cs.setString(8, address2);
				cs.setString(9, address3);
				cs.setString(10, city);
				cs.setString(11, district);
				cs.setString(12, state);
				cs.setString(13, country);
				cs.setString(14, pincode);
				cs.setString(15, phone1);
				cs.setString(16, Extn1);
				cs.setString(17, phone2);
				cs.setString(18, Extn2);
				cs.setString(19, mobile1);
				cs.setString(20, mobile2);
				cs.setString(21, fax);
				cs.setString(22, email);
				cs.setString(23, website);
				cs.setString(24, active);
				cs.setString(25, group);
				cs.setString(26, user);
				 System.out.println(""+cs);
				cs.execute();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/EmailCustomerInfoAction.jsp?action1=Add&msg=Sucessfully Added...");
			} 
			else if (action.equals("ATTEmailCustomerInfoEdit")) 
			{
				 
				
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String cname=request.getParameter("cname");
				String address1=request.getParameter("address1");
				String address2=request.getParameter("address2");
				String address3=request.getParameter("address3");
				String city=request.getParameter("city");
				String district=request.getParameter("district");
				String state=request.getParameter("state");
				String country=request.getParameter("country");
				String pincode=request.getParameter("pincode");
				String department=request.getParameter("department");
				String designation=request.getParameter("designation");
				
				String phone1=request.getParameter("phone1");
				if("".equals(phone1))
					phone1="0";
				String Extn1=request.getParameter("Extn1");
				if("".equals(Extn1))
					Extn1="0";
				String phone2=request.getParameter("phone2");
				if("".equals(phone2))
					phone2="0";
				String Extn2=request.getParameter("Extn2");
				if("".equals(Extn2))
					Extn2="0";
				String mobile1=request.getParameter("mobile1");
				if("".equals(mobile1))
					mobile1="0";
				String mobile2=request.getParameter("mobile2");
				if("".equals(mobile2))
					mobile2="0";
				String fax=request.getParameter("fax");
				String email=request.getParameter("email");
				String website=request.getParameter("website");
				String active=request.getParameter("active");
				String group=request.getParameter("group");
				if("on".equals(active) || "".equals(active))
					active="Y";
				else
					active="N";
				name=name.trim();
				CallableStatement cs = con.prepareCall("{call COM_PRO_EMAILCUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, cname);
				cs.setString(5, department);
				cs.setString(6, designation);
				cs.setString(7, address1);
				cs.setString(8, address2);
				cs.setString(9, address3);
				cs.setString(10, city);
				cs.setString(11, district);
				cs.setString(12, state);
				cs.setString(13, country);
				cs.setString(14, pincode);
				cs.setString(15, phone1);
				cs.setString(16, Extn1);
				cs.setString(17, phone2);
				cs.setString(18, Extn2);
				cs.setString(19, mobile1);
				cs.setString(20, mobile2);
				cs.setString(21, fax);
				cs.setString(22, email);
				cs.setString(23, website);
				cs.setString(24, active);
				cs.setString(25, group);
				cs.setString(26, user);
				cs.execute();
				cs.close();
				 
				con.close();   
				response.sendRedirect("Smart Attendance/EmailCustomerInfo.jsp");
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
