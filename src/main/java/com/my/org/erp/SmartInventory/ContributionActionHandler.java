package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ContributionActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				Statement st = con.createStatement();
				String sql="";
				if("INVContributionAdd".equals(action))
				{
					String saleno=request.getParameter("invno");
					String A11=request.getParameter("A11");
					String A12=request.getParameter("A12");
					String A13=request.getParameter("A13");
					String A14=request.getParameter("A14");
					String A15=request.getParameter("A15");
					double s=0,s1=0,s2=0,s3=0,s4=0;
					s = Double.parseDouble(A11);
					s1 = Double.parseDouble(A12);
					s2 = Double.parseDouble(A13);
					s3 = Double.parseDouble(A14);
					s4 = Double.parseDouble(A15);
					double sum = s+s1+s2+s3+s4;
					sql ="UPDATE inv_t_contribution SET ";
					sql = sql+" DOU_CONTRIBUTION =(DOU_CONTRIBUTION-"+sum +") , ";
					sql = sql+" DOU_AMOUNT1 ="+s +" , ";
					sql = sql+" DOU_AMOUNT2 ="+s1 +" , ";
					sql = sql+" DOU_AMOUNT3 ="+s2 +" , ";
					sql = sql+" DOU_AMOUNT4 ="+s3 +" , ";
					sql = sql+" DOU_AMOUNT5 ="+s4 +" , ";
					sql = sql+" DOU_AMOUNTSUM ="+sum +" WHERE CHR_SALESNO='"+saleno+"' ";
					st.execute(sql);	
					con.close();   
					response.sendRedirect("Smart Inventory/Rept_Contribution.jsp");
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


