package com.my.org.erp.SmartPayroll;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AllowanceTransferActionHandler extends AbstractActionHandler {
  public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS");
      String month = request.getParameter("month");
      String mont = DateUtil.getMonth(Integer.parseInt(month));
      String year = request.getParameter("year");
      String Office = request.getParameter("Office");
      String dept = request.getParameter("dept");
      String Category = request.getParameter("Category");
      int y = Integer.parseInt(year);
      int days = Integer.parseInt(CommonFunctions.QueryExecute("select datediff(now(),'" + y + "-" + month + "-01')")[0][0]);
      if (days < 90) {
        if ("PAYAllowanceTransfer".equals(action)) {
          String type = request.getParameter("type");
          if ("0".equals(type)) {
            System.out.println("Migrate basic start");
            SalaryGenerate(this.con, mont, y, Office, dept, Category, this.auserid);
            System.out.println("Migrate basic end");
            System.out.println("Migrate allowance start");
            AllowanceGenerate(this.con, mont, y, Office, dept, Category, this.auserid);
            System.out.println("Migrate allowance end");
            System.out.println("Migrate recovery start");
            RecoveryGenerate(this.con, mont, y, Office, dept, Category, this.auserid);
            System.out.println("Migrate recovery start");
            this.asql = "SELECT CHR_ACODE, CHR_ANAME,CHR_FLAG FROM pay_m_allowance WHERE CHR_FLAG='N' ORDER BY INT_ALLOWANCEID ";
            String[][] aname = CommonFunctions.RecordSetArray(this.con, this.asql);
            if (aname.length > 0) {
              String allowansql = "UPDATE pay_t_salaryallowance SET  ";
              for (int a = 0; a < aname.length; a++)
                allowansql = String.valueOf(allowansql) + aname[a][0] + " =0, "; 
              allowansql = String.valueOf(allowansql) + " CHR_MONTH ='" + mont + "' WHERE CHR_MONTH='" + mont + "' AND INT_YEAR=" + y;
              System.out.println("Update Allowance ::" + allowansql);
              PreparedStatement apstm = this.con.prepareStatement(allowansql);
              apstm.execute();
              apstm.close();
            } 
          } else if ("1".equals(type)) {
            System.out.println("Migrate basic start");
            SalaryGenerate(this.con, mont, y, Office, dept, Category, this.auserid);
            System.out.println("Migrate basic end");
          } else if ("2".equals(type)) {
            System.out.println("Migrate allowance start");
            AllowanceGenerate(this.con, mont, y, Office, dept, Category, this.auserid);
            System.out.println("Migrate allowance end");
            this.asql = "SELECT CHR_ACODE, CHR_ANAME,CHR_FLAG FROM pay_m_allowance WHERE CHR_FLAG='N' ORDER BY INT_ALLOWANCEID ";
            String[][] aname = CommonFunctions.RecordSetArray(this.con, this.asql);
            if (aname.length > 0) {
              String allowansql = "UPDATE pay_t_salaryallowance SET  ";
              for (int a = 0; a < aname.length; a++)
                allowansql = String.valueOf(allowansql) + aname[a][0] + " =0, "; 
              allowansql = String.valueOf(allowansql) + " CHR_MONTH ='" + mont + "' WHERE CHR_MONTH='" + mont + "' AND INT_YEAR=" + y;
              System.out.println("Update Allowance ::" + allowansql);
              PreparedStatement apstm = this.con.prepareStatement(allowansql);
              apstm.execute();
              apstm.close();
            } 
          } else if ("3".equals(type)) {
            System.out.println("Migrate recovery start");
            RecoveryGenerate(this.con, mont, y, Office, dept, Category, this.auserid);
            System.out.println("Migrate recovery start");
          } 
          System.out.println("MIGRATION COMPLETED...");
          this.con.close();
          response.sendRedirect("Smart Payroll/Payrollmain.jsp");
        } 
      } else {
        this.con.close();
        response.sendRedirect("Smart Payroll/Payrollmain.jsp?pmsg=Migrate not possible due to more 45days old...");
      } 
    } catch (Exception e) {
      response.sendRedirect("error/index.jsp?error=" + e.getMessage());
      System.out.println(e.getMessage());
    } 
  }
  
  public static void SalaryGenerate(Connection co, String month, int year, String Office, String dept, String Category, String auserid) {
    try {
      int intmonth = DateUtil.getMonthNumber(month);
      int lastday = Integer.parseInt(CommonFunctions.QueryExecute("select day(last_day('" + year + "-" + intmonth + "-01'))")[0][0]);
      String sql = " ";
      sql = " INSERT INTO pay_t_salarybasic (CHR_EMPID,INT_SALARY,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_PF,CHR_PFTYPE,INT_PFAMT,CHR_PFNO,CHR_ESI,CHR_ESITYPE,INT_ESIAMT,CHR_ESINO,CHR_PFCALCULATIONTYPE) ";
      sql = String.valueOf(sql) + " SELECT a.CHR_EMPID,a.INT_SALARY,MONTHNAME('" + year + "-" + intmonth + "-" + lastday + "'),YEAR('" + year + "-" + intmonth + "-" + lastday + "'),'" + auserid + "',DATE(NOW()),'Y',a.CHR_PF,a.CHR_PFTYPE,a.INT_PFAMT,a.CHR_PFNO,a.CHR_ESI,a.CHR_ESITYPE,a.INT_ESIAMT,a.CHR_ESINO,a.CHR_PFCALCULATIONTYPE   FROM com_m_staff a ";
      sql = String.valueOf(sql) + " WHERE  ( a.DAT_RESIGNDATE >=(DATE_FORMAT(DATE_SUB('" + year + "-" + intmonth + "-01', INTERVAL 1 MONTH),'%Y-%m-%d')) OR a.DAT_RESIGNDATE is null) ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + Office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
      if (!"0".equals(Category))
        sql = String.valueOf(sql) + " AND a.CHR_CATEGORY='" + Category + "' "; 
      sql = String.valueOf(sql) + " AND a.DT_DOJCOLLEGE<='" + year + "-" + intmonth + "-" + lastday + "'";
      sql = String.valueOf(sql) + " AND NOT EXISTS (SELECT b.CHR_EMPID FROM pay_t_salarybasic b WHERE b.CHR_EMPID=a.CHR_EMPID AND  b.CHR_MONTH =MONTHNAME('" + year + "-" + intmonth + "-" + lastday + "') AND b.INT_YEAR =YEAR('" + year + "-" + intmonth + "-" + lastday + "')  ) ";
      System.out.println(sql);
      PreparedStatement apstm = co.prepareStatement(sql);
      apstm.execute();
      apstm.close();
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void AllowanceGenerate(Connection co, String month, int year, String Office, String dept, String Category, String auserid) {
    try {
      int intmonth = DateUtil.getMonthNumber(month);
      int lastday = Integer.parseInt(CommonFunctions.QueryExecute("select day(last_day('" + year + "-" + intmonth + "-01'))")[0][0]);
      String sql = "";
      String sallowansql = "";
      sql = "SELECT CHR_ACODE  FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
      String[][] aname = CommonFunctions.RecordSetArray(co, sql);
      for (int a = 0; a < aname.length; a++)
        sallowansql = String.valueOf(sallowansql) + " b." + aname[a][0] + " , "; 
      sallowansql = sallowansql.substring(0, sallowansql.length() - 1);
      sql = "INSERT INTO pay_t_salaryallowance (CHR_EMPID, " + sallowansql.replaceAll("b.", "") + " CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  ";
      sql = String.valueOf(sql) + " SELECT a.CHR_EMPID,  " + sallowansql + " MONTHNAME('" + year + "-" + intmonth + "-" + lastday + "'),YEAR('" + year + "-" + intmonth + "-" + lastday + "'),'" + auserid + "',DATE(NOW()),'Y' ";
      sql = String.valueOf(sql) + " FROM com_m_staff a ,pay_t_allowance b   ";
      sql = String.valueOf(sql) + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
      sql = String.valueOf(sql) + " AND  ( a.DAT_RESIGNDATE >=(DATE_FORMAT(DATE_SUB('" + year + "-" + intmonth + "-01', INTERVAL 1 MONTH),'%Y-%m-%d')) OR a.DAT_RESIGNDATE is null) ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + Office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + "  AND a.INT_DEPARTID=" + dept; 
      if (!"0".equals(Category))
        sql = String.valueOf(sql) + " AND a.CHR_CATEGORY='" + Category + "' "; 
      sql = String.valueOf(sql) + " AND a.DT_DOJCOLLEGE<='" + year + "-" + intmonth + "-" + lastday + "'";
      sql = String.valueOf(sql) + " AND NOT EXISTS (SELECT c.CHR_EMPID FROM pay_t_salaryallowance c WHERE  c.CHR_EMPID=a.CHR_EMPID AND  c.CHR_MONTH =MONTHNAME('" + year + "-" + intmonth + "-" + lastday + "') AND c.INT_YEAR =YEAR('" + year + "-" + intmonth + "-" + lastday + "')  ) ";
      System.out.println(sql);
      PreparedStatement apstm = co.prepareStatement(sql);
      apstm = co.prepareStatement(sql);
      apstm.execute();
      apstm.close();
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void RecoveryGenerate(Connection co, String month, int year, String Office, String dept, String Category, String auserid) {
    try {
      int intmonth = DateUtil.getMonthNumber(month);
      int lastday = Integer.parseInt(CommonFunctions.QueryExecute("select day(last_day('" + year + "-" + intmonth + "-01'))")[0][0]);
      String sql = "";
      String sallowansql = "";
      sql = "SELECT CHR_RCODE  FROM pay_m_recovery ORDER BY INT_RECOVERYID";
      String[][] aname = CommonFunctions.RecordSetArray(co, sql);
      for (int a = 0; a < aname.length; a++)
        sallowansql = String.valueOf(sallowansql) + " b." + aname[a][0] + " , "; 
      sallowansql = sallowansql.substring(0, sallowansql.length() - 1);
      sql = "INSERT INTO pay_t_salaryrecovery (CHR_EMPID, " + sallowansql.replaceAll("b.", "") + " CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  ";
      sql = String.valueOf(sql) + " SELECT a.CHR_EMPID,  " + sallowansql + " MONTHNAME('" + year + "-" + intmonth + "-" + lastday + "'),YEAR('" + year + "-" + intmonth + "-" + lastday + "'),'" + auserid + "',DATE(NOW()),'Y' ";
      sql = String.valueOf(sql) + " FROM com_m_staff a ,pay_t_recovery b   ";
      sql = String.valueOf(sql) + " WHERE a.CHR_EMPID = b.CHR_EMPID  ";
      sql = String.valueOf(sql) + " AND  ( a.DAT_RESIGNDATE >=(DATE_FORMAT(DATE_SUB('" + year + "-" + intmonth + "-01', INTERVAL 1 MONTH),'%Y-%m-%d')) OR a.DAT_RESIGNDATE is null) ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + Office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
      if (!"0".equals(Category))
        sql = String.valueOf(sql) + " AND a.CHR_CATEGORY='" + Category + "' "; 
      sql = String.valueOf(sql) + " AND a.DT_DOJCOLLEGE<='" + year + "-" + intmonth + "-" + lastday + "'";
      sql = String.valueOf(sql) + " AND NOT EXISTS (SELECT c.CHR_EMPID FROM pay_t_salaryrecovery c WHERE   c.CHR_EMPID=a.CHR_EMPID AND c.CHR_MONTH =MONTHNAME('" + year + "-" + intmonth + "-" + lastday + "') AND c.INT_YEAR =YEAR('" + year + "-" + intmonth + "-" + lastday + "')  ) ";
      System.out.println(sql);
      PreparedStatement apstm = co.prepareStatement(sql);
      apstm = co.prepareStatement(sql);
      apstm.execute();
      apstm.close();
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void SalaryGenerate(Connection co, String month, int year, String Office, String dept, String Category) {
    try {
      int intmonth = DateUtil.getMonthNumber(month);
      String sql = "SELECT CHR_EMPID,INT_SALARY from com_m_staff WHERE CHR_TYPE!='T' AND CHR_HOLD!='Y' ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND INT_OFFICEID=" + Office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + " AND INT_DEPARTID=" + dept; 
      if (!"0".equals(Category))
        sql = String.valueOf(sql) + " AND CHR_CATEGORY='" + Category + "' "; 
      sql = String.valueOf(sql) + " AND DT_DOJCOLLEGE<='" + year + "-" + intmonth + "-31" + "'";
      String[][] data = CommonFunctions.RecordSetArray(co, sql);
      for (int u = 0; u < data.length; u++) {
        sql = "SELECT COUNT(*) FROM pay_t_salarybasic WHERE CHR_MONTH='" + month + "' AND INT_YEAR=" + year;
        sql = String.valueOf(sql) + " AND CHR_EMPID='" + data[u][0] + "'";
        String ssql = "INSERT INTO pay_t_salarybasic VALUES (?,?,?,?,'ADMIN', now() , 'Y' )";
        PreparedStatement apstm = co.prepareStatement(ssql);
        if (!CommonFunctions.RecordExist(co, sql)) {
          apstm.setString(1, data[u][0]);
          apstm.setString(2, data[u][1]);
          apstm.setString(3, month);
          apstm.setString(4, ""+year);
          apstm.addBatch();
        } 
        apstm.executeBatch();
        apstm.close();
      } 
    } catch (Exception exception) {}
  }
  
  public static void AllowanceGenerate(Connection co, String month, int year, String Office, String dept, String Category) {
    try {
      Statement st = co.createStatement();
      int intmonth = DateUtil.getMonthNumber(month);
      String sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' AND CHR_HOLD!='Y' ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND INT_OFFICEID=" + Office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + " AND INT_DEPARTID=" + dept; 
      if (!"0".equals(Category))
        sql = String.valueOf(sql) + " AND CHR_CATEGORY='" + Category + "' "; 
      sql = String.valueOf(sql) + " AND DT_DOJCOLLEGE<='" + year + "-" + intmonth + "-31" + "'";
      String[][] data = CommonFunctions.RecordSetArray(co, sql);
      String sallowansql = "";
      sql = "SELECT CHR_ACODE  FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
      String[][] aname = CommonFunctions.RecordSetArray(co, sql);
      for (int a = 0; a < aname.length; a++)
        sallowansql = String.valueOf(sallowansql) + aname[a][0] + " ,"; 
      sallowansql = sallowansql.substring(0, sallowansql.length() - 1);
      for (int u = 0; u < data.length; u++) {
        sql = "SELECT COUNT(*) FROM pay_t_allowance WHERE CHR_EMPID='" + data[u][0] + "'";
        if (CommonFunctions.RecordExist(co, sql)) {
          sql = "SELECT COUNT(*) FROM pay_t_salaryallowance WHERE CHR_MONTH='" + month + "' AND INT_YEAR=" + year;
          sql = String.valueOf(sql) + " AND CHR_EMPID='" + data[u][0] + "'";
          if (!CommonFunctions.RecordExist(co, sql)) {
            sql = " SELECT " + sallowansql + " FROM pay_t_allowance WHERE CHR_EMPID='" + data[u][0] + "'";
            String[][] adata = CommonFunctions.RecordSetArray(co, sql);
            sql = " INSERT INTO pay_t_salaryallowance VALUES ('" + data[u][0] + "', ";
            for (int x = 0; x < aname.length; x++)
              sql = String.valueOf(sql) + adata[0][x] + ","; 
            sql = String.valueOf(sql) + " '" + month + "'," + year + ",'ADMIN',now(),'Y')";
            st.execute(sql);
          } 
        } else {
          sql = "SELECT COUNT(*) FROM pay_t_salaryallowance WHERE CHR_MONTH='" + month + "' AND INT_YEAR=" + year;
          sql = String.valueOf(sql) + " AND CHR_EMPID='" + data[u][0] + "'";
          if (!CommonFunctions.RecordExist(co, sql)) {
            sql = " INSERT INTO pay_t_salaryallowance VALUES ('" + data[u][0] + "', ";
            for (int i = 0; i < aname.length; i++)
              sql = String.valueOf(sql) + "0 ,"; 
            sql = String.valueOf(sql) + " '" + month + "'," + year + ",'ADMIN',now(),'Y')";
            st.execute(sql);
          } 
        } 
      } 
    } catch (Exception exception) {}
  }
  
  public static void RecoveryGenerate(Connection co, String month, int year, String Office, String dept, String Category) {
    try {
      Statement st = co.createStatement();
      int intmonth = DateUtil.getMonthNumber(month);
      String sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' AND CHR_HOLD!='Y'  ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND INT_OFFICEID=" + Office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + " AND INT_DEPARTID=" + dept; 
      if (!"0".equals(Category))
        sql = String.valueOf(sql) + " AND CHR_CATEGORY='" + Category + "' "; 
      sql = String.valueOf(sql) + " AND DT_DOJCOLLEGE<='" + year + "-" + intmonth + "-31" + "'";
      String[][] data = CommonFunctions.RecordSetArray(co, sql);
      String sallowansql = "";
      sql = "SELECT CHR_RCODE  FROM pay_m_recovery ORDER BY INT_RECOVERYID";
      String[][] aname = CommonFunctions.RecordSetArray(co, sql);
      for (int a = 0; a < aname.length; a++)
        sallowansql = String.valueOf(sallowansql) + aname[a][0] + " ,"; 
      sallowansql = sallowansql.substring(0, sallowansql.length() - 1);
      for (int u = 0; u < data.length; u++) {
        sql = "SELECT COUNT(*) FROM pay_t_recovery WHERE CHR_EMPID='" + data[u][0] + "'";
        if (CommonFunctions.RecordExist(co, sql)) {
          sql = "SELECT COUNT(*) FROM pay_t_salaryrecovery WHERE CHR_MONTH='" + month + "' AND INT_YEAR=" + year;
          sql = String.valueOf(sql) + " AND CHR_EMPID='" + data[u][0] + "'";
          if (!CommonFunctions.RecordExist(co, sql)) {
            sql = " SELECT " + sallowansql + " FROM pay_t_recovery WHERE CHR_EMPID='" + data[u][0] + "'";
            String[][] adata = CommonFunctions.RecordSetArray(co, sql);
            sql = " INSERT INTO pay_t_salaryrecovery VALUES ('" + data[u][0] + "', ";
            for (int x = 0; x < aname.length; x++)
              sql = String.valueOf(sql) + adata[0][x] + ","; 
            sql = String.valueOf(sql) + " '" + month + "', " + year + ",'ADMIN',now(),'Y')";
            st.execute(sql);
          } 
        } else {
          sql = "SELECT COUNT(*) FROM pay_t_salaryrecovery WHERE CHR_MONTH='" + month + "' AND INT_YEAR=" + year;
          sql = String.valueOf(sql) + " AND CHR_EMPID='" + data[u][0] + "'";
          if (!CommonFunctions.RecordExist(co, sql)) {
            sql = " INSERT INTO pay_t_salaryrecovery VALUES ('" + data[u][0] + "', ";
            for (int i = 0; i < aname.length; i++)
              sql = String.valueOf(sql) + "0 ,"; 
            sql = String.valueOf(sql) + " '" + month + "'," + year + ",'ADMIN',now(),'Y')";
            st.execute(sql);
          } 
        } 
      } 
    } catch (Exception exception) {}
  }
}
