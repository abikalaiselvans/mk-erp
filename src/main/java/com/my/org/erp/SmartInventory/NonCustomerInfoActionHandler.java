package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class NonCustomerInfoActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				Statement st = con.createStatement();
				String sql="";
							
				if("INVNonCustomerInfoAdd".equals(action))
				{
					String name=request.getParameter("name");
					String street=request.getParameter("street");
					String city=request.getParameter("city");
					String state=request.getParameter("state");
					String pin="0"+request.getParameter("pin");
					String country=request.getParameter("country");
					String phone=request.getParameter("phone");
					String mobile=request.getParameter("mobile");
					
					String fax=request.getParameter("fax");
					String email=request.getParameter("email");
					String website=request.getParameter("website");
					
					
					
					int custid=0;
					if(com.my.org.erp.common.CommonInfo.RecordExist("SELECT COUNT(* )from inv_m_noncustomerinfo"))
					{
						String sq = "SELECT MAX(INT_CUSTOMERID) from inv_m_noncustomerinfo";
						String a[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
						custid=Integer.parseInt(a[0][0])+1;
					}
					else
						custid=custid+1;
					
					sql = "INSERT INTO inv_m_noncustomerinfo" +
							" ( INT_CUSTOMERID,CHR_CUSTOMERNAME," +
							" CHR_STREET,CHR_CITY," +
							" CHR_STATE ,CHR_POSTAL ,CHR_COUNTRY," +
							" CHR_PHONE,CHR_MOBILE,CHR_FAX,CHR_EMAIL," +
							" CHR_WEBSITE,INT_ACTIVE,CHR_USRNAME," +
							" DT_UPDATEDATE, CHR_UPDATESTATUS )  VALUES (";
					sql = sql +" '"+custid+"' ,";
					sql = sql +" '"+name +"' , ";
					sql = sql +" '"+street+"' , ";
					sql = sql +" '"+city +"' , ";
					sql = sql +" '"+state +"' , ";
					sql = sql +" '"+pin +"' , ";
					sql = sql +" '"+country +"' , ";
					sql = sql +" '"+phone +"' , ";
					sql = sql +" '"+mobile +"' , ";
					sql = sql +" '"+fax +"' , ";
					sql = sql +" '"+email +"' , ";
					sql = sql +" '"+website +"' , ";
					sql = sql +"1 , ";
					sql = sql +" '"+userId +"' , ";
					sql = sql +" now() , 'Y' )";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/NonCustomerInfo.jsp");
				}	
				else if("INVNonCustomerInfoUpdate".equals(action))
				{
					String custid =request.getParameter("custid");
					String name=request.getParameter("name");
					String street=request.getParameter("street");
					String city=request.getParameter("city");
					String state=request.getParameter("state");
					String pin="0"+request.getParameter("pin");					
					String country=request.getParameter("country");
					String phone=""+request.getParameter("phone");
					String mobile=request.getParameter("mobile");
					String fax=request.getParameter("fax");
					String email=request.getParameter("email");
					String website=request.getParameter("website");
					String status=request.getParameter("status");
							
					if("on".equals(status))
						status="1";
					else
						status="0"; 					
					sql = "UPDATE inv_m_noncustomerinfo SET " ;
					sql = sql +" CHR_CUSTOMERNAME = '"+name +"' , ";
					sql = sql +" CHR_STREET ='"+street+"' , ";
					sql = sql +" CHR_CITY  = '"+city +"' , ";
					sql = sql +" CHR_STATE = '"+state +"' , ";
					sql = sql +" CHR_POSTAL = '"+pin +"' , ";
					sql = sql +" CHR_COUNTRY = '"+country +"' , ";
					sql = sql +" CHR_PHONE = '"+phone +"' , ";
					sql = sql +" CHR_MOBILE = '"+mobile +"' , ";
					sql = sql +" CHR_FAX = '"+fax +"' , ";
					sql = sql +" CHR_EMAIL = '"+email +"' , ";
					sql = sql +" CHR_WEBSITE = '"+website +"' , ";
					sql = sql +" INT_ACTIVE = "+Integer.parseInt(status)+"   , ";
					sql = sql +" CHR_USRNAME ='"+userId +"'  ";
					sql = sql +" Where  INT_CUSTOMERID = "+Integer.parseInt(custid);
					st.execute(sql);
					con.close();   
					response.sendRedirect("Smart Inventory/NonCustomerInfo.jsp");
				}
				else if("INVNonCustomerInfoDelete".equals(action))
				{
					String custids[] = request.getParameterValues("custid");
					for(int u=0; u<custids.length;u++)
					{
						sql = "DELETE FROM inv_m_noncustomerinfo Where  INT_CUSTOMERID = "+Integer.parseInt(custids[u]);
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/NonCustomerInfo.jsp");
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