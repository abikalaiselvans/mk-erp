package com.my.org.erp.SmartAMC;
import java.io.IOException;
 
import java.sql.PreparedStatement;
import java.sql.Statement;
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ServiceCallActionHandler extends AbstractActionHandler
{
	
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				Statement st = con.createStatement();
				@SuppressWarnings("unused")
				String emp = ""+session.getAttribute("EMPID");
				String branchid=""+session.getAttribute("AMCBRANCH");
				String sql="";
				
				if(action.equals("AMCServiceAdd"))
				{					
					String serial =request.getParameter("select");
					String customerid =request.getParameter("customerid");
					String startdate =request.getParameter("startdate");
					String description =request.getParameter("description");
					String bookingtype =request.getParameter("bookingtype");
					String complainttype =request.getParameter("complainttype");
					String cperson =request.getParameter("cperson");
					String cmobile =request.getParameter("cmobile");
					String caddress =request.getParameter("caddress");
					String cemail =request.getParameter("cemail");
					String stdate[] = startdate.split(" ");
					String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
					String amccallno= AMCFunctions.AMCCallBookingNumber()+"/CALL-ID/"+CommonFunctions.AccountYear();
					
					sql = " INSERT INTO inv_t_servicecallbooking	(INT_BRANCHID,CHR_SERVICECALLNO,INT_CUSTOMERID,CHR_SERIALNO,DT_BOOKINGDATE,CHR_SERVICEDESC,CHR_BOOKINGTYPE,CHR_BOOKINGUNDER,CHR_BOOKINGEMPID,CHR_CONTACTPERSON,CHR_CONTACTADDRESS,CHR_CONTACTMOBILE,CHR_CONTACTEMAIL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					sql = sql + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )";
					apstm = con.prepareStatement(sql);
					apstm.setString(1, branchid);
					apstm.setString(2, amccallno);
					apstm.setString(3,customerid);
					apstm.setString(4,serial);
					apstm.setString(5,sdate);
					apstm.setString(6,description.replaceAll("&", " and "));
					apstm.setString(7,bookingtype);
					apstm.setString(8,complainttype);
					apstm.setString(9,userid);
					apstm.setString(10,cperson.replaceAll("&", " and "));
					apstm.setString(11,caddress.replaceAll("&", " and "));
					apstm.setString(12,cmobile);
					apstm.setString(13,cemail);
					apstm.setString(14,userid);
					apstm.setString(15,DateUtil.getCurrentDate());
					apstm.setString(16,"Y");
					apstm.execute();
					apstm.close();
					
					
					sql=" INSERT INTO inv_m_serviceamccallbookingnumbergenerate VALUES ("+CommonFunctions.AMCCallBookingNumber()+")";
					st.execute(sql);
					st.close();
					 
					
					//Send a mail to service Center Head...
					AMCMailFunction.serviceCallBookingMail(amccallno);
					con.close();   
					response.sendRedirect("Smart AMC/ServiceCall.jsp?servicecall="+amccallno);
				}
				else if(action.equals("AMCServiceUpdate"))
				{
					String startdate =request.getParameter("startdate");
					String description =request.getParameter("description");
					String bookingtype =request.getParameter("bookingtype");
					String complainttype =request.getParameter("complainttype");
					String cperson =request.getParameter("cperson");
					String cmobile =request.getParameter("cmobile");
					String caddress =request.getParameter("caddress");
					String cemail =request.getParameter("cemail");
					String Bookingid =request.getParameter("Bookingid");
					String Cancel =request.getParameter("Cancel");
					
					String stdate[] = startdate.split(" ");
					String sdate = DateUtil.FormateDateSQL(stdate[0])+" "+stdate[1];
					sql = " UPDATE inv_t_servicecallbooking SET ";
					sql = sql +" DT_BOOKINGDATE='"+sdate+"',";
					sql = sql +" CHR_SERVICEDESC='"+description.replaceAll("&", " and ")+"',";
					sql = sql +" CHR_BOOKINGTYPE='"+bookingtype+"',";
					sql = sql +" CHR_BOOKINGUNDER='"+complainttype+"',";
					sql = sql +" CHR_BOOKINGEMPID='"+userid+"',";
					sql = sql +" CHR_CONTACTPERSON='"+cperson.replaceAll("&", " and ")+"',";
					sql = sql +" CHR_CONTACTADDRESS='"+caddress.replaceAll("&", " and ")+"',";
					sql = sql +" CHR_CONTACTMOBILE='"+cmobile+"',";
					sql = sql +" CHR_CONTACTEMAIL='"+cemail+"',";
					if("Y".equals(Cancel))
						sql = sql +" DT_CLOSINGDATE=now() , CHR_STATUS='R',";
					sql = sql.substring(0,sql.length()-1);
					sql = sql +" WHERE CHR_SERVICECALLNO='"+Bookingid+"'";
					st.execute(sql);
					st.close();
					con.close();   
					response.sendRedirect("Smart AMC/ServiceCall.jsp");	
				}
				else if(action.equals("AMCServiceDelete"))
				{
					String id[] =request.getParameterValues("Bookingid");
					asql ="DELETE FROM inv_t_servicecallbooking WHERE CHR_SERVICECALLNO=?";
					apstm = con.prepareStatement(asql);
					for (int i = 0; i < id.length; i++)
					{
						apstm.setString(1, id[i]);
						apstm.addBatch();
					}
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart AMC/ServiceCall.jsp");
				}
				else if(action.equals("AMCServiceCallBookingSendaMail"))
				{
					 
					String amccallno = request.getParameter("servicecall");
					AMCMailFunction.serviceCallBookingMail(amccallno);
					con.close();   
					response.sendRedirect("Smart AMC/ServiceCall.jsp");
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
	

	@SuppressWarnings("unused")
	private void addServiceCall(ServiceCall sc, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");		
			//String branchId=""+session.getAttribute("BRANCHID");
			String sql ="";
			sql="SELECT MAX(INT_SERVICEID) FROM inv_t_service ";
			int maxid=CommonFunction.intRecordCount(con, sql)+1;
			sql="INSERT INTO inv_t_service(INT_SERVICEID ,CHR_SERVICEID, "+
			"INT_CUSTOMERID,"+
			"CHR_CUSTOMERFLAG,CHR_SERVICEDESC,"+
			"DT_ARAISEDATE,CHR_SERVICEUNDER,"+
			"CHR_SERCALLSTATUS,"+
			"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "+
			"values(?,?,?,?,?,?,?,?,?,?,?)";			
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, maxid);
			ps.setString(2, sc.getCompalintid());
			ps.setInt(3, Integer.parseInt(sc.getCustomerid()));
			ps.setString(4, sc.getCustomertype());
			ps.setString(5, sc.getDescription());
			ps.setString(6, DateUtil.FormateDateSQL(sc.getStartdate()));
			ps.setString(7, sc.getComplainttype());
			ps.setString(8, sc.getBookingtype());
			ps.setString(9, userId);
			ps.setString(10,DateUtil.getCurrentDateTime() );
			ps.setString(11, "Y");	
			ps.execute();
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);			
		}
	}
	
	@SuppressWarnings("unused")
	private void updateServiceCall(ServiceCall sc, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			//String branchId=""+session.getAttribute("BRANCHID");
			String sql ="";
			String Serviceid = ""+request.getParameter("Serviceid");
			String status = ""+request.getParameter("Servicestatus");
			String attendate = ""+request.getParameter("attendate");
			String enddate = ""+request.getParameter("enddate");
			String Engineerhead = ""+request.getParameter("Engineerhead");
			String servicedesc = ""+request.getParameter("servicedesc");
			String Serviceamount = ""+request.getParameter("Serviceamount");
			String Staffid= ""+request.getParameter("Staffid");
			String bookingtype= ""+request.getParameter("bookingtype");
			String complainttype= ""+request.getParameter("complainttype");
			
			if(status.equals("on"))
				status="Y";
			if(status.equals("null"))
				status="N";
			
			sql = " UPDATE inv_t_service SET DT_ATTENDATE ='"+DateUtil.FormateDateSQL(attendate)+"' ,";
			sql = sql +" DT_COMPLETEDATE = '"+DateUtil.FormateDateSQL(enddate)+"' , ";
			sql = sql +" CHR_SERVICESTATUS = '"+status+"' , ";
			sql = sql +" CHR_AUTHORITY = '"+Engineerhead+"' , ";
			sql = sql +" CHR_EMPID ='"+Staffid+"' , ";
			sql = sql +" DOU_SERVICEAMOUNT = "+Serviceamount+" , ";
			sql = sql +" CHR_SERENGGDESC = '"+servicedesc+"'  ,";
			sql = sql +" CHR_SERVICEUNDER = '"+complainttype+"'  ,";
			sql = sql +" CHR_SERCALLSTATUS = '"+bookingtype+"' ";
			sql = sql +" WHERE  INT_SERVICEID= "+Integer.parseInt(Serviceid);
			PreparedStatement ps=con.prepareStatement(sql);
			ps.execute();
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);		
		}
	}
	
}

