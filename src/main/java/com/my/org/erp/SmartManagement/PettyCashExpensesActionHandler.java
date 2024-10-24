package com.my.org.erp.SmartManagement;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.management.PettyCashExpense;
import com.my.org.erp.common.CommonFunctions;
 

public class PettyCashExpensesActionHandler extends AbstractActionHandler {

	@SuppressWarnings("rawtypes")
	String officeid= null;
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			officeid=""+session.getAttribute("OFFICEID");
			if ("MGTPettyCashExpensesAdd".equals(action)) 
			{	
				Add(request,response);
				con.close();
				response.sendRedirect("Smart Management/PettyCashExpenses.jsp");
			}
			else if ("MGTPettyCashExpensesEdit".equals(action)) 
			{ 
				Edit(request,response); 
				con.close();
				response.sendRedirect("Smart Management/PettyCashExpenses.jsp");
				
			} 
			else if ("MGTPettyCashExpensesDelete".equals(action)) 
			{ 
				Delete(request,response); 
				con.close();
				response.sendRedirect("Smart Management/PettyCashExpenses.jsp");
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

	
	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			PettyCashExpense c =new PettyCashExpense();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			officeid = CommonFunctions.QueryExecute("SELECT FIND_A_OOFICEID_AGAINST_BRANCHID("+c.getBranch()+")")[0][0];
			asql = " INSERT INTO mgt_t_pettycash_expenses ";
			asql = asql +" (INT_BRANCHID,CHR_EXPENSEREFNO,INT_CATEGORYID,DAT_EXPENSE,CHR_DESC,DOU_AMOUNT,INT_PAYMENTMODE,CHR_TYPE,CHR_EMPID,CHR_AUTHORAISEDBY,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			asql = asql +" VALUES (?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,""+c.getBranch());
			apstm.setString(2,""+ pettycashNumberGet(officeid));
			apstm.setString(3,""+c.getCategory());
			apstm.setString(4,c.getIncomedate());
			apstm.setString(5,c.getDesc());
			apstm.setString(6,""+c.getIncome());
			apstm.setString(7,c.getPaymentmode());
			apstm.setString(8,""+c.getWhom());
			apstm.setString(9,""+c.getOthersid());
			apstm.setString(10,""+c.getAuthorised());
			apstm.setString(11,""+auserid);
			System.out.println(apstm);
			apstm.execute();
			apstm.close();
			
			asql = " SELECT FUN_MGT_PETTYCASH_EXPENSENUMBER_INSERT(? )";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, "" + officeid);
			System.out.println("" + apstm);
			apstm.execute();
				 	 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	public void Edit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			 
			 
			PettyCashExpense c =new PettyCashExpense();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			asql = " UPDATE mgt_t_pettycash_expenses SET ";
			asql = asql +" INT_CATEGORYID= ? , ";
			asql = asql +" DAT_EXPENSE= ? , ";
			asql = asql +" DOU_AMOUNT= ? , ";
			asql = asql +" INT_PAYMENTMODE= ? , ";
			asql = asql +" CHR_TYPE= ? , ";
			asql = asql +" CHR_EMPID= ? , ";
			asql = asql +" CHR_AUTHORAISEDBY= ? , ";
			asql = asql +" CHR_DESC= ?  ";
			asql = asql +" WHERE INT_EXPENSESID =?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,""+c.getCategory());
			apstm.setString(2,c.getIncomedate());
			apstm.setString(3,""+c.getIncome());
			apstm.setString(4,c.getPaymentmode());
			apstm.setString(5,c.getWhom());
			apstm.setString(6,c.getOthersid());
			apstm.setString(7,c.getAuthorised());
			apstm.setString(8,c.getDesc());
			apstm.setString(9,""+c.getRowid());
			System.out.println(apstm);
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
	
	
	public void Delete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			 String id[] = request.getParameterValues("rowid");
			 if(id.length>0)
			 {	 
				asql = " DELETE FROM mgt_t_pettycash_expenses WHERE INT_EXPENSESID =? ";
				apstm = con.prepareStatement(asql);
				for(int u=0;u<id.length;u++)
				{
					apstm.setString(1, id[u]);
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
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
	
	 
	 
	//PETTY CASH NUMBER GET
	public static String pettycashNumberGet(String officeid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_MGT_PETTYCASH_EXPENSE_NUMBER('"+officeid+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	 
	
}