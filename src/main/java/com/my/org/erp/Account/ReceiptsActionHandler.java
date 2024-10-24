package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ReceiptsActionHandler extends AbstractActionHandler {
	 

	 
  
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			String cpy = (String) session.getAttribute("ACCCOMPANY");
			String bch = (String) session.getAttribute("ACCBRANCH");
			String sql="";
			Statement st = con.createStatement();
			
			if ("ACCReceiptsAdd".equals(action)) 
			{
				String group=request.getParameter("group");
				String desc=request.getParameter("desc");
				String incomedate=request.getParameter("incomedate");
				String Amount=request.getParameter("Amount");
				String Financialyear=request.getParameter("Financialyear");
				
				sql="INSERT INTO   acc_t_receipts  (INT_GROUPID,INT_COMPANYID,INT_BRANCHID,CHR_DESC,DAT_DATE,DOU_AMOUNT,INT_FINANCIALYEARID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"( ";
				sql = sql +" "+group+", ";
				sql = sql +" "+cpy+", ";
				sql = sql +" "+bch+", ";
				sql = sql +" '"+desc+"', ";
				sql = sql +" '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(incomedate)+"', ";
				sql = sql +" "+Amount+", ";
				sql = sql +" "+Financialyear+", ";
				sql = sql +" '"+user+"', now(),'Y'";
				sql = sql +" )";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Receipts.jsp");
			}
			else if ("ACCReceiptsUpdate".equals(action)) 
			{
				String id = request.getParameter("Rowid");
				String group=request.getParameter("group");
				String desc=request.getParameter("desc");
				String incomedate=request.getParameter("incomedate");
				String Amount=request.getParameter("Amount");
				sql="UPDATE   acc_t_receipts   SET  ";
				sql = sql +"  INT_GROUPID="+group+", ";
				sql = sql +"  CHR_DESC='"+desc+"', ";
				sql = sql +"  DAT_DATE= '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(incomedate)+"', ";
				sql = sql +"  DOU_AMOUNT="+Amount+" ";
				sql = sql +"  WHERE INT_INCOMEID="+id;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/Receipts.jsp");
			}
			else if ("ACCReceiptsDelete".equals(action)) 
			{
				String ids[] =request.getParameterValues("incomeid");
				for(int u=0;u<ids.length;u++)
					st.execute(" DELETE FROM   acc_t_receipts   WHERE INT_INCOMEID="+ids[u]);
				st.close();
				response.sendRedirect("Smart Accounts/Receipts.jsp");
			}
			st.close();
			
		 
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());

		}
	}

}
