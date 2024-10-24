package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Properties;
 

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ServiceCallActionHandler extends AbstractActionHandler
{
	
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				Statement st = con.createStatement();
				@SuppressWarnings("unused")
				String emp = ""+session.getAttribute("EMPID");
				String branchid=""+session.getAttribute("BRANCHID");
				PreparedStatement pstm ;
				String sql=""; 
				if(action.equals("INVServiceAdd"))
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
					String amccallno= CommonFunctions.AMCCallBookingNumber()+"/CALL-ID/"+CommonFunctions.AccountYear();
					sql ="INSERT INTO inv_t_servicecallbooking	(INT_BRANCHID,CHR_SERVICECALLNO,INT_CUSTOMERID,CHR_SERIALNO,DT_BOOKINGDATE,CHR_SERVICEDESC,CHR_BOOKINGTYPE,CHR_BOOKINGUNDER,CHR_BOOKINGEMPID,CHR_CONTACTPERSON,CHR_CONTACTADDRESS,CHR_CONTACTMOBILE,CHR_CONTACTEMAIL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					sql = sql + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )";
					pstm = con.prepareStatement(sql);
					pstm.setString(1, branchid);
					pstm.setString(2, amccallno);
					pstm.setString(3,customerid);
					pstm.setString(4,serial);
					pstm.setString(5,sdate);
					pstm.setString(6,description.replaceAll("&", " and "));
					pstm.setString(7,bookingtype);
					pstm.setString(8,complainttype);
					pstm.setString(9,userid);
					pstm.setString(10,cperson.replaceAll("&", " and "));
					pstm.setString(11,caddress.replaceAll("&", " and "));
					pstm.setString(12,cmobile);
					pstm.setString(13,cemail);
					pstm.setString(14,userid);
					pstm.setString(15,DateUtil.getCurrentDate());
					pstm.setString(16,"Y");
					pstm.execute();
					pstm.close();
					
					
					sql=" INSERT INTO inv_m_serviceamccallbookingnumbergenerate VALUES ("+CommonFunctions.AMCCallBookingNumber()+")";
					st.execute(sql);
					
					st.close();
					 
					
					
					
					//Send a mail to service Center Head...

					sql = " SELECT a.CHR_SERVICECALLNO, b.CHR_CUSTOMERNAME,e.CHR_SERVICEITEMNAME,a.CHR_SERIALNO,  ";
					sql = sql +" a.CHR_BOOKINGEMPID,f.CHR_STAFFNAME,a.CHR_CONTACTPERSON,  ";
					sql = sql +" a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,a.CHR_SERVICEDESC,c.CHR_CENTERNAME,c.CHR_MAIL   ";
					sql = sql +" FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,inv_m_servicecenter c ,inv_m_serviceamc d,inv_m_serviceitems e,com_m_staff f   ";
					sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID = c.INT_SERVICECENTERID  ";
					sql = sql +" AND a.CHR_SERIALNO = d.CHR_SERIALNO  ";
					sql = sql +" AND d.INT_SERVICEITEMID = e.INT_SERVICEITEMID   ";
					sql = sql +" AND a.CHR_BOOKINGEMPID = f.CHR_EMPID  ";
					sql = sql +" AND a.CHR_SERVICECALLNO ='"+amccallno+"'  ";
					 
					
					String mailData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					if(mailData.length>0)
						if(!"-".equals(mailData[0][12]))
						{
							try 
							{
								String mailcontent="";
								mailcontent=mailcontent+" <style type=\"text/css\"> ";
								mailcontent=mailcontent+" <!-- ";
								mailcontent=mailcontent+" .style8 {COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
								mailcontent=mailcontent+" .style11 {COLOR: #000000; font-weight: normal; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
								mailcontent=mailcontent+" .boldEleven {	FONT-WEIGHT: normal;FONT-SIZE: 10px;	COLOR: #000000;	LINE-HEIGHT: 15px;	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif;	TEXT-DECORATION: none;}";  
								mailcontent=mailcontent+" .style15 {COLOR: #000000; font-weight: bold; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px; } ";
								mailcontent=mailcontent+" --> ";
								mailcontent=mailcontent+" </style> ";
								mailcontent=mailcontent+" <table width='600'  class='boldEleven'      cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";  
								mailcontent=mailcontent+" <tr  bgcolor='#FFFFFF'>	 ";
								mailcontent=mailcontent+" <td>	 ";

								
								mailcontent=mailcontent+" <table width='600' border='1' align='center' cellpadding='3' cellspacing='2' class='boldEleven'  bgcolor='#FFFFFF'>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td width='132' class='boldEleven'>Call Number </td>	 ";
								mailcontent=mailcontent+"  <td width='150' class='boldEleven'><h2>" + mailData[0][0] + "</h2> </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Customer Name </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][1] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Service Item </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][2] + " </td>	 ";
								mailcontent=mailcontent+"  </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+"  <td class='boldEleven'>Serial Number </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][3] + " </td>	 ";
								mailcontent=mailcontent+"  </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Employee id / Name </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][4]+" / "+ mailData[0][5]+ " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Contact Person </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][6] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+"  <td class='boldEleven'>Contact Address </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][7] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Contact Mobile </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][8] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Contact Email </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][9] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Problem Description </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][10] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" <tr>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>Service Center </td>	 ";
								mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][11] + " </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";

								mailcontent=mailcontent+" </table>	 ";
								
								mailcontent=mailcontent+" </td>	 ";
								mailcontent=mailcontent+" </tr>	 ";
								mailcontent=mailcontent+" </table>	 ";	 
								 
								
								Properties props = new Properties();
								props.setProperty("mail.transport.protocol", "smtp");
								props.setProperty("mail.host", "192.168.0.5");
								props.setProperty("mail.user", "connect");
								props.setProperty("mail.password", "connect");

								
								
								
								Session mailSession = Session.getDefaultInstance(props, null);
								mailSession.setDebug(true);
								Transport transport = mailSession.getTransport();
								MimeMessage message = new MimeMessage(mailSession);
								message.setSubject("SERVICE CALL  ::"+ mailData[0][0] );
								message.setFrom(new InternetAddress(""+CommonData.mailid));
								message.setContent(mailcontent, "text/html");
								message.addRecipient(Message.RecipientType.TO, new InternetAddress(""+mailData[0][12]+""));
								
								 System.out.println(mailData[0][12]);
								 System.out.println(mailcontent);
								
								 
								transport.connect();
								transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
								transport.close();
							} 
							catch (RuntimeException e) 
							{
								 System.out.println(e.getMessage());
							}
							
						}
					
					con.close();   
					response.sendRedirect("Smart Inventory/ServiceCall.jsp?servicecall="+amccallno);
				}
				else if(action.equals("INVServiceUpdate"))
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
					{
						sql = sql +" DT_CLOSINGDATE=now() , CHR_STATUS='R',";
					}
					sql = sql.substring(0,sql.length()-1);
					sql = sql +" WHERE CHR_SERVICECALLNO='"+Bookingid+"'";
					
					st.execute(sql);
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/ServiceCall.jsp");	
				}
				else if(action.equals("INVServiceDelete"))
				{
					String id[] =request.getParameterValues("Bookingid");
					for (int i = 0; i < id.length; i++)
					{
						sql = " DELETE FROM inv_t_servicecallbooking WHERE CHR_SERVICECALLNO='"+id[i]+"'";
						st.execute(sql);
					}
					st.close();
					con.close();   
					response.sendRedirect("Smart Inventory/servicecall.jsp");
				}
				else if(action.equals("INVServiceCallBookingSendaMail"))
				{
					String amccallno = request.getParameter("servicecall");
					sql = " SELECT a.CHR_SERVICECALLNO, b.CHR_CUSTOMERNAME,e.CHR_SERVICEITEMNAME,a.CHR_SERIALNO,  ";
					sql = sql +" a.CHR_BOOKINGEMPID,f.CHR_STAFFNAME,a.CHR_CONTACTPERSON,  ";
					sql = sql +" a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,a.CHR_SERVICEDESC,c.CHR_CENTERNAME,c.CHR_MAIL   ";
					sql = sql +" FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,inv_m_servicecenter c ,inv_m_serviceamc d,inv_m_serviceitems e,com_m_staff f   ";
					sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID = c.INT_SERVICECENTERID  ";
					sql = sql +" AND a.CHR_SERIALNO = d.CHR_SERIALNO  ";
					sql = sql +" AND d.INT_SERVICEITEMID = e.INT_SERVICEITEMID   ";
					sql = sql +" AND a.CHR_BOOKINGEMPID = f.CHR_EMPID  ";
					sql = sql +" AND a.CHR_SERVICECALLNO ='"+amccallno+"'  ";
					 
					
					String mailData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					if(mailData.length>0)
						if(!"-".equals(mailData[0][12]))
						{
							String mailcontent="";
							mailcontent=mailcontent+" <style type=\"text/css\"> ";
							mailcontent=mailcontent+" <!-- ";
							mailcontent=mailcontent+" .style8 {COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
							mailcontent=mailcontent+" .style11 {COLOR: #000000; font-weight: normal; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
							mailcontent=mailcontent+" .boldEleven {	FONT-WEIGHT: normal;FONT-SIZE: 10px;	COLOR: #000000;	LINE-HEIGHT: 15px;	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif;	TEXT-DECORATION: none;}";  
							mailcontent=mailcontent+" .style15 {COLOR: #000000; font-weight: bold; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px; } ";
							mailcontent=mailcontent+" --> ";
							mailcontent=mailcontent+" </style> ";
							mailcontent=mailcontent+" <table width='600'  class='boldEleven'      cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";  
							mailcontent=mailcontent+" <tr  bgcolor='#FFFFFF'>	 ";
							mailcontent=mailcontent+" <td>	 ";
		
							
							mailcontent=mailcontent+" <table width='600' border='1' align='center' cellpadding='3' cellspacing='2' class='boldEleven'  bgcolor='#FFFFFF'>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td width='132' class='boldEleven'>Call Number </td>	 ";
							mailcontent=mailcontent+"  <td width='150' class='boldEleven'><h2>" + mailData[0][0] + "</h2> </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Customer Name </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][1] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Service Item </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][2] + " </td>	 ";
							mailcontent=mailcontent+"  </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+"  <td class='boldEleven'>Serial Number </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][3] + " </td>	 ";
							mailcontent=mailcontent+"  </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Employee id / Name </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][4]+" / "+ mailData[0][5]+ " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Contact Person </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][6] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+"  <td class='boldEleven'>Contact Address </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][7] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Contact Mobile </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][8] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Contact Email </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][9] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Problem Description </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][10] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" <tr>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>Service Center </td>	 ";
							mailcontent=mailcontent+" <td class='boldEleven'>" + mailData[0][11] + " </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";

							mailcontent=mailcontent+" </table>	 ";
							
							mailcontent=mailcontent+" </td>	 ";
							mailcontent=mailcontent+" </tr>	 ";
							mailcontent=mailcontent+" </table>	 ";	 
							 
							
							Properties props = new Properties();
						    props.setProperty("mail.transport.protocol", "smtp");
						    props.setProperty("mail.host", "192.168.0.5");
						    props.setProperty("mail.user", "connect");
						    props.setProperty("mail.password", "connect");
		
						    
						    
						    
						    Session mailSession = Session.getDefaultInstance(props, null);
						    mailSession.setDebug(true);
						    Transport transport = mailSession.getTransport();
						    MimeMessage message = new MimeMessage(mailSession);
						    message.setSubject("SERVICE CALL  ::"+ mailData[0][0] );
						    message.setFrom(new InternetAddress(""+CommonData.mailid));
						    message.setContent(mailcontent, "text/html");
						    message.addRecipient(Message.RecipientType.TO, new InternetAddress(""+mailData[0][12]+""));
						    transport.connect();
						    transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
						    transport.close();
							
						}
					con.close();   
					response.sendRedirect("Smart Inventory/ServiceCall.jsp");
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
		catch (Exception e) 
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
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
}

