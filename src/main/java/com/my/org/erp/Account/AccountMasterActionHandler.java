package com.my.org.erp.Account;

import java.io.IOException;
 
import java.sql.Statement;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class AccountMasterActionHandler extends AbstractActionHandler 
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
		 
			if ("ACCAccountMasterAdd".equals(action))
			{
				String name=request.getParameter("name");
				String Groupname =request.getParameter("Groupname");
				String alias =request.getParameter("alias");
				String printname=request.getParameter("printname");
				String opbalance=request.getParameter("opbalance");
				String opbalancetype =request.getParameter("opbalancetype");
				String prbalance =request.getParameter("prbalance");
				String prbalancetype=request.getParameter("prbalancetype");
				String address =request.getParameter("address");
				String phone =request.getParameter("phone");
				String fax =request.getParameter("fax");
				String mobile =request.getParameter("mobile");
				String email=request.getParameter("email");
				String contactperson =request.getParameter("contactperson");
				String itpan =request.getParameter("itpan");
				String lst =request.getParameter("lst");
				String gst =request.getParameter("gst");
				String tin=request.getParameter("tin");
				String ward =request.getParameter("ward");
				String service =request.getParameter("service");
				
				sql = "INSERT INTO acc_m_accountmaster  (INT_ACCOUNTGROUPID,CHR_NAME,CHR_ALIAS,CHR_PRINTNAME,DOU_OPENING,CHR_OPENINGTYPE,DOU_PREVIOUS,CHR_PREVIOUSTYPE,CHR_ADDRESS," +
						"CHR_PHONE,CHR_FAX,CHR_MOBILE,CHR_EMAIL,CHR_CONTACTPERSON,CHR_ITPAN,CHR_LST," +
						"CHR_GST,CHR_TIN,CHR_WARD,CHR_SERVICETAX,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
				sql = sql +"(" ;
				sql = sql +""+Groupname+" , ";
				sql = sql +"'"+name+"' , ";
				sql = sql +"'"+alias+"' , ";
				sql = sql +"'"+printname+"' , ";
				sql = sql +""+opbalance+" , ";
				sql = sql +"'"+opbalancetype+"' , ";
				sql = sql +""+prbalance+" , ";
				sql = sql +"'"+prbalancetype+"' , ";
				sql = sql +"'"+address+"' , ";
				sql = sql +"'"+phone+"' , ";
				sql = sql +"'"+fax+"' , ";
				sql = sql +"'"+mobile+"' , ";
				sql = sql +"'"+email+"' , ";
				sql = sql +"'"+contactperson+"' , ";
				sql = sql +"'"+itpan+"' , ";
				sql = sql +"'"+lst+"' , ";
				sql = sql +"'"+gst+"' , ";
				sql = sql +"'"+tin+"' , ";
				sql = sql +"'"+ward+"' , ";
				sql = sql +"'"+service+"' , ";
				sql = sql +" '"+user+"',NOW(),'Y'";
				sql = sql +")";
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/AccountMaster.jsp");
			}
			else if ("ACCAccountMasterEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String Groupname =request.getParameter("Groupname");
				String alias =request.getParameter("alias");
				String printname=request.getParameter("printname");
				String opbalance=request.getParameter("opbalance");
				String opbalancetype =request.getParameter("opbalancetype");
				String prbalance =request.getParameter("prbalance");
				String prbalancetype=request.getParameter("prbalancetype");
				String address =request.getParameter("address");
				String phone =request.getParameter("phone");
				String fax =request.getParameter("fax");
				String mobile =request.getParameter("mobile");
				String email=request.getParameter("email");
				String contactperson =request.getParameter("contactperson");
				String itpan =request.getParameter("itpan");
				String lst =request.getParameter("lst");
				String gst =request.getParameter("gst");
				String tin=request.getParameter("tin");
				String ward =request.getParameter("ward");
				String service =request.getParameter("service");
				
				 
				sql = "UPDATE  acc_m_accountmaster  SET  " ;
				sql = sql +"INT_ACCOUNTGROUPID ="+Groupname+" , ";
				sql = sql +"CHR_NAME ='"+name+"' , ";
				sql = sql +"CHR_ALIAS ='"+alias+"' , ";
				sql = sql +"CHR_PRINTNAME ='"+printname+"' , ";
				sql = sql +"DOU_OPENING ="+opbalance+" , ";
				sql = sql +"CHR_OPENINGTYPE ='"+opbalancetype+"' , ";
				sql = sql +"DOU_PREVIOUS ="+prbalance+" , ";
				sql = sql +"CHR_PREVIOUSTYPE ='"+prbalancetype+"' , ";
				sql = sql +"CHR_ADDRESS ='"+address+"' , ";
				sql = sql +"CHR_PHONE ='"+phone+"' , ";
				sql = sql +"CHR_FAX ='"+fax +"' , ";
				sql = sql +"CHR_MOBILE ='"+mobile+"' , ";
				sql = sql +"CHR_EMAIL ='"+email+"' , ";
				sql = sql +"CHR_CONTACTPERSON ='"+contactperson+"' , ";
				sql = sql +"CHR_ITPAN ='"+itpan+"' , ";
				sql = sql +"CHR_LST ='"+lst+"' , ";
				sql = sql +"CHR_GST ='"+gst+"' , ";
				sql = sql +"CHR_TIN ='"+tin+"' , ";
				sql = sql +"CHR_WARD ='"+ward+"' , ";
				sql = sql +"CHR_SERVICETAX = '"+service+"' WHERE INT_ACCOUNTMASTERID= "+id;
				st.execute(sql);
				st.close();
				response.sendRedirect("Smart Accounts/AccountMaster.jsp");
			}
			else if ("ACCAccountMasterDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				for(int u=0;u<ids.length;u++)
				{
					st.execute("DELETE FROM acc_m_accountmaster WHERE INT_ACCOUNTMASTERID="+ids[u]);
				}
				st.close();
				response.sendRedirect("Smart Accounts/AccountMaster.jsp");
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
