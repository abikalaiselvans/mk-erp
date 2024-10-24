package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class ManualInputActionHandler extends AbstractActionHandler 
{
	String userid=null;
	boolean flag = false;
	 


@SuppressWarnings("rawtypes")
public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			userid=""+session.getAttribute("USRID");
			System.out.println("CONTROLLER FROM MANUAL INPUTS ENTRY ACTION HANDLER  : "+action);
			if ( "ATTManualInput".equals(action) ) 
			{
				try 
				{ 
					ManualInput m = new ManualInput();
					Map map=request.getParameterMap();
					BeanUtils.populate(m,map);
					String staffids[] = m.getEname();
					String mont = m.getMonth();
					int year = m.getYear();
					String month = DateUtil.getMonth(Integer.parseInt(mont));
					String basedata[][] = CommonFunctions.QueryExecutecon(con, "SELECT INT_PERLIMIT,INT_LATELIMIT, DOU_LOSSOFDAY1,DOU_LOSSOFDAY2  FROM att_m_basicsettings WHERE INT_ID=1");
					int latelimit=Integer.parseInt(basedata[0][1]);
					int perlimit=Integer.parseInt(basedata[0][0]);
					double lossofday1=Double.parseDouble(basedata[0][2]);
					double lossofday2=Double.parseDouble(basedata[0][3]);
					
					int late=0;
					int permission=0;
					double present=0.0;
					double absent=0.0;
					double leave=0.0;
					double sunday=0.0;
					double holiday=0.0;
					double onduty=0.0;
					double totaldays=0.0;
					double extradays=0.0;
					if(m.getAttendancecycle() == 1)
						asql ="UPDATE att_t_register SET ";
					else
						asql ="UPDATE att_t_register_cycle2 SET ";
					
					asql = asql + " DOU_PRESENT =?, DOU_ONDUTY =?,DOU_SUNDAY =?, DOU_HOLIDAY =?,  ";
					asql = asql + " DOU_LEAVE =?, DOU_ABSENT  =?,INT_LATE =?,INT_PERMISSION  =?,";
					asql = asql + " DOU_EXTRADAYS =?,DOU_TOTALDAYS =?,DAT_MODIFIEDDATE =NOW(),";   
					asql = asql + " DT_UPDATEDATE =DATE(NOW()),CHR_USRNAME =?,CHR_UPDATESTATUS =? ";
					asql = asql + " WHERE  CHR_EMPID=? AND  CHR_MONTH =? AND  INT_YEAR=?  ";
					apstm = con.prepareStatement(asql);
					for(int u=0; u<staffids.length;u++)
					{
						
						present=m.getPresent();
						sunday=m.getSunday();
						leave=m.getLeave();
						onduty=m.getOnduty();
						holiday=m.getHoliday();
						late=m.getLate();
						permission=m.getPermission();
						extradays=m.getExtradays();
						absent=0.0;
						
						String SData[][] =  CommonFunctions.QueryExecute("SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1");
						if("MTH".equals(SData[0][0]))
							totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5)+extradays;
						else if("CTC".equals(SData[0][0]))
							totaldays= present+sunday+leave+onduty+holiday+(late*0.5)+(permission*0.5)+extradays;
						else if("WRK".equals(SData[0][0]))
							totaldays= present+leave+onduty+holiday+(late*0.5)+(permission*0.5)+extradays;  
						
						if(late>=latelimit)
						{
							totaldays=totaldays-(((int)(late/latelimit))*lossofday1);
							absent = absent+(((int)(late/latelimit))*lossofday1);
						}
						
						if(permission>=perlimit)
						{
							totaldays=totaldays-(((int)(permission/perlimit))*lossofday2);
							absent = absent+(((int)(permission/perlimit))*lossofday2);
						}
						
						totaldays=totaldays+extradays;
						apstm.setString(1,""+present);
						apstm.setString(2,""+onduty);
						apstm.setString(3,""+sunday);
						apstm.setString(4,""+holiday);
						apstm.setString(5,""+leave);
						apstm.setString(6,""+absent);
						apstm.setString(7,""+late);
						apstm.setString(8,""+permission);
						apstm.setString(9,""+extradays);
						apstm.setString(10,""+totaldays);
						apstm.setString(11,userid);
						apstm.setString(12,"Y");
						apstm.setString(13,staffids[u]);
						apstm.setString(14,month);
						apstm.setString(15,""+year);
						System.out.println(""+apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					con.close();   
					response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
				} 
				catch (Exception e) 
				{
					con.close();  
					System.out.println(e.getMessage());
				}
 			}
 		} 
 		catch (Exception e) 
		{
 			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
 		}	
 		finally
		{
			  
		}
	}
}
