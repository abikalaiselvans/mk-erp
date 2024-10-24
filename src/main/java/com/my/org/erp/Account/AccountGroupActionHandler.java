package com.my.org.erp.Account;

import java.io.IOException;
 
import java.sql.Statement;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class AccountGroupActionHandler extends AbstractActionHandler 
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
			if ("ACCAccountGroupAdd".equals(action))
			{
				String Name=request.getParameter("Groupname");
				sql = "INSERT INTO acc_m_accountgroup  (CHR_ACCOUNTGROUPNAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+Name+"' ,  '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/AccountGroup.jsp");
			}
			else if ("ACCAccountGroupEdit".equals(action))
			{
				String Name=request.getParameter("Groupname");
				String Row=request.getParameter("id");
				sql = "UPDATE  acc_m_accountgroup  SET  " ;
				sql = sql +"CHR_ACCOUNTGROUPNAME ='"+Name+"'  WHERE INT_ACCOUNTGROUPID= "+Row;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/AccountGroup.jsp");
			}
			else if ("ACCAccountGroupDelete".equals(action))
			{
				String ids[] = request.getParameterValues("groupid");
				for(int u=0;u<ids.length;u++)
					st.execute("DELETE FROM acc_m_accountgroup WHERE INT_ACCOUNTGROUPID="+ids[u]);
				
				st.close();
				response.sendRedirect("Smart Accounts/AccountGroup.jsp");
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
