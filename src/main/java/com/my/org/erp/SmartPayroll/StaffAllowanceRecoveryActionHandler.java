package com.my.org.erp.SmartPayroll;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class StaffAllowanceRecoveryActionHandler extends AbstractActionHandler {
  Statement st;
  
  ResultSet rs;
  
  PreparedStatement pstm;
  
  private String collectAllowanceField() {
    String fields = "";
    try {
      String sql = "SELECT CHR_ACODE FROM PAY_M_ALLOWANCE ORDER  BY  INT_ALLOWANCEID";
      st = con.createStatement();
      rs = st.executeQuery(sql);
      fields = "";
      while (rs.next())
        fields = String.valueOf(fields) + rs.getString(1) + "~"; 
      return fields;
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return null;
    } 
  }
  
  private String collectRecoveryField() {
    String fields = "";
    try {
      String sql = "SELECT CHR_RCODE FROM PAY_M_RECOVERY ORDER BY INT_RECOVERYID";
      st = con.createStatement();
      rs = st.executeQuery(sql);
      fields = "";
      while (rs.next())
        fields = String.valueOf(fields) + rs.getString(1) + "~"; 
      return fields;
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return null;
    } 
  }
  
  private void StaffDeletion(String staffid) {
    try {
      if (CommonFunctions.RecordExist(con, "SELECT COUNT(*) FROM pay_t_allowance WHERE CHR_EMPID = '" + staffid + "'")) {
        asql = " UPDATE pay_t_allowance SET A001=0,A002=0,A003=0,A004=0,A005=0,A006=0,A007=0,A008=0,A009=0,A0010=0,A0011=0,A0012=0,A0013=0,A0014=0,A0015=0 ,DAT_EFFECT=DATE(NOW())  WHERE CHR_EMPID = '" + staffid + "'";
        apstm = con.prepareStatement(asql);
        apstm.execute();
        apstm.close();
      } 
      if (CommonFunctions.RecordExist(con, "SELECT COUNT(*) FROM pay_t_recovery WHERE CHR_EMPID = '" + staffid + "'")) {
        asql = " UPDATE pay_t_recovery SET R001=0,R002=0,R003=0,R004=0,R005=0,R006=0,R007=0,R008=0 ,DAT_EFFECT=DATE(NOW())  WHERE CHR_EMPID = '" + staffid + "'";
        apstm = con.prepareStatement(asql);
        apstm.execute();
        apstm.close();
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS");
      HttpSession session = request.getSession();
      SimpleDateFormat datetime = new SimpleDateFormat("yyyy-MM-dd");
      Date date = new Date();
      String updatedate = datetime.format(date);
      String userId = (String)session.getAttribute("USRID");
      if (action.equals("PAYStaffAdvanceUpdate")) {
        String staffid = request.getParameter("staffid");
        String advid = request.getParameter("advid");
        double advAdvance = Double.parseDouble(request.getParameter("advAdvance"));
        double advRecovery = Double.parseDouble(request.getParameter("advRecovery"));
        double advBalance = advAdvance - advRecovery;
        String status = "";
        if (advBalance <= 0.0D) {
          status = "C";
        } else {
          status = "";
        } 
        String sql = " INSERT INTO PAY_T_ADVANCE ";
        sql = String.valueOf(sql) + " (CHR_EMPID,CHR_ADVID,INT_YEAR,CHR_MONTH,Int_BalAmt,INT_DUEAMT,Int_Balance,Chr_Status) ";
        sql = String.valueOf(sql) + " VALUES('" + staffid + "','" + advid + "', year(now()),monthname(now()),";
        sql = String.valueOf(sql) + advAdvance + ",";
        sql = String.valueOf(sql) + advRecovery + ",";
        sql = String.valueOf(sql) + advBalance + ",";
        sql = String.valueOf(sql) + "'" + status + "')";
        Statement st = con.createStatement();
        st.execute(sql);
        con.close();
        response.sendRedirect("Smart Payroll/exit.jsp");
      } else if (action.equals("PAYStaffAllowanceRecoveryAdd")) {
        String[] staff = request.getParameterValues("ename");
        String effectdt = request.getParameter("effectdt");
        effectdt = DateUtil.FormateDateSQL(effectdt);
        String staffid = "";
        boolean eflag = false;
        String estaff = "";
        for (int k = 0; k < staff.length; k++) {
          staffid = staff[k];
          String allowanceFields = collectAllowanceField();
          String recoveryFields = collectRecoveryField();
          String[] afields = allowanceFields.split("~");
          String[] rfields = recoveryFields.split("~");
          String sql = "SELECT count(*) FROM PAY_T_ALLOWANCE CHR_EMPID";
          sql = String.valueOf(sql) + " WHERE  CHR_EMPID = '" + staffid + "'";
          boolean aflag = CommonFunctions.RecordExist(con, sql);
          sql = "SELECT count(*) FROM PAY_T_RECOVERY CHR_EMPID";
          sql = String.valueOf(sql) + " WHERE  CHR_EMPID = '" + staffid + "'";
          boolean rflag = CommonFunctions.RecordExist(con, sql);
          String reqallowancefields = "";
          String reqrecoveryfields = "";
          String asqltrue = "";
          String rsqltrue = "";
          String asqlfalse = "";
          String rsqlfalse = "";
          String reqval = "";
          asqltrue = "UPDATE pay_t_allowance SET CHR_USRNAME='" + userId + "', DT_UPDATEDATE=DATE(NOW()), ";
          reqallowancefields = "";
          int i;
          for (i = 0; i < afields.length; i++) {
            reqval = "";
            reqval = request.getParameter(afields[i]);
            if (reqval.equals("") || reqval.equals("null"))
              reqval = "0"; 
            reqallowancefields = String.valueOf(reqallowancefields) + afields[i].toUpperCase() + " = '" + reqval + "' ,";
          } 
          reqallowancefields = String.valueOf(reqallowancefields) + " DAT_EFFECT ='" + effectdt + "',";
          reqallowancefields.trim();
          reqallowancefields = reqallowancefields.substring(0, reqallowancefields.length() - 1);
          asqltrue = String.valueOf(asqltrue) + reqallowancefields + " WHERE CHR_EMPID = '" + staffid + "'";
          asqlfalse = "INSERT INTO pay_t_allowance VALUES ( '" + staffid + "' ,";
          reqallowancefields = "";
          for (i = 0; i < afields.length; i++) {
            reqval = "";
            reqval = request.getParameter(afields[i]);
            if (reqval.equals("") || reqval.equals("null"))
              reqval = "0"; 
            reqallowancefields = String.valueOf(reqallowancefields) + "  '" + reqval + "' ,";
          } 
          reqallowancefields = String.valueOf(reqallowancefields) + "  '" + effectdt + "',";
          reqallowancefields = String.valueOf(reqallowancefields) + " '" + userId + "', DATE(NOW()),'Y' ,";
          reqallowancefields.trim();
          reqallowancefields = reqallowancefields.substring(0, reqallowancefields.length() - 1);
          asqlfalse = String.valueOf(asqlfalse) + reqallowancefields + " )";
          rsqltrue = "UPDATE PAY_T_RECOVERY SET CHR_USRNAME='" + userId + "', DT_UPDATEDATE=DATE(NOW()), ";
          reqrecoveryfields = "";
          for (i = 0; i < rfields.length; i++) {
            reqval = "";
            reqval = request.getParameter(rfields[i]);
            if (reqval.equals("") || reqval.equals("null"))
              reqval = "0"; 
            reqrecoveryfields = String.valueOf(reqrecoveryfields) + rfields[i].toUpperCase() + " = '" + reqval + "' ,";
          } 
          reqrecoveryfields = String.valueOf(reqrecoveryfields) + " DAT_EFFECT ='" + effectdt + "',";
          reqrecoveryfields.trim();
          reqrecoveryfields = reqrecoveryfields.substring(0, reqrecoveryfields.length() - 1);
          rsqltrue = String.valueOf(rsqltrue) + reqrecoveryfields + " WHERE CHR_EMPID = '" + staffid + "'";
          rsqlfalse = "INSERT INTO PAY_T_RECOVERY VALUES ( '" + staffid + "' ,";
          reqrecoveryfields = "";
          for (i = 0; i < rfields.length; i++) {
            reqval = "";
            reqval = request.getParameter(rfields[i]);
            if (reqval.equals("") || reqval.equals("null"))
              reqval = "0"; 
            reqrecoveryfields = String.valueOf(reqrecoveryfields) + "  '" + reqval + "' ,";
          } 
          reqrecoveryfields = String.valueOf(reqrecoveryfields) + "  '" + effectdt + "',";
          reqrecoveryfields = String.valueOf(reqrecoveryfields) + " '" + userId + "', DATE(NOW()),'Y' ,";
          reqrecoveryfields.trim();
          reqrecoveryfields = reqrecoveryfields.substring(0, reqrecoveryfields.length() - 1);
          rsqlfalse = String.valueOf(rsqlfalse) + reqrecoveryfields + " )";
          if (aflag) {
            eflag = true;
            estaff = staffid;
            break;
          } 
          st = con.createStatement();
          st.executeUpdate(asqlfalse);
          if (rflag) {
            eflag = true;
            estaff = staffid;
            break;
          } 
          st = con.createStatement();
          st.executeUpdate(rsqlfalse);
        } 
        if (eflag) {
          String sql = "SELECT B.CHR_EMPID, B.CHR_STAFFNAME FROM pay_t_allowance A, com_m_staff B WHERE A.CHR_EMPID = B.CHR_EMPID AND A.CHR_EMPID='" + staffid + "'";
          String[][] Datas1 = CommonFunctions.QueryExecute(sql);
          String ID = "", Name = "";
          if (Datas1.length > 0) {
            ID = Datas1[0][0];
            Name = Datas1[0][1];
          } else {
            sql = "SELECT B.CHR_EMPID, B.CHR_STAFFNAME FROM pay_t_allowance A, com_m_staff B WHERE A.CHR_EMPID = B.CHR_EMPID AND A.CHR_EMPID='" + staffid + "'";
            String[][] Datas2 = CommonFunctions.QueryExecute(sql);
            if (Datas2.length > 0) {
              ID = Datas2[0][0];
              Name = Datas2[0][1];
            } 
          } 
          con.close();
          response.sendRedirect("Smart Payroll/AllowanceRecoveryAdd.jsp?ID=" + ID + "&Name=" + Name);
        } else {
          response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
        } 
      } else if (action.equals("PAYStaffAllowanceRecoveryUpdate")) {
        String staffid = request.getParameter("staffid");
        String effectdt = request.getParameter("effectdt");
        effectdt = DateUtil.FormateDateSQL(effectdt);
        staffid.trim();
        String allowanceFields = collectAllowanceField();
        String recoveryFields = collectRecoveryField();
        String[] afields = allowanceFields.split("~");
        String[] rfields = recoveryFields.split("~");
        String sql = "SELECT count(*) FROM PAY_T_ALLOWANCE CHR_EMPID";
        sql = String.valueOf(sql) + " WHERE  CHR_EMPID = '" + staffid + "'";
        boolean aflag = CommonFunctions.RecordExist(con, sql);
        sql = "SELECT count(*) FROM PAY_T_RECOVERY CHR_EMPID";
        sql = String.valueOf(sql) + " WHERE  CHR_EMPID = '" + staffid + "'";
        boolean rflag = CommonFunctions.RecordExist(con, sql);
        String reqallowancefields = "";
        String reqrecoveryfields = "";
        String asqltrue = "";
        String rsqltrue = "";
        String asqlfalse = "";
        String rsqlfalse = "";
        String reqval = "";
        asqltrue = "UPDATE pay_t_allowance SET CHR_USRNAME='" + userId + "', DT_UPDATEDATE=DATE(NOW()), ";
        reqallowancefields = "";
        int i;
        for (i = 0; i < afields.length; i++) {
          reqval = "";
          reqval = request.getParameter(afields[i]);
          if (reqval.equals("") || reqval.equals("null"))
            reqval = "0"; 
          reqallowancefields = String.valueOf(reqallowancefields) + 
            afields[i].toUpperCase() + " = '" + reqval + 
            "' ,";
        } 
        reqallowancefields = String.valueOf(reqallowancefields) + " DAT_EFFECT ='" + effectdt + "',";
        reqallowancefields.trim();
        reqallowancefields = reqallowancefields.substring(0, reqallowancefields.length() - 1);
        asqltrue = String.valueOf(asqltrue) + reqallowancefields + " WHERE CHR_EMPID = '" + staffid + "'";
        System.out.println("Allowance Updation :" + asqltrue);
        asqlfalse = "INSERT INTO pay_t_allowance VALUES ( '" + staffid + "' ,";
        reqallowancefields = "";
        for (i = 0; i < afields.length; i++) {
          reqval = "";
          reqval = request.getParameter(afields[i]);
          if (reqval.equals("") || reqval.equals("null"))
            reqval = "0"; 
          reqallowancefields = String.valueOf(reqallowancefields) + "  '" + reqval + "' ,";
        } 
        reqallowancefields = String.valueOf(reqallowancefields) + " '" + effectdt + "',";
        reqallowancefields = String.valueOf(reqallowancefields) + " '" + userId + "', DATE(NOW()),'Y' ,";
        reqallowancefields.trim();
        reqallowancefields = reqallowancefields.substring(0, reqallowancefields.length() - 1);
        asqlfalse = String.valueOf(asqlfalse) + reqallowancefields + " )";
        System.out.println("Allowance Insertion" + asqlfalse);
        rsqltrue = "UPDATE pay_t_recovery SET  CHR_USRNAME='" + userId + "', DT_UPDATEDATE=DATE(NOW()), ";
        reqrecoveryfields = "";
        for (i = 0; i < rfields.length; i++) {
          reqval = "";
          reqval = request.getParameter(rfields[i]);
          if (reqval.equals("") || reqval.equals("null"))
            reqval = "0"; 
          reqrecoveryfields = String.valueOf(reqrecoveryfields) + 
            rfields[i].toUpperCase() + " = '" + reqval + 
            "' ,";
        } 
        reqrecoveryfields = String.valueOf(reqrecoveryfields) + " DAT_EFFECT ='" + effectdt + "',";
        reqrecoveryfields.trim();
        reqrecoveryfields = reqrecoveryfields.substring(0, reqrecoveryfields.length() - 1);
        rsqltrue = String.valueOf(rsqltrue) + reqrecoveryfields + " WHERE CHR_EMPID = '" + staffid + "'";
        System.out.println("Recovery Updation :" + rsqltrue);
        rsqlfalse = "INSERT INTO pay_t_recovery VALUES ( '" + staffid + "' ,";
        reqrecoveryfields = "";
        for (i = 0; i < rfields.length; i++) {
          reqval = "";
          reqval = request.getParameter(rfields[i]);
          if (reqval.equals("") || reqval.equals("null"))
            reqval = "0"; 
          reqrecoveryfields = String.valueOf(reqrecoveryfields) + "  '" + reqval + "' ,";
        } 
        reqrecoveryfields = String.valueOf(reqrecoveryfields) + " '" + effectdt + "',";
        reqrecoveryfields = String.valueOf(reqrecoveryfields) + " '" + userId + "', DATE(NOW()),'Y' ,";
        reqrecoveryfields.trim();
        reqrecoveryfields = reqrecoveryfields.substring(0, reqrecoveryfields.length() - 1);
        rsqlfalse = String.valueOf(rsqlfalse) + reqrecoveryfields + " )";
        System.out.println("Recovery Insertion :" + rsqlfalse);
        st = con.createStatement();
        if (aflag) {
          st.execute(asqltrue);
        } else {
          st.execute(asqlfalse);
        } 
        if (rflag) {
          st.execute(rsqltrue);
        } else {
          st.execute(rsqlfalse);
        } 
        System.out.println("***************************************************************************************");
        staffRegistrationPFESIUpdation(request);
        st.close();
        con.close();
        response.sendRedirect("Smart Payroll/Refresh.jsp");
      } else if (action.equals("PAYStaffAllowanceRecoveryDelete")) {
        String[] staff = request.getParameterValues("staffid");
        String staffid = "";
        for (int i = 0; i < staff.length; i++) {
          staffid = staff[i];
          staffid.trim();
          StaffDeletion(staffid);
        } 
        con.close();
        response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
      } else if ("PAYRivisionDelete".equals(action)) {
        String[] staff = request.getParameterValues("staffid");
        for (int i = 0; i < staff.length; i++) {
          String staffid = staff[i];
          String[][] ma = CommonFunctions.QueryExecute("select max(INT_RIVISIONID) from pay_t_rivision WHERE CHR_EMPID ='" + staffid + "'");
          int maxid = Integer.parseInt(ma[0][0]);
          int alterid = maxid - 1;
          boolean flag = false;
          if (maxid < 2) {
            flag = false;
          } else {
            flag = true;
          } 
          if (flag) {
            String query = "Select CHR_ACODE,CHR_ANAME from pay_m_allowance order by CHR_ACODE";
            String[][] Allowance = CommonFunctions.QueryExecute(query);
            query = "Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE";
            String[][] Recovery = CommonFunctions.QueryExecute(query);
            String fields = "";
            int u;
            for (u = 0; u < Allowance.length; u++)
              fields = String.valueOf(fields) + Allowance[u][0] + ","; 
            for (u = 0; u < Recovery.length; u++)
              fields = String.valueOf(fields) + Recovery[u][0] + ","; 
            fields = fields.substring(0, fields.trim().length() - 1);
            String[][] previousData = CommonFunctions.QueryExecute("SELECT " + fields + " FROM pay_t_rivision WHERE CHR_EMPID ='" + staffid + "' AND  INT_RIVISIONID =" + alterid);
            String sql = "DELETE FROM pay_t_rivision WHERE INT_RIVISIONID=" + maxid + " AND CHR_EMPID='" + staffid + "'";
            Statement st = con.createStatement();
            st.execute(sql);
            sql = "UPDATE pay_t_allowance SET ";
            for (int j = 0; j < Allowance.length; j++)
              sql = String.valueOf(sql) + " " + Allowance[j][0] + " = '" + previousData[0][j] + "' , "; 
            sql = sql.substring(0, sql.trim().length() - 1);
            sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "'";
            st.execute(sql);
            sql = "UPDATE pay_t_recovery SET ";
            int id = Allowance.length;
            for (int k = 0; k < Recovery.length; k++) {
              sql = String.valueOf(sql) + " " + Recovery[k][0] + " = '" + previousData[0][id] + "' , ";
              id++;
            } 
            sql = sql.substring(0, sql.trim().length() - 1);
            sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "'";
            st.execute(sql);
            String q = " SELECT INT_BASIC ,INT_INCREMENT  FROM pay_t_rivision WHERE CHR_EMPID='" + staffid + "' AND INT_RIVISIONID =(SELECT MAX(INT_RIVISIONID) FROM pay_t_rivision WHERE CHR_EMPID='" + staffid + "')";
            String[][] bas = CommonFunctions.QueryExecute(q);
            double basic = 0.0D;
            if (!bas[0][0].equals("-"))
              basic = Double.parseDouble(bas[0][0]); 
            double inc = 0.0D;
            if (!bas[0][1].equals("-"))
              inc = Double.parseDouble(bas[0][1]); 
            sql = "UPDATE  com_m_staff  SET INT_SALARY =" + (basic + inc) + " WHERE CHR_EMPID = '" + staffid + "'";
            st.execute(sql);
          } 
        } 
        con.close();
        response.sendRedirect("Smart Payroll/Rivision.jsp");
      } else if (action.equals("PAYAllowanceRecoveryRivision")) {
        String staffid = request.getParameter("ename");
        String effectdt = request.getParameter("effectdt");
        effectdt = DateUtil.FormateDateSQL(effectdt);
        String increment = request.getParameter("increment");
        String[][] bas = CommonFunctions.QueryExecute("SELECT INT_SALARY FROM  com_m_staff  WHERE CHR_EMPID='" + staffid + "'");
        if ("".equals(increment) || "null".equals(increment))
          increment = "0"; 
        double basic = 0.0D;
        if (!bas[0][0].equals("-"))
          basic = Double.parseDouble(bas[0][0]); 
        int allowancelength = Integer.parseInt(request.getParameter("allowancelength"));
        int recoverylength = Integer.parseInt(request.getParameter("recoverylength"));
        String[][] rivisionid = CommonFunctions.QueryExecute("SELECT (MAX(INT_RIVISIONID)+1) FROM pay_t_rivision WHERE CHR_EMPID='" + staffid + "'");
        int rid = 0;
        if ("-".equals(rivisionid[0][0])) {
          rid = 1;
        } else {
          rid = Integer.parseInt(rivisionid[0][0]);
        } 
        String sql = " INSERT INTO pay_t_rivision ( CHR_EMPID,INT_RIVISIONID,";
        sql = String.valueOf(sql) + " INT_BASIC,INT_INCREMENT, DT_RIVISION,CHR_MONTH,INT_YEAR, ";
        int u;
        for (u = 1; u <= allowancelength; u++)
          sql = String.valueOf(sql) + request.getParameter("Aname" + u) + " , "; 
        for (u = 1; u <= recoverylength; u++)
          sql = String.valueOf(sql) + request.getParameter("Rname" + u) + " , "; 
        sql = String.valueOf(sql) + " DAT_EFFECT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (";
        sql = String.valueOf(sql) + "'" + staffid + "' ," + rid + " , ";
        sql = String.valueOf(sql) + basic + "  ," + Double.parseDouble(increment) + " , now(), monthname(now()), year(now()) , ";
        for (u = 1; u <= allowancelength; u++)
          sql = String.valueOf(sql) + " '" + request.getParameter("Alowance" + u) + "' , "; 
        for (u = 1; u <= recoverylength; u++)
          sql = String.valueOf(sql) + " '" + request.getParameter("Recovery" + u) + "' , "; 
        sql = String.valueOf(sql) + "'" + effectdt + "' , ";
        sql = String.valueOf(sql) + "'" + userId + "' , ";
        sql = String.valueOf(sql) + " now() , 'Y' )";
        System.out.println(sql);
        Statement st = con.createStatement();
        st.execute(sql);
        sql = "UPDATE  com_m_staff  SET INT_SALARY =?  WHERE CHR_EMPID = ?";
        apstm = con.prepareStatement(sql);
        apstm.setString(1,""+( basic + Double.parseDouble(increment)));
        apstm.setString(2, staffid);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        if (CommonInfo.RecordExist("SELECT count(*) FROM pay_t_allowance WHERE CHR_EMPID ='" + staffid + "'")) {
          sql = "UPDATE pay_t_allowance SET ";
          for (int i = 1; i <= allowancelength; i++)
            sql = String.valueOf(sql) + " " + request.getParameter("Aname" + i) + " = '" + request.getParameter("Alowance" + i) + "' , "; 
          sql = String.valueOf(sql) + " DAT_EFFECT='" + effectdt + "' ";
          sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "'";
          System.out.println(sql);
          st.execute(sql);
        } else {
          sql = " INSERT INTO pay_t_allowance ( CHR_EMPID,";
          int i;
          for (i = 1; i <= allowancelength; i++)
            sql = String.valueOf(sql) + " " + request.getParameter("Aname" + i) + " , "; 
          sql = String.valueOf(sql) + " DAT_EFFECT) VALUES (";
          sql = String.valueOf(sql) + " '" + staffid + "' ,";
          for (i = 1; i <= allowancelength; i++)
            sql = String.valueOf(sql) + " '" + request.getParameter("Alowance" + i) + "' , "; 
          sql = String.valueOf(sql) + "'" + effectdt + "') ";
          System.out.println(sql);
          st.execute(sql);
        } 
        if (CommonInfo.RecordExist("SELECT count(*) FROM pay_t_recovery WHERE CHR_EMPID ='" + staffid + "'")) {
          sql = "UPDATE pay_t_recovery SET ";
          for (int i = 1; i <= recoverylength; i++)
            sql = String.valueOf(sql) + " " + request.getParameter("Rname" + i) + " = '" + request.getParameter("Recovery" + i) + "' , "; 
          sql = String.valueOf(sql) + " DAT_EFFECT='" + effectdt + "' ";
          sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "'";
          System.out.println(sql);
          st.execute(sql);
        } else {
          sql = " INSERT INTO pay_t_recovery ( CHR_EMPID,";
          int i;
          for (i = 1; i <= recoverylength; i++)
            sql = String.valueOf(sql) + " " + request.getParameter("Rname" + i) + " , "; 
          sql = String.valueOf(sql) + " DAT_EFFECT) VALUES (";
          sql = String.valueOf(sql) + " '" + staffid + "' ,";
          for (i = 1; i <= recoverylength; i++)
            sql = String.valueOf(sql) + " '" + request.getParameter("Recovery" + i) + "' , "; 
          sql = String.valueOf(sql) + "'" + effectdt + "') ";
          System.out.println(sql);
          st.execute(sql);
        } 
        response.sendRedirect("Smart Payroll/AllowanceRecoveryRivisionConfirm.jsp?staffid=" + staffid);
      } else if ("PAYAllowanceRecoveryRivisionUpdate".equals(action)) {
        String staffid = request.getParameter("staffid");
        int allowancelength = Integer.parseInt(request.getParameter("allowancelength"));
        int recoverylength = Integer.parseInt(request.getParameter("recoverylength"));
        int maxid = Integer.parseInt(request.getParameter("maxid"));
        String increment = request.getParameter("increment");
        String q = " SELECT INT_BASIC FROM pay_t_rivision WHERE CHR_EMPID='" + staffid + "' AND INT_RIVISIONID =(SELECT MAX(INT_RIVISIONID) FROM pay_t_rivision WHERE CHR_EMPID='" + staffid + "')";
        String[][] bas = CommonFunctions.QueryExecute(q);
        if ("".equals(increment) || "null".equals(increment))
          increment = "0.0"; 
        double basic = 0.0D;
        if (!bas[0][0].equals("-"))
          basic = Double.parseDouble(bas[0][0]); 
        String sql = "UPDATE pay_t_rivision  SET  ";
        sql = String.valueOf(sql) + " DT_RIVISION= now(), CHR_MONTH=monthname(now()), INT_YEAR=year(now()) , ";
        sql = String.valueOf(sql) + " INT_INCREMENT = " + Double.parseDouble(increment) + " ,";
        int u;
        for (u = 1; u <= allowancelength; u++)
          sql = String.valueOf(sql) + " " + request.getParameter("Aname" + u) + " = '" + request.getParameter("Alowance" + u) + "' , "; 
        for (u = 1; u <= recoverylength; u++)
          sql = String.valueOf(sql) + " " + request.getParameter("Rname" + u) + " = '" + request.getParameter("Recovery" + u) + "' , "; 
        sql = String.valueOf(sql.substring(0, sql.trim().length() - 1)) + " ";
        sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "' AND INT_RIVISIONID=" + maxid;
        Statement st = con.createStatement();
        st.execute(sql);
        sql = "UPDATE pay_t_recovery SET ";
        int i;
        for (i = 1; i <= recoverylength; i++)
          sql = String.valueOf(sql) + " " + request.getParameter("Rname" + i) + " = '" + request.getParameter("Recovery" + i) + "' , "; 
        sql = sql.substring(0, sql.trim().length() - 1);
        sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "'";
        st.execute(sql);
        sql = "UPDATE pay_t_allowance SET ";
        for (i = 1; i <= allowancelength; i++)
          sql = String.valueOf(sql) + " " + request.getParameter("Aname" + i) + " = '" + request.getParameter("Alowance" + i) + "' , "; 
        sql = sql.substring(0, sql.trim().length() - 1);
        sql = String.valueOf(sql) + " WHERE CHR_EMPID ='" + staffid + "'";
        st.execute(sql);
        sql = "UPDATE  com_m_staff  SET INT_SALARY =" + (basic + Double.parseDouble(increment)) + " WHERE CHR_EMPID = '" + staffid + "'";
        st.execute(sql);
        con.close();
        response.sendRedirect("Smart Payroll/Rivision.jsp");
      } else if ("PAYStaffAllowanceRecoveryAddManual".equals(action)) {
        try {
          String staffid = request.getParameter("staffid");
          String effectdt = request.getParameter("effectdt");
          String flag = request.getParameter("flag");
          effectdt = DateUtil.FormateDateSQL(effectdt);
          String allowanceFields = collectAllowanceField();
          String recoveryFields = collectRecoveryField();
          String[] afields = allowanceFields.split("~");
          String[] rfields = recoveryFields.split("~");
          String reqallowancefields = "";
          String reqrecoveryfields = "";
          String asqlfalse = "";
          String rsqlfalse = "";
          String reqval = "";
          asqlfalse = "INSERT INTO pay_t_allowance VALUES ( '" + staffid + "' ,";
          reqallowancefields = "";
          int i;
          for (i = 0; i < afields.length; i++) {
            reqval = "";
            reqval = request.getParameter(afields[i]);
            if (reqval.equals("") || reqval.equals("null"))
              reqval = "0"; 
            reqallowancefields = String.valueOf(reqallowancefields) + "  '" + reqval + "' ,";
          } 
          reqallowancefields = String.valueOf(reqallowancefields) + "  '" + effectdt + "', '" + userId + "', DATE(NOW()),'Y' ,";
          reqallowancefields.trim();
          reqallowancefields = reqallowancefields.substring(0, reqallowancefields.length() - 1);
          asqlfalse = String.valueOf(asqlfalse) + reqallowancefields + " )";
          System.out.println("\n\nSatff Allowance" + asqlfalse);
          apstm = con.prepareStatement(asqlfalse);
          apstm.execute();
          apstm.close();
          rsqlfalse = "INSERT INTO PAY_T_RECOVERY VALUES ( '" + staffid + "' ,";
          reqrecoveryfields = "";
          for (i = 0; i < rfields.length; i++) {
            reqval = "";
            reqval = request.getParameter(rfields[i]);
            if (reqval.equals("") || reqval.equals("null"))
              reqval = "0"; 
            reqrecoveryfields = String.valueOf(reqrecoveryfields) + "  '" + reqval + "' ,";
          } 
          reqrecoveryfields = String.valueOf(reqrecoveryfields) + "  '" + effectdt + "',  '" + userId + "', DATE(NOW()),'Y' ,";
          reqrecoveryfields.trim();
          reqrecoveryfields = reqrecoveryfields.substring(0, reqrecoveryfields.length() - 1);
          rsqlfalse = String.valueOf(rsqlfalse) + reqrecoveryfields + " )";
          System.out.println("\n\nSatff Allowance" + rsqlfalse);
          apstm = con.prepareStatement(rsqlfalse);
          apstm.execute();
          apstm.close();
          if ("Y".equals(flag)) {
            asql = "UPDATE com_m_staff SET CHR_APPROVED = 'N' WHERE CHR_EMPID =?";
            apstm = con.prepareStatement(asql);
            apstm.setString(1, staffid);
            apstm.execute();
            apstm.close();
          } 
          response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
        } catch (Exception e) {
          System.out.println(e.getMessage());
          request.setAttribute("error", e.getMessage());
          RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
          dispatchers.forward((ServletRequest)request, (ServletResponse)response);
        } 
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  private void staffRegistrationPFESIUpdation(HttpServletRequest request) throws SQLException {
    String id = request.getParameter("id");
    String pf = request.getParameter("pf");
    String optpf = request.getParameter("optpf");
    String txtpfno = request.getParameter("txtpfno");
    String txtpfvalue = request.getParameter("txtpfvalue");
    String nominee = request.getParameter("nominee");
    String pfnomineerelationship = request.getParameter("pfnomineerelationship");
    String esi = request.getParameter("esi");
    String optesi = request.getParameter("optesi");
    String txtesno = request.getParameter("txtesno");
    String txtesivalue = request.getParameter("txtesivalue");
    String dispensary = request.getParameter("dispensary");
    String uannumber = request.getParameter("uannumber");
    String basic = request.getParameter("basic");
    String professionaltax = request.getParameter("professionaltax");
    if (uannumber.length() < 5)
      uannumber = null; 
    if (txtpfno.length() < 2)
      txtpfno = null; 
    if (txtesno.length() < 2)
      txtesno = null; 
    asql = " INSERT INTO com_m_staff_pf_esi_changes  ";
    asql = String.valueOf(asql) + " ( ";
    asql = String.valueOf(asql) + " CHR_EMPID,CHR_PF,CHR_PF_OLD,CHR_PFTYPE,CHR_PFTYPE_OLD, ";
    asql = String.valueOf(asql) + " INT_PFAMT,INT_PFAMT_OLD,CHR_PFNO,CHR_PFNO_OLD,CHR_NOMINEE,CHR_NOMINEE_OLD, ";
    asql = String.valueOf(asql) + " CHR_NOMINEE_RELATIONSHIP,CHR_NOMINEE_RELATIONSHIP_OLD,CHR_ESI,CHR_ESI_OLD, ";
    asql = String.valueOf(asql) + " CHR_ESITYPE,CHR_ESITYPE_OLD,INT_ESIAMT,INT_ESIAMT_OLD, ";
    asql = String.valueOf(asql) + " CHR_ESINO,CHR_ESINO_OLD,INT_PLACEID,INT_PLACEID_OLD, ";
    asql = String.valueOf(asql) + " CHR_USERNAME,DT_UPDATEDATE,CHR_USERSTATUS ";
    asql = String.valueOf(asql) + " ) ";
    asql = String.valueOf(asql) + " SELECT ";
    asql = String.valueOf(asql) + " CHR_EMPID,CHR_PF,'" + pf + "',CHR_PFTYPE,'" + optpf + "', ";
    asql = String.valueOf(asql) + " INT_PFAMT,'" + txtpfvalue + "',CHR_PFNO,'" + txtpfno + "',CHR_NOMINEE,'" + nominee + "', ";
    asql = String.valueOf(asql) + " CHR_NOMINEE_RELATIONSHIP,'" + pfnomineerelationship + "',CHR_ESI,'" + esi + "', ";
    asql = String.valueOf(asql) + " CHR_ESITYPE,'" + optesi + "',INT_ESIAMT,'" + txtesivalue + "', ";
    asql = String.valueOf(asql) + " CHR_ESINO,'" + txtesno + "',INT_PLACEID,'" + dispensary + "' ,";
    asql = String.valueOf(asql) + " UPPER('" + auserid + "') ,DATE(NOW()),'Y' ";
    asql = String.valueOf(asql) + " FROM com_m_staff WHERE CHR_EMPID =? ";
    apstm = con.prepareStatement(asql);
    apstm.setString(1, id);
    System.out.println(apstm);
    apstm.execute();
    apstm.close();
    asql = "UPDATE com_m_staff SET ";
    asql = String.valueOf(asql) + " CHR_PF=?,CHR_PFTYPE=?,CHR_PFNO=?,INT_PFAMT=?, CHR_NOMINEE=?,CHR_NOMINEE_RELATIONSHIP=?, ";
    asql = String.valueOf(asql) + " CHR_ESI=?,CHR_ESITYPE=?,CHR_ESINO=? ,INT_ESIAMT=?, INT_PLACEID=?,CHR_PF_UAN=?,CHR_PROFESSIONALTAX=?,INT_SALARY=? ";
    asql = String.valueOf(asql) + "  WHERE CHR_EMPID=? ";
    apstm = con.prepareStatement(asql);
    apstm.setString(1, pf);
    apstm.setString(2, optpf);
    apstm.setString(3, txtpfno);
    apstm.setString(4, txtpfvalue);
    apstm.setString(5, nominee);
    apstm.setString(6, pfnomineerelationship);
    apstm.setString(7, esi);
    apstm.setString(8, optesi);
    apstm.setString(9, txtesno);
    apstm.setString(10, txtesivalue);
    apstm.setString(11, dispensary);
    apstm.setString(12, uannumber);
    apstm.setString(13, professionaltax);
    apstm.setString(14, basic);
    apstm.setString(15, id);
    System.out.println(apstm);
    apstm.execute();
    apstm.close();
    con.close();
  }
}
