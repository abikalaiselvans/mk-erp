package com.my.org.erp.SmartConveyance;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import java.io.File;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class ConveyanceActionHandler extends AbstractActionHandler {
  public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS");
      HttpSession session = request.getSession();
      Object object1 = session.getAttribute("EMPID");
      Object object2 = session.getAttribute("USRID");
      String sql = "";
      String[][] cdata = CommonFunctions.QueryExecute("SELECT DOU_PETROL FROM m_institution  WHERE INT_ID=1");
      double price = Double.parseDouble(cdata[0][0]);
      if (action.equals("CONConveyanceAdd")) {
        String[] param = request.getParameter("param").split(",");
        String opendate = request.getParameter("opendate");
        sql = "SELECT count(*) FROM conveyance_t_conveyance WHERE CHR_EMPID='" + object1 + "' AND DAT_CONDATE='" + DateUtil.FormateDateSQL(opendate) + "'";
        String[][] data = CommonFunctions.QueryExecute(sql);
        int rcount = Integer.parseInt(data[0][0]);
        boolean fl = false;
        if (rcount > 0)
          fl = true; 
        opendate = DateUtil.FormateDateSQL(opendate);
        String division = request.getParameter("division");
        String repto = request.getParameter("repto");
        String f = request.getParameter("claimdatecheck");
        double t0 = 0.0D;
        double t1 = 0.0D;
        double t2 = 0.0D;
        double t3 = 0.0D;
        double t4 = 0.0D;
        double t5 = 0.0D;
        double t6 = 0.0D;
        double t7 = 0.0D;
        double t8 = 0.0D;
        if (!fl) {
          acs = con.prepareCall("{call CONVEYANCE_PRO_CONVEYANCE(?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,? ,?,?,?)}");
          for (int i = 0; i < param.length; i++) {
            t3 = 0.0D;
            t4 = 0.0D;
            t5 = 0.0D;
            t6 = 0.0D;
            t7 = 0.0D;
            t0 = 0.0D;
            String s0 = request.getParameter("from" + param[i]);
            String s1 = request.getParameter("to" + param[i]);
            String s2 = request.getParameter("km" + param[i]);
            String s3 = request.getParameter("busfare" + param[i]);
            String s4 = request.getParameter("autofare" + param[i]);
            String s5 = request.getParameter("lunch" + param[i]);
            String s6 = request.getParameter("telephone" + param[i]);
            String s7 = request.getParameter("otherdesc" + param[i]);
            String s8 = request.getParameter("otheramt" + param[i]);
            String s9 = request.getParameter("total" + param[i]);
            String s10 = request.getParameter("callid" + param[i]);
            t3 = Double.parseDouble(s3);
            t4 = Double.parseDouble(s4);
            t5 = Double.parseDouble(s5);
            t6 = Double.parseDouble(s6);
            t7 = Double.parseDouble(s8);
            t0 = t3 + t4 + t5 + t6 + t7 + Double.parseDouble(s2) * price;
            acs.setString(1, "INSERT");
            acs.setString(2, "");
            acs.setString(3, (String)object1);
            acs.setString(4, opendate);
            acs.setString(5, repto);
            acs.setString(6, division);
            acs.setString(7, s0);
            acs.setString(8, s1);
            acs.setString(9, s2);
            acs.setString(10, ""+Double.parseDouble(s2) * price);
            acs.setString(11, s3);
            acs.setString(12, s4);
            acs.setString(13, s5);
            acs.setString(14, s6);
            acs.setString(15, s7);
            acs.setString(16, s8);
            acs.setString(17, ""+t0);
            acs.setString(18, s10);
            acs.setString(19, (String)object2);
            acs.addBatch();
          } 
          acs.executeBatch();
          acs.close();
          con.close();
          response.sendRedirect("Smart Conveyance/ConveyanceAdd.jsp");
        } else {
          con.close();
          response.sendRedirect("Smart Conveyance/ConveyanceAdd.jsp?er=Already claim added this date " + request.getParameter("opendate"));
        } 
      } else if (action.equals("CONConveyanceDelete")) {
        String rowid = request.getParameter("id");
        String opendate = request.getParameter("opendate");
        String[] rows = request.getParameterValues("row");
        acs = con.prepareCall("{call CONVEYANCE_PRO_CONVEYANCE(?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,? ,?,?,?)}");
        for (int u = 0; u < rows.length; u++) {
          acs.setString(1, "DELETE");
          acs.setString(2, rows[u]);
          acs.setString(3, "");
          acs.setString(4, "");
          acs.setString(5, "");
          acs.setString(6, "");
          acs.setString(7, "");
          acs.setString(8, "");
          acs.setString(9, "");
          acs.setString(10, "");
          acs.setString(11, "");
          acs.setString(12, "");
          acs.setString(13, "");
          acs.setString(14, "");
          acs.setString(15, "");
          acs.setString(16, "");
          acs.setString(17, "");
          acs.setString(18, "");
          acs.setString(19, "");
          acs.addBatch();
        } 
        acs.executeBatch();
        acs.close();
        con.close();
        response.sendRedirect("Smart Conveyance/ConveyanceModify.jsp?opendate=" + opendate);
      } else if (action.equals("CONConveyancePayAccept")) {
        String[] rows = request.getParameterValues("accept");
        String paydate = request.getParameter("paydate");
        paydate = DateUtil.FormateDateSQL(paydate);
        sql = "UPDATE conveyance_t_conveyance SET CHR_ACCSTATUS=?, DAT_ACCDATE =? WHERE INT_CONID=?";
        apstm = con.prepareStatement(sql);
        for (int u = 0; u < rows.length; u++) {
          apstm.setString(1, "Y");
          apstm.setString(2, paydate);
          apstm.setString(3, rows[u]);
          apstm.addBatch();
        } 
        System.out.println(""+apstm);
        apstm.executeBatch();
        apstm.close();
        con.close();
        response.sendRedirect("Smart Conveyance/ConveyancesAdvanceDeduction.jsp?paydate=" + paydate);
      } else if (action.equals("INVStaffConveyanceAdd")) {
        String[] param = request.getParameter("param").split(",");
        String opendate = request.getParameter("opendate");
        sql = "SELECT count(*) FROM conveyance_t_conveyance WHERE CHR_EMPID='" + object1 + "' AND DAT_CONDATE='" + DateUtil.FormateDateSQL(opendate) + "'";
        String[][] data = CommonFunctions.QueryExecute(sql);
        int rcount = Integer.parseInt(data[0][0]);
        boolean fl = false;
        if (rcount > 0)
          fl = true; 
        opendate = DateUtil.FormateDateSQL(opendate);
        String division = request.getParameter("division");
        String repto = request.getParameter("repto");
        String f = request.getParameter("claimdatecheck");
        double t0 = 0.0D;
        double t1 = 0.0D;
        double t2 = 0.0D;
        double t3 = 0.0D;
        double t4 = 0.0D;
        double t5 = 0.0D;
        double t6 = 0.0D;
        double t7 = 0.0D;
        double t8 = 0.0D;
        if (!fl) {
          acs = con.prepareCall("{call CONVEYANCE_PRO_CONVEYANCE(?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,? ,?,?,?)}");
          for (int i = 0; i < param.length; i++) {
            t3 = 0.0D;
            t4 = 0.0D;
            t5 = 0.0D;
            t6 = 0.0D;
            t7 = 0.0D;
            t0 = 0.0D;
            String s0 = request.getParameter("from" + param[i]);
            String s1 = request.getParameter("to" + param[i]);
            String s2 = request.getParameter("km" + param[i]);
            String s3 = request.getParameter("busfare" + param[i]);
            String s4 = request.getParameter("autofare" + param[i]);
            String s5 = request.getParameter("lunch" + param[i]);
            String s6 = request.getParameter("telephone" + param[i]);
            String s7 = request.getParameter("otherdesc" + param[i]);
            String s8 = request.getParameter("otheramt" + param[i]);
            String s9 = request.getParameter("total" + param[i]);
            String s10 = request.getParameter("callid" + param[i]);
            t3 = Double.parseDouble(s3);
            t4 = Double.parseDouble(s4);
            t5 = Double.parseDouble(s5);
            t6 = Double.parseDouble(s6);
            t7 = Double.parseDouble(s8);
            t0 = t3 + t4 + t5 + t6 + t7 + Double.parseDouble(s2) * price;
            acs.setString(1, "INSERT");
            acs.setString(2, "");
            acs.setString(3, (String)object1);
            acs.setString(4, opendate);
            acs.setString(5, repto);
            acs.setString(6, division);
            acs.setString(7, s0);
            acs.setString(8, s1);
            acs.setString(9, s2);
            acs.setString(10, ""+Double.parseDouble(s2) * price);
            acs.setString(11, s3);
            acs.setString(12, s4);
            acs.setString(13, s5);
            acs.setString(14, s6);
            acs.setString(15, s7);
            acs.setString(16, s8);
            acs.setString(17, ""+t0);
            acs.setString(18, s10);
            acs.setString(19, (String)object2);
            acs.addBatch();
          } 
          acs.executeBatch();
          acs.close();
          con.close();
          response.sendRedirect("Staff/ConveyanceAdd.jsp");
        } else {
          con.close();
          response.sendRedirect("Staff/ConveyanceAdd.jsp?er=Already claim added this date " + request.getParameter("opendate"));
        } 
      } else if (action.equals("INVConveyanceStaffDelete")) {
        String rowid = request.getParameter("id");
        String opendate = request.getParameter("opendate");
        String[] rows = request.getParameterValues("row");
        for (int u = 0; u < rows.length; u++) {
          sql = "Delete from conveyance_t_conveyance WHERE INT_CONID=" + rows[u];
          Statement ts = con.createStatement();
          ts.execute(sql);
          ts.close();
        } 
        con.close();
        response.sendRedirect("Staff/ConveyanceModify.jsp?opendate=" + opendate);
      } else if (action.equals("INVConveyanceStaffEdit")) {
        try {
          String rowid = request.getParameter("id").trim();
          String from = request.getParameter("from").trim();
          String to = request.getParameter("to").trim();
          String kms = request.getParameter("km").trim();
          double km = Double.parseDouble(kms);
          String kmamount = request.getParameter("kmamount").trim();
          String train = request.getParameter("train").trim();
          String auto = request.getParameter("auto").trim();
          String lunch = request.getParameter("lunch").trim();
          String telephone = request.getParameter("telephone").trim();
          String otherdesc = request.getParameter("otherdesc").trim();
          String otheramt = request.getParameter("otheramt").trim();
          String total = request.getParameter("total").trim();
          String callid = request.getParameter("callid").trim();
          String reentry = request.getParameter("reentry").trim();
          sql = "UPDATE conveyance_t_conveyance  SET  DAT_MODIFIED_TIME =NOW() , ";
          sql = String.valueOf(sql) + " CHR_FROM =? , ";
          sql = String.valueOf(sql) + " CHR_TO =? , ";
          sql = String.valueOf(sql) + " DOU_KM =? , ";
          sql = String.valueOf(sql) + " DOU_TRAVEL =? , ";
          sql = String.valueOf(sql) + " DOU_TRAIN =? , ";
          sql = String.valueOf(sql) + " DOU_AUTO =? , ";
          sql = String.valueOf(sql) + " DOU_LUNCH =? , ";
          sql = String.valueOf(sql) + " DOU_TELEPHONE =? , ";
          sql = String.valueOf(sql) + " CHR_OTHERDESC =? , ";
          sql = String.valueOf(sql) + " DOU_OTHERAMT =? , ";
          sql = String.valueOf(sql) + " DOU_TOTAL =? , ";
          sql = String.valueOf(sql) + " CHR_USRNAME =?, ";
          sql = String.valueOf(sql) + " CHR_CALLID =? ,CHR_STATUS='N', CHR_ACCEPT='N' ,";
          if ("R".equals(reentry))
            sql = String.valueOf(sql) + " CHR_REENTRY='Y' ,"; 
          sql = String.valueOf(sql) + " DT_UPDATEDATE =now() ,CHR_UPDATESTATUS ='Y' ";
          sql = String.valueOf(sql) + " WHERE INT_CONID=?";
          apstm = con.prepareStatement(sql);
          apstm.setString(1, from);
          apstm.setString(2, to);
          apstm.setString(3, ""+km);
          apstm.setString(4, ""+(km * price));
          apstm.setString(5, ""+Double.parseDouble(train));
          apstm.setString(6, ""+Double.parseDouble(auto));
          apstm.setString(7, ""+Double.parseDouble(lunch));
          apstm.setString(8, ""+Double.parseDouble(telephone));
          apstm.setString(9, otherdesc);
          apstm.setString(10, ""+Double.parseDouble(otheramt));
          apstm.setString(11, ""+Double.parseDouble(total));
          apstm.setString(12, (String)object2);
          apstm.setString(13, callid);
          apstm.setString(14, rowid);
          apstm.execute();
          apstm.close();
          con.close();
          response.sendRedirect("Staff/Userframe.jsp");
        } catch (RuntimeException e) {
          System.out.println(e.getMessage());
        } 
      } else if (action.equals("INVConveyanceStaffAccept")) {
        String length = request.getParameter("dec");
        String accept = "";
        String reject = "";
        String rejectdec = "";
        String hiddenField = "";
        sql = "";
        for (int u = 0; u < Integer.parseInt(length); u++) {
          sql = "";
          accept = request.getParameter("accept" + u);
          reject = request.getParameter("reject" + u);
          rejectdec = request.getParameter("dec" + u);
          hiddenField = request.getParameter("hiddenField" + u);
          if ("on".equals(accept))
            sql = " UPDATE conveyance_t_conveyance  SET  DAT_APPROVAL_TIME=NOW(), CHR_STATUS ='Y',CHR_ACCEPT ='Y'  WHERE INT_CONID=" + hiddenField; 
          if ("on".equals(reject))
            sql = " UPDATE conveyance_t_conveyance  SET   DAT_APPROVAL_TIME=NOW(), CHR_STATUS ='R' , CHR_ACCEPT ='R' ,CHR_DESC ='" + rejectdec + "'" + " WHERE INT_CONID=" + hiddenField; 
          sql = sql.trim();
          if (sql.length() > 10) {
            Statement st = con.createStatement();
            st.execute(sql);
            st.close();
          } 
        } 
        con.close();
        response.sendRedirect("Staff/StaffConveyanceview.jsp");
      } else if (action.equals("CONConveyanceEdit")) {
        try {
          String rowid = request.getParameter("id").trim();
          String from = request.getParameter("from").trim();
          String to = request.getParameter("to").trim();
          String kms = request.getParameter("km").trim();
          double km = Double.parseDouble(kms);
          String kmamount = request.getParameter("kmamount").trim();
          String train = request.getParameter("train").trim();
          String auto = request.getParameter("auto").trim();
          String lunch = request.getParameter("lunch").trim();
          String telephone = request.getParameter("telephone").trim();
          String otherdesc = request.getParameter("otherdesc").trim();
          String otheramt = request.getParameter("otheramt").trim();
          String total = request.getParameter("total").trim();
          String callid = request.getParameter("callid").trim();
          String reentry = request.getParameter("reentry").trim();
          sql = "UPDATE conveyance_t_conveyance  SET   DAT_MODIFIED_TIME = NOW() , ";
          sql = String.valueOf(sql) + " CHR_FROM =? , ";
          sql = String.valueOf(sql) + " CHR_TO =? , ";
          sql = String.valueOf(sql) + " DOU_KM =? , ";
          sql = String.valueOf(sql) + " DOU_TRAVEL =? , ";
          sql = String.valueOf(sql) + " DOU_TRAIN =? , ";
          sql = String.valueOf(sql) + " DOU_AUTO =? , ";
          sql = String.valueOf(sql) + " DOU_LUNCH =? , ";
          sql = String.valueOf(sql) + " DOU_TELEPHONE =? , ";
          sql = String.valueOf(sql) + " CHR_OTHERDESC =? , ";
          sql = String.valueOf(sql) + " DOU_OTHERAMT =? , ";
          sql = String.valueOf(sql) + " DOU_TOTAL =? , ";
          sql = String.valueOf(sql) + " CHR_USRNAME =?, ";
          sql = String.valueOf(sql) + " CHR_CALLID =? ,CHR_STATUS='N', CHR_ACCEPT='N',";
          if ("R".equals(reentry))
            sql = String.valueOf(sql) + " CHR_REENTRY='Y' ,"; 
          sql = String.valueOf(sql) + " DT_UPDATEDATE =now() ,CHR_UPDATESTATUS ='Y' ";
          sql = String.valueOf(sql) + " WHERE INT_CONID=?";
          apstm = con.prepareStatement(sql);
          apstm.setString(1, from);
          apstm.setString(2, to);
          apstm.setString(3, ""+km);
          apstm.setString(4,""+( km * price));
          apstm.setString(5, ""+Double.parseDouble(train));
          apstm.setString(6, ""+Double.parseDouble(auto));
          apstm.setString(7, ""+Double.parseDouble(lunch));
          apstm.setString(8, ""+Double.parseDouble(telephone));
          apstm.setString(9, otherdesc);
          apstm.setString(10, ""+Double.parseDouble(otheramt));
          apstm.setString(11,""+ Double.parseDouble(total));
          apstm.setString(12, (String)object2);
          apstm.setString(13, callid);
          apstm.setString(14, rowid);
          apstm.execute();
          apstm.close();
          con.close();
          response.sendRedirect("Smart Inventory/Userframe.jsp");
        } catch (RuntimeException e) {
          System.out.println(e.getMessage());
        } 
      } else if (action.equals("CONConveyanceVerification")) {
        try {
          String length = request.getParameter("dec");
          String employeekm = "employeekm";
          String approverkm = "approverkm";
          String employee = request.getParameter("empid");
          String fromdate = request.getParameter("fromdate");
          String todate = request.getParameter("todate");
          System.out.println(fromdate);
          fromdate = DateUtil.FormateDateSys(fromdate);
          todate = DateUtil.FormateDateSys(todate);
          System.out.println(fromdate);
          String redirect = "Conveyanceaccept.jsp?empid=" + employee + "&fromdate=" + fromdate + "&todate=" + todate;
          sql = "";
          String rowid = "";
          boolean flag = false;
          double travel = 0.0D;
          for (int u = 0; u < Integer.parseInt(length); u++) {
            sql = "";
            travel = 0.0D;
            rowid = request.getParameter("rowid" + u);
            employeekm = request.getParameter("employeekm" + u);
            approverkm = request.getParameter("approverkm" + u);
            if (!employeekm.equals(approverkm)) {
              travel = price * Double.parseDouble(approverkm);
              System.out.println(String.valueOf(employeekm) + "/" + approverkm);
              sql = " UPDATE conveyance_t_conveyance  SET  DOU_KM=?, CHR_FLAG=?, DOU_EMP_KM=? , DOU_TRAVEL=?  WHERE INT_CONID = ? ";
              apstm = con.prepareStatement(sql);
              apstm.setString(1, approverkm);
              apstm.setString(2, "Y");
              apstm.setString(3, employeekm);
              apstm.setString(4, ""+Double.parseDouble(approverkm) * price);
              apstm.setString(5, rowid);
              apstm.execute();
              apstm.close();
              sql = " UPDATE conveyance_t_conveyance  SET  DOU_TOTAL = (DOU_TRAVEL + DOU_TRAIN + DOU_AUTO + DOU_LUNCH + DOU_TELEPHONE + DOU_OTHERAMT)   WHERE INT_CONID = ? ";
              apstm = con.prepareStatement(sql);
              apstm.setString(1, rowid);
              apstm.execute();
              apstm.close();
            } 
          } 
          con.close();
          response.sendRedirect("Smart Conveyance/" + redirect);
        } catch (Exception e) {
          con.close();
          System.out.println(e.getMessage());
          e.printStackTrace();
        } 
      } else if (action.equals("CONConveyanceAccept")) {
        try {
          String length = request.getParameter("dec");
          String accept = "";
          String reject = "";
          String rejectdec = "";
          String hiddenField = "";
          sql = "";
          for (int u = 0; u < Integer.parseInt(length); u++) {
            sql = "";
            accept = request.getParameter("accept" + u);
            reject = request.getParameter("reject" + u);
            rejectdec = request.getParameter("dec" + u);
            hiddenField = request.getParameter("hiddenField" + u);
            if ("on".equals(accept) || "on".equals(reject)) {
              if ("on".equals(accept))
                sql = " UPDATE conveyance_t_conveyance  SET   DAT_APPROVAL_TIME=NOW(), CHR_STATUS ='Y',CHR_ACCEPT ='Y'  WHERE INT_CONID=" + hiddenField; 
              if ("on".equals(reject))
                sql = " UPDATE conveyance_t_conveyance  SET   DAT_APPROVAL_TIME=NOW(), CHR_STATUS ='R' , CHR_ACCEPT ='R' ,CHR_DESC ='" + rejectdec + "'" + " WHERE INT_CONID=" + hiddenField; 
              sql = sql.trim();
              CommonFunctions.Execute(sql);
            } 
          } 
          con.close();
          response.sendRedirect("Smart Conveyance/Conveyanceview.jsp");
        } catch (Exception e) {
          System.out.println(e.getMessage());
          e.printStackTrace();
        } 
      } else if (action.equals("CONConveyanceDisapprove")) {
        String length = request.getParameter("dec");
        String accept = "";
        String hiddenField = "";
        sql = "";
        sql = "UPDATE conveyance_t_conveyance SET  DAT_APPROVAL_TIME=null, CHR_STATUS =?,CHR_ACCEPT =? WHERE INT_CONID=?";
        apstm = con.prepareStatement(sql);
        for (int u = 0; u < Integer.parseInt(length); u++) {
          accept = request.getParameter("accept" + u);
          hiddenField = request.getParameter("hiddenField" + u);
          if ("on".equals(accept)) {
            apstm.setString(1, "N");
            apstm.setString(2, "N");
            apstm.setString(3, hiddenField);
            apstm.addBatch();
          } 
        } 
        apstm.executeBatch();
        apstm.close();
        con.close();
        response.sendRedirect("Smart Conveyance/Conveyanceview.jsp");
      } else if ("CONConveyanceClearing".equals(action)) {
        String paiddate = request.getParameter("paiddate");
        String clearingdate = request.getParameter("clearingdate");
        String creditto = request.getParameter("creditto");
        String bank = request.getParameter("bank");
        String descriptions = request.getParameter("descriptions");
        sql = "UPDATE conveyance_t_conveyance SET DAT_CLEARINGDATE =?,CHR_CLEARING_DESC =? , INT_BANKID=? WHERE DAT_ACCDATE=?  AND DAT_CLEARINGDATE IS NULL ";
        apstm = con.prepareStatement(sql);
        apstm.setString(1, DateUtil.FormateDateSQL(clearingdate));
        apstm.setString(2, descriptions);
        apstm.setString(3, creditto);
        apstm.setString(4, DateUtil.FormateDateSQL(paiddate));
        apstm.execute();
        apstm.close();
        con.close();
        response.sendRedirect("Smart Conveyance/Conveyancemain.jsp");
      } else if (action.equals("CONConveyanceAddUploadedExcel")) {
        String filename = request.getParameter("xlsfilename");
        String filepath = String.valueOf(request.getRealPath("/")) + "/uploadfiles/conveyance/" + filename + ".xls";
        readFromExcel((String)object1, (String)object2, filepath, acs, con);
        con.close();
        response.sendRedirect("Smart Common/exit.jsp");
      } 
    } catch (Exception e) {
      response.sendRedirect("error/index.jsp?error=" + e.getMessage());
      System.out.println(e.getMessage());
    } 
  }
  
  public static void readFromExcel(String empid, String userid, String file, CallableStatement acs, Connection con) throws IOException, ClassNotFoundException {
    try {
      Workbook wb = WorkbookFactory.create(new File(file));
      Sheet sheet = wb.getSheetAt(0);
      DataFormatter df = new DataFormatter();
      Row row1 = sheet.getRow(0);
      int rowcount = 0;
      String opendate = "", From = "", To = "", CallNumber = "", OthersDesc = "";
      double NoofKms = 0.0D, TrainFare = 0.0D, AutoFare = 0.0D, Lunch = 0.0D, Telephone = 0.0D, OthersAmt = 0.0D, total = 0.0D;
      String[][] cdata = CommonFunctions.QueryExecute("SELECT DOU_PETROL FROM m_institution  WHERE INT_ID=1");
      String repto = CommonFunctions.QueryExecute("SELECT CHR_REPTO from com_m_staff where CHR_EMPID='" + empid + "'")[0][0];
      double price = Double.parseDouble(cdata[0][0]);
      String value = "";
      for (Row row : sheet) {
        if (rowcount > 0) {
          for (Cell cell : row)
            value = String.valueOf(value) + cell + "kalai,"; 
          value = String.valueOf(value) + "~";
        } 
        rowcount++;
      } 
      acs = con.prepareCall("{call CONVEYANCE_PRO_CONVEYANCE(?,?,?,?,?,?,? ,?,?,?,?,?,?,?,?,? ,?,?,?)}");
      String[] rowdata = value.split("~");
      byte b;
      int i;
      String[] arrayOfString1;
      for (i = (arrayOfString1 = rowdata).length, b = 0; b < i; ) {
        String rowvalue = arrayOfString1[b];
        String[] columndata = rowvalue.split("kalai,");
        String[] excelopendate = columndata[0].split("-");
        opendate = String.valueOf(excelopendate[2]) + "-" + DateUtil.getMonthNumbers(excelopendate[1]) + "-" + excelopendate[0];
        System.out.println(opendate);
        From = columndata[1];
        To = columndata[2];
        NoofKms = Double.parseDouble(columndata[3]);
        CallNumber = columndata[4];
        TrainFare = Double.parseDouble(columndata[5]);
        AutoFare = Double.parseDouble(columndata[6]);
        Lunch = Double.parseDouble(columndata[7]);
        Telephone = Double.parseDouble(columndata[8]);
        OthersDesc = columndata[9];
        OthersAmt = Double.parseDouble(columndata[10]);
        acs.setString(1, "INSERT");
        acs.setString(2, "");
        acs.setString(3, empid);
        acs.setString(4, opendate);
        acs.setString(5, repto);
        acs.setString(6, "1");
        acs.setString(7, From);
        acs.setString(8, To);
        acs.setString(9, ""+NoofKms);
        acs.setString(10, ""+(NoofKms * price));
        acs.setString(11, ""+TrainFare);
        acs.setString(12, ""+AutoFare);
        acs.setString(13, ""+Lunch);
        acs.setString(14, ""+Telephone);
        acs.setString(15, OthersDesc);
        acs.setString(16, ""+OthersAmt);
        total = NoofKms * price + TrainFare + AutoFare + Lunch + Telephone + OthersAmt;
        acs.setString(17, ""+total);
        acs.setString(18, CallNumber);
        acs.setString(19, userid);
        acs.addBatch();
        System.out.print(acs + "\n");
        b++;
      } 
      acs.executeBatch();
      acs.close();
      con.close();
    } catch (Exception e) {
      e.printStackTrace();
    } 
  }
}
