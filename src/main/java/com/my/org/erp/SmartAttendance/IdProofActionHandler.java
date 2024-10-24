package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 
 
public class IdProofActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("ATTIdProofDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call  ATT_PRO_IDPROOF(?,?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, null);
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/IdProof.jsp");
			}
			else if ( "ATTIdProofAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				name=name.trim();
				String proofname = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CONCAT('P00',MAX(INT_ADDRESSPROOFID+1))   FROM com_m_addressproof ")[0][0];
				String previousproofname= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CONCAT('P00',MAX(INT_ADDRESSPROOFID ))   FROM com_m_addressproof ")[0][0];
				int row =Integer.parseInt( CommonFunctions.QueryExecute("select MAX(INT_ADDRESSPROOFID+1) FROM com_m_addressproof ")[0][0]);
				if(row<10)
				{
					CallableStatement cs = con.prepareCall("{call  ATT_PRO_IDPROOF(?,?,?,?,?,? )}");
					cs.setString(1, "INSERT");
					cs.setString(2, "1");
					cs.setString(3, name);
					cs.setString(4, proofname);
					cs.setString(5, previousproofname);
					cs.setString(6, user);
					cs.execute();
					cs.close();
					 
					com.my.org.erp.common.CommonFunctions.Execute( " ALTER TABLE com_m_staffaddressproof ADD COLUMN " + proofname+ " longblob COMMENT  '"+name+"' after   "+previousproofname );
				}
				con.close();   
				response.sendRedirect("Smart Attendance/IdProofAction.jsp?action1=Add");
			} 
			else if (action.equals("ATTIdProofEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				CallableStatement cs = con.prepareCall("{call  ATT_PRO_IDPROOF(?,?,?,?,?,? )}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, user);
				cs.execute();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/IdProof.jsp");
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
