package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class DivisionActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			if("STKDivisionAdd".equals(action)) 
			{
				String divisionname= request.getParameter("divisionname");
				String shortname= request.getParameter("shortname");
				cs = con.prepareCall("{call  CON_INV_PRO_DIVISION (?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,divisionname);
				cs.setString(4,shortname);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Divisionview.jsp");
			}
			else if("STKDivisionEdit".equals(action))
			{
				String divisionname= request.getParameter("divisionname");
				String shortname= request.getParameter("shortname");
				String divisionid= request.getParameter("divisionid");
				cs = con.prepareCall("{call  CON_INV_PRO_DIVISION (?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, divisionid);
				cs.setString(3,divisionname);
				cs.setString(4,shortname);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Divisionview.jsp");
			}
			else if("STKDivisionDelete".equals(action))
			{
				String data[] =request.getParameterValues("Divisionid");
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_DIVISION (?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, "1");
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
					response.sendRedirect("SmartStock/Divisionview.jsp");
				}
				catch(Exception e)
				{
					
				}
			}
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
