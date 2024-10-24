package com.my.org.erp.SmartPayroll;

import java.io.IOException; 
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler; 

import com.my.org.erp.bean.payroll.ExitInterview;

public class ExitInterviewActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			 
			if("PAYExitInterview".equals(action))
			{
				asql = " INSERT INTO  pay_t_exitinterview (CHR_EMPID,DAT_CREATIONTIME ) VALUES (?,NOW() )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, request.getParameter("ename"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Payroll/ExitInterviewView.jsp");
			}
			 
			else if("PAYExitInterviewDelete".equals(action)) 
			{
				asql = " DELETE FROM pay_t_exitinterview WHERE CHR_STATUS='N' AND INT_EXITID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, request.getParameter("staffid"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Payroll/ExitInterviewView.jsp");
				
			}
			else if("PAYExitInterviewAdds".equals(action)) 
			{
				ExitInterview d = new ExitInterview();
				@SuppressWarnings("rawtypes")
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				ExitInterviewAdds(request, response,d);
				con.close();   
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
			} 
			else if("PAYExitInterviewStaffAdd".equals(action))  
			{
				ExitInterview d = new ExitInterview();
				@SuppressWarnings("rawtypes")
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				ExitInterviewAdds(request, response,d);
				con.close();   
				response.sendRedirect("Smart Attendance/iframeStaffMain.jsp");
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

	
	private void ExitInterviewAdds(HttpServletRequest request,HttpServletResponse response,ExitInterview d) throws ServletException, IOException 
	{
		try 
		{
			asql = "";
			asql = "UPDATE pay_t_exitinterview SET CHR_EMPID=?,CHR_REASON1=?,";
			asql = asql + " CHR_REASON2=?,CHR_REASON3=?,CHR_REASON4=?,";
			asql = asql + " CHR_REASON5=?,CHR_REASON6=?,CHR_REASON7=?,";
			asql = asql + " CHR_REASON8=?,CHR_REASON9=?,CHR_REASON10=?,";
			asql = asql + " CHR_REASON11=?,CHR_REASON12=?,CHR_REASON13=?,";
			asql = asql + " CHR_REASON14=?,CHR_REASON15=?,CHR_REASON16=?,";
			asql = asql + " CHR_REASON17=?,CHR_REASON18=?,CHR_REASON19=?,";
			asql = asql + " CHR_REASON20=?, ";
			asql = asql + " DAT_INTERVIEWDATE=DATE(NOW()),CHR_STATUS='Y',CHR_USRNAME=?, ";
			asql = asql + " DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'  WHERE INT_EXITID=?";
			 
			
			apstm = con.prepareStatement(asql);
			apstm.setString(1, d.getEmpid());
			apstm.setString(2, d.getReason1());
			apstm.setString(3, d.getReason2());
			apstm.setString(4, d.getReason3());
			apstm.setString(5, d.getReason4());
			apstm.setString(6, d.getReason5());
			apstm.setString(7, d.getReason6());
			apstm.setString(8, d.getReason7());
			apstm.setString(9, d.getReason8());
			apstm.setString(10, d.getReason9());
			apstm.setString(11, d.getReason10());
			apstm.setString(12, d.getReason11());
			apstm.setString(13, d.getReason12());
			apstm.setString(14, d.getReason13());
			apstm.setString(15, d.getReason14());
			apstm.setString(16, d.getReason15());
			apstm.setString(17, d.getReason16());
			apstm.setString(18, d.getReason17());
			apstm.setString(19, d.getReason18());
			apstm.setString(20, d.getReason19());
			apstm.setString(21, d.getReason20());
			apstm.setString(22, auserid);
			apstm.setString(23, d.getRowid());
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
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
