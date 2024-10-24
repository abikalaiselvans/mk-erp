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

import com.my.org.erp.bean.payroll.EmployeTransfer;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class EmployeTransferActionHandler extends AbstractActionHandler {
	String empId = null, empName = null, msg = null, dojDate, distName,
			toDistrict;

	int distId;

	private void EmpTransferList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<EmployeTransfer> empTransferList = new ArrayList<EmployeTransfer>();
			Statement st = con.createStatement();
			empId = request.getParameter("ename");
			ResultSet rs = st
					.executeQuery("SELECT A.*,B.* FROM PAY_M_EMP_TRANSFER A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.CHR_EMPID='"
							+ empId + "'");

			if (rs.next()) {
				empId = rs.getString("CHR_EMPID");
				empName = rs.getString("CHR_STAFFNAME");
				int transId = rs.getInt("INT_TRANS_ID");
				String tranferDate = rs.getString("DT_TRANSFERDATE");
				String dt[] = tranferDate.split("-");
				tranferDate = dt[2] + "-" + dt[1] + "-" + dt[0];
				int fromDistrict = rs.getInt("INT_FROMDISTRICTID");
				int toDistrictid = rs.getInt("INT_TODISTRICTID");
				Statement sttodist = con.createStatement();
				String Sql_toDistrict = "SELECT CHR_DISTRICT FROM  com_m_district  WHERE INT_DISTRICTID="
						+ toDistrictid;
				ResultSet rstodist = sttodist.executeQuery(Sql_toDistrict);
				while (rstodist.next()) {
					toDistrict = rstodist.getString("CHR_DISTRICT");

				}
				String reason = rs.getString("CHR_REASON");
				String releaveDate = rs.getString("DT_OF_RELEAVE");
				String rdt[] = releaveDate.split("-");
				releaveDate = rdt[2] + "-" + rdt[1] + "-" + rdt[0];
				dojDate = rs.getString("DT_DOJCOLLEGE");
				String tdt[] = dojDate.split("-");
				dojDate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];

				Statement stdist = con.createStatement();
				String Sql_District = "SELECT CHR_DISTRICT FROM  com_m_district  WHERE INT_DISTRICTID="
						+ fromDistrict;
				ResultSet rsdist = stdist.executeQuery(Sql_District);
				while (rsdist.next()) {
					distName = rsdist.getString("CHR_DISTRICT");

				}
				EmployeTransfer emptran = new EmployeTransfer();
				emptran.setEmpId(empId);
				emptran.setTransId(transId);
				emptran.setFromDist(distName);
				emptran.setToDist(toDistrict);
				emptran.setTransferDate(tranferDate);
				emptran.setReleavingDate(releaveDate);
				emptran.setReason(reason);

				empTransferList.add(emptran);
				msg = "List";
				HttpSession session = request.getSession();
				session.setAttribute("empTransferList", empTransferList);
			} else
				msg = "No Record Found";
			HttpSession session = request.getSession();
			session.removeAttribute("empTransferList");
			session.setAttribute("empTransferList", empTransferList);
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void EmployeTransferAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			ResultSet rst;
			String month, OptEmpName, TxtOrder, TxtDor, OptFromDist, TxtReason;
			String Sql, Sql_District;
			String date1, date2;
			int DistrictId = 0, OptToDist;
			String sql_Insert_Query = "INSERT INTO PAY_M_EMP_TRANSFER(INT_TRANS_ID,CHR_EMPID,DT_TRANSFERDATE,INT_FROMDISTRICTID,INT_TODISTRICTID,CHR_REASON,DT_OF_RELEAVE,INT_YEAR,CHR_MONTH,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

			OptEmpName = request.getParameter("ename");
			//System.out.println("Emp id is " + OptEmpName);
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
			TxtDor = request.getParameter("TxtDor");
			date2 = DateUtil.FormateDateSQL(TxtDor);
			OptFromDist = request.getParameter("OptFromDist");
			OptToDist = Integer.parseInt(request.getParameter("OptToDist"));
			TxtReason = request.getParameter("TxtReason");

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
			if (action.equals("PAYEmployeTransferAdd")) {
				sumAct = request.getParameter("Submit");
				sumAct = sumAct.trim();
			}
			if (action.equals("PAYEmployeTransferList")) {
				con.close();   
				response
						.sendRedirect("Smart Payroll/EmployeTransferView.jsp?message=View");
			} else if (action.equals("PAYEmployeTransferAdd")
					&& sumAct.equalsIgnoreCase("Submit")) {
				EmployeTransferAdd(request, response);
				response
						.sendRedirect("Smart Payroll/EmployeTransferView.jsp?message=Employee Transfer Added Sucessfully");
			} else if (action.equals("PAYEmployeTransferAdd")
					&& sumAct.equalsIgnoreCase("List")) {
				empId = request.getParameter("ename");
				EmpTransferList(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/EmployeTransferView.jsp?message="
								+ msg
								+ "&empId="
								+ empId
								+ "&empName="
								+ empName + "&dojDate=" + dojDate);
			} else if (action.equals("PAYEmployeTransferAdd")
					&& sumAct.equalsIgnoreCase("Update")) {
				empId = request.getParameter("empId");
				EmployeTransferUpdate(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/EmployeTransferView.jsp?message=View");
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
