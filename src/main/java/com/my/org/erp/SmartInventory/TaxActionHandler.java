package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class TaxActionHandler extends AbstractActionHandler
{
	 
	private void taxDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_tax WHERE INT_TAXID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
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
	
	
	
		private void taxAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
		{
			try
			{			
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");		
				String name=""+request.getParameter("TxtTaxName").trim();
				String description=request.getParameter("TxtTaxDes");
				String value=request.getParameter("TxtTaxValue");
				String flag=""+request.getParameter("flag");flag = flag.equals("Y")?flag:"N";
				String SGST=request.getParameter("SGST");
				String CGST=request.getParameter("CGST");
				String IGST=request.getParameter("IGST");
				
				asql=" INSERT INTO inv_m_tax "; 
				asql = asql + " (CHR_TAXNAME,DOU_VALUE,CHR_DES,CHR_FLAG,DOU_IGST,DOU_SGST,DOU_CGST,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
				asql = asql + " VALUES ( ?,?,?,?,?,?,?,?,DATE(NOW()),'Y') ";
				apstm =con.prepareStatement(asql);
				apstm.setString(1,name);
				apstm.setString(2,value);
				apstm.setString(3,description);
				apstm.setString(4,flag);
				apstm.setString(5,SGST);
				apstm.setString(6,CGST);
				apstm.setString(7,IGST);
				apstm.setString(8,userid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close(); 
				 
				
			}
			catch(Exception e)
			{
				request.setAttribute("error", e.getMessage() );
	            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    		dispatchers.forward(request, response); 
				System.out.println(e.getMessage());
			}
	}
		
		
	private void taxEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  rowid=""+request.getParameter("taxId");
			HttpSession session=request.getSession();				
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("TxtTaxName").trim();
			String description=request.getParameter("TxtTaxDes").trim();
			String value= request.getParameter("TxtTaxValue") ;
			String flag=""+request.getParameter("flag");flag = flag.equals("Y")?flag:"N";
			String SGST=request.getParameter("SGST");
			String CGST=request.getParameter("CGST");
			String IGST=request.getParameter("IGST");
			
			asql=" UPDATE inv_m_tax SET ";
			asql = asql + " CHR_TAXNAME=?,DOU_VALUE=?,CHR_DES=?,CHR_FLAG=?,DOU_IGST=?,DOU_SGST=?,DOU_CGST=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_TAXID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,value);
			apstm.setString(3,description);
			apstm.setString(4,flag);
			apstm.setString(5,SGST);
			apstm.setString(6,CGST);
			apstm.setString(7,IGST);
			apstm.setString(8,userid);
			apstm.setString(9,rowid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
			
		}
		catch(Exception e)
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				System.out.println(action);
				if(action.equals("INVtaxDelete"))
				{					
					taxDelete(request, response);
					response.sendRedirect("Smart Inventory/TaxView.jsp");
				}
				if("INVtaxAdd".equals(action)){					
					taxAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/TaxView.jsp");
				}
				else if("INVtaxEdit".equals(action)){					
					taxEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/TaxView.jsp");
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

