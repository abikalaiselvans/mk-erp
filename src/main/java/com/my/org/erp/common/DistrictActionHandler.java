package com.my.org.erp.common;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.District;
import com.my.org.erp.bean.State;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DistrictActionHandler extends AbstractActionHandler {
	String stateName, districtName;

	int stateId;

	int districtId;

	private void Statelist(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			ArrayList<State> stateList = new ArrayList<State>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM  com_m_state ORDER BY CHR_STATENAME");
			while (rs.next()) 
			{
				int stateId = Integer.parseInt(rs.getString(2));
				String stateName = rs.getString(3);
				State state = new State(stateId, stateName, "");
				stateList.add(state);
			}
			HttpSession session = request.getSession();
			session.setAttribute("disstateList", stateList);
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	
	
	
	private void DistrictLists(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			stateId = Integer.parseInt(request.getParameter("state"));
			ArrayList<District> districtList = new ArrayList<District>();
			Statement st = con.createStatement();
			String sql = "SELECT * FROM  com_m_district  WHERE INT_STATEId="+ stateId +" ORDER BY CHR_DISTRICT";
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) 
			{
				int districtId = rs.getInt(1);
				String districtName = rs.getString(2);
				String districtDes = rs.getString(3);
				District district = new District(districtId, districtName,districtDes, stateId);
				districtList.add(district);
			}
			rs.close();
			st.close();
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1	.executeQuery("SELECT CHR_STATENAME FROM  com_m_state  WHERE INT_STATEID="+ stateId);
			if (rs1.next()) 
			{
				stateName = rs1.getString(1);
			}
			HttpSession session = request.getSession();
			session.setAttribute("stateList", districtList);
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());

		}
	}
	
	
	
	private void DistrictList(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			stateId = Integer.parseInt(request.getParameter("stateId"));
			ArrayList<District> districtList = new ArrayList<District>();
			Statement st = con.createStatement();
			String sql = "SELECT * FROM  com_m_district  WHERE INT_STATEId="+stateId;
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) 
			{
				int districtId = rs.getInt(1);
				String districtName = rs.getString(2);
				String districtDes = rs.getString(3);
				District district = new District(districtId, districtName,districtDes, stateId);
				districtList.add(district);
			}
			rs.close();
			st.close();
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("SELECT CHR_STATENAME FROM  com_m_state  WHERE INT_STATEID="+ stateId);
			if (rs1.next()) 
			{
				stateName = rs1.getString(1);
			}
			HttpSession session = request.getSession();
			session.setAttribute("stateList", districtList);
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	
	private void DistrictDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DistrictId = request.getParameterValues("districtId");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DISTRICT(?,?,?,?,?,?)}");
			for (int i = 0; i < DistrictId.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, DistrictId[i]);
				cs.setString(3, "a");
				cs.setString(4, "a");
				cs.setString(5, "1");
				cs.setString(6, "a");
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

	
	
	private void DistrictAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			stateId = Integer.parseInt(request.getParameter("stateId"));
			stateName = request.getParameter("stateName");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String districtName = request.getParameter("TxtDistrictName");
			String districtDes = request.getParameter("TxtDistrictDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DISTRICT(?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, districtName);
			cs.setString(4, districtDes);
			cs.setInt(5, stateId);
			cs.setString(6, userId);
			if(districtName!=null)					
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void DistrictEdit(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			stateId = Integer.parseInt(request.getParameter("stateId"));
			String districtId = request.getParameter("districtId");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String districtName = request.getParameter("TxtDistrictName");
			String districtDes = request.getParameter("TxtDistrictDes");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DISTRICT(?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, districtId);
			cs.setString(3, districtName);
			cs.setString(4, districtDes);
			cs.setString(5, "" + stateId);
			cs.setString(6, userId);
			if(districtName!=null)
			cs.execute();
		} 
		catch (Exception e) 
		{
			request.setAttribute("loginmsg", e.getMessage().toString());
			RequestDispatcher dispatcher = application.getRequestDispatcher("/InValidSession.jsp");
			dispatcher.forward(request, response);
		}
	}

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String querypath = request.getParameter("path");
			if (action.equals("ATTdistrictDelete")) 
			{
				DistrictDelete(request, response);
				DistrictLists(request, response);
				querypath = request.getParameter("qp");
				 
				response.sendRedirect("Common/DistrictView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
			} 
			else if (action.equals("COMdistrictAdd")) 
			{
				DistrictAdd(request, response);
				DistrictList(request, response);
				 
				response.sendRedirect("Common/DistrictView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
			}
			else if (action.equals("ATTdistrictEdit")) 
			{
				DistrictEdit(request, response);
				DistrictList(request, response);
				 
				response.sendRedirect("Common/DistrictView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
			}
			else if (action.equals("COM_ATTstateList")) 
			{
				Statelist(request, response);
				 
				response.sendRedirect("Common/DistrictView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
			} 
			else if (action.equals("ATTdistrictList")) 
			{
				DistrictList(request, response);
				 
				response.sendRedirect("Smart Attendance/DistrictView.jsp?stateId="+stateId + "&stateName=" + stateName);
			} 
		} 
		catch (Exception e) 
		{
			
			 System.out.println(e.getMessage());
			request.setAttribute("loginmsg", e.getMessage().toString());
			RequestDispatcher dispatcher = application
					.getRequestDispatcher("/InValidSession.jsp");
			dispatcher.forward(request, response);
		}
	}
}
