package com.my.org.erp.SmartPayroll;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class MigrateWagesActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			
			

			//022-66284986
			if (action.equals("PAYMigrateWagesUpdate")) 
			{
				String ename=request.getParameter("empid");
				String Month=request.getParameter("Month");
				String Year=request.getParameter("Year");
				String basic=request.getParameter("basic");
				String sql="";
				String sql1="";
				sql1 ="  WHERE CHR_EMPID='"+ename+"' AND CHR_MONTH='"+Month+"'  AND INT_YEAR=  "+Year; 
				
				//BASIC UPDATION
				sql = " UPDATE pay_t_salarybasic SET  INT_SALARY="+basic+sql1;
				com.my.org.erp.common.CommonFunctions.Execute(sql);
				
				//ALLOWANCE UPDATION
				sql="SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
				String allowancedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				sql =" UPDATE pay_t_salaryallowance SET ";
				for(int u=0;u<allowancedata.length;u++)
					sql = sql+" "+allowancedata[u][0] +" = "+request.getParameter("allowance"+(u+1))+" ,";
				sql = sql.substring(0,sql.length()-1);
				sql = sql+sql1;
				com.my.org.erp.common.CommonFunctions.Execute(sql);
				
				//RECOVERY UPDATION
				sql="SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery  ORDER BY INT_RECOVERYID";
				String recoverydata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				sql =" UPDATE pay_t_salaryrecovery SET ";
				for(int u=0;u<recoverydata.length;u++)
					sql = sql+" "+recoverydata[u][0] +" = "+request.getParameter("recovery"+(u+1))+" ,";
				sql = sql.substring(0,sql.length()-1);
				sql = sql+sql1;
				com.my.org.erp.common.CommonFunctions.Execute(sql);
				
				//pay_t_salaryallowance
				//pay_t_salaryrecovery
				
				con.close();   
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
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
