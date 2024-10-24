package com.my.org.erp.Account;

import java.io.IOException;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class LedgerActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			
			String sql="";
			//com.my.org.erp.common.CommonFunctions.dateandTimeDifference(fromdate, todate)
			Statement st = con.createStatement();
			if ("ACCLedgerAdd".equals(action))
			{
				
				String Name=request.getParameter("Name");
				String Alias=request.getParameter("Alias");
				String under=request.getParameter("under");
				String Name1=request.getParameter("Name1");
				String acnumber=request.getParameter("acnumber");
				String address=request.getParameter("address");
				String phone=request.getParameter("phone");
				String mobile=request.getParameter("mobile");
				String email=request.getParameter("email");
				String pannumber=request.getParameter("pannumber");
				String tinnumber=request.getParameter("tinnumber");
				String servicetax=request.getParameter("servicetax");
				
				
				//CHR_NAME,CHR_ALIAS,INT_TYPESUBSIDIARYID,CHR_NAME1,CHR_ADDRESS,CHR_PHONE,CHR_MOBILE,CHR_EMAIL,CHR_PAN,CHR_TIN,CHR_SERVICETAX,DAT_DATE
				
				sql = "INSERT INTO accc_m_ledger(CHR_NAME,CHR_ALIAS,INT_TYPESUBSIDIARYID,CHR_NAME1,CHR_ACCOUNT,CHR_ADDRESS,CHR_PHONE,CHR_MOBILE,CHR_EMAIL,CHR_PAN,CHR_TIN,CHR_SERVICETAX,DAT_DATE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +"'"+Name+"' , ";
				sql = sql +"'"+Alias+"' , ";
				sql = sql +"'"+under+"' , ";
				sql = sql +"'"+Name1+"' , ";
				sql = sql +"'"+acnumber+"' , ";
				sql = sql +"'"+address+"' , ";
				sql = sql +"'"+phone+"' , ";
				sql = sql +"'"+mobile+"' , ";
				sql = sql +"'"+email+"' , ";
				sql = sql +"'"+pannumber+"' , ";
				sql = sql +"'"+tinnumber+"' , ";
				sql = sql +"'"+servicetax+"' , ";
				sql = sql +" now() , ";
				sql = sql +" '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/LedgerEntry.jsp");
			}
			else if ("ACCLedgerEdit".equals(action))
			{
				 
				String id=request.getParameter("id");
				String Name=request.getParameter("Name");
				String Alias=request.getParameter("Alias");
				String under=request.getParameter("under");
				String Name1=request.getParameter("Name1");
				String acnumber=request.getParameter("acnumber");
				String address=request.getParameter("address");
				String phone=request.getParameter("phone");
				String mobile=request.getParameter("mobile");
				String email=request.getParameter("email");
				String pannumber=request.getParameter("pannumber");
				String tinnumber=request.getParameter("tinnumber");
				String servicetax=request.getParameter("servicetax");
 				 
				
				
				sql = "UPDATE  accc_m_ledger  SET  " ;
				sql = sql +" CHR_NAME ='"+Name+"'  , ";
				sql = sql +" CHR_ALIAS ='"+Alias+"' ,  ";
				sql = sql +" INT_TYPESUBSIDIARYID ='"+under+"'  , ";
				sql = sql +" CHR_NAME1 ='"+Name1+"'  , ";
				sql = sql +" CHR_ACCOUNT ='"+acnumber+"'  , ";
				sql = sql +" CHR_ADDRESS ='"+address+"'  , ";
				sql = sql +" CHR_PHONE ='"+phone+"'  , ";
				sql = sql +" CHR_MOBILE ='"+mobile+"'  , ";
				sql = sql +" CHR_EMAIL ='"+email+"'  , ";
				sql = sql +" CHR_PAN ='"+pannumber+"'  , ";
				sql = sql +" CHR_TIN ='"+tinnumber+"'  , ";
				sql = sql +" CHR_SERVICETAX ='"+servicetax+"'   ";
				sql = sql +" WHERE INT_LEDGERID= "+id;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/LedgerEntry.jsp");
			}
			else if ("ACCDayBookDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
				{
					st.execute("DELETE FROM accc_t_dayentry WHERE INT_DAYID="+ids[u]);
				}
				st.close();
				response.sendRedirect("Smart Accounts/LedgerEntry.jsp");
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
