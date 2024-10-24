package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class ItemActionHandler extends AbstractActionHandler
{
	
	String productId,productName;
	@SuppressWarnings("unused")
	private void productList(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			ArrayList<Product> productList=new ArrayList<Product>();				
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("SELECT * FROM inv_m_produtlist ORDER BY CHR_ITEMNAME");			
			while (rs.next()) 
			{
				String productId = "";
				String productName=rs.getString("CHR_PRODUCTCODE");
				String productDes=rs.getString("CHR_PRODUCTDESC");
				boolean active=rs.getBoolean("INT_ACTIVE");
				int productGroupId=rs.getInt("INT_PRODUCTGROUPID");
				Product product=new Product();
				product.setProductId(productId);
				product.setProductName(productName);
				product.setProductDes(productDes);
				product.setActive(active);
				product.setProductGropuId(productGroupId);
				productList.add(product);				
			}
			HttpSession session=request.getSession();
			session.setAttribute("productList",productList);			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}	

	private void itemDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{						
			String []ItemId= request.getParameterValues("itemId");
			acs = con.prepareCall("{call INV_PRO_ITEM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<ItemId.length;i++){
				
				acs.setString(1,"DELETE");
				acs.setString(2,"0");
				acs.setString(3,"");
				acs.setString(4,ItemId[i]);
				acs.setString(5,"");
				acs.setString(6,"");
				acs.setString(7,"");
				acs.setString(8,"");
				acs.setDouble(9,0.0);
				acs.setString(10,"");
				acs.setDouble(11,0.0);
				acs.setString(12,"");
				acs.setString(13,"");
				acs.setString(14,"");
				acs.setString(15,"");
				acs.setString(16,"");
				acs.setInt(17,0);
				acs.setInt(18,0);
				acs.setInt(19,0);
				acs.addBatch();
				
			}
			acs.executeBatch();
			acs.close(); 
			 
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			
		}
	}
	
	
	private void itemAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchId=""+session.getAttribute("BRANCHID");
			String itemName=request.getParameter("itemName");
			String itemDes=request.getParameter("itemDes");
			String active=request.getParameter("active");
			String purPrice=""+request.getParameter("purPrice");
			String itemgroup=""+request.getParameter("itemgroup");
			if(purPrice.equals("null")||purPrice.equals("")) purPrice="0";
			String purDes=request.getParameter("purDes");
			String salesPrice=""+request.getParameter("salesPrice");
			if(salesPrice.equals("null")||salesPrice.equals("")) salesPrice="0";
			String salesDes=request.getParameter("salesDes");
			String warranty=request.getParameter("warranty");
			String stock=""+request.getParameter("stock");
			String model=request.getParameter("model");
			String color=request.getParameter("color");	
			String Division=request.getParameter("Division");
			String tax=request.getParameter("tax");
			if(stock.equals("null")||stock.equals("")) 
				stock="0";
			
		
			String itemId = CommonFunctions.QueryExecute("SELECT right(CONCAT('000000', MAX(CHR_ITEMID)+1),6) FROM inv_m_item")[0][0];
			acs = con.prepareCall("{call INV_PRO_ITEM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1,"INSERT");
			acs.setString(2,branchId);
			acs.setString(3,"");
			acs.setString(4,itemId);
			acs.setString(5,itemName);
			acs.setString(6,itemDes);
			acs.setString(7,active);
			acs.setString(8,purDes);
			acs.setDouble(9,Double.parseDouble(purPrice));
			acs.setString(10,salesDes);
			acs.setDouble(11,Double.parseDouble(salesPrice));
			acs.setString(12,warranty);
			acs.setString(13,stock);
			acs.setString(14,model);
			acs.setString(15,color);
			acs.setString(16,userId);
			acs.setInt(17,Integer.parseInt(itemgroup));
			acs.setInt(18, Integer.parseInt(Division));
			acs.setInt(19, Integer.parseInt(tax));
			System.out.println(""+acs);
			acs.execute();
			acs.close();
		}
		catch(SQLWarning   e)
		{
			System.out.println(e.getMessage());
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 
		}
	}
	private void itemEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{

			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchId=""+session.getAttribute("BRANCHID");
			String itemId=request.getParameter("itemId");	
			productId="";
			String itemName=request.getParameter("itemName");
			String itemDes=request.getParameter("itemDes");
			String active=request.getParameter("active");
			String purPrice=""+request.getParameter("purPrice");
			String itemgroup=""+request.getParameter("itemgroup");
			if(purPrice.equals("null")||purPrice.equals("")) purPrice="0";
			String purDes=request.getParameter("purDes");
			String salesPrice=""+request.getParameter("salesPrice");
			if(salesPrice.equals("null")||salesPrice.equals("")) salesPrice="0";
			String salesDes=request.getParameter("salesDes");
			String warranty=request.getParameter("warranty");
			String stock=""+request.getParameter("stock");
			String model=request.getParameter("model");
			String color=request.getParameter("color");	
			String Division=request.getParameter("Division");
			String tax=request.getParameter("tax");
			if(stock.equals("null")||stock.equals("")) stock="0";
			
			CallableStatement cs = con.prepareCall("{call INV_PRO_ITEM(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1,"UPDATE");
			cs.setString(2,branchId);
			cs.setString(3,productId);
			cs.setString(4,itemId);
			cs.setString(5,itemName);
			cs.setString(6,itemDes);
			cs.setString(7,active);
			cs.setString(8,purDes);
			cs.setString(9,purPrice);
			cs.setString(10,salesDes);
			cs.setString(11,salesPrice);
			cs.setString(12,warranty);
			cs.setString(13,stock);
			cs.setString(14,model);
			cs.setString(15,color);
			cs.setString(16,userId);
			cs.setInt(17,Integer.parseInt(itemgroup));
			cs.setInt(18, Integer.parseInt(Division));
			cs.setInt(19, Integer.parseInt(tax));
		    cs.execute();			
		   
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
				if(action.equals("INVItemDelete"))
				{				
					itemDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ItemView.jsp");
					
				} 
				else if(action.equals("INVItemAdd"))
				{					
					
					itemAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ItemView.jsp");
 				}
				else if(action.equals("INVItemEdit"))
				{					
					itemEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ItemView.jsp");
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
