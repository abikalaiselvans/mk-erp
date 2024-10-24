package com.my.org.erp.SmartPayroll;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartAttendance.AttendanceFunctions;
import com.my.org.erp.common.CommonFunctions;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SalaryProcessMonthActionHandler extends AbstractActionHandler {
  Statement st;
  
  Statement pfesist;
  
  Statement messst;
  
  Statement advst;
  
  Statement allnost;
  
  ResultSet rs;
  
  ResultSet allrs;
  
  ResultSet recrs;
  
  ResultSet pfesirs;
  
  ResultSet messrs;
  
  ResultSet advrs;
  
  ResultSet allnors;
  
  public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS");
      HttpSession session = request.getSession();
      String userid = (String)session.getAttribute("USRID");
      String loginempid = (String)session.getAttribute("EMPID");
      String bsql = "SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,CHR_SALARY,CHR_PAYTAXDEDUCTION,CHR_PAYTAXVALUE,INT_PFLIMIT,INT_ESILIMIT,CHR_TAXDEDUCTIONEMP,INT_PFLIMITMINIMUM FROM m_institution WHERE INT_ID=1";
      String[][] basicdata = CommonFunctions.RecordSetArray(con, bsql);
      double cpypf = Double.parseDouble(basicdata[0][2]);
      double cpypension = Double.parseDouble(basicdata[0][3]);
      double cpyesi = Double.parseDouble(basicdata[0][4]);
      String compaytaxdeduction = basicdata[0][6];
      String compaytaxvalue = basicdata[0][7];
      double dbpflimit = Double.parseDouble(basicdata[0][8]);
      double dbesilimit = Double.parseDouble(basicdata[0][9]);
      String taxdeductionempid = basicdata[0][10];
      double dbminimumpflimit = Double.parseDouble(basicdata[0][11]);
      String taxsql = "SELECT INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT FROM pay_m_taxvalue ORDER BY INT_ID ";
      String[][] taxdata = CommonFunctions.RecordSetArray(con, taxsql);
      String sql = "";
      String sallowansql = "";
      String srecoverysql = "";
      String sdf = "";
      int noofdaysinamonth = 0;
      String attendanceTable = "";
      if ("PAYSalary".equals(action)) {
        System.out.println("==========================");
        System.out.println("SALARY PROCESSING START");
        String month = request.getParameter("Month");
        String mon = DateUtil.getMonth(Integer.parseInt(month));
        String year = request.getParameter("Year");
        String Office = request.getParameter("Office");
        String dept = request.getParameter("dept");
        String Category = request.getParameter("Category");
        String attendancecheck = request.getParameter("attendancecheck");
        if (!"Y".equals(attendancecheck))
          attendancecheck = "N"; 
        String attendancecycle = request.getParameter("attendancecycle");
        if ("1".equals(attendancecycle)) {
          attendanceTable = " att_t_register ";
        } else {
          attendanceTable = " att_t_register_cycle2 ";
        } 
        sql = " SELECT COUNT(*) ";
        sql = String.valueOf(sql) + " FROM " + attendanceTable + " a ,com_m_staff b , pay_t_salarybasic c";
        sql = String.valueOf(sql) + " WHERE a.DOU_TOTALDAYS >0 AND a.CHR_MONTH='" + mon + "' ";
        sql = String.valueOf(sql) + " AND a.INT_YEAR= " + year;
        sql = String.valueOf(sql) + " AND a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID=c.CHR_EMPID  ";
        sql = String.valueOf(sql) + " AND c.CHR_MONTH='" + mon + "' ";
        sql = String.valueOf(sql) + " AND c.INT_YEAR=  " + year;
        if ("1".equals(attendancecycle)) {
          sql = String.valueOf(sql) + " AND b.INT_ATTENDANCECYCLE =1 ";
        } else {
          sql = String.valueOf(sql) + " AND b.INT_ATTENDANCECYCLE =2 ";
        } 
        sql = String.valueOf(sql) + " AND b.DT_DOJCOLLEGE<='" + year + "-" + month + "-31" + "'";
        if (!"0".equals(dept))
          sql = String.valueOf(sql) + " AND b.INT_DEPARTID=" + dept + " "; 
        if (!"0".equals(Office))
          sql = String.valueOf(sql) + " AND b.INT_OFFICEID=" + Office + " "; 
        if (!"0".equals(Category))
          sql = String.valueOf(sql) + " AND b.CHR_CATEGORY='" + Category + "' "; 
        sql = String.valueOf(sql) + " ORDER BY b.CHR_STAFFNAME ";
        System.out.println(String.valueOf(sql) + "\n");
        boolean flag = CommonFunctions.RecordExist(con, sql);
        boolean attflag = false;
        if ("Y".equals(attendancecheck)) {
          sql = " SELECT a.CHR_EMPID  ";
          sql = String.valueOf(sql) + " FROM " + attendanceTable + " a ,com_m_staff b , pay_t_salarybasic c";
          sql = String.valueOf(sql) + " WHERE a.DOU_TOTALDAYS >0 AND a.CHR_MONTH='" + mon + "' ";
          sql = String.valueOf(sql) + " AND a.INT_YEAR= " + year;
          sql = String.valueOf(sql) + " AND a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID=c.CHR_EMPID  ";
          sql = String.valueOf(sql) + " AND c.CHR_MONTH='" + mon + "' ";
          sql = String.valueOf(sql) + " AND c.INT_YEAR=  " + year;
          if ("1".equals(attendancecycle)) {
            sql = String.valueOf(sql) + " AND b.INT_ATTENDANCECYCLE =1 ";
          } else {
            sql = String.valueOf(sql) + " AND b.INT_ATTENDANCECYCLE =2 ";
          } 
          sql = String.valueOf(sql) + " AND b.DT_DOJCOLLEGE<='" + year + "-" + month + "-31" + "'";
          if (!"0".equals(dept))
            sql = String.valueOf(sql) + " AND b.INT_DEPARTID=" + dept + " "; 
          if (!"0".equals(Office))
            sql = String.valueOf(sql) + " AND b.INT_OFFICEID=" + Office + " "; 
          if (!"0".equals(Category))
            sql = String.valueOf(sql) + " AND b.CHR_CATEGORY='" + Category + "' "; 
          sql = String.valueOf(sql) + " ORDER BY b.CHR_STAFFNAME ";
          String[][] attendanceData = CommonFunctions.QueryExecute(sql);
          attflag = AttendanceFunctions.attendanceRegisterCheck(con, Integer.parseInt(month), year, attendanceData);
        } else {
          attflag = true;
        } 
        if (attflag) {
          if (flag) {
            sql = "SELECT CHR_ANAME,CHR_FLAG FROM pay_m_allowance ORDER BY INT_ALLOWANCEID ";
            String[][] aname = CommonFunctions.RecordSetArray(con, sql);
            for (int a = 0; a < aname.length; a++)
              sallowansql = String.valueOf(sallowansql) + aname[a][0] + " , "; 
            sql = "SELECT CHR_RNAME FROM pay_m_recovery ORDER BY INT_RECOVERYID";
            String[][] rname = CommonFunctions.RecordSetArray(con, sql);
            for (int i = 0; i < rname.length; i++)
              srecoverysql = String.valueOf(srecoverysql) + rname[i][0] + " , "; 
            String allowancecolumn = "";
            for (int u = 0; u < aname.length; u++)
              allowancecolumn = String.valueOf(allowancecolumn) + aname[u][0] + "^"; 
            String recoverycolumn = "";
            for (int j = 0; j < rname.length; j++)
              recoverycolumn = String.valueOf(recoverycolumn) + rname[j][0] + "^"; 
            sql = " SELECT a.CHR_EMPID,b.CHR_STAFFNAME,a.DOU_TOTALDAYS ,c.INT_SALARY,c.CHR_ESI ,c.CHR_PF ,a.DOU_ABSENT";
            sql = String.valueOf(sql) + " ,b.INT_COMPANYID,b.INT_BRANCHID, b.INT_DEPARTID,b.INT_DESIGID,b.INT_OFFICEID,c.CHR_PF,c.CHR_ESI,b.CHR_BANK,b.CHR_ACCNO,   ";
            sql = String.valueOf(sql) + " b.INT_PFAMT,  b.INT_ESIAMT , ";
            sql = String.valueOf(sql) + " IF(b.CHR_PFTYPE='A','Amount',IF(b.CHR_PFTYPE='P','Percentage','-')),  IF(b.CHR_ESITYPE='A','Amount',IF(b.CHR_ESITYPE='P','Percentage','-')) ";
            sql = String.valueOf(sql) + " FROM  " + attendanceTable + "  a ,com_m_staff b , pay_t_salarybasic c";
            sql = String.valueOf(sql) + " WHERE a.DOU_TOTALDAYS >0 AND a.CHR_MONTH='" + mon + "' ";
            sql = String.valueOf(sql) + " AND a.INT_YEAR= " + year;
            sql = String.valueOf(sql) + " AND a.CHR_EMPID=b.CHR_EMPID";
            sql = String.valueOf(sql) + " AND c.CHR_MONTH='" + mon + "' ";
            sql = String.valueOf(sql) + " AND c.INT_YEAR=  " + year;
            if ("1".equals(attendancecycle)) {
              sql = String.valueOf(sql) + " AND b.INT_ATTENDANCECYCLE =1 ";
            } else {
              sql = String.valueOf(sql) + " AND b.INT_ATTENDANCECYCLE =2 ";
            } 
            sql = String.valueOf(sql) + " AND a.CHR_EMPID=c.CHR_EMPID  ";
            sql = String.valueOf(sql) + " AND b.DT_DOJCOLLEGE<='" + year + "-" + month + "-31" + "'";
            if (!"0".equals(dept))
              sql = String.valueOf(sql) + " AND b.INT_DEPARTID=" + dept + " "; 
            if (!"0".equals(Office))
              sql = String.valueOf(sql) + " AND b.INT_OFFICEID=" + Office + " "; 
            if (!"0".equals(Category))
              sql = String.valueOf(sql) + " AND b.CHR_CATEGORY='" + Category + "' "; 
            sql = String.valueOf(sql) + " ORDER BY b.CHR_STAFFNAME ";
            System.out.println(String.valueOf(sql) + "\n");
            String[][] attdata = CommonFunctions.RecordSetArray(con, sql);
            if (attdata.length < 1)
              response.sendRedirect("Smart Payroll/Salary Process.jsp?er=Kindly migrate the Allowance and Recovery"); 
            String id = "";
            for (int v = 0; v < attdata.length; v++)
              id = String.valueOf(id) + "'" + attdata[v][0].trim() + "' , "; 
            asql = " DELETE FROM pay_t_salary WHERE CHR_MONTH='" + mon + "' AND INT_YEAR=" + year;
            asql = String.valueOf(asql) + " AND CHR_EMPID IN (" + id + " '0' )";
            System.out.println(String.valueOf(asql) + "\n");
            apstm = con.prepareStatement(asql);
            apstm.execute();
            System.out.println(attendancecycle);
            if ("1".equals(attendancecycle)) {
              noofdaysinamonth = Integer.parseInt(CommonFunctions.QueryExecute(" SELECT day(last_day('" + year + "-" + month + "-12' )) ")[0][0]);
            } else {
              System.out.println("SELECT FUN_PAY_SALARY_NOOFDAYSINAMONTH('" + year + "','" + month + "')");
              noofdaysinamonth = Integer.parseInt(CommonFunctions.QueryExecute("SELECT FUN_PAY_SALARY_NOOFDAYSINAMONTH('" + year + "','" + month + "') ")[0][0]);
            } 
            String actualcompany = "";
            String actualbranch = "";
            String actualdepart = "";
            String actualdesign = "";
            String actualoffice = "";
            String actualpftype = "";
            String actualesitype = "";
            String actualbank = "";
            String actualaccountno = "";
            String empid = "";
            String empname = "";
            double totaldays = 0.0D;
            double basic = 0.0D;
            double grosspay = 0.0D;
            double addedallowance = 0.0D;
            double extraallowance = 0.0D;
            double recvalue = 0.0D;
            double pfValue = 0.0D, esiValue = 0.0D;
            double mess = 0.0D, advance = 0.0D;
            String esitype = "";
            String pftype = "";
            double CompanyPF1 = 0.0D;
            double CompanyPF2 = 0.0D;
            double CompanyESI = 0.0D;
            double totalsal = 0.0D;
            double monthsal = 0.0D;
            double ctcsal = 0.0D;
            double totalrecovery = 0.0D;
            double absent = 0.0D;
            double addedallowancesal = 0.0D;
            double originalbasic = 0.0D;
            double originalallowance = 0.0D;
            double originalgross = 0.0D;
            double originalpf = 0.0D;
            double originalpension = 0.0D;
            double originalesi = 0.0D;
            double originalctc = 0.0D;
            double lop = 0.0D;
            double penbasic = 0.0D;
            double admincharge = 0.0D;
            double edli = 0.0D;
            double admincharge1 = 0.0D;
            double pension = 0.0D;
            double taxvalue = 0.0D;
            pension = 0.0D;
            System.out.println("Total Employees :" + attdata.length);
            for (int k = 0; k < attdata.length; k++) {
              empid = "";
              empname = "";
              actualcompany = attdata[k][7];
              actualbranch = attdata[k][8];
              actualdepart = attdata[k][9];
              actualdesign = attdata[k][10];
              actualoffice = attdata[k][11];
              actualpftype = attdata[k][12];
              actualesitype = attdata[k][13];
              actualbank = attdata[k][14];
              actualaccountno = attdata[k][15];
              totaldays = 0.0D;
              basic = 0.0D;
              grosspay = 0.0D;
              addedallowance = 0.0D;
              extraallowance = 0.0D;
              recvalue = 0.0D;
              mess = 0.0D;
              advance = 0.0D;
              totalrecovery = 0.0D;
              esitype = "";
              pftype = "";
              pfValue = 0.0D;
              esiValue = 0.0D;
              CompanyPF1 = 0.0D;
              CompanyPF2 = 0.0D;
              CompanyESI = 0.0D;
              totalsal = 0.0D;
              monthsal = 0.0D;
              ctcsal = 0.0D;
              absent = 0.0D;
              addedallowancesal = 0.0D;
              originalbasic = 0.0D;
              originalallowance = 0.0D;
              originalgross = 0.0D;
              originalpf = 0.0D;
              originalpension = 0.0D;
              originalesi = 0.0D;
              originalctc = 0.0D;
              lop = 0.0D;
              penbasic = 0.0D;
              admincharge = 0.0D;
              edli = 0.0D;
              admincharge1 = 0.0D;
              pension = 0.0D;
              taxvalue = 0.0D;
              Statement ts = con.createStatement();
              empid = attdata[k][0].trim();
              empname = attdata[k][1];
              totaldays = Double.parseDouble(attdata[k][2]);
              basic = Double.parseDouble(attdata[k][3]);
              esitype = attdata[k][4];
              pftype = attdata[k][5];
              absent = Double.parseDouble(attdata[k][6]);
              if (CommonFunctions.RecordExist(con, "SELECT Count(*)  FROM pay_t_advance WHERE CHR_EMPID='" + empid + "' AND CHR_TYPE='Y' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + year)) {
                String advsql = "SELECT  INT_DUEAMT  FROM pay_t_advance WHERE CHR_EMPID='" + empid + "' AND CHR_TYPE='Y'  AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + year;
                advance = Double.parseDouble(CommonFunctions.RecordSetArray(con, advsql)[0][0]);
              } 
              originalbasic = basic;
              basic -= basic / noofdaysinamonth * absent;
              String sqlAllTran = "SELECT * FROM pay_t_salaryallowance ";
              sqlAllTran = String.valueOf(sqlAllTran) + " WHERE CHR_EMPID='" + empid + "' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + year;
              String ssql = "SELECT count(*) FROM pay_t_salaryallowance";
              ssql = String.valueOf(ssql) + " WHERE CHR_EMPID='" + empid + "' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + year;
              String[][] avalue = CommonFunctions.RecordSetArray(con, sqlAllTran);
              String sqlavalues = "";
              if (CommonFunctions.RecordExist(con, ssql)) {
                for (int f = 0; f < aname.length; f++) {
                  if ("Y".equals(aname[f][1])) {
                    addedallowancesal = 0.0D;
                    addedallowancesal = Double.parseDouble(avalue[0][f + 1]);
                    originalallowance += Double.parseDouble(avalue[0][f + 1]);
                    addedallowancesal -= addedallowancesal / noofdaysinamonth * absent;
                    addedallowance += addedallowancesal;
                    sdf = addedallowancesal + ",";
                  } else {
                    extraallowance += Double.parseDouble(avalue[0][f + 1]);
                    sdf = Double.parseDouble(avalue[0][f + 1]) + ",";
                  } 
                  sqlavalues = String.valueOf(sqlavalues) + sdf;
                } 
              } else {
                for (int f = 0; f < aname.length; f++)
                  sqlavalues = String.valueOf(sqlavalues) + "0" + " , "; 
              } 
              String sqlRecTran = "SELECT * FROM pay_t_salaryrecovery";
              sqlRecTran = String.valueOf(sqlRecTran) + " WHERE CHR_EMPID='" + empid + "' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + year;
              ssql = "SELECT count(*) FROM pay_t_salaryrecovery ";
              ssql = String.valueOf(ssql) + " WHERE CHR_EMPID='" + empid + "' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + year;
              String sqlrvalues = "";
              String[][] rvalue = CommonFunctions.RecordSetArray(con, sqlRecTran);
              if (CommonFunctions.RecordExist(con, ssql)) {
                for (int m = 0; m < rname.length; m++) {
                  recvalue += Double.parseDouble(rvalue[0][m + 1]);
                  sqlrvalues = String.valueOf(sqlrvalues) + rvalue[0][m + 1] + " ,";
                } 
              } else {
                for (int m = 0; m < rname.length; m++)
                  sqlrvalues = String.valueOf(sqlrvalues) + "0" + " , "; 
              } 
              grosspay = basic + addedallowance;
              if (pftype.equals("C") || esitype.equals("C")) {
                pfesist = con.createStatement();
                String sql_pfesi_query = "SELECT INT_PFAMT,INT_ESIAMT FROM M_INSTITUTION";
                pfesirs = pfesist.executeQuery(sql_pfesi_query);
                if (pfesirs.next()) {
                  if (pftype.equals("C")) {
                    pfValue = pfesirs.getDouble("INT_PFAMT");
                    pftype = "P";
                  } 
                  if (esitype.equals("C")) {
                    esiValue = pfesirs.getDouble("INT_ESIAMT");
                    esitype = "P";
                  } 
                } 
              } 
              originalgross = originalbasic + originalallowance;
              originalctc = originalbasic + originalallowance + originalpf + originalpension + originalesi;
              if (!pftype.equals("N")) {
                if (pftype.equals("P")) {
                  System.out.println(String.valueOf(originalbasic) + "/" + dbminimumpflimit + "/" + ((originalbasic < dbminimumpflimit) ? 1 : 0));
                  if (originalbasic < dbminimumpflimit) {
                    pfValue = (dbminimumpflimit - dbminimumpflimit / noofdaysinamonth * absent) * pfValue / 100.0D;
                    CompanyPF1 = (dbminimumpflimit - dbminimumpflimit / noofdaysinamonth * absent) * cpypension / 100.0D;
                    CompanyPF2 = (dbminimumpflimit - dbminimumpflimit / noofdaysinamonth * absent) * cpypf / 100.0D;
                    System.out.println(String.valueOf(pfValue) + "/" + CompanyPF1 + "/" + CompanyPF2);
                  } else {
                    System.out.println(String.valueOf(basic) + "/+" + dbpflimit + "/" + ((basic < dbpflimit) ? 1 : 0));
                    if (basic < dbpflimit) {
                      pfValue = basic * pfValue / 100.0D;
                      CompanyPF1 = basic * cpypension / 100.0D;
                      CompanyPF2 = basic * cpypf / 100.0D;
                    } else {
                      pfValue = dbpflimit * pfValue / 100.0D;
                      CompanyPF1 = dbpflimit * cpypension / 100.0D;
                      CompanyPF2 = dbpflimit * cpypf / 100.0D;
                    } 
                  } 
                  originalpf = originalbasic * cpypf / 100.0D;
                  originalpension = originalbasic * cpypension / 100.0D;
                } else {
                  pfValue = Double.parseDouble(attdata[k][16]);
                  CompanyPF1 = pfValue * cpypension / 100.0D;
                  CompanyPF2 = pfValue * cpypf / 100.0D;
                  originalpf = pfValue * cpypf / 100.0D;
                  originalpension = pfValue * cpypension / 100.0D;
                } 
              } else {
                pfValue = 0.0D;
                CompanyPF1 = 0.0D;
                CompanyPF2 = 0.0D;
                originalpf = 0.0D;
                originalpension = 0.0D;
              } 
              if (!esitype.equals("N")) {
                if (esitype.equals("P")) {
                  if (originalgross > dbesilimit) {
                    esiValue = 0.0D;
                    CompanyESI = 0.0D;
                    originalesi = 0.0D;
                  } else {
                    esiValue = grosspay * esiValue / 100.0D;
                    CompanyESI = grosspay * cpyesi / 100.0D;
                    originalesi = (originalbasic + originalallowance) * cpyesi / 100.0D;
                  } 
                } else {
                  esiValue = Double.parseDouble(attdata[k][17]);
                  CompanyESI = 0.0D;
                  originalesi = 0.0D;
                } 
              } else {
                esiValue = 0.0D;
                CompanyESI = 0.0D;
                originalesi = 0.0D;
              } 
              pfValue = CommonFunctions.keep2Digit(pfValue);
              originalgross = originalbasic + originalallowance;
              originalctc = originalbasic + originalallowance + originalpf + originalpension + originalesi;
              ctcsal = grosspay + CompanyPF1 + CompanyPF2 + CompanyESI;
              lop = 0.0D;
              penbasic = 0.0D;
              admincharge = 0.0D;
              edli = 0.0D;
              admincharge1 = 0.0D;
              pension = 0.0D;
              if (!pftype.equals("N")) {
                if (originalbasic < dbminimumpflimit) {
                  penbasic = dbminimumpflimit;
                  penbasic = dbminimumpflimit - dbminimumpflimit / noofdaysinamonth * absent;
                  pension = (dbminimumpflimit - dbminimumpflimit / noofdaysinamonth * absent) * cpypension / 100.0D;
                } else if (basic > dbpflimit) {
                  penbasic = dbpflimit;
                  pension = dbpflimit * cpypension / 100.0D;
                } else {
                  penbasic = basic;
                  pension = basic * cpypension / 100.0D;
                } 
                if (pfValue >= 0.0D) {
                  admincharge = penbasic * 0.011000000000000001D;
                  edli = penbasic * 0.005D;
                  admincharge1 = penbasic * 1.0E-4D;
                } 
              } else {
                penbasic = 0.0D;
                admincharge = 0.0D;
                edli = 0.0D;
                admincharge1 = 0.0D;
                pension = 0.0D;
              } 
              sql = "";
              sql = "SELECT COUNT(*) FROM pay_t_taxempids  WHERE CHR_EMPID='" + empid + "' AND INT_YEAR=" + year + " AND CHR_MONTH='" + mon + "' ";
              taxvalue = 0.0D;
              if ("Y" == taxdeductionempid) {
                if (CommonFunctions.RecordExist(con, sql) && 
                  "Y".equals(compaytaxdeduction))
                  for (int t = 0; t < taxdata.length; t++) {
                    if (originalgross >= Integer.parseInt(taxdata[t][0]) && originalgross <= Integer.parseInt(taxdata[t][1]))
                      if ("P".equals(compaytaxvalue)) {
                        taxvalue += originalgross * Double.parseDouble(taxdata[t][2]) / 100.0D;
                      } else {
                        taxvalue += Double.parseDouble(taxdata[t][3]);
                      }  
                  }  
              } else if (!CommonFunctions.RecordExist(con, sql) && 
                "Y".equals(compaytaxdeduction)) {
                for (int t = 0; t < taxdata.length; t++) {
                  if (originalgross >= Integer.parseInt(taxdata[t][0]) && originalgross <= Integer.parseInt(taxdata[t][1]))
                    if ("P".equals(compaytaxvalue)) {
                      taxvalue += originalgross * Double.parseDouble(taxdata[t][2]) / 100.0D;
                    } else {
                      taxvalue += Double.parseDouble(taxdata[t][3]);
                    }  
                } 
              } 
              sql = "SELECT count(*) from com_m_staff WHERE CHR_EMPID='" + empid + "' AND year(DT_DOJCOLLEGE)=" + year + " AND monthname(DT_DOJCOLLEGE)='" + mon + "'";
              if (!CommonFunctions.RecordExist(con, sql)) {
                lop = originalctc - ctcsal;
              } else {
                lop = 0.0D;
              } 
              sql = "";
              asql = "DELETE FROM pay_t_salary WHERE CHR_EMPID=? AND INT_YEAR=? AND CHR_MONTH=? ";
              apstm = con.prepareStatement(asql);
              apstm.setString(1, empid);
              apstm.setString(2, year);
              apstm.setString(3, mon);
              apstm.execute();
              sql = "INSERT INTO pay_t_salary VALUES";
              sql = String.valueOf(sql) + "(";
              sql = String.valueOf(sql) + "'" + empid + "' , ";
              sql = String.valueOf(sql) + "'" + empname + "' , ";
              sql = String.valueOf(sql) + "'" + mon + "' , ";
              sql = String.valueOf(sql) + year + " , ";
              sql = String.valueOf(sql) + attendancecycle + " , ";
              sql = String.valueOf(sql) + "  " + actualcompany + "  , ";
              sql = String.valueOf(sql) + "  " + actualbranch + "  , ";
              sql = String.valueOf(sql) + "  " + actualdepart + "  , ";
              sql = String.valueOf(sql) + "  " + actualdesign + "  , ";
              sql = String.valueOf(sql) + "  " + actualoffice + "  , ";
              sql = String.valueOf(sql) + "  '" + actualbank + "'  , ";
              sql = String.valueOf(sql) + "  '" + actualaccountno + "'  , ";
              sql = String.valueOf(sql) + "'" + actualpftype + "' , ";
              sql = String.valueOf(sql) + "'" + actualesitype + "' , ";
              sql = String.valueOf(sql) + noofdaysinamonth + " , ";
              sql = String.valueOf(sql) + totaldays + " , ";
              sql = String.valueOf(sql) + basic + " , ";
              sql = String.valueOf(sql) + sqlavalues;
              sql = String.valueOf(sql) + addedallowance + " , ";
              sql = String.valueOf(sql) + extraallowance + " , ";
              sql = String.valueOf(sql) + grosspay + " , ";
              sql = String.valueOf(sql) + sqlrvalues;
              sql = String.valueOf(sql) + recvalue + ",";
              sql = String.valueOf(sql) + pfValue + ",";
              sql = String.valueOf(sql) + esiValue + ",";
              sql = String.valueOf(sql) + mess + ",";
              sql = String.valueOf(sql) + advance + ",";
              totalrecovery = recvalue + pfValue + esiValue + taxvalue;
              sql = String.valueOf(sql) + totalrecovery + ",";
              totalsal = grosspay - recvalue + pfValue + esiValue + mess + advance + taxvalue;
              monthsal = grosspay - recvalue + pfValue + esiValue + mess + advance + taxvalue + extraallowance;
              ctcsal = grosspay + CompanyPF1 + CompanyPF2 + CompanyESI;
              sql = String.valueOf(sql) + totalsal + ",";
              sql = String.valueOf(sql) + monthsal + ",";
              sql = String.valueOf(sql) + CompanyPF1 + ",";
              sql = String.valueOf(sql) + CompanyPF2 + ",";
              sql = String.valueOf(sql) + CompanyESI + ",";
              sql = String.valueOf(sql) + (CompanyPF1 + CompanyPF2 + CompanyESI) + ",";
              sql = String.valueOf(sql) + ctcsal + ",";
              sql = String.valueOf(sql) + originalctc + ",";
              sql = String.valueOf(sql) + absent + ",";
              sql = String.valueOf(sql) + lop + ",";
              sql = String.valueOf(sql) + penbasic + ",";
              sql = String.valueOf(sql) + (pfValue - Math.round(pension)) + ",";
              sql = String.valueOf(sql) + Math.round(pension) + ",";
              sql = String.valueOf(sql) + admincharge + ",";
              sql = String.valueOf(sql) + edli + ",";
              sql = String.valueOf(sql) + admincharge1 + ",";
              sql = String.valueOf(sql) + taxvalue + ",";
              sql = String.valueOf(sql) + " null,'0',null,null,'" + loginempid + "' ,'" + userid + "' , DATE(NOW()),'Y' ";
              sql = String.valueOf(sql) + ")";
              System.out.println("Emp id : " + empid + " / " + k + " @ " + attdata.length + "  pf:" + pftype + "  pftype:" + attdata[k][18] + " pfValue :" + pfValue + " CompanyPF1:" + CompanyPF1 + "  CompanyPF2:" + CompanyPF2);
              apstm = con.prepareStatement(sql);
              apstm.execute();
              apstm.close();
            } 
            con.close();
            response.sendRedirect("Smart Payroll/Salary Report.jsp?reqmonth=" + month + "&er=Salary processed for " + attdata.length + " employees ...");
          } else {
            con.close();
            response.sendRedirect("Smart Payroll/Salary Process.jsp?er=Salary process not possible...");
          } 
        } else {
          con.close();
          response.sendRedirect("Smart Payroll/Salary Process.jsp?er=Salary process not done due to incompletion of attendance...");
        } 
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
}
