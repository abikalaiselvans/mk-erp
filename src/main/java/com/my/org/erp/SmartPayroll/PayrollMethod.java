package com.my.org.erp.SmartPayroll;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PayrollMethod extends HttpServlet {
  public static void loadAllowances(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_ALLOWANCEID,CHR_ACODE,UPPER(CHR_ANAME),if(CHR_FLAG='Y','YES','NO'),CHR_MONTHFLAG,CHR_BONUS FROM  pay_m_allowance WHERE INT_ALLOWANCEID>0 ";
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND CHR_ANAME LIKE '" + startLetter + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY CHR_ANAME ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + datas[u][0] + "</Id>");
          sb.append("<Code>" + datas[u][1] + "</Code>");
          sb.append("<Name>" + datas[u][2].replaceAll("&", " AND ") + "</Name>");
          sb.append("<Flag>" + datas[u][3] + "</Flag>");
          sb.append("<Monthflag>" + datas[u][4] + "</Monthflag>");
          sb.append("<Bonus>" + datas[u][5] + "</Bonus>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadRecoverys(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_RECOVERYID,CHR_RCODE,CHR_RNAME,CHR_MONTHFLAG FROM pay_m_recovery WHERE INT_RECOVERYID>0 ";
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND CHR_RNAME LIKE '" + startLetter + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY CHR_RNAME ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + datas[u][0] + "</Id>");
          sb.append("<Code>" + datas[u][1] + "</Code>");
          sb.append("<Name>" + datas[u][2].replaceAll("&", " AND ") + "</Name>");
          sb.append("<Monthflag>" + datas[u][3] + "</Monthflag>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadPFwages(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT,INT_ESILIMIT,IF(CHR_STATUS='Y','Active','Inactive') FROM m_pf_setting   ";
      sql = String.valueOf(sql) + " ORDER BY INT_ROWID ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + datas[u][0] + "</Rowid>");
          sb.append("<PFMini>" + datas[u][1] + "</PFMini>");
          sb.append("<PFMaxi>" + datas[u][2].replaceAll("&", " AND ") + "</PFMaxi>");
          sb.append("<ESILimit>" + datas[u][3] + "</ESILimit>");
          sb.append("<Status>" + datas[u][4] + "</Status>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYRivision(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String Office = request.getParameter("Office");
      String month = DateUtil.getMonth(Integer.parseInt(request.getParameter("month")));
      String year = request.getParameter("year");
      String sql = "";
      String status = "";
      String off = "";
      if (!"0".equals(Office))
        off = " AND A.INT_OFFICEID=" + Office; 
      if (!"0".equals(startLetter)) {
        status = " AND A.CHR_STAFFNAME LIKE'" + startLetter + "%'   group by F.CHR_EMPID order by A.CHR_EMPID ";
      } else {
        status = "   group by F.CHR_EMPID order by A.CHR_EMPID ";
      } 
      sql = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.CHR_MOBILE  ,E.CHR_COMPANYNAME,F.DAT_EFFECT from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E , pay_t_rivision F \twhere A.INT_BRANCHID=B.INT_BRANCHID\tAND A.INT_COMPANYID =  E.INT_COMPANYID \tAND A.INT_DEPARTID=C.INT_DEPARTID ";
      sql = String.valueOf(sql) + "  " + off + " AND A.INT_DESIGID=D.INT_DESIGID AND A.CHR_EMPID = F.CHR_EMPID AND monthname(F.DAT_EFFECT)='" + month + "' AND year(F.DAT_EFFECT)=" + year + " " + status;
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Rivisio>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<Effect>" + datas[u][7] + "</Effect>");
          sql = " select max(INT_RIVISIONID) from pay_t_rivision  where CHR_EMPID ='" + datas[u][0] + "'";
          String[][] rid = CommonFunctions.QueryExecute(sql);
          sb.append("<Rivision>" + rid[0][0] + "</Rivision>");
          sb.append("</Rivisio>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rivisions>" + sb.toString() + "</Rivisions>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYAdvance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String off = request.getParameter("Office");
      String sql = "";
      String status = "";
      String offid = "";
      if (!"0".equals(off))
        offid = " AND A.INT_OFFICEID =" + off; 
      if (!"0".equals(startLetter)) {
        status = " AND A.CHR_STAFFNAME LIKE'" + startLetter + "%' group by B.CHR_EMPID ";
      } else {
        status = "   group by B.CHR_EMPID ";
      } 
      sql = " SELECT  B.CHR_EMPID, A.CHR_STAFFNAME FROM pay_m_advance B, com_m_staff  A ";
      sql = String.valueOf(sql) + " \twhere  B.CHR_EMPID=A.CHR_EMPID \tAND A.CHR_TYPE!='Y' AND A.CHR_HOLD != 'Y' " + offid + status;
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      double advance = 0.0D;
      double dtection = 0.0D;
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          advance = 0.0D;
          dtection = 0.0D;
          sql = "SELECT count(*) FROM pay_m_advance WHERE CHR_EMPID='" + datas[u][0] + "' ";
          if (CommonFunction.RecordExist(sql)) {
            sql = "SELECT sum(INT_ADVAMT) FROM pay_m_advance WHERE CHR_EMPID='" + datas[u][0] + "' ";
            String[][] advdata = CommonFunction.RecordSetArray(sql);
            advance = Double.parseDouble(advdata[0][0]);
            sql = "SELECT sum(INT_DUEAMT) FROM pay_t_advance WHERE CHR_EMPID='" + datas[u][0] + "' ";
            String[][] detectdata = CommonFunction.doubleRecordSetArray(sql);
            dtection = Double.parseDouble(detectdata[0][0]);
            if (Math.round(advance - dtection) != 0L) {
              sb.append("<Advance>");
              sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
              sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
              sb.append("<Balance>" + Math.round(advance - dtection) + "</Balance>");
              sb.append("</Advance>");
            } 
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Advances>" + sb.toString() + "</Advances>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYMess(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String month = DateUtil.getMonth(Integer.parseInt(request.getParameter("month")));
      String year = request.getParameter("year");
      String sql = "";
      String status = "";
      if (!"0".equals(startLetter)) {
        status = " AND A.CHR_STAFFNAME LIKE'" + startLetter + "%' group by F.CHR_EMPID order by A.CHR_EMPID ";
      } else {
        status = "   order by A.CHR_EMPID ";
      } 
      sql = " SELECT  A.CHR_EMPID,";
      sql = String.valueOf(sql) + " A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME, ";
      sql = String.valueOf(sql) + " E.CHR_COMPANYNAME,F.INT_CASHAMT from  com_m_staff  A, com_m_branch  B, ";
      sql = String.valueOf(sql) + "   com_m_depart   C, com_m_desig  D, com_m_company  E ,pay_m_messbill F ";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID ";
      sql = String.valueOf(sql) + " AND A.CHR_EMPID=F.CHR_EMPID and F.CHR_MONTH='" + month + "' AND F.INT_YEAR='" + year + "'" + status;
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Mess>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<MessAmt>" + datas[u][6] + "</MessAmt>");
          sb.append("</Mess>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Messes>" + sb.toString() + "</Messes>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYTransfer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String type = request.getParameter("type");
      String sql = "";
      sql = " SELECT  A.CHR_EMPID,";
      sql = String.valueOf(sql) + " A.CHR_STAFFNAME,E.CHR_COMPANYNAME, B.CHR_BRANCHNAME,D.CHR_DESIGNAME,C.CHR_DEPARTNAME, ";
      sql = String.valueOf(sql) + " (SELECT COUNT(*) FROM pay_m_emp_transfer F WHERE A.CHR_EMPID=F.CHR_EMPID )  from  com_m_staff  A, com_m_branch  B, ";
      sql = String.valueOf(sql) + "   com_m_depart   C, com_m_desig  D, com_m_company  E  ";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID  ";
      sql = String.valueOf(sql) + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' ";
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + "  AND A.CHR_STAFFNAME LIKE '" + startLetter + "%'  "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( (A.CHR_STAFFNAME LIKE '%" + startLetter.trim() + "%' ) OR (A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY  A.CHR_EMPID ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Transfer>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Desig>" + datas[u][4] + "</Desig>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<NoofTransfer>" + datas[u][6] + "</NoofTransfer>");
          sb.append("</Transfer>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Transfers>" + sb.toString() + "</Transfers>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYPayrollRevision(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String sql = "";
      sql = String.valueOf(sql) + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,DATE_FORMAT(a.DAT_RIVISION,'%d-%b-%Y'),  ";
      sql = String.valueOf(sql) + " (SELECT COUNT(*) FROM pay_t_appraisal h WHERE h.CHR_EMPID=a.CHR_EMPID)  ";
      sql = String.valueOf(sql) + " FROM com_m_staff a  ,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,com_m_desig f ,com_m_employeecategory g";
      sql = String.valueOf(sql) + " WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND a.INT_OFFICEID = d.INT_OFFICEID ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID = e.INT_DEPARTID ";
      sql = String.valueOf(sql) + " AND a.INT_DESIGID = f.INT_DESIGID  AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND  MONTH(a.DAT_RIVISION) =" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(a.DAT_RIVISION) =" + year; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + "  AND a.CHR_STAFFNAME LIKE '" + startLetter + "%'  "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( (a.CHR_STAFFNAME LIKE '%" + startLetter.trim() + "%' ) OR (a.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Revision>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Office>" + datas[u][4] + "</Office>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<Cat>" + datas[u][7] + "</Cat>");
          sb.append("<DOJ>" + datas[u][8] + "</DOJ>");
          sb.append("<DOR>" + datas[u][9] + "</DOR>");
          sb.append("<NoofRevision>" + datas[u][10] + "</NoofRevision>");
          sb.append("</Revision>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Revisions>" + sb.toString() + "</Revisions>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadPayrollRevisionAccep(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String status = request.getParameter("status");
      String sql = "";
      sql = String.valueOf(sql) + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') ,DATE_FORMAT(a.DAT_RIVISION,'%d-%b-%Y'),  ";
      sql = String.valueOf(sql) + " h.CHR_ACCEPT,h.INT_APPRAISALID  ";
      sql = String.valueOf(sql) + " FROM com_m_staff a  ,com_m_company b,com_m_branch c, com_m_office d,com_m_depart e,";
      sql = String.valueOf(sql) + " com_m_desig f ,com_m_employeecategory g,pay_t_appraisal h , pay_t_appraisal_basic i";
      sql = String.valueOf(sql) + " WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND a.INT_OFFICEID = d.INT_OFFICEID ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID = e.INT_DEPARTID ";
      sql = String.valueOf(sql) + " AND a.INT_DESIGID = f.INT_DESIGID  AND h.INT_APPRAISALID = i.INT_APPRAISALID ";
      sql = String.valueOf(sql) + " AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID ";
      sql = String.valueOf(sql) + " AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID = h.CHR_EMPID AND a.CHR_EMPID = i.CHR_EMPID ";
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND   h.CHR_ACCEPT  = '" + status + "' "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND  MONTH(h.DAT_DOR) =" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(h.DAT_DOR) =" + year; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + "  AND a.CHR_STAFFNAME LIKE '" + startLetter + "%'  "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( (a.CHR_STAFFNAME LIKE '%" + startLetter.trim() + "%' ) OR (a.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " GROUP BY a.CHR_EMPID,h.INT_APPRAISALID ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Revision>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Office>" + datas[u][4] + "</Office>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<Cat>" + datas[u][7] + "</Cat>");
          sb.append("<DOJ>" + datas[u][8] + "</DOJ>");
          sb.append("<DOR>" + datas[u][9] + "</DOR>");
          sb.append("<Accept>" + datas[u][10] + "</Accept>");
          sb.append("<Apparaisalid>" + datas[u][11] + "</Apparaisalid>");
          sb.append("</Revision>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Revisions>" + sb.toString() + "</Revisions>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYPromotion(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,";
      sql = String.valueOf(sql) + " (SELECT COUNT(*) FROM pay_m_emp_promotion F WHERE A.CHR_EMPID=F.CHR_EMPID )  from  com_m_staff  A, com_m_branch  B, ";
      sql = String.valueOf(sql) + "   com_m_depart   C, com_m_desig  D, com_m_company  E ";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID=E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID ";
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + "  AND A.CHR_STAFFNAME LIKE'" + startLetter + "%'   "; 
      sql = String.valueOf(sql) + "    order by A.CHR_EMPID ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Promotion>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<NoofPromotion>" + datas[u][6] + "</NoofPromotion>");
          sb.append("</Promotion>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Promotions>" + sb.toString() + "</Promotions>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYCessation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String mode = request.getParameter("mode");
      String startLetter = request.getParameter("startLetter");
      String type = request.getParameter("type");
      String ndc = request.getParameter("ndc");
      String exitinterview = request.getParameter("exitinterview");
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USERTYPE");
      String sql = "";
      sql = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME, ";
      sql = String.valueOf(sql) + " B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME ,DATE_FORMAT(F.DT_TERM_DATE,'%d-%b-%Y'), DATE_FORMAT(F.DAT_PFRESIGNDATE,'%d-%b-%Y'),F.CHR_REASON ";
      sql = String.valueOf(sql) + " ,G.CHR_FINAL,H.CHR_STATUS ,(10+FIND_A_PERFORM_CESSATION(A.CHR_EMPID)),DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y'),G.CHR_ISSUE,F.CHR_TER_TYPE,";
      sql = String.valueOf(sql) + " IF(F.CHR_MODE ='D','Direct',IF(F.CHR_MODE='S','Suspension','Resigination Post')) ";
      sql = String.valueOf(sql) + " from  com_m_staff  A, com_m_branch  B,   ";
      sql = String.valueOf(sql) + " com_m_depart   C, com_m_desig  D, com_m_company  E  ,pay_m_emp_termination F, pay_t_emp_ndc G ,pay_t_exitinterview H";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =E.INT_COMPANYID   ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID   ";
      sql = String.valueOf(sql) + " AND A.CHR_EMPID = F.CHR_EMPID   AND A.CHR_EMPID = G.CHR_EMPID  AND A.CHR_EMPID = H.CHR_EMPID ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(F.DT_TERM_DATE) = " + month + "  "; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(F.DT_TERM_DATE) =  " + year + "  "; 
      if (!"0".equals(mode))
        sql = String.valueOf(sql) + " AND F.CHR_MODE = '" + mode + " ' "; 
      if (!"0".equals(ndc))
        sql = String.valueOf(sql) + " AND G.CHR_FINAL = '" + ndc + " ' "; 
      if (!"0".equals(exitinterview))
        sql = String.valueOf(sql) + " AND H.CHR_STATUS = '" + exitinterview + " ' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND A.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( A.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY A.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Termination>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<DDate>" + datas[u][6] + "</DDate>");
          sb.append("<Pfdate>" + datas[u][7] + "</Pfdate>");
          sb.append("<NDCstatus>" + datas[u][9] + "</NDCstatus>");
          sb.append("<Exitinterview>" + datas[u][10] + "</Exitinterview>");
          sb.append("<Bar>" + datas[u][11] + "</Bar>");
          sb.append("<DOJ>" + datas[u][12] + "</DOJ>");
          sb.append("<Issue>" + datas[u][13] + "</Issue>");
          sb.append("<TerminationType>" + datas[u][14] + "</TerminationType>");
          sb.append("<Mode>" + datas[u][15] + "</Mode>");
          sb.append("<usertype>" + object + "</usertype>");
          sb.append("</Termination>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Terms>" + sb.toString() + "</Terms>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYAllowanceRecovery(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String Search = request.getParameter("Search");
      String Office = request.getParameter("Office");
      HttpSession session = request.getSession();
      String usertype = (String)session.getAttribute("USRTYPE");
      String allowance = "";
      String[][] allowdata = CommonFunctions.QueryExecute("SELECT CHR_ACODE  FROM pay_m_allowance  WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
      for (int h = 0; h < allowdata.length; h++)
        allowance = String.valueOf(allowance) + "d." + allowdata[h][0] + " + "; 
      String sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,";
      sql = String.valueOf(sql) + "\t(SELECT COUNT(*) FROM pay_t_allowance  b WHERE b.CHR_EMPID = a.CHR_EMPID) ,";
      sql = String.valueOf(sql) + "\t(SELECT COUNT(*) FROM pay_t_recovery  c  WHERE c.CHR_EMPID = a.CHR_EMPID) ,";
      sql = String.valueOf(sql) + "\ta.INT_SALARY,  (SELECT sum(" + allowance + "0) FROM pay_t_allowance  d WHERE d.CHR_EMPID = a.CHR_EMPID), ";
      sql = String.valueOf(sql) + "\t(a.INT_SALARY +  (SELECT sum(" + allowance + "0) FROM pay_t_allowance  d WHERE d.CHR_EMPID = a.CHR_EMPID) )";
      sql = String.valueOf(sql) + "\tFROM  com_m_staff a  WHERE a.CHR_TYPE <> 'T'";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + "\t AND a.INT_OFFICEID  =" + Office; 
      if ("0".equals(Search)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '%" + Search.trim() + "%' ) OR ( a.CHR_EMPID LIKE '%" + Search.trim() + "' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Staffid>" + datas[u][0].trim() + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1].trim() + "</Staffname>");
          if ("1".equals(datas[u][2].trim())) {
            sb.append("<Allow>Y</Allow>");
          } else {
            sb.append("<Allow>N</Allow>");
          } 
          if ("1".equals(datas[u][2].trim())) {
            sb.append("<Recv>Y</Recv>");
          } else {
            sb.append("<Recv>N</Recv>");
          } 
          sb.append("<Basic>" + datas[u][4].trim() + "</Basic>");
          sb.append("<Allowance>" + datas[u][5].trim() + "</Allowance>");
          sb.append("<Gross>" + datas[u][6].trim() + "</Gross>");
          sb.append("<usertype>" + usertype.toString() + "</usertype>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void AllowanceRecovery(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String Search = request.getParameter("Search");
      String Office = request.getParameter("Office");
      String resigner = request.getParameter("resigner");
      HttpSession session = request.getSession();
      String usertype = (String)session.getAttribute("USRTYPE");
      String sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_TYPE, CONCAT('Type - ',a.CHR_PFCALCULATIONTYPE), ";
      sql = String.valueOf(sql) + " (SELECT IF(COUNT(*)>0,'Yes','No') FROM pay_t_allowance  b WHERE b.CHR_EMPID = a.CHR_EMPID) allowance,  ";
      sql = String.valueOf(sql) + " (SELECT IF(COUNT(*)>0,'Yes','No') FROM pay_t_recovery  c  WHERE c.CHR_EMPID = a.CHR_EMPID) recovery , ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_BASIC(a.CHR_EMPID) basic, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_ADDEDALLOWANCE(a.CHR_EMPID) added, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_OTHERALLOWANCE(a.CHR_EMPID) others, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) gross, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_RECOVERY(a.CHR_EMPID) recovery, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  )  PF, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ESI_CALCULATION('CPY',a.CHR_EMPID,a.CHR_ESI) ESI ,";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_CTC_VALUE(a.CHR_EMPID) ctc,  ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  )  EMPLOYEEPF, ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ESI_CALCULATION('STAFF',a.CHR_EMPID,a.CHR_ESI) EMPLOYEEESI ,";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS(a.CHR_EMPID,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID)  ),";
      sql = String.valueOf(sql) + "  ( ";
      sql = String.valueOf(sql) + " FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID) ";
      sql = String.valueOf(sql) + " - FUN_PAY_GET_PF_CALCULATION(a.CHR_EMPID,a.INT_SALARY,a.CHR_PFCALCULATIONTYPE  ) ";
      sql = String.valueOf(sql) + "  - FUN_PAY_GET_ESI_CALCULATION('STAFF',a.CHR_EMPID,a.CHR_ESI)   ";
      sql = String.valueOf(sql) + " - FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS(a.CHR_EMPID,FUN_PAY_GET_ORIGINAL_GROSS(a.CHR_EMPID)  ) ";
      sql = String.valueOf(sql) + " - FUN_PAY_GET_ORIGINAL_RECOVERY(a.CHR_EMPID) ";
      sql = String.valueOf(sql) + " ) takehome ";
      sql = String.valueOf(sql) + " FROM  com_m_staff a  WHERE  a.CHR_EMPID IS NOT NULL ";
      if ("Y".equals(resigner)) {
        sql = (new StringBuilder(String.valueOf(sql))).toString();
      } else {
        sql = String.valueOf(sql) + " AND a.CHR_TYPE != 'T' ";
      } 
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + "\t AND a.INT_OFFICEID  =" + Office; 
      if ("0".equals(Search)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '%" + Search.trim() + "%' ) OR ( a.CHR_EMPID LIKE '%" + Search.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Staffid>" + datas[u][0].trim() + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1].trim() + "</Staffname>");
          sb.append("<Type>" + datas[u][2].trim() + "</Type>");
          sb.append("<PFCalculationType>" + datas[u][3].trim() + "</PFCalculationType>");
          sb.append("<Allowanceflag>" + datas[u][4].trim() + "</Allowanceflag>");
          sb.append("<Recoveryflag>" + datas[u][5].trim() + "</Recoveryflag>");
          sb.append("<Basic>" + datas[u][6].trim() + "</Basic>");
          sb.append("<AddedAllowance>" + datas[u][7].trim() + "</AddedAllowance>");
          sb.append("<OtherAllowance>" + datas[u][8].trim() + "</OtherAllowance>");
          sb.append("<Gross>" + datas[u][9].trim() + "</Gross>");
          sb.append("<Recovery>" + datas[u][10].trim() + "</Recovery>");
          sb.append("<PF>" + datas[u][11].trim() + "</PF>");
          sb.append("<ESI>" + datas[u][12].trim() + "</ESI>");
          sb.append("<CTC>" + datas[u][13].trim() + "</CTC>");
          sb.append("<EPF>" + datas[u][14].trim() + "</EPF>");
          sb.append("<EESI>" + datas[u][15].trim() + "</EESI>");
          sb.append("<ProfessionalTax>" + datas[u][16].trim() + "</ProfessionalTax>");
          sb.append("<Takehome>" + datas[u][17].trim() + "</Takehome>");
          sb.append("<usertype>" + usertype.toString() + "</usertype>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYAllowanceUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String emp = request.getParameter("empid");
      String mon = request.getParameter("month");
      String yea = request.getParameter("year");
      String col = request.getParameter("column");
      String value = request.getParameter("value");
      String tablename = request.getParameter("tablename");
      String sql = "UPDATE " + tablename + " SET " + col + "= " + value + " WHERE CHR_EMPID='" + emp + "' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + yea;
      CommonFunction.SQLUpdate(sql);
      sql = "SELECT COUNT(*) FROM " + tablename + " WHERE CHR_EMPID='" + emp + "' AND CHR_MONTH='" + mon + "' AND INT_YEAR=" + yea;
      StringBuffer sb = new StringBuffer();
      if (CommonFunction.RecordExist(sql)) {
        sb.append("<Update>");
        sb.append("<Status>TRUE</Status>");
        sb.append("</Update>");
      } else {
        sb.append("<Update>");
        sb.append("<Status>FALSE</Status>");
        sb.append("</Update>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Updates>" + sb.toString() + "</Updates>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void payLoadTax(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      if ("0".equals(startLetter)) {
        sql = "SELECT INT_ID,CHR_TAXNAME,CHR_DESC from pay_m_tax ORDER BY CHR_TAXNAME";
      } else {
        sql = "SELECT INT_ID,CHR_TAXNAME,CHR_DESC from pay_m_tax WHERE CHR_TAXNAME LIKE'" + startLetter + "%' ORDER BY CHR_TAXNAME";
      } 
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<TaxId>");
          sb.append("<Id>" + datas[u][0].trim() + "</Id>");
          sb.append("<Name>" + datas[u][1].trim() + "</Name>");
          sb.append("<Description>" + datas[u][2].trim() + "</Description>");
          sb.append("</TaxId>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<TaxIdss>" + sb.toString() + "</TaxIdss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void payLoadTaxValue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String Taxid = request.getParameter("Taxid");
      String sql = "";
      sql = " SELECT a.INT_ID,b.CHR_TAXNAME ,a.INT_GTEQL,a.INT_LSEQL,a.DOU_PERCENTAGE,a.DOU_AMOUNT,a.CHR_DESC FROM pay_m_taxvalue a ,pay_m_tax b WHERE a.INT_ID IS NOT NULL AND b.INT_ID=a.INT_TAXID";
      String condsql = "";
      if (!"0".equals(Taxid))
        condsql = " AND a.INT_TAXID= " + Taxid + " "; 
      String searchsql = "";
      if (!"0".equals(startLetter))
        searchsql = " AND b.CHR_TAXNAME LIKE'" + startLetter + "%' "; 
      sql = String.valueOf(sql) + condsql + searchsql + "  Order by a.INT_ID ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<TaxId>");
          sb.append("<Id>" + datas[u][0].trim() + "</Id>");
          sb.append("<Name>" + datas[u][1].trim() + "</Name>");
          sb.append("<Greater>" + datas[u][2].trim() + "</Greater>");
          sb.append("<Lesser>" + datas[u][3].trim() + "</Lesser>");
          sb.append("<Percent>" + datas[u][4].trim() + "</Percent>");
          sb.append("<Amount>" + datas[u][5].trim() + "</Amount>");
          sb.append("<Description>" + datas[u][6].trim() + "</Description>");
          sb.append("</TaxId>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<TaxIdss>" + sb.toString() + "</TaxIdss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYExit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String office = request.getParameter("Office");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String type = request.getParameter("type");
      HttpSession session = request.getSession();
      String sql = "";
      sql = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME,";
      sql = String.valueOf(sql) + " B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,F.INT_EXITID ,A.CHR_TYPE,F.CHR_STATUS ";
      sql = String.valueOf(sql) + "  from  com_m_staff  A, com_m_branch  B, ";
      sql = String.valueOf(sql) + "   com_m_depart   C, com_m_desig  D, com_m_company  E,pay_t_exitinterview F ";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID " + 
        " AND A.CHR_EMPID=F.CHR_EMPID  " + 
        " AND year(F.DAT_CREATIONTIME)=" + year + " ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND month(F.DAT_CREATIONTIME)=" + month; 
      if (!"0".equals(office))
        sql = String.valueOf(sql) + " AND A.INT_OFFICEID=" + office; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND F.CHR_STATUS='" + status + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND A.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( A.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " group by A.CHR_EMPID  order by A.CHR_EMPID ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Termination>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<ExitId>" + datas[u][6] + "</ExitId>");
          sb.append("<Resign>" + datas[u][7] + "</Resign>");
          sb.append("<Status>" + datas[u][8] + "</Status>");
          sb.append("<usertype>" + session.getAttribute("USRTYPE") + "</usertype>");
          sb.append("</Termination>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Terms>" + sb.toString() + "</Terms>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYResignation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object1 = session.getAttribute("EMPID");
      String startLetter = request.getParameter("startLetter");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "";
      Object object2 = session.getAttribute("USERTYPE");
      String status = "";
      if (!"0".equals(startLetter)) {
        status = " AND A.CHR_STAFFNAME LIKE'" + startLetter + "%' group by A.CHR_EMPID  order by A.CHR_EMPID ";
      } else {
        status = " group by A.CHR_EMPID  order by A.CHR_EMPID ";
      } 
      sql = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME,";
      sql = String.valueOf(sql) + " B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,F.INT_RESIGNLETTERID,F.CHR_ACCEPTSTATUS,F.CHR_CESSATION_STATUS ";
      sql = String.valueOf(sql) + "  from  com_m_staff  A, com_m_branch  B, ";
      sql = String.valueOf(sql) + "   com_m_depart   C, com_m_desig  D, com_m_company  E,pay_t_resignationletter F ";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID " + 
        " AND A.CHR_EMPID=F.CHR_EMPID  AND month(F.DAT_APPPLYDATE)=" + month + "  ";
      if (!"F".equals(object2))
        sql = String.valueOf(sql) + " AND F.CHR_REPORTINGTO='" + object1 + "'"; 
      sql = String.valueOf(sql) + "   AND year(F.DAT_APPPLYDATE)=" + year + " " + status;
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Termination>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<ExitId>" + datas[u][6] + "</ExitId>");
          sb.append("<Status>" + datas[u][7] + "</Status>");
          sb.append("<Cessation>" + datas[u][8] + "</Cessation>");
          sb.append("</Termination>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Terms>" + sb.toString() + "</Terms>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadResignationmovetoCessation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "";
      sql = " SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME,";
      sql = String.valueOf(sql) + " B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,F.INT_RESIGNLETTERID,F.CHR_ACCEPTSTATUS,F.CHR_CESSATION_STATUS ,";
      sql = String.valueOf(sql) + " DATE_FORMAT(DAT_APPPLYDATE,'%d-%b-%Y') , DATE_FORMAT(F.DAT_LASTDATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " F.CHR_MODE ";
      sql = String.valueOf(sql) + "  from  com_m_staff  A, com_m_branch  B, ";
      sql = String.valueOf(sql) + "   com_m_depart   C, com_m_desig  D, com_m_company  E,pay_t_resignationletter F ";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_DESIGID=D.INT_DESIGID ";
      sql = String.valueOf(sql) + "   AND A.CHR_EMPID=F.CHR_EMPID  ";
      sql = String.valueOf(sql) + "  AND MONTH(F.DAT_LASTDATE) = " + month;
      sql = String.valueOf(sql) + "  AND YEAR(F.DAT_LASTDATE) = " + year;
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + "   AND A.CHR_STAFFNAME LIKE'" + startLetter + "%' group by A.CHR_EMPID  order by A.CHR_EMPID ";
      } else {
        sql = String.valueOf(sql) + "   group by A.CHR_EMPID  order by A.CHR_EMPID ";
      } 
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Termination>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][2] + "</Companyame>");
          sb.append("<Branch>" + datas[u][3] + "</Branch>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Desig>" + datas[u][5] + "</Desig>");
          sb.append("<ExitId>" + datas[u][6] + "</ExitId>");
          sb.append("<Status>" + datas[u][7] + "</Status>");
          sb.append("<Cessation>" + datas[u][8] + "</Cessation>");
          sb.append("<Adate>" + datas[u][9] + "</Adate>");
          sb.append("<LWD>" + datas[u][10] + "</LWD>");
          sb.append("<Mode>" + datas[u][11] + "</Mode>");
          sb.append("</Termination>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Terms>" + sb.toString() + "</Terms>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYReliving(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "";
      sql = "select A.CHR_EMPID,A.CHR_STAFFNAME FROM  com_m_staff A, pay_t_exitinterview B WHERE A.CHR_EMPID=B.CHR_EMPID AND month(B.DAT_INTERVIEWDATE)=" + month + " AND year(B.DAT_INTERVIEWDATE)=" + year;
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Reliving>");
          sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][1] + "</Staffname>");
          sb.append("</Reliving>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Relvs>" + sb.toString() + "</Relvs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadPayTaxdeduction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String taxid = request.getParameter("taxid");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String Office = request.getParameter("Office");
      String sql = "";
      sql = " SELECT a.INT_ID,c.CHR_STAFFNAME,b.CHR_TAXNAME ,a.CHR_EMPID,a.CHR_MONTH,a.INT_YEAR FROM pay_t_taxempids a,pay_m_tax b,com_m_staff c WHERE a.INT_TAXID=b.INT_ID AND a.CHR_EMPID=c.CHR_EMPID ";
      if (!"0".equals(Office))
        sql = String.valueOf(sql) + " AND c.INT_OFFICEID=" + Office + " "; 
      if (!"0".equals(taxid))
        sql = String.valueOf(sql) + " AND a.INT_TAXID=" + taxid + " "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND a.CHR_MONTH='" + month + "' "; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND a.INT_YEAR=" + year + " "; 
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND c.CHR_STAFFNAME LIKE '" + startLetter + "%'";
      } else {
        sql = String.valueOf(sql) + " AND c.CHR_STAFFNAME LIKE '%'";
      } 
      sql = String.valueOf(sql) + " ORDER BY  c.CHR_STAFFNAME";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + datas[u][0].trim() + "</Id>");
          sb.append("<Name>" + datas[u][1].trim() + "</Name>");
          sb.append("<Tax>" + datas[u][2].trim() + "</Tax>");
          sb.append("<Empid>" + datas[u][3].trim() + "</Empid>");
          sb.append("<Month>" + datas[u][4].trim() + "</Month>");
          sb.append("<Year>" + datas[u][5].trim() + "</Year>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYITMaster(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String fin = request.getParameter("financial");
      String gen = request.getParameter("gender");
      StringBuffer sb = new StringBuffer();
      String sql = "";
      sql = "select INT_INCOMETAXID,INT_FROMSALARY,INT_TOSALARY,CHR_CALCULATIONFLAG,DOU_AMOUNT,DOU_PERCENTAGE from  pay_m_incometax  where INT_FINANCIALYEARID=" + fin + " AND CHR_GENDER='" + gen + "'";
      String[][] data = CommonFunction.RecordSetArray(sql);
      for (int i = 0; i < data.length; i++) {
        sb.append("<ITM>");
        sb.append("<id>" + data[i][0].trim() + "</id>");
        sb.append("<from>" + data[i][1].trim() + "</from>");
        sb.append("<to>" + data[i][2].trim() + "</to>");
        sb.append("<cal>" + data[i][3].trim() + "</cal>");
        sb.append("<amount>" + data[i][4].trim() + "</amount>");
        sb.append("<precent>" + data[i][5].trim() + "</precent>");
        sb.append("</ITM>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<ITMS>" + sb.toString() + "</ITMS>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYPreviousTakeups(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String empid = request.getParameter("empid");
      StringBuffer sb = new StringBuffer();
      String sql = "";
      String allowance = "";
      String[][] allowdata = CommonFunctions.QueryExecute("Select CHR_ACODE,CHR_ANAME from pay_m_allowance order by CHR_ACODE");
      for (int h = 0; h < allowdata.length; h++)
        allowance = String.valueOf(allowance) + allowdata[h][0] + ","; 
      allowance = allowance.substring(0, allowance.length() - 1);
      String[][] Adata = CommonFunctions.QueryExecute("SELECT " + allowance + " FROM pay_t_allowance WHERE CHR_EMPID='" + empid + "'");
      String recovery = "";
      String[][] recoverydata = CommonFunctions.QueryExecute("Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE");
      for (int i = 0; i < allowdata.length; i++)
        recovery = String.valueOf(recovery) + recoverydata[i][0] + ","; 
      recovery = recovery.substring(0, recovery.length() - 1);
      String[][] Rdata = CommonFunctions.QueryExecute("SELECT " + recovery + " FROM pay_t_recovery WHERE CHR_EMPID='" + empid + "'");
      sql = "SELECT INT_SALARY FROM com_m_staff WHERE CHR_EMPID='" + empid + "'";
      String[][] data = CommonFunction.RecordSetArray(sql);
      if (data.length > 0) {
        sb.append("<Row>");
        sb.append("<Basic>" + data[0][0].trim() + "</Basic>");
        sb.append("<Alength>" + allowdata + "</Alength>");
        sb.append("<Rlength>" + allowdata.length + "</Rlength>");
        if (allowdata.length > 0) {
          for (int u = 0; u < allowdata.length; u++)
            sb.append("<AllowanceValue>" + Adata[0][u] + "</AllowanceValue>"); 
        } else {
          for (int u = 0; u < allowdata.length; u++)
            sb.append("<AllowanceValue>0</AllowanceValue>"); 
        } 
        if (recoverydata.length > 0) {
          for (int u = 0; u < recoverydata.length; u++)
            sb.append("<RecoveryValue>" + Rdata[0][u] + "</RecoveryValue>"); 
        } else {
          for (int u = 0; u < recoverydata.length; u++)
            sb.append("<RecoveryValue>0</RecoveryValue>"); 
        } 
        sb.append("</Row>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYloadPFCliamStatus(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "SELECT a.CHR_EMPID, a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),a.CHR_PFCLIAMDESCRIPTION FROM com_m_staff a WHERE a.CHR_PFCLAIMSTATUS='Y' AND a.CHR_TYPE='T' AND a.CHR_PF !='N' ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND  MONTH(a.DAT_PFCLIAMDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(a.DAT_PFCLIAMDATE)=" + year; 
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND  a.CHR_STAFFNAME  LIKE'" + startLetter + "%' ORDER BY a.CHR_STAFFNAME "; 
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Rows>");
          sb.append("<Id1>" + datas[u][0].trim() + "</Id1>");
          sb.append("<Name1>" + datas[u][1].trim() + "</Name1>");
          sb.append("<Date1>" + datas[u][2].trim() + "</Date1>");
          sb.append("<Description1>" + datas[u][3].trim() + "</Description1>");
          sb.append("</Rows>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadTemporarysuspension(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String office = request.getParameter("office");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String ndc = request.getParameter("ndc");
      String sql = "";
      sql = " SELECT a.INT_ROWID,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME ,a.CHR_MONTH,a.INT_YEAR,a.CHR_DESC,DATE_FORMAT(a.DAT_LOW,'%d-%b-%Y'),FIND_A_EMPLOYEE_ID_NAME(a.CHR_ENTEREDEDBY) ";
      sql = String.valueOf(sql) + " , a.CHR_STATUS, a.CHR_SKILLSET,a.CHR_REPLACEMENT,a.CHR_MOVE_RESIGINATION_POST FROM pay_t_temporarysuspension a, com_m_staff b, com_m_office c ";
      sql = String.valueOf(sql) + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
      sql = String.valueOf(sql) + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
      if (!"0".equals(office))
        sql = String.valueOf(sql) + " AND  b.INT_OFFICEID = " + office; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND   a.CHR_MONTH = '" + DateUtil.getMonth(Integer.parseInt(month)) + "' "; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  a.INT_YEAR = " + year; 
      if (!"0".equals(ndc))
        sql = String.valueOf(sql) + " AND   a.CHR_STATUS = '" + ndc + "' "; 
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND  b.CHR_STAFFNAME  LIKE'" + startLetter + "%' ORDER BY b.CHR_STAFFNAME "; 
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Rows>");
          sb.append("<Id>" + datas[u][0].trim() + "</Id>");
          sb.append("<Empid>" + datas[u][1].trim() + "</Empid>");
          sb.append("<Name>" + datas[u][2].trim() + "</Name>");
          sb.append("<Office>" + datas[u][3].trim() + "</Office>");
          sb.append("<Month>" + datas[u][4].trim() + "</Month>");
          sb.append("<Year>" + datas[u][5].trim() + "</Year>");
          sb.append("<description>" + datas[u][6].trim().replaceAll("&", " and ") + "</description>");
          sb.append("<LOW>" + datas[u][7].trim() + "</LOW>");
          sb.append("<Authorisedby>" + datas[u][8].trim() + "</Authorisedby>");
          sb.append("<NDC>" + datas[u][9].trim() + "</NDC>");
          sb.append("<Replacement>" + datas[u][11].trim() + "</Replacement>");
          sb.append("<ResiginationPost>" + datas[u][12].trim() + "</ResiginationPost>");
          sb.append("</Rows>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadNDCStore(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String startLetter = request.getParameter("startLetter");
      String status = request.getParameter("status");
      String sql = "";
      sql = " SELECT  f.INT_NDCID ,a.CHR_EMPID,a.CHR_STAFFNAME,e.CHR_COMPANYNAME,  ";
      sql = String.valueOf(sql) + " b.CHR_BRANCHNAME,c.CHR_DEPARTNAME,d.CHR_DESIGNAME ,  ";
      sql = String.valueOf(sql) + " DATE_FORMAT(f.DAT_CREATION_DATE,'%d-%m-%Y'),f.CHR_STORE,f.CHR_FINAL ";
      sql = String.valueOf(sql) + " from  com_m_staff  a, com_m_branch  b,    ";
      sql = String.valueOf(sql) + " com_m_depart   c, com_m_desig  d, com_m_company  e  ,pay_t_emp_ndc f  ";
      sql = String.valueOf(sql) + " where a.INT_BRANCHID=b.INT_BRANCHID AND a.INT_COMPANYID =e.INT_COMPANYID  ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID=c.INT_DEPARTID AND a.INT_DESIGID=d.INT_DESIGID     ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID = f.CHR_EMPID     ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(f.DAT_CREATION_DATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(f.DAT_CREATION_DATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND f.CHR_STORE = '" + status + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + datas[u][0] + "</Rowid>");
          sb.append("<Staffid>" + datas[u][1] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][2] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][3] + "</Companyame>");
          sb.append("<Branch>" + datas[u][4] + "</Branch>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<EDate>" + datas[u][7] + "</EDate>");
          sb.append("<Status>" + datas[u][8] + "</Status>");
          sb.append("<FStatus>" + datas[u][9] + "</FStatus>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadNDCAccounts(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String startLetter = request.getParameter("startLetter");
      String status = request.getParameter("status");
      String sql = "";
      sql = " SELECT  f.INT_NDCID ,a.CHR_EMPID,a.CHR_STAFFNAME,e.CHR_COMPANYNAME,  ";
      sql = String.valueOf(sql) + " b.CHR_BRANCHNAME,c.CHR_DEPARTNAME,d.CHR_DESIGNAME ,  ";
      sql = String.valueOf(sql) + " DATE_FORMAT(f.DAT_CREATION_DATE,'%d-%m-%Y'),f.CHR_ACCOUNTS,f.CHR_FINAL ";
      sql = String.valueOf(sql) + " from  com_m_staff  a, com_m_branch  b,    ";
      sql = String.valueOf(sql) + " com_m_depart   c, com_m_desig  d, com_m_company  e  ,pay_t_emp_ndc f  ";
      sql = String.valueOf(sql) + " where a.INT_BRANCHID=b.INT_BRANCHID AND a.INT_COMPANYID =e.INT_COMPANYID  ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID=c.INT_DEPARTID AND a.INT_DESIGID=d.INT_DESIGID     ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID = f.CHR_EMPID     ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(f.DAT_CREATION_DATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(f.DAT_CREATION_DATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND f.CHR_ACCOUNTS = '" + status + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + datas[u][0] + "</Rowid>");
          sb.append("<Staffid>" + datas[u][1] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][2] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][3] + "</Companyame>");
          sb.append("<Branch>" + datas[u][4] + "</Branch>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<EDate>" + datas[u][7] + "</EDate>");
          sb.append("<Status>" + datas[u][8] + "</Status>");
          sb.append("<FStatus>" + datas[u][9] + "</FStatus>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadNDCHR(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String startLetter = request.getParameter("startLetter");
      String status = request.getParameter("status");
      String sql = "";
      sql = " SELECT  f.INT_NDCID ,a.CHR_EMPID,a.CHR_STAFFNAME,e.CHR_COMPANYNAME,  ";
      sql = String.valueOf(sql) + " b.CHR_BRANCHNAME,c.CHR_DEPARTNAME,d.CHR_DESIGNAME ,  ";
      sql = String.valueOf(sql) + " DATE_FORMAT(f.DAT_CREATION_DATE,'%d-%m-%Y'),f.CHR_HR,f.CHR_FINAL ";
      sql = String.valueOf(sql) + " from  com_m_staff  a, com_m_branch  b,    ";
      sql = String.valueOf(sql) + " com_m_depart   c, com_m_desig  d, com_m_company  e  ,pay_t_emp_ndc f  ";
      sql = String.valueOf(sql) + " where a.INT_BRANCHID=b.INT_BRANCHID AND a.INT_COMPANYID =e.INT_COMPANYID  ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID=c.INT_DEPARTID AND a.INT_DESIGID=d.INT_DESIGID     ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID = f.CHR_EMPID     ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(f.DAT_CREATION_DATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(f.DAT_CREATION_DATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND f.CHR_HR = '" + status + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + datas[u][0] + "</Rowid>");
          sb.append("<Staffid>" + datas[u][1] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][2] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][3] + "</Companyame>");
          sb.append("<Branch>" + datas[u][4] + "</Branch>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<EDate>" + datas[u][7] + "</EDate>");
          sb.append("<Status>" + datas[u][8] + "</Status>");
          sb.append("<FStatus>" + datas[u][9] + "</FStatus>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadNDC_General(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      String status = request.getParameter("status");
      sql = " SELECT  f.INT_NDCID ,a.CHR_EMPID,a.CHR_STAFFNAME,e.CHR_COMPANYNAME,  ";
      sql = String.valueOf(sql) + " b.CHR_BRANCHNAME,c.CHR_DEPARTNAME,d.CHR_DESIGNAME ,  ";
      sql = String.valueOf(sql) + " DATE_FORMAT(f.DAT_CREATION_DATE,'%d-%m-%Y'),f.CHR_GENERAL,f.CHR_FINAL ";
      sql = String.valueOf(sql) + " from  com_m_staff  a, com_m_branch  b,    ";
      sql = String.valueOf(sql) + " com_m_depart   c, com_m_desig  d, com_m_company  e  ,pay_t_emp_ndc f  ";
      sql = String.valueOf(sql) + " where a.INT_BRANCHID=b.INT_BRANCHID AND a.INT_COMPANYID =e.INT_COMPANYID  ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID=c.INT_DEPARTID AND a.INT_DESIGID=d.INT_DESIGID     ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID = f.CHR_EMPID     ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(f.DAT_CREATION_DATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(f.DAT_CREATION_DATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND f.CHR_GENERAL = '" + status + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + datas[u][0] + "</Rowid>");
          sb.append("<Staffid>" + datas[u][1] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][2] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][3] + "</Companyame>");
          sb.append("<Branch>" + datas[u][4] + "</Branch>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<EDate>" + datas[u][7] + "</EDate>");
          sb.append("<Status>" + datas[u][8] + "</Status>");
          sb.append("<FStatus>" + datas[u][9] + "</FStatus>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadNDCFinalAccept(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      String status = request.getParameter("status");
      sql = " SELECT  f.INT_NDCID ,a.CHR_EMPID,a.CHR_STAFFNAME,e.CHR_COMPANYNAME,  ";
      sql = String.valueOf(sql) + " b.CHR_BRANCHNAME,c.CHR_DEPARTNAME,d.CHR_DESIGNAME ,  ";
      sql = String.valueOf(sql) + " DATE_FORMAT(f.DAT_CREATION_DATE,'%d-%m-%Y'),f.CHR_STORE, ";
      sql = String.valueOf(sql) + " f.CHR_ACCOUNTS,f.CHR_HR,f.CHR_GENERAL, f.CHR_FINAL  from  com_m_staff  a, com_m_branch  b,    ";
      sql = String.valueOf(sql) + " com_m_depart   c, com_m_desig  d, com_m_company  e  ,pay_t_emp_ndc f  ";
      sql = String.valueOf(sql) + " where a.INT_BRANCHID=b.INT_BRANCHID AND a.INT_COMPANYID =e.INT_COMPANYID  ";
      sql = String.valueOf(sql) + " AND a.INT_DEPARTID=c.INT_DEPARTID AND a.INT_DESIGID=d.INT_DESIGID     ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID = f.CHR_EMPID     ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(f.DAT_CREATION_DATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(f.DAT_CREATION_DATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND f.CHR_FINAL = '" + status + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND( ( a.CHR_STAFFNAME LIKE '" + startLetter.trim() + "%' ) OR ( A.CHR_EMPID LIKE '%" + startLetter.trim() + "%' )  )";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + datas[u][0] + "</Rowid>");
          sb.append("<Staffid>" + datas[u][1] + "</Staffid>");
          sb.append("<Staffname>" + datas[u][2] + "</Staffname>");
          sb.append("<Companyame>" + datas[u][3] + "</Companyame>");
          sb.append("<Branch>" + datas[u][4] + "</Branch>");
          sb.append("<Depart>" + datas[u][5] + "</Depart>");
          sb.append("<Desig>" + datas[u][6] + "</Desig>");
          sb.append("<EDate>" + datas[u][7] + "</EDate>");
          sb.append("<SStatus>" + datas[u][8] + "</SStatus>");
          sb.append("<AStatus>" + datas[u][9] + "</AStatus>");
          sb.append("<HStatus>" + datas[u][10] + "</HStatus>");
          sb.append("<GStatus>" + datas[u][11] + "</GStatus>");
          sb.append("<FStatus>" + datas[u][12] + "</FStatus>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadStaff(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String companyId = request.getParameter("companyId");
      String branchId = request.getParameter("branchId");
      String departId = request.getParameter("departId");
      String desigId = request.getParameter("desigId");
      String startLetter = request.getParameter("startLetter");
      String resigned = request.getParameter("resigned");
      String asql = "";
      String[][] orderdata = CommonFunctions.QueryExecute("SELECT CHR_ORDERBY FROM m_institution");
      asql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='" + session.getAttribute("USRID") + "'";
      String[][] officedata = CommonFunctions.QueryExecute(asql);
      asql = " SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME ";
      asql = String.valueOf(asql) + " , A.CHR_MOBILE  ,E.CHR_COMPANYNAME , A.CHR_TYPE  from  com_m_staff  A, com_m_branch  B, ";
      asql = String.valueOf(asql) + " com_m_depart   C, com_m_desig  D,  com_m_company  E , pay_t_basic_informations F where A.INT_BRANCHID=B.INT_BRANCHID AND ";
      asql = String.valueOf(asql) + "  A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_DESIGID=D.INT_DESIGID  ";
      asql = String.valueOf(asql) + " AND A.CHR_EMPID=F.CHR_EMPID ";
      asql = String.valueOf(asql) + " AND F.INT_SALARY<1 ";
      if (!"0".equals(companyId))
        asql = String.valueOf(asql) + " AND A.INT_COMPANYID=" + companyId; 
      if (!"0".equals(branchId))
        asql = String.valueOf(asql) + " AND A.INT_BRANCHID=" + branchId; 
      if (!"0".equals(departId))
        asql = String.valueOf(asql) + " AND A.INT_DEPARTID=" + departId; 
      if (!"0".equals(desigId))
        asql = String.valueOf(asql) + " AND A.INT_DESIGID=" + desigId; 
      if (!"Y".equals(resigned))
        asql = String.valueOf(asql) + " AND A.CHR_TYPE !='T' "; 
      asql = String.valueOf(asql) + " AND  A.INT_OFFICEID IN(" + officedata[0][0] + " ,0) ";
      if (!"0".equals(startLetter))
        asql = String.valueOf(asql) + "  AND A.CHR_STAFFNAME Like'" + startLetter + "%'  "; 
      if ("N".equals(orderdata[0][0])) {
        asql = String.valueOf(asql) + " ORDER BY A.CHR_STAFFNAME ";
      } else {
        asql = String.valueOf(asql) + "  ORDER BY A.CHR_EMPID ";
      } 
      System.out.println(asql);
      String[][] readData = CommonFunctions.QueryExecute(asql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Staff>");
          sb.append("<StaffId>" + readData[u][0] + "</StaffId>");
          sb.append("<StaffName>" + readData[u][1] + "</StaffName>");
          sb.append("<BranchName>" + readData[u][2] + "</BranchName>");
          sb.append("<DepartName>" + readData[u][3] + "</DepartName>");
          sb.append("<DesigName>" + readData[u][4] + "</DesigName>");
          sb.append("<Mobile>" + readData[u][5] + "</Mobile>");
          sb.append("<Company>" + readData[u][6] + "</Company>");
          sb.append("<Termination>" + readData[u][7] + "</Termination>");
          sb.append("<Usertype>" + officedata[0][1] + "</Usertype>");
          sb.append("</Staff>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadStaffSearch(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String search = request.getParameter("search");
      String sql = "SELECT CHR_ORDERBY FROM m_institution";
      String[][] orderdata = CommonFunctions.QueryExecute(sql);
      sql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='" + session.getAttribute("USRID") + "'";
      String[][] officedata = CommonFunctions.QueryExecute(sql);
      sql = " SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME  , A.CHR_MOBILE ,E.CHR_COMPANYNAME ,A.CHR_TYPE,A.CHR_MIDDLENAME";
      sql = String.valueOf(sql) + " from  com_m_staff  A, com_m_branch  B,  com_m_depart  C, com_m_desig  D ,  com_m_company  E , pay_t_basic_informations F";
      sql = String.valueOf(sql) + " where A.INT_BRANCHID=B.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND A.CHR_EMPID=F.CHR_EMPID ";
      sql = String.valueOf(sql) + " AND F.INT_SALARY<1 ";
      sql = String.valueOf(sql) + " AND A.INT_COMPANYID =  E.INT_COMPANYID ";
      sql = String.valueOf(sql) + " AND A.INT_DEPARTID=C.INT_DEPARTID  ";
      sql = String.valueOf(sql) + " AND A.INT_DESIGID=D.INT_DESIGID  ";
      sql = String.valueOf(sql) + " AND  A.INT_OFFICEID IN(" + officedata[0][0] + " ,0) ";
      sql = String.valueOf(sql) + " AND( (A.CHR_STAFFNAME LIKE '%" + search.trim() + "%' ) OR (A.CHR_EMPID LIKE '%" + search.trim() + "%' )  )";
      if ("N".equals(orderdata[0][0])) {
        sql = String.valueOf(sql) + " ORDER BY A.CHR_STAFFNAME ";
      } else {
        sql = String.valueOf(sql) + " ORDER BY A.CHR_EMPID ";
      } 
      System.out.println();
      System.out.println();
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Staff>");
          sb.append("<StaffId>" + readData[u][0] + "</StaffId>");
          String rs = readData[u][1].toUpperCase();
          sb.append("<StaffName>" + rs + "</StaffName>");
          sb.append("<BranchName>" + readData[u][2] + "</BranchName>");
          sb.append("<DepartName>" + readData[u][3] + "</DepartName>");
          sb.append("<DesigName>" + readData[u][4] + "</DesigName>");
          sb.append("<Mobile>" + readData[u][5] + "</Mobile>");
          sb.append("<Company>" + readData[u][6] + "</Company>");
          sb.append("<Termination>" + readData[u][7] + "</Termination>");
          sb.append("<MiddleName>" + readData[u][8] + "</MiddleName>");
          sb.append("<Usertype>" + officedata[0][1] + "</Usertype>");
          sb.append("</Staff>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Staffs>" + sb.toString() + "</Staffs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadLoan(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String search = request.getParameter("search");
      String sql = " SELECT INT_LOANID,CHR_LOANNAME,CHR_DESC FROM pay_m_loan ";
      if (!"0".equals(search))
        sql = String.valueOf(sql) + " WHERE CHR_LOANNAME LIKE '" + search + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_LOANNAME";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      for (int u = 0; u < readData.length; u++) {
        sb.append("<Rows>");
        sb.append("<Id>" + readData[u][0] + "</Id>");
        sb.append("<Name>" + readData[u][1].replaceAll("&", "AND ") + "</Name>");
        sb.append("<descr>" + readData[u][2].replaceAll("&", "AND ") + "</descr>");
        sb.append("</Rows>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadLoanCredit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String loantype = request.getParameter("loantype");
      String off = request.getParameter("Office");
      String sql = " SELECT B.INT_LOAN_CREDITID,B.CHR_EMPID,B.DAT_CREDIT,B.INT_CREDIT_AMOUNT,B.CHR_AUTHORISED,A.CHR_STAFFNAME,C.CHR_LOANNAME FROM pay_t_loancredit B,com_m_staff  A,pay_m_loan C";
      sql = String.valueOf(sql) + " \twhere  B.CHR_EMPID=A.CHR_EMPID AND B.INT_LOANID=C.INT_LOANID";
      if (!"0".equals(off))
        sql = String.valueOf(sql) + " AND  A.INT_OFFICEID = " + off; 
      if (!"0".equals(loantype))
        sql = String.valueOf(sql) + " AND B.INT_LOANID = " + loantype; 
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND  A.CHR_STAFFNAME  LIKE'" + startLetter + "%' ORDER BY A.CHR_STAFFNAME "; 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      for (int u = 0; u < readData.length; u++) {
        sb.append("<RowsLOAN>");
        sb.append("<IdLoan>" + readData[u][0] + "</IdLoan>");
        sb.append("<EMPID>" + readData[u][1] + "</EMPID>");
        sb.append("<CREDIT>" + readData[u][2] + "</CREDIT>");
        sb.append("<LOANNAME>" + readData[u][6] + "</LOANNAME>");
        sb.append("<AMOUNT>" + readData[u][3] + "</AMOUNT>");
        String sql1 = "SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID ='" + readData[u][4] + "'";
        String[][] readData1 = CommonFunctions.QueryExecute(sql1);
        sb.append("<AUTHORISED>" + readData1[0][0] + "</AUTHORISED>");
        sb.append("<STAFFNAME>" + readData[u][5] + "</STAFFNAME>");
        sb.append("</RowsLOAN>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<RowsLoan>" + sb.toString() + "</RowsLoan>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadLoanDebit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String off = request.getParameter("Office");
      String loantype = request.getParameter("loantype");
      String sql = " SELECT B.INT_LOAN_DEBITID,B.CHR_EMPID,B.DAT_DEBIT,B.INT_DEBIT_AMOUNT,A.CHR_STAFFNAME,C.CHR_LOANNAME FROM pay_t_loandebit B,com_m_staff  A ,pay_m_loan C";
      sql = String.valueOf(sql) + " \twhere  B.CHR_EMPID=A.CHR_EMPID AND B.INT_LOANID=C.INT_LOANID";
      if (!"0".equals(off))
        sql = String.valueOf(sql) + " AND  A.INT_OFFICEID = " + off; 
      if (!"0".equals(loantype))
        sql = String.valueOf(sql) + " AND B.INT_LOANID = " + loantype; 
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND  A.CHR_STAFFNAME  LIKE'" + startLetter + "%' ORDER BY A.CHR_STAFFNAME "; 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      for (int u = 0; u < readData.length; u++) {
        sb.append("<RowsLOAND>");
        sb.append("<IdLoand>" + readData[u][0] + "</IdLoand>");
        sb.append("<DEMPID>" + readData[u][1] + "</DEMPID>");
        sb.append("<DCREDIT>" + readData[u][2] + "</DCREDIT>");
        sb.append("<LOANNAME>" + readData[u][5] + "</LOANNAME>");
        sb.append("<DAMOUNT>" + readData[u][3] + "</DAMOUNT>");
        sb.append("<DSTAFFNAME>" + readData[u][4] + "</DSTAFFNAME>");
        sb.append("</RowsLOAND>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<DRowsLoan>" + sb.toString() + "</DRowsLoan>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void IncomeLoadTaxValue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String AccYear = request.getParameter("AccYear");
      int IAccYear = Integer.parseInt(AccYear);
      String sql = "";
      String condsql = "";
      String searchsql = "";
      sql = " SELECT INT_ID,INT_ACCOUNTYEAR,INT_TO,INT_FROM,DOU_PERCENTAGE,CHR_DESC,CHR_GENDER FROM lncome_m_taxvalue a WHERE";
      if (!"0".equals(AccYear))
        condsql = " INT_ACCOUNTYEAR= " + IAccYear + " "; 
      if (!"0".equals(startLetter))
        searchsql = " AND INT_ACCOUNTYEAR LIKE'" + startLetter + "%' "; 
      sql = String.valueOf(sql) + condsql + searchsql + "  Order by INT_ID ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<IncomeId>");
          sb.append("<Id>" + datas[u][0].trim() + "</Id>");
          sb.append("<Accountyear>" + datas[u][1].trim() + "</Accountyear>");
          sb.append("<To>" + datas[u][2].trim() + "</To>");
          sb.append("<From>" + datas[u][3].trim() + "</From>");
          sb.append("<Percent>" + datas[u][4].trim() + "</Percent>");
          sb.append("<Description>" + datas[u][5].trim() + "</Description>");
          sb.append("<Gender>" + datas[u][6].trim() + "</Gender>");
          sb.append("</IncomeId>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<IncomeIds>" + sb.toString() + "</IncomeIds>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void PAYBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String off = request.getParameter("Office");
      String loantype2 = request.getParameter("loantype1");
      System.out.println("loantype..." + loantype2);
      String sql = "";
      sql = " SELECT  A.CHR_EMPID,C.CHR_STAFFNAME,d.CHR_LOANNAME, Getcredit(A.CHR_EMPID,A.INT_LOANID),GetDebit(A.CHR_EMPID,A.INT_LOANID),(Getcredit(A.CHR_EMPID,A.INT_LOANID)-GetDebit(A.CHR_EMPID,A.INT_LOANID) ) FROM  pay_t_loancredit  A,com_m_staff  C ,pay_m_loan  d";
      sql = String.valueOf(sql) + " \twhere C.CHR_EMPID = A.CHR_EMPID AND A.INT_LOANID=d.INT_LOANID";
      if (!"0".equals(off))
        sql = String.valueOf(sql) + " AND  C.INT_OFFICEID = " + off; 
      if (!"0".equals(loantype2))
        sql = String.valueOf(sql) + " AND d.INT_LOANID = " + loantype2; 
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND C.CHR_STAFFNAME LIKE'" + startLetter + "%' group by A.CHR_EMPID ,A.INT_LOANID";
      } else {
        sql = String.valueOf(sql) + " GROUP BY A.CHR_EMPID ,A.INT_LOANID ";
      } 
      System.out.println("sql...." + sql);
      String[][] datas = CommonFunctions.QueryExecute(sql);
      double total = 0.0D;
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          total = Double.parseDouble(datas[u][5]);
          if (Math.round(total) != 0L) {
            sb.append("<Advance>");
            sb.append("<Staffid>" + datas[u][0] + "</Staffid>");
            sb.append("<StaffName>" + datas[u][1] + "</StaffName>");
            sb.append("<LoanName>" + datas[u][2] + "</LoanName>");
            sb.append("<CreditAmt>" + datas[u][3] + "</CreditAmt>");
            sb.append("<DebitAmt>" + datas[u][4] + "</DebitAmt>");
            sb.append("<Balance>" + Math.round(total) + "</Balance>");
            sb.append("</Advance>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Balance>" + sb.toString() + "</Balance>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadSelectEmpid(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String Empid = request.getParameter("Empid");
      String loantype = request.getParameter("loantype");
      String[][] readData = null;
      String totalamt = null;
      if (!"0".equals(loantype)) {
        String sql = "";
        sql = "SELECT A.INT_LOANID,A.INT_CREDIT_AMOUNT,B.CHR_LOANNAME,Getcredit(A.CHR_EMPID,A.INT_LOANID),GetDebit(A.CHR_EMPID,A.INT_LOANID),(Getcredit(A.CHR_EMPID,A.INT_LOANID)-GetDebit(A.CHR_EMPID,A.INT_LOANID)) FROM  pay_t_loancredit A,pay_m_loan B,com_m_staff C WHERE A.INT_LOANID=B.INT_LOANID  AND C.CHR_EMPID = A.CHR_EMPID";
        sql = String.valueOf(sql) + " AND A.CHR_EMPID = '" + Empid + "'";
        sql = String.valueOf(sql) + " AND A.INT_LOANID = " + loantype;
        sql = String.valueOf(sql) + " GROUP BY A.CHR_EMPID ";
        System.out.println("sql....." + sql);
        readData = CommonFunctions.QueryExecute(sql);
        totalamt = readData[0][5];
      } else {
        System.out.println("else path");
        String sql = "";
        sql = "select GetSumcredit(CHR_EMPID),GetSumdebit(CHR_EMPID),(GetSumcredit(CHR_EMPID)-GetSumdebit(CHR_EMPID)) from pay_t_loancredit where ";
        if (!"0".equals(Empid))
          sql = String.valueOf(sql) + "CHR_EMPID = '" + Empid + "'"; 
        sql = String.valueOf(sql) + " GROUP BY CHR_EMPID ";
        System.out.println("sql....." + sql);
        readData = CommonFunctions.QueryExecute(sql);
        totalamt = readData[0][2];
      } 
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<creditamt>" + totalamt + "</creditamt>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        sb.append("<Row>");
        sb.append("<creditamt>0</creditamt>");
        sb.append("</Row>");
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
}
