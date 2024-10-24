package com.my.org.erp.SmartInventory;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DisplayActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			 
			  
			if ("INVConsumableStock".equals(action))
			{
				
				String Branch=request.getParameter("Branch");
				String division=request.getParameter("division");
				asql = " SELECT  e.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_ITEMID,'PRODUCT',b.CHR_PRODUCTCODE, ";
				asql = asql + " b.CHR_PRODUCTDESC,d.CHR_DIVICODE, ";
				asql = asql + " SUM(a.INT_PQTY),SUM(a.INT_SQTY),(SUM(a.INT_PQTY)-SUM(a.INT_SQTY)), ";
				asql = asql + " FUN_GET_AVERAGEPRICE(a.INT_BRANCHID,a.CHR_ITEMID),a.INT_BRANCHID ";
				asql = asql + " FROM inv_t_vendorgoodsreceivedconsumable a ,inv_m_produtlist b,  ";
				asql = asql + " com_m_branch c, inv_m_division d, com_m_company e ";
				asql = asql + " WHERE a.CHR_ITEMID=b.CHR_PRODUCTID  ";
				asql = asql + " AND a.INT_BRANCHID =c.INT_BRANCHID  ";
				asql = asql + " AND b.INT_DIVIID =d.INT_DIVIID ";
				asql = asql + " AND a.CHR_TYPE ='P' ";
				asql = asql+ " AND b.CHR_PTYPE='S' ";
				asql = asql + " AND c.INT_COMPANYID = e.INT_COMPANYID ";
				if(!"0".equals(Branch))
						asql = asql+ " AND a.INT_BRANCHID ="+Branch;
				if(!"0".equals(division))
						asql = asql+ " AND b.INT_DIVIID ="+division;
				asql = asql + " GROUP BY a.INT_BRANCHID,a.CHR_ITEMID  ";
				asql = asql + " ORDER BY b.CHR_PRODUCTCODE, a.INT_BRANCHID ";
				//String data[][] = CommonFunctions.QueryExecute(asql);
				 
				
				response.sendRedirect("Smart Inventory/AccessoriesEntry.jsp");
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
