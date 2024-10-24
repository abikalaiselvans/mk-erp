package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class DayBookActionHandler extends AbstractActionHandler 
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
			if ("ACCDayBookAdd".equals(action))
			{
				String name=request.getParameter("Name");
				String ledgeraccount=request.getParameter("ledgeraccount");
				String desc=request.getParameter("desc");
				String date=request.getParameter("date");
				String amount=request.getParameter("amount");
				//INT_TYPESUBSIDIARYID,DT_DATE,DOU_AMOUNT,CHR_DESC
				sql = "INSERT INTO accc_t_dayentry(INT_TYPESUBSIDIARYID,INT_LEDGERID,DT_DATE,DOU_AMOUNT,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +""+name+" , ";
				sql = sql +""+ledgeraccount+" , ";
				sql = sql +"'"+DateUtil.FormateDateSQL(date)+"' , ";
				sql = sql +""+amount+" , ";
				sql = sql +"'"+desc+"' , ";
				sql = sql +" '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/DayBook.jsp");
			}
			else if ("ACCDayBookEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String desc=request.getParameter("desc");
				String date=request.getParameter("date");
				String amount=request.getParameter("amount");
				
				sql = "UPDATE  accc_t_dayentry  SET  " ;
				sql = sql + " INT_TYPESUBSIDIARYID="+name+" , ";
				sql = sql + " DT_DATE = '"+DateUtil.FormateDateSQL(date)+"' , ";
				sql = sql + " DOU_AMOUNT="+amount+", ";
				sql = sql +" CHR_DESC ='"+desc+"'   ";
				sql = sql +" WHERE INT_DAYID= "+id;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/DayBook.jsp");
			}
			else if ("ACCDayBookDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
				{
					st.execute("DELETE FROM accc_t_dayentry WHERE INT_DAYID="+ids[u]);
				}
				st.close();
				response.sendRedirect("Smart Accounts/DayBook.jsp");
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
