package com.my.org.erp.Account;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 


@WebServlet("/Account")
public class AccountAjax extends HttpServlet{
	private static final long serialVersionUID = 1L;
	String readData[][];
	
	 

 public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
 {
		try
		{
			String action=request.getParameter("actionS");	
			 
			if("LoadType".equals(action))
            {	
            	AccountMethod.LoadType(request,response);
            }
            else if("LoadTypeGroup".equals(action))
            {	
            	AccountMethod.LoadTypeGroup(request,response);
            }
            else if("LoadTypeSubGroup".equals(action))
            {	
            	AccountMethod.LoadTypeSubGroup(request,response);
            }
            else if("LoadTypeSubsidiaryGroup".equals(action))
            {	
            	AccountMethod.LoadTypeSubsidiaryGroup(request,response);
            }
            else if("LoadVouchers".equals(action)) 
            {	
            	AccountMethod.LoadVouchers(request,response);
            }
			
			
            else if("Group".equals(action))
            {	
				AccountMethod.LoadGroup(request,response);
            }	
            else if("Receipts".equals(action))
            {	
            	AccountMethod.LoadIncome(request,response);
            }	
            else if("Payments".equals(action))
            {	
            	AccountMethod.LoadExpense(request,response);
            }	
            else if("LoadBranchess".equals(action))
            {	
            	AccountMethod.LoadBranchess(request,response);
            }
            else if("LoadDayDifference".equals(action))
            {	
            	AccountMethod.LoadDayDifference(request,response);
            }	
            else if("LoadAccountGroup".equals(action))
            {	
            	AccountMethod.LoadAccountGroup(request,response);
            }
            else if("LoadAccountMaster".equals(action))
            {	
            	AccountMethod.LoadAccountMaster(request,response);
            }
            
            else if("LoadSales".equals(action))
            {	
            	AccountMethod.LoadSales(request,response);
            }
            else if("LoadPurchase".equals(action))
            {	
            	AccountMethod.LoadPurchase(request,response);
            }
            else if("LoadPurchaseReturn".equals(action))
            {	
            	AccountMethod.LoadPurchaseReturn(request,response);
            }
            else if("LoadSalesReturn".equals(action))
            {	
            	AccountMethod.LoadSalesReturn(request,response);
            }
            else if("LoadPaymentsEntry".equals(action))
            {	
            	AccountMethod.LoadPaymentsEntry(request,response);
            }
            else if("LoadReceiptsEntry".equals(action))
            {	
            	AccountMethod.LoadReceiptsEntry(request,response);
            }
            else if("LoadJournel".equals(action))
            {	
            	AccountMethod.LoadJournel(request,response);
            }
            else if("LoadContra".equals(action))
            {	
            	AccountMethod.LoadContra(request,response);
            }
            else if("LoadDebit".equals(action))
            {	
            	AccountMethod.LoadDebit(request,response);
            } 
            else if("LoadCredit".equals(action))
            {	
            	AccountMethod.LoadCredit(request,response);
            }
            
            else if("LoadDayBook".equals(action))
            {	
            	AccountMethod.LoadDayBook(request,response);
            }
            else if("LoadDateCheck".equals(action))
            {	
            	AccountMethod.LoadDateCheck(request,response);
            }
            else if("LoadLedger".equals(action))
            {	
            	AccountMethod.LoadLedger(request,response);
            }
            else if("LoadRuntimeLedger".equals(action))
            {	
            	AccountMethod.LoadRuntimeLedger(request,response);
            }
			
			
			
		 
		} catch (Exception e) {
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}			
    }
    
 
}
    
