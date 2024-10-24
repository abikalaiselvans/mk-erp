package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.* ;
 
public class EmployeeWiseAllowanceTransferActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)		throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String month = request.getParameter("month");
			String mont = DateUtil.getMonth(Integer.parseInt(month));
			String year = request.getParameter("year");
			String ename = request.getParameter("ename");
			int y = Integer.parseInt(year);
			int days =Integer.parseInt(CommonFunctions.QueryExecute("select datediff(now(),'"+y+"-"+month+"-01')")[0][0]); 
			if(days<45)
			{
				if("PAYAllowanceTransfer".equals(action)) 
				{
					 
					String type = request.getParameter("type");
					if("1".equals(type))
					{
						System.out.println("Migrate basic start");
						EmployeeWiseMigrate.SalaryGenerate(con, mont, y, ename, auserid);
						System.out.println("Migrate basic end");
					}
					else if("2".equals(type))
					{	
						System.out.println("Migrate allowance start");
						EmployeeWiseMigrate.AllowanceGenerate(con,mont,y, ename,auserid);
						System.out.println("Migrate allowance end");
					}
					else if("3".equals(type))
					{
						System.out.println("Migrate recovery start");
						EmployeeWiseMigrate.RecoveryGenerate(con,mont,y, ename,auserid);
						System.out.println("Migrate recovery start");
					}
					 
					System.out.println("MIGRATION COMPLETED...");
					con.close();    
					response.sendRedirect("Smart Payroll/EmployeewiseTransferRecoveryMove.jsp");
				}
			}
			else
			{
				con.close();    
				response.sendRedirect("Smart Payroll/Payrollmain.jsp?pmsg=Migrate not possible due to more 45days old...");
			}

		}
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	

  
}
