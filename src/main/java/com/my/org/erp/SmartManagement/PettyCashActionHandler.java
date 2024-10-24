package com.my.org.erp.SmartManagement;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import org.apache.commons.beanutils.BeanUtils;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.management.PettyCash;
 

public class PettyCashActionHandler extends AbstractActionHandler {

	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			if ("MGTPettyCashAdd".equals(action)) 
			{	
				//Add(request,response);
				PettyCash c =new PettyCash();
				Map map=request.getParameterMap();
				BeanUtils.populate(c,map);
				asql = " INSERT INTO mgt_m_pettycash ";
				asql = asql +" (CHR_NAME,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
				asql = asql +" VALUES (?,?,?,DATE(NOW()),'Y') ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,""+c.getName().replaceAll("&", " and "));
				apstm.setString(2,c.getDesc());
				apstm.setString(3,""+auserid);
				System.out.println(apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Management/PettyCash.jsp");
			}
			else if ("MGTPettyCashEdit".equals(action)) 
			{ 
				 
				PettyCash c =new PettyCash();
				Map map=request.getParameterMap();
				BeanUtils.populate(c,map);
				asql = " UPDATE  mgt_m_pettycash  SET CHR_NAME=?,CHR_DESC=?   ";
				asql = asql +" WHERE INT_CATEGORYID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, ""+c.getName().replaceAll("&", " and "));
				apstm.setString(2, c.getDesc());
				apstm.setString(3, ""+c.getRowid());
				System.out.println(apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Management/PettyCash.jsp");
				
			} 
			else if ("MGTPettyCashDelete".equals(action)) 
			{ 
				String []rowid= request.getParameterValues("rowid");							
				asql = " DELETE FROM mgt_m_pettycash  WHERE INT_CATEGORYID =?";
				apstm = con.prepareStatement(asql);
				for(int i=0;i<rowid.length;i++)
				{
					apstm.setString(1, rowid[i]) ;
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
				
				con.close();
				response.sendRedirect("Smart Management/PettyCash.jsp");
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