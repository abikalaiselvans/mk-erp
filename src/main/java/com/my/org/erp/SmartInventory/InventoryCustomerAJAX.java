package com.my.org.erp.SmartInventory;

import static com.my.org.erp.SmartInventory.InventoryMethod.loadDelivaryData;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.Authenticator;

@WebServlet("/inventoryCustomer")
public class InventoryCustomerAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
    public void init(ServletConfig config) throws ServletException 
    {        
    }   

    public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
		try
		{
			String action=request.getParameter("actionS");
			if(Authenticator.isAuthenticated(request))
			{ 
				if(action.equals("INVCustomerPurchaseOrder"))
				{
					InventoryMethod.loadCustomerPurchaseOrder(request,response);
				}	
				else if(action.equals("INVDelivary"))
				{
					loadDelivaryData(request,response);    
				}
				else if(action.equals("INVDel"))
				{
					InventoryMethod.loadDelData(request,response);    
				}
				else if(action.equals("INVInvoice"))
				{			
					InventoryMethod.loadInvoiceData(request,response);    
				}
				else if(action.equals("INVCashSale"))
				{
					InventoryMethod.loadCashSale(request,response);    
				}
				else if(action.equals("INVDirectSale"))
				{
					InventoryMethod.loadDirectSale(request,response);    
				}
				else if(action.equals("INVSwapSale"))
				{
					InventoryMethod.loadDSwapSale(request,response);    
				}
				else if(action.equals("INVACCSwapSale"))
				{
					InventoryMethod.loadDACCSwapSale(request,response);    
				}
				else if(action.equals("INVACCServiceBill"))
				{
					InventoryMethod.INVACCServiceBill(request,response);    
				}
				else if(action.equals("INVDirectPurchase"))
				{
					InventoryMethod.loadDirectPurchase(request,response);    
				}
				else if(action.equals("INVACCDirectPurchase"))
				{
					InventoryMethod.loadACCDirectPurchase(request,response);    
				}
				else if(action.equals("CustomerAddress"))
				{
					InventoryMethod.loadCustomerAddress(request,response);    
				}
				else if(action.equals("checkSerial"))
				{
					InventoryMethod.loadcheckSerial(request,response);    
				}
				else if(action.equals("LoadSwapcheckSerial"))
				{
					InventoryMethod.LoadSwapcheckSerial(request,response);    
				}
				else if(action.equals("removedItemSerial"))
				{
					InventoryMethod.loadcremovedItemSerial(request,response);    
				}
				else if(action.equals("INVPaymentCommitment"))
				{
					InventoryMethod.loadPaymentCommitment(request,response);    
				}
				else if(action.equals("INVSaleInstallation"))
				{
					InventoryMethod.LoadSalesInstallation(request,response);    
				}
				else if(action.equals("INVLoadInstallationUpdation"))
				{
					InventoryMethod.LoadInstallationUpdation(request,response);    
				}
				
				
				
				
				
				
				
				
				/*
				 *
				 * Spare module starting here
				 */

				
				else if(action.equals("LoadSSparedemand"))
				{
					InventoryMethod.LoadSSparedemand(request,response);    
				}
				else if(action.equals("INVloadspareissue"))
				{
					InventoryMethod.LoadSpareissue(request,response);  //LoadSSpareissue  
				}
				else if(action.equals("LoadAssignsparedemand"))
				{
					InventoryMethod.LoadAssignsparedemand(request,response);    
				}
				else if(action.equals("INVloadspareitemproduct"))
				{
					InventoryMethod.spareissueItemProduct(request, response);    
				}
				else if(action.equals("INVloadsparereturn"))
				{
					InventoryMethod.LoadSparereturn(request,response);    
				}
				else if(action.equals("Loadvalidserialno"))
				{
					InventoryMethod.Checkserialno(request,response);    
				}
				else if(action.equals("Loadvalidqtyno"))
				{
					InventoryMethod.CheckQtyno(request,response);    
				}
				else if(action.equals("Loadvalidproductcode"))
				{
					InventoryMethod.Checkproductcode(request,response);    
				}
				else if(action.equals("INVAssignsparedemand"))
				{
					InventoryMethod.LoadSparedemandissue(request,response);    
				}
				else if(action.equals("Loadvalidqtynoedit"))
				{
					InventoryMethod.CheckQtyconsumno(request,response);    
				}
				/*
				 *
				 * Spare module end Here
				 */
				
				
				
				

			}
			else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			
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
    
   