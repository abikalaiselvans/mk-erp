package com.my.org.erp.SmartMarketing;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class EmailBranchActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String user=""+session.getAttribute("USRID");			
			if ("MKTEmailBranchAdd".equals(action)) 
			{
				
				String company=request.getParameter("company");
				String bname=request.getParameter("bname");
				String address1=request.getParameter("address1");
				String address2=request.getParameter("address2");
				String address3=request.getParameter("address3");
				String city=request.getParameter("city");
				String state=request.getParameter("state");
				String pincode=request.getParameter("pincode");
				String stdcode=request.getParameter("stdcode");
				if("".equals(stdcode))
					stdcode="0";
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
				
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, company);
				cs.setString(4, bname);
				cs.setString(5, address1);
				cs.setString(6, address2);
				cs.setString(7, address3);
				cs.setString(8, city);
				cs.setString(9, state);
				cs.setString(10, pincode);
				cs.setString(11, stdcode);
				cs.setString(12, phone1);
				cs.setString(13, Extn1);
				cs.setString(14, phone2);
				cs.setString(15, Extn2);
				cs.setString(16, mobile1);
				cs.setString(17, mobile2);
				cs.setString(18, fax);
				cs.setString(19, email);
				cs.setString(20, website);
				cs.setString(21, user);	
				cs.execute();
				cs.close();
				 
				response.sendRedirect("Smart Marketing/EmailBranchAction.jsp?action1=Add&msg=Record Added Successfully");
			} 		
			else if ("MKTEmailBranchEdit".equals(action)) 
			{
				String id=request.getParameter("id");
				String company=request.getParameter("company");
				String bname=request.getParameter("bname");
				String address1=request.getParameter("address1");
				String address2=request.getParameter("address2");
				String address3=request.getParameter("address3");
				String city=request.getParameter("city");
				String state=request.getParameter("state");
				String pincode=request.getParameter("pincode");
				
				String stdcode=request.getParameter("stdcode");
				if("".equals(stdcode))
					stdcode="0";
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
				
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, company);
				cs.setString(4, bname);
				cs.setString(5, address1);
				cs.setString(6, address2);
				cs.setString(7, address3);
				cs.setString(8, city);
				cs.setString(9, state);
				cs.setString(10, pincode);
				cs.setString(11, stdcode);
				cs.setString(12, phone1);
				cs.setString(13, Extn1);
				cs.setString(14, phone2);
				cs.setString(15, Extn2);
				cs.setString(16, mobile1);
				cs.setString(17, mobile2);
				cs.setString(18, fax);
				cs.setString(19, email);
				cs.setString(20, website);
				cs.setString(21, user);	
				cs.execute();
				cs.close();
				 				
				response.sendRedirect("Smart Marketing/EmailBranch.jsp");
			} 	
			else if ("MKTEmailBranchDelete".equals(action)) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				 				
				response.sendRedirect("Smart Marketing/EmailBranch.jsp");
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
