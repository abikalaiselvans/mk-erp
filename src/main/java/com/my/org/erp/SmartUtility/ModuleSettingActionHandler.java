package com.my.org.erp.SmartUtility;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.PreparedStatement;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class ModuleSettingActionHandler extends AbstractActionHandler {
	 
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			 
			String sql="";
			if (action.equals("UTIModuleSetting")) 
			{	
				
				 
				sql="SELECT INT_ID,CHR_SHORTNAME,CHR_MODULE,CHR_MODULETITLE,CHR_PACKAGE FROM   m_projectmodule  WHERE CHR_STATUS='Y' ORDER BY CHR_MODULE";
				String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				sql =  "UPDATE  m_projectmodule SET CHR_MODULETITLE =?  WHERE INT_ID=?";
				PreparedStatement pstm = con.prepareStatement(sql);
				if(data.length>0)
					for(int u=0;u<data.length;u++)
					{
						pstm.setString(1, request.getParameter("title"+(u+1)));
						pstm.setString(2, data[u][0]);
						pstm.addBatch();	
					}
				pstm.executeBatch();
				con.close();    
				response.sendRedirect("Utility/ModuleSetting.jsp");
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
