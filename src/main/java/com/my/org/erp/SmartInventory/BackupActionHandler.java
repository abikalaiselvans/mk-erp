package com.my.org.erp.SmartInventory;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class BackupActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					System.out.println(action);
					if(action.equals("INVBackup"))
					{					
						Runtime rt = Runtime.getRuntime();
						PrintStream ps;
						String profilename = "JDBC.properties";
						InputStream input = new FileInputStream(profilename);
						Properties dbfile = new Properties();
						dbfile.load(input);
						String host=dbfile.getProperty("localhost:3306");
						String user=dbfile.getProperty("DB_USERNAME");
						String pw=dbfile.getProperty("DB_PASSWORD");
						String databasedumb=dbfile.getProperty("exportpath");
						 
						
						String mysqlpath = "C:/Program Files/MySQL/MySQL Server 5.0";//dbfile.getProperty("mysql");
						mysqlpath = mysqlpath+"/bin/mysqldump -h "+host+" -u "+user+" -p "+pw+" smartcampus";
						File test=new File(databasedumb); 
						Process child = rt.exec(mysqlpath);
						ps=new PrintStream(test);
						InputStream in = child.getInputStream();
						int ch;
						while ((ch = in.read()) != -1) 
								ps.write(ch);
						con.close();   
						response.sendRedirect("Smart Inventory/InventoryMain.jsp");
					}
					
			}
			catch (Exception e) 
			{
				 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
				 System.out.println(e.getMessage());
			}
		}
	
	
		@SuppressWarnings("unused")
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
				apstm=con.prepareStatement(sql);
				apstm.setInt(1, maxid);
				apstm.setString(2, Serviceids);
				apstm.setString(3, type);
				apstm.setDouble(4, Double.parseDouble(paidamount));
				apstm.setString(5, DateUtil.FormateDateSQL(paiddate));
				apstm.setString(6, paymentdesc);
				apstm.setDouble(7, ((Double.parseDouble(balance))-(Double.parseDouble(paidamount))));
				apstm.setString(8, userId);
				apstm.setString(9,DateUtil.getCurrentDateTime() );
				apstm.setString(10, "Y");	
				apstm.execute();
			 	
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}	
		
			
			
	}
		
		
		@SuppressWarnings("unused")
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
				apstm=con.prepareStatement(sql);
				apstm.setDouble(1, paid);
				apstm.setString(2, DateUtil.FormateDateSQL(paiddate));
				apstm.setString(3, paymentdesc);
				apstm.setDouble(4, bal);
				apstm.setString(5, userId);
				apstm.setString(6,DateUtil.getCurrentDateTime() );
				apstm.setString(7, "Y");	
				apstm.setInt(8, Integer.parseInt(rowid));
				apstm.setString(9, Serviceids);
				apstm.execute();
			 	
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
		        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    	dispatchers.forward(request, response); 

			}	
		
	}
		@SuppressWarnings("unused")
		private void deleteServicePayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
		{
			try
			{
				String sql="";
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