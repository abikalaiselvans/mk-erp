package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class NarrationActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
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
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

}
