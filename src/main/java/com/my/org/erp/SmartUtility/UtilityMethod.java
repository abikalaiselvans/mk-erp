package com.my.org.erp.SmartUtility;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class UtilityMethod extends HttpServlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static void LoadStaffData(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
			String search=""+request.getParameter("search");
			String startletter=""+request.getParameter("startletter");
			String sql="";
			HttpSession session = request.getSession();   
            String userid = ""+session.getAttribute("USERID");
            String category=""+request.getParameter("category");
            
            
            
            sql =" SELECT UPPER(b.CHR_STAFFNAME), a.CHR_EMPID,a.CHR_USRNAME, a.CHR_TYPE , a.CHR_LIVE FROM m_user a , com_m_staff b ";
			sql = sql +" WHERE a.CHR_USRNAME not in('"+userid+"') "; 
			if(!"0".equals(category))
				sql = sql +"  AND a.CHR_TYPE ='"+category+"'";
			sql = sql +" AND b.CHR_EMPID = a.CHR_EMPID";
			sql = sql +" AND b.CHR_TYPE<>'T' ";
			sql = sql +" AND ( ( b.CHR_STAFFNAME LIKE '%"+search+"%' ) OR ( b.CHR_EMPID LIKE '%"+search.trim()+"%') )";
			sql = sql +" ORDER BY b.CHR_STAFFNAME ";
			
			System.out.println(sql);
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<Staff>");
                    sb.append("<Staffid>" + readData[u][1]+ "</Staffid>");
                    sb.append("<StaffName>" + readData[u][0]+ "</StaffName>");  
                    sb.append("<UserName>" + readData[u][2]+ "</UserName>");
                    sb.append("<Type>" + readData[u][3]+ "</Type>");
                    sb.append("<Live>" + readData[u][4]+ "</Live>");
                    sb.append("</Staff>");	              
	 			}
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<Staffs>" + sb.toString() + "</Staffs>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        	 
		}
		catch(Exception e){
			response.sendRedirect("Utility/error.jsp?error="+e.getMessage());	
			
		}
	}	
	
	}

