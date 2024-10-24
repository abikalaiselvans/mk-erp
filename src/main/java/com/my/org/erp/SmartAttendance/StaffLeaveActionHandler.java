package com.my.org.erp.SmartAttendance;

import java.io.IOException;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DBConnection.DBCon;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.Attendance.Attinfo;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;


public class StaffLeaveActionHandler extends AbstractActionHandler {

	Statement st;
	ResultSet rs;
	String redirecterror="";
	String sql ="";
	boolean redirectflag = false;
	HttpSession session = null;
	String userId =null;
	boolean flags = false;
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();
	boolean lflag = false;
	
	public static boolean RecordExist(String staffid) {
		boolean flag = false;
		try {
			String staffId = staffid;
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			String sql = "SELECT * FROM ATT_M_LEAVE";
			sql = sql + " WHERE  CHR_EMPID = '" + staffId + "' AND INT_YEAR=year(now())";
			String dbId = "";
			rs = st.executeQuery(sql);
			if (rs.next())
				dbId = "" + rs.getString("CHR_EMPID").trim();
			if ((dbId.equalsIgnoreCase("null")) || (dbId.equalsIgnoreCase("")))
				flag = false;
			else
				flag = true;
			 
			return flag;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			//System.out.print(e);
		}
		return flag;
	}

	public void leaveRecordInsertion(String sql) {
		try {

			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			st.executeUpdate(sql);
			
		} catch (Exception e) {
			 System.out.println(e.getMessage());

		}
	}

	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			System.out.println("CONTROL FROM LEAVE ACTION HANDLER ::" + action);
			session = request.getSession();
			
			session.removeAttribute("attinfo"); 
			System.out.println("CONTROLLER FROM LEAVE ACTION HANDLER  : "+action);
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			String year = "" + (1900 + date.getYear());
			userId = (String) session.getAttribute("USRID");
			redirecterror="";
			 
