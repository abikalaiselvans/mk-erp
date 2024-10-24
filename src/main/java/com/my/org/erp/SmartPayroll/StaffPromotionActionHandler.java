package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StaffPromotionActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	PreparedStatement pstm;
	 
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			
			
			if (action.equals("PAYStaffPromotionAdd")) 
			{
				String staffid = "" + request.getParameter("staffid");
				String promotiondate = ""+ request.getParameter("promotiondate");
				promotiondate = DateUtil.FormateDateSQL(promotiondate);
				String pdesgid = "" + request.getParameter("desigid");
				String tdesgid = "" + request.getParameter("toDesigId");
				String reason = "" + request.getParameter("reason");
				String salary = "" + request.getParameter("salary");
				if(!"Y".equals(salary))
					salary="N";
				
				acs = con.prepareCall("{call  PAY_PRO_EMPLOYEEPROMOTION (?,?,?, ?,?,?, ?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, "");
				acs.setString(3,  staffid);
				acs.setString(4, promotiondate );
				acs.setString(5, pdesgid);
				acs.setString(6, tdesgid );
				acs.setString(7, reason );
				acs.setString(8,  salary);
				acs.setString(9,  userid);
				// System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();     
				response.sendRedirect("Smart Payroll/EmployeePromotion.jsp");
			}
			
			else if (action.equals("PAYStaffPromotionUpdate")) 
			{

				
				String rowid = "" + request.getParameter("rowid");
				String staffid = "" + request.getParameter("staffid");
				String promotiondate = ""+ request.getParameter("promotiondate");
				promotiondate = DateUtil.FormateDateSQL(promotiondate);
				String pdesgid = "" + request.getParameter("desigid");
				String tdesgid = "" + request.getParameter("toDesigId");
				String reason = "" + request.getParameter("reason");
				String salary = "" + request.getParameter("salary");
				if(!"Y".equals(salary))
					salary="N";
				acs = con.prepareCall("{call  PAY_PRO_EMPLOYEEPROMOTION (?,?,?, ?,?,?, ?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, rowid);
				acs.setString(3,  staffid);
				acs.setString(4, promotiondate );
				acs.setString(5, pdesgid);
				acs.setString(6, tdesgid );
				acs.setString(7, reason );
				acs.setString(8,  salary);
				acs.setString(9,  userid);
				// System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();     
				response.sendRedirect("Smart Payroll/EmployeePromotion.jsp");
			} 
			
			else if (action.equals("PAYStaffPromotionDelete")) 
			{
			
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println();
				String sql="";
				String staffid[] = request.getParameterValues("staffid");
				acs = con.prepareCall("{call  PAY_PRO_EMPLOYEEPROMOTION (?,?,?, ?,?,?, ?,?,? )}");
				
				for (int u = 0; u < staffid.length; u++) 
				{
					sql = "   SELECT INT_PROMOTION_ID,CHR_EMPID,DT_PRODATE,INT_FROM_DESIGID,INT_TO_DESIGID,CHR_REASON,CHR_SALARYCHANGE FROM pay_m_emp_promotion";
					sql = sql +" WHERE   CHR_EMPID='"+staffid[u]+"'   ORDER BY INT_PROMOTION_ID DESC ";
					String Datas[][] = CommonFunctions.QueryExecute(sql);
					if(Datas.length>0)
					{
						acs.setString(1, "DELETE");
						acs.setString(2, Datas[0][0]);
						acs.setString(3, Datas[0][1]);
						acs.setString(4, Datas[0][2]);
						acs.setString(5, Datas[0][3]);
						acs.setString(6, Datas[0][4]);
						acs.setString(7, Datas[0][5]);
						acs.setString(8, Datas[0][6]);
						acs.setString(9,userid );
						System.out.println(""+acs);
						acs.addBatch();
					}
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Payroll/EmployeePromotion.jsp");
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
