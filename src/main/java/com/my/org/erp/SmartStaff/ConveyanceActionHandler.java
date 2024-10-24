package com.my.org.erp.SmartStaff;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ConveyanceActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String empid = "" + session.getAttribute("EMPID");
			String userid = "" + session.getAttribute("USRID");
			String sql="";
			String cdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DOU_PETROL FROM m_institution  WHERE INT_ID=1");
			double price = Double.parseDouble(cdata[0][0]);
			if(action.equals("STAStaffConveyanceAdd"))
			{

				String param[] = request.getParameter("param").split(",");
				@SuppressWarnings("unused")
				String s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10;
				String opendate =request.getParameter("opendate");
				sql = "SELECT count(*) FROM conveyance_t_conveyance WHERE CHR_EMPID='"+empid+"' AND DAT_CONDATE='"+DateUtil.FormateDateSQL(opendate)+"'";
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				int rcount = Integer.parseInt(data[0][0]);
				boolean fl = false;
				if(rcount>0)
					fl = true;
				opendate = DateUtil.FormateDateSQL(opendate);
				String division =request.getParameter("division");
				String repto =request.getParameter("repto");
				@SuppressWarnings("unused")
				String f =request.getParameter("claimdatecheck");
				double t0=0;
				@SuppressWarnings("unused")
				double t1=0;
				@SuppressWarnings("unused")
				double t2=0;
				double t3=0;
				double t4=0;
				double t5=0;
				double t6=0;
				double t7=0;
				@SuppressWarnings("unused")
				double t8=0;
				if(!fl)
				{	
					acs = con.prepareCall("{call CONVEYANCE_PRO_CONVEYANCE(?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,? ,?,?,?)}");
					for(int i=0;i<param.length;i++)
					{
						t3=0;t4=0;t5=0;t6=0;t7=0;t0=0; 
						s0 = request.getParameter("from"+param[i]);
						s1 = request.getParameter("to"+param[i]);
						s2 = request.getParameter("km"+param[i]);
						s3 = request.getParameter("busfare"+param[i]);
						s4 = request.getParameter( "autofare"+param[i]);
						s5 = request.getParameter("lunch"+param[i]);
						s6 = request.getParameter("telephone"+param[i]);
						s7 = request.getParameter("otherdesc"+param[i]);
						s8 = request.getParameter("otheramt"+param[i]);
						s9 = request.getParameter("total"+param[i]);
						s10 = request.getParameter("callid"+param[i]);
						t3=Double.parseDouble(s3);
						t4=Double.parseDouble(s4);
						t5=Double.parseDouble(s5);
						t6=Double.parseDouble(s6);
						t7=Double.parseDouble(s8);
						t0 = t3+t4+t5+t6+t7+(Double.parseDouble(s2)*price);
						acs.setString(1, "INSERT");		
						acs.setString(2, "");
						acs.setString(3, empid);
						acs.setString(4, opendate);
						acs.setString(5, repto);
						acs.setString(6, division);
						acs.setString(7, s0);
						acs.setString(8, s1);
						acs.setString(9, s2);
						acs.setString(10, ""+(Double.parseDouble(s2)*price));
						acs.setString(11,s3 );		
						acs.setString(12, s4);
						acs.setString(13, s5);
						acs.setString(14, s6);
						acs.setString(15, s7);
						acs.setString(16, s8);
						acs.setString(17, ""+t0);
						acs.setString(18, s10);
						acs.setString(19, userid);
						// System.out.println(""+acs);
						acs.addBatch();
						 
				 }
				 acs.executeBatch();
				 acs.close();
				 con.close();   
				 response.sendRedirect("Staff/ConveyanceAdd.jsp");
				}
				else
				{
					response.sendRedirect("Staff/ConveyanceAdd.jsp?er=Already claim added this date "+request.getParameter("opendate"));
				}
			
			}
			else if (action.equals("STAConveyanceStaffDelete")) 
			{
				@SuppressWarnings("unused")
				String rowid = request.getParameter("id");
				String opendate = request.getParameter("opendate");
				String rows[]= request.getParameterValues("row");
				acs = con.prepareCall("{call CONVEYANCE_PRO_CONVEYANCE(?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,? ,?,?,?)}");
				for(int u=0;u<rows.length;u++)
				{
					acs.setString(1, "DELETE");		
					acs.setString(2, rows[u]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.setString(8, "");
					acs.setString(9, "");
					acs.setString(10, "");
					acs.setString(11,"" );		
					acs.setString(12, "");
					acs.setString(13, "");
					acs.setString(14, "");
					acs.setString(15, "");
					acs.setString(16, "");
					acs.setString(17, "");
					acs.setString(18, "");
					acs.setString(19, "");
					acs.addBatch();
				}
				acs.executeBatch();
			    acs.close();
			    con.close();   
				response.sendRedirect("Staff/ConveyanceModify.jsp?opendate="+opendate);	
			}
			else if (action.equals("STAConveyanceStaffEdit")) 
			{
				try {
					 
					String rowid = request.getParameter("id").trim();
					String from = request.getParameter("from").trim();
					String to = request.getParameter("to").trim();
					String kms = request.getParameter("km").trim();
					double km = Double.parseDouble(kms);
					@SuppressWarnings("unused")
					String kmamount = request.getParameter("kmamount").trim();
					String train = request.getParameter("train").trim();
					String auto = request.getParameter("auto").trim();
					String lunch = request.getParameter("lunch").trim();
					String telephone = request.getParameter("telephone").trim();
					String otherdesc = request.getParameter("otherdesc").trim();
					String otheramt = request.getParameter("otheramt").trim();
					String total = request.getParameter("total").trim();
					String callid =request.getParameter("callid").trim();
					String reentry =request.getParameter("reentry").trim();
					sql = "UPDATE conveyance_t_conveyance  SET   DAT_MODIFIED_TIME =NOW() , ";
					sql = sql +" CHR_FROM ='"+from+"' , ";
					sql = sql +" CHR_TO ='"+to+"' , ";
					sql = sql +" DOU_KM ="+km+" , ";
					sql = sql +" DOU_TRAVEL ="+(km*price)+" , ";//kmamount
					sql = sql +" DOU_TRAIN ="+Double.parseDouble(train)+" , ";
					sql = sql +" DOU_AUTO ="+Double.parseDouble(auto)+" , ";
					sql = sql +" DOU_LUNCH ="+Double.parseDouble(lunch)+" , ";
					sql = sql +" DOU_TELEPHONE ="+Double.parseDouble(telephone)+" , ";
					sql = sql +" CHR_OTHERDESC ='"+otherdesc+"' , ";
					sql = sql +" DOU_OTHERAMT ="+Double.parseDouble(otheramt)+" , ";
					sql = sql +" DOU_TOTAL ="+Double.parseDouble(total)+" , ";
					sql = sql +" CHR_USRNAME ='"+userid+"' , ";
					sql = sql +" CHR_CALLID ='"+callid+"' , CHR_STATUS='N', CHR_ACCEPT='N' ,";
					 
					if("R".equals(reentry))
						sql = sql +" CHR_REENTRY='Y' ,";
					sql = sql +" DT_UPDATEDATE =now() ,CHR_UPDATESTATUS ='Y' ";
					sql = sql +" WHERE INT_CONID="+rowid;
					Statement ts = con.createStatement();
					ts.execute(sql);
					ts.close();
					con.close();    
					response.sendRedirect("Staff/Userframe.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 

				}
			
			}
			else if (action.equals("STAConveyanceStaffAccept")) 
			{
				
				String length  = request.getParameter("dec");
				String accept="";
				String reject="";
				String rejectdec="";
				String hiddenField="";
				for(int u=0;u<Integer.parseInt(length);u++)
				{
					sql="";
					accept = ""+request.getParameter("accept"+u);
					reject = ""+request.getParameter("reject"+u);
					rejectdec = request.getParameter("dec"+u);
					hiddenField=request.getParameter("hiddenField"+u);
					if( ("on".equals(accept))  ||   ("on".equals(reject)))
					{
						sql="UPDATE conveyance_t_conveyance  SET   CHR_STATUS =? , CHR_ACCEPT =? ,CHR_DESC =? WHERE INT_CONID=? ";
						apstm = con.prepareStatement(sql);
						if("on".equals(accept))
						{
							apstm.setString(1, "Y");
							apstm.setString(2, "Y");
							apstm.setString(3, null);
							apstm.setString(4, hiddenField);
						}
						if("on".equals(reject))
						{
							apstm.setString(1, "R");
							apstm.setString(2, "R");
							apstm.setString(3, rejectdec);
							apstm.setString(4, hiddenField);
						}
						apstm.execute();
						apstm.close(); 
					}
				}
				con.close();    
				response.sendRedirect("Staff/StaffConveyanceview.jsp");
				 
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
