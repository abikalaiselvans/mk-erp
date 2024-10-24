package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class AMCPaymentActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					if(action.equals("INVAMCPaymentAdd"))
					{					
						addServicePayment(request,response);
						con.close();    
						response.sendRedirect("Smart Inventory/AMCPayment.jsp");
					}
					else if(action.equals("INVAMCPaymentUpdate"))
					{
						updateServicePayment(request,response);
						con.close();    
						response.sendRedirect("Smart Inventory/AMCPayment.jsp?kalai");
					}
					else if(action.equals("INVAMCPaymentDelete"))
					{
						deleteServicePayment(request,response);
						con.close();    
						response.sendRedirect("Smart Inventory/AMCPayment.jsp");
					}
					else if(action.equals("INVpayList")){
						con.close();    
						response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
					}
					else if(action.equals("INVpayDelete")){	
						con.close();    
						response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
					}
					if("INVpayAdd".equals(action)){		
						con.close();    
						response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
					}
					else if("INVpayEdit".equals(action)){	
						con.close();    
						response.sendRedirect("Smart Inventory/PaymentTermView.jsp");
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
	
	
		private void addServicePayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				String payType = request.getParameter("payType");
				String Serviceids = request.getParameter("Serviceids");
				String paiddate = request.getParameter("paiddate");
				String paidamount = request.getParameter("paidamount");
				String balance = request.getParameter("balance");
				String paymentdesc = request.getParameter("paymentdesc");
				String type="";
				if(payType.equals("Invoice"))
					type = "A";
			 	if(payType.equals("CashPay"))
			 		type="S";
			 	
			 	HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");	
			 	String sql ="";
				sql="SELECT MAX(INT_SERVICEID) FROM inv_t_serviceamount ";
				int maxid=CommonFunction.intRecordCount(con, sql)+1;
				
				sql="INSERT INTO inv_t_serviceamount(INT_SERVICEID ,CHR_SERVICEID, "+
				"CHR_FLAG,"+
				"DOU_PAIDAMOUNT,DAT_PAYMENTDATE,"+
				"CHR_PAYMENTDESC,DOU_BALANCE,"+
				"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "+
				"values(?,?,?,?,?,?,?,?,?,?)";			
				PreparedStatement ps=con.prepareStatement(sql);
				ps.setInt(1, maxid);
				ps.setString(2, Serviceids);
				ps.setString(3, type);
				ps.setDouble(4, Double.parseDouble(paidamount));
				ps.setString(5, DateUtil.FormateDateSQL(paiddate));
				ps.setString(6, paymentdesc);
				ps.setDouble(7, ((Double.parseDouble(balance))-(Double.parseDouble(paidamount))));
				ps.setString(8, userId);
				ps.setString(9,DateUtil.getCurrentDateTime() );
				ps.setString(10, "Y");	
				ps.execute();
			 	
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}	
		
			
			
	}
		
		
		private void updateServicePayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				 
				String Serviceids = request.getParameter("serviceid");
				String paiddate = request.getParameter("paiddate");
				String paidamount = request.getParameter("paidamount");
				String balance = request.getParameter("balance");
				String paymentdesc = request.getParameter("paymentdesc");
				String amount = request.getParameter("amount");
				String rowid = request.getParameter("rowid");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");	
			 	double amt =Double.parseDouble(amount);
			 	double bal =Double.parseDouble(balance);
			 	double paid = Double.parseDouble(paidamount);
			 	amt = amt+bal;
			 	bal = amt -paid;
			 	String sql="UPDATE inv_t_serviceamount SET ";
				sql = sql +" DOU_PAIDAMOUNT = ? ," ; 
				sql = sql +" DAT_PAYMENTDATE = ?,";
				sql = sql +" CHR_PAYMENTDESC = ? ,"; 
				sql = sql +" DOU_BALANCE =  ? , ";
				sql = sql +" CHR_USRNAME = ? , "; 
				sql = sql +" DT_UPDATEDATE = ? ,"; 
				sql = sql +" CHR_UPDATESTATUS = ? ";
				sql = sql +" WHERE INT_SERVICEID =? ";
				sql = sql +" AND CHR_SERVICEID =? ";
				PreparedStatement ps=con.prepareStatement(sql);
				ps.setDouble(1, paid);
				ps.setString(2, DateUtil.FormateDateSQL(paiddate));
				ps.setString(3, paymentdesc);
				ps.setDouble(4, bal);
				ps.setString(5, userId);
				ps.setString(6,DateUtil.getCurrentDateTime() );
				ps.setString(7, "Y");	
				ps.setInt(8, Integer.parseInt(rowid));
				ps.setString(9, Serviceids);
				ps.execute();
			 	
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}	
		
	}
		private void deleteServicePayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				String sql="";
				@SuppressWarnings("unused")
				String tbname="";
				String serviceid[] = request.getParameterValues("salesid");
				for(int u=0; u<serviceid.length;u++)
				{
					String serviceids[] = serviceid[u].split("~");
					String id = serviceids[0];
					String flag = serviceids[1];
					sql = " DELETE FROM inv_t_serviceamount WHERE CHR_SERVICEID =? AND CHR_FLAG =?";
					PreparedStatement ps=con.prepareStatement(sql);
					ps.setString(1,  id);
					ps.setString(2, flag);
					ps.execute();
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