			if (action.equals("ATTStaffLeaveAdd")) 
			{
				String staffid[] = request.getParameterValues("ename");
				
				for (int u = 0; u < staffid.length; u++) 
				{
					redirectflag =false;
					String leaveName[] = com.my.org.erp.bean.Attendance.StaffRegistration.leaveTypeValue().split("~");
					String leaveChr[] = com.my.org.erp.bean.Attendance.StaffRegistration.leaveTypeChar().split("~");
					String s = "";
					String reqVal = "";
					//System.out.println("1");
					for (int y = 0; y < leaveName.length; y++) 
					{
						reqVal = "" + request.getParameter(leaveName[y]).trim();
						if (reqVal.equals("") || reqVal.equals("null"))
							reqVal = "0";
						s = s + reqVal + "~";
					}

					String reqLeaveVal[] = s.split("~");
					
					String sql = "";
					sql = " DELETE FROM ATT_M_LEAVE WHERE ";
					sql = sql + "CHR_EMPID = '" + staffid[u] + "' AND INT_YEAR =";
					sql = sql + Integer.parseInt(year)  ;
					
					Statement ts = con.createStatement();
					ts.execute(sql);
					ts.close();
					
					boolean flag = RecordExist(staffid[u]);
					
					if (flag) 
					{
						redirecterror = redirecterror+staffid[u]+",";
						redirectflag =true;
					} 
					else 
					{
						String carryleaveposition[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_LEAVENAME,CHR_SYMBOL,CHR_CARRY FROM att_m_leavetype ");
						boolean staffflag =false;
						
						
						staffflag=com.my.org.erp.common.CommonInfo.RecordExist("SELECT CHR_EMPID FROM  com_m_staff  WHERE CHR_LEAVECARRY='Y' AND 	CHR_EMPID = '"+staffid[u]+"'");	
						sql = "INSERT INTO ATT_M_LEAVE  VALUES (";
						sql = sql + "'" + staffid[u] + "' , ";
						sql = sql + Integer.parseInt(year) + " , ";
						if(staffflag)
						{
							for (int x = 0; x < leaveChr.length; x++)
							{	
								double leave1=0.0;
								double leave2=0.0;
								double addleave=0.0;
								if("Y".equals(carryleaveposition[x][2]))
								{
									String c1 = "INT_NOD"+(x+1);
									String c2 = "INT_NOD"+(x+1)+"BALANCE";
									String sqls = "SELECT "+c1+" , "+c2 +" FROM  ATT_M_LEAVE WHERE CHR_EMPID ='"+staffid[u]+"' AND INT_YEAR = (year(now())-1)";
									sqls = "SELECT count(*) FROM  ATT_M_LEAVE WHERE CHR_EMPID ='"+staffid[u]+"' AND INT_YEAR = (year(now())-1)";
									
									if(com.my.org.erp.common.CommonInfo.RecordExist(sqls))
									{	
										String dbleave[][] = com.my.org.erp.common.CommonInfo.doubleRecordSetArray(sqls);
										leave1 = Double.parseDouble(dbleave[0][0]);
										leave2 = Double.parseDouble(dbleave[0][1]);
										addleave = leave1-leave2;
									}
									else
										addleave = 0.0;
								}
								sql = sql + " '" + leaveChr[x] + "' , "	+ (Double.parseDouble(reqLeaveVal[x])+addleave)+ ", 0.0 ,";
							}	
						}
						else
						{	
							for (int x = 0; x < leaveChr.length; x++)
								sql = sql + " '" + leaveChr[x] + "' , "	+ Double.parseDouble(reqLeaveVal[x])+ ", 0.0 ,";
						}
						int fl = leaveChr.length;
						@SuppressWarnings("unused")
						int al = 9 - fl;
						if ((fl + 1) < 10)
							for (int a = (fl + 1); a <= 9; a++)
								sql = sql + " ' ' , 0.0, 0.0,";
						
						sql = sql + "'Y' , '" + userId + "' , ";
						sql = sql + "'" + updatedate + "' , ";
						sql = sql + "'Y' ) ";
						st = con.createStatement();
						st.execute(sql);

					}
				}
				//System.out.println("____"+redirectflag);
				 
				if (redirectflag)
					response.sendRedirect("Smart Attendance/StaffLeaveAdd.jsp?er="+redirecterror);
				else
					response.sendRedirect("Smart Attendance/Leave MasterView.jsp");
				
				
			} 
			else if (action.equals("ATTStaffLeaveUpdate")) 
			{
				String staffid = request.getParameter("staffid");
				staffid.trim();
				String reqColumn[] = com.my.org.erp.bean.Attendance.StaffRegistration.leaveTypeValue().split("~");
				String sql = "UPDATE ATT_M_LEAVE SET ";
				for (int i = 0; i < reqColumn.length; i++) 
				{
					String field = "INT_NOD" + (i + 1) + "BALANCE";
					String field1 = "INT_NOD" + (i + 1) ;
					String val = "txt" + i;
					String vl = "tx" + i;
					String reqVal = "" + request.getParameter(val);
					String reqVl = "" + request.getParameter(vl);
					if (reqVal.equals("") || reqVal.equals("null"))
						reqVal = "0.0";
					if (reqVl.equals("") || reqVl.equals("null"))
						reqVl = "0.0";
					sql = sql + field + " = " + Double.parseDouble(reqVal)+ ",";
					sql = sql + field1 + " = " + Double.parseDouble(reqVl)+ ",";
				}
				sql = sql + " CHR_UPDATESTATUS ='Y' WHERE  CHR_EMPID = '"+ staffid + "'";
				st = con.createStatement();
				st.execute(sql);
				//System.out.println(sql);
				
				con.close();    
				response.sendRedirect("Smart Attendance/Leave MasterView.jsp");
			} 
			  
			else if (action.equals("ATTStaffLeaveAssign")) 
			{ 
				lflag = false;
				LeaveEntryAdd(request, response);
				con.close();   
				if(lflag)
					response.sendRedirect("Smart Attendance/LeaveExit.jsp");
				else
					response.sendRedirect("Smart Attendance/leaveMessage.jsp?message=kindly check the attendance");
 			}
			else if ("ATTStaffLeaveEdit".equals(action) ) 
			{
				String rowid = request.getParameter("rowid");
				String leavetype = request.getParameter("leavetype");
				String daytype= request.getParameter("ComboDay");
				sql =  " SELECT a.INT_LEAVEID,a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_LDATE,'%d-%m-%Y'),a.CHR_LEAVETYPE,";
				sql = sql + " c.CHR_LEAVENAME,a.CHR_DAYTYPE,MONTHNAME(a.DT_LDATE),YEAR(a.DT_LDATE),c.INT_LEAVEID,DAY(a.DT_LDATE) FROM  att_t_leave a,com_m_staff b ,att_m_leavetype c ";
				sql = sql + " where a.CHR_EMPID =b.CHR_EMPID AND a.CHR_LEAVETYPE=c.CHR_SYMBOL ";
				sql = sql + " AND a.INT_LEAVEID="+rowid;
				String readData[][] = CommonFunctions.QueryExecute(sql);
				if(readData.length>0)
				{
					double dayvalue=0.0;
					if("Full Day".equals(daytype))
						dayvalue=1.0;
					 else if("Forenoon".equals(daytype))
						 dayvalue=0.5;
					 else if("Afternoon".equals(daytype))
						 dayvalue=0.5; 
					
					int day= Integer.parseInt(readData[0][10]);
					try 
					{
						Statement st  =con.createStatement();
						sql ="UPDATE att_t_leave SET  CHR_LEAVETYPE=?,CHR_DAYTYPE=?, CHR_USRNAME=?, DT_UPDATEDATE=DATE(NOW()), CHR_UPDATESTATUS=?,DOU_VALUE=? WHERE INT_LEAVEID=? ";
						PreparedStatement ps=con.prepareStatement(sql);
						ps.setString(1,leavetype);
						ps.setString(2,daytype);
						ps.setString(3,userId);
						ps.setString(4,"N");
						ps.setString(5,""+dayvalue);
						ps.setString(6,rowid);
						ps.execute();
						ps.close();
						if(readData[0][4].equals(leavetype) )
						{
							if( (readData[0][6].equals("Full Day")) && ( daytype.equals("Forenoon")  || daytype.equals("Afternoon")) )
							{
								
								sql = "UPDATE  att_m_leave SET  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE-0.5) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								st.execute(sql);
								
								
								
							}
							
							else if( ( ( readData[0][6].equals("Forenoon")  || readData[0][6].equals("Afternoon") ) && daytype.equals("Full Day"))  )
							{
								
								sql = "UPDATE  att_m_leave SET  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE+0.5) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								st.execute(sql);
								 
							}
						}
						else
						{
							String leavid = CommonFunctions.QueryExecute("SELECT INT_LEAVEID FROM att_m_leavetype WHERE CHR_SYMBOL='"+leavetype+"'")[0][0];
							
							if(    readData[0][6].equals("Full Day")   &&    daytype.equals("Full Day")    )
							{
								sql = "UPDATE  att_m_leave SET  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE-1.0) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								 
								st.execute(sql);
								sql = "UPDATE  att_m_leave SET  INT_NOD"+leavid+"BALANCE =(INT_NOD"+leavid+"BALANCE+1.0) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								
								st.execute(sql); 
							}
							else if( (readData[0][6].equals("Full Day")) && ( daytype.equals("Forenoon")  || daytype.equals("Afternoon")) )
							{
								
								sql = "UPDATE  att_m_leave SET  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE-1.0) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								 
								st.execute(sql);
								
								sql = "UPDATE  att_m_leave SET  INT_NOD"+leavid+"BALANCE =(INT_NOD"+leavid+"BALANCE+0.5) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								
								st.execute(sql); 
							}
							
							else if( ( ( readData[0][6].equals("Forenoon")  || readData[0][6].equals("Afternoon") ) && daytype.equals("Full Day"))  )
							{
								
								sql = "UPDATE  att_m_leave SET  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE+0.5) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								 
								st.execute(sql); 
								sql = "UPDATE  att_m_leave SET  INT_NOD"+leavid+"BALANCE =(INT_NOD"+leavid+"BALANCE+1.0) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								 
								st.execute(sql); 
							}
							else if(   ( readData[0][6].equals("Forenoon")  || readData[0][6].equals("Afternoon") ) &&  ( daytype.equals("Forenoon")  || daytype.equals("Afternoon"))  )
							{
								
								sql = "UPDATE  att_m_leave SET  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE-0.5) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								 
								st.execute(sql);
								sql = "UPDATE  att_m_leave SET  INT_NOD"+leavid+"BALANCE =(INT_NOD"+leavid+"BALANCE+0.5) ";
								sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
								 
								st.execute(sql);
							}
							
							
						}
						
						
						 sql="UPDATE att_t_register SET ";
						 if("Full Day".equals(readData[0][6]))
						 {
							 sql = sql +"   CHR_MORNING"+day+" = null ,";
							 sql = sql +"  CHR_EVENING"+day+" = null,";
						 }
						 else if("Forenoon".equals(readData[0][6]))
							 sql = sql +"   CHR_MORNING"+day+" = null ,";
						 else if("Afternoon".equals(readData[0][6]))
							 sql = sql +"   CHR_EVENING"+day+" = null,";
						 sql = sql.trim();
						 sql = sql.substring(0,sql.length()-1);
						 sql = sql +"    WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+readData[0][8]+" AND CHR_MONTH='"+readData[0][7]+"'";
						 st.execute(sql);
						 
						 sql="UPDATE att_t_register SET  CHR_USRNAME='"+userId+"',DAT_MODIFIEDDATE=NOW(),";
						 if("Full Day".equals(daytype))
						 {
							 sql = sql +"   CHR_MORNING"+day+" = 'LEA' ,";
							 sql = sql +"  CHR_EVENING"+day+" = 'LEA',";
						 }
						 else if("Forenoon".equals(daytype))
							 sql = sql +"   CHR_MORNING"+day+" = 'LEA' ,";
						 else if("Afternoon".equals(daytype))
							 sql = sql +"   CHR_EVENING"+day+" = 'LEA'  ,";
						 sql = sql.trim();
						 sql = sql.substring(0,sql.length()-1);
						 sql = sql +"    WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+readData[0][8]+" AND CHR_MONTH='"+readData[0][7]+"'";
						 st.execute(sql);
						 st.close();
						 con.close();    
						response.sendRedirect("Smart Attendance/LeaveView.jsp");
					} 
					catch (RuntimeException e) 
					{
						CommonFunctions.ErrorWrite(""+ e.getMessage());
						response.sendRedirect("error/index.jsp?error=" + e.getMessage());
					}
					
				}
				

			}
			else if("ATTStaffMasterLeaveDelete".equals(action))
			{
				con.close();   
				response.sendRedirect("Smart Attendance/Leave MasterView.jsp");
				 
			}
			else if("ATTStaffLeaveDelete".equals(action))
			{
				 
				String rowid = request.getParameter("leaveid");
				sql =  " SELECT a.INT_LEAVEID,a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_LDATE,'%d-%m-%Y'),a.CHR_LEAVETYPE,";
				sql = sql + " c.CHR_LEAVENAME,a.CHR_DAYTYPE,MONTHNAME(a.DT_LDATE),YEAR(a.DT_LDATE),c.INT_LEAVEID,DAY(a.DT_LDATE) FROM  att_t_leave a,com_m_staff b ,att_m_leavetype c ";
				sql = sql + " where a.CHR_EMPID =b.CHR_EMPID AND a.CHR_LEAVETYPE=c.CHR_SYMBOL ";
				sql = sql + " AND a.INT_LEAVEID="+rowid;
				String readData[][] =  CommonFunctions.QueryExecute(sql);
				if(readData.length>0)
				{
					int day= Integer.parseInt(readData[0][10]);
					Statement st = con.createStatement();
					sql = " DELETE FROM att_t_leave WHERE INT_LEAVEID="+rowid;
					st.execute(sql);
					
					
					sql="UPDATE att_t_register SET CHR_USRNAME='"+userId+"',DAT_MODIFIEDDATE=NOW(),";
					 if("Full Day".equals(readData[0][6]))
					 {
						 sql = sql +"   CHR_MORNING"+day+" = null ,";
						 sql = sql +"  CHR_EVENING"+day+" = null,";
					 }
					 else if("Forenoon".equals(readData[0][6]))
						 sql = sql +"   CHR_MORNING"+day+" = null ,";
					 else if("Afternoon".equals(readData[0][6]))
						 sql = sql +"   CHR_EVENING"+day+" = null,";
					 sql = sql.trim();
					 sql = sql.substring(0,sql.length()-1);
					 sql = sql +"    WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+readData[0][8]+" AND CHR_MONTH='"+readData[0][7]+"'";
					 st.execute(sql);
					 
					 
					
					 
					 sql="UPDATE att_m_leave SET ";
					 if("Full Day".equals(readData[0][6]))
					 	 sql = sql +"  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE - 1.0) ,";
					 else 
						 sql = sql +"  INT_NOD"+readData[0][9]+"BALANCE =(INT_NOD"+readData[0][9]+"BALANCE - 0.5) ,";
					 sql = sql.trim();
					 sql = sql.substring(0,sql.length()-1);
					 sql = sql +"  WHERE CHR_EMPID='"+readData[0][1]+"' AND INT_YEAR="+ readData[0][8];
					 st.execute(sql);
					 st.close();
					 
					 asql = " UPDATE att_m_onlineapplyleave SET CHR_STATUS='R' , CHR_ADMINDESC='Entry deleted' ";
					 asql = asql +" WHERE CHR_EMPID=?  AND  DT_PDATE =? ";
					 apstm = con.prepareStatement(asql);
					 apstm.setString(1,readData[0][1] );
					 apstm.setString(2, DateUtil.FormateDateSQL(readData[0][3]));
					 System.out.println(""+apstm);
					 apstm.execute();
					 apstm.close();
					 
					 
					
						 
						
				}
				con.close();   
				response.sendRedirect("Smart Attendance/LeaveView.jsp");
				 
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
	
	
	
	
	


	private void LeaveEntryAdd(	HttpServletRequest request,	HttpServletResponse response)throws ServletException, IOException 
	{
			try 
			{
				userId = (String) session.getAttribute("USRID");
				st = con.createStatement();
				String staffid = request.getParameter("staffid");
				String leave = request.getParameter("leave");
				String leaveid = request.getParameter("leaveid");
				String Eligible = request.getParameter("Eligible");
				String Available = request.getParameter("Available");
				double maxleave=Double.parseDouble(Eligible);
				double takenleave=Double.parseDouble(Available);
				String fdate = request.getParameter("fromdate");
				String dat[] = fdate.split("-");
				String day = ""+Integer.parseInt(dat[0]);
				String umonth=DateUtil.getMonth(Integer.parseInt(dat[1]));
				String uyear = dat[2];
				String type = request.getParameter("ComboDay").trim();
				 double addValue = 0.0;
				 	
				if("Full Day".equals(type))
				 	addValue = 1;
				else  
				 	addValue = 0.5;
				 
				 
				takenleave =takenleave+addValue;
				boolean flag = true;
				if(takenleave>maxleave)
					flag = false;
				
				
				 asql = " SELECT COUNT(*) FROM att_t_leave WHERE CHR_EMPID='"+staffid+"' AND   DT_LDATE='"+DateUtil.FormateDateSQL(fdate)+"'";
				 asql = asql+"  AND CHR_EMPID='"+staffid+"' ";
				 if("Full Day".equals(type))
					 asql = asql+"  AND CHR_DAYTYPE = 'Full Day' ";
				 else if("Forenoon".equals(type))
					 asql = asql+"  AND CHR_DAYTYPE = 'Forenoon' ";
				 else if("Afternoon".equals(type))
					 asql = asql+"  AND CHR_DAYTYPE = 'Afternoon' ";
				
				  
				 
				if(flag && !CommonFunction.RecordExist(asql))
				{	
					
					 try 
					 {
						 
						 String sql = "";
						 String updatequery="UPDATE att_t_register SET ";
						 String  updatequery1= " ";;
						 if("Full Day".equals(type))
						 {
							updatequery=updatequery+" CHR_MORNING"+day+" = 'LEA' ,  CHR_EVENING"+day+" = 'LEA', ";
							updatequery1 = updatequery1 + " AND CHR_MORNING"+day+" NOT IN ('LEA','HOL','ABS') AND CHR_EVENING"+day+"  NOT IN ('LEA','HOL','ABS')";
							
							addValue = 1;
						 }
						 else if("Forenoon".equals(type))
						 {
							updatequery=updatequery+" CHR_MORNING"+day+" = 'LEA' , ";
							updatequery1 = updatequery1 + " AND CHR_MORNING"+day+" NOT IN ('LEA','HOL','ABS') ";
							addValue = 0.5;
						 }
						 else if("Afternoon".equals(type))
						 {
							updatequery=updatequery+" CHR_EVENING"+day+" = 'LEA' , ";
							updatequery1 = updatequery1 + "  CHR_EVENING"+day+"  NOT IN ('LEA','HOL','ABS')";
							addValue = 0.5;
						 }
						 
						 updatequery=updatequery.trim();
						 updatequery = updatequery.substring(0,updatequery.length()-1);
						 String ssql=updatequery+" WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? " +updatequery1;
						 apstm = con.prepareStatement(ssql);
						 apstm.setString(1, staffid);
						 apstm.setString(2, umonth);
						 apstm.setString(3, uyear);
						 System.out.println(""+apstm);
						
						 int i =  apstm.executeUpdate();
						 if(i>0)
							 lflag = true; 
						 System.out.println(""+lflag);
						 
						 if(lflag)
						 {
						  
							 sql = "INSERT INTO att_t_leave (CHR_EMPID,DT_LDATE,CHR_LEAVETYPE,CHR_DAYTYPE,DOU_VALUE,CHR_LEAVESTATUS,CHR_USRNAME , DT_UPDATEDATE , CHR_UPDATESTATUS)VALUES (";
							 sql = sql + "'" + staffid + "' ,";
							 sql = sql + "'" + DateUtil.FormateDateSQL(fdate) + "' ,";
							 sql = sql + "'" + leave + "' ,";
							 sql = sql + "'" + type + "' ,";
							 sql = sql + " " + addValue + "  ,";
							 sql = sql + "'N' ,";
							 sql = sql + "'" + userId + "' ,";
							 sql = sql + " DATE(NOW()) ,";
							 sql = sql + "'Y' )";
							 System.out.println(sql);
							 st.execute(sql);
										
							 sql = " UPDATE ATT_M_LEAVE SET ";
							 sql = sql + "INT_NOD" + (Integer.parseInt(leaveid))+ "BALANCE =" + takenleave;
							 sql = sql + " WHERE CHR_EMPID = '" + staffid + "'";
							 sql = sql + " AND INT_YEAR = " + Integer.parseInt(uyear);
							 st.execute(sql);
						 }
						 
						
					} 
					 catch (RuntimeException e) 
					{
						 con.close();  
						 response.sendRedirect("error/index.jsp?error=" + e.getMessage());
					}
				}
				else
				{ 
					con.close();
					request.setAttribute("error", "Already leave marked ");
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 
					 
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
