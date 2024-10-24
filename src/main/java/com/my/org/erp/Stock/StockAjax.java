package com.my.org.erp.Stock;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 


@WebServlet("/Stock")
public class StockAjax extends HttpServlet{
	private static final long serialVersionUID = 1L;
	String readData[][];
	
	 

 @SuppressWarnings("deprecation")
public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
 {
		try
		{
			String action=request.getParameter("actionS");	
			// System.out.println(request.getRealPath("/"), action);
 			
			if("LoadBranchess".equals(action))
			{
            	StockMethod.LoadBranchess(request,response);
			}	
            else if("LoadUnits".equals(action))
            {
            	StockMethod.LoadUnits(request,response);
            }
            else if("LoadItemGroup".equals(action))
            {
            	StockMethod.LoadItemGroup(request,response);
            }	
            else if("LoadItemList".equals(action))
            {
            	StockMethod.LoadItemList(request,response);
            }
            else if("LoadTermandCondition".equals(action))
            {
            	StockMethod.LoadTermandCondition(request,response);
            }
            else if("LoadPayment".equals(action))
            {
            	StockMethod.LoadPayment(request,response);
            }
            else if("LoadTax".equals(action))
            {
            	StockMethod.LoadTax(request,response);
            }
            else if("LoadBank".equals(action))
            {
            	StockMethod.LoadBank(request,response);
            }
            else if("LoadBankBranch".equals(action))
            {
            	StockMethod.LoadBankBranch(request,response);
            }
            else if("LoadDivision".equals(action))
            {
            	StockMethod.LoadDivision(request,response);
            }
            else if("LoadTargetAssign".equals(action))
            {
            	StockMethod.LoadTargetAssign(request,response);
            }
            else if("LoadTCustomerGroup".equals(action))
            {
            	StockMethod.LoadTCustomerGroup(request,response);
            }
            else if("LoadVendorGroup".equals(action))
            {
            	StockMethod.LoadVendorGroup(request,response);
            }
            else if("LoadCustomer".equals(action))
            {
            	StockMethod.LoadCustomer(request,response);
            }
            else if("LoadVendor".equals(action))
            {
            	StockMethod.LoadVendor(request,response);
            }
            else if("INVItemProductAssign".equals(action))
            {
            	StockMethod.ItemProductAssign(request,response);
            }
            else if("INVItemProductAssignQuotation".equals(action))
            {
            	StockMethod.ItemProductAssignQuotation(request,response);
            }
		    else if("LoadDirectPurchase".equals(action))
            {
            	StockMethod.LoadDirectPurchase(request,response);
            }
		    else if("LoadStock".equals(action))
		    {
		    	StockMethod.LoadStock(request,response);
		    }
		    else if(action.equals("StockCustomer"))
		    {
		    	StockMethod.loadCustomer(request,response);			    
			}
		    else if(action.equals("CustomerAddress"))
		    {
		    	StockMethod.loadCustomerAddress(request,response);    
			}
		    else if(action.equals("LoadDirectSale"))
		    {
		    	StockMethod.loadDirectSale(request,response);    
			}
		    else if(action.equals("LoadQuotation"))
		    {
		    	StockMethod.LoadQuotation(request,response);    
			}
			
		 
		} catch (Exception e) {
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}			
    }
    
 
}
    
