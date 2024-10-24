package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.payroll.EmployePromotion;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class EmployePromotionActionHandler extends AbstractActionHandler {
	String empId = null, reason, empName = null, msg = null, dojDate,
			fromDesigName, toDesigName;

	int distId;

	private void EmpPomotionList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<EmployePromotion> EmpPomotionList = new ArrayList<EmployePromotion>();
			Statement st = con.createStatement();
			empId = request.getParameter("ename");
			ResultSet rs = st
					.executeQuery("SELECT A.*,B.* FROM PAY_M_EMP_PROMOTION A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.CHR_EMPID='"
							+ empId + "'");

			if (rs.next()) {
				empId = rs.getString("CHR_EMPID");
				empName = rs.getString("CHR_STAFFNAME");
				int proId = rs.getInt("INT_PRO_ID");
				String promotionDate = rs.getString("DT_PRODATE");
				String dt[] = promotionDate.split("-");
				promotionDate = dt[2] + "-" + dt[1] + "-" + dt[0];

				int fromDesigId = rs.getInt("INT_DESIGID_FROM");
				Statement stfromdist = con.createStatement();
				String Sql_fromDistrict = "SELECT CHR_DISTRICT FROM  com_m_desig  WHERE INT_DESIGID="
						+ fromDesigId;
				ResultSet rsfromdist = stfromdist
						.executeQuery(Sql_fromDistrict);
				while (rsfromdist.next()) {
					fromDesigName = rsfromdist.getString("CHR_DESIGNAME");

				}

				int toDesigId = rs.getInt("INT_DESIGID_TO");
				Statement sttodist = con.createStatement();
				String Sql_toDistrict = "SELECT CHR_DISTRICT FROM  com_m_desig  WHERE INT_DESIGID="
						+ toDesigId;
				ResultSet rstodist = sttodist.executeQuery(Sql_toDistrict);
				while (rstodist.next()) {
					toDesigName = rstodist.getString("CHR_DESIGNAME");

				}
				reason = rs.getString("CHR_REASON");

				EmployePromotion emppro = new EmployePromotion();

				emppro.setEmpId(empId);
				emppro.setProid(proId);
				emppro.setProDate(promotionDate);
				emppro.setProFrom(fromDesigName);
				emppro.setProTo(toDesigName);
				emppro.setReason(reason);

				EmpPomotionList.add(emppro);

				msg = "List";
				HttpSession session = request.getSession();
				session.setAttribute("EmpPomotionList", EmpPomotionList);
			} else
				msg = "No Record Found";
			HttpSession session = request.getSession();
			session.removeAttribute("EmpPomotionList");
			session.setAttribute("EmpPomotionList", EmpPomotionList);
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void EmployePromotionAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			ResultSet rst;
			String staffname, TxtProDate, TxtReason, month, Releaving;
			int Count = 0, OptTransDes, OptCurrentDes;
			String sql_Insert = "INSERT INTO PAY_M_EMP_PROMOTION(INT_PRO_ID,CHR_EMPID,DT_PRODATE,INT_DESIGID_FROM,INT_DESIGID_TO,CHR_REASON,INT_YEAR,CHR_MONTH,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			String Sql_DesigId;
			 

			staffname = request.getParameter("ename");
			TxtProDate = request.getParameter("TxtProDate");
			Releaving = DateUtil.FormateDateSQL(TxtProDate);
			OptCurrentDes = Integer.parseInt(request
					.getParameter("OptCurrentDes"));
			// //System.out.println("current Designation is "+OptCurrentDes);
			OptTransDes = Integer.parseInt(request.getParameter("OptTransDes"));
			TxtReason = request.getParameter("TxtReason");
			Count = 0;
			String Sql = "Select max(INT_PRO_ID) as maxid from PAY_M_EMP_PROMOTION where CHR_UPDATESTATUS='y'";
			pstm = con.prepareStatement(Sql);
			rst = pstm.executeQuery();

			if (rst.next()) {
				Count = rst.getInt("maxid") + 1;

			} else {
				Count = 1;
			}

			Sql_DesigId = "SELECT INT_DESIGID FROM  com_m_desig  WHERE CHR_DESIGNAME=? ";
			pstm = con.prepareStatement(Sql_DesigId);
			pstm.setInt(1, OptCurrentDes);
			rst = pstm.executeQuery();
			while (rst.next()) {
				 
			}
			pstm = con.prepareStatement(sql_Insert);
			pstm.setInt(1, Count);
			pstm.setString(2, staffname);
			pstm.setString(3, Releaving);
			pstm.setInt(4, OptCurrentDes);
			pstm.setInt(5, OptTransDes);
			pstm.setString(6, TxtReason);
			String data[] = Releaving.split("-");
			month = DateUtil.getMonth(Integer.parseInt(data[1]));
			pstm.setInt(7, Integer.parseInt(data[0]));
			pstm.setString(8, month);
			pstm.setString(9, "ADMIN");
			pstm.setString(10, "2003-06-20 00:00:00");
			pstm.setString(11, "Y");
			pstm.execute();

			String sql_update = "UPDATE  com_m_staff  SET INT_DESIGID =? WHERE CHR_EMPID=?";
			pstm = con.prepareStatement(sql_update);
			pstm.setInt(1, OptTransDes);
			pstm.setString(2, staffname);
			pstm.execute();

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	

	}

	private void EmployeTransferUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			ResultSet rst;
			String month, OptEmpName, TxtOrder, TxtDor, OptFromDist, TxtReason;
			String Sql, Sql_District;
			String date1, date2;
			int DistrictId = 0, OptToDist;

			String sql_Insert_Query = "INSERT INTO PAY_M_EMP_TRANSFER(INT_TRANS_ID,CHR_EMPID,DT_TRANSFERDATE,INT_FROMDISTRICTID,INT_TODISTRICTID,CHR_REASON,DT_OF_RELEAVE,INT_YEAR,CHR_MONTH,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

			OptEmpName = request.getParameter("empId");
			TxtOrder = request.getParameter("TxtOrder");
			date1 = DateUtil.FormateDateSQL(TxtOrder);
			// //System.out.println(date1);
			// TxtDoj=request.getParameter("TxtDateJoin");
			TxtDor = request.getParameter("TxtDor");
			date2 = DateUtil.FormateDateSQL(TxtDor);
			// //System.out.println(date2);
			OptFromDist = request.getParameter("OptFromDist");
			// //System.out.println(OptFromDist);
			OptToDist = Integer.parseInt(request.getParameter("OptToDist"));
			// //System.out.println(OptToDist);
			TxtReason = request.getParameter("TxtReason");
			// //System.out.println(TxtReason);

			//System.out.println("Inside edit " + OptEmpName);
			Statement stdist = con.createStatement();
			String del_Query = "DELETE FROM PAY_M_EMP_TRANSFER WHERE CHR_EMPID='"
					+ OptEmpName + "'";
			stdist.execute(del_Query);

			int Count;
			Sql = "Select max(INT_TRANS_ID) as maxid from PAY_M_EMP_TRANSFER where chr_UPDATESTATUS='y'";
			pstm = con.prepareStatement(Sql);
			rst = pstm.executeQuery();

			if (rst.next()) {
				Count = rst.getInt("maxid") + 1;
			} else {
				Count = 1;
			}

			Sql_District = "SELECT INT_DISTRICTID FROM  com_m_district  WHERE CHR_DISTRICT=? ";
			pstm = con.prepareStatement(Sql_District);
			pstm.setString(1, OptFromDist);
			rst = pstm.executeQuery();
			while (rst.next()) {
				DistrictId = rst.getInt("INT_DISTRICTID");

			}
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setInt(1, Count);
			pstm.setString(2, OptEmpName);
			pstm.setString(3, date1);
			pstm.setInt(4, DistrictId);
			pstm.setInt(5, OptToDist);
			pstm.setString(6, TxtReason);
			pstm.setString(7, date2);
			String data[] = date2.split("-");
			month = DateUtil.getMonth(Integer.parseInt(data[1]));
			pstm.setInt(8, Integer.parseInt(data[0]));
			pstm.setString(9, month);
			pstm.setString(10, "ADMIN");
			pstm.setString(11, "2003-06-20 00:00:00");
			pstm.setString(12, "Y");
			pstm.execute();

			String sql_update = "UPDATE  com_m_staff  SET INT_DISTRICTID =? WHERE CHR_EMPID=?";
			pstm = con.prepareStatement(sql_update);
			pstm.setInt(1, OptToDist);
			pstm.setString(2, OptEmpName);
			pstm.execute();

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String sumAct = null;
			String action = request.getParameter("actionS");
			//System.out.println("Action in Emp Transfer" + action);
			if (action.equals("PAYEmployePromotionAdd")) {
				sumAct = request.getParameter("Submit");
				sumAct = sumAct.trim();
			}

			if (action.equals("PAYEmployePromotionList")) {
				con.close();   
				response
						.sendRedirect("Smart Payroll/EmployePromotionView.jsp?message=View");
			} else if (action.equals("PAYEmployePromotionAdd")
					&& sumAct.equalsIgnoreCase("Submit")) {
				EmployePromotionAdd(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/EmployePromotionView.jsp?message=Employee Transfer Added Sucessfully");
			} else if (action.equals("PAYEmployePromotionAdd")
					&& sumAct.equalsIgnoreCase("List")) {
				empId = request.getParameter("ename");
				//System.out.println("Empid in emplist is" + empId);
				EmpPomotionList(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/EmployePromotionView.jsp?message="
								+ msg
								+ "&empId="
								+ empId
								+ "&empName="
								+ empName);
			} else if (action.equals("PAYEmployePromotionAdd")
					&& sumAct.equalsIgnoreCase("Update")) {
				empId = request.getParameter("empId");
				EmployeTransferUpdate(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/EmployePromotionView.jsp?message=View");
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
