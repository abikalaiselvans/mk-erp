package com.my.org.erp.SmartPayroll;

import java.io.IOException;
 
import java.sql.Statement; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class AllowanceActionHandler extends AbstractActionHandler 
{

	 

	
	
	
	 
	
	
	
	
	private void AllowanceAdd(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			Statement st = null;
			st = con.createStatement();
			String allCode = request.getParameter("acode");
			String allName = request.getParameter("aname");
			String flag  = request.getParameter("Flag");
			String changes  = request.getParameter("changes");
			String Bonus  = request.getParameter("Bonus");
			if("M".equals(changes))
				changes="Y";
			else if("Y".equals(changes))
				changes="N";
			else if("null".equals(changes))
				changes="N";
			
			//Insert to allowance
			String sql = "INSERT INTO PAY_M_ALLOWANCE(CHR_ACODE,CHR_ANAME,CHR_FLAG,CHR_MONTHFLAG,CHR_BONUS) VALUES('"+allCode+"','"+allName+"','"+flag+"'  , '"+changes+"','"+Bonus+"')";
			st.execute(sql);
			
			
			
			//Inset to transaction allowance
			String f =allCode.replace("A00","");
			sql =" ALTER TABLE pay_t_allowance ADD COLUMN " + allCode+ " INT(10) default '0' after  A00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			//Insert into ranaction salary allowance
			sql =" ALTER TABLE pay_t_salaryallowance ADD COLUMN " + allCode+ " INT(10) default '0' after  A00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			//Insert into salary
			sql =" ALTER TABLE pay_t_salary ADD COLUMN " + allCode+ " INT(10) default '0' after  A00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			
			
			//	Insert into salary Band
			sql =" ALTER TABLE pay_m_salaryband ADD COLUMN " + allCode+ "  double(10,2) default '0.00' after  A00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			 

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	
	
	
	private void AllowanceEdit(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String rowid = request.getParameter("rowid");
			 
			String allName = request.getParameter("aname");
			String flag = request.getParameter("Flag");
			String changes  = request.getParameter("changes");
			String Bonus  = request.getParameter("Bonus");
			if("M".equals(changes))
				changes="Y";
			else if("Y".equals(changes))
				changes="N";
			else if("null".equals(changes))
				changes="N";
			String sql = "UPDATE PAY_M_ALLOWANCE SET CHR_FLAG='"+flag+"' , CHR_MONTHFLAG='"+changes+"' , CHR_ANAME='"+allName+"',CHR_BONUS='"+Bonus+"' WHERE INT_ALLOWANCEID="+rowid+" ";
			Statement st = con.createStatement();
			st.execute(sql);
			 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			
			if (action.equals("PAYallowanceAdd")) 
			{
				AllowanceAdd(request, response);
				response.sendRedirect("Smart Payroll/AllowanceView.jsp?message=Allowance Added Sucessfully");
			}
			else if (action.equals("PAYallowanceEdit")) 
			{
				AllowanceEdit(request, response);
				con.close();   
				response.sendRedirect("Smart Payroll/AllowanceView.jsp?message=Allowance Modified Sucessfully");
			}
			else if (action.equals("PAYAllowanceMonthView")) 
			{
				String compId= request.getParameter("company");
				String branchId= request.getParameter("branch");
				String month = request.getParameter("month");
				String mon = DateUtil.getMonth(Integer.parseInt(month));
				String year = request.getParameter("year");
				String sql="";
				String ksql="";
				ksql="company="+compId+"&branch="+branchId+"&month="+mon+"&year="+year;
				sql = "SELECT CHR_ACODE FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
				String allowancedata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				String ssql="";
				for(int u=0;u<allowancedata.length;u++)
					ssql = ssql+" B."+allowancedata[u][0]+",";
				ssql = ssql.substring(0,ssql.length()-1);
				
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,B.CHR_MONTH,"+ssql;
				sql = sql+ " FROM  com_m_staff  A,PAY_T_SALARYALLOWANCE B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID";
				sql = sql+ " AND A.INT_DESIGID=D.INT_DESIGID AND A.INT_DEPARTID=C.INT_DEPARTID AND ";
				sql = sql + "B.CHR_MONTH='" + mon + "' AND B.INT_YEAR="
						+ Integer.parseInt(year);
				sql=sql+" AND A.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;	
				con.close();    
				response.sendRedirect("Smart Payroll/ReptViewAllowance.jsp?"+ksql);
				
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