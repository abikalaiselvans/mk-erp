package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class SSpareDemandActionHandler extends AbstractActionHandler{
 	
	
	private void sparesemanddelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("id");
			asql ="DELETE FROM inv_ss_sparedemand WHERE INT_DEMANID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
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
	
	
	private void spareDemandAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String branch=""+session.getAttribute("BRANCHID");
			String callno1=""+request.getParameter("callno");
			String serialno=""+request.getParameter("serialno");
			String description=""+request.getParameter("description");
			String sdate=""+request.getParameter("fromdate") ;
			String despatchlocation=""+request.getParameter("despatchlocation");
			String customer=""+request.getParameter("customer");
			String customeraddress=""+request.getParameter("customeraddress");
			String calltype=""+request.getParameter("calltype");
			String partdescription=""+request.getParameter("partdescription");
			
			String Sparenumber="SPD/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.sspareNumber();
			
			asql=" INSERT INTO inv_ss_sparedemand ";
			asql = asql + " (CHR_DEMANDNO,INT_BRANCHID,CHR_PRODUCT_SERIALNUMBER,CHR_CALLNUMBER,";
			asql = asql + " CHR_DESC,DAT_DEMAND_RAISED_DATE,CHR_DEMAND_RAISED_BY,CHR_DESPATCH_LOCATION,";
			asql = asql + " CHR_ISSUED,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ,";
			asql = asql + " CHR_CUSTOMER,CHR_CUSTOMER_ADDRESS,CHR_CALLTYPE,CHR_PART_DESC )";
			asql = asql + " VALUES(?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y',?,?,?,?)";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,Sparenumber);
			apstm.setString(2,branch);
			apstm.setString(3,serialno);
			apstm.setString(4,callno1);
			apstm.setString(5,description);
			apstm.setString(6,DateUtil.FormateDateandTimeSQL(sdate));
			apstm.setString(7,userid);
			apstm.setString(8,despatchlocation);
			apstm.setString(9,"N");
			apstm.setString(10,userid);
			apstm.setString(11,customer);
			apstm.setString(12,customeraddress);
			apstm.setString(13,calltype);
			apstm.setString(14,partdescription);
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
	
	private void sparedemandEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String branch=""+session.getAttribute("BRANCHID");
			String callno1=""+request.getParameter("callno");
			String serialno=""+request.getParameter("serialno");
			String description=""+request.getParameter("description");
			String sdate=""+request.getParameter("fromdate");
			String despatchlocation=""+request.getParameter("despatchlocation");
			String rowid=""+request.getParameter("id");
			String customer=""+request.getParameter("customer");
			String customeraddress=""+request.getParameter("customeraddress");
			String calltype=""+request.getParameter("calltype");
			String partdescription=""+request.getParameter("partdescription");
			
			asql=" UPDATE inv_ss_sparedemand SET ";
			asql = asql + " INT_BRANCHID=?,CHR_PRODUCT_SERIALNUMBER=?,CHR_CALLNUMBER=?,CHR_DESC=?,";
			asql = asql + " DAT_DEMAND_RAISED_DATE=?,CHR_DEMAND_RAISED_BY=?,CHR_DESPATCH_LOCATION=?, "; 
			asql = asql + " CHR_CUSTOMER=?,CHR_CUSTOMER_ADDRESS=?,CHR_CALLTYPE=?,CHR_PART_DESC=? ";		
			asql = asql + " WHERE INT_DEMANID=? "; 
			System.out.println("asql...."+asql);
			apstm =con.prepareStatement(asql);
			apstm.setString(1,branch);
			apstm.setString(2,serialno);
			apstm.setString(3,callno1);
			apstm.setString(4,description);
			apstm.setString(5,DateUtil.FormateDateandTimeSQL(sdate));
			apstm.setString(6,userid);
			apstm.setString(7,despatchlocation);
			if(!"Q".equals(calltype))
			{
				apstm.setString(8,customer);
				apstm.setString(9,customeraddress);
			}
			else
			{
				apstm.setString(8,"");
				apstm.setString(9,"");
			}
			apstm.setString(10,calltype);
			apstm.setString(11,partdescription);
			apstm.setString(12,rowid);
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
	
	private void spareIssueItemproductReopen(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String rowid= request.getParameter("id");
			String sql_Update_Query ="UPDATE inv_ss_sparedemand SET CHR_ISSUED = ? WHERE INT_DEMANID=?";
			apstm = con.prepareStatement(sql_Update_Query);
			apstm.setString(1,"N");
			apstm.setString(2,rowid);
			apstm.execute();		
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
				if(action.equals("INVSpareDemandDelete"))
				{					
					sparesemanddelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareDemand.jsp");
				}
				if("INVSpareDemandAdd".equals(action))
				{					
					spareDemandAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareDemand.jsp");
				}
				else if("INVSpareDemandEdit".equals(action))
				{					
					sparedemandEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareDemand.jsp");
				}
				else if("INVSpareDemandReopen".equals(action))
				{					
					spareIssueItemproductReopen(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareDemand.jsp");
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

