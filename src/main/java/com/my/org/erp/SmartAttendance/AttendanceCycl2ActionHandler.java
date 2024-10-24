package com.my.org.erp.SmartAttendance;

import java.io.IOException;
 
  
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class AttendanceCycl2ActionHandler extends AbstractActionHandler 
{
	Statement st;
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String cycledt[][] = CommonFunctions.QueryExecute("SELECT INT_FROM, INT_TO  FROM  att_m_basicsettings WHERE INT_ID=1 ");
			int cycle2_fromdt =Integer.parseInt(cycledt[0][0]); //20
			int cycle2_todt =Integer.parseInt(cycledt[0][1]);//19
			if("ATTAttendanceCalculateCycle2".equals(action))
			{
				String month =""+request.getParameter("month");
				String year = ""+request.getParameter("year");
				String Office = ""+request.getParameter("office");
				String dept = ""+request.getParameter("dept");
				String Category=request.getParameter("category");
				String fromdt = cycledt[0][0]+"-"+month+"-"+year; //20
				String fromdtsql = DateUtil.FormateDateSQL(fromdt);
				
				String todt = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_SUB(DATE_ADD('"+fromdtsql+"', INTERVAL 1 MONTH), INTERVAL 1 DAY),'%d-%m-%Y')")[0][0];
				String todtsql = DateUtil.FormateDateSQL(todt);
				int fromdtend = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+fromdtsql+"'))")[0][0]);
				String sql="";
				String hs="";
				String ssql="";
				String hhs="";
				asql = "DELETE b.*   FROM  com_m_staff a , att_t_register_cycle2 b "; 
	            asql = asql +"  WHERE a.CHR_EMPID = b.CHR_EMPID "; 
	            asql = asql +"  AND a.INT_ATTENDANCECYCLE = 2  ";
	            if(!"0".equals(Office))
	            	asql = asql +"  AND a.INT_OFFICEID = "+Office;
	            if(!"0".equals(dept))
	            	asql = asql +"  AND a.INT_DEPARTID =  "+dept;
	            if(!"0".equals(Category))
	            	asql = asql +"  AND a.CHR_CATEGORY =  "+Category;
	            asql = asql +"  AND b.CHR_MONTH = MONTHNAME('"+todtsql+"') "; 
	            asql = asql +"  AND b.INT_YEAR =YEAR('"+todtsql+"')  ";
	            apstm = con.prepareStatement(asql);
	            System.out.println(""+apstm);
	            
	            apstm.execute();
	            apstm.close();
	            
				 
				//Employee id inserted into att_t_registerCycle2 table
				acs = con.prepareCall("{call ATT_PRO_REGISTER_CREATION_CYCLE2(?,?,?,?,?,?)}");
				acs.setString(1,fromdtsql);
				acs.setString(2,todtsql);
				acs.setString(3,Office);
				acs.setString(4,dept);
				acs.setString(5,Category);
				acs.setString(6,userid);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				
				asql = " SELECT  a.CHR_EMPID FROM  com_m_staff a , att_t_register_cycle2 b "; 
	            asql = asql +"  WHERE a.CHR_EMPID = b.CHR_EMPID "; 
	            asql = asql +"  AND a.INT_ATTENDANCECYCLE = 2  ";
	            if(!"0".equals(Office))
	            	asql = asql +"  AND a.INT_OFFICEID = "+Office;
	            if(!"0".equals(dept))
	            	asql = asql +"  AND a.INT_DEPARTID =  "+dept;
	            if(!"0".equals(Category))
	            	asql = asql +"  AND a.CHR_CATEGORY =  "+Category;
	            asql = asql +"  AND b.CHR_MONTH = MONTHNAME('"+todtsql+"') "; 
	            asql = asql +"  AND b.INT_YEAR =YEAR('"+todtsql+"'); ";
				 
				System.out.println(asql); 
	            //"SELECT CHR_EMPID FROM att_t_register_cycle2 WHERE CHR_MONTH =MONTHNAME('"+todtsql+"')  AND INT_YEAR = YEAR('"+todtsql+"') "
				
				String data[][] =CommonFunctions.QueryExecute(asql); 
				if(data.length>0)
				{
					for(int y=0;y<data.length;y++)
					{
						ssql = "UPDATE att_t_register_cycle2 SET DT_UPDATEDATE =DATE(NOW()),";
						//update the 20th to 31st date attendance...
						hs="";
						for(int x=cycle2_fromdt;x<=fromdtend;x++) //20
							hs = hs+" CHR_MORNING"+x+","+" CHR_EVENING"+x+",";
						hs = hs.trim();
						hs = hs.substring(0,hs.length()-1);	
						sql = " SELECT  "+hs +" FROM att_t_register WHERE CHR_EMPID='"+data[y][0]+"' AND  CHR_MONTH =MONTHNAME('"+fromdtsql+"')  AND INT_YEAR = YEAR('"+fromdtsql+"') ";
						String fromdtdata[][] =CommonFunctions.QueryExecute(sql);
						hs="";
						if(fromdtdata.length>0)
						{
							int i=0;
							hs="";
							for(int x=cycle2_fromdt;x<=fromdtend;x++)//20 
							{
								hs = hs+" CHR_MORNING"+x+"='"+fromdtdata[0][i]+"',";
								i=i+1;
								hs = hs+"  CHR_EVENING"+x+"='"+fromdtdata[0][i]+"' ,";
								i=i+1;
							}
						}
						else
						{
							int i=0;
							hs="";
							for(int x=cycle2_fromdt;x<=fromdtend;x++) //20
							{
								hs = hs+" CHR_MORNING"+x+"='NA',";
								i=i+1;
								hs = hs+"  CHR_EVENING"+x+"='NA' ,";
								i=i+1;
							}
						}
						ssql = ssql+hs;

						
						//update the 1st to 19th date attendance...
						hs="";
						for(int x=1;x<=cycle2_todt;x++)//19 
							hs = hs+" CHR_MORNING"+x+","+" CHR_EVENING"+x+",";
						hs = hs.trim();
						hs = hs.substring(0,hs.length()-1);	
						sql = " SELECT  "+hs +" FROM att_t_register WHERE CHR_EMPID='"+data[y][0]+"' AND  CHR_MONTH =MONTHNAME('"+todtsql+"')  AND INT_YEAR = YEAR('"+todtsql+"') ";
						String todtdata[][] =CommonFunctions.QueryExecute(sql);
						hhs="";
						if(todtdata.length>0)
						{
							int i=0;
							hhs="";
							for(int x=1;x<=cycle2_todt;x++) //19
							{
								hhs = hhs+" CHR_MORNING"+x+"='"+todtdata[0][i]+"',";
								i=i+1;
								hhs = hhs+"  CHR_EVENING"+x+"='"+todtdata[0][i]+"' ,";
								i=i+1;
							}
							hhs = hhs.trim();
							//hhs = hhs.substring(0,hhs.length()-1);	
							
						}
						else
						{
							int i=0;
							hhs="";
							for(int x=1;x<=cycle2_todt;x++) //19
							{
								hhs = hhs+" CHR_MORNING"+x+"='NA',";
								i=i+1;
								hhs = hhs+"  CHR_EVENING"+x+"='NA' ,";
								i=i+1;
							}
							hhs = hhs.trim();
						}
						 
						ssql = ssql+hhs +" DT_UPDATEDATE =DATE(NOW())  WHERE CHR_EMPID='"+data[y][0]+"' AND CHR_MONTH=MONTHNAME('"+todtsql+"')  AND INT_YEAR=YEAR('"+todtsql+"')";
						System.out.println(ssql);
						
						apstm=con.prepareStatement(ssql);
						System.out.println("Cycle -2 : "+y+"/"+data.length+"   "+apstm);
						apstm.execute();
						apstm.close();
						
						
					}
				}
				con.close();   
				response.sendRedirect("Smart Attendance/MunsterrollCycle2Response.jsp?month="+month+"&year="+year+"&office="+Office+"&dept="+dept+"&category="+Category);
				
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