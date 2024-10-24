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
import com.my.org.erp.bean.management.PettyCashIncome;
import com.my.org.erp.common.CommonFunctions;
public class PettyCashIncomeActionHandler extends AbstractActionHandler 
{

	@SuppressWarnings("rawtypes")
	String officeid= null;
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			officeid=""+session.getAttribute("OFFICEID");
			if ("MGTPettyCashIncomeAdd".equals(action)) 
			{	
				Add(request,response);
				con.close();
				response.sendRedirect("Smart Management/PettyCashIncome.jsp");
			}
			else if ("MGTPettyCashIncomeEdit".equals(action)) 
			{ 
				Edit(request,response); 
				con.close();
				response.sendRedirect("Smart Management/PettyCashIncome.jsp");
				
			} 
			else if ("MGTPettyCashIncomeDelete".equals(action)) 
			{ 
				Delete(request,response); 
				con.close();
				response.sendRedirect("Smart Management/PettyCashIncome.jsp");
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
			PettyCashIncome c =new PettyCashIncome();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			officeid = CommonFunctions.QueryExecute("SELECT FIND_A_OOFICEID_AGAINST_BRANCHID("+c.getBranch()+")")[0][0];
			asql = " INSERT INTO mgt_t_pettycash_income ";
			asql = asql +" (INT_BRANCHID,CHR_INCOMEREFNO,INT_CATEGORYID,DAT_INCOME,CHR_DESC,DOU_AMOUNT,INT_PAYMENTMODE,INT_SOURCEID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			asql = asql +" VALUES (?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,""+c.getBranch());
			apstm.setString(2,""+ pettycashNumberGet(officeid));
			apstm.setInt(3,c.getCategory());
			apstm.setString(4,c.getIncomedate());
			apstm.setString(5,c.getDesc());
			apstm.setString(6,""+c.getIncome());
			apstm.setString(7,c.getPaymentmode());
			apstm.setString(8,""+c.getSource());
			apstm.setString(9,""+auserid);
			System.out.println(apstm);
			apstm.execute();
			apstm.close();
			
			asql = " SELECT FUN_MGT_PETTYCASH_INCOMENUMBER_INSERT(? )";
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
			PettyCashIncome c =new PettyCashIncome();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			asql = " UPDATE mgt_t_pettycash_income SET ";
			asql = asql +" DAT_INCOME= ? , ";
			asql = asql +" DOU_AMOUNT= ? , ";
			asql = asql +" INT_PAYMENTMODE= ? , ";
			asql = asql +" CHR_DESC= ? , ";
			asql = asql +" INT_SOURCEID= ? , ";
			asql = asql +" INT_CATEGORYID=?";
			asql = asql +" WHERE INT_INCOMEID =?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,c.getIncomedate());
			apstm.setString(2,""+c.getIncome());
			apstm.setString(3,c.getPaymentmode());
			apstm.setString(4,c.getDesc());
			apstm.setString(5,""+c.getSource());
			apstm.setInt(6,c.getCategory());
			apstm.setString(7,""+c.getRowid());
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
				asql = " DELETE FROM mgt_t_pettycash_income WHERE INT_INCOMEID =? ";
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
			return CommonFunctions.QueryExecute("  SELECT FUN_MGT_PETTYCASH_INCOME_NUMBER('"+officeid+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	 
	
}