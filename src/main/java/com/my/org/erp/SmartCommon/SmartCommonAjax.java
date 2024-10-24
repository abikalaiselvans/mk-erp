 package com.my.org.erp.SmartCommon;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.Authenticator;

@WebServlet("/SmartCommonAjax")
public class SmartCommonAjax extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];
	public  void doGet(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	{
		try
		{
			String action=request.getParameter("actionS");	
			System.out.println(action);
			if(Authenticator.isAuthenticated(request))
			{
				if(action.equals("loadCountry"))
				 {				
					 SmartCommonMethod.loadCountry(request, response) ;	  
				 }
				 else if(action.equals("loadState"))
				 {				
					 SmartCommonMethod.loadState(request, response) ;	    
				 }
				 else if(action.equals("loadDistrict"))
				 {				
					 SmartCommonMethod.loadDistrict(request, response) ;	    
				 }	
				 else if(action.equals("LoadCity"))
				 {				
					 SmartCommonMethod.LoadCity(request, response) ;	    
				 }
				 else if(action.equals("loadCompany"))
				 {				
					 SmartCommonMethod.loadCompany(request, response) ;	    
				 }
				 else if(action.equals("loadBranch"))
				 {				
					 SmartCommonMethod.loadBranch(request, response) ;	    
				 }
				 else if(action.equals("loadBranchSelect"))
				 {				
					 SmartCommonMethod.loadBranchSelect(request, response) ;	    
				 }
				 else if(action.equals("loadOffice"))
				 {				
					 SmartCommonMethod.LoadOffice(request, response) ;	    
				 }
				 else if(action.equals("loadDepartment"))
				 {				
					 SmartCommonMethod.loadDepartment(request, response) ;	    
				 }
				 else if(action.equals("loadDesignation"))
				 {				
					 SmartCommonMethod.loadDesignation(request, response) ;	    
				 }
				 else if(action.equals("loadBloodGroup"))
				 {				
					 SmartCommonMethod.loadBloodGroup(request, response) ;	    
				 }
				 else if(action.equals("LoadQualification"))
				 {				
					 SmartCommonMethod.LoadQualification(request, response) ;	    
				 }
				 else if(action.equals("DatatableLoadQualification"))
				 {				
					 SmartCommonMethod.DatatableLoadQualification(request, response) ;	    
				 }
				 else if(action.equals("loadEmployeeCategory"))
				 {				
					 SmartCommonMethod.loadEmployeeCategory(request, response) ;	    
				 }
				 else if(action.equals("loadStaffType"))
				 {				
					 SmartCommonMethod.loadStaffType(request, response) ;	    
				 }
				 else if(action.equals("loadDispensary"))
				 {				
					 SmartCommonMethod.loadDispensary(request, response) ;	    
				 }
				 else if(action.equals("loadCertification"))
				 {				
					 SmartCommonMethod.loadCertification(request, response) ;	    
				 }
				 else if(action.equals("loadCertificationTrack"))
				 {				
					 SmartCommonMethod.loadCertificationTrack(request,response);			    
				 } 
				 else if(action.equals("LoadIdProof"))
				 {				
					 SmartCommonMethod.LoadIdProof(request, response) ;	    
				 }
				 else if(action.equals("loadBank"))
				 {				
					 SmartCommonMethod.loadBank(request, response) ;	    
				 } 
				 else if(action.equals("loadBankBranch"))
				 {				
					 SmartCommonMethod.loadBankBranch(request, response) ;	    
				 }
				 else if(action.equals("loadStaff"))
				 {				
					 SmartCommonMethod.loadStaff(request, response) ;	    
				 } 
				 else if(action.equals("loadStaffSearch"))
				 {				
					 SmartCommonMethod.loadStaffSearch(request, response) ;	    
				 }
				 else if(action.equals("loadStaffAccountNumberSearch"))
				 {				
					 SmartCommonMethod.loadStaffAccountNumberSearch(request, response) ;	    
				 }
				 else if(action.equals("loadStaffPFESI"))
				 {				
					 SmartCommonMethod.loadStaffPFESI(request, response) ;	    
				 }
				 else if(action.equals("loadStaffPFESIClaims"))
				 {				
					 SmartCommonMethod.loadStaffPFESIClaims(request, response) ;	    
				 }
				 else if(action.equals("loadlocation"))
				 {				
					 SmartCommonMethod.loadlocation(request, response) ;	    
				 }
				 else if(action.equals("loadlocationActive"))
				 {				
					 SmartCommonMethod.loadlocationActive(request, response) ;	    
				 } 
				
				 else if(action.equals("loadAttendanceCycle"))
				 {				
					 SmartCommonMethod.loadAttendanceCycle(request, response) ;	    
				 }
				 else if(action.equals("loadBranchInSelect"))
				 {				
					 SmartCommonMethod.loadBranchData(request, response) ;	    
				 } 
				 else if(action.equals("loadReportingHead"))
				 {				
					 SmartCommonMethod.loadReportingHead(request, response) ;	    
				 }
				 else if(action.equals("StaffRegistrationUnique"))
				 {				
					 SmartCommonMethod.StaffRegistrationUnique(request, response) ;	    
				 }
				
			}
			else { 
				System.out.println("Authenticator Failor. Kindly login");
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
    
