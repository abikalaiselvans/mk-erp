package com.my.org.erp.SmartCommon;

import java.io.IOException;

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
			if (action.equals("GENIdProofDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  ATT_PRO_IDPROOF(?,?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, null);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/IdProof.jsp");
			}
			else if ( "GENIdProofAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				name=name.trim();
				String proofname =  CommonFunctions.QueryExecute("SELECT CONCAT('P00',MAX(INT_ADDRESSPROOFID+1))   FROM com_m_addressproof ")[0][0];
				String previousproofname=  CommonFunctions.QueryExecute("SELECT CONCAT('P00',MAX(INT_ADDRESSPROOFID ))   FROM com_m_addressproof ")[0][0];
				int row =Integer.parseInt( CommonFunctions.QueryExecute("select MAX(INT_ADDRESSPROOFID+1) FROM com_m_addressproof ")[0][0]);
				if(row<10)
				{
					acs = con.prepareCall("{call  ATT_PRO_IDPROOF(?,?,?,?,?,? )}");
					acs.setString(1, "INSERT");
					acs.setString(2, "1");
					acs.setString(3, name);
					acs.setString(4, proofname);
					acs.setString(5, previousproofname);
					acs.setString(6, user);
					acs.execute();
					acs.close();
					CommonFunctions.Execute( " ALTER TABLE com_m_staffaddressproof ADD COLUMN " + proofname+ " longblob COMMENT  '"+name+"' after   "+previousproofname );
					con.close();   
					response.sendRedirect("Smart Common/IdProof.jsp ");
				}
				else
				{
					con.close();   
					response.sendRedirect("Smart Common/IdProofAction.jsp?action1=Add&er=Maximum limit exceeds ");//
				}
			} 
			else if (action.equals("GENIdProofEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				acs = con.prepareCall("{call  ATT_PRO_IDPROOF(?,?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, user);
				acs.execute();
				acs.close();
				con.close();   
				response.sendRedirect("Smart Common/IdProof.jsp");
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
