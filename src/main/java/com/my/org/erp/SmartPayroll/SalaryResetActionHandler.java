package com.my.org.erp.SmartPayroll;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SalaryResetActionHandler extends AbstractActionHandler {
  public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS");
      if (action.equals("PAYSalaryResetDelete"))
        try {
          String month = request.getParameter("Month");
          String mon = DateUtil.getMonth(Integer.parseInt(month));
          String Year = request.getParameter("Year");
          String Office = request.getParameter("Office");
          String dept = request.getParameter("dept");
          String Category = request.getParameter("Category");
          String resetfor = request.getParameter("resetfor");
          asql = "SELECT datediff(now(),'" + Year + "-" + month + "-01')";
          String[][] data = CommonFunctions.QueryExecute(asql);
          int daylimit = Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_ATTENDANCEPROCESS FROM att_m_basicsettings WHERE INT_ID=1")[0][0]);
          if (data.length > 0) {
            int diff = Integer.parseInt(data[0][0]);
            if (diff <= daylimit && diff >= 1) {
              try {
                if ("0".equals(resetfor) || "B".equals(resetfor)) {
                  asql = " DELETE a.* FROM pay_t_salarybasic a , com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID ";
                  if (!"0".equals(Office))
                    asql = String.valueOf(asql) + " AND b.INT_OFFICEID=" + Office; 
                  if (!"0".equals(dept))
                    asql = String.valueOf(asql) + " AND b.INT_DEPARTID=" + dept; 
                  if (!"0".equals(Category))
                    asql = String.valueOf(asql) + "   AND b.CHR_CATEGORY='" + Category + "' "; 
                  asql = String.valueOf(asql) + " AND a.CHR_MONTH='" + mon + "' AND a.INT_YEAR=" + Year;
                  apstm = con.prepareStatement(asql);
                  apstm.execute();
                  apstm.close();
                  System.out.println("pay_t_salarybasic reset");
                  CommonFunctions.Execute(asql);
                } 
                if ("0".equals(resetfor) || "A".equals(resetfor)) {
                  asql = " DELETE  a.* FROM pay_t_salaryallowance a , com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID ";
                  if (!"0".equals(Office))
                    asql = String.valueOf(asql) + " AND b.INT_OFFICEID=" + Office; 
                  if (!"0".equals(dept))
                    asql = String.valueOf(asql) + " AND b.INT_DEPARTID=" + dept; 
                  if (!"0".equals(Category))
                    asql = String.valueOf(asql) + "   AND b.CHR_CATEGORY='" + Category + "' "; 
                  asql = String.valueOf(asql) + " AND a.CHR_MONTH='" + mon + "' AND a.INT_YEAR=" + Year;
                  apstm = con.prepareStatement(asql);
                  apstm.execute();
                  apstm.close();
                  System.out.println("pay_t_salaryallowance reset");
                  CommonFunctions.Execute(asql);
                } 
                if ("0".equals(resetfor) || "A".equals(resetfor)) {
                  asql = " DELETE  a.* FROM pay_t_salaryrecovery a , com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID ";
                  if (!"0".equals(Office))
                    asql = String.valueOf(asql) + " AND b.INT_OFFICEID=" + Office; 
                  if (!"0".equals(dept))
                    asql = String.valueOf(asql) + " AND b.INT_DEPARTID=" + dept; 
                  if (!"0".equals(Category))
                    asql = String.valueOf(asql) + "   AND b.CHR_CATEGORY='" + Category + "' "; 
                  asql = String.valueOf(asql) + " AND a.CHR_MONTH='" + mon + "' AND a.INT_YEAR=" + Year;
                  apstm = con.prepareStatement(asql);
                  apstm.execute();
                  apstm.close();
                  System.out.println("pay_t_salaryrecovery reset");
                  CommonFunctions.Execute(asql);
                } 
                if ("0".equals(resetfor) || "D".equals(resetfor)) {
                  asql = " DELETE  a.* FROM pay_t_advance a , com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID ";
                  if (!"0".equals(Office))
                    asql = String.valueOf(asql) + " AND b.INT_OFFICEID=" + Office; 
                  if (!"0".equals(dept))
                    asql = String.valueOf(asql) + " AND b.INT_DEPARTID=" + dept; 
                  if (!"0".equals(Category))
                    asql = String.valueOf(asql) + "   AND b.CHR_CATEGORY='" + Category + "' "; 
                  asql = String.valueOf(asql) + " AND a.CHR_MONTH='" + mon + "' AND a.INT_YEAR=" + Year;
                  asql = String.valueOf(asql) + " AND a.CHR_TYPE='Y'";
                  apstm = con.prepareStatement(asql);
                  apstm.execute();
                  apstm.close();
                  System.out.println("pay_t_advance reset");
                  CommonFunctions.Execute(asql);
                } 
                if ("0".equals(resetfor) || "A".equals(resetfor)) {
                  asql = " DELETE  a.* FROM pay_t_salary a , com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID ";
                  if (!"0".equals(Office))
                    asql = String.valueOf(asql) + " AND b.INT_OFFICEID=" + Office; 
                  if (!"0".equals(dept))
                    asql = String.valueOf(asql) + " AND b.INT_DEPARTID=" + dept; 
                  if (!"0".equals(Category))
                    asql = String.valueOf(asql) + "   AND b.CHR_CATEGORY='" + Category + "' "; 
                  asql = String.valueOf(asql) + " AND a.CHR_MONTH='" + mon + "' AND a.INT_YEAR=" + Year;
                  apstm = con.prepareStatement(asql);
                  apstm.execute();
                  apstm.close();
                  CommonFunctions.Execute(asql);
                  System.out.println("pay_t_salary reset");
                } 
                con.close();
                response.sendRedirect("Smart Payroll/SalaryReset.jsp");
              } catch (RuntimeException e) {
                con.close();
                response.sendRedirect("error/index.jsp?error=" + e.getMessage());
              } 
            } else {
              con.close();
              request.setAttribute("error", "SALARY RESET NOT POSSIBLE AFTER " + daylimit + " DAYS......");
              RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
              dispatchers.forward((ServletRequest)request, (ServletResponse)response);
            } 
          } 
        } catch (RuntimeException e) {
          System.out.println(e.getMessage());
          request.setAttribute("error", e.getMessage());
          RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
          dispatchers.forward((ServletRequest)request, (ServletResponse)response);
        }  
    } catch (Exception e) {
      response.sendRedirect("error/index.jsp?error=" + e.getMessage());
    } 
  }
}
