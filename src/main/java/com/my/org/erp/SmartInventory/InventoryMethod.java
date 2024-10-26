package com.my.org.erp.SmartInventory;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartInventory.InventoryInvoiceFunctions;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.file.FileFunctions;
import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class InventoryMethod extends HttpServlet {
  public static void loadItemsData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String search = request.getParameter("search");
      String group = request.getParameter("group");
      String sql = "";
      sql = "  SELECT b.CHR_GROUPNAME,a.CHR_ITEMID,a.CHR_ITEMNAME,a.CHR_DES,a.INT_ACTIVE,a.DOU_PURCHASEPRICE,a.DOU_SALESPRICE,a.CHR_WARRANTY,a.INT_ITEMID ";
      sql = String.valueOf(sql) + " FROM inv_m_item  a, inv_m_itemgroup b WHERE a.INT_ITEMGROUPID = b.INT_ITEMGROUPID";
      if (!"0".equals(group))
        sql = String.valueOf(sql) + " AND a.INT_ITEMGROUPID=" + group + "   "; 
      if (!"".equals(search) && 
        !"0".equals(search))
        sql = String.valueOf(sql) + " AND a.CHR_ITEMNAME LIKE '%" + search + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_ITEMNAME ";
      StringBuffer sb = new StringBuffer();
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<group>" + readData[u][0].trim().replace("&", " and ").replaceAll(">", "") + "</group>");
          sb.append("<id>" + readData[u][1] + "</id>");
          sb.append("<itemName>" + readData[u][2].trim().replace("&", " and ").replaceAll(">", "") + "</itemName>");
          sb.append("<itemDes>" + readData[u][3].trim().replace("&", " and ").replaceAll(">", "") + "</itemDes>");
          sb.append("<itemActive>" + readData[u][4] + "</itemActive>");
          sb.append("<itemPurPrice>" + readData[u][5] + "</itemPurPrice>");
          sb.append("<itemSalesPrice>" + readData[u][6] + "</itemSalesPrice>");
          sb.append("<itemWarranty>" + readData[u][7] + "</itemWarranty>");
          sb.append("<Rowid>" + readData[u][8] + "</Rowid>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
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
  
  public static void LoadTermsandconditions(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_CONDITIONID,CHR_CONDITIONNAME,CHR_DES   FROM inv_m_terms_conditions ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_CONDITIONNAME LIKE '" + StartLetter + 
          "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_CONDITIONNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim().replaceAll("&", " and ") + "</Name>");
          sb.append("<Description>" + readData[u][2].trim().replaceAll("&", " and ") + "</Description>");
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
  
  public static void LoadPaymentTermView(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME,CHR_DES   FROM inv_m_paymentterms ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_PAYMENTNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_PAYMENTNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
          sb.append("<Descriptions>" + readData[u][2].trim().replaceAll("&", " and ") + "</Descriptions>");
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
  
  public static void LoadDivision(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String office = request.getParameter("office");
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_DIVIID,CHR_DIVICODE,CHR_DIVISHORTCODE,CHR_EMAILID,CHR_OFFICEIDS,FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID)   FROM inv_m_division WHERE INT_DIVIID >0";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND  CHR_DIVICODE LIKE '" + StartLetter + "%'"; 
      if (!"0".equals(office))
        sql = String.valueOf(sql) + " AND CHR_OFFICEIDS LIKE '%" + office + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY CHR_DIVICODE ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
          sb.append("<Shortcode>" + readData[u][2].trim() + "</Shortcode>");
          sb.append("<Email>" + readData[u][3].trim() + "</Email>");
          String[][] Data = CommonFunctions.QueryExecute("\tSELECT CHR_OFFICENAME FROM com_m_office  WHERE INT_OFFICEID IN (" + readData[u][4] + ") ");
          sql = "";
          if (Data.length > 0) {
            for (int v = 0; v < Data.length; v++)
              sql = String.valueOf(sql) + Data[v][0] + " ,"; 
            sql = sql.substring(0, sql.length() - 1);
          } else {
            sql = " ";
          } 
          sb.append("<Cid>" + sql + "</Cid>");
          sb.append("<Head>" + readData[u][5].trim() + "</Head>");
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
  
  public static void LoadModel(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_MODELID,CHR_MODELCODE   FROM inv_m_model ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_MODELCODE LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_MODELCODE ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadColor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_COLORID,CHR_COLORCODE   FROM inv_m_color ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_COLORCODE LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_COLORCODE ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadMake(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_MAKEID,CHR_MAKENAME,CHR_DESC  FROM inv_m_make  ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_MAKENAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_MAKENAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadUnit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_UNITID,CHR_MEASUREMENT,CHR_SYMBOL,CHR_DESC FROM inv_m_units    ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_MEASUREMENT LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_MEASUREMENT ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Measurement>" + readData[u][1].trim() + "</Measurement>");
          sb.append("<Symbol>" + readData[u][2].trim() + "</Symbol>");
          sb.append("<Desc>" + readData[u][3].trim() + "</Desc>");
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
  
  public static void LoadProcessor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_PROCESSORID,CHR_PROCESSORNAME,CHR_DESC FROM inv_m_processor ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_PROCESSORNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_PROCESSORNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadChipset(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_CHIPSETID,CHR_CHIPSET,CHR_DESC FROM inv_m_chipset ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_CHIPSET LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_CHIPSET ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadMemory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_MEMORYID,CHR_MEMORYNAME,CHR_DESC FROM inv_m_memory ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_MEMORYNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_MEMORYNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadHarddisk(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_HARDDISKID,CHR_HARDDISKNAME,CHR_DESC FROM inv_m_harddisk ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_HARDDISKNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_HARDDISKNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadGraphics(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_GRAPHICSID,CHR_GRAPHICS,CHR_DESC FROM inv_m_graphics ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_GRAPHICS LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_GRAPHICS ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadMonitor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_MONITORID ,CHR_MONITOR, CHR_DESC FROM inv_m_monitor ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_MONITOR LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_MONITOR ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadWireless(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_WIRELESSID ,CHR_WIRELESS, CHR_DESC  FROM inv_m_wireless ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_WIRELESS LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_WIRELESS ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadLAN(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_LANID ,CHR_LAN, CHR_DESC FROM inv_m_lan ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_LAN LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_LAN ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadOpticalDrive(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_OPTICALID ,CHR_OPTICAL, CHR_DESC FROM inv_m_opticaldrive ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_OPTICAL LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_OPTICAL ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadOperatingSystem(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_OSID ,INT_OSNAME, CHR_DESC FROM inv_m_operatingsystem ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  INT_OSNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY INT_OSNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadCourier(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_COURIERID,CHR_COURIERNAME   FROM inv_m_courier ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_COURIERNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_COURIERNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadTax(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = "  SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE,CHR_DES,if(CHR_FLAG ='Y','In-State','Out-State'),DOU_IGST,DOU_SGST,DOU_CGST  FROM inv_m_tax ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_TAXNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_TAXNAME,CHR_FLAG ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
          sb.append("<Value>" + readData[u][2].trim() + "</Value>");
          sb.append("<Flag>" + readData[u][4].trim() + "</Flag>");
          sb.append("<IGST>" + readData[u][5].trim() + "</IGST>");
          sb.append("<SGST>" + readData[u][6].trim() + "</SGST>");
          sb.append("<CGST>" + readData[u][7].trim() + "</CGST>");
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
  
  public static void LoadPaymentCondition(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_PAYMENTCONDITIONID,CHR_PAYMENTNAME,CHR_DES   FROM inv_m_paymentcondition ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_PAYMENTNAME LIKE '" + StartLetter + 
          "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_PAYMENTNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
          sb.append("<Description>" + readData[u][2].trim().replaceAll("&", " and ") + "</Description>");
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
  
  public static void loadBanks(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String producttxtstr = request.getParameter("startLetter");
      String searchtype = request.getParameter("searchtype");
      String bankgroup = request.getParameter("bankgroup");
      String sql = "";
      sql = " SELECT ";
      sql = String.valueOf(sql) + "  a.INT_BANKID,b.CHR_BANKGROUPNAME,a.CHR_BRANCH,a.CHR_BRANCHCODE,a.CHR_IFSCCODE, ";
      sql = String.valueOf(sql) + "  a.CHR_ADDRESS1,a.CHR_ADDRESS2,f.CHR_CITYNAME,e.CHR_DISTRICT,d.CHR_STATENAME,a.INT_PINCODE, ";
      sql = String.valueOf(sql) + "  a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE ";
      sql = String.valueOf(sql) + "  FROM com_m_bank a  , com_m_bankgroup b, ";
      sql = String.valueOf(sql) + "  com_m_country c,com_m_state d,com_m_district e,  com_m_city f ";
      sql = String.valueOf(sql) + "  WHERE a.INT_BANKGROUPID=b.INT_BANKGROUPID ";
      sql = String.valueOf(sql) + "  AND a.INT_COUNTRYID = c.INT_COUNTRYID   ";
      sql = String.valueOf(sql) + "  AND a.INT_STATEID =d.INT_STATEID     ";
      sql = String.valueOf(sql) + "  AND a.INT_DISTRICTID= e.INT_DISTRICTID    ";
      sql = String.valueOf(sql) + "  AND a.INT_CITYID =f.INT_CITYID  ";
      if (!"0".equals(bankgroup))
        sql = String.valueOf(sql) + "  AND a.INT_BANKGROUPID=" + bankgroup; 
      if (!"0".equals(producttxtstr))
        if ("2".equals(searchtype)) {
          sql = String.valueOf(sql) + " AND a.CHR_BRANCH like '" + producttxtstr + "%' ";
        } else {
          sql = String.valueOf(sql) + " AND a.CHR_BRANCH like '" + producttxtstr + "%' ";
        }  
      sql = String.valueOf(sql) + " ORDER BY a.CHR_BRANCH  ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Group>" + readData[u][1].trim().replace("&", " And ") + "</Group>");
          sb.append("<Branch>" + readData[u][2].trim().replace("&", " And ") + "</Branch>");
          sb.append("<BranchCode>" + readData[u][3] + "</BranchCode>");
          sb.append("<IFSC>" + readData[u][4] + "</IFSC>");
          sb.append("<Address1>" + readData[u][5] + "</Address1>");
          sb.append("<Address2>" + readData[u][6] + "</Address2>");
          sb.append("<City>" + readData[u][7] + "</City>");
          sb.append("<District>" + readData[u][8] + "</District>");
          sb.append("<State>" + readData[u][9] + "</State>");
          sb.append("<Pin>" + readData[u][10] + "</Pin>");
          sb.append("<Mobile>" + readData[u][11] + "</Mobile>");
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
  
  public static void LoadItemGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_ITEMGROUPID,CHR_GROUPNAME   FROM inv_m_itemgroup ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_GROUPNAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY TRIM(CHR_GROUPNAME) ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void loadItemData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String search = request.getParameter("search");
      String sql = "";
      if ("".equals(search) || "null".equals(search)) {
        sql = " SELECT CHR_ITEMID,CHR_ITEMNAME  FROM inv_m_item ORDER BY CHR_ITEMNAME";
      } else {
        sql = " SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMNAME LIKE '" + 
          search + "%' ORDER BY CHR_ITEMNAME";
      } 
      StringBuffer sb = new StringBuffer();
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<itemName>" + readData[u][1] + "</itemName>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
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
  
  public static void LoadProductGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_PRODUCTGROUPID,CHR_NAME   FROM inv_m_productgroup ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_NAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void loadProductList(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USRTYPE");
      String search = request.getParameter("search");
      String group = request.getParameter("group");
      String active = request.getParameter("active");
      String type = request.getParameter("type");
      String sql = "";
      sql = " SELECT a.INT_PRODUCTIDS,b.CHR_NAME,a.CHR_PRODUCTCODE,LEFT(a.CHR_PRODUCTDESC,300), a.CHR_WARRANTY,a.INT_ACTIVE , ";
      sql = String.valueOf(sql) + "  if(a.CHR_PTYPE ='F','Full Product',if(a.CHR_PTYPE='S' ,'Consumables','Swap Product')) , b.CHR_CONFIGURATION  ";
      sql = String.valueOf(sql) + "  FROM inv_m_produtlist a , inv_m_productgroup b ";
      sql = String.valueOf(sql) + "  WHERE a.INT_PRODUCTGROUPID = b.INT_PRODUCTGROUPID ";
      if (!"0".equals(group))
        sql = String.valueOf(sql) + " AND a.INT_PRODUCTGROUPID=" + group + "   "; 
      if (!"0".equals(type))
        sql = String.valueOf(sql) + " AND a.CHR_PTYPE  = '" + type + "'   "; 
      if (!"-1".equals(active))
        sql = String.valueOf(sql) + " AND a.INT_ACTIVE =" + active + "   "; 
      if (!"".equals(search) && 
        !"0".equals(search))
        sql = String.valueOf(sql) + " AND a.CHR_PRODUCTCODE LIKE '%" + search + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_PRODUCTCODE  LIMIT 1000";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sql = readData[u][3];
          sql = sql.replaceAll("&", " and ");
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<groupid>" + readData[u][1].trim().replace("&", " and ").replaceAll(">", "") + "</groupid>");
          sb.append("<Name>" + readData[u][2].trim().replace("&", " and ").replaceAll(">", "") + "</Name>");
          sb.append("<desc>" + sql + "</desc>");
          sb.append("<warranty>" + readData[u][4].trim() + "</warranty>");
          sb.append("<active>" + readData[u][5].trim() + "</active>");
          sb.append("<type>" + readData[u][6].trim() + "</type>");
          sb.append("<Innerconfig>" + readData[u][7].trim() + "</Innerconfig>");
          sb.append("<usertype>" + object + "</usertype>");
          sb.append("</Row>");
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
  
  public static void LoadCustomerType(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_CUSTOMERTYPEID,CHR_TYPENAME   FROM inv_m_customertype ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_TYPENAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_TYPENAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
  
  public static void LoadCustomerGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_CUSTOMERGROUPID,UPPER(CHR_NAME),CHR_SHORT   FROM inv_m_customergroup ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_NAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim().replaceAll("&", " AND ") + "</Name>");
          sb.append("<Short>" + readData[u][2].trim().replaceAll("&", " AND ") + "</Short>");
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
  
  public static void loadAllCustomerData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String producttxtstr = request.getParameter("startLetter");
      String searchtype = request.getParameter("searchtype");
      String verified = request.getParameter("verified");
      String customertype = request.getParameter("customertype");
      String customergroup = request.getParameter("customergroup");
      String sql = "";
      sql = String.valueOf(sql) + " SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME, ";
      sql = String.valueOf(sql) + " CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE), ";
      sql = String.valueOf(sql) + "  a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL, a.CHR_VERIFIED ,a.CHR_ALIASNAME ,a.INT_PINCODE, a.CHR_TAXEXAMPTION, a.CHR_TAXEXAMPTIONNO ";
      sql = String.valueOf(sql) + " FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f ";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   ";
      sql = String.valueOf(sql) + " AND a.INT_STATEID =c.INT_STATEID   ";
      sql = String.valueOf(sql) + " AND a.INT_DISTRICTID= d.INT_DISTRICTID ";
      sql = String.valueOf(sql) + " AND a.INT_CITYID =e.INT_CITYID ";
      if (!"0".equals(customertype))
        sql = String.valueOf(sql) + " AND  a.INT_CUSTOMERTYPEID =" + customertype; 
      if (!"0".equals(customergroup))
        sql = String.valueOf(sql) + " AND  a.INT_CUSTOMERGROUPID =" + customergroup; 
      if (!"0".equals(verified))
        sql = String.valueOf(sql) + " AND  a.CHR_VERIFIED ='" + verified + "'"; 
      if (!"0".equals(producttxtstr))
        if ("2".equals(searchtype)) {
          sql = String.valueOf(sql) + " AND ( f.CHR_NAME like '%" + producttxtstr + "%'  OR  a.INT_PINCODE='%" + producttxtstr + "%' ) ";
        } else {
          sql = String.valueOf(sql) + " AND ( f.CHR_NAME like '%" + producttxtstr + "%' OR   a.INT_PINCODE='%" + producttxtstr + "%' ) ";
        }  
      sql = String.valueOf(sql) + " ORDER BY f.CHR_NAME  LIMIT 1000 ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Customer>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].trim().replace("&", " And ") + "</Name>");
          sb.append("<Cperson>" + readData[u][2].trim().replace("&", " And ") + "</Cperson>");
          sb.append("<City>" + readData[u][3] + "</City>");
          sb.append("<District>" + readData[u][4] + "</District>");
          sb.append("<State>" + readData[u][5] + "</State>");
          sb.append("<Pin>" + readData[u][6] + "</Pin>");
          sb.append("<Mobile>" + readData[u][7] + "</Mobile>");
          sb.append("<Active>" + readData[u][8] + "</Active>");
          sb.append("<Phone>" + readData[u][9] + "</Phone>");
          sb.append("<Email>" + readData[u][10] + "</Email>");
          sb.append("<Verified>" + readData[u][11] + "</Verified>");
          sb.append("<Alias>" + readData[u][12].trim().replace("&", " And ") + "</Alias>");
          sb.append("<Pincode>" + readData[u][13] + "</Pincode>");
          sb.append("<taxexamption>" + readData[u][14] + "</taxexamption>");
          sb.append("<taxexamptionno>" + readData[u][15] + "</taxexamptionno>");
          sb.append("</Customer>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
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
  
  public static void LoadVendorGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_GROUPID,CHR_NAME   FROM inv_m_vendorsgroup ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_NAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadAllVendor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String producttxtstr = request.getParameter("startLetter");
      String searchtype = request.getParameter("searchtype");
      String sql = "";
      sql = String.valueOf(sql) + " SELECT a.INT_VENDORID,a.CHR_VENDORNAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT, ";
      sql = String.valueOf(sql) + " c.CHR_STATENAME,  ";
      sql = String.valueOf(sql) + " CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE), ";
      sql = String.valueOf(sql) + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL   ";
      sql = String.valueOf(sql) + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d, ";
      sql = String.valueOf(sql) + " com_m_city e  ,inv_m_vendorsgroup f  ";
      sql = String.valueOf(sql) + " WHERE a.INT_GROUPID = f.INT_GROUPID ";
      sql = String.valueOf(sql) + " AND a.INT_COUNTRYID = b.INT_COUNTRYID  ";
      sql = String.valueOf(sql) + " AND a.INT_STATEID =c.INT_STATEID    ";
      sql = String.valueOf(sql) + " AND a.INT_DISTRICTID= d.INT_DISTRICTID ";
      sql = String.valueOf(sql) + " AND a.INT_CITYID =e.INT_CITYID  ";
      if (!"0".equals(producttxtstr))
        if ("2".equals(searchtype)) {
          sql = String.valueOf(sql) + " AND a.CHR_VENDORNAME like '" + producttxtstr + 
            "%' ";
        } else {
          sql = String.valueOf(sql) + " AND a.CHR_VENDORNAME like '" + producttxtstr + 
            "%' ";
        }  
      sql = String.valueOf(sql) + " ORDER BY a.CHR_VENDORNAME  ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Customer>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].trim().replace("&", " And ") + "</Name>");
          sb.append("<Cperson>" + readData[u][2].trim().replace("&", " And ") + "</Cperson>");
          sb.append("<City>" + readData[u][3] + "</City>");
          sb.append("<District>" + readData[u][4] + "</District>");
          sb.append("<State>" + readData[u][5] + "</State>");
          sb.append("<Pin>" + readData[u][6] + "</Pin>");
          sb.append("<Mobile>" + readData[u][7] + "</Mobile>");
          sb.append("<Active>" + readData[u][8] + "</Active>");
          sb.append("<Phone>" + readData[u][9] + "</Phone>");
          sb.append("<Email>" + readData[u][10] + "</Email>");
          sb.append("</Customer>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
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
  
  public static void loadStock(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String type = request.getParameter("type");
      String search = request.getParameter("search");
      String sval = request.getParameter("sval");
      String Branch = request.getParameter("branch");
      String division = request.getParameter("division");
      String sql = "";
      if ("".equals(search) || "null".equals(search)) {
        if ("I".equals(type))
          if (sval.equals("0")) {
            sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE  FROM inv_m_item WHERE INT_DIVIID = " + 
              division + " ORDER BY CHR_ITEMNAME ";
          } else {
            sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE  FROM inv_m_item  WHERE INT_DIVIID = " + 
              division + 
              " AND CHR_ITEMNAME LIKE '" + 
              sval + 
              "%' ORDER BY CHR_ITEMNAME";
          }  
        if ("P".equals(type))
          if (sval.equals("0")) {
            sql = " SELECT CHR_PRODUCTID, CHR_PRODUCTCODE,CHR_PTYPE FROM inv_m_produtlist WHERE INT_DIVIID = " + 
              division + " ORDER BY CHR_PRODUCTCODE";
          } else {
            sql = " SELECT CHR_PRODUCTID, CHR_PRODUCTCODE ,CHR_PTYPE FROM inv_m_produtlist WHERE  INT_DIVIID = " + 
              division + 
              " AND CHR_PRODUCTCODE LIKE '" + 
              sval + "%' ORDER BY CHR_PRODUCTCODE";
          }  
      } else {
        if ("I".equals(type))
          sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE FROM inv_m_item  WHERE  INT_DIVIID = " + 
            division + 
            "  AND CHR_ITEMNAME LIKE '" + 
            search + 
            "%'ORDER BY CHR_ITEMNAME"; 
        if ("P".equals(type))
          sql = "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PTYPE   FROM inv_m_produtlist   WHERE INT_DIVIID = " + 
            division + 
            " AND CHR_PRODUCTCODE LIKE '" + 
            search + 
            "%' ORDER BY CHR_PRODUCTCODE"; 
      } 
      StringBuffer sb = new StringBuffer();
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<stock>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<itemName>" + readData[u][1] + "</itemName>");
          sql = "SELECT COUNT(*)  FROM inv_t_stock WHERE CHR_ITEMID ='" + 
            readData[u][0] + 
            "' AND  CHR_TYPE='" + 
            type + 
            "' AND INT_BRANCHID =" + Branch;
          int sth = 0;
          if (!CommonFunction.RecordExist(sql)) {
            sb.append("<itemStockIn>" + sth + "</itemStockIn>");
            sb.append("<itemAveragePrice>0</itemAveragePrice>");
            sb.append("<itemLastSale>-</itemLastSale>");
            sb.append("<ptype>-</ptype>");
          } else {
            sql = "SELECT INT_STOCKINHAND,DAT_SALESDATE FROM inv_t_stock WHERE CHR_ITEMID ='" + 
              readData[u][0] + 
              "' AND  CHR_TYPE='" + 
              type + 
              "' AND INT_BRANCHID =" + Branch;
            String[][] stockData = 
              CommonFunctions.QueryExecute(sql);
            sb.append("<itemLastSale>" + stockData[0][1] + 
                "</itemLastSale>");
            if ("P".equals(type) && "S".equals(readData[u][2])) {
              sql = " SELECT DOU_AVGPRICE FROM inv_t_averageprice";
              sql = String.valueOf(sql) + "\tWHERE  CHR_TYPE='" + type + "' ";
              sql = String.valueOf(sql) + "\tAND CHR_ITEMID='" + readData[u][0] + 
                "'  ";
              sql = String.valueOf(sql) + "\tAND INT_BRANCHID= " + Branch;
              sb.append("<itemStockIn>" + stockData[0][0] + 
                  "</itemStockIn>");
              if (CommonFunction.RecordExist(sql)) {
                String[][] stockAverageprice = 
                  CommonFunctions.QueryExecute(sql);
                sb.append("<itemAveragePrice>" + 
                    CommonFunctions.Round(
                      Double.parseDouble(stockAverageprice[0][0])) + 
                    "</itemAveragePrice>");
              } else {
                sb.append("<itemAveragePrice>0</itemAveragePrice>");
              } 
              sb.append("<ptype>S</ptype>");
            } else {
              String sssql = "SELECT COUNT(*)  FROM inv_t_vendorgoodsreceived WHERE CHR_ITEMID ='" + 
                readData[u][0].trim() + 
                "' AND CHR_FLAG <> 'Y'  AND CHR_SERIALNO is not null  AND  CHR_TYPE='" + 
                type.trim() + 
                "' AND INT_BRANCHID =" + 
                Branch.trim();
              sth = 
                CommonFunction.intRecordCount(sssql);
              sb.append("<itemStockIn>" + sth + "</itemStockIn>");
              sql = " SELECT (sum(DOU_UNITPRICE)/(SELECT count(*) FROM inv_t_vendorgoodsreceived ";
              sql = String.valueOf(sql) + 
                "\tWHERE CHR_FLAG ='N' and CHR_GRTFLAG='N' AND CHR_ITEMID='" + 
                readData[u][0] + 
                "'  AND CHR_SERIALNO is not null AND CHR_TYPE='" + 
                type + "'AND INT_BRANCHID=" + Branch + 
                " ))  FROM inv_t_vendorgoodsreceived ";
              sql = String.valueOf(sql) + 
                "\tWHERE CHR_FLAG ='N' and CHR_GRTFLAG='N' AND CHR_ITEMID='" + 
                readData[u][0] + 
                "'  AND CHR_SERIALNO is not null AND CHR_TYPE='" + 
                type + "' AND INT_BRANCHID=" + Branch;
              sql = String.valueOf(sql) + "\tgroup by CHR_ITEMID ";
              if (CommonFunction.RecordExist(sql)) {
                String[][] stockAverageprice = 
                  CommonFunctions.QueryExecute(sql);
                sb.append("<itemAveragePrice>" + 
                    CommonFunctions.Round(
                      Double.parseDouble(stockAverageprice[0][0])) + 
                    "</itemAveragePrice>");
              } else {
                sb.append("<itemAveragePrice>0</itemAveragePrice>");
              } 
              sb.append("<ptype>-</ptype>");
            } 
          } 
          sb.append("<Branch>" + Branch + "</Branch>");
          sb.append("</stock>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<stocks>" + sb.toString() + "</stocks>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadStockAll(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      StringBuffer sb = new StringBuffer();
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<stock>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<itemName>" + readData[u][1] + "</itemName>");
          if (!CommonFunction.RecordExist(sql)) {
            sb.append("<itemStockIn>0</itemStockIn>");
          } else {
            String[][] stockData = 
              CommonFunctions.QueryExecute(sql);
            sb.append("<itemStockIn>" + stockData[0][0] + 
                "</itemStockIn>");
          } 
          sb.append("</stock>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<stocks>" + sb.toString() + "</stocks>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadDemo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USRTYPE");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String txtSer = request.getParameter("startLetter");
      String Branch = request.getParameter("Branch");
      String sql = "";
      sql = " SELECT INT_DEMOID,FUN_GET_BRANCH_NAME(INT_BRANCHID),CHR_CUSTNAME,DATE_FORMAT(DT_DEMODATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + " CHR_STATUS,FIND_A_EMPLOYEE_ID_NAME(CHR_AUTHORISEDBY),FIND_A_EMPLOYEE_ID_NAME(CHR_HANDLEDBY) ";
      sql = String.valueOf(sql) + " FROM   inv_t_demo WHERE INT_DEMOID ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(DT_DEMODATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(DT_DEMODATE) = " + year; 
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND INT_BRANCHID = " + Branch; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND CHR_STATUS = '" + status + "' "; 
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND CHR_CUSTNAME LIKE '" + txtSer + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY CHR_CUSTNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<BName>" + readData[u][1] + "</BName>");
          sb.append("<Name>" + readData[u][2] + "</Name>");
          sb.append("<Date>" + readData[u][3] + "</Date>");
          sb.append("<Status>" + readData[u][4] + "</Status>");
          sb.append("<Authorised>" + readData[u][5] + "</Authorised>");
          sb.append("<Handle>" + readData[u][6] + "</Handle>");
          sb.append("<usertype>" + object + "</usertype>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception exception) {}
  }
  
  public static void INVSalesNumberItems(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String type = request.getParameter("returnType");
      String saleno = request.getParameter("saleno");
      String tablename = "";
      String field = " SELECT INT_ID,CHR_SALESORDERNO,CHR_ITEMID,CHR_TYPE,CHR_SERIALNO,CHR_WARRANTY,CHR_GRTFLAG FROM";
      String field1 = " SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_SERIALNO,CHR_WARRANTY,CHR_GRTFLAG FROM ";
      if (type.equals("Invoice")) {
        tablename = String.valueOf(field) + 
          " inv_t_customersalesorderitemserial WHERE CHR_SALESORDERNO ='" + 
          saleno + "'  ORDER BY INT_ID";
      } else if (type.equals("CashPay")) {
        tablename = String.valueOf(field1) + 
          " inv_t_cashserialno  WHERE CHR_SALESNO ='" + saleno + 
          "'  ORDER BY INT_ID";
      } else if (type.equals("Direct")) {
        tablename = " SELECT a.INT_ID,a.CHR_SALESNO, ";
        tablename = String.valueOf(tablename) + "  a.CHR_ITEMID, ";
        tablename = String.valueOf(tablename) + "  if(a.CHR_TYPE='I' , ";
        tablename = String.valueOf(tablename) + 
          "   ( SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID), ";
        tablename = String.valueOf(tablename) + 
          "    ( SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID) ";
        tablename = String.valueOf(tablename) + "    ), ";
        tablename = String.valueOf(tablename) + 
          "  if(a.CHR_TYPE='I' ,'Item','Product'), ";
        tablename = String.valueOf(tablename) + "    ";
        tablename = String.valueOf(tablename) + 
          "   a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_GRTFLAG ";
        tablename = String.valueOf(tablename) + "  FROM   inv_t_swapsalesserialno  a ";
        tablename = String.valueOf(tablename) + " WHERE a.CHR_SALESNO ='" + saleno + 
          "'  ORDER BY a.INT_ID";
      } 
      sql = tablename;
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Record>");
          for (int y = 0; y < 7; y++)
            sb.append("<Column" + (y + 1) + ">" + readData[u][y] + 
                "</Column" + (y + 1) + ">"); 
          sb.append("</Record>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Records>" + sb.toString() + "</Records>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadBranchess(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String officeid = request.getParameter("office");
      int id = Integer.parseInt(officeid);
      String sql = "";
      sql = " SELECT b.INT_COMPANYID,UPPER(a.CHR_COMPANYNAME),b.INT_BRANCHID,UPPER(b.CHR_BRANCHNAME) FROM com_m_branch b, com_m_company a   WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
      sql = String.valueOf(sql) + 
        " AND SOUNDEX(b.CHR_BRANCHNAME) = SOUNDEX((SELECT CHR_OFFICENAME FROM  com_m_office  WHERE INT_OFFICEID = " + 
        id + ")) AND a.INT_ACTIVE =1  AND b.INT_ACTIVE =1 ORDER BY a.CHR_COMPANYNAME ";
      StringBuffer sb = new StringBuffer();
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      String Selection = 
        CommonFunctions.QueryExecute("SELECT  INT_COMPANYSELECTION FROM m_institution WHERE INT_ID=1")[0][0];
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<branch>");
          sb.append("<Companyid>" + readData[u][0] + "</Companyid>");
          sb.append("<CompanyName>" + readData[u][1] + 
              "</CompanyName>");
          sb.append("<Branchid>" + readData[u][2] + "</Branchid>");
          sb.append("<Selection>" + Selection + "</Selection>");
          sb.append("<BranchName>" + readData[u][3] + "</BranchName>");
          sb.append("</branch>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<branches>" + sb.toString() + "</branches>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadConveyance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String fromdate = request.getParameter("fromdate");
      String todate = request.getParameter("todate");
      fromdate = DateUtil.FormateDateSQL(fromdate);
      todate = DateUtil.FormateDateSQL(todate);
      String sql = "";
      HttpSession session = request.getSession();
      Object object = session.getAttribute("EMPID");
      sql = "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_REPTO='" + 
        object + 
        "' AND CHR_TYPE!='T' AND CHR_HOLD!='Y'order by CHR_STAFFNAME ";
      String[][] Data = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      int entry = 0;
      if (Data.length > 0) {
        for (int u = 0; u < Data.length; u++) {
          sql = " SELECT count(*),sum(DOU_TOTAL) FROM conveyance_t_conveyance WHERE CHR_STATUS='N' AND  (DAT_CONDATE)>='" + 
            fromdate + 
            "' AND (DAT_CONDATE)<='" + 
            todate + 
            "'AND CHR_EMPID='" + Data[u][0] + "'";
          String[][] readData = 
            CommonFunctions.QueryExecute(sql);
          entry = Integer.parseInt(readData[0][0]);
          if (entry > 0) {
            sb.append("<Conveyance>");
            sb.append("<Staffid>" + Data[u][0] + "</Staffid>");
            sb.append("<Staffname>" + Data[u][1] + "</Staffname>");
            sb.append("<noofentry>" + readData[0][0] + 
                "</noofentry>");
            sb.append("<amount>" + readData[0][1] + "</amount>");
            sb.append("</Conveyance>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Conveyances>" + sb.toString() + "</Conveyances>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadTargetAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String year = request.getParameter("year");
      String office = request.getParameter("office");
      String dept = request.getParameter("dept");
      String startletter = request.getParameter("startletter");
      String[][] OfficeData = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN(" + 
          
          CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='" + 
            
            session.getAttribute("USRID") + 
            "' ")[0][0] + " )");
      String officeids = "";
      if (OfficeData.length > 0)
        for (int u = 0; u < OfficeData.length; u++)
          officeids = String.valueOf(officeids) + OfficeData[u][0] + ",";  
      String sql = "";
      sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN, b.INT_JUL,";
      sql = String.valueOf(sql) + " b.INT_AUG, b.INT_SEP, b.INT_OCT, b.INT_NOV, b.INT_DEC, b.INT_JAN, b.INT_FEB, ";
      sql = String.valueOf(sql) + " b.INT_MAR,b.INT_TARGETID FROM com_m_staff a , inv_t_targetassign b ";
      sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
      if (!"0".equals(startletter))
        sql = String.valueOf(sql) + "  AND a.CHR_STAFFNAME like '" + startletter + "%'"; 
      if (!"0".equals(office)) {
        sql = String.valueOf(sql) + " AND a.INT_OFFICEID =" + office;
      } else {
        sql = String.valueOf(sql) + " AND a.INT_OFFICEID IN(" + officeids + "0) ";
      } 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + "  AND a.INT_DEPARTID=" + dept; 
      String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
      String empids = "";
      if (empid.length > 0)
        for (int i = 0; i < empid.length; i++)
          empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
      sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
      sql = String.valueOf(sql) + "  AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] Data = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (Data.length > 0) {
        for (int u = 0; u < Data.length; u++) {
          sb.append("<TargetAssign>");
          sb.append("<Staffid>" + Data[u][0] + "</Staffid>");
          sb.append("<Staffname>" + Data[u][1] + "</Staffname>");
          sb.append("<APR>" + Data[u][2] + "</APR>");
          sb.append("<MAY>" + Data[u][3] + "</MAY>");
          sb.append("<JUN>" + Data[u][4] + "</JUN>");
          sb.append("<JUL>" + Data[u][5] + "</JUL>");
          sb.append("<AUG>" + Data[u][6] + "</AUG>");
          sb.append("<SEP>" + Data[u][7] + "</SEP>");
          sb.append("<OCT>" + Data[u][8] + "</OCT>");
          sb.append("<NOV>" + Data[u][9] + "</NOV>");
          sb.append("<DEC>" + Data[u][10] + "</DEC>");
          sb.append("<JAN>" + Data[u][11] + "</JAN>");
          sb.append("<FEB>" + Data[u][12] + "</FEB>");
          sb.append("<MAR>" + Data[u][13] + "</MAR>");
          sb.append("<ROW>" + Data[u][14] + "</ROW>");
          sb.append("</TargetAssign>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
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
  
  public static void loadDivisionTargetAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String year = request.getParameter("year");
      String division = request.getParameter("division");
      String startletter = request.getParameter("startletter");
      String sql = "";
      sql = "SELECT b.INT_TARGETDIVIID,a.CHR_DIVICODE , b.INT_APR, b.INT_MAY, b.INT_JUN, b.INT_JUL,";
      sql = String.valueOf(sql) + " b.INT_AUG, b.INT_SEP, b.INT_OCT, b.INT_NOV, b.INT_DEC, b.INT_JAN, b.INT_FEB, ";
      sql = String.valueOf(sql) + " b.INT_MAR, ";
      sql = String.valueOf(sql) + "( b.INT_APR+ b.INT_MAY+ b.INT_JUN+ b.INT_JUL+ b.INT_AUG+ b.INT_SEP+ b.INT_OCT+ b.INT_NOV+ b.INT_DEC+ b.INT_JAN+ b.INT_FEB+b.INT_MAR ) ";
      sql = String.valueOf(sql) + " FROM inv_m_division a , inv_t_targetassign_division b ";
      sql = String.valueOf(sql) + " WHERE a.INT_DIVIID =b.INT_DIVIID ";
      if (!"0".equals(startletter))
        sql = String.valueOf(sql) + "  AND a.CHR_DIVICODE like '" + startletter + "%'"; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID =" + division; 
      sql = String.valueOf(sql) + "  AND b.INT_YEAR = " + year;
      sql = String.valueOf(sql) + "    ORDER BY a.CHR_DIVICODE ";
      System.out.println(sql);
      String[][] Data = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (Data.length > 0) {
        for (int u = 0; u < Data.length; u++) {
          sb.append("<TargetAssign>");
          sb.append("<ROW>" + Data[u][0] + "</ROW>");
          sb.append("<Division>" + Data[u][1] + "</Division>");
          sb.append("<APR>" + Data[u][2] + "</APR>");
          sb.append("<MAY>" + Data[u][3] + "</MAY>");
          sb.append("<JUN>" + Data[u][4] + "</JUN>");
          sb.append("<JUL>" + Data[u][5] + "</JUL>");
          sb.append("<AUG>" + Data[u][6] + "</AUG>");
          sb.append("<SEP>" + Data[u][7] + "</SEP>");
          sb.append("<OCT>" + Data[u][8] + "</OCT>");
          sb.append("<NOV>" + Data[u][9] + "</NOV>");
          sb.append("<DEC>" + Data[u][10] + "</DEC>");
          sb.append("<JAN>" + Data[u][11] + "</JAN>");
          sb.append("<FEB>" + Data[u][12] + "</FEB>");
          sb.append("<MAR>" + Data[u][13] + "</MAR>");
          sb.append("<SUM>" + Data[u][14] + "</SUM>");
          sb.append("</TargetAssign>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
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
  
  public static void LoadTargetAssignAll(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object1 = session.getAttribute("USRTYPE");
      Object object2 = session.getAttribute("EMPID");
      String years = request.getParameter("year");
      String office = request.getParameter("office");
      String dept = request.getParameter("dept");
      String period = request.getParameter("period");
      String sql = "";
      int year = Integer.parseInt(years);
      if ("1".equals(period)) {
        sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN,(b.INT_APR+ b.INT_MAY+ b.INT_JUN)  FROM com_m_staff a , inv_t_targetassign b ";
        sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
        if ("A".equals(object1))
          sql = String.valueOf(sql) + " AND a.CHR_EMPID='" + object2 + "' "; 
        if (!"0".equals(office))
          sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + office; 
        if (!"0".equals(dept))
          sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
        String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
        String empids = "";
        if (empid.length > 0)
          for (int i = 0; i < empid.length; i++)
            empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
        sql = String.valueOf(sql) + "  AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
        String[][] data = CommonFunctions.QueryExecute(sql);
        double salessum = 0.0D;
        double achieve = 0.0D;
        double percent = 0.0D;
        StringBuffer sb = new StringBuffer();
        if (data.length > 0) {
          for (int u = 0; u < data.length; u++) {
            salessum = 0.0D;
            sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' ) ";
              sql = String.valueOf(sql) + " AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              salessum += CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
            } 
            sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year;
            sql = String.valueOf(sql) + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directbilling WHERE CHR_REF='" + 
                data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + 
                year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata1 = CommonFunctions.QueryExecute(sql);
              salessum += CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
            } 
            sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + 
              data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + 
              year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + 
                "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + 
                "-06-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata2 = CommonFunctions.QueryExecute(sql);
              salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
            } 
            salessum = CommonFunctions.Round(salessum);
            achieve = CommonFunctions.Round(salessum / 100000.0D);
            percent = CommonFunctions.Round(achieve / Double.parseDouble(data[u][5]) * 100.0D);
            sb.append("<TargetAssign>");
            sb.append("<Staffid>" + data[u][0] + "</Staffid>");
            sb.append("<Staffname>" + data[u][1] + "</Staffname>");
            sb.append("<Month1>" + data[u][2] + "</Month1>");
            sb.append("<Month2>" + data[u][3] + "</Month2>");
            sb.append("<Month3>" + data[u][4] + "</Month3>");
            sb.append("<Target>" + data[u][5] + "</Target>");
            sb.append("<Sales>" + salessum + "</Sales>");
            sb.append("<achieve>" + achieve + "</achieve>");
            sb.append("<percent>" + percent + "</percent>");
            sb.append("</TargetAssign>");
          } 
          response.setContentType("text/xml");
          response.setHeader("Cache-Control", "no-cache");
          response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
        } else {
          response.setStatus(204);
        } 
      } else if ("2".equals(period)) {
        sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JUL, b.INT_AUG, b.INT_SEP,(b.INT_JUL+ b.INT_AUG+ b.INT_SEP)  FROM com_m_staff a , inv_t_targetassign b ";
        sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
        if (!"0".equals(office))
          sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + office; 
        if (!"0".equals(dept))
          sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
        String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
        String empids = "";
        if (empid.length > 0)
          for (int i = 0; i < empid.length; i++)
            empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
        sql = String.valueOf(sql) + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
        String[][] data = CommonFunctions.QueryExecute(sql);
        double salessum = 0.0D;
        double achieve = 0.0D;
        double percent = 0.0D;
        StringBuffer sb = new StringBuffer();
        if (data.length > 0) {
          for (int u = 0; u < data.length; u++) {
            salessum = 0.0D;
            sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
              year + "-07-01' AND DAT_SALESDATE <='" + 
              year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
                year + "-07-01' AND DAT_SALESDATE <='" + 
                year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              salessum += CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
            } 
            sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              year + 
              "-07-01' AND DAT_SALESDATE <='" + 
              year + 
              "-09-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + 
                year + 
                "-07-01' AND DAT_SALESDATE <='" + 
                year + 
                "-09-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata1 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata1[0][0]));
            } 
            sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              year + 
              "-07-01' AND DAT_SALESDATE <='" + 
              year + 
              "-09-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + 
                year + 
                "-07-01' AND DAT_SALESDATE <='" + 
                year + 
                "-09-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata2 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata2[0][0]));
            } 
            salessum = CommonFunctions.Round(salessum);
            achieve = CommonFunctions.Round(salessum / 100000.0D);
            percent = CommonFunctions.Round(achieve / 
                Double.parseDouble(data[u][5]) * 100.0D);
            sb.append("<TargetAssign>");
            sb.append("<Staffid>" + data[u][0] + "</Staffid>");
            sb.append("<Staffname>" + data[u][1] + "</Staffname>");
            sb.append("<Month1>" + data[u][2] + "</Month1>");
            sb.append("<Month2>" + data[u][3] + "</Month2>");
            sb.append("<Month3>" + data[u][4] + "</Month3>");
            sb.append("<Target>" + data[u][5] + "</Target>");
            sb.append("<Sales>" + salessum + "</Sales>");
            sb.append("<achieve>" + achieve + "</achieve>");
            sb.append("<percent>" + percent + "</percent>");
            sb.append("</TargetAssign>");
          } 
          response.setContentType("text/xml");
          response.setHeader("Cache-Control", "no-cache");
          response.getWriter().write(
              "<TargetAssigns>" + sb.toString() + 
              "</TargetAssigns>");
        } else {
          response.setStatus(204);
        } 
      } else if ("3".equals(period)) {
        sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_OCT, b.INT_NOV, b.INT_DEC,(b.INT_OCT+ b.INT_NOV+ b.INT_DEC)  FROM com_m_staff a , inv_t_targetassign b ";
        sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
        if (!"0".equals(office))
          sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + office; 
        if (!"0".equals(dept))
          sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
        String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
        String empids = "";
        if (empid.length > 0)
          for (int i = 0; i < empid.length; i++)
            empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
        sql = String.valueOf(sql) + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
        String[][] data = 
          CommonFunctions.QueryExecute(sql);
        double salessum = 0.0D;
        double achieve = 0.0D;
        double percent = 0.0D;
        StringBuffer sb = new StringBuffer();
        if (data.length > 0) {
          for (int u = 0; u < data.length; u++) {
            salessum = 0.0D;
            sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
              year + 
              "-10-01' AND DAT_SALESDATE <='" + 
              year + 
              "-12-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
                year + 
                "-10-01' AND DAT_SALESDATE <='" + 
                year + 
                "-12-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata[0][0]));
            } 
            sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              year + 
              "-10-01' AND DAT_SALESDATE <='" + 
              year + 
              "-12-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + 
                year + 
                "-10-01' AND DAT_SALESDATE <='" + 
                year + 
                "-12-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata1 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata1[0][0]));
            } 
            sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              year + 
              "-10-01' AND DAT_SALESDATE <='" + 
              year + 
              "-12-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + 
                year + 
                "-10-01' AND DAT_SALESDATE <='" + 
                year + 
                "-12-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata2 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata2[0][0]));
            } 
            salessum = CommonFunctions.Round(salessum);
            achieve = CommonFunctions.Round(salessum / 100000.0D);
            percent = CommonFunctions.Round(achieve / 
                Double.parseDouble(data[u][5]) * 100.0D);
            sb.append("<TargetAssign>");
            sb.append("<Staffid>" + data[u][0] + "</Staffid>");
            sb.append("<Staffname>" + data[u][1] + "</Staffname>");
            sb.append("<Month1>" + data[u][2] + "</Month1>");
            sb.append("<Month2>" + data[u][3] + "</Month2>");
            sb.append("<Month3>" + data[u][4] + "</Month3>");
            sb.append("<Target>" + data[u][5] + "</Target>");
            sb.append("<Sales>" + salessum + "</Sales>");
            sb.append("<achieve>" + achieve + "</achieve>");
            sb.append("<percent>" + percent + "</percent>");
            sb.append("</TargetAssign>");
          } 
          response.setContentType("text/xml");
          response.setHeader("Cache-Control", "no-cache");
          response.getWriter().write(
              "<TargetAssigns>" + sb.toString() + 
              "</TargetAssigns>");
        } else {
          response.setStatus(204);
        } 
      } else if ("4".equals(period)) {
        sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JAN, b.INT_FEB, b.INT_MAR,(b.INT_JAN+ b.INT_FEB+b.INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
        sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
        if (!"0".equals(office))
          sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + office; 
        if (!"0".equals(dept))
          sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
        String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
        String empids = "";
        if (empid.length > 0)
          for (int i = 0; i < empid.length; i++)
            empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
        sql = String.valueOf(sql) + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
        String[][] data = 
          CommonFunctions.QueryExecute(sql);
        double salessum = 0.0D;
        double achieve = 0.0D;
        double percent = 0.0D;
        StringBuffer sb = new StringBuffer();
        if (data.length > 0) {
          for (int u = 0; u < data.length; u++) {
            salessum = 0.0D;
            sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + (
              year + 1) + 
              "-01-01' AND DAT_SALESDATE <='" + (
              year + 1) + 
              "-03-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + (
                year + 1) + 
                "-01-01' AND DAT_SALESDATE <='" + (
                year + 1) + 
                "-03-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata[0][0]));
            } 
            sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + (
              year + 1) + 
              "-01-01' AND DAT_SALESDATE <='" + (
              year + 1) + 
              "-03-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + (
                year + 1) + 
                "-01-01' AND DAT_SALESDATE <='" + (
                year + 1) + 
                "-03-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata1 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata1[0][0]));
            } 
            sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + (
              year + 1) + 
              "-01-01' AND DAT_SALESDATE <='" + (
              year + 1) + 
              "-03-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + (
                year + 1) + 
                "-01-01' AND DAT_SALESDATE <='" + (
                year + 1) + 
                "-03-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata2 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata2[0][0]));
            } 
            salessum = CommonFunctions.Round(salessum);
            achieve = CommonFunctions.Round(salessum / 100000.0D);
            percent = CommonFunctions.Round(achieve / 
                Double.parseDouble(data[u][5]) * 100.0D);
            sb.append("<TargetAssign>");
            sb.append("<Staffid>" + data[u][0] + "</Staffid>");
            sb.append("<Staffname>" + data[u][1] + "</Staffname>");
            sb.append("<Month1>" + data[u][2] + "</Month1>");
            sb.append("<Month2>" + data[u][3] + "</Month2>");
            sb.append("<Month3>" + data[u][4] + "</Month3>");
            sb.append("<Target>" + data[u][5] + "</Target>");
            sb.append("<Sales>" + salessum + "</Sales>");
            sb.append("<achieve>" + achieve + "</achieve>");
            sb.append("<percent>" + percent + "</percent>");
            sb.append("</TargetAssign>");
          } 
          response.setContentType("text/xml");
          response.setHeader("Cache-Control", "no-cache");
          response.getWriter().write(
              "<TargetAssigns>" + sb.toString() + 
              "</TargetAssigns>");
        } else {
          response.setStatus(204);
        } 
      } else if ("5".equals(period)) {
        sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, INT_APR,INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,INT_DEC,INT_JAN,INT_FEB,INT_MAR ,(INT_APR+INT_MAY+INT_JUN+INT_JUL+INT_AUG+INT_SEP+INT_OCT+INT_NOV+INT_DEC+INT_JAN+INT_FEB+INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
        sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
        if (!"0".equals(office))
          sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + office; 
        if (!"0".equals(dept))
          sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
        String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
        String empids = "";
        if (empid.length > 0)
          for (int i = 0; i < empid.length; i++)
            empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
        sql = String.valueOf(sql) + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
        String[][] data = CommonFunctions.QueryExecute(sql);
        double salessum = 0.0D;
        double achieve = 0.0D;
        double percent = 0.0D;
        StringBuffer sb = new StringBuffer();
        if (data.length > 0) {
          for (int u = 0; u < data.length; u++) {
            salessum = 0.0D;
            sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
              year + 
              "-04-01' AND DAT_SALESDATE <='" + (
              year + 1) + 
              "-03-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
                year + 
                "-04-01' AND DAT_SALESDATE <='" + (
                year + 1) + 
                "-03-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata[0][0]));
            } 
            sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              year + 
              "-04-01' AND DAT_SALESDATE <='" + (
              year + 1) + 
              "-03-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + 
                year + 
                "-04-01' AND DAT_SALESDATE <='" + (
                year + 1) + 
                "-03-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata1 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata1[0][0]));
            } 
            sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              year + 
              "-04-01' AND DAT_SALESDATE <='" + (
              year + 1) + 
              "-03-31' AND CHR_PAYMENTSTATUS !='S'";
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + 
                data[u][0] + 
                "' AND DAT_SALESDATE >='" + 
                year + 
                "-04-01' AND DAT_SALESDATE <='" + (
                year + 1) + 
                "-03-31' AND CHR_PAYMENTSTATUS !='S'";
              String[][] salesdata2 = 
                CommonFunctions.QueryExecute(sql);
              salessum += 
                CommonFunctions.Round(
                  Double.parseDouble(salesdata2[0][0]));
            } 
            salessum = CommonFunctions.Round(salessum);
            achieve = CommonFunctions.Round(salessum / 100000.0D);
            percent = CommonFunctions.Round(achieve / 
                Double.parseDouble(data[u][14]) * 100.0D);
            sb.append("<TargetAssign>");
            sb.append("<Staffid>" + data[u][0] + "</Staffid>");
            sb.append("<Staffname>" + data[u][1] + "</Staffname>");
            sb.append("<Month1>" + data[u][2] + "</Month1>");
            sb.append("<Month2>" + data[u][3] + "</Month2>");
            sb.append("<Month3>" + data[u][4] + "</Month3>");
            sb.append("<Month4>" + data[u][5] + "</Month4>");
            sb.append("<Month5>" + data[u][6] + "</Month5>");
            sb.append("<Month6>" + data[u][7] + "</Month6>");
            sb.append("<Month7>" + data[u][8] + "</Month7>");
            sb.append("<Month8>" + data[u][9] + "</Month8>");
            sb.append("<Month9>" + data[u][10] + "</Month9>");
            sb.append("<Month10>" + data[u][11] + "</Month10>");
            sb.append("<Month11>" + data[u][12] + "</Month11>");
            sb.append("<Month12>" + data[u][13] + "</Month12>");
            sb.append("<Target>" + data[u][14] + "</Target>");
            sb.append("<Sales>" + salessum + "</Sales>");
            sb.append("<achieve>" + achieve + "</achieve>");
            sb.append("<percent>" + percent + "</percent>");
            sb.append("</TargetAssign>");
          } 
          response.setContentType("text/xml");
          response.setHeader("Cache-Control", "no-cache");
          response.getWriter().write(
              "<TargetAssigns>" + sb.toString() + 
              "</TargetAssigns>");
        } else {
          response.setStatus(204);
        } 
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadTargetAssignMonth(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object1 = session.getAttribute("USRTYPE");
      Object object2 = session.getAttribute("EMPID");
      String years = request.getParameter("year");
      String office = request.getParameter("office");
      String dept = request.getParameter("dept");
      String months = request.getParameter("month");
      String sql = "";
      int year = Integer.parseInt(years);
      int month = Integer.parseInt(months);
      int yea = year;
      sql = "SELECT a.CHR_EMPID,b.INT_JAN,b.INT_FEB,b.INT_MAR, b.INT_APR, b.INT_MAY, b.INT_JUN,b.INT_JUL,b.INT_AUG,b.INT_SEP,b.INT_OCT,b.INT_NOV,b.INT_DEC,a.CHR_STAFFNAME FROM com_m_staff a , inv_t_targetassign b ";
      sql = String.valueOf(sql) + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
      if (!"0".equals(office))
        sql = String.valueOf(sql) + " AND a.INT_OFFICEID=" + office; 
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + " AND a.INT_DEPARTID=" + dept; 
      String[] empid = CommonFunctions.getReportingEmployeeIds((String)session.getAttribute("EMPID"));
      String empids = "";
      if (empid.length > 0)
        for (int i = 0; i < empid.length; i++)
          empids = String.valueOf(empids) + " '" + empid[i] + "' , ";  
      sql = String.valueOf(sql) + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
      sql = String.valueOf(sql) + "  AND b.INT_YEAR = " + year + 
        "  ORDER BY a.CHR_STAFFNAME ";
      if (month >= 1 && month <= 3)
        yea++; 
      String[][] data = CommonFunctions.QueryExecute(sql);
      if (data.length > 0) {
        double salessum = 0.0D;
        double achieve = 0.0D;
        double percent = 0.0D;
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < data.length; u++) {
          salessum = 0.0D;
          achieve = 0.0D;
          percent = 0.0D;
          sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
            yea + 
            "-" + 
            month + 
            "-01' AND DAT_SALESDATE <='" + 
            yea + 
            "-" + 
            month + 
            "-31' AND CHR_PAYMENTSTATUS !='S'";
          if (CommonFunction.RecordExist(sql)) {
            sql = "SELECT ";
            sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
            sql = String.valueOf(sql) + "   FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + 
              yea + 
              "-" + 
              month + 
              "-01' AND DAT_SALESDATE <='" + 
              yea + 
              "-" + 
              month + 
              "-31' AND CHR_PAYMENTSTATUS !='S'";
            String[][] salesdata = 
              CommonFunctions.QueryExecute(sql);
            salessum += 
              CommonFunctions.Round(
                Double.parseDouble(salesdata[0][0]));
          } 
          sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + 
            data[u][0] + 
            "' AND DAT_SALESDATE >='" + 
            yea + 
            "-" + 
            month + 
            "-01' AND DAT_SALESDATE <='" + 
            yea + 
            "-" + 
            month + 
            "-31' AND CHR_PAYMENTSTATUS !='S'";
          if (CommonFunction.RecordExist(sql)) {
            sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              yea + 
              "-" + 
              month + 
              "-01' AND DAT_SALESDATE <='" + 
              yea + 
              "-" + 
              month + 
              "-31' AND CHR_PAYMENTSTATUS !='S'";
            String[][] salesdata1 = 
              CommonFunctions.QueryExecute(sql);
            salessum += 
              CommonFunctions.Round(
                Double.parseDouble(salesdata1[0][0]));
          } 
          sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + 
            data[u][0] + 
            "' AND DAT_SALESDATE >='" + 
            yea + 
            "-" + 
            month + 
            "-01' AND DAT_SALESDATE <='" + 
            yea + 
            "-" + 
            month + 
            "-31' AND CHR_PAYMENTSTATUS !='S'";
          if (CommonFunction.RecordExist(sql)) {
            sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + 
              data[u][0] + 
              "' AND DAT_SALESDATE >='" + 
              yea + 
              "-" + 
              month + 
              "-01' AND DAT_SALESDATE <='" + 
              yea + 
              "-" + 
              month + 
              "-31' AND CHR_PAYMENTSTATUS !='S'";
            String[][] salesdata2 = 
              CommonFunctions.QueryExecute(sql);
            salessum += 
              CommonFunctions.Round(
                Double.parseDouble(salesdata2[0][0]));
          } 
          salessum = CommonFunctions.Round(salessum);
          achieve = CommonFunctions.Round(salessum / 100000.0D);
          percent = CommonFunctions.Round(achieve / 
              Double.parseDouble(data[u][month]) * 100.0D);
          sb.append("<TargetAssign>");
          sb.append("<Staffid>" + data[u][0] + "</Staffid>");
          sb.append("<Staffname>" + data[u][13] + "</Staffname>");
          sb.append("<Target>" + data[u][month] + "</Target>");
          sb.append("<Sales>" + salessum + "</Sales>");
          sb.append("<achieve>" + achieve + "</achieve>");
          sb.append("<percent>" + percent + "</percent>");
          sb.append("</TargetAssign>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
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
  
  public static void LoadTargetAssignAvgCollection(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String years = request.getParameter("year");
      String Branch = request.getParameter("Branch");
      String division = request.getParameter("division");
      String months = request.getParameter("month");
      String groupid = request.getParameter("groupid");
      String sql = "";
      int year = Integer.parseInt(years);
      int month = Integer.parseInt(months);
      sql = "SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ";
      sql = String.valueOf(sql) + " WHERE INT_CUSTOMERGROUPID >0";
      if (!"0".equals(groupid))
        sql = String.valueOf(sql) + " AND CHR_NAME LIKE '" + groupid + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY INT_CUSTOMERGROUPID";
      System.out.println(sql);
      String[][] data = CommonFunctions.QueryExecute(sql);
      if (data.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < data.length; u++) {
          sql = " SELECT count(*) ";
          sql = String.valueOf(sql) + " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
          sql = String.valueOf(sql) + " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
          sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
          sql = String.valueOf(sql) + " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID ";
          sql = String.valueOf(sql) + " AND a.INT_BRANCHID= " + Branch;
          if (!"0".equals(division))
            sql = String.valueOf(sql) + " AND b.INT_DIVIID= " + division; 
          sql = String.valueOf(sql) + " AND MONTH(a.DAT_PAYMENTDATE)= " + month;
          sql = String.valueOf(sql) + " AND YEAR(a.DAT_PAYMENTDATE) = " + year;
          sql = String.valueOf(sql) + " AND d.INT_CUSTOMERGROUPID= " + data[u][0];
          if (CommonFunction.RecordExist(sql)) {
            sql = " SELECT count(*) ,sum(a.DOU_PAIDAMOUNT),sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE)), ";
            sql = String.valueOf(sql) + " sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE))/count(*) ";
            sql = String.valueOf(sql) + " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
            sql = String.valueOf(sql) + " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
            sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
            sql = String.valueOf(sql) + " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID= " + Branch;
            if (!"0".equals(division))
              sql = String.valueOf(sql) + " AND b.INT_DIVIID= " + division; 
            sql = String.valueOf(sql) + " AND MONTH(a.DAT_PAYMENTDATE)= " + month;
            sql = String.valueOf(sql) + " AND YEAR(a.DAT_PAYMENTDATE) = " + year;
            sql = String.valueOf(sql) + " AND d.INT_CUSTOMERGROUPID= " + data[u][0];
            String[][] vdata = CommonFunctions.QueryExecute(sql);
            sb.append("<TargetAssign>");
            sb.append("<Groupname>" + 
                data[u][1].replaceAll("&", " AND ") + 
                "</Groupname>");
            sb.append("<NoofINV>" + vdata[0][0] + "</NoofINV>");
            sb.append("<Collectionamt>" + 
                CommonFunctions.Round(
                  Double.parseDouble(vdata[0][1])) + 
                "</Collectionamt>");
            sb.append("<Collectionday>" + vdata[0][2] + 
                "</Collectionday>");
            sb.append("<CustomerGroupid>" + data[u][0] + 
                "</CustomerGroupid>");
            sb.append("<Avg>" + 
                CommonFunctions.Round(
                  Double.parseDouble(vdata[0][3])) + "</Avg>");
            sb.append("<Detailed>" + data[u][0] + "</Detailed>");
            sb.append("</TargetAssign>");
          } else {
            sb.append("<TargetAssign>");
            sb.append("<Groupname>" + data[u][1].replaceAll("&", " AND ") + "</Groupname>");
            sb.append("<NoofINV>0</NoofINV>");
            sb.append("<Collectionamt>0</Collectionamt>");
            sb.append("<Collectionday>0</Collectionday>");
            sb.append("<CustomerGroupid>0</CustomerGroupid>");
            sb.append("<Avg>0</Avg>");
            sb.append("<Detailed>0</Detailed>");
            sb.append("</TargetAssign>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadTargetAssignCGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String years = request.getParameter("year");
      String Branch = request.getParameter("Branch");
      String period = request.getParameter("period");
      String division = request.getParameter("division");
      String sql = "";
      String ssql = "";
      String dsql = "";
      int year = Integer.parseInt(years);
      if (!"0".equals(division))
        dsql = " AND a.INT_DIVIID=" + division + "   "; 
      sql = "SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
      String[][] data = CommonFunctions.QueryExecute(sql);
      if (data.length > 0) {
        StringBuffer sb = new StringBuffer();
        if ("1".equals(period))
          for (int u = 0; u < data.length; u++) {
            sb.append("<TargetAssign>");
            sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
            sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-04-01' AND DAT_SALESDATE <='" + year + 
              "-04-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
              } else {
                sb.append("<Month1>0</Month1>");
              } 
            } else {
              sb.append("<Month1>0</Month1>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-05-01' AND DAT_SALESDATE <='" + year + 
              "-05-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
              } else {
                sb.append("<Month2>0</Month2>");
              } 
            } else {
              sb.append("<Month2>0</Month2>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-06-01' AND DAT_SALESDATE <='" + year + 
              "-06-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
              } else {
                sb.append("<Month3>0</Month3>");
              } 
            } else {
              sb.append("<Month3>0</Month3>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-04-01' AND DAT_SALESDATE <='" + year + 
              "-06-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              sb.append("<Target>" + salesdata[0][0] + "</Target>");
            } else {
              sb.append("<Target>0</Target>");
            } 
            sb.append("</TargetAssign>");
          }  
        if ("2".equals(period))
          for (int u = 0; u < data.length; u++) {
            sb.append("<TargetAssign>");
            sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
            sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-07-01' AND DAT_SALESDATE <='" + year + 
              "-07-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
              } else {
                sb.append("<Month1>0</Month1>");
              } 
            } else {
              sb.append("<Month1>0</Month1>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-08-01' AND DAT_SALESDATE <='" + year + 
              "-08-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
              } else {
                sb.append("<Month2>0</Month2>");
              } 
            } else {
              sb.append("<Month2>0</Month2>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-09-01' AND DAT_SALESDATE <='" + year + 
              "-09-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
              } else {
                sb.append("<Month3>0</Month3>");
              } 
            } else {
              sb.append("<Month3>0</Month3>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-07-01' AND DAT_SALESDATE <='" + year + 
              "-09-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              sb.append("<Target>" + salesdata[0][0] + 
                  "</Target>");
            } else {
              sb.append("<Target>0</Target>");
            } 
            sb.append("</TargetAssign>");
          }  
        if ("3".equals(period))
          for (int u = 0; u < data.length; u++) {
            sb.append("<TargetAssign>");
            sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
            sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-10-01' AND DAT_SALESDATE <='" + year + 
              "-10-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
              } else {
                sb.append("<Month1>0</Month1>");
              } 
            } else {
              sb.append("<Month1>0</Month1>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-11-01' AND DAT_SALESDATE <='" + year + 
              "-11-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
              } else {
                sb.append("<Month2>0</ >");
              } 
            } else {
              sb.append("<Month2>0</Month2>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-12-01' AND DAT_SALESDATE <='" + year + 
              "-12-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
              } else {
                sb.append("<Month3>0</Month3>");
              } 
            } else {
              sb.append("<Month3>0</Month3>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-10-01' AND DAT_SALESDATE <='" + year + 
              "-12-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              sb.append("<Target>" + salesdata[0][0] + 
                  "</Target>");
            } else {
              sb.append("<Target>0</Target>");
            } 
            sb.append("</TargetAssign>");
          }  
        if ("4".equals(period))
          for (int u = 0; u < data.length; u++) {
            sb.append("<TargetAssign>");
            sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
            sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-01-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-01-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
              } else {
                sb.append("<Month1>0</Month1 >");
              } 
            } else {
              sb.append("<Month1>0</Month1>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-02-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-02-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
              } else {
                sb.append("<Month2>0</Month2 >");
              } 
            } else {
              sb.append("<Month2>0</Month2>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-03-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-03-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              if (salesdata.length > 0) {
                sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
              } else {
                sb.append("<Month3>0</Month3 >");
              } 
            } else {
              sb.append("<Month3>0</Month3>");
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-01-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-03-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = 
                CommonFunctions.QueryExecute(sql);
              sb.append("<Target>" + salesdata[0][0] + 
                  "</Target>");
            } else {
              sb.append("<Target>0</Target>");
            } 
            sb.append("</TargetAssign>");
          }  
        if ("5".equals(period))
          for (int u = 0; u < data.length; u++) {
            sb.append("<TargetAssign>");
            sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
            sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
            for (int x = 1; x < 13; x++) {
              if (x <= 3) {
                ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
                  " AND  DAT_SALESDATE >='" + (
                  year + 1) + "-" + x + 
                  "-01' AND DAT_SALESDATE <='" + (
                  year + 1) + "-" + x + "-31' ";
              } else {
                ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
                  " AND  DAT_SALESDATE >='" + year + 
                  "-" + x + 
                  "-01' AND DAT_SALESDATE <='" + year + 
                  "-" + x + "-31' ";
              } 
              sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              if (CommonFunction.RecordExist(sql)) {
                sql = "SELECT ";
                sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                sql = String.valueOf(sql) + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                sql = String.valueOf(sql) + 
                  " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                  data[u][0] + ssql;
                String[][] salesdata = 
                  CommonFunctions.QueryExecute(sql);
                if (salesdata.length > 0) {
                  sb.append("<Month" + x + ">" + salesdata[0][0] + "</Month" + x + ">");
                } else {
                  sb.append("<Month" + x + ">0</Month" + x + ">");
                } 
              } else {
                sb.append("<Month" + x + ">0</Month" + x + ">");
              } 
            } 
            ssql = String.valueOf(dsql) + "  AND a.INT_BRANCHID=" + Branch + 
              " AND  DAT_SALESDATE >='" + year + 
              "-04-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-03-31' ";
            sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
            sql = String.valueOf(sql) + 
              " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
              data[u][0] + ssql;
            if (CommonFunction.RecordExist(sql)) {
              sql = "SELECT ";
              sql = String.valueOf(sql) + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
              sql = String.valueOf(sql) + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
              sql = String.valueOf(sql) + 
                " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + 
                data[u][0] + ssql;
              String[][] salesdata = CommonFunctions.QueryExecute(sql);
              sb.append("<Target>" + salesdata[0][0] + 
                  "</Target>");
            } else {
              sb.append("<Target>0</Target>");
            } 
            sb.append("</TargetAssign>");
          }  
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadContribution(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object1 = session.getAttribute("USRTYPE");
      Object object2 = session.getAttribute("EMPID");
      String month = request.getParameter("month");
      String ref = request.getParameter("ref");
      String year = request.getParameter("year");
      String txtSer = request.getParameter("txtSer");
      String day = request.getParameter("day");
      String customer = request.getParameter("customer");
      String sql = "";
      sql = " SELECT a.CHR_SALESNO,a.CHR_EMPID,d.CHR_STAFFNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),a.DOU_CONTRIBUTION,UPPER(FIND_A_CUSTOMER_NAME( b.INT_CUSTOMERID )) , ";
      sql = String.valueOf(sql) + " a.DOU_PAMOUNT,a.DOU_SAMOUNT, ROUND((a.DOU_CONTRIBUTION/DOU_PAMOUNT*100),2),a.INT_PERCENTAGE,ROUND( (a.DOU_SAMOUNT * a.INT_PERCENTAGE/100),2)   FROM inv_t_contribution a,inv_t_directsales b,inv_m_customerinfo c , com_m_staff d ";
      sql = String.valueOf(sql) + " WHERE a.CHR_SALESNO=b.CHR_SALESNO ";
      sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
      sql = String.valueOf(sql) + " AND a.CHR_EMPID =d.CHR_EMPID ";
      if (!"F".equals(object1)) {
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID='" + object2 + "'";
      } else if (!"0".equals(ref)) {
        sql = String.valueOf(sql) + "  AND a.CHR_EMPID='" + ref + "'";
      } 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + "  AND b.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + "  AND DAY(a.DAT_SALESDATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + "  AND MONTH(a.DAT_SALESDATE) = " + month; 
      sql = String.valueOf(sql) + "  AND YEAR(a.DAT_SALESDATE) = " + year;
      if (!txtSer.equals("0"))
        sql = String.valueOf(sql) + " AND d.CHR_STAFFNAME LIKE '" + txtSer + "%' "; 
      if (!txtSer.equals("0"))
        sql = String.valueOf(sql) + " AND d.CHR_STAFFNAME LIKE '" + txtSer + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY d.CHR_STAFFNAME ";
      System.out.println(sql);
      StringBuffer sb = new StringBuffer();
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Saleno>" + readData[u][0] + "</Saleno>");
          sb.append("<Empid>" + readData[u][1] + "</Empid>");
          sb.append("<Empname>" + readData[u][2] + "</Empname>");
          sb.append("<SDate>" + readData[u][3] + "</SDate>");
          sb.append("<CAmount>" + readData[u][4] + "</CAmount>");
          sb.append("<Customer>" + readData[u][5].replaceAll("&", " AND ").trim() + "</Customer>");
          sb.append("<PAmount>" + readData[u][6] + "</PAmount>");
          sb.append("<ActualSAmount>" + readData[u][7] + "</ActualSAmount>");
          sb.append("<CPercentage>" + readData[u][8] + "</CPercentage>");
          sb.append("<SalePercentage>" + readData[u][9] + "</SalePercentage>");
          sb.append("<SAmount>" + readData[u][10] + "</SAmount>");
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
  
  public static void LoadAssignPaymentCommitment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String salno = request.getParameter("invoicenumber");
      String billtype = request.getParameter("billtype");
      String sql = "";
      sql = " SELECT INT_PAYMENTCOMMITMENTID, CHR_SALESNO,CHR_INVOICETYPE,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%b-%Y'),DOU_COMMITMENTAMOUNT,";
      sql = String.valueOf(sql) + 
        " CHR_STATUS,DATE_FORMAT(DT_RECIEVEDDATE,'%d-%b-%Y'),DOU_RECEIVEDAMOUNT,CHR_PAYMENTFLAG,CHR_NEXTFLAG  FROM inv_t_paymentcommitment  WHERE CHR_SALESNO='" + 
        salno + "' AND CHR_INVOICETYPE='" + billtype + "'  ";
      CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Commitment>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Date>" + readData[u][3] + "</Date>");
          sb.append("<Amount>" + readData[u][4] + "</Amount>");
          sb.append("<RDate>" + readData[u][6] + "</RDate>");
          sb.append("<RAmount>" + readData[u][7] + "</RAmount>");
          sb.append("<RStatus>" + readData[u][8] + "</RStatus>");
          sb.append("<Next>" + readData[u][9] + "</Next>");
          sb.append("</Commitment>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Commitments>" + sb.toString() + "</Commitments>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadSalesNumber(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String type = request.getParameter("returnType");
      String month = request.getParameter("month");
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + 
        "-" + 
        month + 
        "-" + 
        DateUtil.totalDays(mon, 
          year);
      if (type.equals("Invoice")) {
        sql = " SELECT CHR_INVOICENO ";
        sql = String.valueOf(sql) + " FROM  inv_t_customersalesorder   ";
        sql = String.valueOf(sql) + " WHERE DT_INVOICEDATE >='" + fDate + "'";
        sql = String.valueOf(sql) + " AND DT_INVOICEDATE <='" + tDate + "'";
        sql = String.valueOf(sql) + " AND INT_BRANCHID = " + object;
        sql = String.valueOf(sql) + " ORDER BY DT_INVOICEDATE ";
      } else if (type.equals("CashPay")) {
        sql = " SELECT CHR_SALESNO ";
        sql = String.valueOf(sql) + " FROM inv_t_cashsales ";
        sql = String.valueOf(sql) + " WHERE DAT_SALESDATE >='" + fDate + "'";
        sql = String.valueOf(sql) + " AND DAT_SALESDATE <='" + tDate + "'";
        sql = String.valueOf(sql) + " AND INT_BRANCHID = " + object;
        sql = String.valueOf(sql) + " ORDER BY DAT_SALESDATE ";
      } else if (type.equals("Direct")) {
        sql = " SELECT CHR_SALESNO  ";
        sql = String.valueOf(sql) + " FROM inv_t_directsales ";
        sql = String.valueOf(sql) + " WHERE DAT_SALESDATE >='" + fDate + "'";
        sql = String.valueOf(sql) + " AND DAT_SALESDATE <='" + tDate + "'";
        sql = String.valueOf(sql) + " AND INT_BRANCHID = " + object;
        sql = String.valueOf(sql) + " ORDER BY DAT_SALESDATE ";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Option>");
          sb.append("<Optionval>" + readData[u][0] + "</Optionval>");
          sb.append("<Optiondis>" + readData[u][0] + "</Optiondis>");
          sb.append("</Option>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Optionss>" + sb.toString() + "</Optionss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void ItemProductAssignStock(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String type = request.getParameter("type");
      String itemid = request.getParameter("typeid");
      HttpSession session = request.getSession();
      String branchid = session.getAttribute("BRANCHID").toString();
      if (type.equals("1"))
        sql = "SELECT CHR_ITEMID,INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='" + 
          itemid + 
          "'\tAND CHR_TYPE='I' AND INT_BRANCHID = " + 
          branchid; 
      if (type.equals("2"))
        sql = "SELECT CHR_ITEMID,INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='" + 
          itemid + 
          "'\tAND CHR_TYPE='P' AND INT_BRANCHID = " + 
          branchid; 
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Assign>");
          if (!readData[u][1].equals("-")) {
            sb.append("<Stock>" + readData[u][1] + "</Stock>");
          } else {
            sb.append("<Stock>0</Stock>");
          } 
          sb.append("</Assign>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Assigns>" + sb.toString() + "</Assigns>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void ItemProductAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String type = request.getParameter("type");
      String typeid = request.getParameter("typeid");
      HttpSession session = request.getSession();
      Object object = session.getAttribute("BRANCHID");
      int stock = 0;
      String ssql = "";
      if (type.equals("1")) {
        sql = " SELECT COUNT(*) ";
        sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceived ";
        sql = String.valueOf(sql) + " WHERE CHR_FLAG <> 'Y'  AND CHR_FLAG='N' AND CHR_SERIALNO IS NOT NULL ";
        sql = String.valueOf(sql) + " AND  CHR_TYPE ='I' ";
        sql = String.valueOf(sql) + " AND  CHR_ITEMID ='" + typeid + "' ";
        sql = String.valueOf(sql) + " AND  INT_BRANCHID ='" + object + "' ";
        stock = CommonFunction.intRecordCount(sql);
        ssql = " Select CHR_DES,DOU_PURCHASEPRICE,DOU_SALESPRICE,INT_TAXID from inv_m_item WHERE CHR_ITEMID ='" + 
          typeid + "'";
      } 
      if (type.equals("2")) {
        sql = "SELECT count(*) FROM inv_m_produtlist WHERE CHR_PTYPE='S' AND CHR_PRODUCTID='" + 
          typeid + "'";
        if (!CommonFunction.RecordExist(sql)) {
          sql = " SELECT COUNT(*) ";
          sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceived ";
          sql = String.valueOf(sql) + 
            " WHERE CHR_FLAG <> 'Y'  AND CHR_FLAG='N'  AND CHR_SERIALNO IS NOT NULL    ";
          sql = String.valueOf(sql) + " AND  CHR_TYPE ='P' ";
          sql = String.valueOf(sql) + " AND  CHR_ITEMID ='" + typeid + "' ";
          sql = String.valueOf(sql) + " AND  INT_BRANCHID ='" + object + "' ";
          stock = CommonFunction.intRecordCount(sql);
          ssql = " select CHR_PRODUCTDESC,DOU_PURCHASEPRICE,DOU_SALESPRICE ,CHR_ITEMLIST,CHR_PTYPE,INT_TAXID from inv_m_produtlist WHERE CHR_PRODUCTID ='" + 
            typeid + "'";
        } else {
          sql = " SELECT  (SUM(INT_PQTY)-SUM(INT_SQTY)) ";
          sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceivedconsumable ";
          sql = String.valueOf(sql) + " WHERE CHR_ITEMID='" + typeid + 
            "' AND CHR_CANCEL='N' AND CHR_TYPE='P' AND  INT_BRANCHID=" + 
            object;
          sql = String.valueOf(sql) + " GROUP BY CHR_ITEMID ";
          String[][] arrayOfString1 = CommonFunctions.QueryExecute(sql);
          if (arrayOfString1.length > 0)
            stock = Integer.parseInt(arrayOfString1[0][0]); 
          sql = " select FUN_GET_AVERAGEPRICE('" + object + "','" + 
            typeid + "') ";
          String[][] readData1 = CommonFunctions.QueryExecute(sql);
          ssql = " select CHR_PRODUCTDESC,DOU_PURCHASEPRICE,'" + 
            readData1[0][0] + 
            "' ,CHR_ITEMLIST,CHR_PTYPE,INT_TAXID from inv_m_produtlist WHERE CHR_PRODUCTID ='" + 
            typeid + "'";
        } 
      } 
      System.out.println(ssql);
      String[][] readData = CommonFunctions.QueryExecute(ssql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Assign>");
          sb.append("<Desc>" + readData[u][0].replace("&", " ") + "</Desc>");
          sb.append("<PPrice>" + readData[u][1] + "</PPrice>");
          sb.append("<Price>" + readData[u][2] + "</Price>");
          sb.append("<Stock>" + stock + "</Stock>");
          if (type.equals("2")) {
            String listname = "";
            if ("C".equals(readData[u][4])) {
              String[] listdata = readData[u][3].split("~");
              for (int x = 0; x < listdata.length; x++) {
                String query = " SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='" + listdata[x] + "'";
                String[][] itemnames = CommonFunctions.QueryExecute(query);
                listname = String.valueOf(listname) + itemnames[0][0] + " / " + listdata[x] + " / ~";
              } 
              sb.append("<Plist>" + listname + "</Plist>");
              sb.append("<Ptype>" + readData[u][4] + "</Ptype>");
            } else {
              sb.append("<Plist>-</Plist>");
              sb.append("<Ptype>" + readData[u][4] + "</Ptype>");
            } 
          } else {
            sb.append("<Plist>-</Plist>");
            sb.append("<Ptype>-</Ptype>");
          } 
          if (type.equals("2")) {
            sb.append("<Ptax>" + readData[u][5] + "</Ptax>");
          } else {
            sb.append("<Ptax>" + readData[u][3] + "</Ptax>");
          } 
          sb.append("</Assign>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Assigns>" + sb.toString() + "</Assigns>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void ItemProductGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String id = request.getParameter("id");
      if (id.equals("1"))
        sql = " Select INT_ITEMGROUPID,replace(UPPER(CHR_GROUPNAME),'&','AND') from inv_m_itemgroup   ORDER BY CHR_GROUPNAME "; 
      if (id.equals("2"))
        sql = " select INT_PRODUCTGROUPID,replace(UPPER(CHR_NAME),'&','AND')from inv_m_productgroup ORDER BY CHR_NAME"; 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Idname>" + readData[u][1].replaceAll("&", " AND ") + "</Idname>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
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
  
  public static void itemproductdependsGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String itype = request.getParameter("itype");
      String group = request.getParameter("group");
      if (itype.equals("1")) {
        sql = " SELECT CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') FROM inv_m_item   WHERE INT_ACTIVE=1 ";
        if (!"0".equals(group))
          sql = String.valueOf(sql) + " AND INT_ITEMGROUPID = " + group; 
        sql = String.valueOf(sql) + " ORDER BY CHR_ITEMNAME ";
      } 
      if (itype.equals("2")) {
        sql = " SELECT CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')FROM inv_m_produtlist  WHERE INT_ACTIVE=1";
        if (!"0".equals(group))
          sql = String.valueOf(sql) + " AND INT_PRODUCTGROUPID = " + group; 
        sql = String.valueOf(sql) + " ORDER BY CHR_PRODUCTCODE ";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Idname>" + readData[u][1].replaceAll("&", " AND ") + "</Idname>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
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
  
  public static void ItemProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String id = request.getParameter("id");
      if (id.equals("1"))
        sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME"; 
      if (id.equals("2"))
        sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE INT_ACTIVE=1 ORDER BY CHR_PRODUCTCODE"; 
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Idname>" + readData[u][1].replaceAll("&", " AND ") + "</Idname>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
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
  
  public static void INVItemProductdependsPurchaseRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String id = request.getParameter("id");
      String vendorid = request.getParameter("vendorid");
      String purchaserequest = request.getParameter("purchaserequest");
      if (id.equals("1"))
        sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME"; 
      if (id.equals("2"))
        sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE INT_ACTIVE=1 ORDER BY CHR_PRODUCTCODE"; 
      if (id.equals("1")) {
        sql = "Select a.CHR_ITEMID,replace(UPPER(a.CHR_ITEMNAME),'&','AND') ";
        sql = String.valueOf(sql) + " from inv_m_item  a , inv_t_purchaserequestitem  b ";
        sql = String.valueOf(sql) + " WHERE  a.CHR_ITEMID = b.CHR_ITEMID ";
        sql = String.valueOf(sql) + " AND a.INT_ACTIVE=1 AND b.CHR_TYPE ='I' ";
        sql = String.valueOf(sql) + " AND b.INT_VENDORID =   " + vendorid;
        sql = String.valueOf(sql) + " AND b.CHR_POREQUESTNO ='" + purchaserequest + "' ";
        sql = String.valueOf(sql) + " ORDER BY a.CHR_ITEMNAME ";
      } 
      if (id.equals("2")) {
        sql = " Select a.CHR_PRODUCTID,replace(UPPER(a.CHR_PRODUCTCODE),'&','AND') ";
        sql = String.valueOf(sql) + " from inv_m_produtlist  a , inv_t_purchaserequestitem  b ";
        sql = String.valueOf(sql) + " WHERE  a.CHR_PRODUCTID = b.CHR_ITEMID ";
        sql = String.valueOf(sql) + " AND a.INT_ACTIVE=1 AND b.CHR_TYPE ='P' ";
        sql = String.valueOf(sql) + " AND b.INT_VENDORID = " + vendorid;
        sql = String.valueOf(sql) + " AND b.CHR_POREQUESTNO ='" + purchaserequest + "' ";
        sql = String.valueOf(sql) + " ORDER BY a.CHR_PRODUCTCODE ";
      } 
      System.out.println("Load Item/Product depends on PR" + sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        sb.append("<item>");
        sb.append("<Id>0</Id>");
        if (id.equals("1"))
          sb.append("<Idname>Select Item</Idname>"); 
        if (id.equals("2"))
          sb.append("<Idname>Select Product</Idname>"); 
        sb.append("</item>");
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Idname>" + readData[u][1].replaceAll("&", " AND ") + "</Idname>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
      } else {
        sb.append("<item>");
        sb.append("<Id>0</Id>");
        if (id.equals("1"))
          sb.append("<Idname>Select Item</Idname>"); 
        if (id.equals("2"))
          sb.append("<Idname>Select Product</Idname>"); 
        sb.append("</item>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void INVItemProductSparemodule(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String id = request.getParameter("id");
      String type = request.getParameter("type");
      if (id.equals("1"))
        sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME"; 
      if (id.equals("2")) {
        sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')  from inv_m_produtlist  WHERE INT_ACTIVE=1 ";
        if ("C".equals(type))
          sql = String.valueOf(sql) + " AND CHR_PTYPE='S' "; 
        sql = String.valueOf(sql) + " ORDER BY CHR_PRODUCTCODE";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Idname>" + readData[u][1].replaceAll("&", " AND ") + "</Idname>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<items>" + sb.toString() + "</items>");
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
  
  public static void LoadItemProductGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String id = request.getParameter("id");
      if (id.equals("1"))
        sql = " Select INT_ITEMGROUPID,CHR_GROUPNAME from inv_m_itemgroup    ORDER BY CHR_GROUPNAME"; 
      if (id.equals("2"))
        sql = " select INT_PRODUCTGROUPID,CHR_NAME from inv_m_productgroup   ORDER BY CHR_NAME"; 
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1] + "</Name>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Rowss>" + sb.toString() + "</Rowss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void QuotationEdit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String itype = request.getParameter("type");
      if (itype.equals("1"))
        sql = " Select CHR_ITEMID,CHR_ITEMNAME from inv_m_item "; 
      if (itype.equals("2"))
        sql = " select CHR_PRODUCTID,CHR_PRODUCTCODE from inv_m_produtlist "; 
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Idname>" + readData[u][1] + "</Idname>");
          sb.append("</item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<items>" + sb.toString() + "</items>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void AMCUniqueId(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String tablename = request.getParameter("tablename");
      String fieldname = request.getParameter("fieldname");
      String value = request.getParameter("value");
      sql = "SELECT COUNT(*) FROM " + tablename + " WHERE " + fieldname + 
        "  = '" + value + "'";
      StringBuffer sb = new StringBuffer();
      if (CommonInfo.RecordExist(sql)) {
        sb.append("<UniqueId>");
        sb.append("<Exsist>TRUE</Exsist>");
        sb.append("</UniqueId>");
      } else {
        sb.append("<UniqueId>");
        sb.append("<Exsist>FALSE</Exsist>");
        sb.append("</UniqueId>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write(
          "<UniqueIds>" + sb.toString() + "</UniqueIds>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void AMCCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String customertype = request.getParameter("types");
      String StartLetter = request.getParameter("StartLetter");
      String sql = "";
      String tablename = "";
      if (customertype.equals("C"))
        tablename = " inv_m_customerinfo "; 
      if (customertype.equals("N"))
        tablename = " inv_m_noncustomerinfo "; 
      if (StartLetter.equals("") || StartLetter.equals("null")) {
        sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM " + 
          tablename + " ORDER BY CHR_CUSTOMERNAME";
      } else {
        sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM " + 
          tablename + " WHERE CHR_CUSTOMERNAME LIKE '" + 
          StartLetter + "%' ORDER BY CHR_CUSTOMERNAME";
      } 
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<ID>");
          sb.append("<Customerid>" + readData[u][0] + "</Customerid>");
          sb.append("<Customername>" + readData[u][1] + 
              "</Customername>");
          sb.append("</ID>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<IDs>" + sb.toString() + "</IDs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadAMC(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String customertype = request.getParameter("customertype");
      String StartLetter = request.getParameter("StartLetter");
      int year = Integer.parseInt(request.getParameter("year"));
      String sql = "";
      String flag = "";
      String start = "";
      if (customertype.equals("0"))
        flag = " "; 
      if (customertype.equals("C"))
        flag = " AND CHR_CUSTOMERFLAG ='C'"; 
      if (customertype.equals("N"))
        flag = " AND CHR_CUSTOMERFLAG ='N'"; 
      if (StartLetter.equals("0")) {
        start = " ";
      } else {
        start = " AND CHR_AMCID LIKE '" + StartLetter + "%'";
      } 
      sql = "SELECT INT_AMCID,CHR_AMCID,INT_CUSTOMERID, CHR_CUSTOMERFLAG,DT_STARTDATE,DT_ENDDATE FROM inv_t_amc WHERE  YEAR(DT_STARTDATE) = " + 
        year + flag + start + " ORDER BY CHR_AMCID";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      String name = "";
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<AMC>");
          sb.append("<Amcid>" + readData[u][1] + "</Amcid>");
          if (readData[u][3].equals("C"))
            if (CommonInfo.RecordExist("SELECT COUNT(*) FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" + 
                readData[u][2])) {
              sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" + 
                readData[u][2];
              String[][] readName = 
                CommonFunctions.QueryExecute(sql);
              name = readName[0][0];
            } else {
              name = "-";
            }  
          if (readData[u][3].equals("N"))
            if (CommonInfo.RecordExist("SELECT COUNT(*) FROM inv_m_noncustomerinfo WHERE INT_CUSTOMERID=" + 
                readData[u][2])) {
              sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_noncustomerinfo WHERE INT_CUSTOMERID=" + 
                readData[u][2];
              String[][] readName = 
                CommonFunctions.QueryExecute(sql);
              name = readName[0][0];
            } else {
              name = "-";
            }  
          sb.append("<Customername>-" + name + "</Customername>");
          sb.append("<Startdate>" + readData[u][4] + "</Startdate>");
          sb.append("<Enddate>" + readData[u][5] + "</Enddate>");
          sb.append("<Renewal>Renewal</Renewal>");
          sb.append("</AMC>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<AMCs>" + sb.toString() + "</AMCs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void ServiceCompalintID(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: ldc ''
    //   2: astore_2
    //   3: new java/lang/StringBuilder
    //   6: dup
    //   7: invokespecial <init> : ()V
    //   10: aload_0
    //   11: ldc_w 'servicecompalintid'
    //   14: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   19: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   22: invokevirtual toString : ()Ljava/lang/String;
    //   25: astore_3
    //   26: new java/lang/StringBuilder
    //   29: dup
    //   30: ldc_w 'SELECT COUNT(*) FROM inv_t_service WHERE CHR_SERVICEID  = ''
    //   33: invokespecial <init> : (Ljava/lang/String;)V
    //   36: aload_3
    //   37: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   40: ldc_w '''
    //   43: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   46: invokevirtual toString : ()Ljava/lang/String;
    //   49: astore_2
    //   50: new java/lang/StringBuffer
    //   53: dup
    //   54: invokespecial <init> : ()V
    //   57: astore #4
    //   59: iconst_0
    //   60: istore #5
    //   62: aload_2
    //   63: invokestatic RecordExist : (Ljava/lang/String;)Z
    //   66: ifeq -> 72
    //   69: iconst_1
    //   70: istore #5
    //   72: new java/lang/StringBuilder
    //   75: dup
    //   76: invokespecial <init> : ()V
    //   79: iload #5
    //   81: invokevirtual append : (Z)Ljava/lang/StringBuilder;
    //   84: invokevirtual toString : ()Ljava/lang/String;
    //   87: astore #6
    //   89: aload #6
    //   91: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   94: astore #6
    //   96: aload #4
    //   98: ldc_w '<ComplaintId>'
    //   101: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   104: pop
    //   105: aload #4
    //   107: new java/lang/StringBuilder
    //   110: dup
    //   111: ldc_w '<Exsist>'
    //   114: invokespecial <init> : (Ljava/lang/String;)V
    //   117: aload #6
    //   119: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   122: ldc_w '</Exsist>'
    //   125: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   128: invokevirtual toString : ()Ljava/lang/String;
    //   131: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   134: pop
    //   135: aload #4
    //   137: ldc_w '</ComplaintId>'
    //   140: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   143: pop
    //   144: aload_1
    //   145: ldc 'text/xml'
    //   147: invokeinterface setContentType : (Ljava/lang/String;)V
    //   152: aload_1
    //   153: ldc 'Cache-Control'
    //   155: ldc 'no-cache'
    //   157: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   162: aload_1
    //   163: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   168: new java/lang/StringBuilder
    //   171: dup
    //   172: ldc_w '<ComplaintIds>'
    //   175: invokespecial <init> : (Ljava/lang/String;)V
    //   178: aload #4
    //   180: invokevirtual toString : ()Ljava/lang/String;
    //   183: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   186: ldc_w '</ComplaintIds>'
    //   189: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   192: invokevirtual toString : ()Ljava/lang/String;
    //   195: invokevirtual write : (Ljava/lang/String;)V
    //   198: goto -> 241
    //   201: astore_2
    //   202: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   205: aload_2
    //   206: invokevirtual getMessage : ()Ljava/lang/String;
    //   209: invokevirtual println : (Ljava/lang/String;)V
    //   212: aload_0
    //   213: ldc 'error'
    //   215: aload_2
    //   216: invokevirtual getMessage : ()Ljava/lang/String;
    //   219: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   224: aload_0
    //   225: ldc '/error/index.jsp'
    //   227: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   232: astore_3
    //   233: aload_3
    //   234: aload_0
    //   235: aload_1
    //   236: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   241: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #4431	-> 0
    //   #4432	-> 3
    //   #4433	-> 10
    //   #4432	-> 22
    //   #4434	-> 26
    //   #4435	-> 36
    //   #4434	-> 46
    //   #4436	-> 50
    //   #4437	-> 59
    //   #4438	-> 62
    //   #4439	-> 69
    //   #4440	-> 72
    //   #4441	-> 89
    //   #4442	-> 96
    //   #4443	-> 105
    //   #4444	-> 135
    //   #4445	-> 144
    //   #4446	-> 152
    //   #4447	-> 162
    //   #4448	-> 168
    //   #4447	-> 195
    //   #4449	-> 198
    //   #4450	-> 202
    //   #4451	-> 212
    //   #4452	-> 224
    //   #4453	-> 225
    //   #4452	-> 232
    //   #4454	-> 233
    //   #4456	-> 241
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	242	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	242	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   3	195	2	sql	Ljava/lang/String;
    //   26	172	3	StartLetter	Ljava/lang/String;
    //   59	139	4	sb	Ljava/lang/StringBuffer;
    //   62	136	5	flag	Z
    //   89	109	6	name	Ljava/lang/String;
    //   202	39	2	e	Ljava/lang/Exception;
    //   233	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	198	201	java/lang/Exception
  }
  
  public static void loadServiceAmountAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String payType = request.getParameter("type");
      String id = request.getParameter("id");
      String sql = "";
      String sql1 = "";
      if (payType.equals("Invoice")) {
        sql = " select DOU_AMCAMOUNT FROM  inv_t_amc WHERE CHR_AMCID = '" + 
          id + "'";
        sql1 = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + 
          id + "' and CHR_FLAG='A' group by CHR_SERVICEID";
      } 
      if (payType.equals("CashPay")) {
        sql = "select DOU_SERVICEAMOUNT FROM  inv_t_service WHERE CHR_SERVICEID = '" + 
          id + "'";
        sql1 = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + 
          id + "' and CHR_FLAG='S' group by CHR_SERVICEID";
      } 
      double total = 0.0D;
      double paid = 0.0D;
      if (CommonInfo.RecordExist(sql1)) {
        String[][] readDatas = 
          CommonInfo.doubleRecordSetArray(sql1);
        paid = Double.parseDouble(readDatas[0][0]);
      } 
      if (CommonInfo.RecordExist(sql)) {
        String[][] readDatas = 
          CommonInfo.doubleRecordSetArray(sql);
        total = Double.parseDouble(readDatas[0][0]);
      } 
      StringBuffer sb = new StringBuffer();
      sb.append("<ServiceId>");
      sb.append("<Serviceamount>" + total + "</Serviceamount>");
      sb.append("<Paidamount>" + paid + "</Paidamount>");
      sb.append("</ServiceId>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write(
          "<ServiceIds>" + sb.toString() + "</ServiceIds>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadAMCServiceids(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String payType = request.getParameter("type");
      String StartLetter = request.getParameter("StartLetter");
      String sql = "";
      if (payType.equals("Invoice"))
        sql = " select CHR_AMCID FROM  inv_t_amc WHERE CHR_AMCID LIKE '" + 
          StartLetter + "%' ORDER BY CHR_AMCID"; 
      if (payType.equals("CashPay"))
        sql = " select CHR_SERVICEID from inv_t_service WHERE CHR_SERVICEID LIKE '" + 
          StartLetter + "%' ORDER BY CHR_SERVICEID"; 
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<ServiceId>");
          sb.append("<Serviceid>" + readData[u][0] + "</Serviceid>");
          sb.append("</ServiceId>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<ServiceIds>" + sb.toString() + "</ServiceIds>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadAMCPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String payType = request.getParameter("payType");
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String sql = "";
      if (payType.equals("") || payType.equals("null"))
        payType = "Invoice"; 
      if (payType.equals("Invoice")) {
        sql = " SELECT CHR_AMCID,INT_CUSTOMERID,CHR_CUSTOMERFLAG,DT_STARTDATE,DOU_AMCAMOUNT,INT_AMCID";
        sql = String.valueOf(sql) + " FROM  inv_t_amc Where year(DT_STARTDATE) = " + 
          year + " and month(DT_STARTDATE) =" + mon;
      } 
      if (payType.equals("CashPay")) {
        sql = " SELECT CHR_SERVICEID,INT_CUSTOMERID,CHR_CUSTOMERFLAG,DT_ATTENDATE,DOU_SERVICEAMOUNT,INT_SERVICEID";
        sql = String.valueOf(sql) + " FROM inv_t_service  Where year(DT_ATTENDATE) = " + 
          year + " and month(DT_ATTENDATE) =" + mon;
      } 
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      String StartLetter = request.getParameter("id");
      String name = "";
      double paidamount = 0.0D;
      double totalamount = 0.0D;
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          paidamount = 0.0D;
          totalamount = 0.0D;
          name = "-";
          if (readData[u][0].startsWith(StartLetter) || 
            "0".startsWith(StartLetter)) {
            if (payType.equals("Invoice")) {
              sql = " Select CHR_CUSTOMERNAME from  inv_m_customerinfo WHERE INT_CUSTOMERID =" + 
                readData[u][1];
              if (CommonInfo.RecordExist("Select count(*) from  inv_m_customerinfo WHERE INT_CUSTOMERID =" + 
                  readData[u][1])) {
                String[][] customername = 
                  CommonFunctions.QueryExecute(sql);
                name = customername[0][0];
              } 
              sql = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + 
                readData[u][0] + 
                "' and CHR_FLAG='A' group by CHR_SERVICEID ";
              if (CommonInfo.RecordExist("select count(*)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + 
                  readData[u][0] + 
                  "' and CHR_FLAG='A' group by CHR_SERVICEID ")) {
                String[][] paids = 
                  CommonInfo.doubleRecordSetArray(sql);
                paidamount = Double.parseDouble(paids[0][0]);
              } 
            } 
            if (payType.equals("CashPay")) {
              sql = " Select CHR_CUSTOMERNAME from  inv_m_noncustomerinfo WHERE INT_CUSTOMERID =" + 
                Integer.parseInt(readData[u][1]);
              if (CommonInfo.RecordExist(" Select count(*) from  inv_m_noncustomerinfo WHERE INT_CUSTOMERID =" + 
                  Integer.parseInt(readData[u][1]))) {
                String[][] customername = 
                  CommonFunctions.QueryExecute(sql);
                name = customername[0][0];
              } 
              sql = " select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + 
                readData[u][0] + 
                "' and CHR_FLAG='S' group by CHR_SERVICEID ";
              if (CommonInfo.RecordExist(" select count(*) FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + 
                  readData[u][0] + 
                  "' and CHR_FLAG='S' group by CHR_SERVICEID ")) {
                String[][] paids = 
                  CommonInfo.doubleRecordSetArray(sql);
                paidamount = Double.parseDouble(paids[0][0]);
              } 
            } 
            if (!readData[u][4].equals("-"))
              totalamount = Double.parseDouble(readData[u][4]); 
            sb.append("<Payment>");
            sb.append("<AmcServiceid>" + readData[u][0] + 
                "</AmcServiceid>");
            sb.append("<Customername>" + name + "</Customername>");
            sb.append("<Date>" + 
                
                DateUtil.FormateDateSys(readData[u][3]) + 
                "</Date>");
            sb.append("<Amount>" + readData[u][4] + "</Amount>");
            sb.append("<PaidAmount>" + paidamount + "</PaidAmount>");
            sb.append("<Balance>" + (totalamount - paidamount) + 
                "</Balance>");
            if (totalamount - paidamount == 0.0D) {
              sb.append("<Status>Y</Status>");
            } else {
              sb.append("<Status>N</Status>");
            } 
            sb.append("</Payment>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Payments>" + sb.toString() + "</Payments>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadServiceCall(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String StartLetter = request.getParameter("StartLetter");
      String sql = " Select INT_SERVICEID,\tCHR_SERVICEID\t,CHR_EMPID,\tINT_CUSTOMERID\t,CHR_CUSTOMERFLAG,";
      sql = String.valueOf(sql) + 
        " CHR_SERVICEDESC,\tDT_ARAISEDATE,\tDT_ATTENDATE\t,DT_COMPLETEDATE,\tCHR_SERVICESTATUS ";
      sql = String.valueOf(sql) + " From inv_t_service\tWHERE month(DT_ARAISEDATE) = " + 
        month;
      sql = String.valueOf(sql) + " AND  year(DT_ARAISEDATE) = " + year;
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][1].startsWith(StartLetter) || 
            "0".startsWith(StartLetter)) {
            sb.append("<Servicecall>");
            sb.append("<Servicerowid>" + readData[u][0] + 
                "</Servicerowid>");
            sb.append("<Serviceid>" + readData[u][1] + 
                "</Serviceid>");
            if (!readData[u][2].equals("-")) {
              if (CommonInfo.RecordExist("Select count(*) from com_m_staff WHERE CHR_EMPID = '" + 
                  readData[u][2] + "'")) {
                sql = "Select CHR_STAFFNAME from com_m_staff WHERE CHR_EMPID = '" + 
                  readData[u][2] + "'";
                String[][] readDatas = 
                  CommonFunctions.QueryExecute(sql);
                sb.append("<Staff>" + readDatas[0][0] + 
                    "</Staff>");
              } else {
                sb.append("<Staff>-</Staff>");
              } 
            } else {
              sb.append("<Staff>-</Staff>");
            } 
            if (readData[u][4].equals("C"))
              if (CommonInfo.RecordExist("select count(*) from inv_m_customerinfo where INT_CUSTOMERID =" + 
                  readData[u][3])) {
                sql = "select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID =" + 
                  readData[u][3];
                String[][] readDatass = 
                  CommonFunctions.QueryExecute(sql);
                sb.append("<Customername>" + readDatass[0][0] + 
                    "</Customername>");
              } else {
                sb.append("<Customername>-</Customername>");
              }  
            if (readData[u][4].equals("N"))
              if (CommonInfo.RecordExist("select count(*) from inv_m_noncustomerinfo where INT_CUSTOMERID =" + 
                  readData[u][3])) {
                sql = "select CHR_CUSTOMERNAME from inv_m_noncustomerinfo where INT_CUSTOMERID =" + 
                  readData[u][3];
                String[][] readDatass = 
                  CommonFunctions.QueryExecute(sql);
                sb.append("<Customername>" + readDatass[0][0] + 
                    "</Customername>");
              } else {
                sb.append("<Customername>-</Customername>");
              }  
            sb.append("<Customerid>" + readData[u][4] + 
                "</Customerid>");
            sb.append("<Customerflag>" + readData[u][5] + 
                "</Customerflag>");
            sb.append("<Desc>" + readData[u][5] + "</Desc>");
            sb.append("<Startdt>" + readData[u][6] + "</Startdt>");
            sb.append("<Attendt>" + readData[u][7] + "</Attendt>");
            sb.append("<Enddt>" + readData[u][8] + "</Enddt>");
            sb.append("<Status>" + readData[u][9] + "</Status>");
            sb.append("</Servicecall>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Servicecalls>" + sb.toString() + "</Servicecalls>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadSalesPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String payType = request.getParameter("payType");
      String division = request.getParameter("division");
      String Payment = request.getParameter("Payment");
      String Branch = request.getParameter("Branch");
      String custid = request.getParameter("customer");
      Object object = session.getAttribute("BRANCHID");
      String searchid = request.getParameter("id");
      String day = request.getParameter("day");
      int month = Integer.parseInt(request.getParameter("month"));
      int year = Integer.parseInt(request.getParameter("year"));
      String type = request.getParameter("type");
      String sql = "";
      if (!payType.equals("Invoice"))
        if (!payType.equals("CashPay"))
          if (payType.equals("Direct")) {
            sql = " SELECT a.CHR_SALESNO,a.INT_CUSTOMERID,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),round(a.DOU_TOTALAMOUNT),a.CHR_PAYMENTSTATUS, ";
            sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') , ";
            sql = String.valueOf(sql) + 
              " (select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO), ";
            sql = String.valueOf(sql) + 
              " (  round(a.DOU_TOTALAMOUNT) - (select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO)    ), ";
            sql = String.valueOf(sql) + " a.INT_BRANCHID,a.INT_DIVIID,a.DAT_SALESDATE, ";
            sql = String.valueOf(sql) + 
              "   (SELECT   count(*) FROM inv_t_paymentcommitment d WHERE   d.CHR_SALESNO =a.CHR_SALESNO  AND d.CHR_STATUS='N' GROUP BY  d.CHR_SALESNO ) ";
            sql = String.valueOf(sql) + " FROM inv_t_directsales a ,inv_m_customerinfo b ";
            sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CANCEL='N' ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND  a.INT_BRANCHID =" + Branch + " "; 
            if (!"0".equals(custid))
              sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + custid; 
            if (!"0".equals(division))
              sql = String.valueOf(sql) + "  AND a.INT_DIVIID=" + division; 
            if ("1".equals(Payment)) {
              sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS ='N' ";
            } else if ("2".equals(Payment)) {
              sql = String.valueOf(sql) + "  AND a.CHR_PAYMENTSTATUS='Y' ";
            } else if ("3".equals(Payment)) {
              sql = String.valueOf(sql) + "  AND a.CHR_PAYMENTSTATUS='P' ";
            } 
            if (!"0".equals(day))
              sql = String.valueOf(sql) + " AND DAY(a.DAT_SALESDATE) =" + day; 
            if (month > 0)
              sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE) = " + month; 
            sql = String.valueOf(sql) + " AND YEAR(a.DAT_SALESDATE) = " + year;
            if ("1".equals(type)) {
              if (!"0".equals(searchid))
                sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + searchid.toUpperCase() + "%'"; 
            } else {
              sql = String.valueOf(sql) + " AND ( (a.CHR_SALESNO LIKE '%" + searchid + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + searchid.toUpperCase() + "%') )";
            } 
            sql = String.valueOf(sql) + " ORDER BY a.INT_SALESID ";
          }   
      String[][] readData = CommonFunctions.QueryExecute(sql);
      System.out.println("Sales Payment.jsp SQL: " + sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          String bal = "0";
          if (!"-".equals(readData[u][7]))
            bal = readData[u][7]; 
          double balance = Integer.parseInt(bal);
          String ck = "";
          if (balance < 0.0D)
            ck = "(Check)"; 
          if ("4".equals(Payment)) {
            if (balance < 0.0D) {
              sb.append("<Payment>");
              sb.append("<Customerid>" + readData[u][0] + "</Customerid>");
              sb.append("<Customername>" + readData[u][2] + "</Customername>");
              sb.append("<Totalamount>" + readData[u][3] + "</Totalamount>");
              sb.append("<Status>" + readData[u][4] + "</Status>");
              sb.append("<Paidamount>" + readData[u][6] + "</Paidamount>");
              sb.append("<Balance>" + readData[u][7] + ck + "</Balance>");
              sb.append("<OrderDate>" + readData[u][10] + "</OrderDate>");
              sb.append("<Commitment>" + readData[u][11] + "</Commitment>");
              sb.append("</Payment>");
            } 
          } else {
            sb.append("<Payment>");
            sb.append("<Customerid>" + readData[u][0] + "</Customerid>");
            sb.append("<Customername>" + readData[u][2] + "</Customername>");
            sb.append("<Totalamount>" + readData[u][3] + "</Totalamount>");
            sb.append("<Status>" + readData[u][4] + "</Status>");
            sb.append("<Paidamount>" + readData[u][6] + "</Paidamount>");
            sb.append("<Balance>" + readData[u][7] + ck + "</Balance>");
            sb.append("<OrderDate>" + readData[u][10] + "</OrderDate>");
            sb.append("<Commitment>" + readData[u][11] + "</Commitment>");
            sb.append("</Payment>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Payments>" + sb.toString() + "</Payments>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadSearchSalesPaymentno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String payType = request.getParameter("payType");
      String search = request.getParameter("search");
      String sql = "";
      if (!payType.equals("Invoice"))
        if (!payType.equals("CashPay"))
          if (payType.equals("Direct")) {
            sql = " SELECT CHR_SALESNO FROM inv_t_directsales ";
            sql = String.valueOf(sql) + " WHERE CHR_PAYMENTSTATUS<>'Y' AND CHR_CANCEL='N' AND FIND_A_PAYMENTCOMMITMENT(CHR_SALESNO,'C') > 0 ";
          }   
      if (!"".equals(search) && !"null".equals(search))
        sql = String.valueOf(sql) + " AND  CHR_SALESNO LIKE '%" + search + "%'  "; 
      sql = String.valueOf(sql) + " ORDER BY CHR_SALESNO ";
      System.out.println("loadSearchSalesPaymentno=====> " + sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][0] + "</Name>");
          sb.append("</Row>");
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
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadDirectBilling(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "";
      sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF , a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME,  (SELECT   count(*) FROM inv_t_paymentcommitment e WHERE   e.CHR_SALESNO =a.CHR_SALESNO  AND e.CHR_STATUS='N' GROUP BY  e.CHR_SALESNO ),(SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME),a.INT_ID    FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c  ,inv_t_paymentcommitment d WHERE  a.CHR_SALESNO =d.CHR_SALESNO  AND a.INT_CUSTOMERID=b.INT_CUSTOMERID  AND c.CHR_EMPID = a.CHR_REF   ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " ";
      sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE)=" + month + " ";
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_SALESDATE)=" + year + " ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + 
          " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + 
          StartLetter + "%'"; 
      sql = String.valueOf(sql) + 
        "   GROUP BY a.CHR_SALESNO ORDER BY  SUBSTRING_INDEX(a.CHR_SALESNO, '/',1)";
      System.out.println();
      System.out.println(sql);
      System.out.println();
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Direct>");
          sb.append("<Invoiceno>" + readData[u][0] + "</Invoiceno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Customer>" + readData[u][2] + "</Customer>");
          sb.append("<Ref>" + readData[u][6] + "</Ref>");
          sb.append("<Amount>" + readData[u][4] + "</Amount>");
          sb.append("<Status>" + readData[u][5] + "</Status>");
          sb.append("<Staff>" + readData[u][5] + "</Staff>");
          sb.append("<Commitment>" + readData[u][7] + "</Commitment>");
          sb.append("<Userid>" + readData[u][8] + "</Userid>");
          sb.append("<Rowid>" + readData[u][9] + "</Rowid>");
          sb.append("</Direct>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Directs>" + sb.toString() + "</Directs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void INVServiceBillingPO(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: invokeinterface getSession : ()Ljavax/servlet/http/HttpSession;
    //   6: astore_2
    //   7: new java/lang/StringBuilder
    //   10: dup
    //   11: invokespecial <init> : ()V
    //   14: aload_2
    //   15: ldc_w 'USRTYPE'
    //   18: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   23: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   26: invokevirtual toString : ()Ljava/lang/String;
    //   29: astore_3
    //   30: aload_0
    //   31: ldc_w 'division'
    //   34: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   39: astore #4
    //   41: aload_0
    //   42: ldc_w 'customer'
    //   45: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   50: astore #5
    //   52: aload_0
    //   53: ldc_w 'Branch'
    //   56: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   61: astore #6
    //   63: new java/lang/StringBuilder
    //   66: dup
    //   67: invokespecial <init> : ()V
    //   70: aload_0
    //   71: ldc_w 'id'
    //   74: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   79: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   82: invokevirtual toString : ()Ljava/lang/String;
    //   85: astore #7
    //   87: aload_0
    //   88: ldc_w 'month'
    //   91: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   96: astore #8
    //   98: aload_0
    //   99: ldc_w 'year'
    //   102: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   107: astore #9
    //   109: aload_0
    //   110: ldc_w 'day'
    //   113: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   118: astore #10
    //   120: aload_0
    //   121: ldc_w 'type'
    //   124: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   129: astore #11
    //   131: ldc_w '-'
    //   134: astore #12
    //   136: ldc_w 'F'
    //   139: aload_3
    //   140: invokevirtual equals : (Ljava/lang/Object;)Z
    //   143: ifne -> 180
    //   146: ldc_w 'SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1'
    //   149: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   152: iconst_0
    //   153: aaload
    //   154: iconst_0
    //   155: aaload
    //   156: ldc_w ','
    //   159: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   162: aload_2
    //   163: ldc_w 'USRID'
    //   166: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   171: invokevirtual toString : ()Ljava/lang/String;
    //   174: invokestatic contains : ([Ljava/lang/Object;Ljava/lang/Object;)Z
    //   177: ifeq -> 185
    //   180: ldc_w 'F'
    //   183: astore #12
    //   185: ldc ''
    //   187: astore #13
    //   189: ldc_w '  SELECT a.INT_SERVICEPOID, a.CHR_SERVICEPOREF,DATE_FORMAT(a.DAT_PODATE,'%d-%b-%Y'),  '
    //   192: astore #13
    //   194: new java/lang/StringBuilder
    //   197: dup
    //   198: aload #13
    //   200: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   203: invokespecial <init> : (Ljava/lang/String;)V
    //   206: ldc_w ' FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),FUN_INV_DIVISION(a.INT_DIVIID),a.DOU_AMOUNT,  '
    //   209: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   212: invokevirtual toString : ()Ljava/lang/String;
    //   215: astore #13
    //   217: new java/lang/StringBuilder
    //   220: dup
    //   221: aload #13
    //   223: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   226: invokespecial <init> : (Ljava/lang/String;)V
    //   229: ldc_w ' FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.CHR_STATUS,a.CHR_CANCEL,FUN_INV_SERVICE_PO_BILLEDAMOUNT(a.CHR_SERVICEPOREF),  '
    //   232: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   235: invokevirtual toString : ()Ljava/lang/String;
    //   238: astore #13
    //   240: new java/lang/StringBuilder
    //   243: dup
    //   244: aload #13
    //   246: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   249: invokespecial <init> : (Ljava/lang/String;)V
    //   252: ldc_w ' ( a.DOU_AMOUNT -FUN_INV_SERVICE_PO_BILLEDAMOUNT(a.CHR_SERVICEPOREF)  ) '
    //   255: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   258: invokevirtual toString : ()Ljava/lang/String;
    //   261: astore #13
    //   263: new java/lang/StringBuilder
    //   266: dup
    //   267: aload #13
    //   269: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   272: invokespecial <init> : (Ljava/lang/String;)V
    //   275: ldc_w ' FROM inv_t_servicebillingpo a   '
    //   278: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   281: invokevirtual toString : ()Ljava/lang/String;
    //   284: astore #13
    //   286: new java/lang/StringBuilder
    //   289: dup
    //   290: aload #13
    //   292: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   295: invokespecial <init> : (Ljava/lang/String;)V
    //   298: ldc_w ' WHERE  a.INT_SERVICEPOID > 0 '
    //   301: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   304: invokevirtual toString : ()Ljava/lang/String;
    //   307: astore #13
    //   309: new java/lang/StringBuilder
    //   312: dup
    //   313: aload #13
    //   315: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   318: invokespecial <init> : (Ljava/lang/String;)V
    //   321: ldc_w ' AND a.INT_BRANCHID='
    //   324: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   327: aload #6
    //   329: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   332: ldc_w ' '
    //   335: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   338: invokevirtual toString : ()Ljava/lang/String;
    //   341: astore #13
    //   343: new java/lang/StringBuilder
    //   346: dup
    //   347: aload #13
    //   349: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   352: invokespecial <init> : (Ljava/lang/String;)V
    //   355: ldc_w ' AND YEAR(a.DAT_PODATE)='
    //   358: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   361: aload #9
    //   363: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   366: ldc_w ' '
    //   369: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   372: invokevirtual toString : ()Ljava/lang/String;
    //   375: astore #13
    //   377: ldc '0'
    //   379: aload #8
    //   381: invokevirtual equals : (Ljava/lang/Object;)Z
    //   384: ifne -> 421
    //   387: new java/lang/StringBuilder
    //   390: dup
    //   391: aload #13
    //   393: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   396: invokespecial <init> : (Ljava/lang/String;)V
    //   399: ldc_w ' AND MONTH(a.DAT_PODATE)='
    //   402: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   405: aload #8
    //   407: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   410: ldc_w ' '
    //   413: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   416: invokevirtual toString : ()Ljava/lang/String;
    //   419: astore #13
    //   421: ldc '0'
    //   423: aload #10
    //   425: invokevirtual equals : (Ljava/lang/Object;)Z
    //   428: ifne -> 459
    //   431: new java/lang/StringBuilder
    //   434: dup
    //   435: aload #13
    //   437: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   440: invokespecial <init> : (Ljava/lang/String;)V
    //   443: ldc_w ' AND DAY(a.DAT_PODATE)= '
    //   446: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   449: aload #10
    //   451: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   454: invokevirtual toString : ()Ljava/lang/String;
    //   457: astore #13
    //   459: ldc '0'
    //   461: aload #5
    //   463: invokevirtual equals : (Ljava/lang/Object;)Z
    //   466: ifne -> 497
    //   469: new java/lang/StringBuilder
    //   472: dup
    //   473: aload #13
    //   475: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   478: invokespecial <init> : (Ljava/lang/String;)V
    //   481: ldc_w ' AND a.INT_CUSTOMERID='
    //   484: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   487: aload #5
    //   489: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   492: invokevirtual toString : ()Ljava/lang/String;
    //   495: astore #13
    //   497: ldc '0'
    //   499: aload #4
    //   501: invokevirtual equals : (Ljava/lang/Object;)Z
    //   504: ifne -> 535
    //   507: new java/lang/StringBuilder
    //   510: dup
    //   511: aload #13
    //   513: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   516: invokespecial <init> : (Ljava/lang/String;)V
    //   519: ldc_w ' AND a.INT_DIVIID='
    //   522: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   525: aload #4
    //   527: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   530: invokevirtual toString : ()Ljava/lang/String;
    //   533: astore #13
    //   535: ldc_w '1'
    //   538: aload #11
    //   540: invokevirtual equals : (Ljava/lang/Object;)Z
    //   543: ifeq -> 595
    //   546: ldc '0'
    //   548: aload #7
    //   550: invokevirtual equals : (Ljava/lang/Object;)Z
    //   553: ifne -> 643
    //   556: new java/lang/StringBuilder
    //   559: dup
    //   560: aload #13
    //   562: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   565: invokespecial <init> : (Ljava/lang/String;)V
    //   568: ldc_w ' AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE ''
    //   571: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   574: aload #7
    //   576: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   579: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   582: ldc '%''
    //   584: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   587: invokevirtual toString : ()Ljava/lang/String;
    //   590: astore #13
    //   592: goto -> 643
    //   595: new java/lang/StringBuilder
    //   598: dup
    //   599: aload #13
    //   601: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   604: invokespecial <init> : (Ljava/lang/String;)V
    //   607: ldc_w ' AND ( (a.CHR_SERVICEPOREF LIKE '%'
    //   610: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   613: aload #7
    //   615: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   618: ldc_w '%') OR ( FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '%'
    //   621: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   624: aload #7
    //   626: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   629: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   632: ldc_w '%') )'
    //   635: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   638: invokevirtual toString : ()Ljava/lang/String;
    //   641: astore #13
    //   643: new java/lang/StringBuilder
    //   646: dup
    //   647: aload #13
    //   649: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   652: invokespecial <init> : (Ljava/lang/String;)V
    //   655: ldc_w '  ORDER BY  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) '
    //   658: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   661: invokevirtual toString : ()Ljava/lang/String;
    //   664: astore #13
    //   666: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   669: aload #13
    //   671: invokevirtual println : (Ljava/lang/String;)V
    //   674: aload #13
    //   676: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   679: astore #14
    //   681: new java/lang/StringBuffer
    //   684: dup
    //   685: invokespecial <init> : ()V
    //   688: astore #15
    //   690: aload_0
    //   691: ldc_w '/'
    //   694: invokeinterface getRealPath : (Ljava/lang/String;)Ljava/lang/String;
    //   699: astore #16
    //   701: aconst_null
    //   702: astore #17
    //   704: aload #14
    //   706: arraylength
    //   707: ifle -> 1340
    //   710: iconst_0
    //   711: istore #18
    //   713: goto -> 1277
    //   716: aload #15
    //   718: ldc '<Row>'
    //   720: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   723: pop
    //   724: aload #15
    //   726: new java/lang/StringBuilder
    //   729: dup
    //   730: ldc '<Rowid>'
    //   732: invokespecial <init> : (Ljava/lang/String;)V
    //   735: aload #14
    //   737: iload #18
    //   739: aaload
    //   740: iconst_0
    //   741: aaload
    //   742: invokevirtual trim : ()Ljava/lang/String;
    //   745: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   748: ldc '</Rowid>'
    //   750: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   753: invokevirtual toString : ()Ljava/lang/String;
    //   756: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   759: pop
    //   760: aload #15
    //   762: new java/lang/StringBuilder
    //   765: dup
    //   766: ldc_w '<Invoiceno>'
    //   769: invokespecial <init> : (Ljava/lang/String;)V
    //   772: aload #14
    //   774: iload #18
    //   776: aaload
    //   777: iconst_1
    //   778: aaload
    //   779: invokevirtual trim : ()Ljava/lang/String;
    //   782: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   785: ldc_w '</Invoiceno>'
    //   788: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   791: invokevirtual toString : ()Ljava/lang/String;
    //   794: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   797: pop
    //   798: aload #15
    //   800: new java/lang/StringBuilder
    //   803: dup
    //   804: ldc_w '<Date>'
    //   807: invokespecial <init> : (Ljava/lang/String;)V
    //   810: aload #14
    //   812: iload #18
    //   814: aaload
    //   815: iconst_2
    //   816: aaload
    //   817: invokevirtual trim : ()Ljava/lang/String;
    //   820: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   823: ldc_w '</Date>'
    //   826: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   829: invokevirtual toString : ()Ljava/lang/String;
    //   832: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   835: pop
    //   836: aload #15
    //   838: new java/lang/StringBuilder
    //   841: dup
    //   842: ldc_w '<Customer>'
    //   845: invokespecial <init> : (Ljava/lang/String;)V
    //   848: aload #14
    //   850: iload #18
    //   852: aaload
    //   853: iconst_3
    //   854: aaload
    //   855: ldc '&'
    //   857: ldc ''
    //   859: invokevirtual replace : (Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    //   862: invokevirtual trim : ()Ljava/lang/String;
    //   865: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   868: ldc_w '</Customer>'
    //   871: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   874: invokevirtual toString : ()Ljava/lang/String;
    //   877: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   880: pop
    //   881: aload #15
    //   883: new java/lang/StringBuilder
    //   886: dup
    //   887: ldc_w '<Division>'
    //   890: invokespecial <init> : (Ljava/lang/String;)V
    //   893: aload #14
    //   895: iload #18
    //   897: aaload
    //   898: iconst_4
    //   899: aaload
    //   900: invokevirtual trim : ()Ljava/lang/String;
    //   903: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   906: ldc_w '</Division>'
    //   909: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   912: invokevirtual toString : ()Ljava/lang/String;
    //   915: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   918: pop
    //   919: aload #15
    //   921: new java/lang/StringBuilder
    //   924: dup
    //   925: ldc_w '<Amount>'
    //   928: invokespecial <init> : (Ljava/lang/String;)V
    //   931: aload #14
    //   933: iload #18
    //   935: aaload
    //   936: iconst_5
    //   937: aaload
    //   938: invokevirtual trim : ()Ljava/lang/String;
    //   941: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   944: ldc_w '</Amount>'
    //   947: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   950: invokevirtual toString : ()Ljava/lang/String;
    //   953: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   956: pop
    //   957: aload #15
    //   959: new java/lang/StringBuilder
    //   962: dup
    //   963: ldc_w '<Ref>'
    //   966: invokespecial <init> : (Ljava/lang/String;)V
    //   969: aload #14
    //   971: iload #18
    //   973: aaload
    //   974: bipush #6
    //   976: aaload
    //   977: invokevirtual trim : ()Ljava/lang/String;
    //   980: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   983: ldc_w '</Ref>'
    //   986: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   989: invokevirtual toString : ()Ljava/lang/String;
    //   992: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   995: pop
    //   996: aload #15
    //   998: new java/lang/StringBuilder
    //   1001: dup
    //   1002: ldc_w '<Status>'
    //   1005: invokespecial <init> : (Ljava/lang/String;)V
    //   1008: aload #14
    //   1010: iload #18
    //   1012: aaload
    //   1013: bipush #7
    //   1015: aaload
    //   1016: invokevirtual trim : ()Ljava/lang/String;
    //   1019: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1022: ldc_w '</Status>'
    //   1025: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1028: invokevirtual toString : ()Ljava/lang/String;
    //   1031: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1034: pop
    //   1035: aload #15
    //   1037: new java/lang/StringBuilder
    //   1040: dup
    //   1041: ldc_w '<Cancel>'
    //   1044: invokespecial <init> : (Ljava/lang/String;)V
    //   1047: aload #14
    //   1049: iload #18
    //   1051: aaload
    //   1052: bipush #8
    //   1054: aaload
    //   1055: invokevirtual trim : ()Ljava/lang/String;
    //   1058: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1061: ldc_w '</Cancel>'
    //   1064: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1067: invokevirtual toString : ()Ljava/lang/String;
    //   1070: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1073: pop
    //   1074: aload #15
    //   1076: new java/lang/StringBuilder
    //   1079: dup
    //   1080: ldc_w '<Billed>'
    //   1083: invokespecial <init> : (Ljava/lang/String;)V
    //   1086: aload #14
    //   1088: iload #18
    //   1090: aaload
    //   1091: bipush #9
    //   1093: aaload
    //   1094: invokevirtual trim : ()Ljava/lang/String;
    //   1097: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1100: ldc_w '</Billed>'
    //   1103: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1106: invokevirtual toString : ()Ljava/lang/String;
    //   1109: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1112: pop
    //   1113: aload #15
    //   1115: new java/lang/StringBuilder
    //   1118: dup
    //   1119: ldc_w '<Balance>'
    //   1122: invokespecial <init> : (Ljava/lang/String;)V
    //   1125: aload #14
    //   1127: iload #18
    //   1129: aaload
    //   1130: bipush #10
    //   1132: aaload
    //   1133: invokevirtual trim : ()Ljava/lang/String;
    //   1136: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1139: ldc_w '</Balance>'
    //   1142: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1145: invokevirtual toString : ()Ljava/lang/String;
    //   1148: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1151: pop
    //   1152: aload #15
    //   1154: new java/lang/StringBuilder
    //   1157: dup
    //   1158: ldc_w '<Usertype>'
    //   1161: invokespecial <init> : (Ljava/lang/String;)V
    //   1164: aload #12
    //   1166: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1169: ldc_w '</Usertype>'
    //   1172: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1175: invokevirtual toString : ()Ljava/lang/String;
    //   1178: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1181: pop
    //   1182: new java/io/File
    //   1185: dup
    //   1186: new java/lang/StringBuilder
    //   1189: dup
    //   1190: aload #16
    //   1192: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   1195: invokespecial <init> : (Ljava/lang/String;)V
    //   1198: ldc_w 'uploadfiles/SERVICEPO/'
    //   1201: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1204: aload #14
    //   1206: iload #18
    //   1208: aaload
    //   1209: iconst_1
    //   1210: aaload
    //   1211: ldc_w '/'
    //   1214: ldc_w '_'
    //   1217: invokevirtual replaceAll : (Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    //   1220: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1223: ldc_w '.pdf'
    //   1226: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1229: invokevirtual toString : ()Ljava/lang/String;
    //   1232: invokespecial <init> : (Ljava/lang/String;)V
    //   1235: astore #17
    //   1237: aload #17
    //   1239: invokevirtual exists : ()Z
    //   1242: ifeq -> 1257
    //   1245: aload #15
    //   1247: ldc_w '<Download>Y</Download>'
    //   1250: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1253: pop
    //   1254: goto -> 1266
    //   1257: aload #15
    //   1259: ldc_w '<Download>N</Download>'
    //   1262: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1265: pop
    //   1266: aload #15
    //   1268: ldc '</Row>'
    //   1270: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1273: pop
    //   1274: iinc #18, 1
    //   1277: iload #18
    //   1279: aload #14
    //   1281: arraylength
    //   1282: if_icmplt -> 716
    //   1285: aload_1
    //   1286: ldc 'text/xml'
    //   1288: invokeinterface setContentType : (Ljava/lang/String;)V
    //   1293: aload_1
    //   1294: ldc 'Cache-Control'
    //   1296: ldc 'no-cache'
    //   1298: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   1303: aload_1
    //   1304: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   1309: new java/lang/StringBuilder
    //   1312: dup
    //   1313: ldc '<Rows>'
    //   1315: invokespecial <init> : (Ljava/lang/String;)V
    //   1318: aload #15
    //   1320: invokevirtual toString : ()Ljava/lang/String;
    //   1323: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1326: ldc '</Rows>'
    //   1328: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1331: invokevirtual toString : ()Ljava/lang/String;
    //   1334: invokevirtual write : (Ljava/lang/String;)V
    //   1337: goto -> 1392
    //   1340: aload_1
    //   1341: sipush #204
    //   1344: invokeinterface setStatus : (I)V
    //   1349: goto -> 1392
    //   1352: astore_2
    //   1353: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   1356: aload_2
    //   1357: invokevirtual getMessage : ()Ljava/lang/String;
    //   1360: invokevirtual println : (Ljava/lang/String;)V
    //   1363: aload_0
    //   1364: ldc 'error'
    //   1366: aload_2
    //   1367: invokevirtual getMessage : ()Ljava/lang/String;
    //   1370: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   1375: aload_0
    //   1376: ldc '/error/index.jsp'
    //   1378: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   1383: astore_3
    //   1384: aload_3
    //   1385: aload_0
    //   1386: aload_1
    //   1387: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   1392: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #5050	-> 0
    //   #5051	-> 7
    //   #5053	-> 30
    //   #5054	-> 41
    //   #5055	-> 52
    //   #5056	-> 63
    //   #5057	-> 87
    //   #5058	-> 98
    //   #5059	-> 109
    //   #5060	-> 120
    //   #5061	-> 131
    //   #5062	-> 136
    //   #5066	-> 146
    //   #5065	-> 153
    //   #5066	-> 154
    //   #5065	-> 155
    //   #5067	-> 156
    //   #5068	-> 162
    //   #5064	-> 174
    //   #5068	-> 177
    //   #5069	-> 180
    //   #5071	-> 185
    //   #5072	-> 189
    //   #5073	-> 194
    //   #5074	-> 217
    //   #5075	-> 240
    //   #5076	-> 263
    //   #5077	-> 286
    //   #5078	-> 309
    //   #5079	-> 343
    //   #5080	-> 377
    //   #5081	-> 387
    //   #5082	-> 421
    //   #5083	-> 431
    //   #5084	-> 459
    //   #5085	-> 469
    //   #5086	-> 497
    //   #5087	-> 507
    //   #5089	-> 535
    //   #5091	-> 546
    //   #5092	-> 556
    //   #5093	-> 592
    //   #5096	-> 595
    //   #5098	-> 643
    //   #5099	-> 666
    //   #5100	-> 674
    //   #5101	-> 681
    //   #5104	-> 690
    //   #5105	-> 701
    //   #5108	-> 704
    //   #5110	-> 710
    //   #5112	-> 716
    //   #5113	-> 724
    //   #5114	-> 760
    //   #5115	-> 798
    //   #5116	-> 836
    //   #5117	-> 881
    //   #5118	-> 919
    //   #5119	-> 957
    //   #5120	-> 996
    //   #5121	-> 1035
    //   #5122	-> 1074
    //   #5123	-> 1113
    //   #5124	-> 1152
    //   #5125	-> 1182
    //   #5126	-> 1237
    //   #5127	-> 1245
    //   #5129	-> 1257
    //   #5130	-> 1266
    //   #5110	-> 1274
    //   #5133	-> 1285
    //   #5134	-> 1293
    //   #5135	-> 1303
    //   #5136	-> 1337
    //   #5139	-> 1340
    //   #5142	-> 1349
    //   #5143	-> 1352
    //   #5145	-> 1353
    //   #5146	-> 1363
    //   #5147	-> 1375
    //   #5148	-> 1384
    //   #5150	-> 1392
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	1393	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	1393	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   7	1342	2	session	Ljavax/servlet/http/HttpSession;
    //   30	1319	3	usertype	Ljava/lang/String;
    //   41	1308	4	division	Ljava/lang/String;
    //   52	1297	5	customer	Ljava/lang/String;
    //   63	1286	6	Branch	Ljava/lang/String;
    //   87	1262	7	StartLetter	Ljava/lang/String;
    //   98	1251	8	month	Ljava/lang/String;
    //   109	1240	9	year	Ljava/lang/String;
    //   120	1229	10	day	Ljava/lang/String;
    //   131	1218	11	type	Ljava/lang/String;
    //   136	1213	12	Usertype	Ljava/lang/String;
    //   189	1160	13	sql	Ljava/lang/String;
    //   681	668	14	readData	[[Ljava/lang/String;
    //   690	659	15	sb	Ljava/lang/StringBuffer;
    //   701	648	16	filepath	Ljava/lang/String;
    //   704	645	17	f	Ljava/io/File;
    //   713	572	18	u	I
    //   1353	39	2	e	Ljava/lang/Exception;
    //   1384	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	1349	1352	java/lang/Exception
  }
  
  public static void LoadServiceBilling(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: invokeinterface getSession : ()Ljavax/servlet/http/HttpSession;
    //   6: astore_2
    //   7: new java/lang/StringBuilder
    //   10: dup
    //   11: invokespecial <init> : ()V
    //   14: aload_2
    //   15: ldc_w 'USRTYPE'
    //   18: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   23: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   26: invokevirtual toString : ()Ljava/lang/String;
    //   29: astore_3
    //   30: aload_0
    //   31: ldc_w 'division'
    //   34: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   39: astore #4
    //   41: aload_0
    //   42: ldc_w 'customer'
    //   45: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   50: astore #5
    //   52: aload_0
    //   53: ldc_w 'Branch'
    //   56: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   61: astore #6
    //   63: new java/lang/StringBuilder
    //   66: dup
    //   67: invokespecial <init> : ()V
    //   70: aload_0
    //   71: ldc_w 'id'
    //   74: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   79: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   82: invokevirtual toString : ()Ljava/lang/String;
    //   85: astore #7
    //   87: aload_0
    //   88: ldc_w 'month'
    //   91: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   96: astore #8
    //   98: aload_0
    //   99: ldc_w 'year'
    //   102: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   107: astore #9
    //   109: aload_0
    //   110: ldc_w 'day'
    //   113: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   118: astore #10
    //   120: aload_0
    //   121: ldc_w 'type'
    //   124: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   129: astore #11
    //   131: ldc_w '-'
    //   134: astore #12
    //   136: ldc_w 'F'
    //   139: aload_3
    //   140: invokevirtual equals : (Ljava/lang/Object;)Z
    //   143: ifne -> 180
    //   146: ldc_w 'SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1'
    //   149: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   152: iconst_0
    //   153: aaload
    //   154: iconst_0
    //   155: aaload
    //   156: ldc_w ','
    //   159: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   162: aload_2
    //   163: ldc_w 'USRID'
    //   166: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   171: invokevirtual toString : ()Ljava/lang/String;
    //   174: invokestatic contains : ([Ljava/lang/Object;Ljava/lang/Object;)Z
    //   177: ifeq -> 185
    //   180: ldc_w 'F'
    //   183: astore #12
    //   185: ldc ''
    //   187: astore #13
    //   189: ldc_w '  SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), '
    //   192: astore #13
    //   194: new java/lang/StringBuilder
    //   197: dup
    //   198: aload #13
    //   200: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   203: invokespecial <init> : (Ljava/lang/String;)V
    //   206: ldc_w ' a.CHR_REF , a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ,  '
    //   209: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   212: invokevirtual toString : ()Ljava/lang/String;
    //   215: astore #13
    //   217: new java/lang/StringBuilder
    //   220: dup
    //   221: aload #13
    //   223: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   226: invokespecial <init> : (Ljava/lang/String;)V
    //   229: ldc_w ' (SELECT   count(*) FROM inv_t_paymentcommitment e WHERE   e.CHR_SALESNO =a.CHR_SALESNO  AND e.CHR_STATUS='N' GROUP BY  e.CHR_SALESNO ),'
    //   232: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   235: invokevirtual toString : ()Ljava/lang/String;
    //   238: astore #13
    //   240: new java/lang/StringBuilder
    //   243: dup
    //   244: aload #13
    //   246: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   249: invokespecial <init> : (Ljava/lang/String;)V
    //   252: ldc_w ' (SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME) ,'
    //   255: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   258: invokevirtual toString : ()Ljava/lang/String;
    //   261: astore #13
    //   263: new java/lang/StringBuilder
    //   266: dup
    //   267: aload #13
    //   269: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   272: invokespecial <init> : (Ljava/lang/String;)V
    //   275: ldc_w ' d.CHR_STATUS,a.CHR_CANCEL,FUN_INV_DIVISION(a.INT_DIVIID) , '
    //   278: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   281: invokevirtual toString : ()Ljava/lang/String;
    //   284: astore #13
    //   286: new java/lang/StringBuilder
    //   289: dup
    //   290: aload #13
    //   292: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   295: invokespecial <init> : (Ljava/lang/String;)V
    //   298: ldc_w ' (NOW() > DATE_ADD(DAT_SALESDATE, INTERVAL (SELECT INT_INVOCECHANGES FROM m_inventorysetting WHERE INT_ROWID= 1) DAY )) '
    //   301: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   304: invokevirtual toString : ()Ljava/lang/String;
    //   307: astore #13
    //   309: new java/lang/StringBuilder
    //   312: dup
    //   313: aload #13
    //   315: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   318: invokespecial <init> : (Ljava/lang/String;)V
    //   321: ldc_w ' FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c ,'
    //   324: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   327: invokevirtual toString : ()Ljava/lang/String;
    //   330: astore #13
    //   332: new java/lang/StringBuilder
    //   335: dup
    //   336: aload #13
    //   338: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   341: invokespecial <init> : (Ljava/lang/String;)V
    //   344: ldc_w ' inv_t_paymentcommitment d   WHERE  a.CHR_SALESNO =d.CHR_SALESNO  '
    //   347: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   350: invokevirtual toString : ()Ljava/lang/String;
    //   353: astore #13
    //   355: new java/lang/StringBuilder
    //   358: dup
    //   359: aload #13
    //   361: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   364: invokespecial <init> : (Ljava/lang/String;)V
    //   367: ldc_w '  AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF    '
    //   370: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   373: invokevirtual toString : ()Ljava/lang/String;
    //   376: astore #13
    //   378: new java/lang/StringBuilder
    //   381: dup
    //   382: aload #13
    //   384: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   387: invokespecial <init> : (Ljava/lang/String;)V
    //   390: ldc_w ' AND a.INT_BRANCHID='
    //   393: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   396: aload #6
    //   398: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   401: ldc_w ' '
    //   404: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   407: invokevirtual toString : ()Ljava/lang/String;
    //   410: astore #13
    //   412: new java/lang/StringBuilder
    //   415: dup
    //   416: aload #13
    //   418: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   421: invokespecial <init> : (Ljava/lang/String;)V
    //   424: ldc_w ' AND YEAR(a.DAT_SALESDATE)='
    //   427: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   430: aload #9
    //   432: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   435: ldc_w ' '
    //   438: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   441: invokevirtual toString : ()Ljava/lang/String;
    //   444: astore #13
    //   446: ldc '0'
    //   448: aload #8
    //   450: invokevirtual equals : (Ljava/lang/Object;)Z
    //   453: ifne -> 490
    //   456: new java/lang/StringBuilder
    //   459: dup
    //   460: aload #13
    //   462: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   465: invokespecial <init> : (Ljava/lang/String;)V
    //   468: ldc_w ' AND MONTH(a.DAT_SALESDATE)='
    //   471: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   474: aload #8
    //   476: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   479: ldc_w ' '
    //   482: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   485: invokevirtual toString : ()Ljava/lang/String;
    //   488: astore #13
    //   490: ldc '0'
    //   492: aload #10
    //   494: invokevirtual equals : (Ljava/lang/Object;)Z
    //   497: ifne -> 528
    //   500: new java/lang/StringBuilder
    //   503: dup
    //   504: aload #13
    //   506: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   509: invokespecial <init> : (Ljava/lang/String;)V
    //   512: ldc_w ' AND DAY(a.DAT_SALESDATE)= '
    //   515: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   518: aload #10
    //   520: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   523: invokevirtual toString : ()Ljava/lang/String;
    //   526: astore #13
    //   528: ldc '0'
    //   530: aload #5
    //   532: invokevirtual equals : (Ljava/lang/Object;)Z
    //   535: ifne -> 566
    //   538: new java/lang/StringBuilder
    //   541: dup
    //   542: aload #13
    //   544: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   547: invokespecial <init> : (Ljava/lang/String;)V
    //   550: ldc_w ' AND a.INT_CUSTOMERID='
    //   553: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   556: aload #5
    //   558: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   561: invokevirtual toString : ()Ljava/lang/String;
    //   564: astore #13
    //   566: ldc '0'
    //   568: aload #4
    //   570: invokevirtual equals : (Ljava/lang/Object;)Z
    //   573: ifne -> 604
    //   576: new java/lang/StringBuilder
    //   579: dup
    //   580: aload #13
    //   582: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   585: invokespecial <init> : (Ljava/lang/String;)V
    //   588: ldc_w ' AND a.INT_DIVIID='
    //   591: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   594: aload #4
    //   596: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   599: invokevirtual toString : ()Ljava/lang/String;
    //   602: astore #13
    //   604: ldc_w '1'
    //   607: aload #11
    //   609: invokevirtual equals : (Ljava/lang/Object;)Z
    //   612: ifeq -> 664
    //   615: ldc '0'
    //   617: aload #7
    //   619: invokevirtual equals : (Ljava/lang/Object;)Z
    //   622: ifne -> 712
    //   625: new java/lang/StringBuilder
    //   628: dup
    //   629: aload #13
    //   631: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   634: invokespecial <init> : (Ljava/lang/String;)V
    //   637: ldc_w ' AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE ''
    //   640: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   643: aload #7
    //   645: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   648: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   651: ldc '%''
    //   653: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   656: invokevirtual toString : ()Ljava/lang/String;
    //   659: astore #13
    //   661: goto -> 712
    //   664: new java/lang/StringBuilder
    //   667: dup
    //   668: aload #13
    //   670: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   673: invokespecial <init> : (Ljava/lang/String;)V
    //   676: ldc_w ' AND ( (a.CHR_SALESNO LIKE '%'
    //   679: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   682: aload #7
    //   684: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   687: ldc_w '%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '%'
    //   690: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   693: aload #7
    //   695: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   698: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   701: ldc_w '%') )'
    //   704: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   707: invokevirtual toString : ()Ljava/lang/String;
    //   710: astore #13
    //   712: new java/lang/StringBuilder
    //   715: dup
    //   716: aload #13
    //   718: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   721: invokespecial <init> : (Ljava/lang/String;)V
    //   724: ldc_w '  GROUP BY  a.INT_ID'
    //   727: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   730: invokevirtual toString : ()Ljava/lang/String;
    //   733: astore #13
    //   735: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   738: aload #13
    //   740: invokevirtual println : (Ljava/lang/String;)V
    //   743: aload #13
    //   745: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   748: astore #14
    //   750: new java/lang/StringBuffer
    //   753: dup
    //   754: invokespecial <init> : ()V
    //   757: astore #15
    //   759: aload #14
    //   761: arraylength
    //   762: ifle -> 1318
    //   765: iconst_0
    //   766: istore #16
    //   768: goto -> 1253
    //   771: aload #15
    //   773: ldc_w '<Service>'
    //   776: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   779: pop
    //   780: aload #15
    //   782: new java/lang/StringBuilder
    //   785: dup
    //   786: ldc_w '<Invoiceno>'
    //   789: invokespecial <init> : (Ljava/lang/String;)V
    //   792: aload #14
    //   794: iload #16
    //   796: aaload
    //   797: iconst_0
    //   798: aaload
    //   799: invokevirtual trim : ()Ljava/lang/String;
    //   802: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   805: ldc_w '</Invoiceno>'
    //   808: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   811: invokevirtual toString : ()Ljava/lang/String;
    //   814: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   817: pop
    //   818: aload #15
    //   820: new java/lang/StringBuilder
    //   823: dup
    //   824: ldc_w '<Date>'
    //   827: invokespecial <init> : (Ljava/lang/String;)V
    //   830: aload #14
    //   832: iload #16
    //   834: aaload
    //   835: iconst_1
    //   836: aaload
    //   837: invokevirtual trim : ()Ljava/lang/String;
    //   840: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   843: ldc_w '</Date>'
    //   846: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   849: invokevirtual toString : ()Ljava/lang/String;
    //   852: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   855: pop
    //   856: aload #15
    //   858: new java/lang/StringBuilder
    //   861: dup
    //   862: ldc_w '<Customer>'
    //   865: invokespecial <init> : (Ljava/lang/String;)V
    //   868: aload #14
    //   870: iload #16
    //   872: aaload
    //   873: iconst_2
    //   874: aaload
    //   875: ldc '&'
    //   877: ldc ''
    //   879: invokevirtual replace : (Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    //   882: invokevirtual trim : ()Ljava/lang/String;
    //   885: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   888: ldc_w '</Customer>'
    //   891: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   894: invokevirtual toString : ()Ljava/lang/String;
    //   897: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   900: pop
    //   901: aload #15
    //   903: new java/lang/StringBuilder
    //   906: dup
    //   907: ldc_w '<Ref>'
    //   910: invokespecial <init> : (Ljava/lang/String;)V
    //   913: aload #14
    //   915: iload #16
    //   917: aaload
    //   918: bipush #6
    //   920: aaload
    //   921: invokevirtual trim : ()Ljava/lang/String;
    //   924: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   927: ldc_w '</Ref>'
    //   930: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   933: invokevirtual toString : ()Ljava/lang/String;
    //   936: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   939: pop
    //   940: aload #15
    //   942: new java/lang/StringBuilder
    //   945: dup
    //   946: ldc_w '<Amount>'
    //   949: invokespecial <init> : (Ljava/lang/String;)V
    //   952: aload #14
    //   954: iload #16
    //   956: aaload
    //   957: iconst_4
    //   958: aaload
    //   959: invokevirtual trim : ()Ljava/lang/String;
    //   962: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   965: ldc_w '</Amount>'
    //   968: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   971: invokevirtual toString : ()Ljava/lang/String;
    //   974: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   977: pop
    //   978: aload #15
    //   980: new java/lang/StringBuilder
    //   983: dup
    //   984: ldc_w '<Status>'
    //   987: invokespecial <init> : (Ljava/lang/String;)V
    //   990: aload #14
    //   992: iload #16
    //   994: aaload
    //   995: iconst_5
    //   996: aaload
    //   997: invokevirtual trim : ()Ljava/lang/String;
    //   1000: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1003: ldc_w '</Status>'
    //   1006: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1009: invokevirtual toString : ()Ljava/lang/String;
    //   1012: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1015: pop
    //   1016: aload #15
    //   1018: new java/lang/StringBuilder
    //   1021: dup
    //   1022: ldc_w '<Commitment>'
    //   1025: invokespecial <init> : (Ljava/lang/String;)V
    //   1028: aload #14
    //   1030: iload #16
    //   1032: aaload
    //   1033: bipush #9
    //   1035: aaload
    //   1036: invokevirtual trim : ()Ljava/lang/String;
    //   1039: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1042: ldc_w '</Commitment>'
    //   1045: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1048: invokevirtual toString : ()Ljava/lang/String;
    //   1051: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1054: pop
    //   1055: aload #15
    //   1057: new java/lang/StringBuilder
    //   1060: dup
    //   1061: ldc_w '<Userid>'
    //   1064: invokespecial <init> : (Ljava/lang/String;)V
    //   1067: aload #14
    //   1069: iload #16
    //   1071: aaload
    //   1072: bipush #8
    //   1074: aaload
    //   1075: invokevirtual trim : ()Ljava/lang/String;
    //   1078: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1081: ldc_w '</Userid>'
    //   1084: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1087: invokevirtual toString : ()Ljava/lang/String;
    //   1090: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1093: pop
    //   1094: aload #15
    //   1096: new java/lang/StringBuilder
    //   1099: dup
    //   1100: ldc_w '<Cancel>'
    //   1103: invokespecial <init> : (Ljava/lang/String;)V
    //   1106: aload #14
    //   1108: iload #16
    //   1110: aaload
    //   1111: bipush #10
    //   1113: aaload
    //   1114: invokevirtual trim : ()Ljava/lang/String;
    //   1117: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1120: ldc_w '</Cancel>'
    //   1123: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1126: invokevirtual toString : ()Ljava/lang/String;
    //   1129: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1132: pop
    //   1133: aload #15
    //   1135: new java/lang/StringBuilder
    //   1138: dup
    //   1139: ldc_w '<Division>'
    //   1142: invokespecial <init> : (Ljava/lang/String;)V
    //   1145: aload #14
    //   1147: iload #16
    //   1149: aaload
    //   1150: bipush #11
    //   1152: aaload
    //   1153: invokevirtual trim : ()Ljava/lang/String;
    //   1156: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1159: ldc_w '</Division>'
    //   1162: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1165: invokevirtual toString : ()Ljava/lang/String;
    //   1168: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1171: pop
    //   1172: aload #15
    //   1174: new java/lang/StringBuilder
    //   1177: dup
    //   1178: ldc_w '<Dtcheck>'
    //   1181: invokespecial <init> : (Ljava/lang/String;)V
    //   1184: aload #14
    //   1186: iload #16
    //   1188: aaload
    //   1189: bipush #12
    //   1191: aaload
    //   1192: invokevirtual trim : ()Ljava/lang/String;
    //   1195: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1198: ldc_w '</Dtcheck>'
    //   1201: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1204: invokevirtual toString : ()Ljava/lang/String;
    //   1207: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1210: pop
    //   1211: aload #15
    //   1213: new java/lang/StringBuilder
    //   1216: dup
    //   1217: ldc_w '<Usertype>'
    //   1220: invokespecial <init> : (Ljava/lang/String;)V
    //   1223: aload #12
    //   1225: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1228: ldc_w '</Usertype>'
    //   1231: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1234: invokevirtual toString : ()Ljava/lang/String;
    //   1237: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1240: pop
    //   1241: aload #15
    //   1243: ldc_w '</Service>'
    //   1246: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1249: pop
    //   1250: iinc #16, 1
    //   1253: iload #16
    //   1255: aload #14
    //   1257: arraylength
    //   1258: if_icmplt -> 771
    //   1261: aload_1
    //   1262: ldc 'text/xml'
    //   1264: invokeinterface setContentType : (Ljava/lang/String;)V
    //   1269: aload_1
    //   1270: ldc 'Cache-Control'
    //   1272: ldc 'no-cache'
    //   1274: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   1279: aload_1
    //   1280: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   1285: new java/lang/StringBuilder
    //   1288: dup
    //   1289: ldc_w '<Services>'
    //   1292: invokespecial <init> : (Ljava/lang/String;)V
    //   1295: aload #15
    //   1297: invokevirtual toString : ()Ljava/lang/String;
    //   1300: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1303: ldc_w '</Services>'
    //   1306: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1309: invokevirtual toString : ()Ljava/lang/String;
    //   1312: invokevirtual write : (Ljava/lang/String;)V
    //   1315: goto -> 1370
    //   1318: aload_1
    //   1319: sipush #204
    //   1322: invokeinterface setStatus : (I)V
    //   1327: goto -> 1370
    //   1330: astore_2
    //   1331: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   1334: aload_2
    //   1335: invokevirtual getMessage : ()Ljava/lang/String;
    //   1338: invokevirtual println : (Ljava/lang/String;)V
    //   1341: aload_0
    //   1342: ldc 'error'
    //   1344: aload_2
    //   1345: invokevirtual getMessage : ()Ljava/lang/String;
    //   1348: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   1353: aload_0
    //   1354: ldc '/error/index.jsp'
    //   1356: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   1361: astore_3
    //   1362: aload_3
    //   1363: aload_0
    //   1364: aload_1
    //   1365: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   1370: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #5156	-> 0
    //   #5157	-> 7
    //   #5159	-> 30
    //   #5160	-> 41
    //   #5161	-> 52
    //   #5162	-> 63
    //   #5163	-> 87
    //   #5164	-> 98
    //   #5165	-> 109
    //   #5166	-> 120
    //   #5167	-> 131
    //   #5168	-> 136
    //   #5172	-> 146
    //   #5171	-> 153
    //   #5172	-> 154
    //   #5171	-> 155
    //   #5173	-> 156
    //   #5174	-> 162
    //   #5170	-> 174
    //   #5174	-> 177
    //   #5175	-> 180
    //   #5177	-> 185
    //   #5178	-> 189
    //   #5179	-> 194
    //   #5180	-> 217
    //   #5181	-> 240
    //   #5182	-> 263
    //   #5183	-> 286
    //   #5184	-> 309
    //   #5185	-> 332
    //   #5186	-> 355
    //   #5187	-> 378
    //   #5188	-> 412
    //   #5189	-> 446
    //   #5190	-> 456
    //   #5191	-> 490
    //   #5192	-> 500
    //   #5193	-> 528
    //   #5194	-> 538
    //   #5195	-> 566
    //   #5196	-> 576
    //   #5198	-> 604
    //   #5200	-> 615
    //   #5201	-> 625
    //   #5202	-> 661
    //   #5205	-> 664
    //   #5207	-> 712
    //   #5214	-> 735
    //   #5216	-> 743
    //   #5217	-> 750
    //   #5218	-> 759
    //   #5220	-> 765
    //   #5222	-> 771
    //   #5223	-> 780
    //   #5224	-> 818
    //   #5225	-> 856
    //   #5226	-> 901
    //   #5227	-> 940
    //   #5228	-> 978
    //   #5229	-> 1016
    //   #5230	-> 1055
    //   #5231	-> 1094
    //   #5232	-> 1133
    //   #5233	-> 1172
    //   #5234	-> 1211
    //   #5235	-> 1241
    //   #5220	-> 1250
    //   #5237	-> 1261
    //   #5238	-> 1269
    //   #5239	-> 1279
    //   #5240	-> 1315
    //   #5243	-> 1318
    //   #5246	-> 1327
    //   #5247	-> 1330
    //   #5249	-> 1331
    //   #5250	-> 1341
    //   #5251	-> 1353
    //   #5252	-> 1362
    //   #5254	-> 1370
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	1371	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	1371	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   7	1320	2	session	Ljavax/servlet/http/HttpSession;
    //   30	1297	3	usertype	Ljava/lang/String;
    //   41	1286	4	division	Ljava/lang/String;
    //   52	1275	5	customer	Ljava/lang/String;
    //   63	1264	6	Branch	Ljava/lang/String;
    //   87	1240	7	StartLetter	Ljava/lang/String;
    //   98	1229	8	month	Ljava/lang/String;
    //   109	1218	9	year	Ljava/lang/String;
    //   120	1207	10	day	Ljava/lang/String;
    //   131	1196	11	type	Ljava/lang/String;
    //   136	1191	12	Usertype	Ljava/lang/String;
    //   189	1138	13	sql	Ljava/lang/String;
    //   750	577	14	readData	[[Ljava/lang/String;
    //   759	568	15	sb	Ljava/lang/StringBuffer;
    //   768	493	16	u	I
    //   1331	39	2	e	Ljava/lang/Exception;
    //   1362	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	1327	1330	java/lang/Exception
  }
  
  public static void loadAdvanceAmount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String advanceto = request.getParameter("advanceto");
      String sql = "";
      sql = " SELECT a.INT_ADVANCEID, FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_DIVICODE, ";
      sql = String.valueOf(sql) + " a.DOU_ADVANCEAMOUNT,DATE_FORMAT(a.DAT_PAYMENTDATE,'%d-%b-%Y'), DATE_FORMAT(DAT_COLLECTEDDATE,'%d-%b-%Y'),FIND_A_EMPLOYEE_ID_NAME(a.CHR_COLLECTEDBY),FIND_A_EMPLOYEE_ID_NAME(a.CHR_CREATED_BY),a.CHR_TRANSFERD,  ";
      sql = String.valueOf(sql) + " a.CHR_ADVANCEID,a.CHR_TYPE,";
      sql = String.valueOf(sql) + " a.DOU_TRANSFERAMOUNT,(a.DOU_ADVANCEAMOUNT - a.DOU_TRANSFERAMOUNT), b.INT_CUSTOMERGROUPID  ";
      sql = String.valueOf(sql) + " FROM inv_t_advancepayment a, inv_m_customerinfo b ,inv_m_division c ";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND a.CHR_DELETEFLAG !='Y'";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID = c.INT_DIVIID ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " ";
      sql = String.valueOf(sql) + " AND MONTH(DAT_CREATEDATE)=" + month + " ";
      sql = String.valueOf(sql) + " AND YEAR(DAT_CREATEDATE)=" + year + " ";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(DAT_CREATEDATE)= " + day; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(advanceto))
        sql = String.valueOf(sql) + " AND a.CHR_TYPE = '" + advanceto + "'"; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + 
          " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + 
          StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY a.INT_ADVANCEID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Advance>");
          sb.append("<Advanceid>" + readData[u][0].trim() + "</Advanceid>");
          sb.append("<Customer>" + readData[u][1].replace("&", "").trim() + "</Customer>");
          sb.append("<Division>" + readData[u][2].trim() + "</Division>");
          sb.append("<Amount>" + readData[u][3].trim() + "</Amount>");
          sb.append("<PaymentDate>" + readData[u][4].trim() + "</PaymentDate>");
          sb.append("<ReceivedDate>" + readData[u][5].trim() + "</ReceivedDate>");
          sb.append("<CollectedBY>" + readData[u][6].trim() + "</CollectedBY>");
          sb.append("<EntryBY>" + readData[u][7].trim() + "</EntryBY>");
          sb.append("<Transfer>" + readData[u][8].trim() + "</Transfer>");
          sb.append("<Advanceno>" + readData[u][9].trim() + "</Advanceno>");
          sb.append("<Type>" + readData[u][10].trim() + "</Type>");
          sb.append("<Transferamount>" + readData[u][11].trim() + "</Transferamount>");
          sb.append("<Balance>" + readData[u][12].trim() + "</Balance>");
          sb.append("<Groupid>" + readData[u][13].trim() + "</Groupid>");
          sb.append("</Advance>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Advancesss>" + sb.toString() + "</Advancesss>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String search = request.getParameter("search");
      String customergroupid = request.getParameter("customergroupid");
      String stype = request.getParameter("type");
      String sql = "";
      sql = " SELECT a.INT_CUSTOMERGROUPID ,b.CHR_NAME  ,  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,  ";
      sql = String.valueOf(sql) + " a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3, f.CHR_CITYNAME, e.CHR_DISTRICT,d.CHR_STATENAME, ";
      sql = String.valueOf(sql) + " c.CHR_COUNTRYNAME, a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE ";
      sql = String.valueOf(sql) + " FROM inv_m_customerinfo a,inv_m_customergroup b, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERGROUPID = b.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.INT_COUNTRYID= c.INT_COUNTRYID  ";
      sql = String.valueOf(sql) + " AND a.INT_STATEID = d.INT_STATEID  ";
      sql = String.valueOf(sql) + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
      sql = String.valueOf(sql) + " AND a.INT_CITYID = f.INT_CITYID ";
      if (!"0".equals(customergroupid))
        sql = String.valueOf(sql) + " AND b.INT_CUSTOMERGROUPID = " + customergroupid; 
      if ("2".equals(stype)) {
        sql = String.valueOf(sql) + " AND( (b.CHR_NAME LIKE '%" + search.trim() + "%' ) OR (a.CHR_MOBILE LIKE '%" + search.trim() + "%' )  )";
      } else if ("1".equals(stype)) {
        if (!"0".equals(search))
          sql = String.valueOf(sql) + " AND a.CHR_STAFFNAME LIKE '" + search.trim() + "%'  "; 
      } 
      sql = String.valueOf(sql) + " ORDER BY b.CHR_NAME limit 1000 ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Group>" + readData[u][1].replace("&", " AND ").trim() + "</Group>");
          sb.append("<City>" + readData[u][6].trim() + "</City>");
          sb.append("<District>" + readData[u][7].trim() + "</District>");
          sb.append("<State>" + readData[u][8].trim() + "</State>");
          sb.append("<Country>" + readData[u][9].trim() + "</Country>");
          sb.append("<Pincode>" + readData[u][10].trim() + "</Pincode>");
          sb.append("<Areacode>" + readData[u][11].trim() + "</Areacode>");
          sb.append("<Phone>" + readData[u][12].trim() + "</Phone>");
          sb.append("<Mobile>" + readData[u][13].trim() + "</Mobile>");
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
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadDirectDC(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String dcstatus = request.getParameter("dcstatus");
      String sql = "";
      sql = " SELECT  a.CHR_DCNO,date_format(a.DAT_DCDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),a.CHR_REF ,   ";
      sql = String.valueOf(sql) + 
        " a.CHR_DES,a.INT_DCSTATUS,e.CHR_STAFFNAME,SUM(c.DOU_UNITPRICE)  ";
      sql = String.valueOf(sql) + 
        " FROM inv_t_directdc a,inv_t_directdcitem b,inv_t_vendorgoodsreceived c,inv_m_customerinfo d,com_m_staff e  ";
      sql = String.valueOf(sql) + 
        " WHERE a.CHR_DCNO = b.CHR_DCNO AND   c.CHR_SERIALNO is not null AND   c.CHR_SERIALNO !=''  ";
      sql = String.valueOf(sql) + " AND b.CHR_SERIALNO= c.CHR_SERIALNO  ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=d.INT_CUSTOMERID  ";
      sql = String.valueOf(sql) + " AND a.CHR_REF  = e.CHR_EMPID  ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_DCDATE)=" + month + " "; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_DCDATE)=" + year + " ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"2".equals(dcstatus))
        sql = String.valueOf(sql) + " AND a.INT_DCSTATUS=" + dcstatus; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + 
          " AND FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID) LIKE '" + 
          StartLetter + "%'"; 
      sql = String.valueOf(sql) + " GROUP BY a.CHR_DCNO  ";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Service>");
          sb.append("<Invoiceno>" + readData[u][0] + "</Invoiceno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Customer>" + readData[u][2] + "</Customer>");
          sb.append("<Status>" + readData[u][5] + "</Status>");
          sb.append("<Ref>" + readData[u][6] + "</Ref>");
          sb.append("<Dcamount>" + readData[u][7] + "</Dcamount>");
          sb.append("</Service>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Services>" + sb.toString() + "</Services>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadPurchaseData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String division = request.getParameter("division");
      String vendorid = request.getParameter("vendor");
      String StartLetter = request.getParameter("id");
      String type = request.getParameter("type");
      String status = request.getParameter("status");
      Object object = session.getAttribute("USRTYPE");
      String cancel = request.getParameter("cancel");
      String sql = "SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " a.INT_ONHOLD,a.INT_PURCHASESTATUS,a.CHR_PAYMENTSTATUS,";
      sql = String.valueOf(sql) + " c.CHR_BRANCHNAME,a.CHR_POREQUESTNO ,FUN_INV_DIVISION(a.INT_DIVIID), ";
      sql = String.valueOf(sql) + " a.CHR_EDD_STATUS,DATE_FORMAT(a.DAT_EDD ,'%d-%b-%Y'), a.CHR_VERIFIED, ";
      sql = String.valueOf(sql) + " a.CHR_CANCEL , ";
      sql = String.valueOf(sql) + " (NOW() > DATE_ADD(a.DAT_ORDERDATE, INTERVAL (SELECT INT_INVOCECHANGES FROM m_inventorysetting WHERE INT_ROWID= 1) DAY )) ";
      sql = String.valueOf(sql) + " FROM  inv_t_vendorpurchaseorder  a, inv_m_vendorsinformation b, com_m_branch c ";
      sql = String.valueOf(sql) + " WHERE a.INT_VENDORID =b.INT_VENDORID AND a.INT_BRANCHID = c.INT_BRANCHID ";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_ORDERDATE) =" + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_ORDERDATE) =" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_ORDERDATE) = " + year; 
      if (!"0".equals(vendorid))
        sql = String.valueOf(sql) + " AND a.INT_VENDORID = " + vendorid; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_VERIFIED = '" + status + "' "; 
      if (!"0".equals(cancel))
        sql = String.valueOf(sql) + " AND a.CHR_CANCEL = '" + cancel + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(StartLetter))
          sql = String.valueOf(sql) + " AND b.CHR_VENDORNAME LIKE '" + StartLetter + "%'   "; 
      } else {
        sql = String.valueOf(sql) + " AND ( (a.CHR_PURCHASEORDERNO LIKE '%" + StartLetter + "%') OR ( b.CHR_VENDORNAME LIKE '" + StartLetter.toUpperCase() + "%') )";
      } 
      sql = String.valueOf(sql) + " ORDER BY INT_PURCHASEORDERID   ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<purchase>");
          sb.append("<Refid>" + readData[u][0].trim() + "</Refid>");
          sb.append("<Vendor>" + readData[u][1].replaceAll("&", " AND ") + "</Vendor>");
          sb.append("<OrderDate>" + readData[u][2] + "</OrderDate>");
          sb.append("<onHold>" + readData[u][3].trim() + "</onHold>");
          sb.append("<Status>" + readData[u][4].trim() + "</Status>");
          sb.append("<Payment>" + readData[u][5].trim() + "</Payment>");
          sb.append("<Branch>" + readData[u][6].trim() + "</Branch>");
          sb.append("<PR>" + readData[u][7].trim() + "</PR>");
          sb.append("<Division>" + readData[u][8] + "</Division>");
          sb.append("<EDDStatus>" + readData[u][9] + "</EDDStatus>");
          sb.append("<EDD>" + readData[u][10] + "</EDD>");
          sb.append("<Verified>" + readData[u][11] + "</Verified>");
          sb.append("<Cancel>" + readData[u][12] + "</Cancel>");
          sb.append("<Dtcheck>" + readData[u][13] + "</Dtcheck>");
          sb.append("<Received>0</Received>");
          sb.append("<Usertype>" + object + "</Usertype>");
          sb.append("</purchase>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<purchases>" + sb.toString() + "</purchases>");
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
  
  public static void loadReceiveData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String startLetter = request.getParameter("startLetter");
      String day = request.getParameter("day");
      String division = request.getParameter("division");
      String vendorid = request.getParameter("vendor");
      String sql = "";
      sql = String.valueOf(sql) + " SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, ";
      sql = String.valueOf(sql) + "  DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + "  FUN_GET_BRANCH_NAME(a.INT_ADDRESSID1),FUN_GET_BRANCH_NAME(a.INT_ADDRESSID2), ";
      sql = String.valueOf(sql) + "  a.INT_ONHOLD,a.INT_PURCHASESTATUS,a.CHR_PAYMENTSTATUS,a.CHR_RECIVEDID,a.DAT_RECIVEDDATE,FUN_INV_DIVISION(a.INT_DIVIID)  ";
      sql = String.valueOf(sql) + "  FROM  inv_t_vendorpurchaseorder a  , inv_m_vendorsinformation b ";
      sql = String.valueOf(sql) + "  WHERE a.INT_VENDORID =b.INT_VENDORID  AND a.CHR_VERIFIED = 'Y'";
      sql = String.valueOf(sql) + "  AND a.CHR_CANCEL ='N' ";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_ORDERDATE) =" + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_ORDERDATE) =" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_ORDERDATE) = " + year; 
      if (!"0".equals(vendorid))
        sql = String.valueOf(sql) + " AND a.INT_VENDORID = " + vendorid; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND b.CHR_VENDORNAME LIKE '" + startLetter + "%' "; 
      sql = String.valueOf(sql) + "  ORDER BY b.CHR_VENDORNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Receive>");
          sb.append("<Refid>" + readData[u][0] + "</Refid>");
          sb.append("<Receiveid>" + readData[u][8] + "</Receiveid>");
          sb.append("<OrderDate>" + readData[u][2] + "</OrderDate>");
          sb.append("<Vendor>" + readData[u][1] + "</Vendor>");
          sb.append("<OrderFrom>" + readData[u][3] + "</OrderFrom>");
          sb.append("<ShippingTo>" + readData[u][4] + "</ShippingTo>");
          sb.append("<onHold>" + readData[u][5] + "</onHold>");
          sb.append("<Status>" + readData[u][6] + "</Status>");
          sb.append("<Payment>" + readData[u][7] + "</Payment>");
          sb.append("<ReceiveDate>" + readData[u][8] + "</ReceiveDate>");
          sb.append("<Division>" + readData[u][9] + "</Division>");
          sb.append("</Receive>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Receives>" + sb.toString() + "</Receives>");
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
  
  public static void loadReturnData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String purchasetype = request.getParameter("purchasetype");
      String month = request.getParameter("month");
      String StartLetter = request.getParameter("id");
      String year = request.getParameter("year");
      String sql = "";
      if ("V".equals(purchasetype)) {
        sql = " SELECT a.CHR_GRTNO ,a.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME, ";
        sql = String.valueOf(sql) + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
        sql = String.valueOf(sql) + " IF( a.CHR_TYPE ='I' ,  ";
        sql = String.valueOf(sql) + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
        sql = String.valueOf(sql) + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) ";
        sql = String.valueOf(sql) + " ) productcode,   ";
        sql = String.valueOf(sql) + " a.CHR_SERIALNO, ";
        sql = String.valueOf(sql) + " a.CHR_FLAG ";
        sql = String.valueOf(sql) + " FROM  inv_t_vendorgoodsreturn a  , inv_t_vendorpurchaseorder b , inv_m_vendorsinformation c ";
        sql = String.valueOf(sql) + " WHERE a.CHR_PURCHASEORDERNO=b.CHR_PURCHASEORDERNO ";
        sql = String.valueOf(sql) + " AND b.INT_VENDORID = c.INT_VENDORID  ";
        if (!"0".equals(month))
          sql = String.valueOf(sql) + " AND MONTH(a.DAT_RETURNDATE ) = " + month; 
        if (!"0".equals(year))
          sql = String.valueOf(sql) + " AND YEAR(a.DAT_RETURNDATE ) = " + year; 
        if (!"0".equals(StartLetter))
          sql = String.valueOf(sql) + " AND c.CHR_VENDORNAME  LIKE '" + StartLetter + "%' "; 
      } else {
        sql = " SELECT a.CHR_GRTNO ,a.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME, ";
        sql = String.valueOf(sql) + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
        sql = String.valueOf(sql) + " IF( a.CHR_TYPE ='I' ,  ";
        sql = String.valueOf(sql) + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
        sql = String.valueOf(sql) + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) ";
        sql = String.valueOf(sql) + " ) productcode,   ";
        sql = String.valueOf(sql) + " a.CHR_SERIALNO, ";
        sql = String.valueOf(sql) + " a.CHR_FLAG ";
        sql = String.valueOf(sql) + " FROM  inv_t_vendorgoodsreturn a  , inv_t_directpurchase b , inv_m_vendorsinformation c ";
        sql = String.valueOf(sql) + " WHERE a.CHR_PURCHASEORDERNO=b.CHR_PURCHASEORDERNO ";
        sql = String.valueOf(sql) + " AND b.INT_VENDORID = c.INT_VENDORID  ";
        if (!"0".equals(month))
          sql = String.valueOf(sql) + " AND MONTH(a.DAT_RETURNDATE ) = " + month; 
        if (!"0".equals(year))
          sql = String.valueOf(sql) + " AND YEAR(a.DAT_RETURNDATE ) = " + year; 
        if (!"0".equals(StartLetter))
          sql = String.valueOf(sql) + " AND c.CHR_VENDORNAME  LIKE '" + StartLetter + "%' "; 
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Return>");
          sb.append("<Grtno>" + readData[u][0] + "</Grtno>");
          sb.append("<purchaseid>" + readData[u][1] + "</purchaseid>");
          sb.append("<vendorname>" + readData[u][2] + "</vendorname>");
          sb.append("<itype>" + readData[u][3] + "</itype>");
          sb.append("<Itemid>" + readData[u][4] + "</Itemid>");
          sb.append("<Serial>" + readData[u][5] + "</Serial>");
          sb.append("<Flag>" + readData[u][6] + "</Flag>");
          sb.append("</Return>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Returns>" + sb.toString() + "</Returns>");
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
  
  public static void loadPaymentData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String payment = request.getParameter("payment");
      String Status = request.getParameter("Status");
      String divis = request.getParameter("divis");
      String vendorid = request.getParameter("vendorid");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String searchid = request.getParameter("id");
      String type = request.getParameter("type");
      String Branch = request.getParameter("Branch");
      String sql = "";
      if ("Purchase".equals(payment)) {
        sql = " SELECT a.CHR_PURCHASEORDERNO  ,  b.CHR_VENDORNAME,a.DOU_TOTALAMOUNT ,  a.DOU_PAIDAMOUNT,(a.DOU_TOTALAMOUNT-a.DOU_PAIDAMOUNT), a.CHR_PAYMENTSTATUS, CONCAT('-')    FROM  inv_t_vendorpurchaseorder  a ,inv_m_vendorsinformation b";
        sql = String.valueOf(sql) + " WHERE  a.INT_VENDORID = b.INT_VENDORID AND a.CHR_PURCHASEORDERNO <> 'null' ";
        if (!"0".equals(divis))
          sql = String.valueOf(sql) + "  AND  a.INT_DIVIID=" + divis + "  "; 
        if (!"0".equals(vendorid))
          sql = String.valueOf(sql) + "  AND  a.INT_VENDORID=" + vendorid + "  "; 
        if ("1".equals(Status)) {
          sql = String.valueOf(sql) + "   AND  a.CHR_PAYMENTSTATUS='N'   ";
        } else if ("2".equals(Status)) {
          sql = String.valueOf(sql) + "   AND  a.CHR_PAYMENTSTATUS='Y'   ";
        } 
        if (!"0".equals(month))
          sql = String.valueOf(sql) + "   AND  MONTH(a.DAT_ORDERDATE) = " + month; 
        if (!"0".equals(year))
          sql = String.valueOf(sql) + "   AND  YEAR(a.DAT_ORDERDATE) = " + year; 
        if (!"0".equals(Branch))
          sql = String.valueOf(sql) + " AND  a.INT_BRANCHID =" + Branch + " "; 
        if ("1".equals(type)) {
          if (!"0".equals(searchid))
            sql = String.valueOf(sql) + " AND b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%'"; 
        } else {
          sql = String.valueOf(sql) + " AND ( (a.CHR_PURCHASEORDERNO LIKE '%" + searchid + "%') OR ( b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%') )";
        } 
        sql = String.valueOf(sql) + " ORDER BY b.CHR_VENDORNAME ";
      } else if ("Direct".equals(payment)) {
        sql = " SELECT a.CHR_PURCHASEORDERNO  ,b.CHR_VENDORNAME ,a.DOU_TOTALAMOUNT ,   FUN_INV_GET_VENDORPAYMENT(a.CHR_PURCHASEORDERNO), ";
        sql = String.valueOf(sql) + "  (a.DOU_TOTALAMOUNT-FUN_INV_GET_VENDORPAYMENT(a.CHR_PURCHASEORDERNO)),a.CHR_PAYMENTSTATUS, a.CHR_VENDORPO ";
        sql = String.valueOf(sql) + "  FROM inv_t_directpurchase  a, inv_m_vendorsinformation  b   ";
        sql = String.valueOf(sql) + " WHERE a.INT_VENDORID=b.INT_VENDORID ";
        if (!"0".equals(divis))
          sql = String.valueOf(sql) + "  AND  a.INT_DIVIID=" + divis + "  "; 
        if (!"0".equals(vendorid))
          sql = String.valueOf(sql) + "  AND  a.INT_VENDORID=" + vendorid + "  "; 
        if ("1".equals(Status)) {
          sql = String.valueOf(sql) + "   AND  a.CHR_PAYMENTSTATUS !='Y'   ";
        } else if ("2".equals(Status)) {
          sql = String.valueOf(sql) + "   AND  a.CHR_PAYMENTSTATUS='Y'   ";
        } 
        if (!"0".equals(month))
          sql = String.valueOf(sql) + "   AND  MONTH(a.DAT_ORDERDATE) = " + month; 
        if (!"0".equals(year))
          sql = String.valueOf(sql) + "   AND  YEAR(a.DAT_ORDERDATE) = " + year; 
        if (!"0".equals(Branch))
          sql = String.valueOf(sql) + " AND  a.INT_BRANCHID =" + Branch + " "; 
        if ("1".equals(type)) {
          if (!"0".equals(searchid))
            sql = String.valueOf(sql) + " AND b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%'"; 
        } else {
          sql = String.valueOf(sql) + " AND ( (a.CHR_PURCHASEORDERNO LIKE '%" + searchid + "%') OR ( b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%') )";
        } 
        sql = String.valueOf(sql) + "  ORDER BY b.CHR_VENDORNAME, a.CHR_PURCHASEORDERNO ";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if ("3".equals(Status)) {
            if (Double.parseDouble(readData[u][4]) < 0.0D) {
              sb.append("<Payment>");
              sb.append("<Purchaseid>" + readData[u][0].replace("&", " AND ") + "</Purchaseid>");
              sb.append("<Vendorname>" + readData[u][1].replace("&", " AND ") + "</Vendorname>");
              sb.append("<Totalamount>" + readData[u][2] + "</Totalamount>");
              sb.append("<Paidamount>" + readData[u][3] + "</Paidamount>");
              sb.append("<Blanace>" + readData[u][4] + "</Blanace>");
              sb.append("<Status>" + readData[u][5] + "</Status>");
              sb.append("<VPO>" + readData[u][6] + "</VPO>");
              sb.append("</Payment>");
            } 
          } else {
            sb.append("<Payment>");
            sb.append("<Purchaseid>" + readData[u][0].replace("&", " AND ") + "</Purchaseid>");
            sb.append("<Vendorname>" + readData[u][1].replace("&", " AND ") + "</Vendorname>");
            sb.append("<Totalamount>" + readData[u][2] + "</Totalamount>");
            sb.append("<Paidamount>" + readData[u][3] + "</Paidamount>");
            sb.append("<Blanace>" + readData[u][4] + "</Blanace>");
            sb.append("<Status>" + readData[u][5] + "</Status>");
            sb.append("<VPO>" + readData[u][6] + "</VPO>");
            sb.append("</Payment>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Payments>" + sb.toString() + "</Payments>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadSearchVendorPO(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String payment = request.getParameter("payment");
      String search = request.getParameter("search");
      String sql = "";
      if ("Purchase".equals(payment)) {
        sql = "SELECT CHR_PURCHASEORDERNO,CHR_VENDORPO FROM   inv_t_vendorpurchaseorder  WHERE CHR_PAYMENTSTATUS <>'Y'";
      } else if ("Direct".equals(payment)) {
        sql = "SELECT CHR_PURCHASEORDERNO,CHR_VENDORPO FROM  inv_t_directpurchase WHERE CHR_PAYMENTSTATUS <> 'Y' ";
      } 
      if (!"".equals(search) && !"null".equals(search))
        sql = String.valueOf(sql) + " AND (  (CHR_PURCHASEORDERNO LIKE '" + search + "%')  OR (CHR_VENDORPO LIKE '%" + search + "%')     ) "; 
      sql = String.valueOf(sql) + "  ORDER BY CHR_PURCHASEORDERNO ";
      System.out.println("loadSearchVendorPO=====> " + sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1] + "</Name>");
          sb.append("</Row>");
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
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadReceivedId(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String rid = request.getParameter("rid");
      String purchasetype = request.getParameter("purchasetype");
      String sql = "";
      if ("V".equals(purchasetype)) {
        sql = "  SELECT a.INT_ID, ";
        sql = String.valueOf(sql) + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
        sql = String.valueOf(sql) + "  IF( a.CHR_TYPE ='I' ,  ";
        sql = String.valueOf(sql) + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
        sql = String.valueOf(sql) + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
        sql = String.valueOf(sql) + " ) productcode,   ";
        sql = String.valueOf(sql) + "  a.CHR_SERIALNO ,a.CHR_WARRANTY, a.CHR_GRTFLAG, ";
        sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y')   ";
        sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceived  a ";
        sql = String.valueOf(sql) + " WHERE a.CHR_FLAG='N' AND a.CHR_RECEIVEDMODE ='P' AND a.CHR_RECIVEDID is not null ";
        sql = String.valueOf(sql) + " AND a.CHR_PURCHASEORDERNO = '" + rid + "'";
        sql = String.valueOf(sql) + " ORDER BY a.INT_ID ";
      } else {
        sql = "  SELECT a.INT_ID, ";
        sql = String.valueOf(sql) + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
        sql = String.valueOf(sql) + "  IF( a.CHR_TYPE ='I' ,  ";
        sql = String.valueOf(sql) + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
        sql = String.valueOf(sql) + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
        sql = String.valueOf(sql) + " ) productcode,   ";
        sql = String.valueOf(sql) + "  a.CHR_SERIALNO ,a.CHR_WARRANTY, a.CHR_GRTFLAG, ";
        sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y')   ";
        sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceived  a ";
        sql = String.valueOf(sql) + " WHERE a.CHR_FLAG='N' AND a.CHR_RECEIVEDMODE ='D' AND a.CHR_RECIVEDID is not null ";
        sql = String.valueOf(sql) + " AND a.CHR_RECIVEDID = '" + rid + "'";
        sql = String.valueOf(sql) + " ORDER BY a.INT_ID ";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Rid>");
          sb.append("<Refid>" + readData[u][0] + "</Refid>");
          sb.append("<Itemtype>" + readData[u][1] + "</Itemtype>");
          sb.append("<Itemname>" + readData[u][2] + "</Itemname>");
          sb.append("<Srial>" + readData[u][3] + "</Srial>");
          sb.append("<Warranty>" + readData[u][4] + "</Warranty>");
          sb.append("<Flag>" + readData[u][5] + "</Flag>");
          sb.append("<Reddate>" + readData[u][6] + "</Reddate>");
          sb.append("</Rid>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<RcdIds>" + sb.toString() + "</RcdIds>");
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
  
  public static void loadSalesPaymentBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String rid = request.getParameter("salesid");
      Object object = session.getAttribute("BRANCHID");
      System.out.println("loadSalesPaymentBalance  branchId=================>" + object);
      String sql = "SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_customersalespayment   WHERE CHR_SALESORDERNO='" + 
        rid + "' ";
      System.out.println("loadSalesPaymentBalance=================>" + sql);
      String[][] amounts = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      double amt = 0.0D;
      if (amounts.length > 0) {
        sql = "SELECT  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) FROM inv_t_directsales a ,inv_m_customerinfo b WHERE a.CHR_SALESNO='" + 
          rid + "'\tAND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
        String[][] cdata = 
          CommonFunctions.QueryExecute(sql);
        sb.append("<Amount>");
        if (!"-".equals(amounts[0][0]))
          amt = Double.parseDouble(amounts[0][0]); 
        sb.append("<Balance>" + amt + "</Balance>");
        sb.append("<Customer>" + cdata[0][0].replaceAll("&", " AND ") + "</Customer>");
        sb.append("</Amount>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Amounts>" + sb.toString() + "</Amounts>");
      } else {
        response.setStatus(204);
      } 
      System.out.println("loadSalesPaymentBalance=================>" + sb);
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadDirectBillingValue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String invno = request.getParameter("invno");
      String Branch = request.getParameter("Branch");
      String sql = "";
      sql = " SELECT  a.CHR_SALESNO,a.DOU_NETAMOUNT,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,";
      sql = String.valueOf(sql) + 
        " (SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_directbillingpayment   WHERE CHR_SALESNO='" + 
        invno + "' AND INT_BRANCHID =" + Branch + ")";
      sql = String.valueOf(sql) + 
        " ,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_directbilling a ,inv_m_customerinfo b ";
      sql = String.valueOf(sql) + " where a.INT_CUSTOMERID = b.INT_CUSTOMERID";
      sql = String.valueOf(sql) + " AND a.CHR_SALESNO='" + invno + "'";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch;
      String[][] amounts = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      double amt = 0.0D;
      double paid = 0.0D;
      if (amounts.length > 0) {
        sb.append("<Amount>");
        if (!"-".equals(amounts[0][1]))
          amt = Double.parseDouble(amounts[0][1]); 
        if (!"-".equals(amounts[0][3]))
          paid = Double.parseDouble(amounts[0][3]); 
        sb.append("<Invoiceamount>" + amounts[0][1] + 
            "</Invoiceamount>");
        sb.append("<Paid>" + paid + "</Paid>");
        sb.append("<Balance>" + (amt - paid) + "</Balance>");
        sb.append("<Customer>" + amounts[0][2] + "</Customer>");
        sb.append("<Invoicedate>" + amounts[0][4] + "</Invoicedate>");
        sb.append("</Amount>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Amounts>" + sb.toString() + "</Amounts>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadServiceBillingValue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String invno = request.getParameter("invno");
      String Branch = request.getParameter("Branch");
      String sql = "";
      sql = " SELECT  a.CHR_SALESNO,a.DOU_NETAMOUNT,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,";
      sql = String.valueOf(sql) + 
        " (SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_servicebillingpayment   WHERE CHR_SALESNO='" + 
        invno + "' AND INT_BRANCHID =" + Branch + ")";
      sql = String.valueOf(sql) + 
        " ,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_servicebilling a ,inv_m_customerinfo b ";
      sql = String.valueOf(sql) + " where a.INT_CUSTOMERID = b.INT_CUSTOMERID";
      sql = String.valueOf(sql) + " AND a.CHR_SALESNO='" + invno + "'";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch;
      String[][] amounts = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      double amt = 0.0D;
      double paid = 0.0D;
      if (amounts.length > 0) {
        sb.append("<Amount>");
        if (!"-".equals(amounts[0][1]))
          amt = Double.parseDouble(amounts[0][1]); 
        if (!"-".equals(amounts[0][3]))
          paid = Double.parseDouble(amounts[0][3]); 
        sb.append("<Invoiceamount>" + amounts[0][1] + 
            "</Invoiceamount>");
        sb.append("<Paid>" + paid + "</Paid>");
        sb.append("<Balance>" + (amt - paid) + "</Balance>");
        sb.append("<Customer>" + amounts[0][2].replace("&", "") + 
            "</Customer>");
        sb.append("<Invoicedate>" + amounts[0][4] + "</Invoicedate>");
        sb.append("</Amount>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Amounts>" + sb.toString() + "</Amounts>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadTaxcalculations(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("id");
      String sql = "";
      sql = " SELECT  DOU_VALUE FROM inv_m_tax WHERE INT_TAXID=" + id;
      String[][] datas = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        sb.append("<Tax>");
        sb.append("<Taxvalue>" + datas[0][0] + "</Taxvalue>");
        sb.append("</Tax>");
        System.out.println(sb.toString());
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Taxs>" + sb.toString() + "</Taxs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadServiceBillingPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String division = request.getParameter("division");
      String Payment = request.getParameter("Payment");
      String customer = request.getParameter("customer");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "";
      sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF , a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ";
      sql = String.valueOf(sql) + 
        " FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c";
      sql = String.valueOf(sql) + 
        " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " "; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_SALESDATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE) = " + month; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_SALESDATE) = " + year;
      if ("1".equals(Payment)) {
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='N'";
      } else if ("2".equals(Payment)) {
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='Y'";
      } else if ("3".equals(Payment)) {
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='P'";
      } 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER  BY a.INT_ID ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Direct>");
          sb.append("<Invoiceno>" + readData[u][0] + "</Invoiceno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Customer>" + readData[u][2].replace("&", "") + "</Customer>");
          sb.append("<Ref>" + readData[u][6] + "</Ref>");
          sb.append("<Amount>" + readData[u][4] + "</Amount>");
          sb.append("<Status>" + readData[u][5] + "</Status>");
          sb.append("</Direct>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Directs>" + sb.toString() + "</Directs>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request
        .getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadDirectBillingPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String division = request.getParameter("division");
      String Payment = request.getParameter("Payment");
      String customer = request.getParameter("customer");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String sql = "";
      sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF , a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ";
      sql = String.valueOf(sql) + " FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " "; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_SALESDATE) =  " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE)   = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(a.DAT_SALESDATE) = " + year; 
      if ("1".equals(Payment)) {
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='N'";
      } else if ("2".equals(Payment)) {
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='Y'";
      } else if ("3".equals(Payment)) {
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='P'";
      } 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER  BY FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Direct>");
          sb.append("<Invoiceno>" + readData[u][0] + "</Invoiceno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Customer>" + readData[u][2] + "</Customer>");
          sb.append("<Ref>" + readData[u][6] + "</Ref>");
          sb.append("<Amount>" + readData[u][4] + "</Amount>");
          sb.append("<Status>" + readData[u][5] + "</Status>");
          sb.append("</Direct>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Directs>" + sb.toString() + "</Directs>");
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
  
  public static void loadCustomerQuotation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String startletter = request.getParameter("startletter");
      String status = request.getParameter("status");
      String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_QUOTATIONDATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  a.CHR_ONHOLD ,a.DOU_TOTALAMOUNT,a.CHR_STATUS, ";
      sql = String.valueOf(sql) + " FUN_INV_DIVISION(a.INT_DIVIID ),a.CHR_CANCEL,a.INT_PROGRESSBAR,datediff(NOW(),a.DAT_CREATIONTIME ),a.CHR_MODE";
      sql = String.valueOf(sql) + " FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_QUOTATIONDATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_QUOTATIONDATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_QUOTATIONDATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS = '" + status + "' AND a.CHR_CANCEL='N' "; 
      if (!"0".equals(startletter))
        sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + startletter + "%' "; 
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + object + " ORDER BY  a.DAT_QUOTATIONDATE";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<quotationNo>" + readData[u][1] + "</quotationNo>");
          sb.append("<customerName>" + readData[u][2].replaceAll("&", " AND ") + "</customerName>");
          sb.append("<QuotDate>" + readData[u][3] + "</QuotDate>");
          sb.append("<reqDate>" + readData[u][4] + "</reqDate>");
          sb.append("<onHold>" + readData[u][5] + "</onHold>");
          sb.append("<totalAmount>" + readData[u][6] + "</totalAmount>");
          sb.append("<quotationStatus>" + readData[u][7] + "</quotationStatus>");
          sb.append("<Division>" + readData[u][8] + "</Division>");
          sb.append("<Cancel>" + readData[u][9] + "</Cancel>");
          sb.append("<Bar>" + readData[u][10] + "</Bar>");
          sb.append("<Age>" + readData[u][11] + "</Age>");
          sb.append("<Mode>" + readData[u][12] + "</Mode>");
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
  
  public static void loadProforma(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String startletter = request.getParameter("startletter");
      String status = request.getParameter("status");
      String sql = " SELECT a.INT_PROFORMAID,a.CHR_PROFORMANO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_PROFORMADATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  a.CHR_ONHOLD ,a.DOU_TOTALAMOUNT,a.CHR_STATUS, ";
      sql = String.valueOf(sql) + " FUN_INV_DIVISION(a.INT_DIVIID ),a.CHR_CANCEL,a.INT_PROGRESSBAR,datediff(NOW(),a.DAT_CREATIONTIME )";
      sql = String.valueOf(sql) + " FROM  inv_t_proforma  a ,inv_m_customerinfo b";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_PROFORMADATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_PROFORMADATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_PROFORMADATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS = '" + status + "' AND a.CHR_CANCEL='N' "; 
      if (!"0".equals(startletter))
        sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + startletter + "%' "; 
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + object + " ORDER BY  a.DAT_PROFORMADATE";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<quotationNo>" + readData[u][1] + "</quotationNo>");
          sb.append("<customerName>" + readData[u][2].replaceAll("&", " AND ") + "</customerName>");
          sb.append("<QuotDate>" + readData[u][3] + "</QuotDate>");
          sb.append("<reqDate>" + readData[u][4] + "</reqDate>");
          sb.append("<onHold>" + readData[u][5] + "</onHold>");
          sb.append("<totalAmount>" + readData[u][6] + "</totalAmount>");
          sb.append("<quotationStatus>" + readData[u][7] + "</quotationStatus>");
          sb.append("<Division>" + readData[u][8] + "</Division>");
          sb.append("<Cancel>" + readData[u][9] + "</Cancel>");
          sb.append("<Bar>" + readData[u][10] + "</Bar>");
          sb.append("<Age>" + readData[u][11] + "</Age>");
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
  
  public static void loadPOVerification(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: invokeinterface getSession : ()Ljavax/servlet/http/HttpSession;
    //   6: astore_2
    //   7: new java/lang/StringBuilder
    //   10: dup
    //   11: invokespecial <init> : ()V
    //   14: aload_2
    //   15: ldc_w 'INVBRANCH'
    //   18: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   23: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   26: invokevirtual toString : ()Ljava/lang/String;
    //   29: astore_3
    //   30: new java/lang/StringBuilder
    //   33: dup
    //   34: invokespecial <init> : ()V
    //   37: aload_2
    //   38: ldc_w 'USRTYPE'
    //   41: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   46: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   49: invokevirtual toString : ()Ljava/lang/String;
    //   52: astore #4
    //   54: aload_0
    //   55: ldc_w 'division'
    //   58: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   63: astore #5
    //   65: aload_0
    //   66: ldc_w 'customer'
    //   69: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   74: astore #6
    //   76: aload_0
    //   77: ldc_w 'day'
    //   80: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   85: astore #7
    //   87: aload_0
    //   88: ldc_w 'month'
    //   91: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   96: astore #8
    //   98: aload_0
    //   99: ldc_w 'year'
    //   102: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   107: astore #9
    //   109: aload_0
    //   110: ldc_w 'startletter'
    //   113: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   118: astore #10
    //   120: aload_0
    //   121: ldc_w 'status'
    //   124: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   129: astore #11
    //   131: aload_0
    //   132: ldc_w 'cancel'
    //   135: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   140: astore #12
    //   142: ldc_w '-'
    //   145: astore #13
    //   147: ldc_w 'F'
    //   150: aload #4
    //   152: invokevirtual equals : (Ljava/lang/Object;)Z
    //   155: ifne -> 192
    //   158: ldc_w 'SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1'
    //   161: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   164: iconst_0
    //   165: aaload
    //   166: iconst_0
    //   167: aaload
    //   168: ldc_w ','
    //   171: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   174: aload_2
    //   175: ldc_w 'USRID'
    //   178: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   183: invokevirtual toString : ()Ljava/lang/String;
    //   186: invokestatic contains : ([Ljava/lang/Object;Ljava/lang/Object;)Z
    //   189: ifeq -> 197
    //   192: ldc_w 'F'
    //   195: astore #13
    //   197: ldc_w '  SELECT a.INT_ROWID,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_SALESORDERNO,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), '
    //   200: astore #14
    //   202: new java/lang/StringBuilder
    //   205: dup
    //   206: aload #14
    //   208: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   211: invokespecial <init> : (Ljava/lang/String;)V
    //   214: ldc_w '  FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_VERIFICATIED,DATE_FORMAT(a.DAT_SALEDATE,'%d-%b-%Y'), '
    //   217: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   220: invokevirtual toString : ()Ljava/lang/String;
    //   223: astore #14
    //   225: new java/lang/StringBuilder
    //   228: dup
    //   229: aload #14
    //   231: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   234: invokespecial <init> : (Ljava/lang/String;)V
    //   237: ldc_w '  IF(a.CHR_PR_AVAILABLE='Y' ,a.CHR_POREQUESTNO,'No'), '
    //   240: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   243: invokevirtual toString : ()Ljava/lang/String;
    //   246: astore #14
    //   248: new java/lang/StringBuilder
    //   251: dup
    //   252: aload #14
    //   254: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   257: invokespecial <init> : (Ljava/lang/String;)V
    //   260: ldc_w '  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF( b.CHR_CLOSEDSTATUS = 'Y','Closed','Pending') FROM inv_t_purchaserequest b WHERE b.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),''), '
    //   263: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   266: invokevirtual toString : ()Ljava/lang/String;
    //   269: astore #14
    //   271: new java/lang/StringBuilder
    //   274: dup
    //   275: aload #14
    //   277: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   280: invokespecial <init> : (Ljava/lang/String;)V
    //   283: ldc_w '  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF(c.CHR_PR_PARTIALLY_RECEIVED='P','Partillay received',IF(c.CHR_PR_PARTIALLY_RECEIVED='Y','Fully Receive','Pending') ) FROM inv_t_purchaserequest c WHERE c.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),'') ,'
    //   286: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   289: invokevirtual toString : ()Ljava/lang/String;
    //   292: astore #14
    //   294: new java/lang/StringBuilder
    //   297: dup
    //   298: aload #14
    //   300: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   303: invokespecial <init> : (Ljava/lang/String;)V
    //   306: ldc_w '  a.DOU_TOTALAMOUNT , a.CHR_RFC , a.CHR_PR_MODIFICATION , a.CHR_CANCEL, a.CHR_BILLED ,a.INT_PROGRESSBAR '
    //   309: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   312: invokevirtual toString : ()Ljava/lang/String;
    //   315: astore #14
    //   317: new java/lang/StringBuilder
    //   320: dup
    //   321: aload #14
    //   323: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   326: invokespecial <init> : (Ljava/lang/String;)V
    //   329: ldc_w '  FROM  inv_t_customersalesorder a WHERE  a.INT_ROWID >0     '
    //   332: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   335: invokevirtual toString : ()Ljava/lang/String;
    //   338: astore #14
    //   340: ldc '0'
    //   342: aload #6
    //   344: invokevirtual equals : (Ljava/lang/Object;)Z
    //   347: ifne -> 378
    //   350: new java/lang/StringBuilder
    //   353: dup
    //   354: aload #14
    //   356: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   359: invokespecial <init> : (Ljava/lang/String;)V
    //   362: ldc_w ' AND  a.INT_CUSTOMERID = '
    //   365: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   368: aload #6
    //   370: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   373: invokevirtual toString : ()Ljava/lang/String;
    //   376: astore #14
    //   378: ldc '0'
    //   380: aload #5
    //   382: invokevirtual equals : (Ljava/lang/Object;)Z
    //   385: ifne -> 416
    //   388: new java/lang/StringBuilder
    //   391: dup
    //   392: aload #14
    //   394: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   397: invokespecial <init> : (Ljava/lang/String;)V
    //   400: ldc_w ' AND  a.INT_DIVIID = '
    //   403: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   406: aload #5
    //   408: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   411: invokevirtual toString : ()Ljava/lang/String;
    //   414: astore #14
    //   416: ldc '0'
    //   418: aload #7
    //   420: invokevirtual equals : (Ljava/lang/Object;)Z
    //   423: ifne -> 454
    //   426: new java/lang/StringBuilder
    //   429: dup
    //   430: aload #14
    //   432: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   435: invokespecial <init> : (Ljava/lang/String;)V
    //   438: ldc_w ' AND DAY(a.DAT_SALEDATE) = '
    //   441: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   444: aload #7
    //   446: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   449: invokevirtual toString : ()Ljava/lang/String;
    //   452: astore #14
    //   454: ldc '0'
    //   456: aload #8
    //   458: invokevirtual equals : (Ljava/lang/Object;)Z
    //   461: ifne -> 492
    //   464: new java/lang/StringBuilder
    //   467: dup
    //   468: aload #14
    //   470: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   473: invokespecial <init> : (Ljava/lang/String;)V
    //   476: ldc_w ' AND MONTH(a.DAT_SALEDATE) = '
    //   479: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   482: aload #8
    //   484: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   487: invokevirtual toString : ()Ljava/lang/String;
    //   490: astore #14
    //   492: ldc '0'
    //   494: aload #9
    //   496: invokevirtual equals : (Ljava/lang/Object;)Z
    //   499: ifne -> 530
    //   502: new java/lang/StringBuilder
    //   505: dup
    //   506: aload #14
    //   508: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   511: invokespecial <init> : (Ljava/lang/String;)V
    //   514: ldc_w ' AND YEAR(a.DAT_SALEDATE) = '
    //   517: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   520: aload #9
    //   522: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   525: invokevirtual toString : ()Ljava/lang/String;
    //   528: astore #14
    //   530: ldc '0'
    //   532: aload #11
    //   534: invokevirtual equals : (Ljava/lang/Object;)Z
    //   537: ifne -> 574
    //   540: new java/lang/StringBuilder
    //   543: dup
    //   544: aload #14
    //   546: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   549: invokespecial <init> : (Ljava/lang/String;)V
    //   552: ldc_w ' AND a.CHR_VERIFICATIED = ''
    //   555: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   558: aload #11
    //   560: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   563: ldc_w ''  '
    //   566: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   569: invokevirtual toString : ()Ljava/lang/String;
    //   572: astore #14
    //   574: ldc '0'
    //   576: aload #12
    //   578: invokevirtual equals : (Ljava/lang/Object;)Z
    //   581: ifne -> 618
    //   584: new java/lang/StringBuilder
    //   587: dup
    //   588: aload #14
    //   590: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   593: invokespecial <init> : (Ljava/lang/String;)V
    //   596: ldc_w ' AND a.CHR_CANCEL = ''
    //   599: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   602: aload #12
    //   604: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   607: ldc_w ''  '
    //   610: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   613: invokevirtual toString : ()Ljava/lang/String;
    //   616: astore #14
    //   618: ldc '0'
    //   620: aload #10
    //   622: invokevirtual equals : (Ljava/lang/Object;)Z
    //   625: ifne -> 661
    //   628: new java/lang/StringBuilder
    //   631: dup
    //   632: aload #14
    //   634: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   637: invokespecial <init> : (Ljava/lang/String;)V
    //   640: ldc_w ' AND  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE ''
    //   643: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   646: aload #10
    //   648: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   651: ldc '%' '
    //   653: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   656: invokevirtual toString : ()Ljava/lang/String;
    //   659: astore #14
    //   661: new java/lang/StringBuilder
    //   664: dup
    //   665: aload #14
    //   667: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   670: invokespecial <init> : (Ljava/lang/String;)V
    //   673: ldc_w ' AND a.INT_BRANCHID='
    //   676: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   679: aload_3
    //   680: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   683: ldc_w ' ORDER BY  a.DAT_SALEDATE'
    //   686: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   689: invokevirtual toString : ()Ljava/lang/String;
    //   692: astore #14
    //   694: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   697: aload #14
    //   699: invokevirtual println : (Ljava/lang/String;)V
    //   702: aload #14
    //   704: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   707: astore #15
    //   709: new java/lang/StringBuffer
    //   712: dup
    //   713: invokespecial <init> : ()V
    //   716: astore #16
    //   718: aload #15
    //   720: arraylength
    //   721: ifle -> 1457
    //   724: iconst_0
    //   725: istore #17
    //   727: goto -> 1394
    //   730: aload #16
    //   732: ldc '<Row>'
    //   734: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   737: pop
    //   738: aload #16
    //   740: new java/lang/StringBuilder
    //   743: dup
    //   744: ldc '<id>'
    //   746: invokespecial <init> : (Ljava/lang/String;)V
    //   749: aload #15
    //   751: iload #17
    //   753: aaload
    //   754: iconst_0
    //   755: aaload
    //   756: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   759: ldc '</id>'
    //   761: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   764: invokevirtual toString : ()Ljava/lang/String;
    //   767: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   770: pop
    //   771: aload #16
    //   773: new java/lang/StringBuilder
    //   776: dup
    //   777: ldc_w '<Branch>'
    //   780: invokespecial <init> : (Ljava/lang/String;)V
    //   783: aload #15
    //   785: iload #17
    //   787: aaload
    //   788: iconst_1
    //   789: aaload
    //   790: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   793: ldc_w '</Branch>'
    //   796: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   799: invokevirtual toString : ()Ljava/lang/String;
    //   802: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   805: pop
    //   806: aload #16
    //   808: new java/lang/StringBuilder
    //   811: dup
    //   812: ldc_w '<CPOref>'
    //   815: invokespecial <init> : (Ljava/lang/String;)V
    //   818: aload #15
    //   820: iload #17
    //   822: aaload
    //   823: iconst_2
    //   824: aaload
    //   825: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   828: ldc_w '</CPOref>'
    //   831: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   834: invokevirtual toString : ()Ljava/lang/String;
    //   837: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   840: pop
    //   841: aload #16
    //   843: new java/lang/StringBuilder
    //   846: dup
    //   847: ldc_w '<Quotation>'
    //   850: invokespecial <init> : (Ljava/lang/String;)V
    //   853: aload #15
    //   855: iload #17
    //   857: aaload
    //   858: iconst_3
    //   859: aaload
    //   860: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   863: ldc_w '</Quotation>'
    //   866: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   869: invokevirtual toString : ()Ljava/lang/String;
    //   872: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   875: pop
    //   876: aload #16
    //   878: new java/lang/StringBuilder
    //   881: dup
    //   882: ldc_w '<customerName>'
    //   885: invokespecial <init> : (Ljava/lang/String;)V
    //   888: aload #15
    //   890: iload #17
    //   892: aaload
    //   893: iconst_4
    //   894: aaload
    //   895: ldc '&'
    //   897: ldc_w ' AND '
    //   900: invokevirtual replaceAll : (Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    //   903: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   906: ldc_w '</customerName>'
    //   909: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   912: invokevirtual toString : ()Ljava/lang/String;
    //   915: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   918: pop
    //   919: aload #16
    //   921: new java/lang/StringBuilder
    //   924: dup
    //   925: ldc_w '<Division>'
    //   928: invokespecial <init> : (Ljava/lang/String;)V
    //   931: aload #15
    //   933: iload #17
    //   935: aaload
    //   936: iconst_5
    //   937: aaload
    //   938: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   941: ldc_w '</Division>'
    //   944: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   947: invokevirtual toString : ()Ljava/lang/String;
    //   950: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   953: pop
    //   954: aload #16
    //   956: new java/lang/StringBuilder
    //   959: dup
    //   960: ldc_w '<Verified>'
    //   963: invokespecial <init> : (Ljava/lang/String;)V
    //   966: aload #15
    //   968: iload #17
    //   970: aaload
    //   971: bipush #6
    //   973: aaload
    //   974: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   977: ldc_w '</Verified>'
    //   980: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   983: invokevirtual toString : ()Ljava/lang/String;
    //   986: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   989: pop
    //   990: aload #16
    //   992: new java/lang/StringBuilder
    //   995: dup
    //   996: ldc_w '<CPODate>'
    //   999: invokespecial <init> : (Ljava/lang/String;)V
    //   1002: aload #15
    //   1004: iload #17
    //   1006: aaload
    //   1007: bipush #7
    //   1009: aaload
    //   1010: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1013: ldc_w '</CPODate>'
    //   1016: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1019: invokevirtual toString : ()Ljava/lang/String;
    //   1022: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1025: pop
    //   1026: aload #16
    //   1028: new java/lang/StringBuilder
    //   1031: dup
    //   1032: ldc_w '<PR>'
    //   1035: invokespecial <init> : (Ljava/lang/String;)V
    //   1038: aload #15
    //   1040: iload #17
    //   1042: aaload
    //   1043: bipush #8
    //   1045: aaload
    //   1046: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1049: ldc_w '</PR>'
    //   1052: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1055: invokevirtual toString : ()Ljava/lang/String;
    //   1058: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1061: pop
    //   1062: aload #16
    //   1064: new java/lang/StringBuilder
    //   1067: dup
    //   1068: ldc_w '<PRStatus>'
    //   1071: invokespecial <init> : (Ljava/lang/String;)V
    //   1074: aload #15
    //   1076: iload #17
    //   1078: aaload
    //   1079: bipush #9
    //   1081: aaload
    //   1082: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1085: ldc_w '</PRStatus>'
    //   1088: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1091: invokevirtual toString : ()Ljava/lang/String;
    //   1094: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1097: pop
    //   1098: aload #16
    //   1100: new java/lang/StringBuilder
    //   1103: dup
    //   1104: ldc_w '<Inward>'
    //   1107: invokespecial <init> : (Ljava/lang/String;)V
    //   1110: aload #15
    //   1112: iload #17
    //   1114: aaload
    //   1115: bipush #10
    //   1117: aaload
    //   1118: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1121: ldc_w '</Inward>'
    //   1124: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1127: invokevirtual toString : ()Ljava/lang/String;
    //   1130: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1133: pop
    //   1134: aload #16
    //   1136: new java/lang/StringBuilder
    //   1139: dup
    //   1140: ldc_w '<Amount>'
    //   1143: invokespecial <init> : (Ljava/lang/String;)V
    //   1146: aload #15
    //   1148: iload #17
    //   1150: aaload
    //   1151: bipush #11
    //   1153: aaload
    //   1154: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1157: ldc_w '</Amount>'
    //   1160: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1163: invokevirtual toString : ()Ljava/lang/String;
    //   1166: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1169: pop
    //   1170: aload #16
    //   1172: new java/lang/StringBuilder
    //   1175: dup
    //   1176: ldc_w '<RFC>'
    //   1179: invokespecial <init> : (Ljava/lang/String;)V
    //   1182: aload #15
    //   1184: iload #17
    //   1186: aaload
    //   1187: bipush #12
    //   1189: aaload
    //   1190: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1193: ldc_w '</RFC>'
    //   1196: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1199: invokevirtual toString : ()Ljava/lang/String;
    //   1202: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1205: pop
    //   1206: aload #16
    //   1208: new java/lang/StringBuilder
    //   1211: dup
    //   1212: ldc_w '<PRModify>'
    //   1215: invokespecial <init> : (Ljava/lang/String;)V
    //   1218: aload #15
    //   1220: iload #17
    //   1222: aaload
    //   1223: bipush #13
    //   1225: aaload
    //   1226: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1229: ldc_w '</PRModify>'
    //   1232: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1235: invokevirtual toString : ()Ljava/lang/String;
    //   1238: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1241: pop
    //   1242: aload #16
    //   1244: new java/lang/StringBuilder
    //   1247: dup
    //   1248: ldc_w '<Cancel>'
    //   1251: invokespecial <init> : (Ljava/lang/String;)V
    //   1254: aload #15
    //   1256: iload #17
    //   1258: aaload
    //   1259: bipush #14
    //   1261: aaload
    //   1262: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1265: ldc_w '</Cancel>'
    //   1268: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1271: invokevirtual toString : ()Ljava/lang/String;
    //   1274: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1277: pop
    //   1278: aload #16
    //   1280: new java/lang/StringBuilder
    //   1283: dup
    //   1284: ldc_w '<Billed>'
    //   1287: invokespecial <init> : (Ljava/lang/String;)V
    //   1290: aload #15
    //   1292: iload #17
    //   1294: aaload
    //   1295: bipush #15
    //   1297: aaload
    //   1298: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1301: ldc_w '</Billed>'
    //   1304: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1307: invokevirtual toString : ()Ljava/lang/String;
    //   1310: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1313: pop
    //   1314: aload #16
    //   1316: new java/lang/StringBuilder
    //   1319: dup
    //   1320: ldc_w '<Bar>'
    //   1323: invokespecial <init> : (Ljava/lang/String;)V
    //   1326: aload #15
    //   1328: iload #17
    //   1330: aaload
    //   1331: bipush #16
    //   1333: aaload
    //   1334: invokevirtual trim : ()Ljava/lang/String;
    //   1337: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1340: ldc_w '</Bar>'
    //   1343: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1346: invokevirtual toString : ()Ljava/lang/String;
    //   1349: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1352: pop
    //   1353: aload #16
    //   1355: new java/lang/StringBuilder
    //   1358: dup
    //   1359: ldc_w '<Usertype>'
    //   1362: invokespecial <init> : (Ljava/lang/String;)V
    //   1365: aload #13
    //   1367: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1370: ldc_w '</Usertype>'
    //   1373: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1376: invokevirtual toString : ()Ljava/lang/String;
    //   1379: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1382: pop
    //   1383: aload #16
    //   1385: ldc '</Row>'
    //   1387: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1390: pop
    //   1391: iinc #17, 1
    //   1394: iload #17
    //   1396: aload #15
    //   1398: arraylength
    //   1399: if_icmplt -> 730
    //   1402: aload_1
    //   1403: ldc 'text/xml'
    //   1405: invokeinterface setContentType : (Ljava/lang/String;)V
    //   1410: aload_1
    //   1411: ldc 'Cache-Control'
    //   1413: ldc 'no-cache'
    //   1415: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   1420: aload_1
    //   1421: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   1426: new java/lang/StringBuilder
    //   1429: dup
    //   1430: ldc '<Rows>'
    //   1432: invokespecial <init> : (Ljava/lang/String;)V
    //   1435: aload #16
    //   1437: invokevirtual toString : ()Ljava/lang/String;
    //   1440: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1443: ldc '</Rows>'
    //   1445: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1448: invokevirtual toString : ()Ljava/lang/String;
    //   1451: invokevirtual write : (Ljava/lang/String;)V
    //   1454: goto -> 1509
    //   1457: aload_1
    //   1458: sipush #204
    //   1461: invokeinterface setStatus : (I)V
    //   1466: goto -> 1509
    //   1469: astore_2
    //   1470: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   1473: aload_2
    //   1474: invokevirtual getMessage : ()Ljava/lang/String;
    //   1477: invokevirtual println : (Ljava/lang/String;)V
    //   1480: aload_0
    //   1481: ldc 'error'
    //   1483: aload_2
    //   1484: invokevirtual getMessage : ()Ljava/lang/String;
    //   1487: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   1492: aload_0
    //   1493: ldc '/error/index.jsp'
    //   1495: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   1500: astore_3
    //   1501: aload_3
    //   1502: aload_0
    //   1503: aload_1
    //   1504: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   1509: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #6571	-> 0
    //   #6572	-> 7
    //   #6573	-> 30
    //   #6574	-> 54
    //   #6575	-> 65
    //   #6576	-> 76
    //   #6577	-> 87
    //   #6578	-> 98
    //   #6579	-> 109
    //   #6580	-> 120
    //   #6581	-> 131
    //   #6582	-> 142
    //   #6583	-> 147
    //   #6587	-> 158
    //   #6586	-> 165
    //   #6587	-> 166
    //   #6586	-> 167
    //   #6588	-> 168
    //   #6589	-> 174
    //   #6585	-> 186
    //   #6589	-> 189
    //   #6590	-> 192
    //   #6592	-> 197
    //   #6593	-> 202
    //   #6594	-> 225
    //   #6595	-> 248
    //   #6596	-> 271
    //   #6597	-> 294
    //   #6599	-> 317
    //   #6600	-> 340
    //   #6601	-> 350
    //   #6602	-> 378
    //   #6603	-> 388
    //   #6604	-> 416
    //   #6605	-> 426
    //   #6606	-> 454
    //   #6607	-> 464
    //   #6608	-> 492
    //   #6609	-> 502
    //   #6610	-> 530
    //   #6611	-> 540
    //   #6612	-> 574
    //   #6613	-> 584
    //   #6615	-> 618
    //   #6616	-> 628
    //   #6617	-> 661
    //   #6619	-> 694
    //   #6620	-> 702
    //   #6621	-> 709
    //   #6623	-> 718
    //   #6625	-> 724
    //   #6628	-> 730
    //   #6629	-> 738
    //   #6630	-> 771
    //   #6631	-> 806
    //   #6632	-> 841
    //   #6633	-> 876
    //   #6634	-> 919
    //   #6635	-> 954
    //   #6636	-> 990
    //   #6637	-> 1026
    //   #6638	-> 1062
    //   #6639	-> 1098
    //   #6640	-> 1134
    //   #6641	-> 1170
    //   #6642	-> 1206
    //   #6643	-> 1242
    //   #6644	-> 1278
    //   #6645	-> 1314
    //   #6646	-> 1353
    //   #6647	-> 1383
    //   #6625	-> 1391
    //   #6651	-> 1402
    //   #6652	-> 1410
    //   #6653	-> 1420
    //   #6654	-> 1454
    //   #6657	-> 1457
    //   #6659	-> 1466
    //   #6660	-> 1469
    //   #6662	-> 1470
    //   #6663	-> 1480
    //   #6664	-> 1492
    //   #6665	-> 1501
    //   #6667	-> 1509
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	1510	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	1510	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   7	1459	2	session	Ljavax/servlet/http/HttpSession;
    //   30	1436	3	branchid	Ljava/lang/String;
    //   54	1412	4	usertype	Ljava/lang/String;
    //   65	1401	5	division	Ljava/lang/String;
    //   76	1390	6	customer	Ljava/lang/String;
    //   87	1379	7	day	Ljava/lang/String;
    //   98	1368	8	month	Ljava/lang/String;
    //   109	1357	9	year	Ljava/lang/String;
    //   120	1346	10	startletter	Ljava/lang/String;
    //   131	1335	11	status	Ljava/lang/String;
    //   142	1324	12	cancel	Ljava/lang/String;
    //   147	1319	13	Usertype	Ljava/lang/String;
    //   202	1264	14	sql	Ljava/lang/String;
    //   709	757	15	readData	[[Ljava/lang/String;
    //   718	748	16	sb	Ljava/lang/StringBuffer;
    //   727	675	17	u	I
    //   1470	39	2	e	Ljava/lang/Exception;
    //   1501	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	1466	1469	java/lang/Exception
  }
  
  public static void POSaleOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String status = request.getParameter("status");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String startletter = request.getParameter("startletter");
      String sql = "  SELECT a.INT_ROWID,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_SALESORDERNO,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
      sql = String.valueOf(sql) + "  FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_VERIFICATIED,DATE_FORMAT(a.DAT_SALEDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + "  IF(a.CHR_PR_AVAILABLE='Y' ,a.CHR_POREQUESTNO,'-'), ";
      sql = String.valueOf(sql) + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF( b.CHR_CLOSEDSTATUS = 'Y','Closed','Pending') FROM inv_t_purchaserequest b WHERE b.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),''), ";
      sql = String.valueOf(sql) + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF(c.CHR_PR_PARTIALLY_RECEIVED='P','Partillay received',IF(c.CHR_PR_PARTIALLY_RECEIVED='Y','Fully Receive','Pending') ) FROM inv_t_purchaserequest c WHERE c.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),'') ,";
      sql = String.valueOf(sql) + "  a.DOU_TOTALAMOUNT , a.CHR_SALEORDER_APPROVAL,a.INT_PROGRESSBAR";
      sql = String.valueOf(sql) + "  FROM  inv_t_customersalesorder a WHERE  a.INT_ROWID >0  ";
      sql = String.valueOf(sql) + "  AND CHR_VERIFICATIED='Y'   ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND  a.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_SALEORDER_APPROVAL = '" + status + "'"; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND  a.INT_DIVIID = " + division; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_SALEDATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALEDATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_SALEDATE) = " + year; 
      if (!"0".equals(startletter))
        sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + startletter + "%' "; 
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + object + " ORDER BY  a.DAT_SALEDATE";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<Branch>" + readData[u][1] + "</Branch>");
          sb.append("<CPOref>" + readData[u][2] + "</CPOref>");
          sb.append("<Quotation>" + readData[u][3] + "</Quotation>");
          sb.append("<customerName>" + readData[u][4].replaceAll("&", " AND ") + "</customerName>");
          sb.append("<Division>" + readData[u][5] + "</Division>");
          sb.append("<Verified>" + readData[u][6] + "</Verified>");
          sb.append("<CPODate>" + readData[u][7] + "</CPODate>");
          sb.append("<PR>" + readData[u][8] + "</PR>");
          sb.append("<PRStatus>" + readData[u][9] + "</PRStatus>");
          sb.append("<Inward>" + readData[u][10] + "</Inward>");
          sb.append("<Amount>" + readData[u][11] + "</Amount>");
          sb.append("<SaleOrder>" + readData[u][12] + "</SaleOrder>");
          sb.append("<Bar>" + readData[u][13] + "</Bar>");
          sb.append("<CPOFlag>" + InventoryInvoiceFunctions.CPOReasdytoBill(readData[u][2]) + "</CPOFlag>");
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
  
  public static void loadPOBilling(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: invokeinterface getSession : ()Ljavax/servlet/http/HttpSession;
    //   6: astore_2
    //   7: new java/lang/StringBuilder
    //   10: dup
    //   11: invokespecial <init> : ()V
    //   14: aload_2
    //   15: ldc_w 'INVBRANCH'
    //   18: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   23: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   26: invokevirtual toString : ()Ljava/lang/String;
    //   29: astore_3
    //   30: new java/lang/StringBuilder
    //   33: dup
    //   34: invokespecial <init> : ()V
    //   37: aload_2
    //   38: ldc_w 'USRTYPE'
    //   41: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   46: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   49: invokevirtual toString : ()Ljava/lang/String;
    //   52: astore #4
    //   54: aload_0
    //   55: ldc_w 'division'
    //   58: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   63: astore #5
    //   65: aload_0
    //   66: ldc_w 'customer'
    //   69: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   74: astore #6
    //   76: aload_0
    //   77: ldc_w 'status'
    //   80: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   85: astore #7
    //   87: aload_0
    //   88: ldc_w 'day'
    //   91: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   96: astore #8
    //   98: aload_0
    //   99: ldc_w 'month'
    //   102: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   107: astore #9
    //   109: aload_0
    //   110: ldc_w 'year'
    //   113: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   118: astore #10
    //   120: aload_0
    //   121: ldc_w 'startletter'
    //   124: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   129: astore #11
    //   131: aload_0
    //   132: ldc_w 'cancel'
    //   135: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   140: astore #12
    //   142: aload_0
    //   143: ldc_w 'type'
    //   146: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   151: astore #13
    //   153: new java/lang/StringBuilder
    //   156: dup
    //   157: invokespecial <init> : ()V
    //   160: aload_0
    //   161: ldc_w 'txtSer'
    //   164: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   169: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   172: invokevirtual toString : ()Ljava/lang/String;
    //   175: astore #14
    //   177: aload #14
    //   179: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   182: astore #14
    //   184: ldc_w '-'
    //   187: astore #15
    //   189: ldc_w 'F'
    //   192: aload #4
    //   194: invokevirtual equals : (Ljava/lang/Object;)Z
    //   197: ifne -> 234
    //   200: ldc_w 'SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1'
    //   203: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   206: iconst_0
    //   207: aaload
    //   208: iconst_0
    //   209: aaload
    //   210: ldc_w ','
    //   213: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   216: aload_2
    //   217: ldc_w 'USRID'
    //   220: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   225: invokevirtual toString : ()Ljava/lang/String;
    //   228: invokestatic contains : ([Ljava/lang/Object;Ljava/lang/Object;)Z
    //   231: ifeq -> 239
    //   234: ldc_w 'F'
    //   237: astore #15
    //   239: ldc_w '  SELECT a.INT_ROWID,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_SALESORDERNO,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), '
    //   242: astore #16
    //   244: new java/lang/StringBuilder
    //   247: dup
    //   248: aload #16
    //   250: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   253: invokespecial <init> : (Ljava/lang/String;)V
    //   256: ldc_w '  FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_VERIFICATIED,DATE_FORMAT(a.DAT_SALEDATE,'%d-%b-%Y'), '
    //   259: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   262: invokevirtual toString : ()Ljava/lang/String;
    //   265: astore #16
    //   267: new java/lang/StringBuilder
    //   270: dup
    //   271: aload #16
    //   273: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   276: invokespecial <init> : (Ljava/lang/String;)V
    //   279: ldc_w '  IF(a.CHR_PR_AVAILABLE='Y' ,a.CHR_POREQUESTNO,'-'), '
    //   282: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   285: invokevirtual toString : ()Ljava/lang/String;
    //   288: astore #16
    //   290: new java/lang/StringBuilder
    //   293: dup
    //   294: aload #16
    //   296: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   299: invokespecial <init> : (Ljava/lang/String;)V
    //   302: ldc_w '  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF( b.CHR_CLOSEDSTATUS = 'Y','Closed','Pending') FROM inv_t_purchaserequest b WHERE b.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),''), '
    //   305: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   308: invokevirtual toString : ()Ljava/lang/String;
    //   311: astore #16
    //   313: new java/lang/StringBuilder
    //   316: dup
    //   317: aload #16
    //   319: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   322: invokespecial <init> : (Ljava/lang/String;)V
    //   325: ldc_w '  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF(c.CHR_PR_PARTIALLY_RECEIVED='P','Partillay received',IF(c.CHR_PR_PARTIALLY_RECEIVED='Y','Fully Receive','Pending') ) FROM inv_t_purchaserequest c WHERE c.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),'') ,'
    //   328: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   331: invokevirtual toString : ()Ljava/lang/String;
    //   334: astore #16
    //   336: new java/lang/StringBuilder
    //   339: dup
    //   340: aload #16
    //   342: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   345: invokespecial <init> : (Ljava/lang/String;)V
    //   348: ldc_w '  a.DOU_TOTALAMOUNT ,a.CHR_BILLED,a.CHR_SALEORDER_APPROVAL, '
    //   351: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   354: invokevirtual toString : ()Ljava/lang/String;
    //   357: astore #16
    //   359: new java/lang/StringBuilder
    //   362: dup
    //   363: aload #16
    //   365: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   368: invokespecial <init> : (Ljava/lang/String;)V
    //   371: ldc_w '  FUN_INV_GET_CPO_SALESINVOICE_COUNT(a.CHR_SALESORDERNO),  '
    //   374: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   377: invokevirtual toString : ()Ljava/lang/String;
    //   380: astore #16
    //   382: new java/lang/StringBuilder
    //   385: dup
    //   386: aload #16
    //   388: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   391: invokespecial <init> : (Ljava/lang/String;)V
    //   394: ldc_w '   a.CHR_CANCEL, a.CHR_BILLED,a.INT_PROGRESSBAR   '
    //   397: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   400: invokevirtual toString : ()Ljava/lang/String;
    //   403: astore #16
    //   405: new java/lang/StringBuilder
    //   408: dup
    //   409: aload #16
    //   411: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   414: invokespecial <init> : (Ljava/lang/String;)V
    //   417: ldc_w '  FROM  inv_t_customersalesorder a WHERE  a.INT_ROWID >0   AND CHR_VERIFICATIED='Y' '
    //   420: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   423: invokevirtual toString : ()Ljava/lang/String;
    //   426: astore #16
    //   428: ldc '0'
    //   430: aload #6
    //   432: invokevirtual equals : (Ljava/lang/Object;)Z
    //   435: ifne -> 466
    //   438: new java/lang/StringBuilder
    //   441: dup
    //   442: aload #16
    //   444: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   447: invokespecial <init> : (Ljava/lang/String;)V
    //   450: ldc_w ' AND  a.INT_CUSTOMERID = '
    //   453: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   456: aload #6
    //   458: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   461: invokevirtual toString : ()Ljava/lang/String;
    //   464: astore #16
    //   466: ldc '0'
    //   468: aload #7
    //   470: invokevirtual equals : (Ljava/lang/Object;)Z
    //   473: ifne -> 510
    //   476: new java/lang/StringBuilder
    //   479: dup
    //   480: aload #16
    //   482: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   485: invokespecial <init> : (Ljava/lang/String;)V
    //   488: ldc_w ' AND a.CHR_BILLED = ''
    //   491: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   494: aload #7
    //   496: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   499: ldc_w '''
    //   502: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   505: invokevirtual toString : ()Ljava/lang/String;
    //   508: astore #16
    //   510: ldc '0'
    //   512: aload #12
    //   514: invokevirtual equals : (Ljava/lang/Object;)Z
    //   517: ifne -> 554
    //   520: new java/lang/StringBuilder
    //   523: dup
    //   524: aload #16
    //   526: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   529: invokespecial <init> : (Ljava/lang/String;)V
    //   532: ldc_w ' AND a.CHR_CANCEL = ''
    //   535: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   538: aload #12
    //   540: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   543: ldc_w '''
    //   546: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   549: invokevirtual toString : ()Ljava/lang/String;
    //   552: astore #16
    //   554: ldc '0'
    //   556: aload #5
    //   558: invokevirtual equals : (Ljava/lang/Object;)Z
    //   561: ifne -> 592
    //   564: new java/lang/StringBuilder
    //   567: dup
    //   568: aload #16
    //   570: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   573: invokespecial <init> : (Ljava/lang/String;)V
    //   576: ldc_w ' AND  a.INT_DIVIID = '
    //   579: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   582: aload #5
    //   584: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   587: invokevirtual toString : ()Ljava/lang/String;
    //   590: astore #16
    //   592: ldc '0'
    //   594: aload #8
    //   596: invokevirtual equals : (Ljava/lang/Object;)Z
    //   599: ifne -> 630
    //   602: new java/lang/StringBuilder
    //   605: dup
    //   606: aload #16
    //   608: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   611: invokespecial <init> : (Ljava/lang/String;)V
    //   614: ldc_w ' AND DAY(a.DAT_SALEDATE) = '
    //   617: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   620: aload #8
    //   622: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   625: invokevirtual toString : ()Ljava/lang/String;
    //   628: astore #16
    //   630: ldc '0'
    //   632: aload #9
    //   634: invokevirtual equals : (Ljava/lang/Object;)Z
    //   637: ifne -> 668
    //   640: new java/lang/StringBuilder
    //   643: dup
    //   644: aload #16
    //   646: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   649: invokespecial <init> : (Ljava/lang/String;)V
    //   652: ldc_w ' AND MONTH(a.DAT_SALEDATE) = '
    //   655: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   658: aload #9
    //   660: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   663: invokevirtual toString : ()Ljava/lang/String;
    //   666: astore #16
    //   668: ldc '0'
    //   670: aload #10
    //   672: invokevirtual equals : (Ljava/lang/Object;)Z
    //   675: ifne -> 706
    //   678: new java/lang/StringBuilder
    //   681: dup
    //   682: aload #16
    //   684: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   687: invokespecial <init> : (Ljava/lang/String;)V
    //   690: ldc_w ' AND YEAR(a.DAT_SALEDATE) = '
    //   693: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   696: aload #10
    //   698: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   701: invokevirtual toString : ()Ljava/lang/String;
    //   704: astore #16
    //   706: ldc_w '1'
    //   709: aload #13
    //   711: invokevirtual equals : (Ljava/lang/Object;)Z
    //   714: ifeq -> 763
    //   717: ldc '0'
    //   719: aload #11
    //   721: invokevirtual equals : (Ljava/lang/Object;)Z
    //   724: ifne -> 811
    //   727: new java/lang/StringBuilder
    //   730: dup
    //   731: aload #16
    //   733: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   736: invokespecial <init> : (Ljava/lang/String;)V
    //   739: ldc_w ' AND FIND_A_CUSTOMER_NAME(A.INT_CUSTOMERID) LIKE ''
    //   742: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   745: aload #11
    //   747: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   750: ldc '%''
    //   752: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   755: invokevirtual toString : ()Ljava/lang/String;
    //   758: astore #16
    //   760: goto -> 811
    //   763: new java/lang/StringBuilder
    //   766: dup
    //   767: aload #16
    //   769: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   772: invokespecial <init> : (Ljava/lang/String;)V
    //   775: ldc_w ' AND ( (a.CHR_SALESORDERNO LIKE '%'
    //   778: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   781: aload #14
    //   783: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   786: ldc_w '%') OR ( FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE ''
    //   789: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   792: aload #14
    //   794: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   797: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   800: ldc_w '%') )'
    //   803: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   806: invokevirtual toString : ()Ljava/lang/String;
    //   809: astore #16
    //   811: new java/lang/StringBuilder
    //   814: dup
    //   815: aload #16
    //   817: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   820: invokespecial <init> : (Ljava/lang/String;)V
    //   823: ldc_w ' AND a.INT_BRANCHID='
    //   826: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   829: aload_3
    //   830: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   833: ldc_w ' ORDER BY  a.DAT_SALEDATE'
    //   836: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   839: invokevirtual toString : ()Ljava/lang/String;
    //   842: astore #16
    //   844: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   847: aload #16
    //   849: invokevirtual println : (Ljava/lang/String;)V
    //   852: aload #16
    //   854: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   857: astore #17
    //   859: new java/lang/StringBuffer
    //   862: dup
    //   863: invokespecial <init> : ()V
    //   866: astore #18
    //   868: aload #17
    //   870: arraylength
    //   871: ifle -> 1707
    //   874: iconst_0
    //   875: istore #19
    //   877: goto -> 1644
    //   880: aload #18
    //   882: ldc '<Row>'
    //   884: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   887: pop
    //   888: aload #18
    //   890: new java/lang/StringBuilder
    //   893: dup
    //   894: ldc '<id>'
    //   896: invokespecial <init> : (Ljava/lang/String;)V
    //   899: aload #17
    //   901: iload #19
    //   903: aaload
    //   904: iconst_0
    //   905: aaload
    //   906: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   909: ldc '</id>'
    //   911: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   914: invokevirtual toString : ()Ljava/lang/String;
    //   917: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   920: pop
    //   921: aload #18
    //   923: new java/lang/StringBuilder
    //   926: dup
    //   927: ldc_w '<Branch>'
    //   930: invokespecial <init> : (Ljava/lang/String;)V
    //   933: aload #17
    //   935: iload #19
    //   937: aaload
    //   938: iconst_1
    //   939: aaload
    //   940: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   943: ldc_w '</Branch>'
    //   946: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   949: invokevirtual toString : ()Ljava/lang/String;
    //   952: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   955: pop
    //   956: aload #18
    //   958: new java/lang/StringBuilder
    //   961: dup
    //   962: ldc_w '<CPOref>'
    //   965: invokespecial <init> : (Ljava/lang/String;)V
    //   968: aload #17
    //   970: iload #19
    //   972: aaload
    //   973: iconst_2
    //   974: aaload
    //   975: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   978: ldc_w '</CPOref>'
    //   981: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   984: invokevirtual toString : ()Ljava/lang/String;
    //   987: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   990: pop
    //   991: aload #18
    //   993: new java/lang/StringBuilder
    //   996: dup
    //   997: ldc_w '<Quotation>'
    //   1000: invokespecial <init> : (Ljava/lang/String;)V
    //   1003: aload #17
    //   1005: iload #19
    //   1007: aaload
    //   1008: iconst_3
    //   1009: aaload
    //   1010: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1013: ldc_w '</Quotation>'
    //   1016: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1019: invokevirtual toString : ()Ljava/lang/String;
    //   1022: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1025: pop
    //   1026: aload #18
    //   1028: new java/lang/StringBuilder
    //   1031: dup
    //   1032: ldc_w '<customerName>'
    //   1035: invokespecial <init> : (Ljava/lang/String;)V
    //   1038: aload #17
    //   1040: iload #19
    //   1042: aaload
    //   1043: iconst_4
    //   1044: aaload
    //   1045: ldc '&'
    //   1047: ldc_w ' AND '
    //   1050: invokevirtual replaceAll : (Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    //   1053: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1056: ldc_w '</customerName>'
    //   1059: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1062: invokevirtual toString : ()Ljava/lang/String;
    //   1065: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1068: pop
    //   1069: aload #18
    //   1071: new java/lang/StringBuilder
    //   1074: dup
    //   1075: ldc_w '<Division>'
    //   1078: invokespecial <init> : (Ljava/lang/String;)V
    //   1081: aload #17
    //   1083: iload #19
    //   1085: aaload
    //   1086: iconst_5
    //   1087: aaload
    //   1088: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1091: ldc_w '</Division>'
    //   1094: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1097: invokevirtual toString : ()Ljava/lang/String;
    //   1100: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1103: pop
    //   1104: aload #18
    //   1106: new java/lang/StringBuilder
    //   1109: dup
    //   1110: ldc_w '<Verified>'
    //   1113: invokespecial <init> : (Ljava/lang/String;)V
    //   1116: aload #17
    //   1118: iload #19
    //   1120: aaload
    //   1121: bipush #6
    //   1123: aaload
    //   1124: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1127: ldc_w '</Verified>'
    //   1130: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1133: invokevirtual toString : ()Ljava/lang/String;
    //   1136: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1139: pop
    //   1140: aload #18
    //   1142: new java/lang/StringBuilder
    //   1145: dup
    //   1146: ldc_w '<CPODate>'
    //   1149: invokespecial <init> : (Ljava/lang/String;)V
    //   1152: aload #17
    //   1154: iload #19
    //   1156: aaload
    //   1157: bipush #7
    //   1159: aaload
    //   1160: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1163: ldc_w '</CPODate>'
    //   1166: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1169: invokevirtual toString : ()Ljava/lang/String;
    //   1172: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1175: pop
    //   1176: aload #18
    //   1178: new java/lang/StringBuilder
    //   1181: dup
    //   1182: ldc_w '<PR>'
    //   1185: invokespecial <init> : (Ljava/lang/String;)V
    //   1188: aload #17
    //   1190: iload #19
    //   1192: aaload
    //   1193: bipush #8
    //   1195: aaload
    //   1196: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1199: ldc_w '</PR>'
    //   1202: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1205: invokevirtual toString : ()Ljava/lang/String;
    //   1208: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1211: pop
    //   1212: aload #18
    //   1214: new java/lang/StringBuilder
    //   1217: dup
    //   1218: ldc_w '<PRStatus>'
    //   1221: invokespecial <init> : (Ljava/lang/String;)V
    //   1224: aload #17
    //   1226: iload #19
    //   1228: aaload
    //   1229: bipush #9
    //   1231: aaload
    //   1232: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1235: ldc_w '</PRStatus>'
    //   1238: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1241: invokevirtual toString : ()Ljava/lang/String;
    //   1244: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1247: pop
    //   1248: aload #18
    //   1250: new java/lang/StringBuilder
    //   1253: dup
    //   1254: ldc_w '<Inward>'
    //   1257: invokespecial <init> : (Ljava/lang/String;)V
    //   1260: aload #17
    //   1262: iload #19
    //   1264: aaload
    //   1265: bipush #10
    //   1267: aaload
    //   1268: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1271: ldc_w '</Inward>'
    //   1274: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1277: invokevirtual toString : ()Ljava/lang/String;
    //   1280: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1283: pop
    //   1284: aload #18
    //   1286: new java/lang/StringBuilder
    //   1289: dup
    //   1290: ldc_w '<Amount>'
    //   1293: invokespecial <init> : (Ljava/lang/String;)V
    //   1296: aload #17
    //   1298: iload #19
    //   1300: aaload
    //   1301: bipush #11
    //   1303: aaload
    //   1304: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1307: ldc_w '</Amount>'
    //   1310: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1313: invokevirtual toString : ()Ljava/lang/String;
    //   1316: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1319: pop
    //   1320: aload #18
    //   1322: new java/lang/StringBuilder
    //   1325: dup
    //   1326: ldc_w '<Billing>'
    //   1329: invokespecial <init> : (Ljava/lang/String;)V
    //   1332: aload #17
    //   1334: iload #19
    //   1336: aaload
    //   1337: bipush #12
    //   1339: aaload
    //   1340: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1343: ldc_w '</Billing>'
    //   1346: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1349: invokevirtual toString : ()Ljava/lang/String;
    //   1352: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1355: pop
    //   1356: aload #18
    //   1358: new java/lang/StringBuilder
    //   1361: dup
    //   1362: ldc_w '<SaleOrder>'
    //   1365: invokespecial <init> : (Ljava/lang/String;)V
    //   1368: aload #17
    //   1370: iload #19
    //   1372: aaload
    //   1373: bipush #13
    //   1375: aaload
    //   1376: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1379: ldc_w '</SaleOrder>'
    //   1382: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1385: invokevirtual toString : ()Ljava/lang/String;
    //   1388: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1391: pop
    //   1392: ldc_w 'Y'
    //   1395: aload #17
    //   1397: iload #19
    //   1399: aaload
    //   1400: bipush #12
    //   1402: aaload
    //   1403: invokevirtual equals : (Ljava/lang/Object;)Z
    //   1406: ifne -> 1450
    //   1409: aload #18
    //   1411: new java/lang/StringBuilder
    //   1414: dup
    //   1415: ldc_w '<CPOFlag>'
    //   1418: invokespecial <init> : (Ljava/lang/String;)V
    //   1421: aload #17
    //   1423: iload #19
    //   1425: aaload
    //   1426: iconst_2
    //   1427: aaload
    //   1428: invokestatic CPOReasdytoBill : (Ljava/lang/String;)Ljava/lang/String;
    //   1431: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1434: ldc_w '</CPOFlag>'
    //   1437: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1440: invokevirtual toString : ()Ljava/lang/String;
    //   1443: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1446: pop
    //   1447: goto -> 1459
    //   1450: aload #18
    //   1452: ldc_w '<CPOFlag>-</CPOFlag>'
    //   1455: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1458: pop
    //   1459: aload #18
    //   1461: new java/lang/StringBuilder
    //   1464: dup
    //   1465: ldc_w '<NoofBilling>'
    //   1468: invokespecial <init> : (Ljava/lang/String;)V
    //   1471: aload #17
    //   1473: iload #19
    //   1475: aaload
    //   1476: bipush #14
    //   1478: aaload
    //   1479: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1482: ldc_w '</NoofBilling>'
    //   1485: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1488: invokevirtual toString : ()Ljava/lang/String;
    //   1491: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1494: pop
    //   1495: aload #18
    //   1497: new java/lang/StringBuilder
    //   1500: dup
    //   1501: ldc_w '<Cancel>'
    //   1504: invokespecial <init> : (Ljava/lang/String;)V
    //   1507: aload #17
    //   1509: iload #19
    //   1511: aaload
    //   1512: bipush #15
    //   1514: aaload
    //   1515: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1518: ldc_w '</Cancel>'
    //   1521: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1524: invokevirtual toString : ()Ljava/lang/String;
    //   1527: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1530: pop
    //   1531: aload #18
    //   1533: new java/lang/StringBuilder
    //   1536: dup
    //   1537: ldc_w '<Billed>'
    //   1540: invokespecial <init> : (Ljava/lang/String;)V
    //   1543: aload #17
    //   1545: iload #19
    //   1547: aaload
    //   1548: bipush #16
    //   1550: aaload
    //   1551: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1554: ldc_w '</Billed>'
    //   1557: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1560: invokevirtual toString : ()Ljava/lang/String;
    //   1563: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1566: pop
    //   1567: aload #18
    //   1569: new java/lang/StringBuilder
    //   1572: dup
    //   1573: ldc_w '<Bar>'
    //   1576: invokespecial <init> : (Ljava/lang/String;)V
    //   1579: aload #17
    //   1581: iload #19
    //   1583: aaload
    //   1584: bipush #17
    //   1586: aaload
    //   1587: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1590: ldc_w '</Bar>'
    //   1593: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1596: invokevirtual toString : ()Ljava/lang/String;
    //   1599: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1602: pop
    //   1603: aload #18
    //   1605: new java/lang/StringBuilder
    //   1608: dup
    //   1609: ldc_w '<Usertype>'
    //   1612: invokespecial <init> : (Ljava/lang/String;)V
    //   1615: aload #15
    //   1617: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1620: ldc_w '</Usertype>'
    //   1623: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1626: invokevirtual toString : ()Ljava/lang/String;
    //   1629: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1632: pop
    //   1633: aload #18
    //   1635: ldc '</Row>'
    //   1637: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1640: pop
    //   1641: iinc #19, 1
    //   1644: iload #19
    //   1646: aload #17
    //   1648: arraylength
    //   1649: if_icmplt -> 880
    //   1652: aload_1
    //   1653: ldc 'text/xml'
    //   1655: invokeinterface setContentType : (Ljava/lang/String;)V
    //   1660: aload_1
    //   1661: ldc 'Cache-Control'
    //   1663: ldc 'no-cache'
    //   1665: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   1670: aload_1
    //   1671: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   1676: new java/lang/StringBuilder
    //   1679: dup
    //   1680: ldc '<Rows>'
    //   1682: invokespecial <init> : (Ljava/lang/String;)V
    //   1685: aload #18
    //   1687: invokevirtual toString : ()Ljava/lang/String;
    //   1690: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1693: ldc '</Rows>'
    //   1695: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1698: invokevirtual toString : ()Ljava/lang/String;
    //   1701: invokevirtual write : (Ljava/lang/String;)V
    //   1704: goto -> 1759
    //   1707: aload_1
    //   1708: sipush #204
    //   1711: invokeinterface setStatus : (I)V
    //   1716: goto -> 1759
    //   1719: astore_2
    //   1720: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   1723: aload_2
    //   1724: invokevirtual getMessage : ()Ljava/lang/String;
    //   1727: invokevirtual println : (Ljava/lang/String;)V
    //   1730: aload_0
    //   1731: ldc 'error'
    //   1733: aload_2
    //   1734: invokevirtual getMessage : ()Ljava/lang/String;
    //   1737: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   1742: aload_0
    //   1743: ldc '/error/index.jsp'
    //   1745: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   1750: astore_3
    //   1751: aload_3
    //   1752: aload_0
    //   1753: aload_1
    //   1754: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   1759: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #6759	-> 0
    //   #6760	-> 7
    //   #6761	-> 30
    //   #6762	-> 54
    //   #6763	-> 65
    //   #6764	-> 76
    //   #6765	-> 87
    //   #6766	-> 98
    //   #6767	-> 109
    //   #6768	-> 120
    //   #6769	-> 131
    //   #6770	-> 142
    //   #6771	-> 153
    //   #6772	-> 177
    //   #6773	-> 184
    //   #6774	-> 189
    //   #6778	-> 200
    //   #6777	-> 207
    //   #6778	-> 208
    //   #6777	-> 209
    //   #6779	-> 210
    //   #6780	-> 216
    //   #6776	-> 228
    //   #6780	-> 231
    //   #6781	-> 234
    //   #6782	-> 239
    //   #6783	-> 244
    //   #6784	-> 267
    //   #6785	-> 290
    //   #6786	-> 313
    //   #6787	-> 336
    //   #6788	-> 359
    //   #6789	-> 382
    //   #6790	-> 405
    //   #6791	-> 428
    //   #6792	-> 438
    //   #6793	-> 466
    //   #6794	-> 476
    //   #6795	-> 510
    //   #6796	-> 520
    //   #6797	-> 554
    //   #6798	-> 564
    //   #6799	-> 592
    //   #6800	-> 602
    //   #6801	-> 630
    //   #6802	-> 640
    //   #6803	-> 668
    //   #6804	-> 678
    //   #6805	-> 706
    //   #6807	-> 717
    //   #6808	-> 727
    //   #6809	-> 760
    //   #6812	-> 763
    //   #6814	-> 811
    //   #6816	-> 844
    //   #6817	-> 852
    //   #6818	-> 859
    //   #6820	-> 868
    //   #6822	-> 874
    //   #6825	-> 880
    //   #6826	-> 888
    //   #6827	-> 921
    //   #6828	-> 956
    //   #6829	-> 991
    //   #6830	-> 1026
    //   #6831	-> 1069
    //   #6832	-> 1104
    //   #6833	-> 1140
    //   #6834	-> 1176
    //   #6835	-> 1212
    //   #6836	-> 1248
    //   #6837	-> 1284
    //   #6838	-> 1320
    //   #6839	-> 1356
    //   #6840	-> 1392
    //   #6841	-> 1409
    //   #6843	-> 1450
    //   #6844	-> 1459
    //   #6845	-> 1495
    //   #6846	-> 1531
    //   #6847	-> 1567
    //   #6849	-> 1603
    //   #6851	-> 1633
    //   #6822	-> 1641
    //   #6855	-> 1652
    //   #6856	-> 1660
    //   #6857	-> 1670
    //   #6858	-> 1704
    //   #6861	-> 1707
    //   #6863	-> 1716
    //   #6864	-> 1719
    //   #6866	-> 1720
    //   #6867	-> 1730
    //   #6868	-> 1742
    //   #6869	-> 1751
    //   #6871	-> 1759
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	1760	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	1760	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   7	1709	2	session	Ljavax/servlet/http/HttpSession;
    //   30	1686	3	branchid	Ljava/lang/String;
    //   54	1662	4	usertype	Ljava/lang/String;
    //   65	1651	5	division	Ljava/lang/String;
    //   76	1640	6	customer	Ljava/lang/String;
    //   87	1629	7	status	Ljava/lang/String;
    //   98	1618	8	day	Ljava/lang/String;
    //   109	1607	9	month	Ljava/lang/String;
    //   120	1596	10	year	Ljava/lang/String;
    //   131	1585	11	startletter	Ljava/lang/String;
    //   142	1574	12	cancel	Ljava/lang/String;
    //   153	1563	13	type	Ljava/lang/String;
    //   177	1539	14	txtSer	Ljava/lang/String;
    //   189	1527	15	Usertype	Ljava/lang/String;
    //   244	1472	16	sql	Ljava/lang/String;
    //   859	857	17	readData	[[Ljava/lang/String;
    //   868	848	18	sb	Ljava/lang/StringBuffer;
    //   877	775	19	u	I
    //   1720	39	2	e	Ljava/lang/Exception;
    //   1751	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	1716	1719	java/lang/Exception
  }
  
  public static void PurchaseIdCheck(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String username = request.getParameter("userName");
      String sql = " SELECT count(*) FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO='" + username + "'";
      boolean flag = CommonInfo.RecordExist(sql);
      StringBuffer sb = new StringBuffer();
      sb.append("<Username>");
      sb.append("<Status>" + flag + "</Status>");
      sb.append("</Username>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void QuotationIdCheck(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String quoNumber = request.getParameter("quoNumber");
      String sql = " SELECT count(*) FROM  inv_t_customerquotation  WHERE CHR_QUOTATIONNO='" + quoNumber + "'";
      boolean flag = CommonInfo.RecordExist(sql);
      StringBuffer sb = new StringBuffer();
      sb.append("<Username>");
      sb.append("<Status>" + flag + "</Status>");
      sb.append("</Username>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void CheckUnique(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      boolean flag = false;
      String quoNumber = request.getParameter("quoNumber");
      quoNumber = quoNumber.trim();
      if (!quoNumber.equals("null") && !quoNumber.equals("")) {
        String fieldName = request.getParameter("fieldName");
        String tableName = request.getParameter("tableName");
        String sql = " SELECT count(*) FROM " + tableName + " WHERE " + fieldName + "='" + quoNumber + "'";
        flag = CommonInfo.RecordExist(sql);
      } 
      StringBuffer sb = new StringBuffer();
      sb.append("<Username>");
      sb.append("<Status>" + flag + "</Status>");
      sb.append("</Username>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadCustomerPurchaseOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String poattach = request.getParameter("poattach");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String startletter = request.getParameter("startletter");
      String status = request.getParameter("status");
      String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_QUOTATIONDATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), a.CHR_ONHOLD,a.DOU_TOTALAMOUNT,a.CHR_STATUS,";
      sql = String.valueOf(sql) + "  (SELECT COUNT(*) FROM inv_t_customersalesorder c WHERE c.CHR_QUOTATIONNO=a.CHR_QUOTATIONNO ), ";
      sql = String.valueOf(sql) + " FUN_INV_DIVISION(a.INT_DIVIID ) ,a.INT_PROGRESSBAR, datediff(NOW(),a.DAT_CREATIONTIME )";
      sql = String.valueOf(sql) + " FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID  AND a.CHR_ONHOLD='N' ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(poattach))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS = '" + poattach + "' "; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_QUOTATIONDATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_QUOTATIONDATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_QUOTATIONDATE) = " + year; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS = '" + status + "' AND a.CHR_CANCEL='N' "; 
      if (!"0".equals(startletter))
        sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + startletter + "%' "; 
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + object + " ORDER BY  a.DAT_QUOTATIONDATE";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      String filepath = request.getRealPath("/");
      File f = null;
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<id>" + readData[u][0] + "</id>");
          sb.append("<quotationNo>" + readData[u][1] + "</quotationNo>");
          sb.append("<customerName>" + readData[u][2].replaceAll("&", " AND ") + "</customerName>");
          sb.append("<QuotDate>" + readData[u][3] + "</QuotDate>");
          sb.append("<reqDate>" + readData[u][4] + "</reqDate>");
          sb.append("<onHold>" + readData[u][5] + "</onHold>");
          sb.append("<totalAmount>" + readData[u][6] + "</totalAmount>");
          sb.append("<quotationStatus>" + readData[u][7] + "</quotationStatus>");
          sb.append("<Purchaseorder>" + readData[u][8] + "</Purchaseorder>");
          sb.append("<Division>" + readData[u][9] + "</Division>");
          sb.append("<Bar>" + readData[u][10] + "</Bar>");
          sb.append("<Age>" + readData[u][11] + "</Age>");
          f = new File(String.valueOf(filepath) + "uploadfiles/CPO_Order/" + readData[u][1].replaceAll("/", "_") + ".pdf");
          if (f.exists()) {
            sb.append("<Download>Y</Download>");
          } else {
            sb.append("<Download>N</Download>");
          } 
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
  
  public static void loadDelData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String txtSer = request.getParameter("txtSer");
      if (txtSer.equals("null"))
        txtSer = ""; 
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + 
        "-" + 
        month + 
        "-" + 
        DateUtil.totalDays(mon, 
          year);
      String sql = "SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),";
      sql = String.valueOf(sql) + 
        " a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
      sql = String.valueOf(sql) + " where a.DAT_SALEDATE>='" + fDate + "' ";
      sql = String.valueOf(sql) + " AND a.DAT_SALEDATE<='" + tDate + "' ";
      sql = String.valueOf(sql) + 
        " AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          String query = "select CHR_SALESORDERNO,CHR_DELIVERYNO,DT_DELIVERYDATE from  inv_t_customersalesorderitemserial   WHERE CHR_SALESORDERNO='" + 
            readData[u][2] + 
            "' AND  CHR_DELIVERYNO is not null GROUP by CHR_DELIVERYNO";
          String[][] data = 
            CommonFunctions.QueryExecute(query);
          if (readData[u][2].toUpperCase().startsWith(
              txtSer.toUpperCase()) || 
            "0".equals(txtSer)) {
            sb.append("<Delivery>");
            sb.append("<Qno>" + readData[u][0] + "</Qno>");
            sb.append("<Custpurchaseno>" + readData[u][1] + 
                "</Custpurchaseno>");
            sb.append("<Saleno>" + readData[u][2] + "</Saleno>");
            sb.append("<Saleby>" + readData[u][3] + "</Saleby>");
            sb.append("<Saledate>" + readData[u][4] + "</Saledate>");
            sb.append("<Custname>" + readData[u][5] + "</Custname>");
            sb.append("<Status>" + readData[u][6] + "</Status>");
            sb.append("<Did>" + readData[0][1] + "</Did>");
            sb.append("</Delivery>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Deliverys>" + sb.toString() + "</Deliverys>");
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
  
  public static void loadDelivaryData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String txtSer = request.getParameter("txtSer");
      if (txtSer.equals("null"))
        txtSer = ""; 
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + 
        "-" + 
        month + 
        "-" + 
        DateUtil.totalDays(mon, 
          year);
      String sql = "SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),";
      sql = String.valueOf(sql) + 
        " a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
      sql = String.valueOf(sql) + " where a.DAT_SALEDATE>='" + fDate + "' ";
      sql = String.valueOf(sql) + " AND a.DAT_SALEDATE<='" + tDate + "' ";
      sql = String.valueOf(sql) + 
        " AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][2].toUpperCase().startsWith(
              txtSer.toUpperCase()) || 
            "0".equals(txtSer)) {
            sb.append("<Delivery>");
            sb.append("<Qno>" + readData[u][0] + "</Qno>");
            sb.append("<Custpurchaseno>" + readData[u][1] + 
                "</Custpurchaseno>");
            sb.append("<Saleno>" + readData[u][2] + "</Saleno>");
            sb.append("<Saleby>" + readData[u][3] + "</Saleby>");
            sb.append("<Saledate>" + readData[u][4] + "</Saledate>");
            sb.append("<Custname>" + readData[u][5] + "</Custname>");
            sb.append("<Status>" + readData[u][6] + "</Status>");
            sb.append("</Delivery>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Deliverys>" + sb.toString() + "</Deliverys>");
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
  
  public static void loadInvoiceData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String txtSer = request.getParameter("txtSer");
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + 
        "-" + 
        month + 
        "-" + 
        DateUtil.totalDays(mon, 
          year);
      String sql = " SELECT  a.CHR_QUOTATIONNO,a.CHR_INVOICENO,a.DT_INVOICEDATE,a.CHR_SALESORDERNO,";
      sql = String.valueOf(sql) + 
        " FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,a.CHR_INVOICESTATUS ";
      sql = String.valueOf(sql) + 
        " FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
      sql = String.valueOf(sql) + " where a.DAT_SALEDATE>='" + fDate + "'  ";
      sql = String.valueOf(sql) + " AND a.DAT_SALEDATE<='" + tDate + "' ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
      sql = String.valueOf(sql) + "  and CHR_DELIVERYSTATUS='Y' order by a.DAT_SALEDATE ";
      String[][] readData = 
        CommonInfo.KRecordSetArray(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][0].toUpperCase().startsWith(
              txtSer.toUpperCase()) || 
            "0".equals(txtSer)) {
            sb.append("<Invoice>");
            sb.append("<Quotationid>" + readData[u][0] + 
                "</Quotationid>");
            sb.append("<Invnumber>" + readData[u][1] + 
                "</Invnumber>");
            sb.append("<Invdate>" + readData[u][2] + "</Invdate>");
            sb.append("<SalesOrderNo>" + readData[u][3] + 
                "</SalesOrderNo>");
            sb.append("<Customername>" + readData[u][4] + 
                "</Customername>");
            sb.append("<Invstatus>" + readData[u][5] + 
                "</Invstatus>");
            sb.append("</Invoice>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<invoices>" + sb.toString() + "</invoices>");
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
  
  public static void loadCashSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      if (txtSer.equals("null"))
        txtSer = ""; 
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + 
        "-" + 
        month + 
        "-" + 
        DateUtil.totalDays(mon, 
          year);
      String sql = "SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS FROM inv_t_cashsales  where DAT_SALESDATE>='" + 
        
        fDate + 
        "' AND DAT_SALESDATE<='" + 
        tDate + 
        "' " + 
        " order by DAT_SALESDATE";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][2].toUpperCase().startsWith(
              txtSer.toUpperCase()) || 
            "0".equals(txtSer)) {
            sb.append("<cashSale>");
            sb.append("<salId>" + readData[u][0] + "</salId>");
            sb.append("<salNo>" + readData[u][1] + "</salNo>");
            sb.append("<salDate>" + readData[u][3] + "</salDate>");
            sb.append("<salTotal>" + readData[u][4] + "</salTotal>");
            if (!readData[u][2].equals("-")) {
              String csql = "Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID=" + 
                readData[u][2];
              String custName = 
                CommonInfo.stringGetAnySelectField(csql, 
                  "CHR_CUSTOMERNAME");
              sb.append("<quoCust>" + custName + "</quoCust>");
            } else {
              sb.append("<quoCust>-</quoCust>");
            } 
            sb.append("</cashSale>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<cashSales>" + sb.toString() + "</cashSales>");
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
  
  public static void loadDirectSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      txtSer = txtSer.toUpperCase();
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + 
        "-" + 
        month + 
        "-" + 
        DateUtil.totalDays(mon, 
          year);
      String sql = "SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,INT_SALESSTATUS FROM inv_t_directsales  where CHR_SALESTYPE='D' AND DAT_SALESDATE>='" + 
        
        fDate + 
        "' AND DAT_SALESDATE<='" + tDate + "' ";
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND CHR_SALESNO LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + "  order by DAT_SALESDATE";
      String[][] readData = 
        CommonFunction.RecordSetArray(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directSale>");
          sb.append("<salId>" + readData[u][0] + "</salId>");
          sb.append("<salNo>" + readData[u][1] + "</salNo>");
          sb.append("<salDate>" + readData[u][3] + "</salDate>");
          sb.append("<salTotal>" + readData[u][4] + "</salTotal>");
          String csql = "Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID=" + 
            readData[u][2];
          String custName = CommonInfo.stringGetAnySelectField(csql, 
              "CHR_CUSTOMERNAME");
          sb.append("<quoCust>" + custName + "</quoCust>");
          sb.append("<Status>" + readData[u][6] + "</Status>");
          sb.append("<PStatus>" + readData[u][5] + "</PStatus>");
          sb.append("</directSale>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<directSales>" + sb.toString() + "</directSales>");
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
  
  public static void loadDSwapSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: invokeinterface getSession : ()Ljavax/servlet/http/HttpSession;
    //   6: astore_2
    //   7: new java/lang/StringBuilder
    //   10: dup
    //   11: invokespecial <init> : ()V
    //   14: aload_2
    //   15: ldc_w 'BRANCHID'
    //   18: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   23: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   26: invokevirtual toString : ()Ljava/lang/String;
    //   29: astore_3
    //   30: new java/lang/StringBuilder
    //   33: dup
    //   34: invokespecial <init> : ()V
    //   37: aload_2
    //   38: ldc_w 'USRTYPE'
    //   41: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   46: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   49: invokevirtual toString : ()Ljava/lang/String;
    //   52: astore #4
    //   54: new java/lang/StringBuilder
    //   57: dup
    //   58: invokespecial <init> : ()V
    //   61: aload_0
    //   62: ldc_w 'txtSer'
    //   65: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   70: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   73: invokevirtual toString : ()Ljava/lang/String;
    //   76: astore #5
    //   78: aload #5
    //   80: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   83: astore #5
    //   85: aload_0
    //   86: ldc_w 'month'
    //   89: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   94: astore #6
    //   96: new java/lang/StringBuilder
    //   99: dup
    //   100: invokespecial <init> : ()V
    //   103: aload_0
    //   104: ldc_w 'customer'
    //   107: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   112: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   115: invokevirtual toString : ()Ljava/lang/String;
    //   118: astore #7
    //   120: new java/lang/StringBuilder
    //   123: dup
    //   124: invokespecial <init> : ()V
    //   127: aload_0
    //   128: ldc_w 'division'
    //   131: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   136: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   139: invokevirtual toString : ()Ljava/lang/String;
    //   142: astore #8
    //   144: aload_0
    //   145: ldc_w 'year'
    //   148: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   153: invokestatic parseInt : (Ljava/lang/String;)I
    //   156: istore #9
    //   158: aload_0
    //   159: ldc_w 'day'
    //   162: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   167: astore #10
    //   169: aload_0
    //   170: ldc_w 'delivery'
    //   173: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   178: astore #11
    //   180: aload_0
    //   181: ldc_w 'type'
    //   184: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   189: astore #12
    //   191: aload_0
    //   192: ldc_w 'cancel'
    //   195: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   200: astore #13
    //   202: aload_0
    //   203: ldc_w 'taxtype'
    //   206: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   211: astore #14
    //   213: ldc_w '-'
    //   216: astore #15
    //   218: ldc_w 'F'
    //   221: aload #4
    //   223: invokevirtual equals : (Ljava/lang/Object;)Z
    //   226: ifne -> 263
    //   229: ldc_w 'SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1'
    //   232: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   235: iconst_0
    //   236: aaload
    //   237: iconst_0
    //   238: aaload
    //   239: ldc_w ','
    //   242: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   245: aload_2
    //   246: ldc_w 'USRID'
    //   249: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   254: invokevirtual toString : ()Ljava/lang/String;
    //   257: invokestatic contains : ([Ljava/lang/Object;Ljava/lang/Object;)Z
    //   260: ifeq -> 268
    //   263: ldc_w 'F'
    //   266: astore #15
    //   268: ldc ''
    //   270: astore #16
    //   272: ldc_w ' SELECT a.INT_SALESID,a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') ,'
    //   275: astore #16
    //   277: new java/lang/StringBuilder
    //   280: dup
    //   281: aload #16
    //   283: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   286: invokespecial <init> : (Ljava/lang/String;)V
    //   289: ldc_w ' a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS,a.INT_SALESSTATUS,'
    //   292: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   295: invokevirtual toString : ()Ljava/lang/String;
    //   298: astore #16
    //   300: new java/lang/StringBuilder
    //   303: dup
    //   304: aload #16
    //   306: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   309: invokespecial <init> : (Ljava/lang/String;)V
    //   312: ldc_w '  FUN_INV_GET_PAYMENTCOMMITMENTCOUNT(a.CHR_SALESNO ), '
    //   315: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   318: invokevirtual toString : ()Ljava/lang/String;
    //   321: astore #16
    //   323: new java/lang/StringBuilder
    //   326: dup
    //   327: aload #16
    //   329: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   332: invokespecial <init> : (Ljava/lang/String;)V
    //   335: ldc_w ' a.DOU_TOTALAMOUNT,  FUN_INV_GET_STAFFNAMEBYUSERNAME(a.CHR_USRNAME), '
    //   338: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   341: invokevirtual toString : ()Ljava/lang/String;
    //   344: astore #16
    //   346: new java/lang/StringBuilder
    //   349: dup
    //   350: aload #16
    //   352: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   355: invokespecial <init> : (Ljava/lang/String;)V
    //   358: ldc_w ' a.CHR_INVOICEBLOCK,a.CHR_SALESTYPE,a.CHR_DELIVERY,DATEDIFF(DATE(a.DAT_COURIERDATE),a.DAT_SALESDATE),a.CHR_CANCEL,   '
    //   361: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   364: invokevirtual toString : ()Ljava/lang/String;
    //   367: astore #16
    //   369: new java/lang/StringBuilder
    //   372: dup
    //   373: aload #16
    //   375: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   378: invokespecial <init> : (Ljava/lang/String;)V
    //   381: ldc_w ' FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_CPONUMBER ,'
    //   384: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   387: invokevirtual toString : ()Ljava/lang/String;
    //   390: astore #16
    //   392: new java/lang/StringBuilder
    //   395: dup
    //   396: aload #16
    //   398: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   401: invokespecial <init> : (Ljava/lang/String;)V
    //   404: ldc_w ' (NOW() > DATE_ADD(a.DAT_SALESDATE, INTERVAL (SELECT INT_INVOCECHANGES FROM m_inventorysetting WHERE INT_ROWID= 1) DAY ))  dd'
    //   407: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   410: invokevirtual toString : ()Ljava/lang/String;
    //   413: astore #16
    //   415: new java/lang/StringBuilder
    //   418: dup
    //   419: aload #16
    //   421: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   424: invokespecial <init> : (Ljava/lang/String;)V
    //   427: ldc_w ' ,IF(CHR_GST_TYPE='S','State','Central'),CHR_DISCOUNTBILL FROM inv_t_directsales  a ,inv_m_customerinfo b   '
    //   430: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   433: invokevirtual toString : ()Ljava/lang/String;
    //   436: astore #16
    //   438: new java/lang/StringBuilder
    //   441: dup
    //   442: aload #16
    //   444: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   447: invokespecial <init> : (Ljava/lang/String;)V
    //   450: ldc_w ' where  a.INT_CUSTOMERID = b.INT_CUSTOMERID   '
    //   453: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   456: invokevirtual toString : ()Ljava/lang/String;
    //   459: astore #16
    //   461: ldc '0'
    //   463: aload #6
    //   465: invokevirtual equals : (Ljava/lang/Object;)Z
    //   468: ifne -> 499
    //   471: new java/lang/StringBuilder
    //   474: dup
    //   475: aload #16
    //   477: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   480: invokespecial <init> : (Ljava/lang/String;)V
    //   483: ldc_w ' AND MONTH(a.DAT_SALESDATE) ='
    //   486: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   489: aload #6
    //   491: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   494: invokevirtual toString : ()Ljava/lang/String;
    //   497: astore #16
    //   499: ldc '0'
    //   501: iload #9
    //   503: invokestatic valueOf : (I)Ljava/lang/Integer;
    //   506: invokevirtual equals : (Ljava/lang/Object;)Z
    //   509: ifne -> 540
    //   512: new java/lang/StringBuilder
    //   515: dup
    //   516: aload #16
    //   518: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   521: invokespecial <init> : (Ljava/lang/String;)V
    //   524: ldc_w ' AND YEAR(a.DAT_SALESDATE) ='
    //   527: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   530: iload #9
    //   532: invokevirtual append : (I)Ljava/lang/StringBuilder;
    //   535: invokevirtual toString : ()Ljava/lang/String;
    //   538: astore #16
    //   540: ldc '0'
    //   542: aload #11
    //   544: invokevirtual equals : (Ljava/lang/Object;)Z
    //   547: ifne -> 584
    //   550: new java/lang/StringBuilder
    //   553: dup
    //   554: aload #16
    //   556: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   559: invokespecial <init> : (Ljava/lang/String;)V
    //   562: ldc_w ' AND  a.CHR_DELIVERY  = ''
    //   565: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   568: aload #11
    //   570: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   573: ldc_w '' '
    //   576: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   579: invokevirtual toString : ()Ljava/lang/String;
    //   582: astore #16
    //   584: ldc '0'
    //   586: aload #13
    //   588: invokevirtual equals : (Ljava/lang/Object;)Z
    //   591: ifne -> 628
    //   594: new java/lang/StringBuilder
    //   597: dup
    //   598: aload #16
    //   600: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   603: invokespecial <init> : (Ljava/lang/String;)V
    //   606: ldc_w ' AND  a.CHR_CANCEL  = ''
    //   609: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   612: aload #13
    //   614: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   617: ldc_w '' '
    //   620: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   623: invokevirtual toString : ()Ljava/lang/String;
    //   626: astore #16
    //   628: ldc '0'
    //   630: aload #10
    //   632: invokevirtual equals : (Ljava/lang/Object;)Z
    //   635: ifne -> 666
    //   638: new java/lang/StringBuilder
    //   641: dup
    //   642: aload #16
    //   644: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   647: invokespecial <init> : (Ljava/lang/String;)V
    //   650: ldc_w ' AND DAY(a.DAT_SALESDATE)='
    //   653: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   656: aload #10
    //   658: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   661: invokevirtual toString : ()Ljava/lang/String;
    //   664: astore #16
    //   666: ldc '0'
    //   668: aload #7
    //   670: invokevirtual equals : (Ljava/lang/Object;)Z
    //   673: ifne -> 704
    //   676: new java/lang/StringBuilder
    //   679: dup
    //   680: aload #16
    //   682: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   685: invokespecial <init> : (Ljava/lang/String;)V
    //   688: ldc_w '  AND a.INT_CUSTOMERID = '
    //   691: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   694: aload #7
    //   696: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   699: invokevirtual toString : ()Ljava/lang/String;
    //   702: astore #16
    //   704: ldc '0'
    //   706: aload #8
    //   708: invokevirtual equals : (Ljava/lang/Object;)Z
    //   711: ifne -> 742
    //   714: new java/lang/StringBuilder
    //   717: dup
    //   718: aload #16
    //   720: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   723: invokespecial <init> : (Ljava/lang/String;)V
    //   726: ldc_w '  AND a.INT_DIVIID = '
    //   729: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   732: aload #8
    //   734: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   737: invokevirtual toString : ()Ljava/lang/String;
    //   740: astore #16
    //   742: ldc_w 'S'
    //   745: aload #14
    //   747: invokevirtual equals : (Ljava/lang/Object;)Z
    //   750: ifeq -> 779
    //   753: new java/lang/StringBuilder
    //   756: dup
    //   757: aload #16
    //   759: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   762: invokespecial <init> : (Ljava/lang/String;)V
    //   765: ldc_w '  AND a.CHR_GST_TYPE = 'S''
    //   768: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   771: invokevirtual toString : ()Ljava/lang/String;
    //   774: astore #16
    //   776: goto -> 813
    //   779: ldc_w 'D'
    //   782: aload #14
    //   784: invokevirtual equals : (Ljava/lang/Object;)Z
    //   787: ifeq -> 813
    //   790: new java/lang/StringBuilder
    //   793: dup
    //   794: aload #16
    //   796: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   799: invokespecial <init> : (Ljava/lang/String;)V
    //   802: ldc_w '  AND a.CHR_GST_TYPE = 'D''
    //   805: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   808: invokevirtual toString : ()Ljava/lang/String;
    //   811: astore #16
    //   813: ldc_w '1'
    //   816: aload #12
    //   818: invokevirtual equals : (Ljava/lang/Object;)Z
    //   821: ifeq -> 873
    //   824: ldc '0'
    //   826: aload #5
    //   828: invokevirtual equals : (Ljava/lang/Object;)Z
    //   831: ifne -> 921
    //   834: new java/lang/StringBuilder
    //   837: dup
    //   838: aload #16
    //   840: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   843: invokespecial <init> : (Ljava/lang/String;)V
    //   846: ldc_w ' AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE ''
    //   849: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   852: aload #5
    //   854: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   857: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   860: ldc '%''
    //   862: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   865: invokevirtual toString : ()Ljava/lang/String;
    //   868: astore #16
    //   870: goto -> 921
    //   873: new java/lang/StringBuilder
    //   876: dup
    //   877: aload #16
    //   879: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   882: invokespecial <init> : (Ljava/lang/String;)V
    //   885: ldc_w ' AND ( (a.CHR_SALESNO LIKE '%'
    //   888: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   891: aload #5
    //   893: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   896: ldc_w '%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE ''
    //   899: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   902: aload #5
    //   904: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   907: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   910: ldc_w '%') )'
    //   913: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   916: invokevirtual toString : ()Ljava/lang/String;
    //   919: astore #16
    //   921: new java/lang/StringBuilder
    //   924: dup
    //   925: aload #16
    //   927: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   930: invokespecial <init> : (Ljava/lang/String;)V
    //   933: ldc_w '   GROUP BY  a.INT_SALESID '
    //   936: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   939: invokevirtual toString : ()Ljava/lang/String;
    //   942: astore #16
    //   944: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   947: aload #16
    //   949: invokevirtual println : (Ljava/lang/String;)V
    //   952: aload #16
    //   954: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   957: astore #17
    //   959: new java/lang/StringBuffer
    //   962: dup
    //   963: invokespecial <init> : ()V
    //   966: astore #18
    //   968: aload #17
    //   970: arraylength
    //   971: ifle -> 1872
    //   974: iconst_0
    //   975: istore #19
    //   977: goto -> 1780
    //   980: aload #18
    //   982: ldc_w '<directSale>'
    //   985: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   988: pop
    //   989: aload #18
    //   991: new java/lang/StringBuilder
    //   994: dup
    //   995: ldc_w '<salId>'
    //   998: invokespecial <init> : (Ljava/lang/String;)V
    //   1001: aload #17
    //   1003: iload #19
    //   1005: aaload
    //   1006: iconst_0
    //   1007: aaload
    //   1008: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1011: ldc_w '</salId>'
    //   1014: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1017: invokevirtual toString : ()Ljava/lang/String;
    //   1020: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1023: pop
    //   1024: aload #18
    //   1026: new java/lang/StringBuilder
    //   1029: dup
    //   1030: ldc_w '<salNo>'
    //   1033: invokespecial <init> : (Ljava/lang/String;)V
    //   1036: aload #17
    //   1038: iload #19
    //   1040: aaload
    //   1041: iconst_1
    //   1042: aaload
    //   1043: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1046: ldc_w '</salNo>'
    //   1049: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1052: invokevirtual toString : ()Ljava/lang/String;
    //   1055: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1058: pop
    //   1059: aload #18
    //   1061: new java/lang/StringBuilder
    //   1064: dup
    //   1065: ldc_w '<salDate>'
    //   1068: invokespecial <init> : (Ljava/lang/String;)V
    //   1071: aload #17
    //   1073: iload #19
    //   1075: aaload
    //   1076: iconst_3
    //   1077: aaload
    //   1078: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1081: ldc_w '</salDate>'
    //   1084: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1087: invokevirtual toString : ()Ljava/lang/String;
    //   1090: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1093: pop
    //   1094: aload #18
    //   1096: new java/lang/StringBuilder
    //   1099: dup
    //   1100: ldc_w '<salTotal>'
    //   1103: invokespecial <init> : (Ljava/lang/String;)V
    //   1106: aload #17
    //   1108: iload #19
    //   1110: aaload
    //   1111: iconst_4
    //   1112: aaload
    //   1113: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1116: ldc_w '</salTotal>'
    //   1119: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1122: invokevirtual toString : ()Ljava/lang/String;
    //   1125: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1128: pop
    //   1129: aload #18
    //   1131: new java/lang/StringBuilder
    //   1134: dup
    //   1135: ldc_w '<quoCust>'
    //   1138: invokespecial <init> : (Ljava/lang/String;)V
    //   1141: aload #17
    //   1143: iload #19
    //   1145: aaload
    //   1146: iconst_2
    //   1147: aaload
    //   1148: ldc '&'
    //   1150: ldc_w '9865043008'
    //   1153: invokevirtual replace : (Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    //   1156: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1159: ldc_w '</quoCust>'
    //   1162: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1165: invokevirtual toString : ()Ljava/lang/String;
    //   1168: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1171: pop
    //   1172: aload #18
    //   1174: new java/lang/StringBuilder
    //   1177: dup
    //   1178: ldc_w '<Status>'
    //   1181: invokespecial <init> : (Ljava/lang/String;)V
    //   1184: aload #17
    //   1186: iload #19
    //   1188: aaload
    //   1189: bipush #6
    //   1191: aaload
    //   1192: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1195: ldc_w '</Status>'
    //   1198: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1201: invokevirtual toString : ()Ljava/lang/String;
    //   1204: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1207: pop
    //   1208: aload #18
    //   1210: new java/lang/StringBuilder
    //   1213: dup
    //   1214: ldc_w '<PStatus>'
    //   1217: invokespecial <init> : (Ljava/lang/String;)V
    //   1220: aload #17
    //   1222: iload #19
    //   1224: aaload
    //   1225: iconst_5
    //   1226: aaload
    //   1227: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1230: ldc_w '</PStatus>'
    //   1233: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1236: invokevirtual toString : ()Ljava/lang/String;
    //   1239: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1242: pop
    //   1243: aload #18
    //   1245: new java/lang/StringBuilder
    //   1248: dup
    //   1249: ldc_w '<PayCommitment>'
    //   1252: invokespecial <init> : (Ljava/lang/String;)V
    //   1255: aload #17
    //   1257: iload #19
    //   1259: aaload
    //   1260: bipush #7
    //   1262: aaload
    //   1263: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1266: ldc_w '</PayCommitment>'
    //   1269: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1272: invokevirtual toString : ()Ljava/lang/String;
    //   1275: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1278: pop
    //   1279: aload #18
    //   1281: new java/lang/StringBuilder
    //   1284: dup
    //   1285: ldc_w '<Entryby>'
    //   1288: invokespecial <init> : (Ljava/lang/String;)V
    //   1291: aload #17
    //   1293: iload #19
    //   1295: aaload
    //   1296: bipush #9
    //   1298: aaload
    //   1299: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1302: ldc_w '</Entryby>'
    //   1305: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1308: invokevirtual toString : ()Ljava/lang/String;
    //   1311: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1314: pop
    //   1315: aload #18
    //   1317: new java/lang/StringBuilder
    //   1320: dup
    //   1321: ldc_w '<Block>'
    //   1324: invokespecial <init> : (Ljava/lang/String;)V
    //   1327: aload #17
    //   1329: iload #19
    //   1331: aaload
    //   1332: bipush #10
    //   1334: aaload
    //   1335: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1338: ldc_w '</Block>'
    //   1341: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1344: invokevirtual toString : ()Ljava/lang/String;
    //   1347: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1350: pop
    //   1351: aload #18
    //   1353: new java/lang/StringBuilder
    //   1356: dup
    //   1357: ldc_w '<Saletype>'
    //   1360: invokespecial <init> : (Ljava/lang/String;)V
    //   1363: aload #17
    //   1365: iload #19
    //   1367: aaload
    //   1368: bipush #11
    //   1370: aaload
    //   1371: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1374: ldc_w '</Saletype>'
    //   1377: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1380: invokevirtual toString : ()Ljava/lang/String;
    //   1383: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1386: pop
    //   1387: aload #18
    //   1389: new java/lang/StringBuilder
    //   1392: dup
    //   1393: ldc_w '<Courier>'
    //   1396: invokespecial <init> : (Ljava/lang/String;)V
    //   1399: aload #17
    //   1401: iload #19
    //   1403: aaload
    //   1404: bipush #12
    //   1406: aaload
    //   1407: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1410: ldc_w '</Courier>'
    //   1413: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1416: invokevirtual toString : ()Ljava/lang/String;
    //   1419: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1422: pop
    //   1423: aload #18
    //   1425: new java/lang/StringBuilder
    //   1428: dup
    //   1429: ldc_w '<Courierdiff>'
    //   1432: invokespecial <init> : (Ljava/lang/String;)V
    //   1435: aload #17
    //   1437: iload #19
    //   1439: aaload
    //   1440: bipush #13
    //   1442: aaload
    //   1443: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1446: ldc_w '</Courierdiff>'
    //   1449: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1452: invokevirtual toString : ()Ljava/lang/String;
    //   1455: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1458: pop
    //   1459: aload #18
    //   1461: new java/lang/StringBuilder
    //   1464: dup
    //   1465: ldc_w '<Cancel>'
    //   1468: invokespecial <init> : (Ljava/lang/String;)V
    //   1471: aload #17
    //   1473: iload #19
    //   1475: aaload
    //   1476: bipush #14
    //   1478: aaload
    //   1479: invokevirtual trim : ()Ljava/lang/String;
    //   1482: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1485: ldc_w '</Cancel>'
    //   1488: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1491: invokevirtual toString : ()Ljava/lang/String;
    //   1494: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1497: pop
    //   1498: aload #18
    //   1500: new java/lang/StringBuilder
    //   1503: dup
    //   1504: ldc_w '<Division>'
    //   1507: invokespecial <init> : (Ljava/lang/String;)V
    //   1510: aload #17
    //   1512: iload #19
    //   1514: aaload
    //   1515: bipush #15
    //   1517: aaload
    //   1518: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1521: ldc_w '</Division>'
    //   1524: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1527: invokevirtual toString : ()Ljava/lang/String;
    //   1530: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1533: pop
    //   1534: aload #18
    //   1536: new java/lang/StringBuilder
    //   1539: dup
    //   1540: ldc_w '<CPO>'
    //   1543: invokespecial <init> : (Ljava/lang/String;)V
    //   1546: aload #17
    //   1548: iload #19
    //   1550: aaload
    //   1551: bipush #16
    //   1553: aaload
    //   1554: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1557: ldc_w '</CPO>'
    //   1560: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1563: invokevirtual toString : ()Ljava/lang/String;
    //   1566: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1569: pop
    //   1570: aload #18
    //   1572: new java/lang/StringBuilder
    //   1575: dup
    //   1576: ldc_w '<Dtcheck>'
    //   1579: invokespecial <init> : (Ljava/lang/String;)V
    //   1582: aload #17
    //   1584: iload #19
    //   1586: aaload
    //   1587: bipush #17
    //   1589: aaload
    //   1590: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1593: ldc_w '</Dtcheck>'
    //   1596: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1599: invokevirtual toString : ()Ljava/lang/String;
    //   1602: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1605: pop
    //   1606: aload #18
    //   1608: new java/lang/StringBuilder
    //   1611: dup
    //   1612: ldc_w '<Taxtype>'
    //   1615: invokespecial <init> : (Ljava/lang/String;)V
    //   1618: aload #17
    //   1620: iload #19
    //   1622: aaload
    //   1623: bipush #18
    //   1625: aaload
    //   1626: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1629: ldc_w '</Taxtype>'
    //   1632: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1635: invokevirtual toString : ()Ljava/lang/String;
    //   1638: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1641: pop
    //   1642: aload #18
    //   1644: new java/lang/StringBuilder
    //   1647: dup
    //   1648: ldc_w '<Discount>'
    //   1651: invokespecial <init> : (Ljava/lang/String;)V
    //   1654: aload #17
    //   1656: iload #19
    //   1658: aaload
    //   1659: bipush #19
    //   1661: aaload
    //   1662: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1665: ldc_w '</Discount>'
    //   1668: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1671: invokevirtual toString : ()Ljava/lang/String;
    //   1674: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1677: pop
    //   1678: aload #18
    //   1680: new java/lang/StringBuilder
    //   1683: dup
    //   1684: ldc_w '<Usertype>'
    //   1687: invokespecial <init> : (Ljava/lang/String;)V
    //   1690: aload #15
    //   1692: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1695: ldc_w '</Usertype>'
    //   1698: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1701: invokevirtual toString : ()Ljava/lang/String;
    //   1704: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1707: pop
    //   1708: aload #18
    //   1710: new java/lang/StringBuilder
    //   1713: dup
    //   1714: ldc_w '<CpyShortName>'
    //   1717: invokespecial <init> : (Ljava/lang/String;)V
    //   1720: new java/lang/StringBuilder
    //   1723: dup
    //   1724: ldc_w 'SELECT CHR_SHORTNAME from com_m_company  WHERE INT_COMPANYID='
    //   1727: invokespecial <init> : (Ljava/lang/String;)V
    //   1730: aload_2
    //   1731: ldc_w 'INVCOMPANY'
    //   1734: invokeinterface getAttribute : (Ljava/lang/String;)Ljava/lang/Object;
    //   1739: invokevirtual append : (Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   1742: invokevirtual toString : ()Ljava/lang/String;
    //   1745: invokestatic QueryExecute : (Ljava/lang/String;)[[Ljava/lang/String;
    //   1748: iconst_0
    //   1749: aaload
    //   1750: iconst_0
    //   1751: aaload
    //   1752: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1755: ldc_w '</CpyShortName>'
    //   1758: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1761: invokevirtual toString : ()Ljava/lang/String;
    //   1764: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1767: pop
    //   1768: aload #18
    //   1770: ldc_w '</directSale>'
    //   1773: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   1776: pop
    //   1777: iinc #19, 1
    //   1780: iload #19
    //   1782: aload #17
    //   1784: arraylength
    //   1785: if_icmplt -> 980
    //   1788: aload_1
    //   1789: ldc 'text/xml'
    //   1791: invokeinterface setContentType : (Ljava/lang/String;)V
    //   1796: aload_1
    //   1797: ldc 'Cache-Control'
    //   1799: ldc 'no-cache'
    //   1801: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   1806: aload_1
    //   1807: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   1812: new java/lang/StringBuilder
    //   1815: dup
    //   1816: ldc_w '<directSales>'
    //   1819: invokespecial <init> : (Ljava/lang/String;)V
    //   1822: aload #18
    //   1824: invokevirtual toString : ()Ljava/lang/String;
    //   1827: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1830: ldc_w '</directSales>'
    //   1833: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1836: invokevirtual toString : ()Ljava/lang/String;
    //   1839: invokevirtual write : (Ljava/lang/String;)V
    //   1842: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   1845: new java/lang/StringBuilder
    //   1848: dup
    //   1849: ldc_w '============='
    //   1852: invokespecial <init> : (Ljava/lang/String;)V
    //   1855: aload #18
    //   1857: invokevirtual toString : ()Ljava/lang/String;
    //   1860: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   1863: invokevirtual toString : ()Ljava/lang/String;
    //   1866: invokevirtual println : (Ljava/lang/String;)V
    //   1869: goto -> 1924
    //   1872: aload_1
    //   1873: sipush #204
    //   1876: invokeinterface setStatus : (I)V
    //   1881: goto -> 1924
    //   1884: astore_2
    //   1885: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   1888: aload_2
    //   1889: invokevirtual getMessage : ()Ljava/lang/String;
    //   1892: invokevirtual println : (Ljava/lang/String;)V
    //   1895: aload_0
    //   1896: ldc 'error'
    //   1898: aload_2
    //   1899: invokevirtual getMessage : ()Ljava/lang/String;
    //   1902: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   1907: aload_0
    //   1908: ldc '/error/index.jsp'
    //   1910: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   1915: astore_3
    //   1916: aload_3
    //   1917: aload_0
    //   1918: aload_1
    //   1919: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   1924: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #7360	-> 0
    //   #7361	-> 7
    //   #7362	-> 30
    //   #7363	-> 54
    //   #7364	-> 78
    //   #7365	-> 85
    //   #7366	-> 96
    //   #7367	-> 120
    //   #7368	-> 144
    //   #7369	-> 158
    //   #7370	-> 169
    //   #7371	-> 180
    //   #7372	-> 191
    //   #7373	-> 202
    //   #7375	-> 213
    //   #7376	-> 218
    //   #7380	-> 229
    //   #7379	-> 236
    //   #7380	-> 237
    //   #7379	-> 238
    //   #7381	-> 239
    //   #7382	-> 245
    //   #7378	-> 257
    //   #7382	-> 260
    //   #7383	-> 263
    //   #7385	-> 268
    //   #7386	-> 272
    //   #7387	-> 277
    //   #7389	-> 300
    //   #7390	-> 323
    //   #7391	-> 346
    //   #7392	-> 369
    //   #7393	-> 392
    //   #7395	-> 415
    //   #7396	-> 438
    //   #7400	-> 461
    //   #7401	-> 471
    //   #7403	-> 499
    //   #7404	-> 512
    //   #7406	-> 540
    //   #7407	-> 550
    //   #7409	-> 584
    //   #7410	-> 594
    //   #7412	-> 628
    //   #7413	-> 638
    //   #7415	-> 666
    //   #7416	-> 676
    //   #7417	-> 704
    //   #7418	-> 714
    //   #7420	-> 742
    //   #7421	-> 753
    //   #7422	-> 779
    //   #7423	-> 790
    //   #7425	-> 813
    //   #7427	-> 824
    //   #7428	-> 834
    //   #7429	-> 870
    //   #7432	-> 873
    //   #7434	-> 921
    //   #7437	-> 944
    //   #7439	-> 952
    //   #7440	-> 959
    //   #7442	-> 968
    //   #7443	-> 974
    //   #7444	-> 980
    //   #7445	-> 989
    //   #7446	-> 1024
    //   #7447	-> 1059
    //   #7448	-> 1094
    //   #7449	-> 1129
    //   #7450	-> 1172
    //   #7451	-> 1208
    //   #7452	-> 1243
    //   #7453	-> 1279
    //   #7454	-> 1315
    //   #7455	-> 1351
    //   #7456	-> 1387
    //   #7457	-> 1423
    //   #7458	-> 1459
    //   #7459	-> 1498
    //   #7460	-> 1534
    //   #7461	-> 1570
    //   #7462	-> 1606
    //   #7463	-> 1642
    //   #7464	-> 1678
    //   #7465	-> 1708
    //   #7466	-> 1768
    //   #7443	-> 1777
    //   #7468	-> 1788
    //   #7469	-> 1796
    //   #7470	-> 1806
    //   #7471	-> 1812
    //   #7470	-> 1839
    //   #7472	-> 1842
    //   #7473	-> 1869
    //   #7474	-> 1872
    //   #7476	-> 1881
    //   #7477	-> 1885
    //   #7478	-> 1895
    //   #7479	-> 1907
    //   #7480	-> 1908
    //   #7479	-> 1915
    //   #7481	-> 1916
    //   #7483	-> 1924
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	1925	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	1925	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   7	1874	2	session	Ljavax/servlet/http/HttpSession;
    //   30	1851	3	branchid	Ljava/lang/String;
    //   54	1827	4	usertype	Ljava/lang/String;
    //   78	1803	5	txtSer	Ljava/lang/String;
    //   96	1785	6	month	Ljava/lang/String;
    //   120	1761	7	customer	Ljava/lang/String;
    //   144	1737	8	division	Ljava/lang/String;
    //   158	1723	9	year	I
    //   169	1712	10	day	Ljava/lang/String;
    //   180	1701	11	delivery	Ljava/lang/String;
    //   191	1690	12	type	Ljava/lang/String;
    //   202	1679	13	cancel	Ljava/lang/String;
    //   213	1668	14	taxtype	Ljava/lang/String;
    //   218	1663	15	Usertype	Ljava/lang/String;
    //   272	1609	16	query	Ljava/lang/String;
    //   959	922	17	readData	[[Ljava/lang/String;
    //   968	913	18	sb	Ljava/lang/StringBuffer;
    //   977	811	19	u	I
    //   1885	39	2	e	Ljava/lang/Exception;
    //   1916	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	1881	1884	java/lang/Exception
  }
  
  public static void loadDACCSwapSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      txtSer = txtSer.toUpperCase();
      String month = request.getParameter("month");
      String customer = request.getParameter("customer");
      String division = request.getParameter("division");
      String Aflag = request.getParameter("Aflag");
      String Accbranch = request.getParameter("Accbranch");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String sql = " SELECT a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), (if(a.CHR_PAYMENTSTATUS ='Y' , 'Paid' ,'Pending'  )) ,";
      sql = String.valueOf(sql) + "  a.CHR_ACCOUNTFLAG  ,d.CHR_BRANCHNAME,a.DOU_TOTALAMOUNT,a.CHR_CANCEL,CONCAT('DR-',b.INT_CUSTOMERGROUPID),FUN_INV_DIVISION(a.INT_DIVIID)    FROM inv_t_directsales a , inv_m_customerinfo b , com_m_branch d ";
      sql = String.valueOf(sql) + " where b.INT_CUSTOMERID = a.INT_CUSTOMERID AND a.INT_BRANCHID =d.INT_BRANCHID AND a.INT_SALESSTATUS=1 ";
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE) =" + mon; 
      sql = String.valueOf(sql) + " AND year(a.DAT_SALESDATE)=" + year;
      if (!"0".equals(Accbranch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID = " + Accbranch; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(Aflag))
        if ("1".equals(Aflag)) {
          sql = String.valueOf(sql) + "  AND a.CHR_ACCOUNTFLAG ='Y'";
        } else {
          sql = String.valueOf(sql) + "  AND a.CHR_ACCOUNTFLAG ='N'";
        }  
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + " order by    SUBSTRING_INDEX( a.CHR_SALESNO, '/',1) , a.DAT_SALESDATE DESC ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      String filepath = request.getRealPath("/");
      File f = null;
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directSale>");
          sb.append("<salesno>" + readData[u][0] + "</salesno>");
          sb.append("<custname>" + readData[u][1].trim().replace("&", "98650") + "</custname>");
          sb.append("<saledate>" + readData[u][2] + "</saledate>");
          sb.append("<PStatus>" + readData[u][3] + "</PStatus>");
          sb.append("<InvoiceStatus>" + readData[u][4] + "</InvoiceStatus>");
          sb.append("<Branch>" + readData[u][5] + "</Branch>");
          sb.append("<NetAmount>" + readData[u][6] + "</NetAmount>");
          sb.append("<Cancel>" + readData[u][7] + "</Cancel>");
          sb.append("<Alias>" + readData[u][8] + "</Alias>");
          sb.append("<Division>" + readData[u][9] + "</Division>");
          f = new File(String.valueOf(filepath) + "uploadfiles/DCIMAGE/" + readData[u][0].replaceAll("/", "_") + ".pdf");
          if (f.exists()) {
            sb.append("<Download>Y</Download>");
          } else {
            sb.append("<Download>N</Download>");
          } 
          sb.append("</directSale>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
  
  public static void INVACCServiceBill(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      txtSer = txtSer.toUpperCase();
      String month = request.getParameter("month");
      String customer = request.getParameter("customer");
      String division = request.getParameter("division");
      String Aflag = request.getParameter("Aflag");
      String Accbranch = request.getParameter("Accbranch");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String sql = " SELECT a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " a.CHR_PAYMENTSTATUS ,a.CHR_ACCOUNTFLAG ,d.CHR_BRANCHNAME,a.DOU_NETAMOUNT ,a.CHR_CANCEL ,CONCAT('DR-',b.INT_CUSTOMERGROUPID),FUN_INV_DIVISION(a.INT_DIVIID)";
      sql = String.valueOf(sql) + " FROM inv_t_servicebilling a , inv_m_customerinfo b , com_m_branch d ";
      sql = String.valueOf(sql) + " where b.INT_CUSTOMERID = a.INT_CUSTOMERID AND a.INT_BRANCHID =d.INT_BRANCHID ";
      if (!"0".equals(Accbranch))
        sql = String.valueOf(sql) + "  AND a.INT_BRANCHID = " + Accbranch; 
      if ("1".equals(Aflag)) {
        sql = String.valueOf(sql) + "  AND a.CHR_ACCOUNTFLAG ='Y'";
      } else if ("2".equals(Aflag)) {
        sql = String.valueOf(sql) + "  AND a.CHR_ACCOUNTFLAG ='N'";
      } 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + "  AND a.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + "   AND  a.INT_DIVIID = " + division; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND month(a.DAT_SALESDATE) =" + mon; 
      sql = String.valueOf(sql) + " AND year(a.DAT_SALESDATE)=" + year;
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + " order by SUBSTRING_INDEX(a.CHR_SALESNO, '/',1) , a.DAT_SALESDATE DESC ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      String filepath = request.getRealPath("/");
      File f = null;
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directSale>");
          sb.append("<salesno>" + readData[u][0] + "</salesno>");
          sb.append("<custname>" + readData[u][1].trim().replace("&", "98650") + "</custname>");
          sb.append("<saledate>" + readData[u][2] + "</saledate>");
          f = new File(String.valueOf(filepath) + "uploadfiles/DCIMAGE/" + readData[u][0].replaceAll("/", "_") + ".pdf");
          if (f.exists()) {
            sb.append("<Download>Y</Download>");
          } else {
            sb.append("<Download>N</Download>");
          } 
          if ("Y".equalsIgnoreCase(readData[u][3])) {
            sb.append("<PStatus>Paid</PStatus>");
          } else {
            sb.append("<PStatus>Pending</PStatus>");
          } 
          sb.append("<InvoiceStatus>" + readData[u][4] + "</InvoiceStatus>");
          sb.append("<Branch>" + readData[u][5] + "</Branch>");
          sb.append("<NetAmount>" + readData[u][6] + "</NetAmount>");
          sb.append("<Cancel>" + readData[u][7] + "</Cancel>");
          sb.append("<Alias>" + readData[u][8] + "</Alias>");
          sb.append("<Division>" + readData[u][9] + "</Division>");
          sb.append("</directSale>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
  
  public static void loadDirectPurchase(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object1 = session.getAttribute("BRANCHID");
      Object object2 = session.getAttribute("USRTYPE");
      String txtSer = request.getParameter("txtSer");
      String month = request.getParameter("month");
      String vendor = request.getParameter("vendor");
      String division = request.getParameter("division");
      String cancel = request.getParameter("cancel");
      String taxtype = request.getParameter("taxtype");
      System.out.println("-----" + taxtype);
      String ssql = "";
      String day = request.getParameter("day");
      int year = Integer.parseInt(request.getParameter("year"));
      String sql = " SELECT a.INT_PURCHASEORDERID,a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') , ";
      sql = String.valueOf(sql) + " a.DOU_TOTALAMOUNT, if(a.CHR_PAYMENTSTATUS='Y','Paid','Pending') ,a.CHR_FLAG,a.CHR_SALEFLAG,a.DOU_TOTALAMOUNT,a.CHR_POREQUESTNO,a.CHR_CANCEL, ";
      sql = String.valueOf(sql) + " FUN_INV_DIVISION(a.INT_DIVIID),FIND_A_EMPLOYEE_ID_NAMEONLY_BY_USERID(a.CHR_USRNAME), ";
      sql = String.valueOf(sql) + " a.CHR_GST_TYPE,if(a.CHR_GST_TYPE='S','GST','IST'), a.CHR_VENDORPO, RIGHT(a.CHR_PURCHASEORDERNO,8)  FROM inv_t_directpurchase  a, inv_m_vendorsinformation  b ";
      sql = String.valueOf(sql) + " where   a.INT_VENDORID=b.INT_VENDORID ";
      if (!"F".equals(object2))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID =" + object1; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND month(a.DAT_ORDERDATE) = " + month; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_ORDERDATE)=" + day; 
      sql = String.valueOf(sql) + " AND year(a.DAT_ORDERDATE)=   " + year;
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(vendor))
        sql = String.valueOf(sql) + "  AND a.INT_VENDORID = " + vendor; 
      if (!"0".equals(cancel))
        sql = String.valueOf(sql) + " AND a.CHR_CANCEL = '" + cancel + "' "; 
      if (!"0".equals(taxtype))
        sql = String.valueOf(sql) + " AND a.CHR_GST_TYPE = '" + taxtype + "' "; 
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND b.CHR_VENDORNAME LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + "   order by a.INT_PURCHASEORDERID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directPurchase>");
          sb.append("<salId>" + readData[u][0].trim() + "</salId>");
          sb.append("<salNo>" + readData[u][1].trim() + "</salNo>");
          sb.append("<quoCust>" + readData[u][2].trim().replace("&", "9865043008") + "</quoCust>");
          sb.append("<salDate>" + readData[u][3].trim() + "</salDate>");
          sb.append("<salTotal>" + readData[u][4].trim() + "</salTotal>");
          sb.append("<PStatus>" + readData[u][5].trim() + "</PStatus>");
          if ("Y".equalsIgnoreCase(readData[u][6].trim())) {
            sb.append("<Status>Y</Status>");
          } else {
            sb.append("<Status>N</Status>");
          } 
          if ("Y".equalsIgnoreCase(readData[u][7].trim())) {
            sb.append("<SalesStatus>Y</SalesStatus>");
          } else {
            sb.append("<SalesStatus>N</SalesStatus>");
          } 
          sb.append("<PR>" + readData[u][9].trim() + "</PR>");
          sb.append("<Cancel>" + readData[u][10].trim() + "</Cancel>");
          sb.append("<Division>" + readData[u][11] + "</Division>");
          sb.append("<Entry>" + readData[u][12] + "</Entry>");
          sb.append("<Taxtype>" + readData[u][13] + "</Taxtype>");
          sb.append("<TaxtypeGST>" + readData[u][14] + "</TaxtypeGST>");
          sb.append("<VPO>" + readData[u][15] + "</VPO>");
          sb.append("<GPO>" + readData[u][16] + "</GPO>");
          sb.append("<usertype>" + object2 + "</usertype>");
          sb.append("</directPurchase>");
        } 
        System.out.println("\n\n" + sb.toString());
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<DirectPurchases>" + sb.toString() + "</DirectPurchases>");
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
  
  public static void loadACCDirectPurchase(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      String month = request.getParameter("month");
      String vendor = request.getParameter("vendor");
      String division = request.getParameter("division");
      String Aflag = request.getParameter("Aflag");
      String Accbranch = request.getParameter("Accbranch");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String sql = " SELECT  a.CHR_PURCHASEORDERNO,CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + " a.CHR_PAYMENTSTATUS  ,a.CHR_ACCOUNTFLAG,d.CHR_BRANCHNAME,a.IMG_INVOICE,a.DOU_TOTALAMOUNT, ";
      sql = String.valueOf(sql) + " FUN_INV_DIVISION(a.INT_DIVIID) FROM inv_t_directpurchase a ,  inv_m_vendorsinformation  b , com_m_branch d";
      sql = String.valueOf(sql) + " where  a.INT_VENDORID = b.INT_VENDORID AND a.INT_BRANCHID =d.INT_BRANCHID ";
      if (!"0".equals(Accbranch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID = " + Accbranch; 
      if ("0".equals(Aflag)) {
        sql = String.valueOf(sql) + "  AND a.CHR_ACCOUNTFLAG ='Y'";
      } else if ("1".equals(Aflag)) {
        sql = String.valueOf(sql) + " AND a.CHR_ACCOUNTFLAG ='N'";
      } 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(vendor))
        sql = String.valueOf(sql) + " AND a.INT_VENDORID = " + vendor; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + "   AND MONTH(a.DAT_ORDERDATE) =" + mon; 
      sql = String.valueOf(sql) + " AND year(a.DAT_ORDERDATE)= " + year;
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND  b.CHR_VENDORNAME LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY a.INT_PURCHASEORDERID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      String filepath = request.getRealPath("/");
      File f = null;
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directPurchase>");
          sb.append("<Pono>" + readData[u][0] + "</Pono>");
          sb.append("<Vendor>" + readData[u][1].trim().replace("&", "98650") + "</Vendor>");
          sb.append("<Podate>" + readData[u][2] + "</Podate>");
          f = new File(String.valueOf(filepath) + "uploadfiles/DCIMAGE/" + readData[u][0].replaceAll("/", "_") + ".pdf");
          if (f.exists()) {
            sb.append("<Download>Y</Download>");
          } else {
            sb.append("<Download>N</Download>");
          } 
          if ("Y".equalsIgnoreCase(readData[u][3])) {
            sb.append("<PStatus>Paid</PStatus>");
          } else {
            sb.append("<PStatus>Pending</PStatus>");
          } 
          sb.append("<InvoiceStatus>" + readData[u][4] + "</InvoiceStatus>");
          sb.append("<Branch>" + readData[u][5] + "</Branch>");
          sb.append("<NetAmount>" + readData[u][7] + "</NetAmount>");
          sb.append("<Division>" + readData[u][8] + "</Division>");
          sb.append("</directPurchase>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<directPurchases>" + sb.toString() + "</directPurchases>");
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
  
  public static void loadCustomerAddress(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("id");
      String sql = "";
      sql = "  SELECT CONCAT(f.CHR_NAME,'~', a.CHR_ADDRESS1, '~',a.CHR_ADDRESS2, '~', a.CHR_ADDRESS3, '~', e.CHR_CITYNAME,'~',d.CHR_DISTRICT,'~',   ";
      sql = String.valueOf(sql) + " c.CHR_STATENAME,'~', CONCAT(a.INT_PINCODE),'~' )   ";
      sql = String.valueOf(sql) + " , a.INT_STATEID   FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,   ";
      sql = String.valueOf(sql) + " com_m_city e  ,inv_m_customergroup f      ";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   ";
      sql = String.valueOf(sql) + " AND a.INT_COUNTRYID = b.INT_COUNTRYID       ";
      sql = String.valueOf(sql) + " AND a.INT_STATEID =c.INT_STATEID       ";
      sql = String.valueOf(sql) + "  AND a.INT_DISTRICTID= d.INT_DISTRICTID     ";
      sql = String.valueOf(sql) + " AND a.INT_CITYID =e.INT_CITYID        ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + id;
      sql = String.valueOf(sql) + " ORDER BY f.CHR_NAME   ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Address>");
          sb.append("<A>" + readData[u][0] + "</A>");
          sb.append("<GstStateId>" + readData[u][1] + "</GstStateId>");
          sb.append("</Address>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Addresss>" + sb.toString() + "</Addresss>");
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
  
  public static synchronized void loadcheckSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: ldc_w 'serial'
    //   4: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   9: ldc_w ','
    //   12: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   15: astore_2
    //   16: ldc ''
    //   18: astore_3
    //   19: iconst_0
    //   20: istore #4
    //   22: ldc ''
    //   24: astore #5
    //   26: ldc ''
    //   28: astore #6
    //   30: ldc ''
    //   32: astore #7
    //   34: ldc ''
    //   36: astore #8
    //   38: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   41: invokevirtual println : ()V
    //   44: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   47: invokevirtual println : ()V
    //   50: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   53: ldc_w 'Serial number Checking'
    //   56: invokevirtual println : (Ljava/lang/String;)V
    //   59: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   62: ldc_w '======================'
    //   65: invokevirtual println : (Ljava/lang/String;)V
    //   68: iconst_0
    //   69: istore #9
    //   71: goto -> 283
    //   74: aload_2
    //   75: iload #9
    //   77: aaload
    //   78: ldc_w '~'
    //   81: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   84: astore #10
    //   86: aload #10
    //   88: iconst_0
    //   89: aaload
    //   90: astore #6
    //   92: aload #10
    //   94: iconst_1
    //   95: aaload
    //   96: astore #7
    //   98: aload #10
    //   100: iconst_2
    //   101: aaload
    //   102: astore #8
    //   104: new java/lang/StringBuilder
    //   107: dup
    //   108: ldc_w 'SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO=''
    //   111: invokespecial <init> : (Ljava/lang/String;)V
    //   114: aload #6
    //   116: invokevirtual trim : ()Ljava/lang/String;
    //   119: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   122: ldc_w '''
    //   125: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   128: invokevirtual toString : ()Ljava/lang/String;
    //   131: astore_3
    //   132: new java/lang/StringBuilder
    //   135: dup
    //   136: aload_3
    //   137: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   140: invokespecial <init> : (Ljava/lang/String;)V
    //   143: ldc_w ' AND CHR_TYPE=''
    //   146: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   149: aload #8
    //   151: invokevirtual trim : ()Ljava/lang/String;
    //   154: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   157: ldc_w ''  AND CHR_ITEMID = ''
    //   160: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   163: aload #7
    //   165: invokevirtual trim : ()Ljava/lang/String;
    //   168: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   171: ldc_w '' '
    //   174: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   177: invokevirtual toString : ()Ljava/lang/String;
    //   180: astore_3
    //   181: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   184: new java/lang/StringBuilder
    //   187: dup
    //   188: aload_3
    //   189: invokestatic valueOf : (Ljava/lang/Object;)Ljava/lang/String;
    //   192: invokespecial <init> : (Ljava/lang/String;)V
    //   195: ldc_w ' \\nSwap Serial Number checking '
    //   198: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   201: iload #9
    //   203: iconst_1
    //   204: iadd
    //   205: invokevirtual append : (I)Ljava/lang/StringBuilder;
    //   208: ldc_w '    '
    //   211: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   214: aload #6
    //   216: invokevirtual trim : ()Ljava/lang/String;
    //   219: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   222: ldc_w '/'
    //   225: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   228: iload #4
    //   230: invokevirtual append : (Z)Ljava/lang/StringBuilder;
    //   233: ldc_w '/'
    //   236: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   239: aload_3
    //   240: invokestatic RecordExist : (Ljava/lang/String;)Z
    //   243: ifeq -> 250
    //   246: iconst_0
    //   247: goto -> 251
    //   250: iconst_1
    //   251: invokevirtual append : (Z)Ljava/lang/StringBuilder;
    //   254: invokevirtual toString : ()Ljava/lang/String;
    //   257: invokevirtual println : (Ljava/lang/String;)V
    //   260: aload_3
    //   261: invokestatic RecordExist : (Ljava/lang/String;)Z
    //   264: ifne -> 277
    //   267: iconst_0
    //   268: istore #4
    //   270: aload #6
    //   272: astore #5
    //   274: goto -> 290
    //   277: iconst_1
    //   278: istore #4
    //   280: iinc #9, 1
    //   283: iload #9
    //   285: aload_2
    //   286: arraylength
    //   287: if_icmplt -> 74
    //   290: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   293: ldc_w '======================'
    //   296: invokevirtual println : (Ljava/lang/String;)V
    //   299: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   302: invokevirtual println : ()V
    //   305: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   308: invokevirtual println : ()V
    //   311: new java/lang/StringBuffer
    //   314: dup
    //   315: invokespecial <init> : ()V
    //   318: astore #9
    //   320: aload_2
    //   321: arraylength
    //   322: ifle -> 476
    //   325: aload #9
    //   327: ldc_w '<Serial>'
    //   330: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   333: pop
    //   334: aload #9
    //   336: new java/lang/StringBuilder
    //   339: dup
    //   340: ldc_w '<Id>'
    //   343: invokespecial <init> : (Ljava/lang/String;)V
    //   346: aload #5
    //   348: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   351: ldc_w '</Id>'
    //   354: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   357: invokevirtual toString : ()Ljava/lang/String;
    //   360: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   363: pop
    //   364: aload #9
    //   366: new java/lang/StringBuilder
    //   369: dup
    //   370: ldc_w '<Flag>'
    //   373: invokespecial <init> : (Ljava/lang/String;)V
    //   376: new java/lang/StringBuilder
    //   379: dup
    //   380: invokespecial <init> : ()V
    //   383: iload #4
    //   385: invokevirtual append : (Z)Ljava/lang/StringBuilder;
    //   388: invokevirtual toString : ()Ljava/lang/String;
    //   391: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   394: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   397: ldc_w '</Flag>'
    //   400: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   403: invokevirtual toString : ()Ljava/lang/String;
    //   406: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   409: pop
    //   410: aload #9
    //   412: ldc_w '</Serial>'
    //   415: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   418: pop
    //   419: aload_1
    //   420: ldc 'text/xml'
    //   422: invokeinterface setContentType : (Ljava/lang/String;)V
    //   427: aload_1
    //   428: ldc 'Cache-Control'
    //   430: ldc 'no-cache'
    //   432: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   437: aload_1
    //   438: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   443: new java/lang/StringBuilder
    //   446: dup
    //   447: ldc_w '<Serials>'
    //   450: invokespecial <init> : (Ljava/lang/String;)V
    //   453: aload #9
    //   455: invokevirtual toString : ()Ljava/lang/String;
    //   458: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   461: ldc_w '</Serials>'
    //   464: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   467: invokevirtual toString : ()Ljava/lang/String;
    //   470: invokevirtual write : (Ljava/lang/String;)V
    //   473: goto -> 528
    //   476: aload_1
    //   477: sipush #204
    //   480: invokeinterface setStatus : (I)V
    //   485: goto -> 528
    //   488: astore_2
    //   489: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   492: aload_2
    //   493: invokevirtual getMessage : ()Ljava/lang/String;
    //   496: invokevirtual println : (Ljava/lang/String;)V
    //   499: aload_0
    //   500: ldc 'error'
    //   502: aload_2
    //   503: invokevirtual getMessage : ()Ljava/lang/String;
    //   506: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   511: aload_0
    //   512: ldc '/error/index.jsp'
    //   514: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   519: astore_3
    //   520: aload_3
    //   521: aload_0
    //   522: aload_1
    //   523: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   528: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #7897	-> 0
    //   #7898	-> 16
    //   #7899	-> 19
    //   #7900	-> 22
    //   #7901	-> 26
    //   #7902	-> 30
    //   #7903	-> 34
    //   #7904	-> 38
    //   #7905	-> 44
    //   #7906	-> 50
    //   #7907	-> 59
    //   #7908	-> 68
    //   #7910	-> 74
    //   #7911	-> 86
    //   #7912	-> 92
    //   #7913	-> 98
    //   #7915	-> 104
    //   #7916	-> 132
    //   #7917	-> 181
    //   #7918	-> 260
    //   #7920	-> 267
    //   #7921	-> 270
    //   #7922	-> 274
    //   #7924	-> 277
    //   #7908	-> 280
    //   #7926	-> 290
    //   #7927	-> 299
    //   #7928	-> 305
    //   #7929	-> 311
    //   #7930	-> 320
    //   #7932	-> 325
    //   #7933	-> 334
    //   #7934	-> 364
    //   #7935	-> 410
    //   #7936	-> 419
    //   #7937	-> 427
    //   #7938	-> 437
    //   #7939	-> 473
    //   #7942	-> 476
    //   #7944	-> 485
    //   #7945	-> 488
    //   #7947	-> 489
    //   #7948	-> 499
    //   #7949	-> 511
    //   #7950	-> 520
    //   #7952	-> 528
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	529	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	529	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   16	469	2	serial	[Ljava/lang/String;
    //   19	466	3	sql	Ljava/lang/String;
    //   22	463	4	flag	Z
    //   26	459	5	id	Ljava/lang/String;
    //   30	455	6	serials	Ljava/lang/String;
    //   34	451	7	item	Ljava/lang/String;
    //   38	447	8	type	Ljava/lang/String;
    //   71	219	9	x	I
    //   86	194	10	cserial	[Ljava/lang/String;
    //   320	165	9	sb	Ljava/lang/StringBuffer;
    //   489	39	2	e	Ljava/lang/Exception;
    //   520	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	485	488	java/lang/Exception
  }
  
  public static synchronized void LoadSwapcheckSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String Serial = request.getParameter("Serial");
      String Item = request.getParameter("Item");
      String Type = request.getParameter("Type");
      String sql = "";
      sql = "SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO='" + Serial.trim() + "'";
      sql = String.valueOf(sql) + " AND CHR_TYPE='" + Type.trim() + 
        "'  AND CHR_ITEMID = '" + Item.trim() + 
        "' AND CHR_QUALITY='Y'";
      StringBuffer sb = new StringBuffer();
      if (CommonInfo.RecordExist(sql)) {
        sb.append("<Serial>");
        sb.append("<Exsist>TRUE</Exsist>");
        sb.append("<Nos>" + Serial + "</Nos>");
        sb.append("</Serial>");
      } else {
        sb.append("<Serial>");
        sb.append("<Exsist>FALSE</Exsist>");
        sb.append("<Nos>" + Serial + " - Already Sold...</Nos>");
        sb.append("</Serial>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Serials>" + sb.toString() + "</Serials>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void loadcremovedItemSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    // Byte code:
    //   0: aload_0
    //   1: ldc_w 'serial'
    //   4: invokeinterface getParameter : (Ljava/lang/String;)Ljava/lang/String;
    //   9: ldc_w ','
    //   12: invokevirtual split : (Ljava/lang/String;)[Ljava/lang/String;
    //   15: astore_2
    //   16: ldc ''
    //   18: astore_3
    //   19: iconst_0
    //   20: istore #4
    //   22: ldc ''
    //   24: astore #5
    //   26: iconst_0
    //   27: istore #6
    //   29: goto -> 93
    //   32: aload_2
    //   33: iload #6
    //   35: aaload
    //   36: astore #7
    //   38: new java/lang/StringBuilder
    //   41: dup
    //   42: ldc_w 'SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO=''
    //   45: invokespecial <init> : (Ljava/lang/String;)V
    //   48: aload #7
    //   50: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   53: ldc_w '''
    //   56: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   59: invokevirtual toString : ()Ljava/lang/String;
    //   62: astore_3
    //   63: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   66: aload_3
    //   67: invokevirtual println : (Ljava/lang/String;)V
    //   70: aload_3
    //   71: invokestatic RecordExist : (Ljava/lang/String;)Z
    //   74: ifeq -> 87
    //   77: iconst_0
    //   78: istore #4
    //   80: aload #7
    //   82: astore #5
    //   84: goto -> 100
    //   87: iconst_1
    //   88: istore #4
    //   90: iinc #6, 1
    //   93: iload #6
    //   95: aload_2
    //   96: arraylength
    //   97: if_icmplt -> 32
    //   100: new java/lang/StringBuffer
    //   103: dup
    //   104: invokespecial <init> : ()V
    //   107: astore #6
    //   109: aload_2
    //   110: arraylength
    //   111: ifle -> 265
    //   114: aload #6
    //   116: ldc_w '<Serial>'
    //   119: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   122: pop
    //   123: aload #6
    //   125: new java/lang/StringBuilder
    //   128: dup
    //   129: ldc_w '<Id>'
    //   132: invokespecial <init> : (Ljava/lang/String;)V
    //   135: aload #5
    //   137: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   140: ldc_w '</Id>'
    //   143: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   146: invokevirtual toString : ()Ljava/lang/String;
    //   149: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   152: pop
    //   153: aload #6
    //   155: new java/lang/StringBuilder
    //   158: dup
    //   159: ldc_w '<Flag>'
    //   162: invokespecial <init> : (Ljava/lang/String;)V
    //   165: new java/lang/StringBuilder
    //   168: dup
    //   169: invokespecial <init> : ()V
    //   172: iload #4
    //   174: invokevirtual append : (Z)Ljava/lang/StringBuilder;
    //   177: invokevirtual toString : ()Ljava/lang/String;
    //   180: invokevirtual toUpperCase : ()Ljava/lang/String;
    //   183: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   186: ldc_w '</Flag>'
    //   189: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   192: invokevirtual toString : ()Ljava/lang/String;
    //   195: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   198: pop
    //   199: aload #6
    //   201: ldc_w '</Serial>'
    //   204: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuffer;
    //   207: pop
    //   208: aload_1
    //   209: ldc 'text/xml'
    //   211: invokeinterface setContentType : (Ljava/lang/String;)V
    //   216: aload_1
    //   217: ldc 'Cache-Control'
    //   219: ldc 'no-cache'
    //   221: invokeinterface setHeader : (Ljava/lang/String;Ljava/lang/String;)V
    //   226: aload_1
    //   227: invokeinterface getWriter : ()Ljava/io/PrintWriter;
    //   232: new java/lang/StringBuilder
    //   235: dup
    //   236: ldc_w '<Serials>'
    //   239: invokespecial <init> : (Ljava/lang/String;)V
    //   242: aload #6
    //   244: invokevirtual toString : ()Ljava/lang/String;
    //   247: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   250: ldc_w '</Serials>'
    //   253: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   256: invokevirtual toString : ()Ljava/lang/String;
    //   259: invokevirtual write : (Ljava/lang/String;)V
    //   262: goto -> 317
    //   265: aload_1
    //   266: sipush #204
    //   269: invokeinterface setStatus : (I)V
    //   274: goto -> 317
    //   277: astore_2
    //   278: getstatic java/lang/System.out : Ljava/io/PrintStream;
    //   281: aload_2
    //   282: invokevirtual getMessage : ()Ljava/lang/String;
    //   285: invokevirtual println : (Ljava/lang/String;)V
    //   288: aload_0
    //   289: ldc 'error'
    //   291: aload_2
    //   292: invokevirtual getMessage : ()Ljava/lang/String;
    //   295: invokeinterface setAttribute : (Ljava/lang/String;Ljava/lang/Object;)V
    //   300: aload_0
    //   301: ldc '/error/index.jsp'
    //   303: invokeinterface getRequestDispatcher : (Ljava/lang/String;)Ljavax/servlet/RequestDispatcher;
    //   308: astore_3
    //   309: aload_3
    //   310: aload_0
    //   311: aload_1
    //   312: invokeinterface forward : (Ljavax/servlet/ServletRequest;Ljavax/servlet/ServletResponse;)V
    //   317: return
    // Line number table:
    //   Java source line number -> byte code offset
    //   #8003	-> 0
    //   #8004	-> 16
    //   #8005	-> 19
    //   #8006	-> 22
    //   #8007	-> 26
    //   #8009	-> 32
    //   #8010	-> 38
    //   #8011	-> 63
    //   #8012	-> 70
    //   #8014	-> 77
    //   #8015	-> 80
    //   #8016	-> 84
    //   #8018	-> 87
    //   #8007	-> 90
    //   #8020	-> 100
    //   #8021	-> 109
    //   #8023	-> 114
    //   #8024	-> 123
    //   #8025	-> 153
    //   #8026	-> 199
    //   #8027	-> 208
    //   #8028	-> 216
    //   #8029	-> 226
    //   #8030	-> 232
    //   #8029	-> 259
    //   #8031	-> 262
    //   #8034	-> 265
    //   #8036	-> 274
    //   #8037	-> 277
    //   #8039	-> 278
    //   #8040	-> 288
    //   #8041	-> 300
    //   #8042	-> 309
    //   #8044	-> 317
    // Local variable table:
    //   start	length	slot	name	descriptor
    //   0	318	0	request	Ljavax/servlet/http/HttpServletRequest;
    //   0	318	1	response	Ljavax/servlet/http/HttpServletResponse;
    //   16	258	2	serial	[Ljava/lang/String;
    //   19	255	3	sql	Ljava/lang/String;
    //   22	252	4	flag	Z
    //   26	248	5	id	Ljava/lang/String;
    //   29	71	6	x	I
    //   38	52	7	serials	Ljava/lang/String;
    //   109	165	6	sb	Ljava/lang/StringBuffer;
    //   278	39	2	e	Ljava/lang/Exception;
    //   309	8	3	dispatchers	Ljavax/servlet/RequestDispatcher;
    // Exception table:
    //   from	to	target	type
    //   0	274	277	java/lang/Exception
  }
  
  public static void loadSalesReturn(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String returnType = request.getParameter("returnType");
      Object object = session.getAttribute("BRANCHID");
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String fDate = String.valueOf(year) + "-" + month + "-01";
      String tDate = String.valueOf(year) + "-" + month + "-" + DateUtil.totalDays(mon, year);
      String sql = "";
      if ("Invoice".equals(returnType)) {
        sql = " SELECT a.CHR_SALESORDERNO,a.DAT_SALEDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SALESORDERNO  ,c.CHR_GRTFLAG ";
        sql = String.valueOf(sql) + "  from  inv_t_customersalesorder   a  ,inv_m_customerinfo b , inv_t_customersalesorderitemserial c where ";
        sql = String.valueOf(sql) + " a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.DAT_SALEDATE>='" + fDate + "'";
        sql = String.valueOf(sql) + " AND a.CHR_SALESORDERNO = c.CHR_SALESORDERNO AND c.CHR_GRTFLAG ='Y' ";
        sql = String.valueOf(sql) + " AND a.DAT_SALEDATE<='" + tDate + "' AND a.INT_BRANCHID=" + object;
        sql = String.valueOf(sql) + " AND CHR_INVOICESTATUS='Y'  GROUP BY c.CHR_SALESORDERNO ";
      } else if ("Direct".equals(returnType)) {
        sql = " SELECT a.CHR_SALESNO,a.DAT_SALESDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SALESNO  ,c.CHR_GRTFLAG ";
        sql = String.valueOf(sql) + "  from inv_t_directsales a  ,inv_m_customerinfo b ,inv_t_swapsalesserialno c  where ";
        sql = String.valueOf(sql) + " a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.DAT_SALESDATE>='" + fDate + "'";
        sql = String.valueOf(sql) + " AND a.CHR_SALESNO = c.CHR_SALESNO AND c.CHR_GRTFLAG ='Y' ";
        sql = String.valueOf(sql) + " AND a.DAT_SALESDATE<='" + tDate + "' AND a.INT_BRANCHID=" + object;
        sql = String.valueOf(sql) + " AND INT_SALESSTATUS='1' GROUP BY c.CHR_SALESNO ";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      String StartLetter = request.getParameter("id");
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][0].startsWith(StartLetter) || "0".startsWith(StartLetter)) {
            sb.append("<Return>");
            sb.append("<DCNO>" + readData[u][0] + "</DCNO>");
            sb.append("<DCdate>" + readData[u][1] + "</DCdate>");
            sb.append("<CustName>" + readData[u][2] + "</CustName>");
            if (readData[u][4].equals("Y")) {
              sb.append("<ReturnStatus>true</ReturnStatus>");
            } else {
              sb.append("<ReturnStatus>false</ReturnStatus>");
            } 
            sb.append("<SalesNo>" + readData[u][3] + "</SalesNo>");
            sb.append("</Return>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Returns>" + sb.toString() + "</Returns>");
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
  
  public static void loadBranchData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String cpyid = request.getParameter("companyid");
      String sql = "select * from com_m_branch where INT_COMPANYID=" + 
        cpyid + " ORDER BY INT_BRANCHID";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      sb.append("<Branch>");
      sb.append("<Branchid>0</Branchid>");
      sb.append("<Branchname>Select</Branchname>");
      sb.append("</Branch>");
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Branch>");
          sb.append("<Branchid>" + readData[u][0] + "</Branchid>");
          sb.append("<Branchname>" + readData[u][2] + "</Branchname>");
          sb.append("</Branch>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Branchs>" + sb.toString() + "</Branchs>");
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
  
  public static void loadStockTransfer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String id = request.getParameter("id");
      HttpSession session = request.getSession();
      String branchid = session.getAttribute("BRANCHID").toString();
      String day = request.getParameter("day");
      String type = request.getParameter("type");
      Object object = session.getAttribute("INVBRANCH");
      String sql = " SELECT INT_ID,CHR_STOCKTRANSFERID,DATE_FORMAT(DAT_TRANSFERDATE,'%d-%b-%Y'),";
      sql = String.valueOf(sql) + " FUN_GET_BRANCH_NAME(INT_BRANCHID_FROM),INT_BRANCHID_FROM,FUN_GET_BRANCH_NAME(INT_BRANCHID_TO),";
      sql = String.valueOf(sql) + " INT_BRANCHID_TO,INT_STATUS ,INT_TRANSFERSTATUS,CHR_DELIVERY ";
      sql = String.valueOf(sql) + " from inv_t_stocktransfer  WHERE INT_ID >0 ";
      sql = String.valueOf(sql) + "  AND (INT_BRANCHID_TO=" + Integer.parseInt(branchid);
      sql = String.valueOf(sql) + " OR INT_BRANCHID_FROM=" + Integer.parseInt(branchid) + ")";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(DAT_TRANSFERDATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(DAT_TRANSFERDATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(DAT_TRANSFERDATE) = " + year; 
      if ("1".equals(type)) {
        if (!"0".equals(id))
          sql = String.valueOf(sql) + " AND CHR_STOCKTRANSFERID LIKE '" + id.toUpperCase() + "%'"; 
      } else {
        sql = String.valueOf(sql) + " AND CHR_STOCKTRANSFERID LIKE '%" + id.toUpperCase() + "%'";
      } 
      if (!"".equals(status))
        if (!"1".equals(status)) {
          sql = String.valueOf(sql) + " AND INT_STATUS = " + status;
        } else {
          sql = String.valueOf(sql) + " AND INT_STATUS = " + status;
        }  
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<StockTrans>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<TransId>" + readData[u][1] + "</TransId>");
          sb.append("<TransDate>" + readData[u][2] + "</TransDate>");
          sb.append("<FromBranch>" + readData[u][3] + "</FromBranch>");
          sb.append("<FromBranchid>" + readData[u][4] + "</FromBranchid>");
          sb.append("<ToBranch>" + readData[u][5] + "</ToBranch>");
          sb.append("<ToBranchid>" + readData[u][6] + "</ToBranchid>");
          sb.append("<invbranchid>" + object + "</invbranchid>");
          sb.append("<Status>" + readData[u][7] + "</Status>");
          sb.append("<TStatus>" + readData[u][8] + "</TStatus>");
          sb.append("<Delivery>" + readData[u][9] + "</Delivery>");
          if (branchid.equals(readData[u][4])) {
            sb.append("<TransferLink>false</TransferLink>");
          } else {
            sb.append("<TransferLink>true</TransferLink>");
          } 
          if (branchid.equals(readData[u][6])) {
            sb.append("<ReceivedLink>false</ReceivedLink>");
          } else {
            sb.append("<ReceivedLink>true</ReceivedLink>");
          } 
          sb.append("</StockTrans>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<StockTransfer>" + sb.toString() + "</StockTransfer>");
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
  
  public static void LoadNonCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String group = request.getParameter("group");
      String startLetter = request.getParameter("startLetter");
      String servicecenter = request.getParameter("servicecenter");
      String branch = request.getParameter("branch");
      String sql = " ";
      sql = " SELECT  INT_CUSTOMERID ,CHR_CUSTOMERNAME,CHR_PHONE,CHR_MOBILE,CHR_EMAIL \tFROM inv_m_servicecustomerinfo ";
      sql = String.valueOf(sql) + " WHERE INT_CUSTOMERID >= 1 ";
      if (!"0".equals(group))
        sql = String.valueOf(sql) + " AND INT_GROUPID=" + group; 
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND INT_BRANCHID  =" + branch; 
      if (!"0".equals(servicecenter))
        sql = String.valueOf(sql) + " AND INT_SERVICECENTERID=" + servicecenter; 
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND CHR_CUSTOMERNAME like '" + startLetter + 
          "%' ";
      } else {
        sql = String.valueOf(sql) + " AND CHR_CUSTOMERNAME like '%' ";
      } 
      sql = String.valueOf(sql) + "ORDER BY  CHR_CUSTOMERNAME ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Rows>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].replaceAll("&", " AND ").trim() + "</Name>");
          sb.append("<Phone>" + readData[u][2] + "</Phone>");
          sb.append("<Mobile>" + readData[u][3] + " </Mobile>");
          sb.append("<Email>" + readData[u][4] + "</Email>");
          sb.append("</Rows>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Fieldss>" + sb.toString() + "</Fieldss>");
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
  
  public static void LoadServiceItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = " ";
      sql = " SELECT INT_SERVICEITEMID ,CHR_SERVICEITEMNAME FROM  inv_m_serviceitems ";
      sql = String.valueOf(sql) + " WHERE INT_SERVICEITEMID >= 1 ";
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND CHR_SERVICEITEMNAME like '" + startLetter + 
          "%' ";
      } else {
        sql = String.valueOf(sql) + " AND CHR_SERVICEITEMNAME like '%' ";
      } 
      sql = String.valueOf(sql) + "ORDER BY  CHR_SERVICEITEMNAME ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Item>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].replaceAll("&", " AND ") + "</Name>");
          sb.append("</Item>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Items>" + sb.toString() + "</Items>");
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
  
  public static void LoadServiceGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String startLetter = request.getParameter("startLetter");
      String branch = request.getParameter("branch");
      String sql = " ";
      sql = " SELECT INT_GROUPID ,CHR_GROUPNAME FROM  inv_m_servicecustomergroup ";
      sql = String.valueOf(sql) + " WHERE INT_GROUPID >= 1 ";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND  INT_BRANCHID =" + branch; 
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND CHR_GROUPNAME like '" + startLetter + "%' ";
      } else {
        sql = String.valueOf(sql) + " AND CHR_GROUPNAME like '%' ";
      } 
      sql = String.valueOf(sql) + "ORDER BY  CHR_GROUPNAME ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Group>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].replaceAll("&", " AND ") + "</Name>");
          sb.append("</Group>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Groups>" + sb.toString() + "</Groups>");
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
  
  public static void LoadServiceCenter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = " ";
      sql = " SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME,CHR_MOBILE,CHR_MAIL FROM  inv_m_servicecenter";
      sql = String.valueOf(sql) + " WHERE INT_SERVICECENTERID >= 1 ";
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND CHR_CENTERNAME like '" + startLetter + "%' ";
      } else {
        sql = String.valueOf(sql) + " AND CHR_CENTERNAME like '%' ";
      } 
      sql = String.valueOf(sql) + "ORDER BY  CHR_CENTERNAME ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Group>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1] + "</Name>");
          sb.append("<SName>" + readData[u][2] + "</SName>");
          sb.append("<Mobile>" + readData[u][3] + "</Mobile>");
          sb.append("<EMail>" + readData[u][4] + "</EMail>");
          sb.append("</Group>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Groups>" + sb.toString() + "</Groups>");
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
  
  public static void LoadServiceAMC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String startLetter = request.getParameter("startLetter");
      String servicecenter = request.getParameter("servicecenter");
      String customerid = request.getParameter("customerid");
      String peripheralid = request.getParameter("peripheralid");
      String branch = request.getParameter("branch");
      String sql = " ";
      sql = "  SELECT a.INT_CUSTOMERID,a.INT_SERVICEITEMID,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)  ,c.CHR_SERVICEITEMNAME,count(c.CHR_SERVICEITEMNAME), b.CHR_MOBILE  FROM inv_m_serviceamc a  ,inv_m_servicecustomerinfo b,inv_m_serviceitems c";
      sql = String.valueOf(sql) + 
        "   WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID   AND a.INT_SERVICEITEMID = c.INT_SERVICEITEMID";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND b.INT_BRANCHID  =" + branch; 
      if (!"0".equals(customerid))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customerid; 
      if (!"0".equals(servicecenter))
        sql = String.valueOf(sql) + " AND b.INT_SERVICECENTERID=" + servicecenter; 
      if (!"0".equals(peripheralid))
        sql = String.valueOf(sql) + " AND c.INT_SERVICEITEMID=" + peripheralid; 
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + 
          " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) like '" + 
          startLetter + "%' ";
      } else {
        sql = String.valueOf(sql) + 
          " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) like '%' ";
      } 
      sql = String.valueOf(sql) + 
        " GROUP BY a.INT_CUSTOMERID,c.CHR_SERVICEITEMNAME  ORDER BY  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<AMC>");
          sb.append("<Customerid>" + readData[u][0] + "</Customerid>");
          sb.append("<Serviceitemid>" + readData[u][1] + "</Serviceitemid>");
          sb.append("<Name>" + readData[u][2].replaceAll("&", " AND ") + "</Name>");
          sb.append("<Item>" + readData[u][3].replaceAll("&", " AND ") + "</Item>");
          sb.append("<Noofmachine>" + readData[u][4].replaceAll("&", " AND ") + "</Noofmachine>");
          sb.append("<Mobile>" + readData[u][5].replaceAll("&", " AND ") + "</Mobile>");
          sb.append("</AMC>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
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
  
  public static void LoadAMCSerialnumber(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String startLetter = request.getParameter("search");
      String tablename = request.getParameter("tablename");
      String fieldname = request.getParameter("fieldname");
      String sql = " ";
      sql = " SELECT " + fieldname + " FROM " + tablename;
      if (!"".equals(startLetter)) {
        sql = String.valueOf(sql) + " WHERE CHR_STATUS ='Y'AND " + fieldname + 
          " like '" + startLetter + "%' ";
      } else {
        sql = String.valueOf(sql) + "  WHERE CHR_STATUS ='Y'AND  " + fieldname + 
          " like '%' ";
      } 
      sql = String.valueOf(sql) + "ORDER BY  " + fieldname;
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<AMC>");
          sb.append("<Serial>" + readData[u][0] + "</Serial>");
          sb.append("</AMC>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
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
  
  public static void LoadAMCSerialNumberCustomerwise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String id = request.getParameter("id");
      String sql = " ";
      sql = " SELECT CHR_SERIALNO FROM inv_m_serviceamc ";
      sql = String.valueOf(sql) + "  WHERE CHR_STATUS ='Y' AND   INT_CUSTOMERID= " + id;
      sql = String.valueOf(sql) + " ORDER BY  CHR_SERIALNO";
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<AMC>");
          sb.append("<Serial>" + readData[u][0] + "</Serial>");
          sb.append("</AMC>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
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
  
  public static void LoadAMCcustomerinfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String serialnumber = request.getParameter("serialnumber");
      String sql = " SELECT d.CHR_SERVICEITEMNAME,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_EMAIL,a.INT_CUSTOMERID,c.CHR_CATEGORY,c.CHR_DESC , ";
      sql = String.valueOf(sql) + "DATE_FORMAT(c.DT_STARTDATE,'%d-%b-%Y %H:%m:%s %p'),DATE_FORMAT(c.DT_ENDDATE,'%d-%b-%Y %H:%m:%s %p')   FROM inv_m_servicecustomerinfo  a ,inv_m_servicecustomergroup b,inv_m_serviceamc c,inv_m_serviceitems d  ";
      sql = String.valueOf(sql) + " WHERE a.INT_GROUPID = b.INT_GROUPID  ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=c.INT_CUSTOMERID  ";
      sql = String.valueOf(sql) + " AND c.INT_SERVICEITEMID = d.INT_SERVICEITEMID  ";
      sql = String.valueOf(sql) + " AND c.CHR_SERIALNO='" + serialnumber + "' ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Customer>");
          sb.append("<Type>" + readData[u][0] + "</Type>");
          sb.append("<Group>" + readData[u][1] + "</Group>");
          sb.append("<Name>" + readData[u][2] + "</Name>");
          sb.append("<Street>" + readData[u][3] + "</Street>");
          sb.append("<City>" + readData[u][4] + "</City>");
          sb.append("<State>" + readData[u][5] + "</State>");
          sb.append("<Phone>" + readData[u][6] + "</Phone>");
          sb.append("<Mobile>" + readData[u][7] + "</Mobile>");
          sb.append("<Email>" + readData[u][8] + "</Email>");
          sb.append("<Id>" + readData[u][9] + "</Id>");
          sb.append("<Category>" + readData[u][10] + "</Category>");
          sb.append("<Descs>" + readData[u][11].replaceAll("&", " and ") + "</Descs>");
          sb.append("<Start>" + readData[u][12] + "</Start>");
          sb.append("<End>" + readData[u][13] + "</End>");
          sb.append("</Customer>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
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
  
  public static void LoadAMCCallBooking(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String customerid = request.getParameter("customerid");
      String bookingtype = request.getParameter("bookingtype");
      String bookingunder = request.getParameter("bookingunder");
      String callstatus = request.getParameter("callstatus");
      String StartLetter = request.getParameter("StartLetter");
      String branch = request.getParameter("branch");
      String sql = " SELECT a.CHR_SERVICECALLNO, FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H :%i :%s %p'), DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H :%i :%s %p'),a.CHR_BOOKINGTYPE,a.CHR_BOOKINGUNDER,a.CHR_STATUS, a.CHR_ENGGSTATUS,a.CHR_BOOKINGEMPID,c.CHR_STAFFNAME FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,com_m_staff c";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND a.CHR_USRNAME =c.CHR_USERID";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + "  AND a.INT_BRANCHID   =" + branch; 
      if (!"0".equals(customerid))
        sql = String.valueOf(sql) + "  AND a.INT_CUSTOMERID =" + customerid; 
      if (!"0".equals(bookingtype))
        sql = String.valueOf(sql) + "  AND a.CHR_BOOKINGTYPE= '" + bookingtype + "'"; 
      if (!"0".equals(bookingunder))
        sql = String.valueOf(sql) + "  AND a.CHR_BOOKINGUNDER='" + bookingunder + "'"; 
      if (!"0".equals(callstatus))
        sql = String.valueOf(sql) + "  AND a.CHR_STATUS ='" + callstatus + "'"; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + "  AND MONTH(DT_BOOKINGDATE)= " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + "  AND YEAR(DT_BOOKINGDATE) =" + year; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + "  AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'"; 
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Booking>");
          sb.append("<Bookingid>" + readData[u][0] + "</Bookingid>");
          sb.append("<Name>" + readData[u][1].replaceAll("&", " AND") + "</Name>");
          sb.append("<Serial>" + readData[u][2].replaceAll("&", " AND") + "</Serial>");
          sb.append("<Bdate>" + readData[u][3].replaceAll("&", " AND") + "</Bdate>");
          sb.append("<Cdate>" + readData[u][4].replaceAll("&", " AND") + "</Cdate>");
          sb.append("<Btype>" + readData[u][5].replaceAll("&", " AND") + "</Btype>");
          sb.append("<Bunder>" + readData[u][6].replaceAll("&", " AND") + "</Bunder>");
          sb.append("<CallStatus>" + readData[u][7].replaceAll("&", " AND") + "</CallStatus>");
          sb.append("<EnggStatus>" + readData[u][8].replaceAll("&", " AND") + "</EnggStatus>");
          sb.append("<Bookedby>" + readData[u][9].replaceAll("&", " AND") + "</Bookedby>");
          sb.append("<Staff>" + readData[u][10].replaceAll("&", " AND") + "</Staff>");
          sb.append("</Booking>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Bookings>" + sb.toString() + "</Bookings>");
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
  
  public static void LoadAMCCallAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String servicecenter = request.getParameter("servicecenter");
      String callstatus = request.getParameter("callstatus");
      String StartLetter = request.getParameter("StartLetter");
      String branch = request.getParameter("branch");
      HttpSession session = request.getSession();
      String  usertype = session.getAttribute("USRTYPE").toString();
      String sql = " SELECT a.CHR_SERVICECALLNO, FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H:%i:%s %p'), DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H:%i:%s %p'),a.CHR_BOOKINGTYPE,a.CHR_BOOKINGUNDER,a.CHR_STATUS, a.CHR_ENGGSTATUS,a.CHR_BOOKINGEMPID,a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,a.CHR_SERVICEDESC,c.CHR_CENTERNAME FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,inv_m_servicecenter c ";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID = c.INT_SERVICECENTERID";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + "  AND a.INT_BRANCHID = " + branch + " "; 
      if (!"0".equals(callstatus))
        sql = String.valueOf(sql) + "  AND a.CHR_STATUS ='" + callstatus + "'"; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + "  AND MONTH(DT_BOOKINGDATE)= " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + "  AND YEAR(DT_BOOKINGDATE) =" + year; 
      if (!"0".equals(servicecenter))
        sql = String.valueOf(sql) + "  AND b.INT_SERVICECENTERID =" + servicecenter; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + "  AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'"; 
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Booking>");
          sb.append("<Bookingid>" + readData[u][0] + "</Bookingid>");
          sb.append("<Name>" + readData[u][1].replaceAll("&", " and ") + "</Name>");
          sb.append("<Serial>" + readData[u][2].replaceAll("&", " and ") + "</Serial>");
          sb.append("<Bdate>" + readData[u][3].replaceAll("&", " and ") + "</Bdate>");
          sb.append("<Cdate>" + readData[u][4].replaceAll("&", " and ") + "</Cdate>");
          sb.append("<Btype>" + readData[u][5].replaceAll("&", " and ") + "</Btype>");
          sb.append("<usertype>" + usertype.replaceAll("&", " and ") + "</usertype>");
          sb.append("<Bunder>" + readData[u][6].replaceAll("&", " and ") + "</Bunder>");
          sb.append("<CallStatus>" + readData[u][7].replaceAll("&", " and ") + "</CallStatus>");
          sb.append("<EnggStatus>" + readData[u][8].replaceAll("&", " and ") + "</EnggStatus>");
          sb.append("<Bookedby>" + readData[u][9].replaceAll("&", " and ") + "</Bookedby>");
          sb.append("<Cperson>" + readData[u][10].replaceAll("&", " and ") + "</Cperson>");
          sb.append("<Caddress>" + readData[u][11].replaceAll("&", " and ") + "</Caddress>");
          sb.append("<Cmobile>" + readData[u][12].replaceAll("&", " and ") + "</Cmobile>");
          sb.append("<Cmail>" + readData[u][13].replaceAll("&", " and ") + "</Cmail>");
          sb.append("<Descriptions>" + readData[u][14].replaceAll("&", " and ") + "</Descriptions>");
          sb.append("<ServiceCenter>" + readData[u][15].replaceAll("&", " and ") + "</ServiceCenter>");
          sb.append("</Booking>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Bookings>" + sb.toString() + "</Bookings>");
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
  
  public static void LoadAMCPersonalinfo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("id");
      String sql = " SELECT CHR_CUSTOMERNAME,CHR_STREET,CHR_CITY,CHR_STATE,CHR_PHONE,CHR_MOBILE,CHR_EMAIL FROM  inv_m_servicecustomerinfo  WHERE INT_CUSTOMERID=" + id;
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Details>");
          sb.append("<Name>" + readData[u][0] + "</Name>");
          sb.append("<Street>" + readData[u][1] + "</Street>");
          sb.append("<City>" + readData[u][2] + "</City>");
          sb.append("<State>" + readData[u][3] + "</State>");
          sb.append("<Phone>" + readData[u][4] + "</Phone>");
          sb.append("<Mobile>" + readData[u][5] + "</Mobile>");
          sb.append("<Email>" + readData[u][6] + "</Email>");
          sb.append("</Details>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
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
  
  public static void LoadCustomerCreditLimit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("customerid");
      String nettotal = request.getParameter("nettotal");
      double pamount = 0.0D;
      double camount = 0.0D;
      double percentage = 0.0D;
      String sql = " SELECT sum(a.DOU_TOTALAMOUNT),SUM(DOU_PAIDAMOUNT),(sum(a.DOU_TOTALAMOUNT)-SUM(DOU_PAIDAMOUNT)) FROM inv_t_directsales a ,inv_t_customersalespayment b ";
      sql = String.valueOf(sql) + " WHERE a.CHR_SALESNO=b.CHR_SALESORDERNO ";
      sql = String.valueOf(sql) + "  AND  a.INT_CUSTOMERID= " + id;
      String[][] pendingamount = CommonFunctions.QueryExecute(sql);
      if (pendingamount.length > 0)
        if (!"-".equals(pendingamount[0][2])) {
          pamount = Double.parseDouble(pendingamount[0][2]);
        } else {
          pamount = 0.0D;
        }  
      sql = " SELECT DOU_CREDITLIMIT FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" + id;
      String[][] creditamount = CommonFunctions.QueryExecute(sql);
      if (creditamount.length > 0) {
        camount = Double.parseDouble(creditamount[0][0]);
      } else {
        camount = 0.0D;
      } 
      sql = " SELECT DOU_RESELLERPERCENTAGE FROM m_institution  WHERE INT_ID=1 ";
      String[][] percentageamount = CommonFunctions.QueryExecute(sql);
      if (percentageamount.length > 0) {
        percentage = Double.parseDouble(percentageamount[0][0]);
      } else {
        percentage = 10.0D;
      } 
      percentage = percentage / 100.0D * camount;
      camount += percentage;
      double valid = Double.parseDouble(nettotal) + pamount;
      StringBuffer sb = new StringBuffer();
      sb.append("<Details>");
      if (camount > 0.0D) {
        if (valid > camount) {
          sb.append("<Valid>False</Valid>");
        } else {
          sb.append("<Valid>True</Valid>");
        } 
        sb.append("<Amount>" + pamount + "</Amount>");
        sb.append("<Amount1>" + nettotal + "</Amount1>");
      } else {
        sb.append("<Valid>True</Valid>");
        sb.append("<Amount>" + pamount + "</Amount>");
        sb.append("<Amount1>" + nettotal + "</Amount1>");
      } 
      sb.append("</Details>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadCustomerServiceCallCreditLimit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String callid = request.getParameter("callid");
      String startdate = request.getParameter("startdate");
      String[] sdate = startdate.split(" ");
      startdate = String.valueOf(DateUtil.FormateDateSQL(sdate[0])) + " " + sdate[1];
      String enddate = request.getParameter("enddate");
      String[] edate = enddate.split(" ");
      enddate = String.valueOf(DateUtil.FormateDateSQL(edate[0])) + " " + edate[1];
      String bookingdate = request.getParameter("bookingdate");
      String[] bdate = bookingdate.split(" ");
      bookingdate = String.valueOf(DateUtil.FormateDateSQL(bdate[0])) + " " + bdate[1];
      boolean f1 = false;
      boolean f2 = false;
      boolean f3 = false;
      String sql = " SELECT '" + startdate + "' >" + "'" + bookingdate + "'";
      String[][] bookdiff = CommonFunctions.QueryExecute(sql);
      if ("1".equals(bookdiff[0][0])) {
        f1 = true;
      } else {
        f1 = false;
      } 
      sql = " SELECT '" + enddate + "' >" + "'" + startdate + "'";
      String[][] dtdiff = CommonFunctions.QueryExecute(sql);
      if ("1".equals(dtdiff[0][0])) {
        f2 = true;
      } else {
        f2 = false;
      } 
      sql = "SELECT DT_CLOSEDATE FROM   inv_t_servicecallbookingtrack WHERE  INT_TRACKID = ( SELECT max(INT_TRACKID) FROM   inv_t_servicecallbookingtrack WHERE CHR_SERVICECALLNO='" + callid + "' ) ";
      String[][] call = CommonFunctions.QueryExecute(sql);
      if (call.length > 0) {
        sql = " SELECT '" + startdate + "' >" + "'" + call[0][0] + "'";
        String[][] dbdtdiff = CommonFunctions.QueryExecute(sql);
        if ("1".equals(dbdtdiff[0][0])) {
          f3 = true;
        } else {
          f3 = false;
        } 
      } else {
        f3 = true;
      } 
      StringBuffer sb = new StringBuffer();
      sb.append("<Details>");
      if (f1 && f2 && f3) {
        sb.append("<Valid>True</Valid>");
      } else {
        sb.append("<Valid>False</Valid>");
      } 
      sb.append("</Details>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadCustomerServiceCallSerialnumberCheck(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String serialno = request.getParameter("serialno");
      String startdate = request.getParameter("startdate");
      String[] sdate = startdate.split(" ");
      startdate = String.valueOf(DateUtil.FormateDateSQL(sdate[0])) + " " + sdate[1];
      String sql = "SELECT DT_CLOSEDATE,CHR_CALLSTATUS  FROM  inv_t_servicecallbookingtrack WHERE DT_CLOSEDATE=(SELECT MAX(DT_CLOSEDATE) FROM  inv_t_servicecallbookingtrack WHERE CHR_SERIALNO='" + serialno + "')";
      String[][] diff = CommonFunctions.QueryExecute(sql);
      boolean f1 = false;
      if (diff.length > 0) {
        sql = " select datediff('" + startdate + "','" + diff[0][0] + "')";
        int day = Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
        if (day >= 7) {
          f1 = true;
        } else {
          f1 = false;
        } 
      } else {
        f1 = true;
      } 
      StringBuffer sb = new StringBuffer();
      sb.append("<Details>");
      if (f1) {
        sb.append("<Valid>True</Valid>");
      } else {
        sb.append("<Valid>False</Valid>");
      } 
      sb.append("</Details>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void LoadRuntimeCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("id");
      String branch = request.getParameter("branch");
      String sql = "";
      sql = " SELECT  INT_CUSTOMERID ,CHR_CUSTOMERNAME FROM inv_m_servicecustomerinfo     WHERE INT_CUSTOMERID >= 1 ";
      if (!"0".equals(id))
        sql = String.valueOf(sql) + " AND INT_SERVICECENTERID=" + id; 
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND INT_BRANCHID  =" + branch; 
      sql = String.valueOf(sql) + " ORDER BY CHR_CUSTOMERNAME ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].toUpperCase().replaceAll("&", " AND ") + "</Name>");
          sb.append("</Row>");
        } 
        sb.toString();
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
  
  public static void LoadRuntimeNonCustomerGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("id");
      String branch = request.getParameter("branch");
      String sql = "";
      sql = " SELECT a.INT_GROUPID,b.CHR_GROUPNAME FROM  inv_m_servicecustomerinfo a ,inv_m_servicecustomergroup b WHERE a.INT_GROUPID = b.INT_GROUPID ";
      if (!"0".equals(id))
        sql = String.valueOf(sql) + " AND a.INT_SERVICECENTERID=" + id; 
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND b.INT_BRANCHID=" + branch; 
      sql = String.valueOf(sql) + " GROUP BY a.INT_GROUPID  ORDER BY b.CHR_GROUPNAME";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].toUpperCase().replaceAll("&", " AND ") + "</Name>");
          sb.append("</Row>");
        } 
        sb.toString();
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
  
  public static void LoadAccessories(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM inv_m_accessoriesgroup WHERE INT_GROUPID>=1 ";
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND CHR_GROUPNAME LIKE '" + startLetter + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY CHR_GROUPNAME ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0] + "</Id>");
          sb.append("<Name>" + readData[u][1].toUpperCase() + "</Name>");
          sb.append("<Desc>" + readData[u][2] + "</Desc>");
          sb.append("</Row>");
        } 
        sb.toString();
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
  
  public static void LoadAccessoriesProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String group = request.getParameter("group");
      String startletter = request.getParameter("startLetter");
      String ssql = "";
      if (!"0".equals(startletter)) {
        ssql = " AND a.CHR_PRODUCTNAME like '" + startletter + "%'";
      } else {
        ssql = " AND a.CHR_PRODUCTNAME like '%'";
      } 
      String sql = "";
      sql = "SELECT a.INT_PRODUCTID,a.CHR_PRODUCTNAME ,b.CHR_GROUPNAME,a.CHR_DESC ,a.DOU_AMOUNT FROM inv_m_accessoriesproduct a,inv_m_accessoriesgroup b WHERE a.INT_GROUPID=b.INT_GROUPID ";
      if (!"0".equals(group))
        sql = String.valueOf(sql) + "  AND a.INT_GROUPID=" + group + " "; 
      sql = String.valueOf(sql) + ssql;
      sql = String.valueOf(sql) + " ORDER BY a.CHR_PRODUCTNAME ";
      String[][] Data = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (Data.length > 0) {
        for (int u = 0; u < Data.length; u++) {
          sb.append("<AccessoriesProduct>");
          sb.append("<Productid>" + Data[u][0] + "</Productid>");
          sb.append("<Product>" + Data[u][1] + "</Product>");
          sb.append("<Group>" + Data[u][2] + "</Group>");
          sb.append("<Desc>" + Data[u][3] + "</Desc>");
          sb.append("<Amount>" + Data[u][4] + "</Amount>");
          sb.append("</AccessoriesProduct>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<AccessoriesProducts>" + sb.toString() + "</AccessoriesProducts>");
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
  
  public static void LoadBudgetAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String year = request.getParameter("year");
      String dept = request.getParameter("dept");
      String access = request.getParameter("access");
      String startletter = request.getParameter("startletter");
      String ssql = "";
      if (!"0".equals(startletter))
        ssql = " AND b.CHR_DEPARTNAME like '" + startletter + "%'"; 
      String sql = "";
      sql = "SELECT b.CHR_DEPARTNAME,c.CHR_GROUPNAME,  a.DOU_AMOUNT,a.INT_TARGETID FROM inv_t_budgetassign a  ,com_m_depart b ,inv_m_accessoriesgroup c WHERE a.INT_DEPARTID = b.INT_DEPARTID \tAND a.INT_GROUPID = c.INT_GROUPID ";
      if (!"0".equals(dept))
        sql = String.valueOf(sql) + "  AND a.INT_DEPARTID=" + dept + " "; 
      if (!"0".equals(access))
        sql = String.valueOf(sql) + "  AND a.INT_GROUPID=" + access + " "; 
      sql = String.valueOf(sql) + ssql;
      sql = String.valueOf(sql) + " AND a.INT_YEAR = " + year + "  ORDER BY b.CHR_DEPARTNAME ";
      String[][] Data = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (Data.length > 0) {
        for (int u = 0; u < Data.length; u++) {
          sb.append("<BudgetAssign>");
          sb.append("<Deptname>" + Data[u][0] + "</Deptname>");
          sb.append("<Accessname>" + Data[u][1] + "</Accessname>");
          sb.append("<Amount>" + Data[u][2] + "</Amount>");
          sb.append("<ROW>" + Data[u][3] + "</ROW>");
          sb.append("</BudgetAssign>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<BudgetAssigns>" + sb.toString() + "</BudgetAssigns>");
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
  
  public static void LoadBudgetCheck(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String dept = request.getParameter("dept");
      String access = request.getParameter("access");
      String year = request.getParameter("year");
      String sql = "";
      sql = "SELECT COUNT(*) FROM inv_t_budgetassign WHERE INT_DEPARTID=" + 
        dept + " AND INT_YEAR=" + year + 
        " AND INT_GROUPID=" + access;
      boolean flag = false;
      if (CommonFunction.RecordExist(sql)) {
        flag = true;
      } else {
        flag = false;
      } 
      StringBuffer sb = new StringBuffer();
      sb.append("<Row>");
      if (flag) {
        sb.append("<Value>True</Value>");
      } else {
        sb.append("<Value>False</Value>");
      } 
      sb.append("</Row>");
      sb.toString();
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
  
  public static void loadPurchaseProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String id = request.getParameter("id");
      String sql = "";
      sql = "SELECT CHR_DESC,DOU_AMOUNT FROM  inv_m_accessoriesproduct WHERE INT_PRODUCTID=" + id;
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        sb.append("<Product>");
        sb.append("<Desc>" + datas[0][0] + "</Desc>");
        sb.append("<Amount>" + datas[0][1] + "</Amount>");
        sb.append("</Product>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Products>" + sb.toString() + "</Products>");
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
  
  public static void loadIndentRaise(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String dept = request.getParameter("dept");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String sql = "";
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USRTYPE");
      sql = " SELECT a.INT_PURCHASEINDENTID,a.CHR_PURCHASENO,DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'),DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME, ";
      sql = String.valueOf(sql) + " a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO,a.DOU_TOTALAMOUNT,a.CHR_STATUS,a.CHR_ACCEPT,a.CHR_ACCSTATUS,a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME,a.CHR_ACCDESC ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c";
      sql = String.valueOf(sql) + " WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID";
      sql = String.valueOf(sql) + " AND month(a.DAT_INDENTDATE)= " + month;
      sql = String.valueOf(sql) + " AND year(a.DAT_INDENTDATE)= " + year;
      sql = String.valueOf(sql) + " AND  a.INT_DEPARTID=" + dept;
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_ACCEPT='" + status + "'"; 
      sql = String.valueOf(sql) + " ORDER BY a.INT_PURCHASEINDENTID ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Product>");
          sb.append("<Id>" + datas[u][0] + "</Id>");
          sb.append("<Po>" + datas[u][1] + "</Po>");
          sb.append("<Indentdate>" + datas[u][2] + "</Indentdate>");
          sb.append("<Expectdate>" + datas[u][3] + "</Expectdate>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Contact>" + datas[u][5] + "</Contact>");
          sb.append("<Number>" + datas[u][6] + "</Number>");
          sb.append("<Amount>" + datas[u][7] + "</Amount>");
          sb.append("<Status>" + datas[u][8] + "</Status>");
          sb.append("<AdminStatus>" + datas[u][9] + "</AdminStatus>");
          sb.append("<SuperAdminStatus>" + datas[u][10] + "</SuperAdminStatus>");
          sb.append("<Empid>" + datas[u][11] + "</Empid>");
          sb.append("<Name>" + datas[u][12] + "</Name>");
          sb.append("<Desc>" + datas[u][13] + "</Desc>");
          sb.append("<usertype>" + object + "</usertype>");
          sb.append("</Product>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Products>" + sb.toString() + "</Products>");
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
  
  public static void loadIndentClose(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String dept = request.getParameter("dept");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String payment = request.getParameter("payment");
      String sql = "";
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USRTYPE");
      sql = " SELECT a.INT_PURCHASEINDENTID,a.CHR_PURCHASENO,DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'), ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME, ";
      sql = String.valueOf(sql) + " a.DOU_TOTALAMOUNT,a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME,a.CHR_ACCSTATUS , ";
      sql = String.valueOf(sql) + " a.DAT_ACCDATE,a.CHR_PURCHASEORDERNO,a.DAT_PODATE,a.CHR_PAYMENTSTATUS ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c  ";
      sql = String.valueOf(sql) + " WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID  ";
      sql = String.valueOf(sql) + " AND CHR_ACCEPT='Y' ";
      sql = String.valueOf(sql) + " AND month(a.DAT_INDENTDATE)= " + month;
      sql = String.valueOf(sql) + " AND year(a.DAT_INDENTDATE)= " + year;
      sql = String.valueOf(sql) + " AND  a.INT_DEPARTID=" + dept;
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_ACCSTATUS='" + status + "'"; 
      if (!"0".equals(payment))
        sql = String.valueOf(sql) + " AND a.CHR_PAYMENTSTATUS='" + payment + "'"; 
      sql = String.valueOf(sql) + " ORDER BY a.INT_PURCHASEINDENTID ";
      String[][] datas = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (datas.length > 0) {
        for (int u = 0; u < datas.length; u++) {
          sb.append("<Product>");
          sb.append("<Id>" + datas[u][0] + "</Id>");
          sb.append("<Po>" + datas[u][1] + "</Po>");
          sb.append("<Indentdate>" + datas[u][2] + "</Indentdate>");
          sb.append("<Expectdate>" + datas[u][3] + "</Expectdate>");
          sb.append("<Depart>" + datas[u][4] + "</Depart>");
          sb.append("<Amount>" + datas[u][5] + "</Amount>");
          sb.append("<Empid>" + datas[u][6] + "</Empid>");
          sb.append("<Name>" + datas[u][7] + "</Name>");
          sb.append("<Approval>" + datas[u][8] + "</Approval>");
          sb.append("<Approvaldate>" + datas[u][9] + "</Approvaldate>");
          sb.append("<Ponumber>" + datas[u][10] + "</Ponumber>");
          sb.append("<Podate>" + datas[u][11] + "</Podate>");
          sb.append("<Payment>" + datas[u][12] + "</Payment>");
          sb.append("<usertype>" + object + "</usertype>");
          sb.append("</Product>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Products>" + sb.toString() + "</Products>");
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
  
  public static void LoadIndentPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String Status = request.getParameter("Status");
      String vendorid = request.getParameter("vendorid");
      String sql = "";
      String ssql = "";
      if (!"0".equals(vendorid))
        ssql = " AND  a.INT_VENDORID=" + vendorid + "  "; 
      String sssql = "";
      if ("1".equals(Status)) {
        sssql = " AND  a.CHR_PAYMENTSTATUS='N'   ";
      } else if ("2".equals(Status)) {
        sssql = " AND  a.CHR_PAYMENTSTATUS='Y'   ";
      } else if ("0".equals(Status)) {
        sssql = " ";
      } 
      sql = " SELECT a.CHR_PURCHASENO  ,b.CHR_VENDORNAME ,a.DOU_TOTALAMOUNT ,  a.DOU_PAIDAMOUNT, ";
      sql = String.valueOf(sql) + 
        "  (a.DOU_TOTALAMOUNT-a.DOU_PAIDAMOUNT),a.CHR_PAYMENTSTATUS FROM inv_t_purchaseindent  a, inv_m_vendorsinformation  b ";
      sql = String.valueOf(sql) + " WHERE a.INT_VENDORID=b.INT_VENDORID " + ssql + sssql;
      sql = String.valueOf(sql) + " ORDER BY a.DAT_INDENTDATE ";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      String StartLetter = request.getParameter("id");
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][0].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter)) {
            sb.append("<Payment>");
            sb.append("<Purchaseid>" + readData[u][0].replace("&", " AND ") + "</Purchaseid>");
            sb.append("<Vendorname>" + readData[u][1].replace("&", " AND ") + "</Vendorname>");
            sb.append("<Totalamount>" + readData[u][2] + "</Totalamount>");
            sb.append("<Paidamount>" + readData[u][3] + "</Paidamount>");
            sb.append("<Blanace>" + readData[u][4] + "</Blanace>");
            sb.append("<Status>" + readData[u][5] + "</Status>");
            sb.append("</Payment>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
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
  
  public static void loadPaymentCommitment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      txtSer = txtSer.toUpperCase();
      String month = request.getParameter("month");
      String customer = request.getParameter("customer");
      String division = request.getParameter("division");
      String salestype = request.getParameter("salestype");
      int year = Integer.parseInt(request.getParameter("year"));
      String Branch = request.getParameter("Branch");
      String day = request.getParameter("day");
      String sql = "";
      if ("C".equals(salestype)) {
        sql = " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID), (SELECT count(d.CHR_INVOICETYPE)  FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_TOTALAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_directsales a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID  AND a.CHR_CANCEL='N'  ";
        if (!"0".equals(Branch))
          sql = String.valueOf(sql) + " AND a.INT_BRANCHID = " + Branch; 
        if (!"0".equals(customer))
          sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
        if (!"0".equals(salestype))
          sql = String.valueOf(sql) + " AND b.CHR_INVOICETYPE = '" + salestype + "'"; 
        if (!"0".equals(division))
          sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
        if (!"0".equals(month))
          sql = String.valueOf(sql) + " AND month(a.DAT_SALESDATE) = " + Integer.parseInt(month); 
        sql = String.valueOf(sql) + " AND year(a.DAT_SALESDATE) = " + year;
        if (!"0".equals(day))
          sql = String.valueOf(sql) + " AND DAY(a.DAT_SALESDATE) = " + day; 
        if (!"0".equals(txtSer))
          sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) LIKE '" + txtSer + "%'"; 
        sql = String.valueOf(sql) + " GROUP  BY  b.CHR_SALESNO ORDER BY  a.INT_SALESID ";
      } else if ("S".equals(salestype)) {
        sql = " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID), (SELECT count(d.CHR_INVOICETYPE) FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_NETAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_servicebilling a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID  AND a.CHR_CANCEL='N' ";
        if (!"0".equals(Branch))
          sql = String.valueOf(sql) + " AND a.INT_BRANCHID = " + Branch; 
        if (!"0".equals(customer))
          sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
        if (!"0".equals(salestype))
          sql = String.valueOf(sql) + " AND b.CHR_INVOICETYPE = '" + salestype + "'"; 
        if (!"0".equals(division))
          sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
        if (!"0".equals(month))
          sql = String.valueOf(sql) + " AND month(a.DAT_SALESDATE) = " + Integer.parseInt(month); 
        sql = String.valueOf(sql) + " AND year(a.DAT_SALESDATE) = " + year;
        if (!"0".equals(day))
          sql = String.valueOf(sql) + " AND DAY(a.DAT_SALESDATE) = " + day; 
        if (!"0".equals(txtSer))
          sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) LIKE '" + txtSer + "%'"; 
        sql = String.valueOf(sql) + "  GROUP  BY  b.CHR_SALESNO  ORDER BY b.CHR_SALESNO";
      } else if ("D".equals(salestype)) {
        sql = " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID), (SELECT count(d.CHR_INVOICETYPE) FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_NETAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_directbilling a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID ";
        if (!"0".equals(Branch))
          sql = String.valueOf(sql) + " AND a.INT_BRANCHID = " + Branch; 
        if (!"0".equals(customer))
          sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = " + customer; 
        if (!"0".equals(salestype))
          sql = String.valueOf(sql) + " AND b.CHR_INVOICETYPE = '" + salestype + "'"; 
        if (!"0".equals(division))
          sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
        if (!"0".equals(month))
          sql = String.valueOf(sql) + " AND month(a.DAT_SALESDATE) = " + Integer.parseInt(month); 
        sql = String.valueOf(sql) + " AND year(a.DAT_SALESDATE) = " + year;
        if (!"0".equals(day))
          sql = String.valueOf(sql) + " AND DAY(a.DAT_SALESDATE) = " + day; 
        if (!"0".equals(txtSer))
          sql = String.valueOf(sql) + " AND  FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) LIKE '" + txtSer + "%'"; 
        sql = String.valueOf(sql) + "  GROUP  BY  b.CHR_SALESNO  ORDER BY  SUBSTRING_INDEX(b.CHR_SALESNO, '/',1)  ,a.DAT_SALESDATE  ";
      } 
      System.out.println(sql);
      String[][] readData = CommonFunction.RecordSetArray(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directSale>");
          sb.append("<InvoiceNumber>" + readData[u][0] + "</InvoiceNumber>");
          sb.append("<InvoiceDate>" + readData[u][1] + "</InvoiceDate>");
          sb.append("<Customer>" + readData[u][2].replace("&", " AND ") + "</Customer>");
          sb.append("<NoofDue>" + readData[u][3] + "</NoofDue>");
          sb.append("<InvoiceAmount>" + readData[u][4] + "</InvoiceAmount>");
          sb.append("<Cdate>" + readData[u][5] + "</Cdate>");
          sb.append("<CAmount>" + readData[u][6] + "</CAmount>");
          sb.append("<Status>" + readData[u][7] + "</Status>");
          sb.append("</directSale>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
  
  public static void LoadCustomerSalesCreditlimt(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String customerId = request.getParameter("customerId");
      String type = request.getParameter("type");
      double customercreditlimit = Double.parseDouble(CommonFunctions.QueryExecute("SELECT DOU_CREDITLIMIT  FROM inv_m_customerinfo  WHERE INT_CUSTOMERID=" + customerId)[0][0]);
      String sql = "";
      if ("C".equals(type)) {
        sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS  ";
        sql = String.valueOf(sql) + " ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME    ";
        sql = String.valueOf(sql) + "  from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d, com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'   ";
        sql = String.valueOf(sql) + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID  ";
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=d.INT_DIVIID  AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID  ";
        sql = String.valueOf(sql) + " AND DATEDIFF(NOW(),a.DAT_SALESDATE) >= 20 ";
        sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID=  " + customerId;
        sql = String.valueOf(sql) + " ORDER BY  a.DAT_SALESDATE";
      } else if ("D".equals(type)) {
        sql = "";
        sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS   ";
        sql = String.valueOf(sql) + "  ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME  from inv_t_directbilling a , inv_m_customerinfo b ,   ";
        sql = String.valueOf(sql) + "  com_m_staff c ,inv_m_division d ,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'    ";
        sql = String.valueOf(sql) + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID   ";
        sql = String.valueOf(sql) + "  AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID    ";
        sql = String.valueOf(sql) + " AND DATEDIFF(NOW(),a.DAT_SALESDATE) >= 20 ";
        sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID=  " + customerId;
        sql = String.valueOf(sql) + " ORDER BY  a.DAT_SALESDATE";
      } else if ("S".equals(type)) {
        sql = "";
        sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS   ";
        sql = String.valueOf(sql) + "  ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME  from inv_t_servicebilling a , inv_m_customerinfo b ,    ";
        sql = String.valueOf(sql) + "  com_m_staff c ,inv_m_division d,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'    ";
        sql = String.valueOf(sql) + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID   ";
        sql = String.valueOf(sql) + "  AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID   ";
        sql = String.valueOf(sql) + " AND DATEDIFF(NOW(),a.DAT_SALESDATE) >= 20 ";
        sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID=  " + customerId;
        sql = String.valueOf(sql) + " ORDER BY  a.DAT_SALESDATE";
      } 
      System.out.println(sql);
      StringBuffer sb = new StringBuffer();
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Saleno>" + readData[u][0] + "</Saleno>");
          sb.append("<creditsum>" + customercreditlimit + "</creditsum>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Daysleft>" + readData[u][2] + "</Daysleft>");
          sb.append("<Amount>" + readData[u][3] + "</Amount>");
          sb.append("<PaymentStatus>" + readData[u][4] + "</PaymentStatus>");
          sb.append("<Customer>" + readData[u][5] + "</Customer>");
          sb.append("<Stafff>" + readData[u][6] + "</Stafff>");
          sb.append("<Division>" + readData[u][7] + "</Division>");
          sb.append("<Company>" + readData[u][8] + "</Company>");
          sb.append("<Branch>" + readData[u][9] + "</Branch>");
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
  
  public static void LoadCustomerSalesCreditAmount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String customerId = request.getParameter("customerId");
      double customercreditlimit = Double.parseDouble(CommonFunctions.QueryExecute("SELECT DOU_CREDITLIMIT  FROM inv_m_customerinfo  WHERE INT_CUSTOMERID=" + customerId)[0][0]);
      if (customercreditlimit > 0.0D) {
        StringBuffer sb = new StringBuffer();
        sb.append("<Row>");
        sb.append("<creditsum>" + customercreditlimit + "</creditsum>");
        sb.append("</Row>");
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
  
  public static void loadSalesAnalysisGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String years = request.getParameter("year");
      String Branch = request.getParameter("Branch");
      String period = request.getParameter("period");
      String division = request.getParameter("division");
      String payType = request.getParameter("payType");
      String divisionid = request.getParameter("divisionid");
      String sql = "";
      String dsql = "";
      int year = Integer.parseInt(years);
      if (!"0".equals(division))
        dsql = " AND a.INT_DIVIID=" + division + "   "; 
      sql = "SELECT INT_DIVIID,CHR_DIVICODE FROM inv_m_division  WHERE INT_DIVIID>=1";
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND  INT_DIVIID=" + division + "   "; 
      if (!"0".equals(divisionid))
        sql = String.valueOf(sql) + " AND CHR_DIVICODE LIKE '" + divisionid + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_DIVICODE ";
      String tablename = "";
      String columnname = "";
      if ("CustomerSales".equals(payType)) {
        tablename = " inv_t_directsales a ";
        columnname = " a.DOU_TOTALAMOUNT ";
      } else if ("DirectBilling".equals(payType)) {
        tablename = " inv_t_directbilling a";
        columnname = "  a.DOU_NETAMOUNT ";
      } else if ("ServiceBilling".equals(payType)) {
        tablename = " inv_t_servicebilling a  ";
        columnname = " a.DOU_NETAMOUNT ";
      } 
      String[][] data = CommonFunctions.QueryExecute(sql);
      if (data.length > 0) {
        StringBuffer sb = new StringBuffer();
        int totalnumber = 0;
        double totalamount = 0.0D;
        if ("1".equals(period))
          for (int u = 0; u < data.length; u++) {
            totalnumber = 0;
            totalamount = 0.0D;
            sb.append("<Row>");
            sb.append("<Divid>" + data[u][0] + "</Divid>");
            sb.append("<Divname>" + data[u][1] + "</Divname>");
            dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + " FROM " + tablename + " ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-04-31' ";
            sql = String.valueOf(sql) + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("April : " + sql);
            String[][] aprildata = CommonFunctions.QueryExecute(sql);
            if (aprildata.length > 0) {
              sb.append("<Month1>" + aprildata[0][3] + "</Month1>");
              sb.append("<AmtMonth1>" + aprildata[0][4] + "</AmtMonth1>");
              totalnumber += Integer.parseInt(aprildata[0][3]);
              totalamount += Double.parseDouble(aprildata[0][4]);
            } else {
              sb.append("<Month1>0</Month1>");
              sb.append("<AmtMonth1>0</AmtMonth1>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + " FROM  " + tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + "-05-01' AND DAT_SALESDATE <='" + year + "-05-31' ";
            sql = String.valueOf(sql) + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("May : " + sql);
            String[][] maydata = CommonFunctions.QueryExecute(sql);
            if (maydata.length > 0) {
              sb.append("<Month2>" + maydata[0][3] + "</Month2>");
              sb.append("<AmtMonth2>" + maydata[0][4] + "</AmtMonth2>");
              totalnumber += Integer.parseInt(maydata[0][3]);
              totalamount += Double.parseDouble(maydata[0][4]);
            } else {
              sb.append("<Month2>0</Month2>");
              sb.append("<AmtMonth2>0</AmtMonth2>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + "-06-01' AND DAT_SALESDATE <='" + year + "-06-31' ";
            sql = String.valueOf(sql) + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("June : " + sql);
            String[][] junedata = CommonFunctions.QueryExecute(sql);
            if (junedata.length > 0) {
              sb.append("<Month3>" + junedata[0][3] + "</Month3>");
              sb.append("<AmtMonth3>" + junedata[0][4] + "</AmtMonth3>");
              totalnumber += Integer.parseInt(junedata[0][3]);
              totalamount += Double.parseDouble(junedata[0][4]);
            } else {
              sb.append("<Month3>0</Month3>");
              sb.append("<AmtMonth3>0</AmtMonth3>");
            } 
            sb.append("<Totalnumber>" + totalnumber + "</Totalnumber>");
            sb.append("<TotalAmount>" + totalamount + "</TotalAmount>");
            sb.append("</Row>");
          }  
        if ("2".equals(period))
          for (int u = 0; u < data.length; u++) {
            totalnumber = 0;
            totalamount = 0.0D;
            sb.append("<Row>");
            sb.append("<Divid>" + data[u][0] + "</Divid>");
            sb.append("<Divname>" + data[u][1] + "</Divname>");
            dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
              "-07-01' AND DAT_SALESDATE <='" + year + 
              "-07-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("July : " + sql);
            String[][] julydata = CommonFunctions.QueryExecute(sql);
            if (julydata.length > 0) {
              sb.append("<Month1>" + julydata[0][3] + "</Month1>");
              sb.append("<AmtMonth1>" + julydata[0][4] + 
                  "</AmtMonth1>");
              totalnumber += 
                Integer.parseInt(julydata[0][3]);
              totalamount += 
                Double.parseDouble(julydata[0][4]);
            } else {
              sb.append("<Month1>0</Month1>");
              sb.append("<AmtMonth1>0</AmtMonth1>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
              "-08-01' AND DAT_SALESDATE <='" + year + 
              "-08-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("August : " + sql);
            String[][] augdata = CommonFunctions.QueryExecute(sql);
            if (augdata.length > 0) {
              sb.append("<Month2>" + augdata[0][3] + "</Month2>");
              sb.append("<AmtMonth2>" + augdata[0][4] + 
                  "</AmtMonth2>");
              totalnumber += 
                Integer.parseInt(augdata[0][3]);
              totalamount += 
                Double.parseDouble(augdata[0][4]);
            } else {
              sb.append("<Month2>0</Month2>");
              sb.append("<AmtMonth2>0</AmtMonth2>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
              "-09-01' AND DAT_SALESDATE <='" + year + 
              "-09-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("September : " + sql);
            String[][] sepdata = CommonFunctions.QueryExecute(sql);
            if (sepdata.length > 0) {
              sb.append("<Month3>" + sepdata[0][3] + "</Month3>");
              sb.append("<AmtMonth3>" + sepdata[0][4] + 
                  "</AmtMonth3>");
              totalnumber += 
                Integer.parseInt(sepdata[0][3]);
              totalamount += 
                Double.parseDouble(sepdata[0][4]);
            } else {
              sb.append("<Month3>0</Month3>");
              sb.append("<AmtMonth3>0</AmtMonth3>");
            } 
            sb.append("<Totalnumber>" + totalnumber + 
                "</Totalnumber>");
            sb.append("<TotalAmount>" + totalamount + 
                "</TotalAmount>");
            sb.append("</Row>");
          }  
        if ("3".equals(period))
          for (int u = 0; u < data.length; u++) {
            totalnumber = 0;
            totalamount = 0.0D;
            sb.append("<Row>");
            sb.append("<Divid>" + data[u][0] + "</Divid>");
            sb.append("<Divname>" + data[u][1] + "</Divname>");
            dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
              "-10-01' AND DAT_SALESDATE <='" + year + 
              "-10-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("October : " + sql);
            String[][] octdata = CommonFunctions.QueryExecute(sql);
            if (octdata.length > 0) {
              sb.append("<Month1>" + octdata[0][3] + "</Month1>");
              sb.append("<AmtMonth1>" + octdata[0][4] + 
                  "</AmtMonth1>");
              totalnumber += 
                Integer.parseInt(octdata[0][3]);
              totalamount += 
                Double.parseDouble(octdata[0][4]);
            } else {
              sb.append("<Month1>0</Month1>");
              sb.append("<AmtMonth1>0</AmtMonth1>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
              "-11-01' AND DAT_SALESDATE <='" + year + 
              "-11-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("November : " + sql);
            String[][] novdata = 
              CommonFunctions.QueryExecute(sql);
            if (novdata.length > 0) {
              sb.append("<Month2>" + novdata[0][3] + "</Month2>");
              sb.append("<AmtMonth2>" + novdata[0][4] + 
                  "</AmtMonth2>");
              totalnumber += 
                Integer.parseInt(novdata[0][3]);
              totalamount += 
                Double.parseDouble(novdata[0][4]);
            } else {
              sb.append("<Month2>0</Month2>");
              sb.append("<AmtMonth2>0</AmtMonth2>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1   ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
              "-12-01' AND DAT_SALESDATE <='" + year + 
              "-12-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("December : " + sql);
            String[][] decdata = CommonFunctions.QueryExecute(sql);
            if (decdata.length > 0) {
              sb.append("<Month3>" + decdata[0][3] + "</Month3>");
              sb.append("<AmtMonth3>" + decdata[0][4] + 
                  "</AmtMonth3>");
              totalnumber += 
                Integer.parseInt(decdata[0][3]);
              totalamount += 
                Double.parseDouble(decdata[0][4]);
            } else {
              sb.append("<Month3>0</Month3>");
              sb.append("<AmtMonth3>0</AmtMonth3>");
            } 
            sb.append("<Totalnumber>" + totalnumber + 
                "</Totalnumber>");
            sb.append("<TotalAmount>" + totalamount + 
                "</TotalAmount>");
            sb.append("</Row>");
          }  
        if ("4".equals(period))
          for (int u = 0; u < data.length; u++) {
            totalnumber = 0;
            totalamount = 0.0D;
            sb.append("<Row>");
            sb.append("<Divid>" + data[u][0] + "</Divid>");
            sb.append("<Divname>" + data[u][1] + "</Divname>");
            dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-01-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-01-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("January : " + sql);
            String[][] jandata = CommonFunctions.QueryExecute(sql);
            if (jandata.length > 0) {
              sb.append("<Month1>" + jandata[0][3] + "</Month1>");
              sb.append("<AmtMonth1>" + jandata[0][4] + 
                  "</AmtMonth1>");
              totalnumber += 
                Integer.parseInt(jandata[0][3]);
              totalamount += 
                Double.parseDouble(jandata[0][4]);
            } else {
              sb.append("<Month1>0</Month1>");
              sb.append("<AmtMonth1>0</AmtMonth1>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-02-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-02-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("February : " + sql);
            String[][] febdata = CommonFunctions.QueryExecute(sql);
            if (febdata.length > 0) {
              sb.append("<Month2>" + febdata[0][3] + "</Month2>");
              sb.append("<AmtMonth2>" + febdata[0][4] + 
                  "</AmtMonth2>");
              totalnumber += 
                Integer.parseInt(febdata[0][3]);
              totalamount += 
                Double.parseDouble(febdata[0][4]);
            } else {
              sb.append("<Month2>0</Month2>");
              sb.append("<AmtMonth2>0</AmtMonth2>");
            } 
            sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
              columnname + 
              " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
            sql = String.valueOf(sql) + 
              " FROM  " + 
              tablename + 
              "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
            sql = String.valueOf(sql) + " where a.INT_DIVIID=b.INT_DIVIID  ";
            sql = String.valueOf(sql) + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
            sql = String.valueOf(sql) + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
            if (!"0".equals(Branch))
              sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
            sql = String.valueOf(sql) + dsql;
            sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + (year + 1) + 
              "-03-01' AND DAT_SALESDATE <='" + (year + 1) + 
              "-03-31' ";
            sql = String.valueOf(sql) + 
              " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
            System.out.println("March : " + sql);
            String[][] mardata = 
              CommonFunctions.QueryExecute(sql);
            if (mardata.length > 0) {
              sb.append("<Month3>" + mardata[0][3] + "</Month3>");
              sb.append("<AmtMonth3>" + mardata[0][4] + 
                  "</AmtMonth3>");
              totalnumber += 
                Integer.parseInt(mardata[0][3]);
              totalamount += 
                Double.parseDouble(mardata[0][4]);
            } else {
              sb.append("<Month3>0</Month3>");
              sb.append("<AmtMonth3>0</AmtMonth3>");
            } 
            sb.append("<Totalnumber>" + totalnumber + 
                "</Totalnumber>");
            sb.append("<TotalAmount>" + totalamount + 
                "</TotalAmount>");
            sb.append("</Row>");
          }  
        if ("5".equals(period))
          for (int u = 0; u < data.length; u++) {
            totalnumber = 0;
            totalamount = 0.0D;
            sb.append("<Row>");
            sb.append("<Divid>" + data[u][0] + "</Divid>");
            sb.append("<Divname>" + data[u][1] + "</Divname>");
            dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
            for (int x = 1; x < 13; x++) {
              if (x <= 3) {
                sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
                  columnname + 
                  " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                sql = String.valueOf(sql) + 
                  " FROM  " + 
                  tablename + 
                  "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                sql = String.valueOf(sql) + 
                  " where a.INT_DIVIID=b.INT_DIVIID  ";
                sql = String.valueOf(sql) + 
                  " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                sql = String.valueOf(sql) + 
                  " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                if (!"0".equals(Branch))
                  sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
                sql = String.valueOf(sql) + dsql;
                sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + (
                  year + 1) + "-" + x + 
                  "-01' AND DAT_SALESDATE <='" + (
                  year + 1) + "-" + x + "-31' ";
                sql = String.valueOf(sql) + 
                  " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
              } else {
                sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + 
                  columnname + 
                  " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                sql = String.valueOf(sql) + 
                  " FROM  " + 
                  tablename + 
                  "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                sql = String.valueOf(sql) + 
                  " where a.INT_DIVIID=b.INT_DIVIID  ";
                sql = String.valueOf(sql) + 
                  " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                sql = String.valueOf(sql) + 
                  " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                if (!"0".equals(Branch))
                  sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
                sql = String.valueOf(sql) + dsql;
                sql = String.valueOf(sql) + " AND  DAT_SALESDATE >='" + year + 
                  "-" + x + 
                  "-01' AND DAT_SALESDATE <='" + year + 
                  "-" + x + "-31' ";
                sql = String.valueOf(sql) + 
                  " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
              } 
              String[][] mardata = 
                CommonFunctions.QueryExecute(sql);
              if (mardata.length > 0) {
                sb.append("<Month" + x + ">" + mardata[0][3] + 
                    "</Month" + x + ">");
                sb.append("<AmtMonth" + x + ">" + mardata[0][4] + 
                    "</AmtMonth" + x + ">");
                totalnumber += 
                  Integer.parseInt(mardata[0][3]);
                totalamount += 
                  Double.parseDouble(mardata[0][4]);
              } else {
                sb.append("<Month" + x + ">0</Month" + x + ">");
                sb.append("<AmtMonth" + x + ">0</AmtMonth" + x + 
                    ">");
              } 
            } 
            sb.append("<Totalnumber>" + totalnumber + 
                "</Totalnumber>");
            sb.append("<TotalAmount>" + totalamount + 
                "</TotalAmount>");
            sb.append("</Row>");
          }  
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadPurchaseRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String status = request.getParameter("status");
      String sql = "";
      HttpSession session = request.getSession();
      String usertype = session.getAttribute("USERTYPE").toString();
      String datelock = CommonFunctions.QueryExecute("SELECT INT_PURCHASEREQUEST_LOCK FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
      sql = " SELECT ";
      sql = String.valueOf(sql) + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + " h.CHR_NAME,h.CHR_NAME, ";
      sql = String.valueOf(sql) + " f.CHR_PAYMENTNAME, ";
      sql = String.valueOf(sql) + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ,a.CHR_PR_PARTIALLY_RECEIVED,";
      sql = String.valueOf(sql) + " if(a.CHR_PR_PARTIALLY_RECEIVED ='N','Pending',(if(CHR_PR_PARTIALLY_RECEIVED='Y','Closed','Partially Inward'))) ,";
      sql = String.valueOf(sql) + " if(a.CHR_CLOSEDSTATUS ='Y', ";
      sql = String.valueOf(sql) + "     if( (DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock + "),'N','Y'  ) ";
      sql = String.valueOf(sql) + "     ,'' ";
      sql = String.valueOf(sql) + "   )        ";
      sql = String.valueOf(sql) + " , a.CHR_BYBACK, a.CHR_SALESNO, ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS,a.INT_PROGRESSBAR ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d, inv_m_customergroup h,  ";
      sql = String.valueOf(sql) + " inv_m_paymentterms f,com_m_staff g ";
      sql = String.valueOf(sql) + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID =c.INT_DIVIID ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID = h.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
      sql = String.valueOf(sql) + " AND a.CHR_REF=g.CHR_EMPID ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_REQUESTDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_REQUESTDATE)=" + year; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_REQUESTDATE)=" + day; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_APPROVEDSTATUS='" + status + "'"; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND h.CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY a.INT_POREQUESTID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<RowID>" + readData[u][0].trim() + "</RowID>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Division>" + readData[u][2].trim() + "</Division>");
          sb.append("<Requestno>" + readData[u][3].trim() + "</Requestno>");
          sb.append("<Date>" + readData[u][4].trim() + "</Date>");
          sb.append("<Customer>" + readData[u][5].replace("&", "").trim() + "</Customer>");
          sb.append("<Vendorpayment>" + readData[u][7].replace("&", "").trim() + "</Vendorpayment>");
          sb.append("<Customerpayment>" + readData[u][8].replace("&", "").trim() + "</Customerpayment>");
          sb.append("<Ref>" + readData[u][9].trim() + "</Ref>");
          sb.append("<Staff>" + readData[u][10].trim() + "</Staff>");
          sb.append("<Status>" + readData[u][11].trim() + "</Status>");
          sb.append("<PRStatus>" + readData[u][12].trim() + "</PRStatus>");
          sb.append("<Inward>" + readData[u][13].trim() + "</Inward>");
          sb.append("<Age>" + readData[u][15].trim() + "</Age>");
          sb.append("<usertype>" + usertype + "</usertype>");
          sb.append("<Byback>" + readData[u][16].trim() + "</Byback>");
          sb.append("<InvoiceNumber>" + readData[u][17].trim() + "</InvoiceNumber>");
          sb.append("<Bh>" + readData[u][18].trim() + "</Bh>");
          sb.append("<Admin>" + readData[u][19].trim() + "</Admin>");
          sb.append("<Stock>" + readData[u][20].trim() + "</Stock>");
          sb.append("<Finance>" + readData[u][21].trim() + "</Finance>");
          sb.append("<Bar>" + readData[u][22].trim() + "</Bar>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void LoadPurchaseRequestdependsonVendor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String vendorid = request.getParameter("vendorid");
      String datelock = CommonFunctions.QueryExecute("SELECT INT_PURCHASEREQUEST_LOCK FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
      String sql = " ";
      sql = " SELECT  a.CHR_POREQUESTNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a ,inv_t_purchaserequestitem b  ";
      sql = String.valueOf(sql) + " WHERE a.CHR_POREQUESTNO =b.CHR_POREQUESTNO AND a.CHR_CLOSEDSTATUS='Y' ";
      if (!"0".equals(vendorid))
        sql = String.valueOf(sql) + " AND b.INT_VENDORID=" + vendorid; 
      sql = String.valueOf(sql) + " AND a.CHR_PR_PARTIALLY_RECEIVED !='Y'  ";
      sql = String.valueOf(sql) + "   AND  DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock;
      sql = String.valueOf(sql) + "  GROUP BY a.CHR_POREQUESTNO  ";
      sql = String.valueOf(sql) + " ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Id>" + readData[u][0].trim() + "</Id>");
          sb.append("<Name>" + readData[u][1].replaceAll("&", " AND ") + "</Name>");
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
  
  public static void loadBybackSalesnumber(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "SELECT CHR_SALESNO FROM  inv_t_directsales  WHERE CHR_CANCEL ='N' AND CHR_BYBACK='Y' AND CHR_BYBACKINWARD ='N' ORDER BY DAT_SALESDATE ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Invoice>" + readData[u][0].trim() + "</Invoice>");
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
  
  public static void loadPurchaseRequestTaken(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String itype = request.getParameter("itype");
      String item = request.getParameter("item");
      String vendor = request.getParameter("vendor");
      String Branch = request.getParameter("Branch");
      String sql = "";
      sql = "SELECT  c.CHR_BRANCHNAME, d.CHR_DIVICODE,a.CHR_POREQUESTNO , ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
      sql = String.valueOf(sql) + " FIND_A_VENDOR_NAME(b.INT_VENDORID), ";
      sql = String.valueOf(sql) + " if(b.CHR_TYPE='I','Item','Product'), ";
      sql = String.valueOf(sql) + " if(b.CHR_TYPE='I', ";
      sql = String.valueOf(sql) + "  (SELECT  e.CHR_ITEMNAME FROM inv_m_item e WHERE e.CHR_ITEMID= b.CHR_ITEMID), ";
      sql = String.valueOf(sql) + "  (SELECT f.CHR_PRODUCTCODE FROM inv_m_produtlist f WHERE f.CHR_PRODUCTID= b.CHR_ITEMID) ";
      sql = String.valueOf(sql) + " ) , ";
      sql = String.valueOf(sql) + " if(b.CHR_TYPE='I', ";
      sql = String.valueOf(sql) + "  (SELECT  e1.CHR_DES FROM inv_m_item e1 WHERE e1.CHR_ITEMID= b.CHR_ITEMID), ";
      sql = String.valueOf(sql) + "  (SELECT f1.CHR_PRODUCTDESC FROM inv_m_produtlist f1 WHERE f1.CHR_PRODUCTID= b.CHR_ITEMID) ";
      sql = String.valueOf(sql) + " ) ,b.INT_QUANTITY, ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ";
      sql = String.valueOf(sql) + " FROM  inv_t_purchaserequest a, inv_t_purchaserequestitem  b, com_m_branch c, inv_m_division d ";
      sql = String.valueOf(sql) + " WHERE a.CHR_POREQUESTNO =b.CHR_POREQUESTNO ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID =d.INT_DIVIID ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_REQUESTDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_REQUESTDATE)=" + year; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_REQUESTDATE)=" + day; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(vendor))
        sql = String.valueOf(sql) + " AND b.INT_VENDORID=" + vendor; 
      if (!"0".equals(itype))
        if ("1".equals(itype)) {
          sql = String.valueOf(sql) + " AND b.CHR_TYPE = 'I'";
        } else {
          sql = String.valueOf(sql) + " AND b.CHR_TYPE = 'P'";
        }  
      if (!"0".equals(item))
        sql = String.valueOf(sql) + " AND b.CHR_ITEMID = '" + item + "'"; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " GROUP BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
      sql = String.valueOf(sql) + " FIND_A_VENDOR_NAME(b.INT_VENDORID), ";
      sql = String.valueOf(sql) + " a.CHR_POREQUESTNO,a.INT_BRANCHID,a.INT_DIVIID,b.CHR_TYPE ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Branch>" + readData[u][0].trim() + "</Branch>");
          sb.append("<Division>" + readData[u][1].trim() + "</Division>");
          sb.append("<Requestno>" + readData[u][2].trim() + "</Requestno>");
          sb.append("<Date>" + readData[u][3].trim() + "</Date>");
          sb.append("<Customer>" + readData[u][4].replace("&", "").trim() + "</Customer>");
          sb.append("<Vendor>" + readData[u][5].replace("&", "").trim() + "</Vendor>");
          sb.append("<Type>" + readData[u][6].replace("&", "").trim() + "</Type>");
          sb.append("<Product>" + readData[u][7].replace("&", "").trim() + "</Product>");
          sb.append("<Quantity>" + readData[u][9] + "</Quantity>");
          sb.append("<Admin>" + readData[u][10].trim() + "</Admin>");
          sb.append("<Bh>" + readData[u][11].trim() + "</Bh>");
          sb.append("<Stock>" + readData[u][12].trim() + "</Stock>");
          sb.append("<Finance>" + readData[u][13].trim() + "</Finance>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadPurchaseRequestDate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String purchaserequest = request.getParameter("purchaserequest");
      String sql = "";
      sql = " SELECT  DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y')  ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a ";
      sql = String.valueOf(sql) + " WHERE a.CHR_POREQUESTNO = '" + purchaserequest + "' ";
      System.out.println(sql);
      String[][] readData = 
        CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Date>" + readData[u][0].trim() + "</Date>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadPurchaseRequestDetails(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String purchaserequest = request.getParameter("purchaserequest");
      String sql = "";
      sql = " SELECT  DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y')  ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a ";
      sql = String.valueOf(sql) + " WHERE a.CHR_POREQUESTNO = '" + purchaserequest + "' ";
      System.out.println(sql);
      String[][] Data = CommonFunctions.QueryExecute(sql);
      sql = " SELECT a.CHR_TYPE, ";
      sql = String.valueOf(sql) + " if(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
      sql = String.valueOf(sql) + 
        " if(a.CHR_TYPE='I',(SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
      sql = String.valueOf(sql) + 
        " (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID) ";
      sql = String.valueOf(sql) + " ), ";
      sql = String.valueOf(sql) + 
        " if(a.CHR_TYPE='I',(SELECT d.INT_TAXID FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
      sql = String.valueOf(sql) + 
        " (SELECT e.INT_TAXID  FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID) ";
      sql = String.valueOf(sql) + " ), ";
      sql = String.valueOf(sql) + 
        " a.CHR_ITEMID,UPPER(a.CHR_DESC),a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_PURCHASEPRICE,  ";
      sql = String.valueOf(sql) + 
        " a.DOU_UNITSALEPRICE,a.DOU_SALESPRICE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, ";
      sql = String.valueOf(sql) + 
        " a.CHR_ACCEPT,a.INT_ROWID ,a.CHR_PURCHASEWARRANTY,a.CHR_SALESWARRANTY  FROM inv_t_purchaserequestitem a  ";
      sql = String.valueOf(sql) + " WHERE a.CHR_ACCEPT='Y' AND a.CHR_POREQUESTNO='" + 
        purchaserequest + "'  ORDER BY a.CHR_TYPE ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<itypecode>" + readData[u][0] + "</itypecode>");
          sb.append("<itype>" + readData[u][1] + "</itype>");
          sb.append("<iname>" + readData[u][2] + "</iname>");
          sb.append("<itax>" + readData[u][3] + "</itax>");
          sb.append("<inamecode>" + readData[u][4].replaceAll("&", "and") + "</inamecode>");
          sb.append("<Date>" + Data[0][0].trim() + "</Date>");
          sb.append("<descc>" + readData[u][5].replaceAll("&", "AND") + "</descc>");
          sb.append("<qty>" + readData[u][6] + "</qty>");
          sb.append("<upprice>" + readData[u][7] + "</upprice>");
          sb.append("<pprice>" + readData[u][8] + "</pprice>");
          sb.append("<usprice>" + readData[u][9] + "</usprice>");
          sb.append("<sprice>" + readData[u][10] + "</sprice>");
          sb.append("<pwarranty>" + readData[u][15] + "</pwarranty>");
          sb.append("<swarranty>" + readData[u][16] + "</swarranty>");
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
  
  public static void loadPurchaseRequestDivision(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String day = request.getParameter("day");
      String sql = "";
      sql = " SELECT   ";
      sql = String.valueOf(sql) + "  a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO, ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  ";
      sql = String.valueOf(sql) + "  h.CHR_NAME,  ";
      sql = String.valueOf(sql) + " a.CHR_REF,g.CHR_STAFFNAME, ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,       ";
      sql = String.valueOf(sql) + "  a.CHR_MODE, a.CHR_CPOREF_NUMBER ,";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c, ";
      sql = String.valueOf(sql) + "  inv_m_customerinfo d,inv_m_customergroup h,   ";
      sql = String.valueOf(sql) + "  com_m_staff g ,inv_t_purchaserequestitem i   ";
      sql = String.valueOf(sql) + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID =c.INT_DIVIID   ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
      sql = String.valueOf(sql) + " AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.CHR_REF=g.CHR_EMPID   ";
      sql = String.valueOf(sql) + " AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND   a.INT_BRANCHID =" + Branch; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_REQUESTDATE)=" + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_REQUESTDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_REQUESTDATE)=" + year; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_LOW_CONTRIBUTION1='" + status + "'"; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND h.CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " GROUP BY  a.CHR_POREQUESTNO  ORDER BY a.INT_POREQUESTID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<RowID>" + readData[u][0].trim() + "</RowID>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Division>" + readData[u][2].trim() + "</Division>");
          sb.append("<Requestno>" + readData[u][3].trim() + "</Requestno>");
          sb.append("<Date>" + readData[u][4].trim() + "</Date>");
          sb.append("<Customer>" + readData[u][5].replace("&", "").trim() + "</Customer>");
          sb.append("<Ref>" + readData[u][6].trim() + "</Ref>");
          sb.append("<Staff>" + readData[u][7].trim() + "</Staff>");
          sb.append("<Status>" + readData[u][8].trim() + "</Status>");
          sb.append("<Mode>" + readData[u][9].trim() + "</Mode>");
          sb.append("<CPONumber>" + readData[u][10].trim() + "</CPONumber>");
          sb.append("<Bh>" + readData[u][11].trim() + "</Bh>");
          sb.append("<Admin>" + readData[u][12].trim() + "</Admin>");
          sb.append("<Stock>" + readData[u][13].trim() + "</Stock>");
          sb.append("<Finance>" + readData[u][14].trim() + "</Finance>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadPurchaseRequestAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String day = request.getParameter("day");
      String sql = "";
      sql = " SELECT   ";
      sql = String.valueOf(sql) + "  a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO, ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  ";
      sql = String.valueOf(sql) + "  h.CHR_NAME,  ";
      sql = String.valueOf(sql) + " a.CHR_REF,g.CHR_STAFFNAME, ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION2,       ";
      sql = String.valueOf(sql) + "  a.CHR_MODE, a.CHR_CPOREF_NUMBER, ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c, ";
      sql = String.valueOf(sql) + "  inv_m_customerinfo d,inv_m_customergroup h,   ";
      sql = String.valueOf(sql) + "  com_m_staff g ,inv_t_purchaserequestitem i   ";
      sql = String.valueOf(sql) + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID =c.INT_DIVIID   ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
      sql = String.valueOf(sql) + " AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.CHR_REF=g.CHR_EMPID   ";
      sql = String.valueOf(sql) + " AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND   a.INT_BRANCHID =" + Branch; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_REQUESTDATE)=" + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_REQUESTDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_REQUESTDATE)=" + year; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_LOW_CONTRIBUTION2='" + status + "'"; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND h.CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " GROUP BY  a.CHR_POREQUESTNO  ORDER BY a.INT_POREQUESTID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<RowID>" + readData[u][0].trim() + "</RowID>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Division>" + readData[u][2].trim() + "</Division>");
          sb.append("<Requestno>" + readData[u][3].trim() + "</Requestno>");
          sb.append("<Date>" + readData[u][4].trim() + "</Date>");
          sb.append("<Customer>" + readData[u][5].replace("&", "").trim() + "</Customer>");
          sb.append("<Ref>" + readData[u][6].trim() + "</Ref>");
          sb.append("<Staff>" + readData[u][7].trim() + "</Staff>");
          sb.append("<Status>" + readData[u][8].trim() + "</Status>");
          sb.append("<Mode>" + readData[u][9].trim() + "</Mode>");
          sb.append("<CPONumber>" + readData[u][10].trim() + "</CPONumber>");
          sb.append("<Bh>" + readData[u][11].trim() + "</Bh>");
          sb.append("<Admin>" + readData[u][12].trim() + "</Admin>");
          sb.append("<Stock>" + readData[u][13].trim() + "</Stock>");
          sb.append("<Finance>" + readData[u][14].trim() + "</Finance>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadPurchaseRequestAccept(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String day = request.getParameter("day");
      String sql = "";
      String datelock = CommonFunctions.QueryExecute("SELECT INT_PURCHASEREQUEST_LOCK FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
      sql = " SELECT ";
      sql = String.valueOf(sql) + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + " h.CHR_NAME,h.CHR_NAME, ";
      sql = String.valueOf(sql) + " f.CHR_PAYMENTNAME, ";
      sql = String.valueOf(sql) + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_APPROVEDSTATUS, ";
      sql = String.valueOf(sql) + "a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y') ,a.CHR_CLOSEDSTATUS,SUM(i.DOU_PURCHASEPRICE),  ";
      sql = String.valueOf(sql) + " if(a.CHR_CLOSEDSTATUS ='Y', ";
      sql = String.valueOf(sql) + "     if( (DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock + "),'N','Y'  ) ";
      sql = String.valueOf(sql) + "     ,'' ";
      sql = String.valueOf(sql) + "   )        ";
      sql = String.valueOf(sql) + " , a.CHR_BYBACK, a.CHR_SALESNO ,a.CHR_MODE, a.CHR_CPOREF_NUMBER  ";
      sql = String.valueOf(sql) + " ,a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2, ";
      sql = String.valueOf(sql) + " FUN_INV_OVERALL_CONTRIBUTION(a.CHR_POREQUESTNO) , a.CHR_MODE, ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS,a.INT_PROGRESSBAR ";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,inv_m_customergroup h, ";
      sql = String.valueOf(sql) + " inv_m_paymentterms f,com_m_staff g ,inv_t_purchaserequestitem i ";
      sql = String.valueOf(sql) + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID =c.INT_DIVIID ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
      sql = String.valueOf(sql) + " AND a.CHR_REF=g.CHR_EMPID ";
      sql = String.valueOf(sql) + " AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND   a.INT_BRANCHID =" + Branch; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_REQUESTDATE)=" + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_REQUESTDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_REQUESTDATE)=" + year; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_APPROVEDSTATUS='" + status + "'"; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND h.CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " GROUP BY  a.CHR_POREQUESTNO  ORDER BY a.INT_POREQUESTID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<RowID>" + readData[u][0].trim() + "</RowID>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Division>" + readData[u][2].trim() + "</Division>");
          sb.append("<Requestno>" + readData[u][3].trim() + "</Requestno>");
          sb.append("<Date>" + readData[u][4].trim() + "</Date>");
          sb.append("<Customer>" + readData[u][5].replace("&", "").trim() + "</Customer>");
          sb.append("<Vendorpayment>" + readData[u][7].replace("&", "").trim() + "</Vendorpayment>");
          sb.append("<Customerpayment>" + readData[u][8].replace("&", "").trim() + "</Customerpayment>");
          sb.append("<Ref>" + readData[u][9].trim() + "</Ref>");
          sb.append("<Staff>" + readData[u][10].trim() + "</Staff>");
          sb.append("<Status>" + readData[u][11].trim() + "</Status>");
          sb.append("<Approved>" + readData[u][12].trim() + "</Approved>");
          sb.append("<Approveddate>" + readData[u][13].trim() + "</Approveddate>");
          sb.append("<PRStatus>" + readData[u][14].trim() + "</PRStatus>");
          sb.append("<PurchaseAmount>" + readData[u][15].trim() + "</PurchaseAmount>");
          sb.append("<Age>" + readData[u][16].trim() + "</Age>");
          sb.append("<Byback>" + readData[u][17].trim() + "</Byback>");
          sb.append("<InvoiceNumber>" + readData[u][18].trim() + "</InvoiceNumber>");
          sb.append("<Mode>" + readData[u][19].trim() + "</Mode>");
          sb.append("<CPONumber>" + readData[u][20].trim() + "</CPONumber>");
          sb.append("<Divisionhead>" + readData[u][21].trim() + "</Divisionhead>");
          sb.append("<Admin>" + readData[u][22].trim() + "</Admin>");
          sb.append("<PRcontribution>" + readData[u][23].trim() + "</PRcontribution>");
          sb.append("<CPOcontribution>" + readData[u][24].trim() + "</CPOcontribution>");
          sb.append("<Admin>" + readData[u][25].trim() + "</Admin>");
          sb.append("<Bh>" + readData[u][26].trim() + "</Bh>");
          sb.append("<Stock>" + readData[u][27].trim() + "</Stock>");
          sb.append("<Finance>" + readData[u][28].trim() + "</Finance>");
          sb.append("<Bar>" + readData[u][29].trim() + "</Bar>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void loadPurchaseRequestClosed(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String status = request.getParameter("status");
      String day = request.getParameter("day");
      String sql = "";
      String datelock = CommonFunctions.QueryExecute("SELECT INT_PURCHASEREQUEST_LOCK FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
      sql = " SELECT  a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO, ";
      sql = String.valueOf(sql) + "  DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  h.CHR_NAME,h.CHR_NAME, ";
      sql = String.valueOf(sql) + " f.CHR_PAYMENTNAME,  ";
      sql = String.valueOf(sql) + " DATE_FORMAT(a.DAT_PURCHASEDATE,'%d-%b-%Y'),a.INT_CUSTOMERCOMMITMENTDAYS,DATE_FORMAT(a.DAT_COMMITMENTDATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + " a.CHR_CLOSEDSTATUS ,SUM(i.DOU_PURCHASEPRICE), a.CHR_PR_PARTIALLY_RECEIVED ,";
      sql = String.valueOf(sql) + " if(a.CHR_CLOSEDSTATUS ='Y', ";
      sql = String.valueOf(sql) + "     if( (DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock + "),'N','Y'  ) ";
      sql = String.valueOf(sql) + "     ,'' ";
      sql = String.valueOf(sql) + "   )        ";
      sql = String.valueOf(sql) + " , a.CHR_BYBACK, a.CHR_SALESNO ,a.CHR_MODE,a.CHR_CPOREF_NUMBER , ";
      sql = String.valueOf(sql) + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS  ,a.INT_PROGRESSBAR";
      sql = String.valueOf(sql) + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c, ";
      sql = String.valueOf(sql) + " inv_m_customerinfo d,    ";
      sql = String.valueOf(sql) + "  inv_m_paymentterms f, inv_m_customergroup h ,inv_t_purchaserequestitem i  ";
      sql = String.valueOf(sql) + " WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
      sql = String.valueOf(sql) + " AND a.INT_DIVIID =c.INT_DIVIID   ";
      sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID    AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
      sql = String.valueOf(sql) + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID   AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
      sql = String.valueOf(sql) + " AND ( a.CHR_APPROVEDSTATUS='Y' OR a.CHR_APPROVEDSTATUS='P')";
      if (!"0".equals(Branch))
        sql = String.valueOf(sql) + " AND   a.INT_BRANCHID =" + Branch; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_REQUESTDATE)=" + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_REQUESTDATE)=" + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_REQUESTDATE)=" + year; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND a.CHR_CLOSEDSTATUS ='" + status + "'"; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND h.CHR_NAME LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + 
        " GROUP BY  a.CHR_POREQUESTNO   ORDER BY a.INT_POREQUESTID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<RowID>" + readData[u][0].trim() + "</RowID>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Division>" + readData[u][2].trim() + "</Division>");
          sb.append("<Requestno>" + readData[u][3].trim() + "</Requestno>");
          sb.append("<Date>" + readData[u][4].trim() + "</Date>");
          sb.append("<Customer>" + readData[u][5].replace("&", "").trim() + "</Customer>");
          sb.append("<Vendorpayment>" + readData[u][7].replace("&", "").trim() + "</Vendorpayment>");
          sb.append("<Pdate>" + readData[u][8].replace("&", "").trim() + "</Pdate>");
          sb.append("<Cdays>" + readData[u][9].trim() + "</Cdays>");
          sb.append("<Cdate>" + readData[u][10].trim() + "</Cdate>");
          sb.append("<Status>" + readData[u][11].trim() + "</Status>");
          sb.append("<PurchaseAmount>" + readData[u][12].trim() + "</PurchaseAmount>");
          sb.append("<Received>" + readData[u][13].trim() + "</Received>");
          sb.append("<Age>" + readData[u][14].trim() + "</Age>");
          sb.append("<Byback>" + readData[u][15].trim() + "</Byback>");
          sb.append("<InvoiceNumber>" + readData[u][16].trim() + "</InvoiceNumber>");
          sb.append("<Mode>" + readData[u][17].trim() + "</Mode>");
          sb.append("<CPONumber>" + readData[u][18].trim() + "</CPONumber>");
          sb.append("<Admin>" + readData[u][19].trim() + "</Admin>");
          sb.append("<Bh>" + readData[u][20].trim() + "</Bh>");
          sb.append("<Stock>" + readData[u][21].trim() + "</Stock>");
          sb.append("<Finance>" + readData[u][22].trim() + "</Finance>");
          sb.append("<Bar>" + readData[u][23].trim() + "</Bar>");
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
  
  public static void LoadSalesInstallation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      txtSer = txtSer.toUpperCase();
      String month = request.getParameter("month");
      String customer = request.getParameter("customer");
      String division = request.getParameter("division");
      String status = request.getParameter("status");
      String branch = request.getParameter("branch");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String sql = " SELECT a.CHR_SALESNO, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO,a.CHR_INSTALLATION_STATUS, ";
      sql = String.valueOf(sql) + " if(a.CHR_DELIVERY='P','PROGRESS',if(a.CHR_DELIVERY='Y','DELIVERED',if(a.CHR_DELIVERY='R','REJECT','PENDING'))) ";
      sql = String.valueOf(sql) + " FROM inv_t_directsales a , inv_m_customerinfo b ";
      sql = String.valueOf(sql) + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_DELIVERY NOT IN ('N','R') ";
      sql = String.valueOf(sql) + 
        " AND a.CHR_INSTALLATION ='Y'   AND a.INT_SALESSTATUS=1  AND a.CHR_CANCEL='N' ";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + "  AND a.INT_BRANCHID = " + branch; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + "   AND a.INT_CUSTOMERID = " + customer; 
      if ("Y".equals(status)) {
        sql = String.valueOf(sql) + "    AND a.CHR_INSTALLATION_STATUS ='Y'";
      } else if ("N".equals(status)) {
        sql = String.valueOf(sql) + "    AND a.CHR_INSTALLATION_STATUS ='N'";
      } 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID = " + division; 
      if (!"0".equals(mon))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE) =" + mon; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_SALESDATE)=" + year;
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + " order by a.INT_SALESID  ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directSale>");
          sb.append("<salesno>" + readData[u][0] + "</salesno>");
          sb.append("<salesdate>" + readData[u][1] + "</salesdate>");
          sb.append("<custname>" + readData[u][2].trim().replace("&", "98650") + "</custname>");
          sb.append("<contactperson>" + readData[u][3] + "</contactperson>");
          sb.append("<contactphone>" + readData[u][4] + "</contactphone>");
          sb.append("<Status>" + readData[u][5] + "</Status>");
          sb.append("<Delivery>" + readData[u][6] + "</Delivery>");
          sb.append("</directSale>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<directSales>" + sb.toString() + "</directSales>");
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
  
  public static void LoadInstallationUpdation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String txtSer = request.getParameter("txtSer");
      txtSer = txtSer.toUpperCase();
      String month = request.getParameter("month");
      String customer = request.getParameter("customer");
      String division = request.getParameter("division");
      String status = request.getParameter("status");
      String branch = request.getParameter("branch");
      int year = Integer.parseInt(request.getParameter("year"));
      int mon = Integer.parseInt(month);
      String sql = "  SELECT a.INT_INSTALLATIONID,a.CHR_SALESNO, ";
      sql = String.valueOf(sql) + 
        "   FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),b.CHR_CONTACTDETAILS,b.CHR_CONTACTNO,  ";
      sql = String.valueOf(sql) + 
        " a.CHR_SERIALNO, DATE_FORMAT(a.DAT_INSTALLATION,'%d-%b-%Y %h:%i:%s'),a.CHR_EMPID,a.CHR_STATUS  ";
      sql = String.valueOf(sql) + 
        " FROM inv_t_directsales_installation a, inv_t_directsales b, inv_m_customerinfo c  ";
      sql = String.valueOf(sql) + " WHERE a.CHR_SALESNO  = b.CHR_SALESNO   ";
      sql = String.valueOf(sql) + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID  ";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + "  AND b.INT_BRANCHID = " + branch; 
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + "   AND b.INT_CUSTOMERID = " + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND b.INT_DIVIID = " + division; 
      if (!"0".equals(mon))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SALESDATE) =" + mon; 
      sql = String.valueOf(sql) + " AND YEAR(b.DAT_SALESDATE)=" + year;
      if ("Y".equals(status)) {
        sql = String.valueOf(sql) + "    AND a.CHR_STATUS ='Y'";
      } else if ("A".equals(status)) {
        sql = String.valueOf(sql) + "    AND a.CHR_STATUS ='A'";
      } else if ("P".equals(status)) {
        sql = String.valueOf(sql) + "    AND a.CHR_STATUS ='P'";
      } 
      if (!"0".equals(txtSer))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)  LIKE '" + txtSer + "%'"; 
      sql = String.valueOf(sql) + " order by a.INT_INSTALLATIONID    ";
      System.out.println(sql);
      File file = null;
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<directSale>");
          sb.append("<salesid>" + readData[u][0] + "</salesid>");
          sb.append("<salesno>" + readData[u][1] + "</salesno>");
          sb.append("<custname>" + readData[u][2].trim().replace("&", "98650") + "</custname>");
          sb.append("<contactperson>" + readData[u][3] + "</contactperson>");
          sb.append("<contactphone>" + readData[u][4] + "</contactphone>");
          sb.append("<serialno>" + readData[u][5] + "</serialno>");
          sb.append("<assigndate>" + readData[u][6] + "</assigndate>");
          sb.append("<assignempid>" + readData[u][7] + "</assignempid>");
          sb.append("<Status>" + readData[u][8] + "</Status>");
          file = new File(String.valueOf(request.getRealPath("/")) + "uploadfiles/CCFR/" + readData[u][0] + ".pdf");
          if (file.exists()) {
            sb.append("<file>Y</file>");
          } else {
            sb.append("<file>N</file>");
          } 
          sb.append("</directSale>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
  
  public static void LoadStaffAsset(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String offic = request.getParameter("office");
      String deptment = request.getParameter("dept");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String StartLetter = request.getParameter("startLetter");
      String status = request.getParameter("status");
      Object object = session.getAttribute("BRANCHID");
      String sql = "";
      sql = "  SELECT b.CHR_EMPID,b.CHR_STAFFNAME, ";
      sql = String.valueOf(sql) + "  if(a.CHR_TYPE='I','Item','Product'), ";
      sql = String.valueOf(sql) + "  if(a.CHR_TYPE='I',   ";
      sql = String.valueOf(sql) + "  (SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID) ";
      sql = String.valueOf(sql) + "  , ";
      sql = String.valueOf(sql) + "  (SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID) ";
      sql = String.valueOf(sql) + "  ),   ";
      sql = String.valueOf(sql) + "   a.INT_ASSETID,a.CHR_SERIALNO, ";
      sql = String.valueOf(sql) + "  DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y'),a.CHR_STATUS ";
      sql = String.valueOf(sql) + "  FROM inv_t_asset a,com_m_staff b,inv_t_vendorgoodsreceived c ";
      sql = String.valueOf(sql) + "  WHERE a.CHR_EMPID=b.CHR_EMPID ";
      sql = String.valueOf(sql) + "  AND a.CHR_ITEMID = c.CHR_ITEMID ";
      sql = String.valueOf(sql) + "  AND a.CHR_SERIALNO =c.CHR_SERIALNO ";
      if (!"0".equals(status))
        sql = String.valueOf(sql) + " AND  a.CHR_STATUS ='" + status + "' "; 
      if (!"0".equals(object))
        sql = String.valueOf(sql) + " AND  a.INT_BRANCHID =" + object; 
      if (!"0".equals(offic))
        sql = String.valueOf(sql) + " AND  b.INT_OFFICEID =" + offic; 
      if (!"0".equals(deptment))
        sql = String.valueOf(sql) + " AND b.INT_DEPARTID =" + deptment; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_CREATIONDATE) = " + month; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_CREATIONDATE) = " + year;
      sql = String.valueOf(sql) + " ORDER BY b.CHR_STAFFNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter)) {
            sb.append("<Row>");
            sb.append("<Empid>" + readData[u][0] + "</Empid>");
            sb.append("<Empname>" + readData[u][1] + "</Empname>");
            sb.append("<Itemtype>" + readData[u][2] + "</Itemtype>");
            sb.append("<Itemname>" + readData[u][3] + "</Itemname>");
            sb.append("<AssetId>" + readData[u][4] + "</AssetId>");
            sb.append("<Serialno>" + readData[u][5] + "</Serialno>");
            sb.append("<CreatedDate>" + readData[u][6] + "</CreatedDate>");
            sb.append("<Status>" + readData[u][7] + "</Status>");
            sb.append("</Row>");
          } 
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
  
  public static void LoadSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String str = "Serial not found...";
      String searchSer = request.getParameter("itemvalue").trim();
      String sql = "SELECT CHR_SERIALNO,CHR_ITEMID FROM inv_t_vendorgoodsreceived WHERE CHR_TYPE='I' AND CHR_FLAG ='N'  AND CHR_SERIALNO is not null  AND CHR_ITEMID='" + searchSer + "'";
      String[][] serialnoData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (serialnoData.length > 0) {
        for (int x = 0; x < serialnoData.length; x++) {
          sb.append("<serial>");
          sb.append("<id>" + serialnoData[x][1] + "</id>");
          sb.append("<serialNo>" + serialnoData[x][0] + "</serialNo>");
          sb.append("</serial>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(
            "<Rowserial>" + sb.toString() + "</Rowserial>");
      } else {
        System.out.println("elsepath..");
        sb.append("<serial>");
        sb.append("<id>0</id>");
        sb.append("<serialNo>" + str + "</serialNo>");
        sb.append("</serial>");
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
  
  public static void INVloadEMDAsset(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String offic = request.getParameter("office");
      String EmdType = request.getParameter("EmdType");
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      String StartLetter = request.getParameter("startLetter");
      String accept = request.getParameter("accept");
      String returned = request.getParameter("returned");
      Object object = session.getAttribute("BRANCHID");
      String sql = "SELECT a.INT_EMDID,a.CHR_EMD_REFNUMBER,if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),UPPER(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID )) ,a.DOU_EMD_AMOUNT,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),a.CHR_APPROVAL,a.CHR_STATUS,d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)";
      sql = String.valueOf(sql) + 
        " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID";
      sql = String.valueOf(sql) + " AND  a.CHR_REF =c.CHR_EMPID";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) LIKE '" + StartLetter + "%'"; 
      if (!"0".equals(object))
        sql = String.valueOf(sql) + " AND  a.INV_BRANCHID =" + object; 
      if (!"0".equals(offic))
        sql = String.valueOf(sql) + " AND  c.INT_OFFICEID =" + offic; 
      if (!"0".equals(EmdType))
        sql = String.valueOf(sql) + " AND a.INT_EMD_TYPE ='" + EmdType + "'"; 
      if (!"0".equals(accept))
        sql = String.valueOf(sql) + " AND a.CHR_APPROVAL ='" + accept + "'"; 
      if (!"0".equals(returned))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS ='" + returned + "'"; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_CREATION) = " + month; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_CREATION) = " + year;
      sql = String.valueOf(sql) + " ORDER BY a.INT_CUSTOMERID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        String filepath = request.getRealPath("/");
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Emddetail>");
          sb.append("<Emdid>" + readData[u][0] + "</Emdid>");
          sb.append("<Emdnumber>" + readData[u][1] + "</Emdnumber>");
          sb.append("<EmdType>" + readData[u][2] + "</EmdType>");
          sb.append("<CustomerName>" + readData[u][3].replaceAll("&", " AND") + "</CustomerName>");
          sb.append("<EmdAmt>" + readData[u][4] + "</EmdAmt>");
          sb.append("<TenderLastDate>" + readData[u][5] + "</TenderLastDate>");
          sb.append("<Approval>" + readData[u][6] + "</Approval>");
          sb.append("<Status>" + readData[u][7] + "</Status>");
          sb.append("<Division>" + readData[u][8] + "</Division>");
          sb.append("<Entry>" + readData[u][9] + "</Entry>");
          if (FileFunctions.fileIsThere(String.valueOf(filepath) + "uploadfiles/EMD_File/" + readData[u][0] + ".pdf")) {
            sb.append("<F>Y</F>");
          } else {
            sb.append("<F>N</F>");
          } 
          sb.append("</Emddetail>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Emd>" + sb.toString() + "</Emd>");
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
  
  public static void INVloadStaffEMD(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      String offic = request.getParameter("office");
      String EmdType = request.getParameter("EmdType");
      String month = request.getParameter("month");
      int year = Integer.parseInt(request.getParameter("year"));
      String StartLetter = request.getParameter("startLetter");
      String accept = request.getParameter("accept");
      String returned = request.getParameter("returned");
      Object object = session.getAttribute("BRANCHID");
      String sql = "SELECT a.INT_EMDID,a.CHR_EMD_REFNUMBER,if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),a.DOU_EMD_AMOUNT,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),a.CHR_APPROVAL,a.CHR_STATUS,d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)";
      sql = String.valueOf(sql) + 
        " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID";
      sql = String.valueOf(sql) + " AND  a.CHR_REF =c.CHR_EMPID";
      if (!"0".equals(object))
        sql = String.valueOf(sql) + " AND  a.INV_BRANCHID =" + object; 
      if (!"0".equals(offic))
        sql = String.valueOf(sql) + " AND  c.INT_OFFICEID =" + offic; 
      if (!"0".equals(EmdType))
        sql = String.valueOf(sql) + " AND a.INT_EMD_TYPE ='" + EmdType + "'"; 
      if (!"0".equals(accept))
        sql = String.valueOf(sql) + " AND a.CHR_APPROVAL ='" + accept + "'"; 
      if (!"0".equals(returned))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS ='" + returned + "'"; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) LIKE '" + StartLetter + "%'"; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_CREATION) = " + month; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_CREATION) = " + year;
      sql = String.valueOf(sql) + " AND a.CHR_REF='" + session.getAttribute("EMPID") + 
        "' ";
      sql = String.valueOf(sql) + " ORDER BY a.INT_CUSTOMERID ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          if (readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter)) {
            sb.append("<Emddetail>");
            sb.append("<Emdid>" + readData[u][0] + "</Emdid>");
            sb.append("<Emdnumber>" + readData[u][1] + 
                "</Emdnumber>");
            sb.append("<EmdType>" + readData[u][2] + "</EmdType>");
            sb.append("<CustomerName>" + 
                readData[u][3].replaceAll("&", " AND") + 
                "</CustomerName>");
            sb.append("<EmdAmt>" + readData[u][4] + "</EmdAmt>");
            sb.append("<TenderLastDate>" + readData[u][5] + 
                "</TenderLastDate>");
            sb.append("<Approval>" + readData[u][5] + "</Approval>");
            sb.append("<Status>" + readData[u][7] + "</Status>");
            sb.append("<Division>" + readData[u][8] + "</Division>");
            sb.append("<Entry>" + readData[u][9] + "</Entry>");
            sb.append("</Emddetail>");
          } 
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Emd>" + sb.toString() + "</Emd>");
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
  
  public static void LoadProject(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String sql = "";
      sql = " SELECT INT_PROJECTID,CHR_PROJECTNAME,CHR_STATUS  FROM inv_m_project ";
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " WHERE  CHR_PROJECTNAME LIKE '" + StartLetter + 
          "%'"; 
      sql = String.valueOf(sql) + " ORDER BY CHR_PROJECTNAME ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Name>" + readData[u][1].trim() + "</Name>");
          sb.append("<Status>" + readData[u][2].trim() + "</Status>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<RowProject>" + sb.toString() + "</RowProject>");
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
  
  public static void LoadSpareDemand(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String branch = request.getParameter("branch");
      String calltype = request.getParameter("calltype");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String sql = "";
      sql = " SELECT a.INT_DEMANID,a.CHR_DEMANDNO,b.CHR_BRANCHNAME,a.CHR_CUSTOMER,a.CHR_CUSTOMER_ADDRESS,if(a.CHR_CALLTYPE='N','Not Qualified',if(a.CHR_CALLTYPE='M','No Machine','Qualified')),a.CHR_PRODUCT_SERIALNUMBER,a.CHR_PART_DESC, ";
      sql = String.valueOf(sql) + " a.CHR_CALLNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y  %h:%m:%s %p'), ";
      sql = String.valueOf(sql) + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY),a.CHR_DESPATCH_LOCATION,a.CHR_ISSUED ";
      sql = String.valueOf(sql) + " FROM inv_t_sparedemand a , com_m_branch b";
      sql = String.valueOf(sql) + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND  a.INT_BRANCHID = " + branch; 
      if (!"0".equals(calltype))
        sql = String.valueOf(sql) + " AND  a.CHR_CALLTYPE = '" + calltype + "' "; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND  DAY(a.DAT_DEMAND_RAISED_DATE)= " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND  MONTH(a.DAT_DEMAND_RAISED_DATE)= " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND  a.CHR_CUSTOMER LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_CUSTOMER ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Ref>" + readData[u][1].trim() + "</Ref>");
          sb.append("<Branch>" + readData[u][2].trim() + "</Branch>");
          sb.append("<Customer>" + readData[u][3].trim() + "</Customer>");
          sb.append("<Customeradd>" + readData[u][4].trim() + "</Customeradd>");
          sb.append("<Calltype>" + readData[u][5].trim() + "</Calltype>");
          sb.append("<productserial>" + readData[u][6].trim() + "</productserial>");
          sb.append("<description>" + readData[u][7].trim().replaceAll("&", " and ") + "</description>");
          sb.append("<Callno>" + readData[u][8].trim() + "</Callno>");
          sb.append("<Demanddate>" + readData[u][9].trim() + "</Demanddate>");
          sb.append("<Entry>" + readData[u][10].trim() + "</Entry>");
          sb.append("<DespatchLocation>" + readData[u][11].trim() + "</DespatchLocation>");
          sb.append("<Issued>" + readData[u][12].trim() + "</Issued>");
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
  
  public static void LoadSpareIssued(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String branch = request.getParameter("branch");
      String calltype = request.getParameter("calltype");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String sql = "";
      sql = " SELECT a.INT_DEMANID,b.CHR_BRANCHNAME,a.CHR_CUSTOMER,a.CHR_CUSTOMER_ADDRESS,if(a.CHR_CALLTYPE='N','Not Qualified',if(a.CHR_CALLTYPE='M','No Machine','Qualified')),a.CHR_PRODUCT_SERIALNUMBER, a.CHR_PART_DESC, ";
      sql = String.valueOf(sql) + 
        " a.CHR_CALLNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y  %h:%m:%s %p'), ";
      sql = String.valueOf(sql) + 
        " FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY),a.CHR_DESPATCH_LOCATION,a.CHR_ISSUED, ";
      sql = String.valueOf(sql) + 
        " a.CHR_ISSUED_SERIALNUMBER,FIND_A_EMPLOYEE_ID_NAME(a.CHR_ISSUED_BY),DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%b-%Y  %h:%m:%s %p'),";
      sql = String.valueOf(sql) + 
        " a.CHR_RETURN_STATUS ,DATEDIFF(a.DAT_ISSUED_DATE,a.DAT_DEMAND_RAISED_DATE),";
      sql = String.valueOf(sql) + 
        " if(a.CHR_ISSUE_THROUGH='C','Courier',if(a.CHR_ISSUE_THROUGH='P','Person','Vechicle') ), ";
      sql = String.valueOf(sql) + "  a.CHR_ISSUE_DESC ";
      sql = String.valueOf(sql) + " FROM inv_t_sparedemand a , com_m_branch b";
      sql = String.valueOf(sql) + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND  a.INT_BRANCHID = " + branch; 
      if (!"0".equals(calltype))
        sql = String.valueOf(sql) + " AND  a.CHR_CALLTYPE = '" + calltype + "' "; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND  DAY(a.DAT_DEMAND_RAISED_DATE)= " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND  MONTH(a.DAT_DEMAND_RAISED_DATE)= " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND a.CHR_CUSTOMER LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_CUSTOMER ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Customer>" + readData[u][2].trim() + "</Customer>");
          sb.append("<Customeradd>" + readData[u][3].trim() + "</Customeradd>");
          sb.append("<Calltype>" + readData[u][4].trim() + "</Calltype>");
          sb.append("<productserial>" + readData[u][5].trim() + "</productserial>");
          sb.append("<description>" + readData[u][6].trim().replaceAll("&", " and ") + "</description>");
          sb.append("<Callno>" + readData[u][7].trim() + "</Callno>");
          sb.append("<Demanddate>" + readData[u][8].trim() + "</Demanddate>");
          sb.append("<Entry>" + readData[u][9].trim() + "</Entry>");
          sb.append("<DespatchLocation>" + readData[u][10].trim() + "</DespatchLocation>");
          sb.append("<Issued>" + readData[u][11].trim() + "</Issued>");
          sb.append("<Serial>" + readData[u][12].trim() + "</Serial>");
          sb.append("<IssuedBy>" + readData[u][13].trim() + "</IssuedBy>");
          sb.append("<IssuedDate>" + readData[u][14].trim() + "</IssuedDate>");
          sb.append("<Return>" + readData[u][15].trim() + "</Return>");
          sb.append("<diff>" + readData[u][16].trim() + "</diff>");
          sb.append("<Through>" + readData[u][17].trim() + "</Through>");
          sb.append("<Throughdesc>" + readData[u][18].trim().replaceAll("&", " and ") + "</Throughdesc>");
          sb.append("</Row>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter()
          .write("<Rows>" + sb.toString() + "</Rows>");
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
  
  public static void LoadSpareReturn(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("startLetter");
      String branch = request.getParameter("branch");
      String calltype = request.getParameter("calltype");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String day = request.getParameter("day");
      String returnstatus = request.getParameter("returnstatus");
      String sql = "";
      sql = " SELECT a.INT_DEMANID,b.CHR_BRANCHNAME, a.CHR_CUSTOMER,a.CHR_CUSTOMER_ADDRESS,if(a.CHR_CALLTYPE='N','Not Qualified',if(a.CHR_CALLTYPE='M','No Machine','Qualified')),a.CHR_PRODUCT_SERIALNUMBER,a.CHR_PART_DESC, ";
      sql = String.valueOf(sql) + " a.CHR_CALLNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y  %h:%m:%s %p'), ";
      sql = String.valueOf(sql) + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY),a.CHR_DESPATCH_LOCATION,a.CHR_ISSUED, ";
      sql = String.valueOf(sql) + " a.CHR_ISSUED_SERIALNUMBER,FIND_A_EMPLOYEE_ID_NAME(a.CHR_ISSUED_BY),DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%b-%Y  %h:%m:%s %p'),";
      sql = String.valueOf(sql) + " a.CHR_RETURN_STATUS ,DATEDIFF(a.DAT_ISSUED_DATE,a.DAT_DEMAND_RAISED_DATE),";
      sql = String.valueOf(sql) + " if(a.CHR_ISSUE_THROUGH='C','Courier',if(a.CHR_ISSUE_THROUGH='P','Person','Vechicle') ), ";
      sql = String.valueOf(sql) + "  a.CHR_ISSUE_DESC, DATEDIFF(a.DAT_RETURN_DATE,a.DAT_ISSUED_DATE)";
      sql = String.valueOf(sql) + " FROM inv_t_sparedemand a , com_m_branch b";
      sql = String.valueOf(sql) + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID  AND a.CHR_ISSUED ='Y' ";
      if (!"0".equals(returnstatus))
        sql = String.valueOf(sql) + " AND  a.CHR_RETURN_STATUS = '" + returnstatus + 
          "' "; 
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND  a.INT_BRANCHID = " + branch; 
      if (!"0".equals(calltype))
        sql = String.valueOf(sql) + " AND  a.CHR_CALLTYPE = '" + calltype + "' "; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND  DAY(a.DAT_DEMAND_RAISED_DATE)= " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND  MONTH(a.DAT_DEMAND_RAISED_DATE)= " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND  YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year; 
      if (!"0".equals(StartLetter))
        sql = String.valueOf(sql) + " AND  a.CHR_CUSTOMER LIKE '" + StartLetter + "%'"; 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_CUSTOMER ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
          sb.append("<Branch>" + readData[u][1].trim() + "</Branch>");
          sb.append("<Customer>" + readData[u][2].trim() + "</Customer>");
          sb.append("<Customeradd>" + readData[u][3].trim() + "</Customeradd>");
          sb.append("<Calltype>" + readData[u][4].trim() + "</Calltype>");
          sb.append("<productserial>" + readData[u][5].trim() + "</productserial>");
          sb.append("<description>" + readData[u][6].trim().replaceAll("&", " and ") + "</description>");
          sb.append("<Callno>" + readData[u][7].trim() + "</Callno>");
          sb.append("<Demanddate>" + readData[u][8].trim() + "</Demanddate>");
          sb.append("<Entry>" + readData[u][9].trim() + "</Entry>");
          sb.append("<DespatchLocation>" + readData[u][10].trim() + "</DespatchLocation>");
          sb.append("<Issued>" + readData[u][11].trim() + "</Issued>");
          sb.append("<Serial>" + readData[u][12].trim() + "</Serial>");
          sb.append("<IssuedBy>" + readData[u][13].trim() + "</IssuedBy>");
          sb.append("<IssuedDate>" + readData[u][14].trim() + "</IssuedDate>");
          sb.append("<Return>" + readData[u][15].trim() + "</Return>");
          sb.append("<diff>" + readData[u][16].trim() + "</diff>");
          sb.append("<Through>" + readData[u][17].trim() + "</Through>");
          sb.append("<Throughdesc>" + readData[u][18].trim().replaceAll("&", " and ") + "</Throughdesc>");
          sb.append("<Returnage>" + readData[u][19].trim() + "</Returnage>");
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
  
  public static void loadDeliveryChallan(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String dcstatus = request.getParameter("dcstatus");
      String day = request.getParameter("day");
      String type = request.getParameter("type");
      String sql = "";
      sql = " SELECT  a.CHR_DCNO,date_format(a.DAT_DCDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF ,a.CHR_DES,a.CHR_DCSTATUS,a.CHR_STATUS,c.CHR_STAFFNAME FROM inv_t_deliverychallan a,inv_m_customerinfo b,com_m_staff c WHERE  a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_REF  = c.CHR_EMPID  ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " ";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_DCDATE)=" + day + " "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_DCDATE)=" + month + " "; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_DCDATE)=" + year + " ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"2".equals(dcstatus))
        sql = String.valueOf(sql) + " AND a.CHR_DCSTATUS='" + dcstatus + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(StartLetter))
          sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%'"; 
      } else {
        sql = String.valueOf(sql) + " AND ( (a.CHR_DCNO LIKE '%" + StartLetter + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%') )";
      } 
      sql = String.valueOf(sql) + " GROUP BY a.CHR_DCNO  ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Service>");
          sb.append("<Invoiceno>" + readData[u][0] + "</Invoiceno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Customer>" + readData[u][2] + "</Customer>");
          sb.append("<Status>" + readData[u][6] + "</Status>");
          sb.append("<Return>" + readData[u][5] + "</Return>");
          sb.append("<Ref>" + readData[u][7] + "</Ref>");
          sb.append("</Service>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Services>" + sb.toString() + "</Services>");
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
  
  public static void INVScrab(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String division = request.getParameter("division");
      String customer = request.getParameter("customer");
      String Branch = request.getParameter("Branch");
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String dcstatus = request.getParameter("dcstatus");
      String day = request.getParameter("day");
      String type = request.getParameter("type");
      String sql = "";
      sql = " SELECT  a.CHR_SCRABNO,date_format(a.DAT_SCRABDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF ,a.CHR_DES,a.CHR_STATUS,a.CHR_STATUS,c.CHR_STAFFNAME FROM inv_t_scrab a,inv_m_customerinfo b,com_m_staff c WHERE  a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_REF  = c.CHR_EMPID  ";
      sql = String.valueOf(sql) + " AND a.INT_BRANCHID=" + Branch + " ";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_SCRABDATE)=" + day + " "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_SCRABDATE)=" + month + " "; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_SCRABDATE)=" + year + " ";
      if (!"0".equals(customer))
        sql = String.valueOf(sql) + " AND a.INT_CUSTOMERID=" + customer; 
      if (!"0".equals(division))
        sql = String.valueOf(sql) + " AND a.INT_DIVIID=" + division; 
      if (!"2".equals(dcstatus))
        sql = String.valueOf(sql) + " AND a.CHR_STATUS='" + dcstatus + "' "; 
      if ("1".equals(type)) {
        if (!"0".equals(StartLetter))
          sql = String.valueOf(sql) + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%'"; 
      } else {
        sql = String.valueOf(sql) + " AND ( (a.CHR_SCRABNO LIKE '%" + StartLetter + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%') )";
      } 
      sql = String.valueOf(sql) + " GROUP BY a.CHR_SCRABNO  ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Service>");
          sb.append("<Invoiceno>" + readData[u][0] + "</Invoiceno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Customer>" + readData[u][2] + "</Customer>");
          sb.append("<Status>" + readData[u][6] + "</Status>");
          sb.append("<Return>" + readData[u][5] + "</Return>");
          sb.append("<Ref>" + readData[u][7] + "</Ref>");
          sb.append("</Service>");
        } 
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Services>" + sb.toString() + "</Services>");
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
  
  public static void loadStockAdjustment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String StartLetter = request.getParameter("id");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String dcstatus = request.getParameter("dcstatus");
      String day = request.getParameter("day");
      String type = request.getParameter("type");
      String sql = "";
      sql = " SELECT  a.CHR_ADJUSTMENTNO,date_format(a.DAT_ADJUSTMENTDATE,'%d-%b-%Y'),FUN_GET_BRANCH_NAME(a.INT_TO_BRANCHID),a.CHR_REF ,a.CHR_DES,a.CHR_DCSTATUS,a.CHR_STATUS,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)  FROM inv_t_stockadjustment a  WHERE  INT_STOCKADJUSTMENT_ID >= 0  ";
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_ADJUSTMENTDATE)=" + day + " "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_ADJUSTMENTDATE)=" + month + " "; 
      sql = String.valueOf(sql) + " AND YEAR(a.DAT_ADJUSTMENTDATE)=" + year + " ";
      if (!"0".equals(dcstatus))
        sql = String.valueOf(sql) + " AND a.CHR_DCSTATUS='" + dcstatus + "' "; 
      sql = String.valueOf(sql) + " GROUP BY a.CHR_ADJUSTMENTNO  ";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Refno>" + readData[u][0] + "</Refno>");
          sb.append("<Date>" + readData[u][1] + "</Date>");
          sb.append("<Branch>" + readData[u][2] + "</Branch>");
          sb.append("<Status>" + readData[u][6] + "</Status>");
          sb.append("<Return>" + readData[u][5] + "</Return>");
          sb.append("<Ref>" + readData[u][7] + "</Ref>");
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
  
  public static void LoadSSparedemand(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USRTYPE");
      String issue = request.getParameter("Issue");
      String startLetter = request.getParameter("startLetter");
      String day = request.getParameter("day");
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String stype = request.getParameter("stype");
      String branch = request.getParameter("branch");
      String sql = "";
      sql = String.valueOf(sql) + " SELECT a.INT_DEMANID,a.CHR_DEMANDNO,a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.CHR_DESC, ";
      sql = String.valueOf(sql) + " a.CHR_ISSUED,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y'), ";
      sql = String.valueOf(sql) + "  b.CHR_BRANCHNAME ,  ";
      sql = String.valueOf(sql) + " if(a.CHR_CALLTYPE='Q', ";
      sql = String.valueOf(sql) + " ( SELECT c.CHR_CUSTOMERNAME FROM inv_ss_sparemaster c  WHERE   a.CHR_PRODUCT_SERIALNUMBER = c.CHR_SERIALNO ), ";
      sql = String.valueOf(sql) + " a.CHR_CUSTOMER ";
      sql = String.valueOf(sql) + " ) customer, ";
      sql = String.valueOf(sql) + "    if(a.CHR_CALLTYPE='Q', ";
      sql = String.valueOf(sql) + " ( SELECT if(c1.CHR_CATEGORY='A','AMC','Warranty') FROM inv_ss_sparemaster c1  WHERE   a.CHR_PRODUCT_SERIALNUMBER = c1.CHR_SERIALNO ), ";
      sql = String.valueOf(sql) + " 'NM CALL' ";
      sql = String.valueOf(sql) + " ) category,  ";
      sql = String.valueOf(sql) + " if(a.CHR_CALLTYPE='Q', ";
      sql = String.valueOf(sql) + " ( SELECT c2.CHR_CUSTOMERADDRESS FROM inv_ss_sparemaster c2 WHERE   a.CHR_PRODUCT_SERIALNUMBER = c2.CHR_SERIALNO ), ";
      sql = String.valueOf(sql) + " a.CHR_CUSTOMER_ADDRESS ";
      sql = String.valueOf(sql) + " )  address , FIND_A_EMPLOYEE_ID_NAME_BY_USERID(a.CHR_USRNAME)";
      sql = String.valueOf(sql) + " FROM inv_ss_sparedemand a,com_m_branch b ";
      sql = String.valueOf(sql) + " WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID ";
      if (!"0".equals(issue))
        sql = String.valueOf(sql) + " AND a.CHR_ISSUED ='" + issue + "'"; 
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND a.INT_BRANCHID = " + branch; 
      if (!"0".equals(day))
        sql = String.valueOf(sql) + " AND DAY(a.DAT_DEMAND_RAISED_DATE) = " + day; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND MONTH(a.DAT_DEMAND_RAISED_DATE) = " + month; 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year; 
      if (!"1".equals(stype))
        if (!"".equals(startLetter))
          sql = String.valueOf(sql) + " AND a.CHR_PRODUCT_SERIALNUMBER LIKE '%" + startLetter + "%' ";  
      sql = String.valueOf(sql) + " ORDER BY a.DAT_DEMAND_RAISED_DATE";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<DId>" + readData[u][0] + "</DId>");
          sb.append("<Dnumber>" + readData[u][1].replaceAll("&", " AND ") + "</Dnumber>");
          sb.append("<Callnumber>" + readData[u][2].replaceAll("&", " AND ") + "</Callnumber>");
          sb.append("<DSerialno>" + readData[u][3].replaceAll("&", " AND ") + "</DSerialno>");
          sb.append("<descrip>" + readData[u][4].replaceAll("&", " AND ") + "</descrip>");
          sb.append("<Issue>" + readData[u][5].replaceAll("&", " AND ") + "</Issue>");
          sb.append("<demanddate>" + readData[u][6].replaceAll("&", " AND ") + "</demanddate>");
          sb.append("<branch>" + readData[u][7].replaceAll("&", " AND ") + "</branch>");
          sb.append("<customer>" + readData[u][8].replaceAll("&", " AND ") + "</customer>");
          sb.append("<type>" + readData[u][9].replaceAll("&", " AND ") + "</type>");
          sb.append("<customeraddress>" + readData[u][10].replaceAll("&", " AND ") + "</customeraddress>");
          sb.append("<Entry>" + readData[u][11].replaceAll("&", " AND ") + "</Entry>");
          sb.append("<Usertype>" + object + "</Usertype>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<RowsSpare>" + sb.toString() + "</RowsSpare>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void LoadSSpareissue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      HttpSession session = request.getSession();
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String stype = request.getParameter("stype");
      String sparetype = request.getParameter("sparetype");
      String userid = (String)session.getAttribute("USRID");
      String sql = "";
      sql = " SELECT a.INT_ISSUEID,a.CHR_ISSUEDNO,a.CHR_DEMANDNO,a.CHR_SPARETYPE,a.CHR_TYPE,a.INT_QTY,a.CHR_ISSUED_SERIALNUMBER,b.CHR_PRODUCTCODE,";
      sql = String.valueOf(sql) + " if(c.CHR_CALLTYPE='Q', ";
      sql = String.valueOf(sql) + " ( SELECT c2.CHR_CUSTOMERNAME FROM inv_ss_sparemaster c2 ";
      sql = String.valueOf(sql) + " WHERE   c.CHR_PRODUCT_SERIALNUMBER = c2.CHR_SERIALNO ),  ";
      sql = String.valueOf(sql) + " c.CHR_CUSTOMER ";
      sql = String.valueOf(sql) + " ) customer, ";
      sql = String.valueOf(sql) + " a.CHR_STATUS ";
      sql = String.valueOf(sql) + " FROM inv_ss_t_sparedemandissue a ,inv_m_produtlist b,inv_ss_sparedemand c ";
      sql = String.valueOf(sql) + " WHERE a.INT_ISSUEID>0 AND a.CHR_PRODUCTCODE = b.CHR_PRODUCTID AND c.CHR_DEMANDNO = a.CHR_DEMANDNO";
      sql = String.valueOf(sql) + " AND a.CHR_ISSUED_BY='" + userid + "'";
      if (!"0".equals(type))
        sql = String.valueOf(sql) + " AND a.CHR_TYPE = '" + type + "'"; 
      if (!"0".equals(sparetype))
        sql = String.valueOf(sql) + " AND a.CHR_SPARETYPE = '" + sparetype + "' "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND month(a.DAT_ISSUED_DATE) = " + Integer.parseInt(month); 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND year(a.DAT_ISSUED_DATE) = " + year; 
      if ("1".equals(stype)) {
        if (!"0".equals(startLetter))
          sql = String.valueOf(sql) + " AND TRIM(b.CHR_PRODUCTCODE) LIKE '" + startLetter.trim() + "%' "; 
      } else if (!"".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND TRIM(b.CHR_PRODUCTCODE) LIKE '%" + startLetter + "%' ";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_DEMANDNO";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<DemandIssueId>" + readData[u][0] + "</DemandIssueId>");
          sb.append("<DemandIssueNo>" + readData[u][1] + "</DemandIssueNo>");
          sb.append("<DemandNO>" + readData[u][2] + "</DemandNO>");
          sb.append("<Sparetype>" + readData[u][3] + "</Sparetype>");
          sb.append("<type>" + readData[u][4] + "</type>");
          sb.append("<qty>" + readData[u][5] + "</qty>");
          sb.append("<DemandissueSerialno>" + readData[u][6] + "</DemandissueSerialno>");
          sb.append("<productname>" + readData[u][7] + "</productname>");
          sb.append("<customername>" + readData[u][8] + "</customername>");
          sb.append("<Return>" + readData[u][9] + "</Return>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowsspareissue>" + sb.toString() + "</Rowsspareissue>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void LoadAssignsparedemand(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String demandnumber = request.getParameter("demandnumber");
      String sql1 = " Select CHR_DEMANDNO from inv_ss_sparedemand   WHERE INT_DEMANID = '" + demandnumber + "'";
      String[][] readData1 = CommonFunctions.QueryExecute(sql1);
      String sql = "";
      sql = " SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.DAT_DEMAND_RAISED_DATE,a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION";
      sql = String.valueOf(sql) + " FROM inv_ss_sparedemand a,com_m_branch b ";
      sql = String.valueOf(sql) + " WHERE  a.INT_BRANCHID=b.INT_BRANCHID ";
      sql = String.valueOf(sql) + " AND a.CHR_DEMANDNO = '" + readData1[0][0] + "' ";
      sql = String.valueOf(sql) + " ORDER BY a.CHR_DEMANDNO";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Demandissuecallnum>" + readData[u][0] + "</Demandissuecallnum>");
          sb.append("<productserialnumber>" + readData[u][1] + "</productserialnumber>");
          sb.append("<raiseddate>" + readData[u][2] + "</raiseddate>");
          sb.append("<raisedby>" + readData[u][3] + "</raisedby>");
          sb.append("<despatchlocation>" + readData[u][4] + "</despatchlocation>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowssparedemanddetail>" + sb.toString() + "</Rowssparedemanddetail>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void LoadSpareissue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      HttpSession session = request.getSession();
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String sparetype = request.getParameter("sparetype");
      String userid = (String)session.getAttribute("USRID");
      String branch = request.getParameter("branch");
      String sql = "";
      sql = " SELECT a.INT_ISSUEID,a.CHR_ISSUEDNO,a.CHR_DEMANDNO,a.CHR_SPARETYPE,";
      sql = String.valueOf(sql) + " if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT'), ";
      sql = String.valueOf(sql) + "a.INT_QTY,a.CHR_ISSUED_SERIALNUMBER,a.CHR_PRODUCTCODE,";
      sql = String.valueOf(sql) + " if( a.CHR_TYPE ='I',";
      sql = String.valueOf(sql) + "(SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_PRODUCTCODE),";
      sql = String.valueOf(sql) + "(SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_PRODUCTCODE))productcode,";
      sql = String.valueOf(sql) + " if(c.CHR_CALLTYPE='Q', ";
      sql = String.valueOf(sql) + " ( SELECT d.CHR_CUSTOMERNAME FROM inv_ss_sparemaster d  WHERE   c.CHR_PRODUCT_SERIALNUMBER = d.CHR_SERIALNO ), ";
      sql = String.valueOf(sql) + " c.CHR_CUSTOMER";
      sql = String.valueOf(sql) + " ) ";
      sql = String.valueOf(sql) + " FROM inv_ss_t_sparedemandissue a ,inv_ss_sparedemand c ";
      sql = String.valueOf(sql) + " WHERE a.INT_ISSUEID>0  AND c.CHR_DEMANDNO = a.CHR_DEMANDNO";
      sql = String.valueOf(sql) + " AND a.CHR_ISSUED_BY='" + userid + "'";
      if (!"0".equals(type))
        sql = String.valueOf(sql) + " AND a.CHR_TYPE = '" + type + "'"; 
      if (!"0".equals(sparetype))
        sql = String.valueOf(sql) + " AND a.CHR_SPARETYPE = '" + sparetype + "' "; 
      if (!"0".equals(branch))
        sql = String.valueOf(sql) + " AND c.INT_BRANCHID =  " + branch; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND month(a.DAT_ISSUED_DATE) = " + Integer.parseInt(month); 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND year(a.DAT_ISSUED_DATE) = " + year; 
      if (!"0".equals(startLetter)) {
        sql = String.valueOf(sql) + " AND (   ";
        sql = String.valueOf(sql) + " \t\t if( a.CHR_TYPE ='I' ,  ";
        sql = String.valueOf(sql) + " \t\t    (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_PRODUCTCODE),  ";
        sql = String.valueOf(sql) + " \t\t    (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_PRODUCTCODE)  ";
        sql = String.valueOf(sql) + " \t\t ) ) LIKE '" + startLetter + "%'  ";
      } 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_DEMANDNO";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<DemandIssueId>" + readData[u][0] + "</DemandIssueId>");
          sb.append("<DemandIssueNo>" + readData[u][1] + "</DemandIssueNo>");
          sb.append("<DemandNO>" + readData[u][2] + "</DemandNO>");
          sb.append("<Sparetype>" + readData[u][3] + "</Sparetype>");
          sb.append("<type>" + readData[u][4] + "</type>");
          sb.append("<qty>" + readData[u][5] + "</qty>");
          sb.append("<DemandissueSerialno>" + readData[u][6] + "</DemandissueSerialno>");
          sb.append("<productid>" + readData[u][7] + "</productid>");
          sb.append("<productname>" + readData[u][8] + "</productname>");
          sb.append("<customername>" + readData[u][9] + "</customername>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowsspareissue>" + sb.toString() + "</Rowsspareissue>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void CheckQtyno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String qtyno = request.getParameter("qtyno");
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      String consumable = request.getParameter("consumable");
      StringBuffer sb = new StringBuffer();
      if (!qtyno.equals("0")) {
        String sql = " SELECT if((SUM(INT_PQTY)-SUM(INT_SQTY))> 0,if((SUM(INT_PQTY)-SUM(INT_SQTY)) >= '" + qtyno + "','Valid','Invalid'),'Invalid') ";
        sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceivedconsumable  WHERE INT_BRANCHID = '" + object + "' AND CHR_ITEMID= '" + consumable + "'";
        sql = String.valueOf(sql) + " GROUP BY CHR_ITEMID";
        System.out.println(sql);
        String[][] readData = CommonFunctions.QueryExecute(sql);
        if (readData.length > 0) {
          sb.append("<validnotvalid>");
          sb.append("<Status>" + readData[0][0] + "</Status>");
          sb.append("</validnotvalid>");
        } else {
          sb.append("<validnotvalid>");
          sb.append("<Status>0</Status>");
          sb.append("</validnotvalid>");
        } 
      } else {
        sb.append("<validnotvalid>");
        sb.append("<Status>0</Status>");
        sb.append("</validnotvalid>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<qtyno>" + sb.toString() + "</qtyno>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void Checkserialno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      boolean flag = false;
      String serialno = request.getParameter("serialno");
      String sql = " SELECT count(*) FROM inv_t_vendorgoodsreceived WHERE CHR_FLAG='N' AND CHR_SERIALNO='" + serialno + "'";
      flag = CommonInfo.RecordExist(sql);
      StringBuffer sb = new StringBuffer();
      sb.append("<serialnumber>");
      sb.append("<Status>" + flag + "</Status>");
      sb.append("</serialnumber>");
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<serialno>" + sb.toString() + "</serialno>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void Checkproductcode(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      boolean flag = false;
      String productcode = request.getParameter("productcode");
      String demandno = request.getParameter("demandno");
      String demand = null;
      StringBuffer sb = new StringBuffer();
      if (!productcode.equals("0")) {
        String sql1 = "SELECT INT_DEMANID,CHR_DEMANDNO FROM inv_ss_sparedemand WHERE CHR_ISSUED!='Y' AND INT_DEMANID='" + demandno + "'";
        sql1 = String.valueOf(sql1) + " ORDER BY CHR_DEMANDNO";
        String[][] demandnodata = CommonFunctions.QueryExecute(sql1);
        demand = demandnodata[0][1];
        String sql = " SELECT count(*) FROM inv_ss_t_sparedemandissue WHERE CHR_PRODUCTCODE='" + productcode + "' AND CHR_DEMANDNO ='" + demand + "'";
        flag = CommonInfo.RecordExist(sql);
        System.out.println(sql);
        flag = false;
        sb.append("<productnumber>");
        sb.append("<PStatus>" + flag + "</PStatus>");
        sb.append("</productnumber>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Productcode>" + sb.toString() + "</Productcode>");
      } else {
        String product = "0";
        sb.append("<productnumber>");
        sb.append("<PStatus>" + product + "</PStatus>");
        sb.append("</productnumber>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Productcode>" + sb.toString() + "</Productcode>");
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void LoadSparedemandissue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String demandnumber = request.getParameter("demandnumber");
      if (!"0".equals(demandnumber)) {
        String sql1 = " Select CHR_DEMANDNO from inv_ss_sparedemand   WHERE INT_DEMANID = '" + demandnumber + "'";
        String[][] readData1 = CommonFunctions.QueryExecute(sql1);
        sql = " SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.DAT_DEMAND_RAISED_DATE,a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION";
        sql = String.valueOf(sql) + " FROM inv_ss_sparedemand a,com_m_branch b";
        sql = String.valueOf(sql) + " WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID ";
        sql = String.valueOf(sql) + " AND a.CHR_DEMANDNO = '" + readData1[0][0] + "' ";
        sql = String.valueOf(sql) + " ORDER BY a.CHR_DEMANDNO";
      } else {
        sql = " SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.DAT_DEMAND_RAISED_DATE,a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION";
        sql = String.valueOf(sql) + " FROM inv_ss_sparedemand a,com_m_branch b";
        sql = String.valueOf(sql) + " WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID ";
        sql = String.valueOf(sql) + " AND a.CHR_DEMANDNO = '0' ";
        sql = String.valueOf(sql) + " ORDER BY a.CHR_DEMANDNO";
      } 
      System.out.println("spareissuedetail...." + sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<Demandissuecallnum>" + readData[u][0] + "</Demandissuecallnum>");
          sb.append("<productserialnumber>" + readData[u][1] + "</productserialnumber>");
          sb.append("<raiseddate>" + readData[u][2] + "</raiseddate>");
          sb.append("<raisedby>" + readData[u][3] + "</raisedby>");
          sb.append("<despatchlocation>" + readData[u][4] + "</despatchlocation>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowssparedemanddetail>" + sb.toString() + "</Rowssparedemanddetail>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void spareissueItemProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String sql = "";
      String id = request.getParameter("itemproducttype");
      String selec = "Not Selected Product Type";
      String sparetype = request.getParameter("sparetype");
      String demandno = request.getParameter("demandno");
      StringBuffer sb = new StringBuffer();
      if (!id.equals("0") && !demandno.equals("0")) {
        String sqld = "SELECT CHR_DEMANDNO FROM inv_ss_sparedemand WHERE INT_DEMANID='" + demandno + "'";
        String[][] readDataDemand = CommonFunctions.QueryExecute(sqld);
        String sqlp = "SELECT CHR_PRODUCTCODE FROM inv_ss_t_sparedemandissue WHERE CHR_TYPE= '" + id + "' AND CHR_DEMANDNO='" + readDataDemand[0][0] + "'";
        String[][] readDataProductcode = CommonFunctions.QueryExecute(sqlp);
        System.out.println("sqlp...." + sqlp);
        String demanids = "( ";
        if (readDataProductcode.length > 0)
          for (int u = 0; u < readDataProductcode.length; u++)
            demanids = String.valueOf(demanids) + "'" + readDataProductcode[u][0] + "',";  
        demanids = String.valueOf(demanids) + "'0')";
        if (id.equals("I"))
          sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME"; 
        if (id.equals("P") && "S".equals(sparetype))
          sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE CHR_PTYPE!= 'S' ORDER BY CHR_PRODUCTCODE"; 
        if (id.equals("P") && "C".equals(sparetype))
          sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE CHR_PTYPE = 'S' AND CHR_PRODUCTID NOT IN " + demanids + " ORDER BY CHR_PRODUCTCODE"; 
        String[][] readData = CommonFunctions.QueryExecute(sql);
        if (readData.length > 0) {
          for (int u = 0; u < readData.length; u++) {
            sb.append("<itemspare>");
            sb.append("<SpareitemproductId>" + readData[u][0] + "</SpareitemproductId>");
            sb.append("<Spareitemproductname>" + readData[u][1].replaceAll("&", " AND ") + "</Spareitemproductname>");
            sb.append("</itemspare>");
          } 
          response.setContentType("text/xml");
          response.setHeader("Cache-Control", "no-cache");
          response.getWriter().write("<itemspareissue>" + sb.toString() + "</itemspareissue>");
        } else {
          response.setStatus(204);
        } 
      } else {
        sb.append("<itemspare>");
        sb.append("<SpareitemproductId>0</SpareitemproductId>");
        sb.append("<Spareitemproductname>" + selec + "</Spareitemproductname>");
        sb.append("</itemspare>");
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<itemspareissue>" + sb.toString() + "</itemspareissue>");
        System.out.println(sb.toString());
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void CheckQtyconsumno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String spoldqty = request.getParameter("oldqty");
      String newqtyno = request.getParameter("qtyno");
      HttpSession session = request.getSession();
      Object object = session.getAttribute("INVBRANCH");
      String consumable = request.getParameter("consumable");
      String sql = " SELECT if((SUM(INT_PQTY)-SUM(INT_SQTY))>= 0,if((SUM(INT_PQTY)-SUM(INT_SQTY))+'" + spoldqty + "' >= '" + newqtyno + "','Valid','Invalid'),'Invalid') ";
      sql = String.valueOf(sql) + " FROM inv_t_vendorgoodsreceivedconsumable  WHERE INT_BRANCHID = '" + object + "' AND CHR_ITEMID= '" + consumable + "'";
      sql = String.valueOf(sql) + " GROUP BY CHR_ITEMID";
      String[][] readData = CommonFunctions.QueryExecute(sql);
      System.out.println(sql);
      StringBuffer sb = new StringBuffer();
      if (readData.length > 0) {
        sb.append("<validnotvalid>");
        sb.append("<Status>" + readData[0][0] + "</Status>");
        sb.append("</validnotvalid>");
      } else {
        sb.append("<validnotvalid>");
        sb.append("<Status>0</Status>");
        sb.append("</validnotvalid>");
      } 
      response.setContentType("text/xml");
      response.setHeader("Cache-Control", "no-cache");
      response.getWriter().write("<qtyconsumno>" + sb.toString() + "</qtyconsumno>");
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
  
  public static void LoadSparereturn(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    try {
      String startLetter = request.getParameter("startLetter");
      HttpSession session = request.getSession();
      String month = request.getParameter("month");
      String year = request.getParameter("year");
      String type = request.getParameter("type");
      String sparetype = request.getParameter("sparetype");
      String userid = (String)session.getAttribute("USRID");
      String sql = "";
      sql = " SELECT a.INT_ISSUEID,a.CHR_ISSUEDNO,a.CHR_DEMANDNO,a.CHR_SPARETYPE,a.CHR_TYPE,a.INT_QTY,a.CHR_ISSUED_SERIALNUMBER,b.CHR_PRODUCTCODE,a.CHR_RETURN_STATUS,";
      sql = String.valueOf(sql) + " if(c.CHR_CALLTYPE='Q', ";
      sql = String.valueOf(sql) + " ( SELECT d.CHR_CUSTOMERNAME FROM inv_ss_sparemaster d  WHERE   c.CHR_PRODUCT_SERIALNUMBER = d.CHR_SERIALNO ), ";
      sql = String.valueOf(sql) + " c.CHR_CUSTOMER";
      sql = String.valueOf(sql) + " ) ,";
      sql = String.valueOf(sql) + " a.INT_RETURN_QTY,a.INT_USED_QTY FROM inv_ss_t_sparedemandissue a ,inv_m_produtlist b,inv_ss_sparedemand c ";
      sql = String.valueOf(sql) + " WHERE a.INT_ISSUEID>0 AND a.CHR_PRODUCTCODE = b.CHR_PRODUCTID AND c.CHR_DEMANDNO = a.CHR_DEMANDNO";
      sql = String.valueOf(sql) + " AND a.CHR_ISSUED_BY='" + userid + "'";
      if (!"0".equals(type))
        sql = String.valueOf(sql) + " AND a.CHR_TYPE = '" + type + "'"; 
      if (!"0".equals(sparetype))
        sql = String.valueOf(sql) + " AND a.CHR_SPARETYPE = '" + sparetype + "' "; 
      if (!"0".equals(month))
        sql = String.valueOf(sql) + " AND month(a.DAT_ISSUED_DATE) = " + Integer.parseInt(month); 
      if (!"0".equals(year))
        sql = String.valueOf(sql) + " AND year(a.DAT_ISSUED_DATE) = " + year; 
      if (!"0".equals(startLetter))
        sql = String.valueOf(sql) + " AND b.CHR_PRODUCTCODE LIKE '" + startLetter + "%' "; 
      sql = String.valueOf(sql) + " ORDER BY a.CHR_DEMANDNO";
      System.out.println(sql);
      String[][] readData = CommonFunctions.QueryExecute(sql);
      if (readData.length > 0) {
        StringBuffer sb = new StringBuffer();
        for (int u = 0; u < readData.length; u++) {
          sb.append("<Row>");
          sb.append("<DemandIssueId>" + readData[u][0] + "</DemandIssueId>");
          sb.append("<DemandIssueNo>" + readData[u][1] + "</DemandIssueNo>");
          sb.append("<DemandNO>" + readData[u][2] + "</DemandNO>");
          sb.append("<Sparetype>" + readData[u][3] + "</Sparetype>");
          sb.append("<type>" + readData[u][4] + "</type>");
          sb.append("<qty>" + readData[u][5] + "</qty>");
          sb.append("<DemandissueSerialno>" + readData[u][6] + "</DemandissueSerialno>");
          sb.append("<productname>" + readData[u][7] + "</productname>");
          sb.append("<Status>" + readData[u][8] + "</Status>");
          sb.append("<customername>" + readData[u][9] + "</customername>");
          sb.append("<returnqty>" + readData[u][10] + "</returnqty>");
          sb.append("<usedqty>" + readData[u][11] + "</usedqty>");
          sb.append("</Row>");
        } 
        sb.toString();
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write("<Rowssparereturn>" + sb.toString() + "</Rowssparereturn>");
      } else {
        response.setStatus(204);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
    } 
  }
}
