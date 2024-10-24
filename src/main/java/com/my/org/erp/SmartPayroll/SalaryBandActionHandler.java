package com.my.org.erp.SmartPayroll;

import java.io.IOException;
 
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 

public class SalaryBandActionHandler extends AbstractActionHandler {
	 

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String sql="";
			Statement st = con.createStatement();
			if (action.equals("PAYSalaryBandAdd")) 
			{
				
				try 
				{
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println();
					String GT = request.getParameter("GT");
					String LT = request.getParameter("LT");
					String Basic = request.getParameter("Basic");
					String splitup = request.getParameter("splitup");
					 
					double from = Double.parseDouble(GT);
					double to = Double.parseDouble(LT);
					String salaryData[][] =CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
					boolean flag = false;
					for(int u=0; u<salaryData.length;u++)
					{
						if( from >= Integer.parseInt(salaryData[u][1])  &&  from <= Integer.parseInt(salaryData[u][2])  ) 
							if( to >= Integer.parseInt(salaryData[u][1])  &&  to <= Integer.parseInt(salaryData[u][2])  )  ;
								flag = true;
					}
					
					System.out.println(flag);
					
					/*
					for(int u=0; u<salaryData.length;u++)
						if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
							flag = true;
					
					*/
					
					if(!flag)
					{
						String AllowanceData[][] =CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance   WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
						sql=" INSERT  INTO pay_m_salaryband  ( INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN,  INT_BASIC, ";
						for(int u=0; u<AllowanceData.length;u++)
							sql = sql+AllowanceData[u][1]+", ";
						sql= sql +" CHR_USRNAME, DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( ";
						sql = sql+" "+GT+" , ";
						sql = sql+" "+LT+" , ";
						sql = sql+" '"+splitup+"' , ";
						 
						sql = sql+" "+Basic+" , ";
						for(int u=0; u<AllowanceData.length;u++)
							sql = sql+request.getParameter("Allowance"+(u+1))+", ";
						sql = sql+" '"+userid+"' , ";
						sql = sql+" now() , ";
						sql = sql+" 'Y'  ";
						sql = sql + " )";
						System.out.println(sql);
						st.execute(sql);
						con.close();    
						response.sendRedirect("Smart Payroll/SalaryBandView.jsp");
					}
					else
					{
						con.close();    
						response.sendRedirect("Smart Payroll/SalaryBandAdd.jsp?error=Already Salary Slab  Exisit...."  );
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
			else if(action.equals("PAYSalaryBandUpdate")) 
			{
				try 
				{
					String rowid = request.getParameter("rowid");
					String GT = request.getParameter("GT");
					String LT = request.getParameter("LT");
					String Basic = request.getParameter("Basic");
					String splitup = request.getParameter("splitup");
					String AllowanceData[][] =CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance  WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
					
					sql = " UPDATE pay_m_salaryband SET INT_STARTINGSALARY="+GT+",INT_ENDINGSALARY="+LT+", CHR_SPLITUPIN='"+splitup+"' , INT_BASIC ="+Basic+",";
					for(int u=0; u<AllowanceData.length;u++)
						sql = sql+AllowanceData[u][1]+" = "+request.getParameter("Allowance"+(u+1))+", ";
					sql = sql+" CHR_USRNAME='"+userid+"' , ";
					sql = sql+" DT_UPDATEDATE= now() , ";
					sql = sql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_SALARYBANDID="+rowid;
					// System.out.println(sql);
					st.execute(sql);
					con.close();   
					response.sendRedirect("Smart Payroll/SalaryBandView.jsp");
				} 
				catch (RuntimeException e) 
				{
					response.sendRedirect("error/index.jsp?error=" + e.getMessage());
				}
			}
			else if(action.equals("PAYSalaryBandDelete")) 
			{
				try 
				{
					String rowid[] = request.getParameterValues("allowance");
					for(int u=0;u<rowid.length;u++)
					{
						sql = "DELETE FROM pay_m_salaryband   ";
						sql = sql+"WHERE INT_SALARYBANDID="+rowid[u];
						//st.execute(sql);
					}	
					con.close();    
					response.sendRedirect("Smart Payroll/SalaryBandView.jsp");
				} 
				catch (RuntimeException e) 
				{
					response.sendRedirect("error/index.jsp?error=" + e.getMessage());
				}
			}
			
			st.close();
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
