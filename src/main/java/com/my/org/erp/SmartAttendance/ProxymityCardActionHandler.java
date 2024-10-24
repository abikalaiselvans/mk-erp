package com.my.org.erp.SmartAttendance;

import java.io.IOException;
 import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
 
public class ProxymityCardActionHandler extends AbstractActionHandler 
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		
		try 
		{
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String action = request.getParameter("actionS");
			 
			if (action.equals("ATTProxymityCardADD")) 
			{
				String ename= request.getParameter("ename");
				String cardno= request.getParameter("cardno");
				
				asql= "SELECT COUNT(*) FROM att_m_proximitycardno WHERE INT_PROXYID>=0 AND ( CHR_EMPID='"+ename+"' OR CHR_CARDNO='"+cardno+"') AND CHR_RETURN='N'";
				System.out.println(asql);
				if(!CommonFunction.RecordExist(asql))
				{	
					acs = con.prepareCall("{call ATT_PRO_PROXYMITYCARDISSUE (?,?,?,?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "1");
					acs.setString(3,ename);
					acs.setString(4,cardno.trim());
					acs.setString(5,userid);
					acs.execute();
					acs.close();
					con.close();   
					response.sendRedirect("Smart Attendance/ProximityView.jsp");
				}
				else
				{
					asql= "SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID)  FROM att_m_proximitycardno WHERE INT_PROXYID>=0 AND ( CHR_EMPID='"+ename+"' OR CHR_CARDNO='"+cardno+"') AND CHR_RETURN='N'";
					String data[][]= CommonFunctions.QueryExecute(asql);
					con.close();   
					response.sendRedirect("Smart Attendance/Proxymitycardissue.jsp?msg=Already issued to "+data[0][0]);
				}
				
			}
			else if (action.equals("ATTProxymityCardUpdate")) 
			{
				String ename= request.getParameter("ename");
				String cardno= request.getParameter("cardno");
				String rowid= request.getParameter("rowid");
				acs = con.prepareCall("{call ATT_PRO_PROXYMITYCARDISSUE (?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, rowid);
				acs.setString(3,ename);
				acs.setString(4,cardno.trim());
				acs.setString(5,userid);
				acs.execute();
				acs.close();
				con.close();   
				response.sendRedirect("Smart Attendance/ProximityView.jsp");
			}
			else if (action.equals("ATTProxymityCardReturn")) 
			{
				String Empid= request.getParameter("Empid");
				asql = " UPDATE att_m_proximitycardno SET CHR_CARDNUMBER= CHR_CARDNO , CHR_CARDNO=null, CHR_RETURN =? WHERE CHR_EMPID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y");
				apstm.setString(2, Empid);
				apstm.execute();
				apstm.close();
				con.close();   
				response.sendRedirect("Smart Attendance/ProximityView.jsp");
			}
			
			
			else if (action.equals("ATTProxymityCardDelete")) 
			{
				String data[] =request.getParameterValues("staffid");
				acs = con.prepareCall("{call ATT_PRO_PROXYMITYCARDISSUE (?,?,?,?,?)}");
				for(int y=0;y<data.length;y++)
				{
					acs.setString(1, "DELETE");
					acs.setString(2,"0");
					acs.setString(3,data[y]);
					acs.setString(4, "1");
					acs.setString(5, "1");
					acs.addBatch();				
				}
				acs.executeBatch();
				con.close();   
				response.sendRedirect("Smart Attendance/ProximityView.jsp");
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
