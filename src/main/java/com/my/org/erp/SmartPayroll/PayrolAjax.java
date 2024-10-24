package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@SuppressWarnings("serial")
@WebServlet("/Payroll")
public class PayrolAjax extends HttpServlet
{
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
		try
			{
				String action=request.getParameter("actionS");
				if(Authenticator.isAuthenticated(request))
				{ 
					
					if(action.equals("loadAllowances"))
					{	
						PayrollMethod.loadAllowances(request, response);
					}
					else if(action.equals("loadRecoverys"))
					{	
						PayrollMethod.loadRecoverys(request, response);
					}
					else if(action.equals("LoadPFwages"))
					{	
						PayrollMethod.LoadPFwages(request, response);
					}
					
					else if(action.equals("PAYRivision"))
					{	
						PayrollMethod.PAYRivision(request, response);
					}
					else if(action.equals("PAYAdvance"))
					{	
						PayrollMethod.PAYAdvance(request, response);
					}	
					else if(action.equals("PAYMess"))
					{
						PayrollMethod.PAYMess(request, response);
					}
					else if(action.equals("PAYTransfer"))
					{
						PayrollMethod.PAYTransfer(request, response);
					}
					else if(action.equals("loadPayrollRevision"))
					{
						PayrollMethod.PAYPayrollRevision(request, response);
					}
					else if(action.equals("loadPayrollRevisionAccep"))
					{
						PayrollMethod.loadPayrollRevisionAccep(request, response);
					}
					else if(action.equals("PAYPromotion"))
					{
						PayrollMethod.PAYPromotion(request, response);
					}
					else if(action.equals("PAYCessation"))
					{
						PayrollMethod.PAYCessation(request, response);
					}
					else if(action.equals("PAYAllowRecov"))
					{
						PayrollMethod.PAYAllowanceRecovery(request, response);
					}
					else if(action.equals("AllowanceRecovery"))
					{
						PayrollMethod.AllowanceRecovery(request, response);
					}
					else if("PAYLoadTax".equals(action))
					{
						PayrollMethod.payLoadTax(request, response);
					}
					else if("PAYLoadTaxValue".equals(action))
					{
						PayrollMethod.payLoadTaxValue(request, response);
					}
					else if("ALLOWANCEUPDATE".equals(action))
					{
						PayrollMethod.PAYAllowanceUpdate(request, response);
					}
					else if(action.equals("PAYExit"))
					{
						PayrollMethod.PAYExit(request, response);
					}
					else if(action.equals("PAYResignation"))
					{
						PayrollMethod.PAYResignation(request, response);
					}
					else if(action.equals("loadResignationmovetoCessation"))
					{
						PayrollMethod.loadResignationmovetoCessation(request, response);
					}
					else if(action.equals("PAYReliving"))
					{
						PayrollMethod.PAYReliving(request, response);
					}
					else if("LoadPayTaxdeduction".equals(action))
					{
						PayrollMethod.LoadPayTaxdeduction(request, response);
					}
					else if("PAYITMaster".equals(action))
					{
						PayrollMethod.PAYITMaster(request, response);
					}
					else if("PAYPreviousTakeups".equals(action))
					{
						PayrollMethod.PAYPreviousTakeups(request, response);
					}
					else if("PAYloadPFCliamStatus".equals(action))
					{
						PayrollMethod.PAYloadPFCliamStatus(request, response);
					}
					else if("loadTemporarysuspension".equals(action))
					{
						PayrollMethod.loadTemporarysuspension(request, response);
					}	
					else if("loadStaff".equals(action))
					{
						PayrollMethod.loadStaff(request, response);
					}
					else if("loadStaffSearch".equals(action))
					{
						PayrollMethod.loadStaffSearch(request, response);
					}
					else if(action.equals("LoadNDCStore"))
					{
						PayrollMethod.LoadNDCStore(request, response);
					}
					else if(action.equals("LoadNDCAccounts"))
					{
						PayrollMethod.LoadNDCAccounts(request, response);
					}
					else if(action.equals("LoadNDCHR"))
					{
						PayrollMethod.LoadNDCHR(request, response);
					}
					else if(action.equals("LoadNDC_General"))
					{
						PayrollMethod.LoadNDC_General(request, response);
					}
					else if(action.equals("LoadNDCFinalAccept"))
					{
						PayrollMethod.LoadNDCFinalAccept(request, response);
					}
					else if(action.equals("loadLoan"))
					{				
						PayrollMethod.loadLoan(request, response) ;	    
					}
					else if(action.equals("loadLoanCredit"))
					{				
						PayrollMethod.loadLoanCredit(request, response) ;	    
					}
					else if(action.equals("loadLoanDebit"))
					{				
						PayrollMethod.loadLoanDebit(request, response) ;	    
					}
					else if(action.equals("IncomeLoadTaxValue"))
					{				
						PayrollMethod.IncomeLoadTaxValue(request, response) ;	    
					}
					else if(action.equals("PAYBalance"))
					{
						PayrollMethod.PAYBalance(request, response);
					}	
					if(action.equals("LoadSelectEmpid"))
					{	
						PayrollMethod.LoadSelectEmpid(request,response);			    
					}
	 
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
    
