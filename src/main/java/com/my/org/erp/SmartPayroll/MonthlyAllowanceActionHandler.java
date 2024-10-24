package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class MonthlyAllowanceActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
 			
			//System.out.println("Monthly Allowance " + action);
			if (action.equals("PAYMonthlyAllowance")) 
			{
				String staff[] = request.getParameterValues("ename");
				String allowancetype=request.getParameter("Allowance");
				String mont=request.getParameter("month");
				String year=request.getParameter("year");
				String month= DateUtil.getMonth(Integer.parseInt(mont));
				int amount= Integer.parseInt(request.getParameter("amount"));
				String sql="";
				for(int u=0;u<staff.length;u++)
				{
					sql="";
					sql =" SELECT COUNT(*) FROM pay_t_salaryallowance WHERE CHR_EMPID='"+staff[u]+"'  AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
					if(CommonFunctions.RecordExist(con, sql))
					{
						sql= "UPDATE pay_t_salaryallowance SET "+allowancetype+" = "+amount +" WHERE CHR_EMPID='"+staff[u]+"'  AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
						Statement st= con.createStatement();
						st.execute(sql);
						st.close();
					}
					else
					{
						sql=" INSERT INTO pay_t_salaryallowance (CHR_EMPID,"+allowancetype+" ,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						sql = sql +"'"+staff[u]+"' , ";
						sql = sql +amount+" , ";
						sql = sql +"'"+month+"' , ";
						sql = sql + year+"  ,'"+userid+"' ,  now(),'Y')";
						Statement st= con.createStatement();
						st.execute(sql);
						st.close();
					}
				}
				con.close();    
				response.sendRedirect("Smart Payroll/MonthlyAllowanceView.jsp");
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
