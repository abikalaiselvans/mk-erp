package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.SQLWarning;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class SpareActionHandler extends AbstractActionHandler
{
	
	 
	private void Delete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{						
			String []ItemId= request.getParameterValues("rowid");
			asql="DELETE FROM inv_m_spare WHERE INT_SPAREID=?  ";
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
			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String sparename=request.getParameter("sparename");
			String description=request.getParameter("description");
			String active=request.getParameter("active");
			String purPrice=""+request.getParameter("pprice");
			String sparegroup=""+request.getParameter("sparegroup");
			if(purPrice.equals("null")||purPrice.equals("")) purPrice="0";
			String purDes=request.getParameter("pdescription");
			String salesPrice=""+request.getParameter("sprice");
			if(salesPrice.equals("null")||salesPrice.equals("")) salesPrice="0";
			String salesDes=request.getParameter("sdescription");
			String warranty=request.getParameter("warranty");
			String stock=""+request.getParameter("stock");
			String model=request.getParameter("model");
			String color=request.getParameter("color");	
			String Division=request.getParameter("division");
			String tax=request.getParameter("tax");
			if(stock.equals("null")||stock.equals("")) 
				stock="0";
			 
			asql = " INSERT INTO inv_m_spare "; 
			asql = asql +" ( ";
			asql = asql +"   CHR_SPARENAME ,CHR_DES , INT_ACTIVE, ";
			asql = asql +" CHR_PURCHASEDES ,DOU_PURCHASEPRICE ,CHR_SALESDES, DOU_SALESPRICE ,CHR_WARRANTY, ";
			asql = asql +"  INT_MODELCODE , INT_COLORCODE,  INT_GROUPID  ,INT_DIVIID, ";
			asql = asql +" INT_TAXID, CHR_USRNAME,  DT_UPDATEDATE, CHR_UPDATESTATUS ";
			asql = asql +" ) ";
			asql = asql +"  VALUES( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,sparename );
			apstm.setString(2,description );
			apstm.setString(3,active );
			apstm.setString(4,purDes );
			apstm.setString(5,purPrice );
			apstm.setString(6,salesDes );
			apstm.setString(7,salesPrice );
			apstm.setString(8,warranty );
			apstm.setString(9,model );
			apstm.setString(10,color );
			apstm.setString(11,sparegroup );
			apstm.setString(12,Division);
			apstm.setString(13,tax);
			apstm.setString(14,userid );
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

			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String sparename=request.getParameter("sparename");
			String description=request.getParameter("description");
			String active=request.getParameter("active");
			String purPrice=""+request.getParameter("pprice");
			String sparegroup=""+request.getParameter("sparegroup");
			if(purPrice.equals("null")||purPrice.equals("")) purPrice="0";
			String purDes=request.getParameter("pdescription");
			String salesPrice=""+request.getParameter("sprice");
			if(salesPrice.equals("null")||salesPrice.equals("")) salesPrice="0";
			String salesDes=request.getParameter("sdescription");
			String warranty=request.getParameter("warranty");
			String model=request.getParameter("model");
			String color=request.getParameter("color");	
			String Division=request.getParameter("division");
			String tax=request.getParameter("tax");
				String rowid=request.getParameter("rowid");
			 
			
			asql = " UPDATE inv_m_spare SET CHR_SPARENAME=?,CHR_DES=?,INT_TAXID=?, ";
			asql = asql +"  INT_ACTIVE=?,CHR_PURCHASEDES=?,DOU_PURCHASEPRICE=?,CHR_SALESDES=?,DOU_SALESPRICE=?, ";
			asql = asql +" CHR_WARRANTY=?,INT_GROUPID=?,INT_MODELCODE=?,INT_COLORCODE=?, ";
			asql = asql +" INT_DIVIID=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()) WHERE INT_SPAREID=?  ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,sparename );
			apstm.setString(2,description );
			apstm.setString(3,tax);
			apstm.setString(4,active );
			apstm.setString(5,purDes );
			apstm.setString(6,purPrice );
			apstm.setString(7,salesDes );
			apstm.setString(8,salesPrice );
			apstm.setString(9,warranty );
			apstm.setString(10,sparegroup );
			apstm.setString(11,model );
			apstm.setString(12,color );
			apstm.setString(13,Division);
			apstm.setString(14,userid );
			apstm.setString(15,rowid );
			System.out.println(""+apstm);
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

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVSpareAdd"))
				{					
					Add(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/Spare.jsp");
 				}
				else if(action.equals("INVSpareEdit"))
				{					
					Edit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/Spare.jsp?sparegroup="+request.getParameter("sparegroup"));
				}
				else if(action.equals("INVSpareDelete"))
				{				
					Delete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/Spare.jsp");
					
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
