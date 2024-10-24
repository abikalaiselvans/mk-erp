package com.my.org.erp.SmartInventory;
import java.io.IOException;

import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.inventory.CustomerInfo;

public class CustomerInfoActionHandler extends AbstractActionHandler
{
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				 
				HttpSession session=request.getSession();			
				@SuppressWarnings("unused")
				String userId=""+session.getAttribute("USRID");
				 
				String sql="";
				if("INVCustomerInfoAdd".equals(action))
				{
					CustomerInfo d = new CustomerInfo();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					CustomerInfoMethod.addCustomerInfo( con,apstm, d, request, response);
					con.close();   
					response.sendRedirect("Smart Inventory/CustomerInfo.jsp");
				}	
				else if("INVCustomerInfoUpdate".equals(action))
				{
					
					CustomerInfo d = new CustomerInfo();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					CustomerInfoMethod.updateCustomerInfo(con,apstm,  d, request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/CustomerInfo.jsp");
				}
				else if("INVCustomerInfoDelete".equals(action))
				{
					String custids[] = request.getParameterValues("custid");
					sql = "DELETE FROM inv_m_customerinfo Where  INT_CUSTOMERID = ?";
					apstm=con.prepareStatement(sql);
				 	for(int u=0; u<custids.length;u++)
					{
						apstm.setString(1, custids[u]);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					con.close();   
					response.sendRedirect("Smart Inventory/CustomerInfo.jsp");
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