package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class TermandConditionActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			if("STKTermansConditionAdd".equals(action)) 
			{
				
				String termandconditionname= request.getParameter("termandconditionname");
				String description= request.getParameter("description");
				cs = con.prepareCall("{call  CON_INV_PRO_TERMANDCONDITION (?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,termandconditionname);
				cs.setString(4,description);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/TermandConditionview.jsp");
			}
			else if("STKTermansConditionEdit".equals(action))
			{
				String conditionid= request.getParameter("conditionid");
				String termandconditionname= request.getParameter("termandconditionname");
				String description= request.getParameter("description");
				cs = con.prepareCall("{call  CON_INV_PRO_TERMANDCONDITION (?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, conditionid);
				cs.setString(3, termandconditionname);
				cs.setString(4, description);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/TermandConditionview.jsp");
			}
			else if("STKTermansConditionDelete".equals(action))
			{
				String data[] =request.getParameterValues("Termid");
				 
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_TERMANDCONDITION (?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, userid);
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/TermandConditionview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
