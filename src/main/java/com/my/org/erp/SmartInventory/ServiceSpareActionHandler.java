package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ServiceSpareActionHandler extends AbstractActionHandler
{
	
	private void spareDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("id");
			System.out.println("dghfh"+rowid);
			asql ="DELETE FROM inv_m_sparemaster WHERE INT_ROWID=?";
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
	
	
	private void spareAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String customer=""+request.getParameter("customernam");
			String location=""+request.getParameter("location");
			String unittype=""+request.getParameter("unittype");
			String model=""+request.getParameter("model");
			String category=""+request.getParameter("category");
			String serialno=""+request.getParameter("serialno");
			String description=""+request.getParameter("description");
			
			String sdate=""+request.getParameter("fromdate");
			String edate=""+request.getParameter("todate");
			asql = asql + " INSERT INTO inv_m_sparemaster ";
			asql = asql + "     (  INT_CUSTOMERID,INT_SPAREUNITID,INT_MODELID,CHR_CATEGORY,";
			asql = asql + "        CHR_SERIALNO,CHR_DESC,INT_STATEID,DAT_CREATION,DT_STARTDATE,DT_ENDDATE,";
			asql = asql + "        CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS";
			asql = asql + "      )";
			asql = asql + "      VALUES";
			asql = asql + "      ( ";
			asql = asql + "       ?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ) ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,customer);
			apstm.setString(2,unittype);
			apstm.setString(3,model);
			apstm.setString(4,category);
			apstm.setString(5,serialno);
			apstm.setString(6,description);
			apstm.setString(7,location);
			apstm.setString(8,DateUtil.FormateDateSQL(sdate));
			apstm.setString(9,DateUtil.FormateDateSQL(edate));
			apstm.setString(10,DateUtil.FormateDateSQL(sdate));
			apstm.setString(11,userid);
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
	
	
	private void spareEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	  
			String  rowid=""+request.getParameter("id");
			HttpSession session=request.getSession();				
			String userid=""+session.getAttribute("USRID");
			String customer=""+request.getParameter("customernam");
			String location=""+request.getParameter("location");
			String unittype=""+request.getParameter("unittype");
			String model=""+request.getParameter("model");
			String category=""+request.getParameter("category");
			String serialno=""+request.getParameter("serialno");
			String description=""+request.getParameter("description");
			String sdate=""+request.getParameter("fromdate");
			String edate=""+request.getParameter("todate");
			asql=" UPDATE inv_m_sparemaster SET ";
			asql = asql + " INT_CUSTOMERID=?, ";
			asql = asql + " INT_SPAREUNITID=?, ";
			asql = asql + " INT_MODELID=?,";
			asql = asql + " CHR_CATEGORY=?,";
			asql = asql + " CHR_SERIALNO=?,";
			asql = asql + " CHR_DESC=?,";
			asql = asql + " INT_STATEID=?,";
			asql = asql + " DT_STARTDATE=?,DT_ENDDATE=?,";
			asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y'";
			asql = asql + " WHERE INT_ROWID=? ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,customer);
			apstm.setString(2,unittype);
			apstm.setString(3,model);
			apstm.setString(4,category);
			apstm.setString(5,serialno);
			apstm.setString(6,description);
			apstm.setString(7,location);
			apstm.setString(8,DateUtil.FormateDateSQL(sdate));
			apstm.setString(9,DateUtil.FormateDateSQL(edate));
			apstm.setString(10,userid);
			apstm.setString(11,rowid);
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
				if(action.equals("INVServiceSpareDelete"))
				{					
					spareDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareMaster.jsp");
				}
				if("INVServiceSpareAdd".equals(action))
				{					
					spareAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareMaster.jsp");
				}
				else if("INVServiceSpareEdit".equals(action))
				{					
					spareEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareMaster.jsp");
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

