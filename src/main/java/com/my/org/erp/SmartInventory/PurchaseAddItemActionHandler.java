package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class PurchaseAddItemActionHandler extends AbstractActionHandler
{
	
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				 		
				 
				Statement st = con.createStatement();
				String sql="";
				for(int u=0; u<20; u++)
					//System.out.println();
				if("INVPurchaseAddItem".equals(action))
				{
					String itemid=request.getParameter("item");
					String description=request.getParameter("description");
					String Quantity=request.getParameter("Quantity");
					String unitprice=request.getParameter("unitprice");
					String discount=request.getParameter("discount");
					String unitdiscount=request.getParameter("unitdiscount");
					String amount=request.getParameter("amount");
					sql = "INSERT INTO inv_m_itemadd (INT_ITEMID, CHR_DESC , " +
							" INT_QUANTITY , DOU_UNITPRICE ,CHR_DISCOUNT ," +
							" DOU_UNITDISCOUNT , DOU_AMOUNT ) VALUES (";
					sql = sql+Integer.parseInt(itemid)+" , ";
					sql = sql +"'" +description+"' , ";
					sql = sql+Integer.parseInt(Quantity)+" , ";
					sql = sql+Double.parseDouble(unitprice)+" , ";
					sql = sql +"'" +discount+"' , ";
					sql = sql+Double.parseDouble(unitdiscount)+" , ";
					sql = sql+Double.parseDouble(amount)+" ) ";
					//System.out.println(sql);
					st.execute(sql); 
					con.close();    
					response.sendRedirect("Smart Inventory/sample.jsp");
				}	
				else if("INVPurchaseAddItemClear".equals(action))
				{
					sql = "DELETE FROM inv_m_itemadd ";
					st.execute(sql);
					con.close();   
					response.sendRedirect("Smart Inventory/sample.jsp");
				}
				else if("INVPurchaseDeleteItem".equals(action))
				{
					int id = Integer.parseInt(request.getParameter("id"));
					sql = "DELETE FROM inv_m_itemadd WHERE INT_ID ="+id;
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/sample.jsp");
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