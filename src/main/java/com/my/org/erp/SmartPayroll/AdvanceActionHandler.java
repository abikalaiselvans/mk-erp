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

import com.my.org.erp.bean.payroll.Advance;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class AdvanceActionHandler extends AbstractActionHandler {
	String empId = null, msg = null, empName = null, fromdate, todate;

	private void AdvanceList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			ArrayList<Advance> advancelist = new ArrayList<Advance>();
			Statement st = con.createStatement();
			// empId=request.getParameter("ename");
			String closedate = null;
			fromdate = request.getParameter("fromDate");
			String fdate = DateUtil.FormateDateSQL(fromdate);
			todate = request.getParameter("toDate");
			String tdate = DateUtil.FormateDateSQL(todate);

			// ResultSet rs=st.executeQuery("SELECT A.*,B.CHR_STAFFNAME FROM
			// PAY_M_ADVANCE A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND
			// A.CHR_EMPID='"+empId+"'");
			String str = ("SELECT A.*,B.CHR_STAFFNAME FROM PAY_M_ADVANCE A, com_m_staff  B WHERE A.DT_DATE>='"
					+ fdate + "' AND A.DT_DATE<='" + tdate + "' AND A.CHR_EMPID=B.CHR_EMPID");
			ResultSet rs = st.executeQuery(str);
			//System.out.println("Ouery is " + str);
			while (rs.next()) {
				String empId = rs.getString("CHR_EMPID");
				empName = rs.getString("CHR_STAFFNAME");
				String advId = rs.getString("CHR_ADVID");
				String date = rs.getString("DT_DATE");
				String odate[] = date.split("-");
				int y1 = Integer.parseInt(odate[0]);
				int m1 = Integer.parseInt(odate[1]);
				int d1 = Integer.parseInt(odate[2]);
				String openDate = d1 + "-" + m1 + "-" + y1;
				int advamt = rs.getInt("INT_ADVAMT");
				int noofinstal = rs.getInt("Int_NOOFINS");
				int dueamt = rs.getInt("INT_DUE");
				String cldate = "" + rs.getString("DT_CLOSEDATE");
				if (!cldate.equals("null")) {
					String cdate[] = cldate.split("-");
					int y2 = Integer.parseInt(cdate[0]);
					int m2 = Integer.parseInt(cdate[1]);
					int d2 = Integer.parseInt(cdate[2]);
					closedate = d2 + "-" + m2 + "-" + y2;
				} else {
					closedate = "";
				}

				int balamt = rs.getInt("INT_BALAMT");
				int balinstal = rs.getInt("INT_BALINS");

				Advance advance = new Advance();
				advance.setEmp_Id(empId);
				advance.setEmp_name(empName);
				advance.setAdv_Id(advId);
				advance.setOpenDate(openDate);
				advance.setAdvAmt(advamt);
				advance.setNoInstal(noofinstal);
				advance.setDueAmt(dueamt);
				advance.setCloseDate(closedate);
				advance.setBalAmt(balamt);
				advance.setBalInstal(balinstal);
				advancelist.add(advance);
			}
			msg = "List";
			HttpSession session = request.getSession();
			session.setAttribute("advancelist", advancelist);

		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	private void AdvanceAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm, pstran;
			@SuppressWarnings("unused")
			String empid, advid, status, dmonth, closeday, intype;
			@SuppressWarnings("unused")
			int i, m1, d1, y1, m2, d2, y2, addamt, noinstal, dueamt, balamt, binstal;
			String sql_Insert_Query = "INSERT INTO PAY_M_ADVANCE(CHR_EMPID,CHR_ADVID,DT_DATE,INT_YEAR,"
					+ "CHR_MONTH,INT_ADVAMT,Int_NOOFINS,INT_DUE,CHR_DECTYPE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			String sql_tran_Insert = "INSERT INTO PAY_T_ADVANCE(CHR_EMPID,CHR_ADVID,INT_YEAR,CHR_MONTH,INT_DUEAMT)VALUES(?,?,?,?,?)";
			// SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");

			empid = request.getParameter("ename");
			advid = request.getParameter("advid");
			intype = request.getParameter("intype");
			String dat = request.getParameter("openday");
			String data[] = dat.split("-");
			d1 = Integer.parseInt(data[0]);
			m1 = Integer.parseInt(data[1]);
			y1 = Integer.parseInt(data[2]);
			String mon = DateUtil.getMonth(m1);

			String odate = y1 + "-" + m1 + "-" + d1;
			addamt = Integer.parseInt(request.getParameter("adamt"));
			String instal = "" + request.getParameter("noinstal");
			if (instal.equals("null"))
				noinstal = 0;
			else
				noinstal = Integer.parseInt(instal);
			String amt = "" + request.getParameter("dueamt");
			if (amt.equals("null"))
				dueamt = 0;
			else
				dueamt = Integer.parseInt(amt);
			dmonth = request.getParameter("duemonth");
			/*
			 * status=request.getParameter("status");
			 * closeday=""+request.getParameter("closeday"); String cdate=null;
			 * if(closeday.equals("null")||closeday.equals("")) { closeday=null;
			 * }else { String date[]=closeday.split("-");
			 * d2=Integer.parseInt(date[0]); m2=Integer.parseInt(date[1]);
			 * y2=Integer.parseInt(date[2]); cdate=y2+"-"+m2+"-"+d2; }
			 * 
			 * if(dmonth.equals("n")) { m1=m1+1; mon=DateUtil.getMonth(m1); }
			 * balamt=Integer.parseInt(request.getParameter("balamt")); String
			 * balIns=""+request.getParameter("binstal");
			 * if(balIns.equals("null")) { balIns="0"; }
			 * binstal=Integer.parseInt(balIns);
			 */
			if (intype.equals("M")) {
				// CallableStatement cs=con.prepareCall("{call
				// PAY_PRO_(?,?,?,?,?,?,?,?,?)}");
				pstm = con.prepareStatement(sql_Insert_Query);
				pstm.setString(1, empid);
				pstm.setString(2, advid);
				pstm.setString(3, odate);
				pstm.setInt(4, y1);
				pstm.setString(5, mon);
				pstm.setInt(6, addamt);
				pstm.setInt(7, noinstal);
				pstm.setInt(8, dueamt);
				/*
				 * pstm.setInt(9,balamt); pstm.setInt(10,binstal);
				 * pstm.setString(11,status);
				 */
				pstm.setString(12, intype);
				// pstm.setString(13,cdate);
				pstm.setString(14, "ADMIN");
				pstm.setString(15, "2003-06-20 00:00:00");
				pstm.setString(16, "Y");
				pstm.executeUpdate();

			} else if (intype.equals("A")) {
				pstm = con.prepareStatement(sql_Insert_Query);
				pstm.setString(1, empid);
				pstm.setString(2, advid);
				pstm.setString(3, odate);
				pstm.setInt(4, y1);
				pstm.setString(5, mon);
				pstm.setInt(6, addamt);
				pstm.setInt(7, noinstal);
				pstm.setInt(8, dueamt);
				// pstm.setInt(9,balamt);
				// pstm.setInt(10,binstal);
				// pstm.setString(11,status);
				pstm.setString(9, intype);
				// pstm.setString(13,cdate);
				pstm.setString(10, "ADMIN");
				pstm.setString(11, "2003-06-20 00:00:00");
				pstm.setString(12, "Y");
				pstm.executeUpdate();
				pstm.close();
				for (i = 0; i < noinstal; i++) {
					pstran = con.prepareStatement(sql_tran_Insert);
					pstran.setString(1, empid);
					pstran.setString(2, advid);
					pstran.setInt(3, y1);
					pstran.setString(4, mon);
					// pstran.setInt(5,balamt);
					pstran.setInt(5, dueamt);
					// pstran.setInt(7,binstal);
					// pstran.setString(8,status);
					pstran.executeUpdate();
					m1 = m1 + 1;
					if (m1 > 12) {
						m1 = 1;
						y1 = y1 + 1;
					}
					// balamt=balamt-dueamt;
					// binstal=binstal-1;
					mon = DateUtil.getMonth(m1);
				}
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

	private void AdvanceEdit(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			String empid, advid;
			int m1, d1, y1;
			String sql_Edit_Query = "UPDATE PAY_M_ADVANCE SET DT_CLOSEDATE=?,CHR_DUE=? WHERE CHR_EMPID=? AND CHR_ADVID=?";

			// SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");

			empid = request.getParameter("empId");
			advid = request.getParameter("advId");
			String cdate = request.getParameter("closeday");
			String data[] = cdate.split("-");
			d1 = Integer.parseInt(data[0]);
			m1 = Integer.parseInt(data[1]);
			y1 = Integer.parseInt(data[2]);

			@SuppressWarnings("unused")
			String mon = DateUtil.getMonth(m1);
			String odate = y1 + "-" + m1 + "-" + d1;

			pstm = con.prepareStatement(sql_Edit_Query);
			pstm.setString(1, odate);
			pstm.setString(2, "C");
			pstm.setString(3, empid);
			pstm.setString(4, advid);
			pstm.executeUpdate();
 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void AdvanceDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] advanceId = request.getParameterValues("advance");
			Statement st = con.createStatement();
			String str;
			for (int i = 0; i < advanceId.length; i++) {
				str = "DELETE FROM PAY_M_ADVANCE WHERE CHR_ADVID="
						+ advanceId[i];
				st.executeUpdate(str);
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

	 
 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String sumAct = null;
			String action = request.getParameter("actionS");
			if (action.equals("PAYAdvanceAdd")) 
			{
				sumAct = request.getParameter("Submit");
				sumAct = sumAct.trim();
			}
			if (action.equals("PAYAdvanceView")) 
			{
				AdvanceList(request, response);
				response.sendRedirect("Smart Payroll/AdvanceFromTo.jsp?fromDate=" + fromdate + "&toDate=" + todate);
			}
			else if (action.equals("PAYAdvanceAdd")&& sumAct.equalsIgnoreCase("Submit")) 
			{
				AdvanceAdd(request, response);
				response.sendRedirect("Smart Payroll/Advance.jsp");
			} 
			else if (action.equals("PAYAdvanceAdd")	&& sumAct.equalsIgnoreCase("List")) 
			{
				empId = request.getParameter("ename");
				AdvanceList(request, response);
				response.sendRedirect("Smart Payroll/Advance.jsp?message="+ msg + "&empId=" + empId + "&empName=" + empName);
			}
			if (action.equals("PAYAdvanceEdit")) 
			{
				AdvanceEdit(request, response);
				AdvanceList(request, response);
				response
						.sendRedirect("Smart Payroll/AdvanceFromTo.jsp?fromDate="
								+ fromdate + "&toDate=" + todate);
			}
			if (action.equals("PayAdvanceDelete")) 
			{
				AdvanceDelete(request, response);
				AdvanceList(request, response);
				response
						.sendRedirect("Smart Payroll/AdvanceFromTo.jsp?fromDate="
								+ fromdate + "&toDate=" + todate);
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