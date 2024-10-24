package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class SpareCallAssignActionHandler extends AbstractActionHandler
{
	
	private void SpareCallAssignDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("id");
			System.out.println("dghfh"+rowid);
			asql ="DELETE FROM spare_t_callassign WHERE INT_CALLASSIGNID=?";
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
	
	
	private void SpareCallAssignAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String empid=""+session.getAttribute("EMPID");	
			String callno = request.getParameter("callno");
			String serialnumber = request.getParameter("serialnumber");
			String startdate = request.getParameter("startdate");
			String prioritytype = request.getParameter("prioritytype");
			String inhours = request.getParameter("inhours");
			String problem = request.getParameter("problem");
			String cperson = request.getParameter("cperson");
			String phone = request.getParameter("phone");
			String mobile = request.getParameter("mobile");
			String email = request.getParameter("email");
			String description = request.getParameter("description");
			String ename = request.getParameter("ename");
			asql = " INSERT INTO spare_t_callassign ";
			asql = asql + " ( CHR_CALLASSIGNREFNO,INT_CALLNO,CHR_SERIALNO,DAT_CALLASSIGNDATE ,";
			asql = asql + " CHR_PRIORITY,INT_HOURS,INT_PROBLEMID,CHR_CONTACTPERSON, ";
			asql = asql + " CHR_PHONE,CHR_MOBILE,CHR_EMAIL , ";
			asql = asql + " CHR_REMARKS,CHR_ENGINEER,CHR_CREATEDBY,DT_CREATION , ";
			asql = asql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW(),?,DATE(NOW()),'Y' )";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,spareCallAssignNumber(""+session.getAttribute("INVSTATE")) );
			apstm.setString(2,callno);
			apstm.setString(3,serialnumber );
			apstm.setString(4,DateUtil.FormateDateandTimeSQL(startdate) );
			apstm.setString(5,prioritytype );
			apstm.setString(6,inhours );
			apstm.setString(7,problem );
			apstm.setString(8,cperson );
			apstm.setString(9,phone );
			apstm.setString(10,mobile );
			apstm.setString(11,email );
			apstm.setString(12,description );
			apstm.setString(13,ename );
			apstm.setString(14,empid );
			apstm.setString(15,userid );
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
			apstm=con.prepareStatement("  SELECT FUN_SPARE_CALLASSIGN_NUMBER_INSERT(?) ");
			apstm.setString(1,""+session.getAttribute("INVSTATE"));
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
	
	
	private void SpareCallAssignEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	  
			 
			HttpSession session=request.getSession();				
			String userid=""+session.getAttribute("USRID");
			String empid=""+session.getAttribute("EMPID");	
			String callno = request.getParameter("callno");
			String serialnumber = request.getParameter("serialnumber");
			String startdate = request.getParameter("startdate");
			String prioritytype = request.getParameter("prioritytype");
			String inhours = request.getParameter("inhours");
			String problem = request.getParameter("problem");
			String cperson = request.getParameter("cperson");
			String phone = request.getParameter("phone");
			String mobile = request.getParameter("mobile");
			String email = request.getParameter("email");
			String description = request.getParameter("description");
			String ename = request.getParameter("ename");
			String rowid = request.getParameter("rowid");
			
			asql = " UPDATE spare_t_callassign SET ";
			asql = asql + " INT_CALLNO=?,CHR_SERIALNO=?,DAT_CALLASSIGNDATE=? ,";
			asql = asql + " CHR_PRIORITY=?,INT_HOURS=?,INT_PROBLEMID=?,CHR_CONTACTPERSON=?, ";
			asql = asql + " CHR_PHONE=?,CHR_MOBILE=?,CHR_EMAIL=? , ";
			asql = asql + " CHR_REMARKS=?,CHR_ENGINEER=?,  ";
			asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW())  WHERE INT_CALLASSIGNID=? ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,callno);
			apstm.setString(2,serialnumber );
			apstm.setString(3,DateUtil.FormateDateandTimeSQL(startdate) );
			apstm.setString(4,prioritytype );
			apstm.setString(5,inhours );
			apstm.setString(6,problem );
			apstm.setString(7,cperson );
			apstm.setString(8,phone );
			apstm.setString(9,mobile );
			apstm.setString(10,email );
			apstm.setString(11,description );
			apstm.setString(12,ename );
			apstm.setString(13,userid );
			apstm.setString(14,rowid );
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
				if(action.equals("INVSpareCallAssignDelete"))
				{					
					SpareCallAssignDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareCallAssignView.jsp");
				}
				if("INVSpareCallAssignAdd".equals(action))
				{					
					SpareCallAssignAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareCallAssignView.jsp");
				}
				else if("INVSpareCallAssignEdit".equals(action))
				{					
					SpareCallAssignEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareCallAssignView.jsp");
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
	
	
	public static String spareCallAssignNumber(String state) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_SPARE_CALLASSIGN_NUMBER('"+state+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
}

