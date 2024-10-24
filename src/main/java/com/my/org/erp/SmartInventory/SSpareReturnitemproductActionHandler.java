package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class SSpareReturnitemproductActionHandler extends AbstractActionHandler
{
	
	
	private void sparesreturnitemproductdelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String rowid=""+request.getParameter("id");
			System.out.println("rowid....."+rowid);
			asql=" UPDATE inv_ss_t_sparedemandissue SET ";
			asql = asql + "INT_RETURN_QTY=?,INT_USED_QTY=?,CHR_RETURN_SERIALNUMBER=?,CHR_RETURN_STATUS=?,DAT_RETURN_DATE=?,CHR_RETURN_DESC=?,CHR_RETURN_TYPE=? WHERE INT_ISSUEID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,"0");
			apstm.setString(2,"0");
			apstm.setString(3,"");
			apstm.setString(4,"N");
			apstm.setString(5,null);
			apstm.setString(6,"");
			apstm.setString(7,"R");
			apstm.setString(8,rowid);
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
	
	
	private void sparereturnitemproductEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			
			
			String receivedserialno=""+request.getParameter("receivedserialno");
			String receivedstatus=""+request.getParameter("receivedstatus");
			String qty=""+request.getParameter("qty");
			String receiveDate=""+request.getParameter("recivedDate") ;
			String receiveddescription=""+request.getParameter("receiveddescription");
			String returntype=""+request.getParameter("returntype");
			String returnid=""+request.getParameter("returnid");
			String usedquatity=""+request.getParameter("usedquatity");
			 
			if("".equals(qty) || "null".equals(qty))
				qty = "0";
			
			if("".equals(receivedserialno) || "null".equals(receivedserialno))
				receivedserialno = "0";
			
			if("".equals(usedquatity) || "null".equals(usedquatity))
				usedquatity = "0";
			
			if("".equals(receivedstatus) || "null".equals(receivedstatus))
				receivedstatus = "";
			
			asql=" UPDATE inv_ss_t_sparedemandissue SET ";
			asql = asql + "INT_RETURN_QTY=?,INT_USED_QTY=?,CHR_RETURN_SERIALNUMBER=?,CHR_RETURN_STATUS=?,DAT_RETURN_DATE=?,CHR_RETURN_DESC=?,CHR_RETURN_TYPE=? WHERE INT_ISSUEID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,qty);
			apstm.setString(2,usedquatity);
			apstm.setString(3,receivedserialno);
			apstm.setString(4,receivedstatus);
			apstm.setString(5,DateUtil.FormateDateandTimeSQL(receiveDate));
			apstm.setString(6,receiveddescription);
			apstm.setString(7,returntype);
			apstm.setString(8,returnid);
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
				if(action.equals("INVSparereturnitemproductdelete"))
				{
					sparesreturnitemproductdelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSparereturnview.jsp");
				}
				else if("INVSparereturnitemproductedit".equals(action))
				{					
					sparereturnitemproductEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSparereturnview.jsp");
				}
		}
		catch(Exception e) 
		{
			request.setAttribute("error", e.getMessage());
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
    		System.out.println(e.getMessage());
		}
	}
	
}

