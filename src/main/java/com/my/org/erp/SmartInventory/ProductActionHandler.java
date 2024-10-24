package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class ProductActionHandler extends AbstractActionHandler
{
	String categoryName,categoryDes;
	int categoryId;
	 

	private void productDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			String []ItemId= request.getParameterValues("productId");
			asql="DELETE FROM inv_m_produtlist WHERE INT_PRODUCTIDS=?  ";
			apstm  = con.prepareStatement(asql);
			for(int i=0;i<ItemId.length;i++)
			{
				apstm.setInt(1,Integer.parseInt(ItemId[i]));
				apstm.addBatch();
				System.out.println(""+apstm);
			}	
			apstm.executeBatch();
			apstm.close();
			
			 
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	
	
	private void productAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			String branchId=""+session.getAttribute("BRANCHID");			
			String productId=request.getParameter("productId").trim();
			String productName=request.getParameter("productName").trim();
			String productDes=request.getParameter("productDes").trim();
			String active=request.getParameter("active").trim();
			String groupId=request.getParameter("groupId").trim();
			String priceStatus=request.getParameter("priceStatus").trim();
			acs = con.prepareCall("{call INV_PRO_PRODUCT(?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, branchId);
			acs.setString(3, productId);
			acs.setString(4, productName);
			acs.setString(5, productDes);
			acs.setString(6, active);
			acs.setString(7, groupId);
			acs.setString(8, priceStatus);
			acs.setString(9, userId);
		    acs.execute();		    
		}
		catch(Exception e)
		{						
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}
	
	
	private void productEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			String branchId=""+session.getAttribute("BRANCHID");			
			String productId=request.getParameter("productId").trim();
			String productName=request.getParameter("productName").trim();
			String productDes=request.getParameter("productDes").trim();
			String active=request.getParameter("active").trim();
			String groupId=request.getParameter("groupId").trim();
			String priceStatus=request.getParameter("priceStatus").trim();
			acs = con.prepareCall("{call INV_PRO_PRODUCT(?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, branchId);
			acs.setString(3, productId);
			acs.setString(4, productName);
			acs.setString(5, productDes);
			acs.setString(6, active);
			acs.setString(7, groupId);
			acs.setString(8, priceStatus);
			acs.setString(9, userId);
		    acs.execute();											
		}
		catch(Exception e)
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
				String action=request.getParameter("actionS");
				if(action.equals("INVProductAdd")){					
					productAdd(request, response);
					con.close();   
					response.sendRedirect("inventory?actionS=INVProductAdd&filename=ProductView.jsp");				
				}
				else if(action.equals("INVProductEdit")){					
					productEdit(request, response);
					con.close();    
					response.sendRedirect("inventory?actionS=INVProductAdd&filename=ProductView.jsp");
				}
				else if(action.equals("INVProductDelete"))
				{					
					productDelete(request, response);
					response.sendRedirect("inventory?actionS=INVProductAdd&filename=ProductView.jsp");
				}
		} 
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}
		
	}
	
}

