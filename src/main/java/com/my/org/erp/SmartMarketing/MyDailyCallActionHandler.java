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
import com.my.org.erp.bean.SmartMarketing.MyFunnel;

public class MyDailyCallActionHandler extends AbstractActionHandler {

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user = (String) session.getAttribute("USRID");
			String empid =""+session.getAttribute("EMPID");
			
			if ("MKTMyDailyCallAdd".equals(action)) {

				MyDailyCall d = new MyDailyCall(); 
				Map map = request.getParameterMap();
				BeanUtils.populate(d, map);
				
				String field = " ( CHR_CLIENT_NAME, CHR_LOCATION, CHR_CONTACTPERSON, CHR_DESIGNATION, INT_CONTACTNUMBER,  ";
				field = field + "  CHR_TYPEOFCALL,  DT_ENTRY, CHR_DESCRIPTION,  DT_FOLLOWUP, CHR_USRNAME , DT_UPDATEDATE, CHR_UPDATESTATUS ,CHR_EMPID )";
				String sql = " INSERT INTO mkt_t_mydailycall " + field
						+ " VALUES (?,?,?,?,?,?,?,?,?,? , now(), 'Y' ,? )";
				 
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, d.getClientname());
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
				System.out.println("" + ps);
				ps.execute();
				ps.close();
				con.close();
				response.sendRedirect("Smart Marketing/MyDailyCall_View.jsp");
			} else if (action.equals("MKTMyDailyCallEdit")) {
				String id = request.getParameter("id");
				MyDailyCall d = new MyDailyCall();
				Map map = request.getParameterMap();
				BeanUtils.populate(d, map);

				String ssql =   "UPDATE mkt_t_mydailycall SET CHR_CLIENT_NAME=?, CHR_LOCATION=?, CHR_CONTACTPERSON=?, "
						+ "CHR_DESIGNATION=?, INT_CONTACTNUMBER=?,  ";
				ssql = ssql + "CHR_TYPEOFCALL=?,  DT_ENTRY=?, CHR_DESCRIPTION=?,  DT_FOLLOWUP=?, CHR_USRNAME=? , "
						+ "DT_UPDATEDATE=now(), CHR_UPDATESTATUS='Y'   WHERE INT_CALLID=?";
				 
				PreparedStatement ps = con.prepareStatement(ssql);
				ps.setString(1, d.getClientname());
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
				System.out.println("" + ps);
				ps.execute();
				ps.close();
				con.close();
				response.sendRedirect("Smart Marketing/MyDailyCall_View.jsp");
			} else if (action.equals("MKTMyDailyCallDelete")) {

				String rowids[] = request.getParameterValues("rowid");
				String sql = " DELETE from  mkt_t_mydailycall WHERE INT_CALLID=?";
				apstm = con.prepareStatement(sql);
				for (int u = 0; u < rowids.length; u++) {
					apstm.setString(1, rowids[u]);
					System.out.println("" + apstm);
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
			}
			response.sendRedirect("Smart Marketing/MyDailyCall_View.jsp");

		} catch (Exception e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}
