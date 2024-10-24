package com.my.org.erp.common;

import java.io.IOException;
 
import java.sql.Statement;
 
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DispensaryActionHandler extends AbstractActionHandler {
	

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			 
			 
			//System.out.println(action);
			String sql="";
			if (action.equals("COMDispensaryAdd")) 
			{
				String dispname = request.getParameter("dispname");
				String address = request.getParameter("address");
				String pincode = ""+request.getParameter("pincode");
				String phone = ""+request.getParameter("phone");
				if("null".equals(pincode) || "".equals(pincode))
					pincode="0";
				if("null".equals(phone) ||"".equals(phone))
					phone="0";
				sql ="INSERT INTO com_m_dispensary  (CHR_DESPNAME, CHR_ADDRESS,  INT_PINCODE, INT_PHONE,  CHR_USRNAME , DT_UPDATEDATE,  CHR_UPDATESTATUS ) VALUES (";
				sql = sql+"'"+dispname+"' , ";
				sql = sql+"'"+address+"' , ";
				sql = sql+""+pincode+" , ";
				sql = sql+""+phone+" , ";
				sql = sql+""+phone+" , ";
				sql = sql+" now() ,'Y' ) ";
				Statement st = con.createStatement();
				st.execute(sql);
				 
				response.sendRedirect("Common/DispensaryView.jsp?path=ATT");
			}
			else if (action.equals("COMDispensaryDelete")) 
			{
				String ids[] = request.getParameterValues("placeid");
				for(int u=0;u<ids.length;u++)
				{
					sql = "DELETE FROM com_m_dispensary WHERE INT_DESPID="+ids[u];
					Statement st = con.createStatement();
					st.execute(sql);
					st.close();
				}
				 
				response.sendRedirect("Common/DispensaryView.jsp?path=ATT");
			} 
			else if (action.equals("COMDispensaryUpdate")) 
			{
				String dispname = request.getParameter("dispname");
				String address = request.getParameter("address");
				String pincode = ""+request.getParameter("pincode");
				String phone = ""+request.getParameter("phone");
				if("null".equals(pincode) || "".equals(pincode))
					pincode="0";
				if("null".equals(phone) ||"".equals(phone))
					phone="0";
				String dispensaryid = request.getParameter("dispensaryid");
				
				sql = " UPDATE com_m_dispensary SET CHR_DESPNAME ='"+dispname+"' , ";
				sql = sql+"	CHR_ADDRESS= '"+address+"',";
				sql = sql+"	INT_PINCODE= "+pincode+",";
				sql = sql+"	INT_PHONE= "+phone+"  WHERE INT_DESPID ="+dispensaryid;
				Statement st = con.createStatement();
				st.execute(sql);
				st.close();
				 
				response.sendRedirect("Common/DispensaryView.jsp?path=ATT");
			} 
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			
		}
	}
}
