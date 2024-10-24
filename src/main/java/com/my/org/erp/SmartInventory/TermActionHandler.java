package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class TermActionHandler extends AbstractActionHandler
{
	
	private void termDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []termId= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_terms_conditions WHERE INT_CONDITIONID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<termId.length;i++)
			{	
				apstm.setString(1,termId[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
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
	
	
	
	private void termAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String termName=""+request.getParameter("TxtCondition").trim();
			String termDes=request.getParameter("TxtTermDes");
			asql=" INSERT INTO inv_m_terms_conditions ";
			asql = asql + " (CHR_CONDITIONNAME,CHR_DES,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?,?,DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,termName);
			apstm.setString(2,termDes);
			apstm.setString(3,userid);
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
	
	private void termEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			 
			HttpSession session=request.getSession();				
			String userid=""+session.getAttribute("USRID");
			String termName=request.getParameter("TxtCondition").trim();
			String termDes=request.getParameter("TxtTermDes").trim();
			String termId=request.getParameter("termId").trim();
			asql=" UPDATE inv_m_terms_conditions SET ";
			asql = asql + " CHR_CONDITIONNAME=?,CHR_DES=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_CONDITIONID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,termName);
			apstm.setString(2,termDes);
			apstm.setString(3,userid);
			apstm.setString(4,termId);
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
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try{
				String action=request.getParameter("actionS");
				if(action.equals("INVtermDelete"))
				{					
					termDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/Term&ConditionView.jsp");
				}
				if("INVtermAdd".equals(action))
				{					
					termAdd(request, response);
					con.close();   
					response.sendRedirect("Smart Inventory/Term&ConditionView.jsp");
				}
				else if("INVtermEdit".equals(action))
				{					
					termEdit(request, response);
					con.close();   
					response.sendRedirect("Smart Inventory/Term&ConditionView.jsp");
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

