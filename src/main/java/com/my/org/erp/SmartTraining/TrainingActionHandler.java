package com.my.org.erp.SmartTraining;

import java.io.IOException;
import java.sql.CallableStatement;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.SmartTraining.Training;
 
 
 
public class TrainingActionHandler extends AbstractActionHandler 
{
	
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("TRATrainingDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call  TRA_PRO_TRAINING(?,?,?,?,?,?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, null);
					cs.setString(5, null);
					cs.setString(6, null);
					cs.setString(7, null);
					cs.setString(8, null);
					cs.setString(9, null);
					cs.setString(10, null);
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				con.close();   
				response.sendRedirect("Smart Training/Training.jsp");
			}
			else if ( "TRATrainingAdd".equals(action) ) 
			{
				
				Training d = new Training();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				acs = con.prepareCall("{call  TRA_PRO_TRAINING(?,?,?,?,?,?,?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, " ");
				acs.setString(3,d.getEname());
				acs.setString(4,d.getType());
				acs.setString(5,d.getFromdate() );
				acs.setString(6,d.getTodate() );
				acs.setString(7,d.getConductedby() );
				acs.setString(8,d.getTest() );
				acs.setString(9,d.getDesc() );
				acs.setString(10,user );
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();   
				response.sendRedirect("Smart Training/Training.jsp");
			} 
			else if (action.equals("TRATrainingEdit")) 
			{
				Training d = new Training();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				acs = con.prepareCall("{call  TRA_PRO_TRAINING(?,?,?,?,?,?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2,""+d.getId());
				acs.setString(3,d.getEname());
				acs.setString(4,d.getType());
				acs.setString(5,d.getFromdate() );
				acs.setString(6,d.getTodate() );
				acs.setString(7,d.getConductedby() );
				acs.setString(8,d.getTest() );
				acs.setString(9,d.getDesc() );
				acs.setString(10,user );
				acs.execute();
				acs.close();
				con.close();   
				response.sendRedirect("Smart Training/Training.jsp");
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
