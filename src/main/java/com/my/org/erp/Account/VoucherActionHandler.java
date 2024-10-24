package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.CallableStatement;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class VoucherActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			switch(EnumActionName.VOUCHERACTION.valueOf(action))
			{

					case ACCVoucherAdd: 
										Add(request,response);
										 
										response.sendRedirect("Smart Accounts/VoucherAction.jsp?action1=Create");
										break;
		
					case ACCVoucherEdit:  
										Edit(request,response);
										 
										response.sendRedirect("Smart Accounts/Voucherview.jsp");
										break;
										
					case ACCVoucherDelete:  					
										Delete(request,response);
										 
										response.sendRedirect("Smart Accounts/Voucherview.jsp");
										break;
					 
			}
			
			
			
			
			
			
			
			
			/*
			 * 
			 String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			String sql="";
			Statement st = con.createStatement();
			 
			if ("ACCNarrationAdd".equals(action))
			{
				String name=request.getParameter("name");
				String Narration =request.getParameter("desc");
				String type =request.getParameter("type");
				sql = "INSERT INTO acc_m_vouchertype  (CHR_VNAME,CHR_NARRATION,CHR_TYPE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+name+"' , ";
				sql = sql +"'"+Narration+"' , ";
				sql = sql +"'"+type+"' , '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Narration.jsp");
			}
			else if ("ACCNarrationEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String Narration =request.getParameter("desc");
				String type =request.getParameter("type");
				sql = "UPDATE  acc_m_vouchertype  SET  " ;
				sql = sql +"CHR_VNAME ='"+name+"' , ";
				sql = sql +"CHR_NARRATION ='"+Narration+"' , ";
				sql = sql +"CHR_TYPE = '"+type+"' WHERE INT_VOUCGERID= "+id;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Narration.jsp");
			}
			else if ("ACCNarrationDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
				{
					st.execute("DELETE FROM acc_m_vouchertype WHERE INT_VOUCGERID="+ids[u]);
				}
				st.close();
				response.sendRedirect("Smart Accounts/Narration.jsp");
			}
			
			st.close();
			 */
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}
	
	
	

	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String name=request.getParameter("name");
			String desc=request.getParameter("desc");
			String type=request.getParameter("type");
			CallableStatement cs=con.prepareCall("{call ACC_PRO_VOUCHER(?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "");
			cs.setString(3, name);
			cs.setString(4, desc);
			cs.setString(5, type);
			cs.setString(6, userid);
			cs.execute();
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	public void Edit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String id=request.getParameter("id");
			String name=request.getParameter("name");
			String desc=request.getParameter("desc");
			String type=request.getParameter("type");
			CallableStatement cs=con.prepareCall("{call ACC_PRO_VOUCHER(?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, id);
			cs.setString(3, name);
			cs.setString(4, desc);
			cs.setString(5, type);
			cs.setString(6, userid);
			cs.execute();
			
			 
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	public void Delete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String ids[] = request.getParameterValues("id");
			CallableStatement cs=con.prepareCall("{call ACC_PRO_VOUCHER(?,?,?,?,?,?)}");
			for(int i=0;i<ids.length;i++)
			{
				cs.setString(1, "DELETE");
				cs.setString(2, ids[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.addBatch();
			}
			cs.executeBatch();
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	

}
