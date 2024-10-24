package com.my.org.erp.SmartStaff;

import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.SmartMarketing.CustomerInfo;

 
public class  SFACustomerInfoActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			String createdby  = (String) session.getAttribute("EMPID");
			if (action.equals("STACustomerInfoAdd")) 
			{
				CustomerInfo  d = new CustomerInfo();
				@SuppressWarnings("rawtypes")
				Map map = request.getParameterMap();
				BeanUtils.populate(d, map);
				acs = con.prepareCall("{call MKT_PRO_CUSTOMERINFO(  ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3,d.getName());
				acs.setString(4,""+d.getCname());
				acs.setString(5,d.getAddress1());
				acs.setString(6,d.getAddress2());
				acs.setString(7,d.getAddress3());
				acs.setString(8,""+d.getCity());
				acs.setString(9,""+d.getDistrict() );
				acs.setString(10,""+d.getState());
				acs.setString(11,""+d.getCountry() );
				acs.setString(12,""+d.getPincode());
				acs.setString(13,""+d.getPhone1());
				acs.setString(14,""+d.getExtn1());
				acs.setString(15,""+d.getPhone2());
				acs.setString(16,""+d.getExtn2() );
				acs.setString(17,""+d.getMobile1() );
				acs.setString(18,""+d.getMobile2() );
				acs.setString(19,""+d.getFax() );
				acs.setString(20,d.getEmail() );
				acs.setString(21,d.getWebsite() );
				acs.setString(22,d.getActive() );
				acs.setString(23,""+d.getGroup() );
				acs.setString(24, createdby);
				acs.setString(25, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("Staff/SFACustomerInformationsActions.jsp?action1=Add&msg=Sucessfully Added...");
			} 
			else if (action.equals("STACustomerInfoEdit")) 
			{
				 
				CustomerInfo  d = new CustomerInfo();
				@SuppressWarnings("rawtypes")
				Map map = request.getParameterMap();
				BeanUtils.populate(d, map);
				acs = con.prepareCall("{call MKT_PRO_CUSTOMERINFO(?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2,""+d.getRowid());
				acs.setString(3,d.getName());
				acs.setString(4,""+d.getCname());
				acs.setString(5,d.getAddress1());
				acs.setString(6,d.getAddress2());
				acs.setString(7,d.getAddress3());
				acs.setString(8,""+d.getCity());
				acs.setString(9,""+d.getDistrict() );
				acs.setString(10,""+d.getState());
				acs.setString(11,""+d.getCountry() );
				acs.setString(12,""+d.getPincode());
				acs.setString(13,""+d.getPhone1());
				acs.setString(14,""+d.getExtn1());
				acs.setString(15,""+d.getPhone2());
				acs.setString(16,""+d.getExtn2() );
				acs.setString(17,""+d.getMobile1() );
				acs.setString(18,""+d.getMobile2() );
				acs.setString(19,""+d.getFax() );
				acs.setString(20,d.getEmail() );
				acs.setString(21,d.getWebsite() );
				acs.setString(22,d.getActive() );
				acs.setString(23,""+d.getGroup() );
				acs.setString(24, createdby);
				acs.setString(25, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("Staff/SFACustomerInformations.jsp");
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
