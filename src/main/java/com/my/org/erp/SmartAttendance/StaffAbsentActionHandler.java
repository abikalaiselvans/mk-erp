package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.Attendance.Attinfo;
import com.my.org.erp.common.CommonFunctions;

public class StaffAbsentActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	@SuppressWarnings("deprecation")
	String year = "" + (1900 + date.getYear());
	boolean redirectflag = false;
	String redirecterror="";
	String sql;
	boolean flag = false;
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();
	
	
	
	
  
public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

		try 
		{
			
			String action = request.getParameter("actionS");
			javax.servlet.http.HttpSession session=request.getSession();
			session.removeAttribute("attinfo"); 
			System.out.println("CONTROLLER FROM ABSENT ACTION HANDLER  : "+action);
			if ("ATTAbsentAdd".equals(action)  ) 
			{
				AbsentAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/Absent View.jsp");
			}
			else if ( "ATTAbsensUpdate".equals(action)  ) 
			{
				AbsentUpdate(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Absent View.jsp");
			}
			else if ( "ATTAbsensDelete".equals(action)   ) 
			{
				AbsentDelete(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Absent View.jsp");
			}
			else if("ATTContinuousAbsentDateWiseAdd".equals(action))//DATE WISE
			{
				ContinuousAbsentDateWiseAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/Absent View.jsp");
			}
			else if("ATTContinuousAbsentAdd".equals(action))//MONTHWISE
			{
				ATTContinuousAbsentAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/Absent View.jsp");
			}
			else if("ATTQuickAbsent".equals(action))
			{
				String empid[] = request.getParameter("empid").split(",");
				String type = request.getParameter("type");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String day = request.getParameter("day");
				String monthname = DateUtil.getMonth(Integer.parseInt(month));
				String sundays[] = CommonFunctions.QueryExecute(" SELECT FIND_A_SUNDAY("+month+","+year+")")[0][0].split(",");
				int noofdays= DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
				
				asql= " UPDATE att_t_register SET ";
				
				if("SUN".equals(type))
				{
					//Only sunday marking
					for(int i=0; i<sundays.length;i++)
						asql = asql +" CHR_MORNING"+sundays[i]+" ='SUN' , CHR_EVENING"+sundays[i]+"='SUN',  ";
				}
				else
				{	
					if("0".equals(day))
					{	
						for(int u=1; u<=noofdays;u++)
							asql = asql +" CHR_MORNING"+u+" ='"+type+"' , CHR_EVENING"+u+"='"+type+"', ";
						if("PRE".equals(type))
							for(int i=0; i<sundays.length;i++)
								asql = asql +" CHR_MORNING"+sundays[i]+" ='SUN' , CHR_EVENING"+sundays[i]+"='SUN',  ";
					}
					else
					{
						asql = asql +" CHR_MORNING"+day+" ='"+type+"' , CHR_EVENING"+day+"='"+type+"', ";
						
					}
				}	
				
				asql = asql +" DT_UPDATEDATE=DATE(NOW()),CHR_USRNAME='"+auserid+"',CHR_UPDATESTATUS='Y' ";
				asql = asql +" WHERE CHR_MONTH ='"+monthname+"' AND INT_YEAR="+year;
				asql = asql +" AND CHR_EMPID  IN (";
				for(int u=0;u<empid.length;u++)
					asql = asql +" '"+empid[u].trim().toUpperCase()+"',";
				asql = asql +"'0' )";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				con.close();   
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
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





private void AbsentAdd(	HttpServletRequest request,	HttpServletResponse response)throws ServletException, IOException 
{
		try 
		{
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String staffid[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String dat[] = fdate.split("-");
			String day = ""+Integer.parseInt(dat[0]);
			String umonth=DateUtil.getMonth(Integer.parseInt(dat[1]));
			String uyear = dat[2];
			fdate =DateUtil.FormateDateSQL(fdate);
			String daytype = request.getParameter("ComboDay");
			double dayvalue=0.0;
			
			String updatequery="UPDATE att_t_register SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(),";
			String registerquery="SELECT  CHR_MORNING"+day   +" , CHR_EVENING"+day+ "  FROM att_t_register  WHERE CHR_MONTH='"+umonth+"' AND INT_YEAR="+year;
			String  updatequery1= " SElECT COUNT(*)  FROM att_t_register  WHERE CHR_MONTH='"+umonth+"' AND INT_YEAR="+year;
			
			if("Full Day".equals(daytype))
			{	
				dayvalue=1.0;
				updatequery=updatequery+" CHR_MORNING"+day+" = 'ABS' ,   CHR_EVENING"+day+" = 'ABS', ";
				updatequery1 =updatequery1 + " AND CHR_MORNING"+day+" !='0'  AND CHR_EVENING"+day+" !='0'" ;
			}
			else if("Forenoon".equals(daytype))
			{
				dayvalue=0.5;
				updatequery=updatequery+" CHR_MORNING"+day+" = 'ABS' , ";
				updatequery1 =updatequery1 + " AND CHR_MORNING"+day+" !='0'  " ;
			}
			else if("Afternoon".equals(daytype))
			{
				dayvalue=0.5;
				updatequery=updatequery+" CHR_EVENING"+day+" = 'ABS' , ";
				updatequery1 =updatequery1 + "  AND CHR_EVENING"+day+" !='0'" ;
			}
			
			
			updatequery=updatequery.trim();
			updatequery = updatequery.substring(0,updatequery.length()-1);
			String ssql=updatequery+" WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=?";
			
			
			flag = false;
			//int daydiff = Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute( "select datediff(now(),'"+fdate+"')<45")[0][0]);
			
			
			PreparedStatement pstm = con.prepareStatement(ssql);
			CallableStatement cs = con.prepareCall("{call ATT_PRO_ABSENT( ?,?,?,?,?,?,?,? )}");
			
			for (int u = 0; u < staffid.length; u++) 
			{
				
				asql = " SELECT COUNT(*) FROM att_t_absent WHERE CHR_EMPID='"+staffid[u].trim()+"' AND   DT_ABSENTDATE='"+fdate+"'";
				updatequery1 = updatequery1+"  AND CHR_EMPID='"+staffid[u].trim()+"' ";
				registerquery=registerquery+"  AND CHR_EMPID='"+staffid[u].trim()+"' ";
				//String regData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(registerquery);
				
				//if((!com.my.org.erp.common.CommonFunction.RecordExist(asql)) && ( daydiff==1) && ( !com.my.org.erp.common.CommonFunction.RecordExist(updatequery1))  )
				{
					cs.setString(1, "INSERT");
					cs.setString(2,  null); 
					cs.setString(3,  staffid[u].trim()); 
					cs.setString(4, fdate ); 
					cs.setString(5, daytype ); 
					cs.setString(6,  daytype); 
					cs.setString(7, ""+dayvalue ); 
					cs.setString(8,  userid); 
					cs.addBatch();
					
	
					pstm.setString(1, staffid[u].trim());
					pstm.setString(2, umonth);
					pstm.setString(3, uyear);
					pstm.addBatch();
				}
				 
				
			}
			cs.executeBatch();
			pstm.executeBatch();
			pstm.close();
			cs.close();
			
			 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}







private void AbsentDelete(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
	try 
	{
		String rowid[] = request.getParameterValues("rowid");
		String updatequery="  ";
		acs = con.prepareCall("{call ATT_PRO_ABSENT( ?,?,?,?,?,?,?,? )}");
		String updatequery1="";
		boolean lflag = false;
		for(int u=0; u<rowid.length;u++)
		{
			 lflag = false;
			 sql ="SELECT CHR_EMPID,MONTHNAME(DT_ABSENTDATE),YEAR(DT_ABSENTDATE),CHR_DAYTYPE,DAY(DT_ABSENTDATE) FROM att_t_absent WHERE INT_ABSENTID="+rowid[u];
			 String readData[][] = CommonFunctions.QueryExecute(sql);
			
			 updatequery=" UPDATE att_t_register SET  ";
			 updatequery1 ="";
			 if("Full Day".equals(readData[0][3]))
			 {
			 	updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null ,  CHR_EVENING"+readData[0][4]+" = null, ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+"  IN ('ABS') AND CHR_EVENING"+readData[0][4]+"  IN ('ABS') ";
			 }	
			 else if("Forenoon".equals(readData[0][3]))
			 { 
				updatequery=updatequery+" CHR_MORNING"+readData[0][4]+" = null , ";
				updatequery1 = updatequery1 + " AND CHR_MORNING"+readData[0][4]+"  IN ('ABS')   ";
			 }	
			 else if("Afternoon".equals(readData[0][3]))
			 {	 
				updatequery=updatequery+" CHR_EVENING"+readData[0][4]+" = null , ";
				updatequery1 = updatequery1 + "   AND CHR_EVENING"+readData[0][4]+"  IN ('ABS') ";
			 }	
			 updatequery=updatequery.trim();
			 updatequery = updatequery.substring(0,updatequery.length()-1);
			 updatequery = updatequery+" WHERE CHR_EMPID=  ? AND CHR_MONTH=?  AND INT_YEAR=? "+updatequery1;
			 apstm = con.prepareStatement(updatequery);
			 apstm.setString(1,readData[0][0] );
			 apstm.setString(2,readData[0][1] );
			 apstm.setString(3,readData[0][2] );
			 int i =  apstm.executeUpdate();
			 if(i>0)
				 lflag = true; 
			 System.out.println(""+lflag +" / "+updatequery);
			 apstm.close();
			 
			 if(lflag)
			 {
				 acs.setString(1, "DELETE");
				 acs.setString(2, rowid[u]);
				 acs.setString(3, null);
				 acs.setString(4, null);
				 acs.setString(5, null);
				 acs.setString(6, null );
				 acs.setString(7, null);
				 acs.setString(8, null);
				 acs.addBatch();
			 }
			
		}
		acs.executeBatch();
		acs.close();
		 
	}
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 

	}	
}




private void AbsentUpdate (	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
	try 
	{
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("USRID");
		String rowid = request.getParameter("rowid");
		String fromdt = request.getParameter("fromdt");
		fromdt= DateUtil.FormateDateSQL(fromdt);
		String ComboDay = request.getParameter("ComboDay");
		double dayvalue=0.0;
		if("Full Day".equals(ComboDay))
			dayvalue=1.0;
		else
			dayvalue=0.5;
		
		sql = " SELECT a.INT_ABSENTID ,a.CHR_DAYTYPE, DATE_FORMAT(a.DT_ABSENTDATE,'%d-%m-%Y') ,MONTHNAME(a.DT_ABSENTDATE) ,YEAR( a.DT_ABSENTDATE),DAY( a.DT_ABSENTDATE),a.CHR_EMPID FROM att_t_absent a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_ABSENTID="+rowid;
		String readData[][] = CommonFunctions.QueryExecute(sql);
		
		String updatequery=" UPDATE att_t_register SET  ";
		if("Full Day".equals(readData[0][1]))
		 	updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = null ,  CHR_EVENING"+readData[0][5]+" = null, ";
		else if("Forenoon".equals(readData[0][1]))
			updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = null , ";
		else if("Afternoon".equals(readData[0][1]))
			updatequery=updatequery+" CHR_EVENING"+readData[0][5]+" = null , ";
		 updatequery=updatequery.trim();
		 updatequery = updatequery.substring(0,updatequery.length()-1);
		 updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][6]+"' AND CHR_MONTH='"+readData[0][3]+"' AND INT_YEAR="+readData[0][4];
		 st= con.createStatement();
		 st.executeUpdate(updatequery);
		 
		 
		 CallableStatement cs = con.prepareCall("{call ATT_PRO_ABSENT( ?,?,?,?,?,?,?,? )}");
		 cs.setString(1, "UPDATE");
		 cs.setString(2,  rowid); 
		 cs.setString(3,  readData[0][6]); 
		 cs.setString(4, fromdt ); 
		 cs.setString(5, ComboDay ); 
		 cs.setString(6,  ComboDay); 
		 cs.setString(7, ""+dayvalue ); 
		 cs.setString(8,  userid); 
		 cs.execute();
		 cs.close();
		 
		 updatequery=" UPDATE att_t_register SET  ";
		 if("Full Day".equals(ComboDay))
		 	updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = 'ABS'  ,  CHR_EVENING"+readData[0][5]+" = 'ABS' , ";
		 else if("Forenoon".equals(ComboDay))
			updatequery=updatequery+" CHR_MORNING"+readData[0][5]+" = 'ABS' , ";
		 else if("Afternoon".equals(ComboDay))
			updatequery=updatequery+" CHR_EVENING"+readData[0][5]+" = 'ABS' , ";
		 updatequery=updatequery.trim();
		 updatequery = updatequery.substring(0,updatequery.length()-1);
		 updatequery = updatequery+" WHERE CHR_EMPID='"+readData[0][6]+"' AND CHR_MONTH='"+readData[0][3]+"' AND INT_YEAR="+readData[0][4];
		 st.executeUpdate(updatequery);
		 st.close();
		
		 
       }
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 
	}
}




private void ContinuousAbsentDateWiseAdd(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
	try 
	{ 

		 
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("USRID");
		String staffids[] = request.getParameterValues("ename");
		String ComboDay = request.getParameter("ComboDay");
		String fromdt = request.getParameter("fromdt");
		String todt = request.getParameter("todt");
		String fdt[] =fromdt.split("-") ;
		String tdt[] = todt.split("-");
		int staringdate = Integer.parseInt(fdt[0]);
		int endingdate = Integer.parseInt(tdt[0]);
		String month = tdt[1];
		String monthname = DateUtil.getMonth(Integer.parseInt(month));
		String year = fdt[2];
		
		/*================================*/
		String updatequery="";
		String updatequery1="";
		acs = con.prepareCall("{call ATT_PRO_ABSENT( ?,?,?,?,?,?,?,? )}");
		for(int u=0; u<staffids.length;u++)
		{
			
			for(int day=staringdate;day<=endingdate;day++)
			{
				updatequery="";
				updatequery1="";
				updatequery=" UPDATE att_t_register SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(), ";
				if("Full Day".equals(ComboDay))
				{
					updatequery = updatequery+" CHR_MORNING"+day+" = 'ABS' , CHR_EVENING"+day+"='ABS' , ";
					updatequery1 = updatequery1 + " AND CHR_MORNING"+day+" NOT IN ('LEA','ABS') AND CHR_EVENING"+day+"  NOT IN ('LEA','ABS')";
				}	
				else if("Forenoon".equals(ComboDay))
				{
					updatequery = updatequery+" CHR_MORNING"+day+" = 'ABS'  , ";
					updatequery1 = updatequery1 + " AND CHR_MORNING"+day+" NOT IN ('LEA','ABS') ";
				}
				else
				{
					updatequery = updatequery+"  CHR_EVENING"+day+"='ABS' , ";
					updatequery1 = updatequery1 + "  AND CHR_EVENING"+day+"  NOT IN ('LEA','ABS')";
				}
				
				updatequery = updatequery+" CHR_UPDATESTATUS='Y' ,";
				updatequery=updatequery.trim();
				updatequery = updatequery.substring(0,updatequery.length()-1);
				updatequery = updatequery +"  WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? "+updatequery1;
				apstm = con.prepareStatement(updatequery);
				apstm.setString(1, staffids[u]);
				apstm.setString(2, monthname);
				apstm.setString(3, ""+year);
				System.out.println(""+apstm);
				int i =  apstm.executeUpdate();
				apstm.close();
				boolean  lflag = false;
				if(i>0)
					 lflag = true; 
				if(lflag)
				{
					acs.setString(1, "INSERT");
					acs.setString(2,  null); 
					acs.setString(3,  staffids[u].trim()); 
					if(day<10)
						acs.setString(4, ""+year+"-"+month+"-0"+day );
					else
						acs.setString(4, ""+year+"-"+month+"-0"+day );
					acs.setString(5, "Full Day" ); 
					acs.setString(6,  "Full Day"); 
					acs.setString(7, "1.0" ); 
					acs.setString(8,  userid); 
					System.out.println(""+acs);
					acs.addBatch();
				}
			
			}
		}
		acs.executeBatch();
		acs.close();
		/*================================*/
		
			
		/*
		acs = con.prepareCall("{call ATT_PRO_ABSENT( ?,?,?,?,?,?,?,? )}");
		for(int u=0; u<staffids.length;u++)
		{
				boolean f = false;
				String field =" UPDATE att_t_register SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(), ";
				for(int day=staringdate;day<=endingdate;day++)
				{
					 {
 						 {
							f = true;
							acs.setString(1, "INSERT");
							acs.setString(2,  null); 
							acs.setString(3,  staffids[u].trim()); 
							if(day<10)
								acs.setString(4, ""+year+"-"+month+"-0"+day );
							else
								acs.setString(4, ""+year+"-"+month+"-0"+day );
							acs.setString(5, "Full Day" ); 
							acs.setString(6,  "Full Day"); 
							acs.setString(7, "1.0" ); 
							acs.setString(8,  userid); 
							System.out.println(""+acs);
							acs.addBatch();
							
							if("Full Day".equals(ComboDay))
								field = field+" CHR_MORNING"+day+" = 'ABS' , CHR_EVENING"+day+"='ABS' , ";
							else if("Forenoon".equals(ComboDay))
								field = field+" CHR_MORNING"+day+" = 'ABS'  , ";
							else  
								field = field+"  CHR_EVENING"+day+"='ABS' , ";
							
						}
 					}
				}
			
				field = field+" CHR_UPDATESTATUS='Y' ,";
				field=field.trim();
				field = field.substring(0,field.length()-1);
				field = field +"  WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? ";
				if(f)
				{
					PreparedStatement pstm = con.prepareStatement(field);
					pstm.setString(1, staffids[u]);
					pstm.setString(2, monthname);
					pstm.setString(3, ""+year);
					System.out.println(""+pstm);
					pstm.execute();
					pstm.close();
					
					 
				}
			
			
		}
		acs.executeBatch();
		 
		 
		*/
		 
	}
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 
	}
}





private void ATTContinuousAbsentAdd(	HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
	try 
	{ 
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("USRID"); 
		String staffids[] = request.getParameterValues("ename");
		String mont = request.getParameter("month");
		String year = request.getParameter("year");
		String month = DateUtil.getMonth(Integer.parseInt(mont));
		int totaldays = Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+mont+"-01'))")[0][0]);
		String salaryprocess = CommonFunctions.QueryExecute("SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1")[0][0];
		
		acs = con.prepareCall("{call ATT_PRO_ABSENT( ?,?,?,?,?,?,?,? )}");
		for(int u=0; u<staffids.length;u++)
		{
			String field ="";
			field =" UPDATE att_t_register a SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(),";
			boolean f = false;
			for(int day=1;day<=totaldays;day++)
			{	
				
				if("WRK".equals(salaryprocess))
				{
					if(!"Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+mont+"-"+day+"') ")[0][0]))
					{
						 	f = true;
							acs.setString(1, "INSERT");
							acs.setString(2,  null); 
							acs.setString(3,  staffids[u].trim()); 
							if(day<10)
								acs.setString(4, ""+year+"-"+mont+"-0"+day );
							else
								acs.setString(4, ""+year+"-"+mont+"-0"+day );
							acs.setString(5, "Full Day" ); 
							acs.setString(6,  "Full Day"); 
							acs.setString(7, "1.0" ); 
							acs.setString(8,  userid); 
							acs.addBatch();
							field = field+" CHR_MORNING"+day+" = 'ABS' , CHR_EVENING"+day+"='ABS' , ";
					}
				}
				else if("CTC".equals(salaryprocess) || "MTH".equals(salaryprocess))
				{	 
						 	f = true;
							acs.setString(1, "INSERT");
							acs.setString(2,  null); 
							acs.setString(3,  staffids[u].trim()); 
							if(day<10)
								acs.setString(4, ""+year+"-"+mont+"-0"+day );
							else
								acs.setString(4, ""+year+"-"+mont+"-0"+day );
							acs.setString(5, "Full Day" ); 
							acs.setString(6,  "Full Day"); 
							acs.setString(7, "1.0" ); 
							acs.setString(8,  userid); 
							acs.addBatch();
							field = field+" CHR_MORNING"+day+" = 'ABS' , CHR_EVENING"+day+"='ABS' , ";
					
				}
				
				
				
					
			}
			field = field+" CHR_UPDATESTATUS='Y' ,";
			field=field.trim();
			field = field.substring(0,field.length()-1);
			field = field +" WHERE a.CHR_EMPID=? AND a.CHR_MONTH=? AND a.INT_YEAR=?";
			if(f)
			{
				PreparedStatement pstm = con.prepareStatement(field);
				pstm.setString(1, staffids[u]);
				pstm.setString(2, month);
				pstm.setString(3, ""+year);	
				pstm.execute();
				pstm.close();
			}
		}
		 
		 
		
		acs.executeBatch();
		 
	 	
		 
		
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
