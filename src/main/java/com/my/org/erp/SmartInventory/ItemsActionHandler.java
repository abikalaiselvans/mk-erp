package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.SQLWarning;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class ItemsActionHandler extends AbstractActionHandler
{
	private void Delete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{						
			String []ItemId= request.getParameterValues("rowid");
			asql="DELETE FROM inv_m_item WHERE INT_ITEMID=?  ";
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
	
	
	private void Add(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			
			String itemName=request.getParameter("itemname");
			String itemDes=request.getParameter("description");
			String active=request.getParameter("active");
			String purPrice=""+request.getParameter("pprice");
			String itemgroup=""+request.getParameter("itemgroup");
			if(purPrice.equals("null")||purPrice.equals("")) purPrice="0";
			String purDes=request.getParameter("pdescription");
			String salesPrice=""+request.getParameter("sprice");
			if(salesPrice.equals("null")||salesPrice.equals("")) salesPrice="0";
			String salesDes=request.getParameter("sdescription");
			String warranty=request.getParameter("warranty");
			String stock=""+request.getParameter("stock");
			String model=request.getParameter("model");
			String color=request.getParameter("color");	
			String hsncode=request.getParameter("hsncode");	
			String tax=request.getParameter("tax");
			String units=request.getParameter("units");
			if(stock.equals("null")||stock.equals("")) 
				stock="0";
			
			String itemId = "";
			if( CommonFunctions.RecordExist(con, "select count(*) FROM inv_m_produtlist"))
				itemId = CommonFunctions.QueryExecute("SELECT right(CONCAT('000000', MAX(INT_ITEMID)+1),6) FROM inv_m_item")[0][0];
			else
				itemId = "000001";
			
			 
			asql = " INSERT INTO inv_m_item "; 
			asql = asql +" ( ";
			asql = asql +" CHR_ITEMID, CHR_ITEMNAME ,CHR_DES , INT_ACTIVE, ";
			asql = asql +" CHR_PURCHASEDES ,DOU_PURCHASEPRICE ,CHR_SALESDES, DOU_SALESPRICE ,CHR_WARRANTY, ";
			asql = asql +" INT_STOCKINHAND , INT_MODELCODE , INT_COLORCODE,  INT_ITEMGROUPID  ,  ";
			asql = asql +" INT_TAXID,CHR_HSNCODE, INT_UNITID,CHR_USRNAME,  DT_UPDATEDATE, CHR_UPDATESTATUS";
			asql = asql +" ) ";
			asql = asql +"  VALUES(?,?,?,?,?,?, ";
			asql = asql +" ?,?,?,?,?,?,?,?,?,?,?, DATE(NOW()),'Y') ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,itemId);
			apstm.setString(2,itemName.toUpperCase().replaceAll("&", " AND ") );
			apstm.setString(3,itemDes.toUpperCase().replaceAll("&", " AND ")  );
			apstm.setString(4,active );
			apstm.setString(5,purDes.toUpperCase() );
			apstm.setString(6,purPrice );
			apstm.setString(7,salesDes .toUpperCase());
			apstm.setString(8,salesPrice );
			apstm.setString(9,warranty );
			apstm.setString(10,stock );
			apstm.setString(11,model );
			apstm.setString(12,color );
			apstm.setString(13,itemgroup );
			apstm.setString(14,tax);
			apstm.setString(15,hsncode);
			apstm.setString(16,units);
			apstm.setString(17,auserid );
			apstm.execute();
			System.out.println(""+acs);
			apstm.close();
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
	private void Edit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{

			String itemName=request.getParameter("itemname");
			String itemDes=request.getParameter("description");
			String active=request.getParameter("active");
			String purPrice=""+request.getParameter("pprice");
			String itemgroup=""+request.getParameter("itemgroup");
			if(purPrice.equals("null")||purPrice.equals("")) purPrice="0";
			String purDes=request.getParameter("pdescription");
			String salesPrice=""+request.getParameter("sprice");
			if(salesPrice.equals("null")||salesPrice.equals("")) salesPrice="0";
			String salesDes=request.getParameter("sdescription");
			String warranty=request.getParameter("warranty");
			String stock=""+request.getParameter("stock");
			String model=request.getParameter("model");
			String color=request.getParameter("color");	
			String hsncode=request.getParameter("hsncode");
			 
			String tax=request.getParameter("tax");
			String units=request.getParameter("units");
			if(stock.equals("null")||stock.equals("")) 
				stock="0";
			 
			String rowid=request.getParameter("rowid");
			 
			
			asql = " UPDATE inv_m_item SET CHR_ITEMNAME=?,CHR_DES=?,INT_TAXID=?, ";
			asql = asql +"  INT_ACTIVE=?,CHR_PURCHASEDES=?,DOU_PURCHASEPRICE=?,CHR_SALESDES=?,DOU_SALESPRICE=?, ";
			asql = asql +" CHR_WARRANTY=?, INT_ITEMGROUPID=?,INT_STOCKINHAND=?,INT_MODELCODE=?,INT_COLORCODE=?, ";//INT_ITEMGROUPID
			asql = asql +"  CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_HSNCODE=?,INT_UNITID=? WHERE INT_ITEMID=?  ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,itemName.toUpperCase() );
			apstm.setString(2,itemDes.toUpperCase() );
			apstm.setString(3,tax);
			apstm.setString(4,active );
			apstm.setString(5,purDes.toUpperCase() );
			apstm.setString(6,purPrice );
			apstm.setString(7,salesDes.toUpperCase() );
			apstm.setString(8,salesPrice );
			apstm.setString(9,warranty );
			apstm.setString(10,itemgroup  );//itemgroup
			apstm.setString(11,stock );
			apstm.setString(12,model );
			apstm.setString(13,color );
			apstm.setString(14,auserid );
			apstm.setString(15,hsncode );
			apstm.setString(16,units );
			apstm.setString(17,rowid );
			System.out.println(""+apstm);
			apstm.execute();
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

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVItemAdd"))
				{					
					Add(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ItemView.jsp");
 				}
				else if(action.equals("INVItemEdit"))
				{					
					Edit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ItemView.jsp");
				}
				else if(action.equals("INVItemDelete"))
				{				
					Delete(request, response);
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
