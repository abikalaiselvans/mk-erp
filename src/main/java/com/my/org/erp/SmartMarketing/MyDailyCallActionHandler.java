package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.SmartMarketing.MyDailyCall;

public class MyDailyCallActionHandler extends AbstractActionHandler {

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Plan: parse action, populate bean, use try-with-resources for PreparedStatement,
		// preserve SQL and parameter order, and ensure connection closed in finally.
		String redirect = "Smart Marketing/MyDailyCall_View.jsp";
		try {
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user = (String) session.getAttribute("USRID");
			String empid = String.valueOf(session.getAttribute("EMPID"));

			if (action == null) {
				request.setAttribute("error", "No action specified");
				request.getRequestDispatcher("/error/index.jsp").forward(request, response);
				return;
			}

			if ("MKTMyDailyCallAdd".equals(action)) {
				MyDailyCall d = new MyDailyCall();
				@SuppressWarnings("unchecked")
				Map<String, String[]> map = request.getParameterMap();
				BeanUtils.populate(d, map);

				String field = " ( INT_CUSTOMERNAMEID, CHR_LOCATION, CHR_CONTACTPERSON, CHR_DESIGNATION, INT_CONTACTNUMBER,  ";
				field = field + "  CHR_TYPEOFCALL,  DT_ENTRY, CHR_DESCRIPTION,  DT_FOLLOWUP, CHR_USRNAME , DT_UPDATEDATE, CHR_UPDATESTATUS ,CHR_EMPID,CHR_TRACKING_ID  )";
				String sql = " INSERT INTO mkt_t_mydailycall " + field
						+ " VALUES (?,?,?,?,?,?,?,?,?,? , now(), 'Y' ,?,  DATE_FORMAT(NOW(6), '%Y%m%d%H%i%s') )";

				try (PreparedStatement ps = con.prepareStatement(sql)) {
					ps.setString(1, d.getCname());
					ps.setString(2, d.getLocation());
					ps.setString(3, d.getContactperson());
					ps.setString(4, d.getDesignation());
					ps.setString(5, d.getContactnumber());
					ps.setString(6, d.getTypeofcall());
					ps.setString(7, DateUtil.FormateDateSQL(d.getEntrydate()));
					ps.setString(8, d.getDescription());
					ps.setString(9, DateUtil.FormateDateSQL(d.getNextfollowdate()));
					ps.setString(10, user);
					ps.setString(11, empid);
					System.out.println(ps);
					ps.execute();
				}

			} else if ("MKTMyDailyCallEdit".equals(action)) {
				String id = request.getParameter("id");
				MyDailyCall d = new MyDailyCall();
				@SuppressWarnings("unchecked")
				Map<String, String[]> map = request.getParameterMap();
				BeanUtils.populate(d, map);

				String ssql = "UPDATE mkt_t_mydailycall SET INT_CUSTOMERNAMEID=?, CHR_LOCATION=?, CHR_CONTACTPERSON=?, "
						+ "CHR_DESIGNATION=?, INT_CONTACTNUMBER=?,  ";
				ssql = ssql + "CHR_TYPEOFCALL=?,  DT_ENTRY=?, CHR_DESCRIPTION=?,  DT_FOLLOWUP=?, CHR_USRNAME=? , "
						+ "DT_UPDATEDATE=now(), CHR_UPDATESTATUS='Y'   WHERE INT_CALLID=?";

				try (PreparedStatement ps = con.prepareStatement(ssql)) {
					ps.setString(1, d.getCname());
					ps.setString(2, d.getLocation());
					ps.setString(3, d.getContactperson());
					ps.setString(4, d.getDesignation());
					ps.setString(5, d.getContactnumber());
					ps.setString(6, d.getTypeofcall());
					ps.setString(7, DateUtil.FormateDateSQL(d.getEntrydate()));
					ps.setString(8, d.getDescription());
					ps.setString(9, DateUtil.FormateDateSQL(d.getNextfollowdate()));
					ps.setString(10, user);
					ps.setString(11, d.getRowid());
					System.out.println(ps);
					ps.execute();
				}

			} else if ("MKTMyDailyCallDelete".equals(action)) {
				String[] rowids = request.getParameterValues("rowid");
				if (rowids != null && rowids.length > 0) {
					String sql = " DELETE from  mkt_t_mydailycall WHERE INT_CALLID=?";
					try (PreparedStatement apstm = con.prepareStatement(sql)) {
						for (String rid : rowids) {
							apstm.setString(1, rid);
							System.out.println(apstm);
							apstm.addBatch();
						}
						apstm.executeBatch();
					}
				}
			}
			else if ("MKTMyDailyCallClose".equals(action)) {
				//String[] rowids = request.getParameterValues("rowid");
				//if (rowids != null && rowids.length > 0) {
				String rowid = request.getParameter("rowid");
					String sql = " UPDATE mkt_t_mydailycall SET CHR_STATUS='CLOSED', CHR_USRNAME=? , DT_UPDATEDATE=now(), "
							+ "CHR_UPDATESTATUS='Y'  WHERE INT_CALLID=?";
					try (PreparedStatement apstm = con.prepareStatement(sql)) {
				 		apstm.setString(1, user);
						apstm.setString(2, rowid);
						System.out.println(apstm);
						apstm.execute();
					}
				 
			}
			else if("MKTMyDailyCallFollowUp".equals(action)) {
				
				// one is closed and another is opened
				String rowid = request.getParameter("rowid");
				String followupdate = request.getParameter("followupdate");
				 
				String ssql = "UPDATE mkt_t_mydailycall SET  ";
				ssql = ssql + "CHR_STATUS=?, CHR_USRNAME=? , DT_UPDATEDATE=now(), CHR_UPDATESTATUS='Y'   WHERE INT_CALLID=?";
				System.out.println(ssql);
				boolean flag = false;
				try (PreparedStatement ps = con.prepareStatement(ssql)) {
					ps.setString(1, "CLOSED");
					ps.setString(2, user);
					ps.setString(3,rowid);
					System.out.println(ps);
					ps.execute();
					flag = true;
				}
				
				if(flag) {
					  
					String sql = " INSERT INTO mkt_t_mydailycall  ( CHR_CLIENT_NAME, CHR_LOCATION, CHR_CONTACTPERSON, CHR_DESIGNATION, INT_CONTACTNUMBER, ";
					sql = sql + "  CHR_TYPEOFCALL,  DT_ENTRY, CHR_DESCRIPTION,  DT_FOLLOWUP, CHR_TRACKING_ID,  CHR_USRNAME  ,CHR_EMPID,  ";
					sql = sql + "  DT_UPDATEDATE, CHR_UPDATESTATUS  )";
					sql = sql + "  SELECT CHR_CLIENT_NAME, CHR_LOCATION, CHR_CONTACTPERSON, CHR_DESIGNATION, INT_CONTACTNUMBER, "; 
					sql = sql + "  CHR_TYPEOFCALL,  NOW(), CHR_DESCRIPTION,  DT_FOLLOWUP, CHR_TRACKING_ID,  CHR_USRNAME ,CHR_EMPID ,NOW(), 'Y'  "; 
					sql = sql + "  from mkt_t_mydailycall   WHERE INT_CALLID =? ";
					System.out.println(sql);
					
					try (PreparedStatement ps = con.prepareStatement(sql)) {
						ps.setString(1, rowid);
						System.out.println(ps);
						ps.execute();
					}
				}
				 
				
			}

			response.sendRedirect(redirect);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		} finally {
			try {
				if (con != null && !con.isClosed())
					con.close();
			} catch (Exception e) {
				// log and ignore
				System.out.println("Error closing connection: " + e.getMessage());
			}
		}
	}

}