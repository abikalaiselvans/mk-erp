package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 

public class SalaryVerificationActionHandler extends AbstractActionHandler 
{
	public synchronized void  handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			
			if (action.equals("PAYSalaryVerification")) 
			{ 
				try 
				{
					String month = request.getParameter("Month");
					String monname= DateUtil.getMonth(Integer.parseInt(month));
					String Year = request.getParameter("Year");
					asql = " SELECT a.CHR_EMPID ID  FROM  pay_t_salary a ";
					asql = asql + " WHERE a.CHR_MONTH = '"+monname+"' AND a.INT_YEAR=" +Year;
					asql = asql + " ORDER BY  a.CHR_EMPID";
					System.out.println(asql);
					String salarayData[][] = CommonFunctions.QueryExecutecon(con,asql);
					String empids = "'0',";
					if(salarayData.length>0)
					{	
						for(int u=0; u<salarayData.length;u++)
						{	
							empids = empids +"'"+salarayData[u][0]+"' ,";
						}
					}
					empids = empids+ "'0'";
					 
					asql =" SELECT DAY(LAST_DAY('"+Year+"-"+month+"-01'))";
					String lastday =  CommonFunctions.QueryExecutecon(con,asql)[0][0];
					 
					asql = " DELETE FROM pay_t_salaryverification WHERE  CHR_MONTH = ? AND  INT_YEAR=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, monname);
					apstm.setString(2, Year);
					apstm.execute();
					apstm.close();
					
					asql = " INSERT INTO  pay_t_salaryverification (CHR_EMPID,CHR_MODE,INT_ATTENDANCECYCLE,CHR_MONTH,INT_YEAR) ";
					asql = asql + " SELECT a.CHR_EMPID ,CONCAT('S'),a.INT_ATTENDANCECYCLE,MONTHNAME('"+Year+"-"+month+"-"+lastday+"'), YEAR('"+Year+"-"+month+"-"+lastday+"')";
					asql = asql + " FROM com_m_staff a ";
					asql = asql + " WHERE a.DT_DOJCOLLEGE <='"+Year+"-"+month+"-"+lastday+"' ";
					asql = asql + " AND  ( (a.CHR_TYPE!='T' AND a.DAT_RESIGNDATE IS NULL)  OR (a.DAT_RESIGNDATE <='"+Year+"-"+month+"-"+lastday+"' AND a.DAT_RESIGNDATE >='"+Year+"-"+month+"-01'  )) ";  
					asql = asql + " AND a.CHR_EMPID NOT IN ("+empids+")";
					asql = asql + " ORDER BY  a.CHR_EMPID ";
					System.out.println(asql);
					apstm = con.prepareStatement(asql);
					apstm.execute();
					apstm.close();
					response.sendRedirect("Smart Payroll/SalaryVerificationResponse.jsp?monthname="+monname+"&year="+Year); 
				} 
				catch (RuntimeException e) 
				{
					
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
		            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    		dispatchers.forward(request, response); 
				}
			}
			 
		}
		catch (Exception e) 
		{
			 
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 
		}
	}

}
