package com.my.org.erp.common;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.State;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class StateActionHandler extends AbstractActionHandler 
{
	String courseName;
	int courseId;

	private void StateList(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			ArrayList<State> stateList = new ArrayList<State>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM  com_m_state  ORDER BY CHR_STATENAME");
			while (rs.next()) 
			{
				int stateId = Integer.parseInt(rs.getString(2));
				String stateName = rs.getString(3);
				String desp = rs.getString(4);
				State state = new State(stateId, stateName, desp);
				stateList.add(state);
			}
			HttpSession session = request.getSession();
			session.setAttribute("stateList", stateList);
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	private void StateDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] StateId = request.getParameterValues("OptStateName");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_STATE(?,?,?,?,?)}");
			for (int i = 0; i < StateId.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, StateId[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.addBatch();
			}
			cs.executeBatch();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void StateAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String stateName = request.getParameter("TxtStateName").trim();
			String stateDes = request.getParameter("TxtStateDes").trim();
			CallableStatement cs = con.prepareCall("{call  COM_PRO_STATE(?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, stateName.trim());
			cs.setString(4, stateDes.trim());
			cs.setString(5, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	

	private void StateEdit(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String stateId = request.getParameter("stateId");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String stateName = request.getParameter("TxtStateName").trim();
			String stateDes = request.getParameter("TxtStateDes").trim();
			CallableStatement cs = con
					.prepareCall("{call  COM_PRO_STATE(?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, stateId);
			cs.setString(3, stateName.trim());
			cs.setString(4, stateDes.trim());
			cs.setString(5, userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			
			String action = request.getParameter("actionS");
			String querypath = request.getParameter("path");
			if (action.equals("COM_ATTstateList")) 
			{
			
				 
				StateList(request, response);			
				response.sendRedirect("Common/StateView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
			} 
			else if (action.equals("ATTstateDelete")) 
			{
				String actType = request.getParameter("Submit");
				if (actType.equalsIgnoreCase("Delete")) {
					StateDelete(request, response);
					StateList(request, response);
					response.sendRedirect("Common/StateView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				} 
				
			} 
			else if (action.equals("COMstateAdd")) 
			{
				StateAdd(request, response);
				StateList(request, response);
				 
				response.sendRedirect("Common/StateView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
			} else if (action.equals("ATTstateEdit")) {
				StateEdit(request, response);
				StateList(request, response);
				 
				response.sendRedirect("Common/StateView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}