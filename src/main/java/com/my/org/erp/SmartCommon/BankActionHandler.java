package com.my.org.erp.SmartCommon;

import java.io.IOException;
import java.sql.SQLException;
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class BankActionHandler extends AbstractActionHandler 
{
	 

	
	private void BankDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] Id = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_BANKGROUP(?,?,?,?,?)}");
			
			

			asql = "DELETE FROM com_m_bankgroup WHERE INT_BANKGROUPID=?";
			apstm = con.prepareStatement(asql);
			for (int i = 0; i < Id.length; i++) 
			{
				apstm.setString(1,Id[i]);
				apstm.addBatch();
			}
			apstm.executeBatch();
			apstm.close();
			con.close();
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

			 
		}
	}

	private void BankAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String Name = request.getParameter("Name").trim();
			String shortname = request.getParameter("shortname").trim();
			asql ="INSERT INTO com_m_bankgroup ( CHR_BANKGROUPNAME,CHR_SHORTNAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			asql = asql+ " VALUES (?,?,?,DATE(NOW()),'Y' )";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,Name);
			apstm.setString(2,shortname);
			apstm.setString(3,auserid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			con.close();
			
			
			
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

			 
		}
	}
	
	

	private void BankEdit(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String id = request.getParameter("id");
			String Name = request.getParameter("Name").trim();
			String shortname = request.getParameter("shortname").trim();
			asql = "UPDATE com_m_bankgroup SET "; 
			asql = asql +" CHR_BANKGROUPNAME=?,CHR_SHORTNAME=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' ";
			asql = asql +" WHERE INT_BANKGROUPID=?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,Name);
			apstm.setString(2,shortname);
			apstm.setString(3,auserid);
			apstm.setString(4,id);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			con.close();
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

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
			String action = request.getParameter("actionS");
			 
			if (action.equals("GENBankDelete")) 
			{
				BankDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Common/BankView.jsp");
			} 
			else if (action.equals("GENBankAdd")) 
			{
				BankAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Common/BankView.jsp"); 
			} 
			else if (action.equals("GENBankEdit")) 
			{
				BankEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Common/BankView.jsp");
				 
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

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