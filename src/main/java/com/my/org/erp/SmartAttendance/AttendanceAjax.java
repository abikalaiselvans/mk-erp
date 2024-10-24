package com.my.org.erp.SmartAttendance;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@WebServlet("/attendance")
public class AttendanceAjax extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];
	 public  void doGet(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	 {
		try
		{
			String action=request.getParameter("actionS");
			if(Authenticator.isAuthenticated(request))
			{
		 	 
				 if(action.equals("ATTdistrict"))
				 {				
					 AttendanceMethod.loadDistrict(request,response);			    
				 }	
				 else if(action.equals("ATTstaff"))
				 {				
					 AttendanceMethod.loadStaff(request,response);			    
				 }
				 else if(action.equals("PermissionLeave"))
				 {		
					 AttendanceMethod.PermissionLeave(request,response);			    
				 }
				 else if(action.equals("loadPermissionLeaveRegisterMark"))
				 {		
					 AttendanceMethod.loadPermissionLeaveRegisterMark(request,response);			    
				 }
				 else if(action.equals("AttOnduty"))
				 {				
					 AttendanceMethod.loadOnduty(request,response);			    
				 }
				 else if(action.equals("AttStaffHold"))
				 {				
					 AttendanceMethod.loadStaffHold(request,response);			    
				 }
				 else if(action.equals("AttManual"))
				 {				
					 AttendanceMethod.loadManual(request,response);			    
				 }
				 else if(action.equals("AttPermission"))
				 {				
					 AttendanceMethod.loadPermission(request,response);			    
				 }
				 else if(action.equals("LoadAbsentDays"))
				 {				
					 AttendanceMethod.LoadAbsentDays(request,response);			    
				 }
				 else if(action.equals("LoadContinuousEntryDays"))
				 {				
					 AttendanceMethod.LoadContinuousEntryDays(request,response);			    
				 }
				 else if(action.equals("ATTbranch"))
				 {				
					 AttendanceMethod.loadBranchData(request,response);			    
				 }	 
				 else if(action.equals("ATTholiday"))
				 {				
					 AttendanceMethod.loadHolidayData(request,response);			    
				 }
				 else if(action.equals("loadStaffName"))
				 {				
					 AttendanceMethod.loadStaffName(request,response);			    
				 }
				 else if(action.equals("ATTovertime"))
				 {				
					 AttendanceMethod.loadOverTime(request,response);			    
				 }
				 else if (action.equals("ATTextraDays"))
				 {
					 AttendanceMethod.loadExtraDays(request, response);
				 }
				 else if (action.equals("ATTextraDayschk"))
				 {
					 AttendanceMethod.loadExtraDayschk(request, response);
				 }
				 else if(action.equals("ATTCompensation"))
				 {				
					 AttendanceMethod.loadCompensationData(request,response);			    
				 }	 
				 else if(action.equals("ATTShift"))
				 {				
					 AttendanceMethod.loadShiftData(request,response);			    
				 }		
				 else if(action.equals("AttLeave"))
				 {				
					 AttendanceMethod.loadLeaveData(request,response);			    
				 }
				 else if(action.equals("AttLeaves"))
				 {				
					 AttendanceMethod.loadLeaveDatas(request,response);			    
				 }
				 else if(action.equals("AttQuery"))
				 {				
					 AttendanceMethod.loadAttQuery(request,response);			    
				 }
				 else if(action.equals("ATTBranch"))
				 {				
				 	 AttendanceMethod.loadBranch(request,response);			    
				 }
				 else if(action.equals("CommonHoliday"))
				 {				
					 AttendanceMethod.loadCommonHolidayData(request,response);			    
				 }
				 else if(action.equals("AttProxy"))
				 {				
					 AttendanceMethod.loadProxy(request,response);			    
				 }
				 else if(action.equals("LoadEmailCustomerGroup"))
				 {				
					 AttendanceMethod.LoadEmailCustomerGroup(request,response);			    
				 }
				 else if(action.equals("LoadEmailCustomerinfo"))
				 {				
					 AttendanceMethod.LoadEmailCustomerinfo(request,response);			    
				 }
				 else if(action.equals("loadCertification"))
				 {				
					 AttendanceMethod.loadCertification(request,response);			    
				 }
				
				 else if(action.equals("loadEmployeeCategory"))
				 {				
					 AttendanceMethod.loadEmployeeCategory(request,response);			    
				 }
				 else if(action.equals("loadStaffType"))
				 {				
					 AttendanceMethod.loadStaffType(request,response);			    
				 }
				 else if(action.equals("loadBloodGroup"))
				 {				
					 AttendanceMethod.loadBloodGroup(request,response);			    
				 }
				 else if(action.equals("LoadQualification"))
				 {				
					 AttendanceMethod.LoadQualification(request,response);			    
				 }
				 else if(action.equals("LoadIdProof"))
				 {				
					 AttendanceMethod.LoadIdProof(request,response);			    
				 }
				 else if(action.equals("loadLeaveEntry"))
				 {				
					 AttendanceMethod.loadLeaveEntry(request,response);			    
				 }
				 else if(action.equals("checkLeaveBalance"))
				 {				
					 AttendanceMethod.checkLeaveBalance(request,response);			    
				 }
				 else if(action.equals("StaffPermissionLeave"))
				 {		
					 AttendanceMethod.StaffPermissionLeave(request,response);			    
				 }
				 else if(action.equals("ForceLeaveandPermission"))
				 {		
					 AttendanceMethod.ForceLeaveandPermission(request,response);			    
				 }
				 else if(action.equals("loadAttendanceReport"))
				 {		
					 AttendanceMethod.loadAttendanceReport(request,response);			    
				 }
				 else if(action.equals("loadAttendanceReport1"))
				 {		
					 AttendanceMethod.loadAttendanceReport1(request,response);			    
				 }
				 else if(action.equals("AttShiftMaster"))
				 {				
					 AttendanceMethod.loadShiftMaster(request,response);			    
				 }
			}
			else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		} 
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}			
    }
    
 
}
    
