package com.my.org.erp.SmartInventory;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.file.FileFunctions;
import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.ArrayUtils;

public class InventoryMethodmsl extends HttpServlet {
   public static void loadItemsData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String search = request.getParameter("search");
         String group = request.getParameter("group");
         String sql = "";
         sql = "  SELECT b.CHR_GROUPNAME,a.CHR_ITEMID,a.CHR_ITEMNAME,a.CHR_DES,a.INT_ACTIVE,a.DOU_PURCHASEPRICE,a.DOU_SALESPRICE,a.CHR_WARRANTY,a.INT_ITEMID ";
         sql = sql + " FROM inv_m_item  a, inv_m_itemgroup b WHERE a.INT_ITEMGROUPID = b.INT_ITEMGROUPID";
         if (!"0".equals(group)) {
            sql = sql + " AND a.INT_ITEMGROUPID=" + group + "   ";
         }

         if (!"".equals(search) && !"0".equals(search)) {
            sql = sql + " AND a.CHR_ITEMNAME LIKE '%" + search + "%' ";
         }

         sql = sql + " ORDER BY a.CHR_ITEMNAME ";
         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadTermsandconditions(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_CONDITIONID,CHR_CONDITIONNAME,CHR_DES   FROM inv_m_terms_conditions ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_CONDITIONNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_CONDITIONNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadPaymentTermView(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME,CHR_DES   FROM inv_m_paymentterms ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_PAYMENTNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_PAYMENTNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadDivision(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String office = request.getParameter("office");
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_DIVIID,CHR_DIVICODE,CHR_DIVISHORTCODE,CHR_EMAILID,CHR_OFFICEIDS,FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID)   FROM inv_m_division WHERE INT_DIVIID >0";
         if (!"0".equals(StartLetter)) {
            sql = sql + " AND  CHR_DIVICODE LIKE '" + StartLetter + "%'";
         }

         if (!"0".equals(office)) {
            sql = sql + " AND CHR_OFFICEIDS LIKE '%" + office + "%' ";
         }

         sql = sql + " ORDER BY CHR_DIVICODE ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Row>");
               sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
               sb.append("<Name>" + readData[u][1].trim() + "</Name>");
               sb.append("<Shortcode>" + readData[u][2].trim() + "</Shortcode>");
               sb.append("<Email>" + readData[u][3].trim() + "</Email>");
               String[][] Data = CommonFunctions.QueryExecute("\tSELECT CHR_OFFICENAME FROM com_m_office  WHERE INT_OFFICEID IN (" + readData[u][4] + ") ");
               sql = "";
               if (Data.length <= 0) {
                  sql = " ";
               } else {
                  for(int v = 0; v < Data.length; ++v) {
                     sql = sql + Data[v][0] + " ,";
                  }

                  sql = sql.substring(0, sql.length() - 1);
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
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadModel(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_MODELID,CHR_MODELCODE   FROM inv_m_model ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_MODELCODE LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_MODELCODE ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadColor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_COLORID,CHR_COLORCODE   FROM inv_m_color ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_COLORCODE LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_COLORCODE ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadMake(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_MAKEID,CHR_MAKENAME,CHR_DESC  FROM inv_m_make  ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_MAKENAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_MAKENAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadUnit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_UNITID,CHR_MEASUREMENT,CHR_SYMBOL,CHR_DESC FROM inv_m_units    ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_MEASUREMENT LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_MEASUREMENT ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadProcessor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_PROCESSORID,CHR_PROCESSORNAME,CHR_DESC FROM inv_m_processor ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_PROCESSORNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_PROCESSORNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadChipset(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_CHIPSETID,CHR_CHIPSET,CHR_DESC FROM inv_m_chipset ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_CHIPSET LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_CHIPSET ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadMemory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_MEMORYID,CHR_MEMORYNAME,CHR_DESC FROM inv_m_memory ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_MEMORYNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_MEMORYNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadHarddisk(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_HARDDISKID,CHR_HARDDISKNAME,CHR_DESC FROM inv_m_harddisk ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_HARDDISKNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_HARDDISKNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadGraphics(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_GRAPHICSID,CHR_GRAPHICS,CHR_DESC FROM inv_m_graphics ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_GRAPHICS LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_GRAPHICS ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadMonitor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_MONITORID ,CHR_MONITOR, CHR_DESC FROM inv_m_monitor ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_MONITOR LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_MONITOR ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadWireless(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_WIRELESSID ,CHR_WIRELESS, CHR_DESC  FROM inv_m_wireless ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_WIRELESS LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_WIRELESS ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadLAN(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_LANID ,CHR_LAN, CHR_DESC FROM inv_m_lan ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_LAN LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_LAN ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadOpticalDrive(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_OPTICALID ,CHR_OPTICAL, CHR_DESC FROM inv_m_opticaldrive ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_OPTICAL LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_OPTICAL ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadOperatingSystem(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_OSID ,INT_OSNAME, CHR_DESC FROM inv_m_operatingsystem ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  INT_OSNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY INT_OSNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadCourier(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_COURIERID,CHR_COURIERNAME   FROM inv_m_courier ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_COURIERNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_COURIERNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadTax(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = "  SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE,CHR_DES,if(CHR_FLAG ='Y','In-State','Out-State'),DOU_IGST,DOU_SGST,DOU_CGST  FROM inv_m_tax ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_TAXNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_TAXNAME,CHR_FLAG ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadPaymentCondition(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_PAYMENTCONDITIONID,CHR_PAYMENTNAME,CHR_DES   FROM inv_m_paymentcondition ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_PAYMENTNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_PAYMENTNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadBanks(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String producttxtstr = request.getParameter("startLetter");
         String searchtype = request.getParameter("searchtype");
         String bankgroup = request.getParameter("bankgroup");
         String sql = "";
         sql = " SELECT ";
         sql = sql + "  a.INT_BANKID,b.CHR_BANKGROUPNAME,a.CHR_BRANCH,a.CHR_BRANCHCODE,a.CHR_IFSCCODE, ";
         sql = sql + "  a.CHR_ADDRESS1,a.CHR_ADDRESS2,f.CHR_CITYNAME,e.CHR_DISTRICT,d.CHR_STATENAME,a.INT_PINCODE, ";
         sql = sql + "  a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE ";
         sql = sql + "  FROM com_m_bank a  , com_m_bankgroup b, ";
         sql = sql + "  com_m_country c,com_m_state d,com_m_district e,  com_m_city f ";
         sql = sql + "  WHERE a.INT_BANKGROUPID=b.INT_BANKGROUPID ";
         sql = sql + "  AND a.INT_COUNTRYID = c.INT_COUNTRYID   ";
         sql = sql + "  AND a.INT_STATEID =d.INT_STATEID     ";
         sql = sql + "  AND a.INT_DISTRICTID= e.INT_DISTRICTID    ";
         sql = sql + "  AND a.INT_CITYID =f.INT_CITYID  ";
         if (!"0".equals(bankgroup)) {
            sql = sql + "  AND a.INT_BANKGROUPID=" + bankgroup;
         }

         if (!"0".equals(producttxtstr)) {
            if ("2".equals(searchtype)) {
               sql = sql + " AND a.CHR_BRANCH like '" + producttxtstr + "%' ";
            } else {
               sql = sql + " AND a.CHR_BRANCH like '" + producttxtstr + "%' ";
            }
         }

         sql = sql + " ORDER BY a.CHR_BRANCH  ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadItemGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_ITEMGROUPID,CHR_GROUPNAME   FROM inv_m_itemgroup ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_GROUPNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY TRIM(CHR_GROUPNAME) ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadItemData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String search = request.getParameter("search");
         String sql = "";
         if (!"".equals(search) && !"null".equals(search)) {
            sql = " SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMNAME LIKE '" + search + "%' ORDER BY CHR_ITEMNAME";
         } else {
            sql = " SELECT CHR_ITEMID,CHR_ITEMNAME  FROM inv_m_item ORDER BY CHR_ITEMNAME";
         }

         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadProductGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_PRODUCTGROUPID,CHR_NAME   FROM inv_m_productgroup ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_NAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadProductList(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String usertype = "" + session.getAttribute("USRTYPE");
         String search = request.getParameter("search");
         String group = request.getParameter("group");
         String active = request.getParameter("active");
         String type = request.getParameter("type");
         String sql = "";
         sql = " SELECT a.INT_PRODUCTIDS,b.CHR_NAME,a.CHR_PRODUCTCODE,LEFT(a.CHR_PRODUCTDESC,300), a.CHR_WARRANTY,a.INT_ACTIVE , ";
         sql = sql + "  if(a.CHR_PTYPE ='F','Full Product',if(a.CHR_PTYPE='S' ,'Consumables','Swap Product')) , b.CHR_CONFIGURATION  ";
         sql = sql + "  FROM inv_m_produtlist a , inv_m_productgroup b ";
         sql = sql + "  WHERE a.INT_PRODUCTGROUPID = b.INT_PRODUCTGROUPID ";
         if (!"0".equals(group)) {
            sql = sql + " AND a.INT_PRODUCTGROUPID=" + group + "   ";
         }

         if (!"0".equals(type)) {
            sql = sql + " AND a.CHR_PTYPE  = '" + type + "'   ";
         }

         if (!"-1".equals(active)) {
            sql = sql + " AND a.INT_ACTIVE =" + active + "   ";
         }

         if (!"".equals(search) && !"0".equals(search)) {
            sql = sql + " AND a.CHR_PRODUCTCODE LIKE '%" + search + "%' ";
         }

         sql = sql + " ORDER BY a.CHR_PRODUCTCODE  LIMIT 1000";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               sb.append("<usertype>" + usertype + "</usertype>");
               sb.append("</Row>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadCustomerType(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_CUSTOMERTYPEID,CHR_TYPENAME   FROM inv_m_customertype ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_TYPENAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_TYPENAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadCustomerGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_CUSTOMERGROUPID,UPPER(CHR_NAME),CHR_SHORT   FROM inv_m_customergroup ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_NAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME, ";
         sql = sql + " CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE), ";
         sql = sql + "  a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL, a.CHR_VERIFIED ,a.CHR_ALIASNAME ,a.INT_PINCODE, a.CHR_TAXEXAMPTION, a.CHR_TAXEXAMPTIONNO ";
         sql = sql + " FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f ";
         sql = sql + " WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   ";
         sql = sql + " AND a.INT_STATEID =c.INT_STATEID   ";
         sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID ";
         sql = sql + " AND a.INT_CITYID =e.INT_CITYID ";
         if (!"0".equals(customertype)) {
            sql = sql + " AND  a.INT_CUSTOMERTYPEID =" + customertype;
         }

         if (!"0".equals(customergroup)) {
            sql = sql + " AND  a.INT_CUSTOMERGROUPID =" + customergroup;
         }

         if (!"0".equals(verified)) {
            sql = sql + " AND  a.CHR_VERIFIED ='" + verified + "'";
         }

         if (!"0".equals(producttxtstr)) {
            if ("2".equals(searchtype)) {
               sql = sql + " AND ( f.CHR_NAME like '%" + producttxtstr + "%'  OR  a.INT_PINCODE='%" + producttxtstr + "%' ) ";
            } else {
               sql = sql + " AND ( f.CHR_NAME like '%" + producttxtstr + "%' OR   a.INT_PINCODE='%" + producttxtstr + "%' ) ";
            }
         }

         sql = sql + " ORDER BY f.CHR_NAME  LIMIT 1000 ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadVendorGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_GROUPID,CHR_NAME   FROM inv_m_vendorsgroup ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_NAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadAllVendor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String producttxtstr = request.getParameter("startLetter");
         String searchtype = request.getParameter("searchtype");
         String sql = "";
         sql = sql + " SELECT a.INT_VENDORID,a.CHR_VENDORNAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT, ";
         sql = sql + " c.CHR_STATENAME,  ";
         sql = sql + " CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE), ";
         sql = sql + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL   ";
         sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d, ";
         sql = sql + " com_m_city e  ,inv_m_vendorsgroup f  ";
         sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID ";
         sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID  ";
         sql = sql + " AND a.INT_STATEID =c.INT_STATEID    ";
         sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID ";
         sql = sql + " AND a.INT_CITYID =e.INT_CITYID  ";
         if (!"0".equals(producttxtstr)) {
            if ("2".equals(searchtype)) {
               sql = sql + " AND a.CHR_VENDORNAME like '" + producttxtstr + "%' ";
            } else {
               sql = sql + " AND a.CHR_VENDORNAME like '" + producttxtstr + "%' ";
            }
         }

         sql = sql + " ORDER BY a.CHR_VENDORNAME  ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         if (!"".equals(search) && !"null".equals(search)) {
            if ("I".equals(type)) {
               sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE FROM inv_m_item  WHERE  INT_DIVIID = " + division + "  AND CHR_ITEMNAME LIKE '" + search + "%'ORDER BY CHR_ITEMNAME";
            }

            if ("P".equals(type)) {
               sql = "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PTYPE   FROM inv_m_produtlist   WHERE INT_DIVIID = " + division + " AND CHR_PRODUCTCODE LIKE '" + search + "%' ORDER BY CHR_PRODUCTCODE";
            }
         } else {
            if ("I".equals(type)) {
               if (sval.equals("0")) {
                  sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE  FROM inv_m_item WHERE INT_DIVIID = " + division + " ORDER BY CHR_ITEMNAME ";
               } else {
                  sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE  FROM inv_m_item  WHERE INT_DIVIID = " + division + " AND CHR_ITEMNAME LIKE '" + sval + "%' ORDER BY CHR_ITEMNAME";
               }
            }

            if ("P".equals(type)) {
               if (sval.equals("0")) {
                  sql = " SELECT CHR_PRODUCTID, CHR_PRODUCTCODE,CHR_PTYPE FROM inv_m_produtlist WHERE INT_DIVIID = " + division + " ORDER BY CHR_PRODUCTCODE";
               } else {
                  sql = " SELECT CHR_PRODUCTID, CHR_PRODUCTCODE ,CHR_PTYPE FROM inv_m_produtlist WHERE  INT_DIVIID = " + division + " AND CHR_PRODUCTCODE LIKE '" + sval + "%' ORDER BY CHR_PRODUCTCODE";
               }
            }
         }

         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<stock>");
               sb.append("<id>" + readData[u][0] + "</id>");
               sb.append("<itemName>" + readData[u][1] + "</itemName>");
               sql = "SELECT COUNT(*)  FROM inv_t_stock WHERE CHR_ITEMID ='" + readData[u][0] + "' AND  CHR_TYPE='" + type + "' AND INT_BRANCHID =" + Branch;
               int sth = 0;
               if (!CommonFunction.RecordExist(sql)) {
                  sb.append("<itemStockIn>" + sth + "</itemStockIn>");
                  sb.append("<itemAveragePrice>0</itemAveragePrice>");
                  sb.append("<itemLastSale>-</itemLastSale>");
                  sb.append("<ptype>-</ptype>");
               } else {
                  sql = "SELECT INT_STOCKINHAND,DAT_SALESDATE FROM inv_t_stock WHERE CHR_ITEMID ='" + readData[u][0] + "' AND  CHR_TYPE='" + type + "' AND INT_BRANCHID =" + Branch;
                  String[][] stockData = CommonFunctions.QueryExecute(sql);
                  sb.append("<itemLastSale>" + stockData[0][1] + "</itemLastSale>");
                  if ("P".equals(type) && "S".equals(readData[u][2])) {
                     sql = " SELECT DOU_AVGPRICE FROM inv_t_averageprice";
                     sql = sql + "\tWHERE  CHR_TYPE='" + type + "' ";
                     sql = sql + "\tAND CHR_ITEMID='" + readData[u][0] + "'  ";
                     sql = sql + "\tAND INT_BRANCHID= " + Branch;
                     sb.append("<itemStockIn>" + stockData[0][0] + "</itemStockIn>");
                     if (CommonFunction.RecordExist(sql)) {
                        String[][] stockAverageprice = CommonFunctions.QueryExecute(sql);
                        sb.append("<itemAveragePrice>" + CommonFunctions.Round(Double.parseDouble(stockAverageprice[0][0])) + "</itemAveragePrice>");
                     } else {
                        sb.append("<itemAveragePrice>0</itemAveragePrice>");
                     }

                     sb.append("<ptype>S</ptype>");
                  } else {
                     String sssql = "SELECT COUNT(*)  FROM inv_t_vendorgoodsreceived WHERE CHR_ITEMID ='" + readData[u][0].trim() + "' AND CHR_FLAG <> 'Y'  AND CHR_SERIALNO is not null  AND  CHR_TYPE='" + type.trim() + "' AND INT_BRANCHID =" + Branch.trim();
                     sth = CommonFunction.intRecordCount(sssql);
                     sb.append("<itemStockIn>" + sth + "</itemStockIn>");
                     sql = " SELECT (sum(DOU_UNITPRICE)/(SELECT count(*) FROM inv_t_vendorgoodsreceived ";
                     sql = sql + "\tWHERE CHR_FLAG ='N' and CHR_GRTFLAG='N' AND CHR_ITEMID='" + readData[u][0] + "'  AND CHR_SERIALNO is not null AND CHR_TYPE='" + type + "'AND INT_BRANCHID=" + Branch + " ))  FROM inv_t_vendorgoodsreceived ";
                     sql = sql + "\tWHERE CHR_FLAG ='N' and CHR_GRTFLAG='N' AND CHR_ITEMID='" + readData[u][0] + "'  AND CHR_SERIALNO is not null AND CHR_TYPE='" + type + "' AND INT_BRANCHID=" + Branch;
                     sql = sql + "\tgroup by CHR_ITEMID ";
                     if (CommonFunction.RecordExist(sql)) {
                        String[][] stockAverageprice = CommonFunctions.QueryExecute(sql);
                        sb.append("<itemAveragePrice>" + CommonFunctions.Round(Double.parseDouble(stockAverageprice[0][0])) + "</itemAveragePrice>");
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
            response.getWriter().write("<stocks>" + sb.toString() + "</stocks>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadStockAll(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<stock>");
               sb.append("<id>" + readData[u][0] + "</id>");
               sb.append("<itemName>" + readData[u][1] + "</itemName>");
               if (!CommonFunction.RecordExist(sql)) {
                  sb.append("<itemStockIn>0</itemStockIn>");
               } else {
                  String[][] stockData = CommonFunctions.QueryExecute(sql);
                  sb.append("<itemStockIn>" + stockData[0][0] + "</itemStockIn>");
               }

               sb.append("</stock>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<stocks>" + sb.toString() + "</stocks>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDemo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String usertype = "" + session.getAttribute("USRTYPE");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String status = request.getParameter("status");
         String txtSer = request.getParameter("startLetter");
         String Branch = request.getParameter("Branch");
         String sql = "";
         sql = " SELECT INT_DEMOID,FUN_GET_BRANCH_NAME(INT_BRANCHID),CHR_CUSTNAME,DATE_FORMAT(DT_DEMODATE,'%d-%b-%Y'), ";
         sql = sql + " CHR_STATUS,FIND_A_EMPLOYEE_ID_NAME(CHR_AUTHORISEDBY),FIND_A_EMPLOYEE_ID_NAME(CHR_HANDLEDBY) ";
         sql = sql + " FROM   inv_t_demo WHERE INT_DEMOID ";
         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(DT_DEMODATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(DT_DEMODATE) = " + year;
         }

         if (!"0".equals(Branch)) {
            sql = sql + " AND INT_BRANCHID = " + Branch;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND CHR_STATUS = '" + status + "' ";
         }

         if (!"0".equals(txtSer)) {
            sql = sql + " AND CHR_CUSTNAME LIKE '" + txtSer + "%' ";
         }

         sql = sql + " ORDER BY CHR_CUSTNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Row>");
               sb.append("<Id>" + readData[u][0] + "</Id>");
               sb.append("<BName>" + readData[u][1] + "</BName>");
               sb.append("<Name>" + readData[u][2] + "</Name>");
               sb.append("<Date>" + readData[u][3] + "</Date>");
               sb.append("<Status>" + readData[u][4] + "</Status>");
               sb.append("<Authorised>" + readData[u][5] + "</Authorised>");
               sb.append("<Handle>" + readData[u][6] + "</Handle>");
               sb.append("<usertype>" + usertype + "</usertype>");
               sb.append("</Row>");
            }

            sb.toString();
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var13) {
      }

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
            tablename = field + " inv_t_customersalesorderitemserial WHERE CHR_SALESORDERNO ='" + saleno + "'  ORDER BY INT_ID";
         } else if (type.equals("CashPay")) {
            tablename = field1 + " inv_t_cashserialno  WHERE CHR_SALESNO ='" + saleno + "'  ORDER BY INT_ID";
         } else if (type.equals("Direct")) {
            tablename = " SELECT a.INT_ID,a.CHR_SALESNO, ";
            tablename = tablename + "  a.CHR_ITEMID, ";
            tablename = tablename + "  if(a.CHR_TYPE='I' , ";
            tablename = tablename + "   ( SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID), ";
            tablename = tablename + "    ( SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID) ";
            tablename = tablename + "    ), ";
            tablename = tablename + "  if(a.CHR_TYPE='I' ,'Item','Product'), ";
            tablename = tablename + "    ";
            tablename = tablename + "   a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_GRTFLAG ";
            tablename = tablename + "  FROM   inv_t_swapsalesserialno  a ";
            tablename = tablename + " WHERE a.CHR_SALESNO ='" + saleno + "'  ORDER BY a.INT_ID";
         }

         System.out.println(tablename);
         String[][] readData = CommonFunctions.QueryExecute(tablename);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Record>");

               for(int y = 0; y < 7; ++y) {
                  sb.append("<Column" + (y + 1) + ">" + readData[u][y] + "</Column" + (y + 1) + ">");
               }

               sb.append("</Record>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Records>" + sb.toString() + "</Records>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadBranchess(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String officeid = request.getParameter("office");
         int id = Integer.parseInt(officeid);
         String sql = "";
         sql = " SELECT b.INT_COMPANYID,UPPER(a.CHR_COMPANYNAME),b.INT_BRANCHID,UPPER(b.CHR_BRANCHNAME) FROM com_m_branch b, com_m_company a   WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
         sql = sql + " AND SOUNDEX(b.CHR_BRANCHNAME) = SOUNDEX((SELECT CHR_OFFICENAME FROM  com_m_office  WHERE INT_OFFICEID = " + id + ")) AND a.INT_ACTIVE =1  AND b.INT_ACTIVE =1 ORDER BY a.CHR_COMPANYNAME ";
         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         String Selection = CommonFunctions.QueryExecute("SELECT  INT_COMPANYSELECTION FROM m_institution WHERE INT_ID=1")[0][0];
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<branch>");
               sb.append("<Companyid>" + readData[u][0] + "</Companyid>");
               sb.append("<CompanyName>" + readData[u][1] + "</CompanyName>");
               sb.append("<Branchid>" + readData[u][2] + "</Branchid>");
               sb.append("<Selection>" + Selection + "</Selection>");
               sb.append("<BranchName>" + readData[u][3] + "</BranchName>");
               sb.append("</branch>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<branches>" + sb.toString() + "</branches>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String empid = "" + session.getAttribute("EMPID");
         sql = "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_REPTO='" + empid + "' AND CHR_TYPE!='T' AND CHR_HOLD!='Y'order by CHR_STAFFNAME ";
         String[][] Data = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         int entry = 0;
         if (Data.length > 0) {
            for(int u = 0; u < Data.length; ++u) {
               sql = " SELECT count(*),sum(DOU_TOTAL) FROM conveyance_t_conveyance WHERE CHR_STATUS='N' AND  (DAT_CONDATE)>='" + fromdate + "' AND (DAT_CONDATE)<='" + todate + "'AND CHR_EMPID='" + Data[u][0] + "'";
               String[][] readData = CommonFunctions.QueryExecute(sql);
               entry = Integer.parseInt(readData[0][0]);
               if (entry > 0) {
                  sb.append("<Conveyance>");
                  sb.append("<Staffid>" + Data[u][0] + "</Staffid>");
                  sb.append("<Staffname>" + Data[u][1] + "</Staffname>");
                  sb.append("<noofentry>" + readData[0][0] + "</noofentry>");
                  sb.append("<amount>" + readData[0][1] + "</amount>");
                  sb.append("</Conveyance>");
               }
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Conveyances>" + sb.toString() + "</Conveyances>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadTargetAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String year = request.getParameter("year");
         String office = request.getParameter("office");
         String dept = request.getParameter("dept");
         String startletter = request.getParameter("startletter");
         String[][] OfficeData = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN(" + CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='" + session.getAttribute("USRID") + "' ")[0][0] + " )");
         String officeids = "";
         if (OfficeData.length > 0) {
            for(int u = 0; u < OfficeData.length; ++u) {
               officeids = officeids + OfficeData[u][0] + ",";
            }
         }

         String sql = "";
         sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN, b.INT_JUL,";
         sql = sql + " b.INT_AUG, b.INT_SEP, b.INT_OCT, b.INT_NOV, b.INT_DEC, b.INT_JAN, b.INT_FEB, ";
         sql = sql + " b.INT_MAR,b.INT_TARGETID FROM com_m_staff a , inv_t_targetassign b ";
         sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
         if (!"0".equals(startletter)) {
            sql = sql + "  AND a.CHR_STAFFNAME like '" + startletter + "%'";
         }

         if (!"0".equals(office)) {
            sql = sql + " AND a.INT_OFFICEID =" + office;
         } else {
            sql = sql + " AND a.INT_OFFICEID IN(" + officeids + "0) ";
         }

         if (!"0".equals(dept)) {
            sql = sql + "  AND a.INT_DEPARTID=" + dept;
         }

         String[] empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
         String empids = "";
         if (empid.length > 0) {
            for(int i = 0; i < empid.length; ++i) {
               empids = empids + " '" + empid[i] + "' , ";
            }
         }

         sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
         sql = sql + "  AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
         System.out.println(sql);
         String[][] Data = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (Data.length > 0) {
            for(int u = 0; u < Data.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " b.INT_AUG, b.INT_SEP, b.INT_OCT, b.INT_NOV, b.INT_DEC, b.INT_JAN, b.INT_FEB, ";
         sql = sql + " b.INT_MAR, ";
         sql = sql + "( b.INT_APR+ b.INT_MAY+ b.INT_JUN+ b.INT_JUL+ b.INT_AUG+ b.INT_SEP+ b.INT_OCT+ b.INT_NOV+ b.INT_DEC+ b.INT_JAN+ b.INT_FEB+b.INT_MAR ) ";
         sql = sql + " FROM inv_m_division a , inv_t_targetassign_division b ";
         sql = sql + " WHERE a.INT_DIVIID =b.INT_DIVIID ";
         if (!"0".equals(startletter)) {
            sql = sql + "  AND a.CHR_DIVICODE like '" + startletter + "%'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID =" + division;
         }

         sql = sql + "  AND b.INT_YEAR = " + year;
         sql = sql + "    ORDER BY a.CHR_DIVICODE ";
         System.out.println(sql);
         String[][] Data = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (Data.length > 0) {
            for(int u = 0; u < Data.length; ++u) {
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
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadTargetAssignAll(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String usertype = "" + session.getAttribute("USRTYPE");
         String userid = "" + session.getAttribute("EMPID");
         String years = request.getParameter("year");
         String office = request.getParameter("office");
         String dept = request.getParameter("dept");
         String period = request.getParameter("period");
         String sql = "";
         int year = Integer.parseInt(years);
         String[] empid;
         String empids;
         int i;
         double salessum;
         double achieve;
         double percent;
         StringBuffer sb;
         int u;
         String[][] salesdata2;
         String[][] data;
         if ("1".equals(period)) {
            sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN,(b.INT_APR+ b.INT_MAY+ b.INT_JUN)  FROM com_m_staff a , inv_t_targetassign b ";
            sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
            if ("A".equals(usertype)) {
               sql = sql + " AND a.CHR_EMPID='" + userid + "' ";
            }

            if (!"0".equals(office)) {
               sql = sql + " AND a.INT_OFFICEID=" + office;
            }

            if (!"0".equals(dept)) {
               sql = sql + " AND a.INT_DEPARTID=" + dept;
            }

            empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
            empids = "";
            if (empid.length > 0) {
               for(i = 0; i < empid.length; ++i) {
                  empids = empids + " '" + empid[i] + "' , ";
               }
            }

            sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
            sql = sql + "  AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
            data = CommonFunctions.QueryExecute(sql);
            salessum = 0.0D;
            achieve = 0.0D;
            percent = 0.0D;
            sb = new StringBuffer();
            if (data.length > 0) {
               for(u = 0; u < data.length; ++u) {
                  salessum = 0.0D;
                  sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' ) ";
                     sql = sql + " AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year;
                  sql = sql + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
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
            sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
            if (!"0".equals(office)) {
               sql = sql + " AND a.INT_OFFICEID=" + office;
            }

            if (!"0".equals(dept)) {
               sql = sql + " AND a.INT_DEPARTID=" + dept;
            }

            empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
            empids = "";
            if (empid.length > 0) {
               for(i = 0; i < empid.length; ++i) {
                  empids = empids + " '" + empid[i] + "' , ";
               }
            }

            sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
            sql = sql + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
            data = CommonFunctions.QueryExecute(sql);
            salessum = 0.0D;
            achieve = 0.0D;
            percent = 0.0D;
            sb = new StringBuffer();
            if (data.length > 0) {
               for(u = 0; u < data.length; ++u) {
                  salessum = 0.0D;
                  sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
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
         } else if ("3".equals(period)) {
            sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_OCT, b.INT_NOV, b.INT_DEC,(b.INT_OCT+ b.INT_NOV+ b.INT_DEC)  FROM com_m_staff a , inv_t_targetassign b ";
            sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
            if (!"0".equals(office)) {
               sql = sql + " AND a.INT_OFFICEID=" + office;
            }

            if (!"0".equals(dept)) {
               sql = sql + " AND a.INT_DEPARTID=" + dept;
            }

            empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
            empids = "";
            if (empid.length > 0) {
               for(i = 0; i < empid.length; ++i) {
                  empids = empids + " '" + empid[i] + "' , ";
               }
            }

            sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
            sql = sql + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
            data = CommonFunctions.QueryExecute(sql);
            salessum = 0.0D;
            achieve = 0.0D;
            percent = 0.0D;
            sb = new StringBuffer();
            if (data.length > 0) {
               for(u = 0; u < data.length; ++u) {
                  salessum = 0.0D;
                  sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
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
         } else if ("4".equals(period)) {
            sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JAN, b.INT_FEB, b.INT_MAR,(b.INT_JAN+ b.INT_FEB+b.INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
            sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
            if (!"0".equals(office)) {
               sql = sql + " AND a.INT_OFFICEID=" + office;
            }

            if (!"0".equals(dept)) {
               sql = sql + " AND a.INT_DEPARTID=" + dept;
            }

            empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
            empids = "";
            if (empid.length > 0) {
               for(i = 0; i < empid.length; ++i) {
                  empids = empids + " '" + empid[i] + "' , ";
               }
            }

            sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
            sql = sql + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
            data = CommonFunctions.QueryExecute(sql);
            salessum = 0.0D;
            achieve = 0.0D;
            percent = 0.0D;
            sb = new StringBuffer();
            if (data.length > 0) {
               for(u = 0; u < data.length; ++u) {
                  salessum = 0.0D;
                  sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
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
         } else if ("5".equals(period)) {
            sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, INT_APR,INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,INT_DEC,INT_JAN,INT_FEB,INT_MAR ,(INT_APR+INT_MAY+INT_JUN+INT_JUL+INT_AUG+INT_SEP+INT_OCT+INT_NOV+INT_DEC+INT_JAN+INT_FEB+INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
            sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
            if (!"0".equals(office)) {
               sql = sql + " AND a.INT_OFFICEID=" + office;
            }

            if (!"0".equals(dept)) {
               sql = sql + " AND a.INT_DEPARTID=" + dept;
            }

            empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
            empids = "";
            if (empid.length > 0) {
               for(i = 0; i < empid.length; ++i) {
                  empids = empids + " '" + empid[i] + "' , ";
               }
            }

            sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
            sql = sql + "   AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
            data = CommonFunctions.QueryExecute(sql);
            salessum = 0.0D;
            achieve = 0.0D;
            percent = 0.0D;
            sb = new StringBuffer();
            if (data.length > 0) {
               for(u = 0; u < data.length; ++u) {
                  salessum = 0.0D;
                  sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' AND CHR_PAYMENTSTATUS !='S'";
                     salesdata2 = CommonFunctions.QueryExecute(sql);
                     salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
                  }

                  salessum = CommonFunctions.Round(salessum);
                  achieve = CommonFunctions.Round(salessum / 100000.0D);
                  percent = CommonFunctions.Round(achieve / Double.parseDouble(data[u][14]) * 100.0D);
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
               response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
            } else {
               response.setStatus(204);
            }
         }
      } catch (Exception var23) {
         System.out.println(var23.getMessage());
         request.setAttribute("error", var23.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadTargetAssignMonth(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         (new StringBuilder()).append(session.getAttribute("USRTYPE")).toString();
         (new StringBuilder()).append(session.getAttribute("EMPID")).toString();
         String years = request.getParameter("year");
         String office = request.getParameter("office");
         String dept = request.getParameter("dept");
         String months = request.getParameter("month");
         String sql = "";
         int year = Integer.parseInt(years);
         int month = Integer.parseInt(months);
         int yea = year;
         sql = "SELECT a.CHR_EMPID,b.INT_JAN,b.INT_FEB,b.INT_MAR, b.INT_APR, b.INT_MAY, b.INT_JUN,b.INT_JUL,b.INT_AUG,b.INT_SEP,b.INT_OCT,b.INT_NOV,b.INT_DEC,a.CHR_STAFFNAME FROM com_m_staff a , inv_t_targetassign b ";
         sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID ";
         if (!"0".equals(office)) {
            sql = sql + " AND a.INT_OFFICEID=" + office;
         }

         if (!"0".equals(dept)) {
            sql = sql + " AND a.INT_DEPARTID=" + dept;
         }

         String[] empid = CommonFunctions.getReportingEmployeeIds("" + session.getAttribute("EMPID"));
         String empids = "";
         if (empid.length > 0) {
            for(int i = 0; i < empid.length; ++i) {
               empids = empids + " '" + empid[i] + "' , ";
            }
         }

         sql = sql + "  AND a.CHR_EMPID IN(" + empids + "'0') ";
         sql = sql + "  AND b.INT_YEAR = " + year + "  ORDER BY a.CHR_STAFFNAME ";
         if (month >= 1 && month <= 3) {
            yea = year + 1;
         }

         String[][] data = CommonFunctions.QueryExecute(sql);
         if (data.length > 0) {
            double salessum = 0.0D;
            double achieve = 0.0D;
            double percent = 0.0D;
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < data.length; ++u) {
               salessum = 0.0D;
               achieve = 0.0D;
               percent = 0.0D;
               sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + yea + "-" + month + "-01' AND DAT_SALESDATE <='" + yea + "-" + month + "-31' AND CHR_PAYMENTSTATUS !='S'";
               String[][] salesdata2;
               if (CommonFunction.RecordExist(sql)) {
                  sql = "SELECT ";
                  sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                  sql = sql + "   FROM inv_t_directsales WHERE ( CHR_REF='" + data[u][0] + "' OR  CHR_REF1='" + data[u][0] + "' OR  CHR_REF2='" + data[u][0] + "' )  AND DAT_SALESDATE >='" + yea + "-" + month + "-01' AND DAT_SALESDATE <='" + yea + "-" + month + "-31' AND CHR_PAYMENTSTATUS !='S'";
                  salesdata2 = CommonFunctions.QueryExecute(sql);
                  salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
               }

               sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + yea + "-" + month + "-01' AND DAT_SALESDATE <='" + yea + "-" + month + "-31' AND CHR_PAYMENTSTATUS !='S'";
               if (CommonFunction.RecordExist(sql)) {
                  sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + yea + "-" + month + "-01' AND DAT_SALESDATE <='" + yea + "-" + month + "-31' AND CHR_PAYMENTSTATUS !='S'";
                  salesdata2 = CommonFunctions.QueryExecute(sql);
                  salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
               }

               sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + yea + "-" + month + "-01' AND DAT_SALESDATE <='" + yea + "-" + month + "-31' AND CHR_PAYMENTSTATUS !='S'";
               if (CommonFunction.RecordExist(sql)) {
                  sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='" + data[u][0] + "' AND DAT_SALESDATE >='" + yea + "-" + month + "-01' AND DAT_SALESDATE <='" + yea + "-" + month + "-31' AND CHR_PAYMENTSTATUS !='S'";
                  salesdata2 = CommonFunctions.QueryExecute(sql);
                  salessum += CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
               }

               salessum = CommonFunctions.Round(salessum);
               achieve = CommonFunctions.Round(salessum / 100000.0D);
               percent = CommonFunctions.Round(achieve / Double.parseDouble(data[u][month]) * 100.0D);
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
            response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var25) {
         System.out.println(var25.getMessage());
         request.setAttribute("error", var25.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " WHERE INT_CUSTOMERGROUPID >0";
         if (!"0".equals(groupid)) {
            sql = sql + " AND CHR_NAME LIKE '" + groupid + "%'";
         }

         sql = sql + " ORDER BY INT_CUSTOMERGROUPID";
         System.out.println(sql);
         String[][] data = CommonFunctions.QueryExecute(sql);
         if (data.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < data.length; ++u) {
               sql = " SELECT count(*) ";
               sql = sql + " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
               sql = sql + " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
               sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
               sql = sql + " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID ";
               sql = sql + " AND a.INT_BRANCHID= " + Branch;
               if (!"0".equals(division)) {
                  sql = sql + " AND b.INT_DIVIID= " + division;
               }

               sql = sql + " AND MONTH(a.DAT_PAYMENTDATE)= " + month;
               sql = sql + " AND YEAR(a.DAT_PAYMENTDATE) = " + year;
               sql = sql + " AND d.INT_CUSTOMERGROUPID= " + data[u][0];
               if (CommonFunction.RecordExist(sql)) {
                  sql = " SELECT count(*) ,sum(a.DOU_PAIDAMOUNT),sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE)), ";
                  sql = sql + " sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE))/count(*) ";
                  sql = sql + " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
                  sql = sql + " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
                  sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
                  sql = sql + " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID ";
                  sql = sql + " AND a.INT_BRANCHID= " + Branch;
                  if (!"0".equals(division)) {
                     sql = sql + " AND b.INT_DIVIID= " + division;
                  }

                  sql = sql + " AND MONTH(a.DAT_PAYMENTDATE)= " + month;
                  sql = sql + " AND YEAR(a.DAT_PAYMENTDATE) = " + year;
                  sql = sql + " AND d.INT_CUSTOMERGROUPID= " + data[u][0];
                  String[][] vdata = CommonFunctions.QueryExecute(sql);
                  sb.append("<TargetAssign>");
                  sb.append("<Groupname>" + data[u][1].replaceAll("&", " AND ") + "</Groupname>");
                  sb.append("<NoofINV>" + vdata[0][0] + "</NoofINV>");
                  sb.append("<Collectionamt>" + CommonFunctions.Round(Double.parseDouble(vdata[0][1])) + "</Collectionamt>");
                  sb.append("<Collectionday>" + vdata[0][2] + "</Collectionday>");
                  sb.append("<CustomerGroupid>" + data[u][0] + "</CustomerGroupid>");
                  sb.append("<Avg>" + CommonFunctions.Round(Double.parseDouble(vdata[0][3])) + "</Avg>");
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
            response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         if (!"0".equals(division)) {
            dsql = " AND a.INT_DIVIID=" + division + "   ";
         }

         sql = "SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
         String[][] data = CommonFunctions.QueryExecute(sql);
         if (data.length > 0) {
            StringBuffer sb = new StringBuffer();
            int u;
            String[][] salesdata;
            if ("1".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  sb.append("<TargetAssign>");
                  sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
                  sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-04-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
                     } else {
                        sb.append("<Month1>0</Month1>");
                     }
                  } else {
                     sb.append("<Month1>0</Month1>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-05-01' AND DAT_SALESDATE <='" + year + "-05-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
                     } else {
                        sb.append("<Month2>0</Month2>");
                     }
                  } else {
                     sb.append("<Month2>0</Month2>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-06-01' AND DAT_SALESDATE <='" + year + "-06-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
                     } else {
                        sb.append("<Month3>0</Month3>");
                     }
                  } else {
                     sb.append("<Month3>0</Month3>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-06-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     sb.append("<Target>" + salesdata[0][0] + "</Target>");
                  } else {
                     sb.append("<Target>0</Target>");
                  }

                  sb.append("</TargetAssign>");
               }
            }

            if ("2".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  sb.append("<TargetAssign>");
                  sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
                  sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-07-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
                     } else {
                        sb.append("<Month1>0</Month1>");
                     }
                  } else {
                     sb.append("<Month1>0</Month1>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-08-01' AND DAT_SALESDATE <='" + year + "-08-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
                     } else {
                        sb.append("<Month2>0</Month2>");
                     }
                  } else {
                     sb.append("<Month2>0</Month2>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-09-01' AND DAT_SALESDATE <='" + year + "-09-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
                     } else {
                        sb.append("<Month3>0</Month3>");
                     }
                  } else {
                     sb.append("<Month3>0</Month3>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-09-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     sb.append("<Target>" + salesdata[0][0] + "</Target>");
                  } else {
                     sb.append("<Target>0</Target>");
                  }

                  sb.append("</TargetAssign>");
               }
            }

            if ("3".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  sb.append("<TargetAssign>");
                  sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
                  sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-10-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
                     } else {
                        sb.append("<Month1>0</Month1>");
                     }
                  } else {
                     sb.append("<Month1>0</Month1>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-11-01' AND DAT_SALESDATE <='" + year + "-11-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
                     } else {
                        sb.append("<Month2>0</ >");
                     }
                  } else {
                     sb.append("<Month2>0</Month2>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-12-01' AND DAT_SALESDATE <='" + year + "-12-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
                     } else {
                        sb.append("<Month3>0</Month3>");
                     }
                  } else {
                     sb.append("<Month3>0</Month3>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-12-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     sb.append("<Target>" + salesdata[0][0] + "</Target>");
                  } else {
                     sb.append("<Target>0</Target>");
                  }

                  sb.append("</TargetAssign>");
               }
            }

            if ("4".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  sb.append("<TargetAssign>");
                  sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
                  sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");
                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-01-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month1>" + salesdata[0][0] + "</Month1>");
                     } else {
                        sb.append("<Month1>0</Month1 >");
                     }
                  } else {
                     sb.append("<Month1>0</Month1>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + (year + 1) + "-02-01' AND DAT_SALESDATE <='" + (year + 1) + "-02-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month2>" + salesdata[0][0] + "</Month2>");
                     } else {
                        sb.append("<Month2>0</Month2 >");
                     }
                  } else {
                     sb.append("<Month2>0</Month2>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + (year + 1) + "-03-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     if (salesdata.length > 0) {
                        sb.append("<Month3>" + salesdata[0][0] + "</Month3>");
                     } else {
                        sb.append("<Month3>0</Month3 >");
                     }
                  } else {
                     sb.append("<Month3>0</Month3>");
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     sb.append("<Target>" + salesdata[0][0] + "</Target>");
                  } else {
                     sb.append("<Target>0</Target>");
                  }

                  sb.append("</TargetAssign>");
               }
            }

            if ("5".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  sb.append("<TargetAssign>");
                  sb.append("<Cgroup>" + data[u][0] + "</Cgroup>");
                  sb.append("<Cgroupname>" + data[u][1] + "</Cgroupname>");

                  for(int x = 1; x < 13; ++x) {
                     if (x <= 3) {
                        ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + (year + 1) + "-" + x + "-01' AND DAT_SALESDATE <='" + (year + 1) + "-" + x + "-31' ";
                     } else {
                        ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-" + x + "-01' AND DAT_SALESDATE <='" + year + "-" + x + "-31' ";
                     }

                     sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     if (CommonFunction.RecordExist(sql)) {
                        sql = "SELECT ";
                        sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                        sql = sql + "   FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                        sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                        salesdata = CommonFunctions.QueryExecute(sql);
                        if (salesdata.length > 0) {
                           sb.append("<Month" + x + ">" + salesdata[0][0] + "</Month" + x + ">");
                        } else {
                           sb.append("<Month" + x + ">0</Month" + x + ">");
                        }
                     } else {
                        sb.append("<Month" + x + ">0</Month" + x + ">");
                     }
                  }

                  ssql = dsql + "  AND a.INT_BRANCHID=" + Branch + " AND  DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' ";
                  sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                  sql = sql + " WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                  if (CommonFunction.RecordExist(sql)) {
                     sql = "SELECT ";
                     sql = sql + "  (SUM(DOU_AMOUNT)*(IF( CHR_REF='" + data[u][0] + "' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='" + data[u][0] + "',INT_REF_PERCENTAGE2,IF(CHR_REF2='" + data[u][0] + "',INT_REF_PERCENTAGE3,0) ) )/100 )) ";
                     sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
                     sql = sql + " WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID=" + data[u][0] + ssql;
                     salesdata = CommonFunctions.QueryExecute(sql);
                     sb.append("<Target>" + salesdata[0][0] + "</Target>");
                  } else {
                     sb.append("<Target>0</Target>");
                  }

                  sb.append("</TargetAssign>");
               }
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadContribution(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String admin = "" + session.getAttribute("USRTYPE");
         String empid = "" + session.getAttribute("EMPID");
         String month = request.getParameter("month");
         String ref = request.getParameter("ref");
         String year = request.getParameter("year");
         String txtSer = request.getParameter("txtSer");
         String day = request.getParameter("day");
         String customer = request.getParameter("customer");
         String sql = "";
         sql = " SELECT a.CHR_SALESNO,a.CHR_EMPID,d.CHR_STAFFNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),a.DOU_CONTRIBUTION,UPPER(FIND_A_CUSTOMER_NAME( b.INT_CUSTOMERID )) , ";
         sql = sql + " a.DOU_PAMOUNT,a.DOU_SAMOUNT, ROUND((a.DOU_CONTRIBUTION/DOU_PAMOUNT*100),2),a.INT_PERCENTAGE,ROUND( (a.DOU_SAMOUNT * a.INT_PERCENTAGE/100),2)   FROM inv_t_contribution a,inv_t_directsales b,inv_m_customerinfo c , com_m_staff d ";
         sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESNO ";
         sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
         sql = sql + " AND a.CHR_EMPID =d.CHR_EMPID ";
         if (!"F".equals(admin)) {
            sql = sql + "  AND a.CHR_EMPID='" + empid + "'";
         } else if (!"0".equals(ref)) {
            sql = sql + "  AND a.CHR_EMPID='" + ref + "'";
         }

         if (!"0".equals(customer)) {
            sql = sql + "  AND b.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(day)) {
            sql = sql + "  AND DAY(a.DAT_SALESDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + "  AND MONTH(a.DAT_SALESDATE) = " + month;
         }

         sql = sql + "  AND YEAR(a.DAT_SALESDATE) = " + year;
         if (!txtSer.equals("0")) {
            sql = sql + " AND d.CHR_STAFFNAME LIKE '" + txtSer + "%' ";
         }

         if (!txtSer.equals("0")) {
            sql = sql + " AND d.CHR_STAFFNAME LIKE '" + txtSer + "%' ";
         }

         sql = sql + " ORDER BY d.CHR_STAFFNAME ";
         System.out.println(sql);
         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadAssignPaymentCommitment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String salno = request.getParameter("invoicenumber");
         String billtype = request.getParameter("billtype");
         String sql = "";
         sql = " SELECT INT_PAYMENTCOMMITMENTID, CHR_SALESNO,CHR_INVOICETYPE,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%b-%Y'),DOU_COMMITMENTAMOUNT,";
         sql = sql + " CHR_STATUS,DATE_FORMAT(DT_RECIEVEDDATE,'%d-%b-%Y'),DOU_RECEIVEDAMOUNT,CHR_PAYMENTFLAG,CHR_NEXTFLAG  FROM inv_t_paymentcommitment  WHERE CHR_SALESNO='" + salno + "' AND CHR_INVOICETYPE='" + billtype + "'  ";
         CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Commitments>" + sb.toString() + "</Commitments>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadSalesNumber(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String type = request.getParameter("returnType");
         String month = request.getParameter("month");
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         if (type.equals("Invoice")) {
            sql = " SELECT CHR_INVOICENO ";
            sql = sql + " FROM  inv_t_customersalesorder   ";
            sql = sql + " WHERE DT_INVOICEDATE >='" + fDate + "'";
            sql = sql + " AND DT_INVOICEDATE <='" + tDate + "'";
            sql = sql + " AND INT_BRANCHID = " + branchid;
            sql = sql + " ORDER BY DT_INVOICEDATE ";
         } else if (type.equals("CashPay")) {
            sql = " SELECT CHR_SALESNO ";
            sql = sql + " FROM inv_t_cashsales ";
            sql = sql + " WHERE DAT_SALESDATE >='" + fDate + "'";
            sql = sql + " AND DAT_SALESDATE <='" + tDate + "'";
            sql = sql + " AND INT_BRANCHID = " + branchid;
            sql = sql + " ORDER BY DAT_SALESDATE ";
         } else if (type.equals("Direct")) {
            sql = " SELECT CHR_SALESNO  ";
            sql = sql + " FROM inv_t_directsales ";
            sql = sql + " WHERE DAT_SALESDATE >='" + fDate + "'";
            sql = sql + " AND DAT_SALESDATE <='" + tDate + "'";
            sql = sql + " AND INT_BRANCHID = " + branchid;
            sql = sql + " ORDER BY DAT_SALESDATE ";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Option>");
               sb.append("<Optionval>" + readData[u][0] + "</Optionval>");
               sb.append("<Optiondis>" + readData[u][0] + "</Optiondis>");
               sb.append("</Option>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Optionss>" + sb.toString() + "</Optionss>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void ItemProductAssignStock(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String type = request.getParameter("type");
         String itemid = request.getParameter("typeid");
         HttpSession session = request.getSession();
         String branchid = session.getAttribute("BRANCHID").toString();
         if (type.equals("1")) {
            sql = "SELECT CHR_ITEMID,INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='" + itemid + "'\tAND CHR_TYPE='I' AND INT_BRANCHID = " + branchid;
         }

         if (type.equals("2")) {
            sql = "SELECT CHR_ITEMID,INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='" + itemid + "'\tAND CHR_TYPE='P' AND INT_BRANCHID = " + branchid;
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Assigns>" + sb.toString() + "</Assigns>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void ItemProductAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String type = request.getParameter("type");
         String typeid = request.getParameter("typeid");
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("BRANCHID");
         int stock = 0;
         String ssql = "";
         if (type.equals("1")) {
            sql = " SELECT COUNT(*) ";
            sql = sql + " FROM inv_t_vendorgoodsreceived ";
            sql = sql + " WHERE CHR_FLAG <> 'Y'  AND CHR_FLAG='N' AND CHR_SERIALNO IS NOT NULL ";
            sql = sql + " AND  CHR_TYPE ='I' ";
            sql = sql + " AND  CHR_ITEMID ='" + typeid + "' ";
            sql = sql + " AND  INT_BRANCHID ='" + branchid + "' ";
            stock = CommonFunction.intRecordCount(sql);
            ssql = " Select CHR_DES,DOU_PURCHASEPRICE,DOU_SALESPRICE,INT_TAXID from inv_m_item WHERE CHR_ITEMID ='" + typeid + "'";
         }

         String[][] readData;
         if (type.equals("2")) {
            sql = "SELECT count(*) FROM inv_m_produtlist WHERE CHR_PTYPE='S' AND CHR_PRODUCTID='" + typeid + "'";
            if (!CommonFunction.RecordExist(sql)) {
               sql = " SELECT COUNT(*) ";
               sql = sql + " FROM inv_t_vendorgoodsreceived ";
               sql = sql + " WHERE CHR_FLAG <> 'Y'  AND CHR_FLAG='N'  AND CHR_SERIALNO IS NOT NULL    ";
               sql = sql + " AND  CHR_TYPE ='P' ";
               sql = sql + " AND  CHR_ITEMID ='" + typeid + "' ";
               sql = sql + " AND  INT_BRANCHID ='" + branchid + "' ";
               stock = CommonFunction.intRecordCount(sql);
               ssql = " select CHR_PRODUCTDESC,DOU_PURCHASEPRICE,DOU_SALESPRICE ,CHR_ITEMLIST,CHR_PTYPE,INT_TAXID from inv_m_produtlist WHERE CHR_PRODUCTID ='" + typeid + "'";
            } else {
               sql = " SELECT  (SUM(INT_PQTY)-SUM(INT_SQTY)) ";
               sql = sql + " FROM inv_t_vendorgoodsreceivedconsumable ";
               sql = sql + " WHERE CHR_ITEMID='" + typeid + "' AND CHR_CANCEL='N' AND CHR_TYPE='P' AND  INT_BRANCHID=" + branchid;
               sql = sql + " GROUP BY CHR_ITEMID ";
               readData = CommonFunctions.QueryExecute(sql);
               if (readData.length > 0) {
                  stock = Integer.parseInt(readData[0][0]);
               }

               sql = " select FUN_GET_AVERAGEPRICE('" + branchid + "','" + typeid + "') ";
               String[][] readData1 = CommonFunctions.QueryExecute(sql);
               ssql = " select CHR_PRODUCTDESC,DOU_PURCHASEPRICE,'" + readData1[0][0] + "' ,CHR_ITEMLIST,CHR_PTYPE,INT_TAXID from inv_m_produtlist WHERE CHR_PRODUCTID ='" + typeid + "'";
            }
         }

         System.out.println(ssql);
         readData = CommonFunctions.QueryExecute(ssql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Assign>");
               sb.append("<Desc>" + readData[u][0].replace("&", " ") + "</Desc>");
               sb.append("<PPrice>" + readData[u][1] + "</PPrice>");
               sb.append("<Price>" + readData[u][2] + "</Price>");
               sb.append("<Stock>" + stock + "</Stock>");
               if (!type.equals("2")) {
                  sb.append("<Plist>-</Plist>");
                  sb.append("<Ptype>-</Ptype>");
               } else {
                  String listname = "";
                  if (!"C".equals(readData[u][4])) {
                     sb.append("<Plist>-</Plist>");
                     sb.append("<Ptype>" + readData[u][4] + "</Ptype>");
                  } else {
                     String[] listdata = readData[u][3].split("~");

                     for(int x = 0; x < listdata.length; ++x) {
                        String query = " SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='" + listdata[x] + "'";
                        String[][] itemnames = CommonFunctions.QueryExecute(query);
                        listname = listname + itemnames[0][0] + " / " + listdata[x] + " / ~";
                     }

                     sb.append("<Plist>" + listname + "</Plist>");
                     sb.append("<Ptype>" + readData[u][4] + "</Ptype>");
                  }
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
            response.getWriter().write("<Assigns>" + sb.toString() + "</Assigns>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void ItemProductGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String id = request.getParameter("id");
         if (id.equals("1")) {
            sql = " Select INT_ITEMGROUPID,replace(UPPER(CHR_GROUPNAME),'&','AND') from inv_m_itemgroup   ORDER BY CHR_GROUPNAME ";
         }

         if (id.equals("2")) {
            sql = " select INT_PRODUCTGROUPID,replace(UPPER(CHR_NAME),'&','AND')from inv_m_productgroup ORDER BY CHR_NAME";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void itemproductdependsGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String itype = request.getParameter("itype");
         String group = request.getParameter("group");
         if (itype.equals("1")) {
            sql = " SELECT CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') FROM inv_m_item   WHERE INT_ACTIVE=1 ";
            if (!"0".equals(group)) {
               sql = sql + " AND INT_ITEMGROUPID = " + group;
            }

            sql = sql + " ORDER BY CHR_ITEMNAME ";
         }

         if (itype.equals("2")) {
            sql = " SELECT CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')FROM inv_m_produtlist  WHERE INT_ACTIVE=1";
            if (!"0".equals(group)) {
               sql = sql + " AND INT_PRODUCTGROUPID = " + group;
            }

            sql = sql + " ORDER BY CHR_PRODUCTCODE ";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void ItemProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String id = request.getParameter("id");
         if (id.equals("1")) {
            sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME";
         }

         if (id.equals("2")) {
            sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE INT_ACTIVE=1 ORDER BY CHR_PRODUCTCODE";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void INVItemProductdependsPurchaseRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String id = request.getParameter("id");
         String vendorid = request.getParameter("vendorid");
         String purchaserequest = request.getParameter("purchaserequest");
         if (id.equals("1")) {
            sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME";
         }

         if (id.equals("2")) {
            sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE INT_ACTIVE=1 ORDER BY CHR_PRODUCTCODE";
         }

         if (id.equals("1")) {
            sql = "Select a.CHR_ITEMID,replace(UPPER(a.CHR_ITEMNAME),'&','AND') ";
            sql = sql + " from inv_m_item  a , inv_t_purchaserequestitem  b ";
            sql = sql + " WHERE  a.CHR_ITEMID = b.CHR_ITEMID ";
            sql = sql + " AND a.INT_ACTIVE=1 AND b.CHR_TYPE ='I' ";
            sql = sql + " AND b.INT_VENDORID =   " + vendorid;
            sql = sql + " AND b.CHR_POREQUESTNO ='" + purchaserequest + "' ";
            sql = sql + " ORDER BY a.CHR_ITEMNAME ";
         }

         if (id.equals("2")) {
            sql = " Select a.CHR_PRODUCTID,replace(UPPER(a.CHR_PRODUCTCODE),'&','AND') ";
            sql = sql + " from inv_m_produtlist  a , inv_t_purchaserequestitem  b ";
            sql = sql + " WHERE  a.CHR_PRODUCTID = b.CHR_ITEMID ";
            sql = sql + " AND a.INT_ACTIVE=1 AND b.CHR_TYPE ='P' ";
            sql = sql + " AND b.INT_VENDORID = " + vendorid;
            sql = sql + " AND b.CHR_POREQUESTNO ='" + purchaserequest + "' ";
            sql = sql + " ORDER BY a.CHR_PRODUCTCODE ";
         }

         System.out.println("Load Item/Product depends on PR" + sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            sb.append("<item>");
            sb.append("<Id>0</Id>");
            if (id.equals("1")) {
               sb.append("<Idname>Select Item</Idname>");
            }

            if (id.equals("2")) {
               sb.append("<Idname>Select Product</Idname>");
            }

            sb.append("</item>");

            for(int u = 0; u < readData.length; ++u) {
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
            if (id.equals("1")) {
               sb.append("<Idname>Select Item</Idname>");
            }

            if (id.equals("2")) {
               sb.append("<Idname>Select Product</Idname>");
            }

            sb.append("</item>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<items>" + sb.toString() + "</items>");
         }
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void INVItemProductSparemodule(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String id = request.getParameter("id");
         String type = request.getParameter("type");
         if (id.equals("1")) {
            sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME";
         }

         if (id.equals("2")) {
            sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')  from inv_m_produtlist  WHERE INT_ACTIVE=1 ";
            if ("C".equals(type)) {
               sql = sql + " AND CHR_PTYPE='S' ";
            }

            sql = sql + " ORDER BY CHR_PRODUCTCODE";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadItemProductGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String id = request.getParameter("id");
         if (id.equals("1")) {
            sql = " Select INT_ITEMGROUPID,CHR_GROUPNAME from inv_m_itemgroup    ORDER BY CHR_GROUPNAME";
         }

         if (id.equals("2")) {
            sql = " select INT_PRODUCTGROUPID,CHR_NAME from inv_m_productgroup   ORDER BY CHR_NAME";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void QuotationEdit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String itype = request.getParameter("type");
         if (itype.equals("1")) {
            sql = " Select CHR_ITEMID,CHR_ITEMNAME from inv_m_item ";
         }

         if (itype.equals("2")) {
            sql = " select CHR_PRODUCTID,CHR_PRODUCTCODE from inv_m_produtlist ";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<item>");
               sb.append("<Id>" + readData[u][0] + "</Id>");
               sb.append("<Idname>" + readData[u][1] + "</Idname>");
               sb.append("</item>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<items>" + sb.toString() + "</items>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void AMCUniqueId(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String tablename = request.getParameter("tablename");
         String fieldname = request.getParameter("fieldname");
         String value = request.getParameter("value");
         sql = "SELECT COUNT(*) FROM " + tablename + " WHERE " + fieldname + "  = '" + value + "'";
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
         response.getWriter().write("<UniqueIds>" + sb.toString() + "</UniqueIds>");
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void AMCCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String customertype = request.getParameter("types");
         String StartLetter = request.getParameter("StartLetter");
         String sql = "";
         String tablename = "";
         if (customertype.equals("C")) {
            tablename = " inv_m_customerinfo ";
         }

         if (customertype.equals("N")) {
            tablename = " inv_m_noncustomerinfo ";
         }

         if (!StartLetter.equals("") && !StartLetter.equals("null")) {
            sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM " + tablename + " WHERE CHR_CUSTOMERNAME LIKE '" + StartLetter + "%' ORDER BY CHR_CUSTOMERNAME";
         } else {
            sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM " + tablename + " ORDER BY CHR_CUSTOMERNAME";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<ID>");
               sb.append("<Customerid>" + readData[u][0] + "</Customerid>");
               sb.append("<Customername>" + readData[u][1] + "</Customername>");
               sb.append("</ID>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<IDs>" + sb.toString() + "</IDs>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         if (customertype.equals("0")) {
            flag = " ";
         }

         if (customertype.equals("C")) {
            flag = " AND CHR_CUSTOMERFLAG ='C'";
         }

         if (customertype.equals("N")) {
            flag = " AND CHR_CUSTOMERFLAG ='N'";
         }

         if (StartLetter.equals("0")) {
            start = " ";
         } else {
            start = " AND CHR_AMCID LIKE '" + StartLetter + "%'";
         }

         sql = "SELECT INT_AMCID,CHR_AMCID,INT_CUSTOMERID, CHR_CUSTOMERFLAG,DT_STARTDATE,DT_ENDDATE FROM inv_t_amc WHERE  YEAR(DT_STARTDATE) = " + year + flag + start + " ORDER BY CHR_AMCID";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String name = "";
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<AMC>");
               sb.append("<Amcid>" + readData[u][1] + "</Amcid>");
               String[][] readName;
               if (readData[u][3].equals("C")) {
                  if (CommonInfo.RecordExist("SELECT COUNT(*) FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" + readData[u][2])) {
                     sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" + readData[u][2];
                     readName = CommonFunctions.QueryExecute(sql);
                     name = readName[0][0];
                  } else {
                     name = "-";
                  }
               }

               if (readData[u][3].equals("N")) {
                  if (CommonInfo.RecordExist("SELECT COUNT(*) FROM inv_m_noncustomerinfo WHERE INT_CUSTOMERID=" + readData[u][2])) {
                     sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_noncustomerinfo WHERE INT_CUSTOMERID=" + readData[u][2];
                     readName = CommonFunctions.QueryExecute(sql);
                     name = readName[0][0];
                  } else {
                     name = "-";
                  }
               }

               sb.append("<Customername>-" + name + "</Customername>");
               sb.append("<Startdate>" + readData[u][4] + "</Startdate>");
               sb.append("<Enddate>" + readData[u][5] + "</Enddate>");
               sb.append("<Renewal>Renewal</Renewal>");
               sb.append("</AMC>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var13) {
         System.out.println(var13.getMessage());
         request.setAttribute("error", var13.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void ServiceCompalintID(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String StartLetter = request.getParameter("servicecompalintid");
         sql = "SELECT COUNT(*) FROM inv_t_service WHERE CHR_SERVICEID  = '" + StartLetter + "'";
         StringBuffer sb = new StringBuffer();
         boolean flag = false;
         if (CommonInfo.RecordExist(sql)) {
            flag = true;
         }

         String name = "" + flag;
         name = name.toUpperCase();
         sb.append("<ComplaintId>");
         sb.append("<Exsist>" + name + "</Exsist>");
         sb.append("</ComplaintId>");
         response.setContentType("text/xml");
         response.setHeader("Cache-Control", "no-cache");
         response.getWriter().write("<ComplaintIds>" + sb.toString() + "</ComplaintIds>");
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadServiceAmountAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String payType = request.getParameter("type");
         String id = request.getParameter("id");
         String sql = "";
         String sql1 = "";
         if (payType.equals("Invoice")) {
            sql = " select DOU_AMCAMOUNT FROM  inv_t_amc WHERE CHR_AMCID = '" + id + "'";
            sql1 = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + id + "' and CHR_FLAG='A' group by CHR_SERVICEID";
         }

         if (payType.equals("CashPay")) {
            sql = "select DOU_SERVICEAMOUNT FROM  inv_t_service WHERE CHR_SERVICEID = '" + id + "'";
            sql1 = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + id + "' and CHR_FLAG='S' group by CHR_SERVICEID";
         }

         double total = 0.0D;
         double paid = 0.0D;
         String[][] readDatas;
         if (CommonInfo.RecordExist(sql1)) {
            readDatas = CommonInfo.doubleRecordSetArray(sql1);
            paid = Double.parseDouble(readDatas[0][0]);
         }

         if (CommonInfo.RecordExist(sql)) {
            readDatas = CommonInfo.doubleRecordSetArray(sql);
            total = Double.parseDouble(readDatas[0][0]);
         }

         StringBuffer sb = new StringBuffer();
         sb.append("<ServiceId>");
         sb.append("<Serviceamount>" + total + "</Serviceamount>");
         sb.append("<Paidamount>" + paid + "</Paidamount>");
         sb.append("</ServiceId>");
         response.setContentType("text/xml");
         response.setHeader("Cache-Control", "no-cache");
         response.getWriter().write("<ServiceIds>" + sb.toString() + "</ServiceIds>");
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadAMCServiceids(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String payType = request.getParameter("type");
         String StartLetter = request.getParameter("StartLetter");
         String sql = "";
         if (payType.equals("Invoice")) {
            sql = " select CHR_AMCID FROM  inv_t_amc WHERE CHR_AMCID LIKE '" + StartLetter + "%' ORDER BY CHR_AMCID";
         }

         if (payType.equals("CashPay")) {
            sql = " select CHR_SERVICEID from inv_t_service WHERE CHR_SERVICEID LIKE '" + StartLetter + "%' ORDER BY CHR_SERVICEID";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<ServiceId>");
               sb.append("<Serviceid>" + readData[u][0] + "</Serviceid>");
               sb.append("</ServiceId>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<ServiceIds>" + sb.toString() + "</ServiceIds>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadAMCPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String payType = request.getParameter("payType");
         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String sql = "";
         if (payType.equals("") || payType.equals("null")) {
            payType = "Invoice";
         }

         if (payType.equals("Invoice")) {
            sql = " SELECT CHR_AMCID,INT_CUSTOMERID,CHR_CUSTOMERFLAG,DT_STARTDATE,DOU_AMCAMOUNT,INT_AMCID";
            sql = sql + " FROM  inv_t_amc Where year(DT_STARTDATE) = " + year + " and month(DT_STARTDATE) =" + mon;
         }

         if (payType.equals("CashPay")) {
            sql = " SELECT CHR_SERVICEID,INT_CUSTOMERID,CHR_CUSTOMERFLAG,DT_ATTENDATE,DOU_SERVICEAMOUNT,INT_SERVICEID";
            sql = sql + " FROM inv_t_service  Where year(DT_ATTENDATE) = " + year + " and month(DT_ATTENDATE) =" + mon;
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String StartLetter = request.getParameter("id");
         String name = "";
         double paidamount = 0.0D;
         double totalamount = 0.0D;
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               paidamount = 0.0D;
               totalamount = 0.0D;
               name = "-";
               if (readData[u][0].startsWith(StartLetter) || "0".startsWith(StartLetter)) {
                  String[][] paids;
                  if (payType.equals("Invoice")) {
                     sql = " Select CHR_CUSTOMERNAME from  inv_m_customerinfo WHERE INT_CUSTOMERID =" + readData[u][1];
                     if (CommonInfo.RecordExist("Select count(*) from  inv_m_customerinfo WHERE INT_CUSTOMERID =" + readData[u][1])) {
                        paids = CommonFunctions.QueryExecute(sql);
                        name = paids[0][0];
                     }

                     sql = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + readData[u][0] + "' and CHR_FLAG='A' group by CHR_SERVICEID ";
                     if (CommonInfo.RecordExist("select count(*)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + readData[u][0] + "' and CHR_FLAG='A' group by CHR_SERVICEID ")) {
                        paids = CommonInfo.doubleRecordSetArray(sql);
                        paidamount = Double.parseDouble(paids[0][0]);
                     }
                  }

                  if (payType.equals("CashPay")) {
                     sql = " Select CHR_CUSTOMERNAME from  inv_m_noncustomerinfo WHERE INT_CUSTOMERID =" + Integer.parseInt(readData[u][1]);
                     if (CommonInfo.RecordExist(" Select count(*) from  inv_m_noncustomerinfo WHERE INT_CUSTOMERID =" + Integer.parseInt(readData[u][1]))) {
                        paids = CommonFunctions.QueryExecute(sql);
                        name = paids[0][0];
                     }

                     sql = " select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + readData[u][0] + "' and CHR_FLAG='S' group by CHR_SERVICEID ";
                     if (CommonInfo.RecordExist(" select count(*) FROM  inv_t_serviceamount WHERE CHR_SERVICEID='" + readData[u][0] + "' and CHR_FLAG='S' group by CHR_SERVICEID ")) {
                        paids = CommonInfo.doubleRecordSetArray(sql);
                        paidamount = Double.parseDouble(paids[0][0]);
                     }
                  }

                  if (!readData[u][4].equals("-")) {
                     totalamount = Double.parseDouble(readData[u][4]);
                  }

                  sb.append("<Payment>");
                  sb.append("<AmcServiceid>" + readData[u][0] + "</AmcServiceid>");
                  sb.append("<Customername>" + name + "</Customername>");
                  sb.append("<Date>" + DateUtil.FormateDateSys(readData[u][3]) + "</Date>");
                  sb.append("<Amount>" + readData[u][4] + "</Amount>");
                  sb.append("<PaidAmount>" + paidamount + "</PaidAmount>");
                  sb.append("<Balance>" + (totalamount - paidamount) + "</Balance>");
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
            response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadServiceCall(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String StartLetter = request.getParameter("StartLetter");
         String sql = " Select INT_SERVICEID,\tCHR_SERVICEID\t,CHR_EMPID,\tINT_CUSTOMERID\t,CHR_CUSTOMERFLAG,";
         sql = sql + " CHR_SERVICEDESC,\tDT_ARAISEDATE,\tDT_ATTENDATE\t,DT_COMPLETEDATE,\tCHR_SERVICESTATUS ";
         sql = sql + " From inv_t_service\tWHERE month(DT_ARAISEDATE) = " + month;
         sql = sql + " AND  year(DT_ARAISEDATE) = " + year;
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               if (readData[u][1].startsWith(StartLetter) || "0".startsWith(StartLetter)) {
                  sb.append("<Servicecall>");
                  sb.append("<Servicerowid>" + readData[u][0] + "</Servicerowid>");
                  sb.append("<Serviceid>" + readData[u][1] + "</Serviceid>");
                  String[][] readDatass;
                  if (!readData[u][2].equals("-")) {
                     if (CommonInfo.RecordExist("Select count(*) from com_m_staff WHERE CHR_EMPID = '" + readData[u][2] + "'")) {
                        sql = "Select CHR_STAFFNAME from com_m_staff WHERE CHR_EMPID = '" + readData[u][2] + "'";
                        readDatass = CommonFunctions.QueryExecute(sql);
                        sb.append("<Staff>" + readDatass[0][0] + "</Staff>");
                     } else {
                        sb.append("<Staff>-</Staff>");
                     }
                  } else {
                     sb.append("<Staff>-</Staff>");
                  }

                  if (readData[u][4].equals("C")) {
                     if (CommonInfo.RecordExist("select count(*) from inv_m_customerinfo where INT_CUSTOMERID =" + readData[u][3])) {
                        sql = "select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID =" + readData[u][3];
                        readDatass = CommonFunctions.QueryExecute(sql);
                        sb.append("<Customername>" + readDatass[0][0] + "</Customername>");
                     } else {
                        sb.append("<Customername>-</Customername>");
                     }
                  }

                  if (readData[u][4].equals("N")) {
                     if (CommonInfo.RecordExist("select count(*) from inv_m_noncustomerinfo where INT_CUSTOMERID =" + readData[u][3])) {
                        sql = "select CHR_CUSTOMERNAME from inv_m_noncustomerinfo where INT_CUSTOMERID =" + readData[u][3];
                        readDatass = CommonFunctions.QueryExecute(sql);
                        sb.append("<Customername>" + readDatass[0][0] + "</Customername>");
                     } else {
                        sb.append("<Customername>-</Customername>");
                     }
                  }

                  sb.append("<Customerid>" + readData[u][4] + "</Customerid>");
                  sb.append("<Customerflag>" + readData[u][5] + "</Customerflag>");
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
            response.getWriter().write("<Servicecalls>" + sb.toString() + "</Servicecalls>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         (new StringBuilder()).append(session.getAttribute("BRANCHID")).toString();
         String searchid = request.getParameter("id");
         String day = request.getParameter("day");
         int month = Integer.parseInt(request.getParameter("month"));
         int year = Integer.parseInt(request.getParameter("year"));
         String type = request.getParameter("type");
         String sql = "";
         if (!payType.equals("Invoice") && !payType.equals("CashPay") && payType.equals("Direct")) {
            sql = " SELECT a.CHR_SALESNO,a.INT_CUSTOMERID,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),round(a.DOU_TOTALAMOUNT),a.CHR_PAYMENTSTATUS, ";
            sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') , ";
            sql = sql + " (select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO), ";
            sql = sql + " (  round(a.DOU_TOTALAMOUNT) - (select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO)    ), ";
            sql = sql + " a.INT_BRANCHID,a.INT_DIVIID,a.DAT_SALESDATE, ";
            sql = sql + "   (SELECT   count(*) FROM inv_t_paymentcommitment d WHERE   d.CHR_SALESNO =a.CHR_SALESNO  AND d.CHR_STATUS='N' GROUP BY  d.CHR_SALESNO ) ";
            sql = sql + " FROM inv_t_directsales a ,inv_m_customerinfo b ";
            sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CANCEL='N' ";
            if (!"0".equals(Branch)) {
               sql = sql + " AND  a.INT_BRANCHID =" + Branch + " ";
            }

            if (!"0".equals(custid)) {
               sql = sql + " AND a.INT_CUSTOMERID=" + custid;
            }

            if (!"0".equals(division)) {
               sql = sql + "  AND a.INT_DIVIID=" + division;
            }

            if ("1".equals(Payment)) {
               sql = sql + " AND a.CHR_PAYMENTSTATUS ='N' ";
            } else if ("2".equals(Payment)) {
               sql = sql + "  AND a.CHR_PAYMENTSTATUS='Y' ";
            } else if ("3".equals(Payment)) {
               sql = sql + "  AND a.CHR_PAYMENTSTATUS='P' ";
            }

            if (!"0".equals(day)) {
               sql = sql + " AND DAY(a.DAT_SALESDATE) =" + day;
            }

            if (month > 0) {
               sql = sql + " AND MONTH(a.DAT_SALESDATE) = " + month;
            }

            sql = sql + " AND YEAR(a.DAT_SALESDATE) = " + year;
            if ("1".equals(type)) {
               if (!"0".equals(searchid)) {
                  sql = sql + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + searchid.toUpperCase() + "%'";
               }
            } else {
               sql = sql + " AND ( (a.CHR_SALESNO LIKE '%" + searchid + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + searchid.toUpperCase() + "%') )";
            }

            sql = sql + " ORDER BY a.INT_SALESID ";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         System.out.println("Sales Payment.jsp SQL: " + sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               String bal = "0";
               if (!"-".equals(readData[u][7])) {
                  bal = readData[u][7];
               }

               double balance = (double)Integer.parseInt(bal);
               String ck = "";
               if (balance < 0.0D) {
                  ck = "(Check)";
               }

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
            response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var22) {
         System.out.println(var22.getMessage());
         request.setAttribute("error", var22.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadSearchSalesPaymentno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String payType = request.getParameter("payType");
         String search = request.getParameter("search");
         String sql = "";
         if (!payType.equals("Invoice") && !payType.equals("CashPay") && payType.equals("Direct")) {
            sql = " SELECT CHR_SALESNO FROM inv_t_directsales ";
            sql = sql + " WHERE CHR_PAYMENTSTATUS<>'Y' AND CHR_CANCEL='N' AND FIND_A_PAYMENTCOMMITMENT(CHR_SALESNO,'C') > 0 ";
         }

         if (!"".equals(search) && !"null".equals(search)) {
            sql = sql + " AND  CHR_SALESNO LIKE '%" + search + "%'  ";
         }

         sql = sql + " ORDER BY CHR_SALESNO ";
         System.out.println("loadSearchSalesPaymentno=====> " + sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         sql = sql + " AND MONTH(a.DAT_SALESDATE)=" + month + " ";
         sql = sql + " AND YEAR(a.DAT_SALESDATE)=" + year + " ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         sql = sql + "   GROUP BY a.CHR_SALESNO ORDER BY  SUBSTRING_INDEX(a.CHR_SALESNO, '/',1)";
         System.out.println();
         System.out.println(sql);
         System.out.println();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Directs>" + sb.toString() + "</Directs>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void INVServiceBillingPO(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String usertype = "" + session.getAttribute("USRTYPE");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String Branch = request.getParameter("Branch");
         String StartLetter = request.getParameter("id");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String day = request.getParameter("day");
         String type = request.getParameter("type");
         String Usertype = "-";
         if ("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString())) {
            Usertype = "F";
         }

         String sql = "";
         sql = "  SELECT a.INT_SERVICEPOID, a.CHR_SERVICEPOREF,DATE_FORMAT(a.DAT_PODATE,'%d-%b-%Y'),  ";
         sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),FUN_INV_DIVISION(a.INT_DIVIID),a.DOU_AMOUNT,  ";
         sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.CHR_STATUS,a.CHR_CANCEL,FUN_INV_SERVICE_PO_BILLEDAMOUNT(a.CHR_SERVICEPOREF),  ";
         sql = sql + " ( a.DOU_AMOUNT -FUN_INV_SERVICE_PO_BILLEDAMOUNT(a.CHR_SERVICEPOREF)  ) ";
         sql = sql + " FROM inv_t_servicebillingpo a   ";
         sql = sql + " WHERE  a.INT_SERVICEPOID > 0 ";
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         sql = sql + " AND YEAR(a.DAT_PODATE)=" + year + " ";
         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_PODATE)=" + month + " ";
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_PODATE)= " + day;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if ("1".equals(type)) {
            if (!"0".equals(StartLetter)) {
               sql = sql + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%'";
            }
         } else {
            sql = sql + " AND ( (a.CHR_SERVICEPOREF LIKE '%" + StartLetter + "%') OR ( FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '%" + StartLetter.toUpperCase() + "%') )";
         }

         sql = sql + "  ORDER BY  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String filepath = request.getRealPath("/");
         File f = null;
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Row>");
               sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
               sb.append("<Invoiceno>" + readData[u][1].trim() + "</Invoiceno>");
               sb.append("<Date>" + readData[u][2].trim() + "</Date>");
               sb.append("<Customer>" + readData[u][3].replace("&", "").trim() + "</Customer>");
               sb.append("<Division>" + readData[u][4].trim() + "</Division>");
               sb.append("<Amount>" + readData[u][5].trim() + "</Amount>");
               sb.append("<Ref>" + readData[u][6].trim() + "</Ref>");
               sb.append("<Status>" + readData[u][7].trim() + "</Status>");
               sb.append("<Cancel>" + readData[u][8].trim() + "</Cancel>");
               sb.append("<Billed>" + readData[u][9].trim() + "</Billed>");
               sb.append("<Balance>" + readData[u][10].trim() + "</Balance>");
               sb.append("<Usertype>" + Usertype + "</Usertype>");
               f = new File(filepath + "uploadfiles/SERVICEPO/" + readData[u][1].replaceAll("/", "_") + ".pdf");
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
      } catch (Exception var19) {
         System.out.println(var19.getMessage());
         request.setAttribute("error", var19.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadServiceBilling(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String usertype = "" + session.getAttribute("USRTYPE");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String Branch = request.getParameter("Branch");
         String StartLetter = request.getParameter("id");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String day = request.getParameter("day");
         String type = request.getParameter("type");
         String Usertype = "-";
         if ("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString())) {
            Usertype = "F";
         }

         String sql = "";
         sql = "  SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), ";
         sql = sql + " a.CHR_REF , a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ,  ";
         sql = sql + " (SELECT   count(*) FROM inv_t_paymentcommitment e WHERE   e.CHR_SALESNO =a.CHR_SALESNO  AND e.CHR_STATUS='N' GROUP BY  e.CHR_SALESNO ),";
         sql = sql + " (SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME) ,";
         sql = sql + " d.CHR_STATUS,a.CHR_CANCEL,FUN_INV_DIVISION(a.INT_DIVIID) , ";
         sql = sql + " (NOW() > DATE_ADD(DAT_SALESDATE, INTERVAL (SELECT INT_INVOCECHANGES FROM m_inventorysetting WHERE INT_ROWID= 1) DAY )) ";
         sql = sql + " FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c ,";
         sql = sql + " inv_t_paymentcommitment d   WHERE  a.CHR_SALESNO =d.CHR_SALESNO  ";
         sql = sql + "  AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF    ";
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         sql = sql + " AND YEAR(a.DAT_SALESDATE)=" + year + " ";
         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALESDATE)=" + month + " ";
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SALESDATE)= " + day;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if ("1".equals(type)) {
            if (!"0".equals(StartLetter)) {
               sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%'";
            }
         } else {
            sql = sql + " AND ( (a.CHR_SALESNO LIKE '%" + StartLetter + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '%" + StartLetter.toUpperCase() + "%') )";
         }

         sql = sql + "  GROUP BY  a.INT_ID";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Service>");
               sb.append("<Invoiceno>" + readData[u][0].trim() + "</Invoiceno>");
               sb.append("<Date>" + readData[u][1].trim() + "</Date>");
               sb.append("<Customer>" + readData[u][2].replace("&", "").trim() + "</Customer>");
               sb.append("<Ref>" + readData[u][6].trim() + "</Ref>");
               sb.append("<Amount>" + readData[u][4].trim() + "</Amount>");
               sb.append("<Status>" + readData[u][5].trim() + "</Status>");
               sb.append("<Commitment>" + readData[u][9].trim() + "</Commitment>");
               sb.append("<Userid>" + readData[u][8].trim() + "</Userid>");
               sb.append("<Cancel>" + readData[u][10].trim() + "</Cancel>");
               sb.append("<Division>" + readData[u][11].trim() + "</Division>");
               sb.append("<Dtcheck>" + readData[u][12].trim() + "</Dtcheck>");
               sb.append("<Usertype>" + Usertype + "</Usertype>");
               sb.append("</Service>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Services>" + sb.toString() + "</Services>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

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
         sql = sql + " a.DOU_ADVANCEAMOUNT,DATE_FORMAT(a.DAT_PAYMENTDATE,'%d-%b-%Y'), DATE_FORMAT(DAT_COLLECTEDDATE,'%d-%b-%Y'),FIND_A_EMPLOYEE_ID_NAME(a.CHR_COLLECTEDBY),FIND_A_EMPLOYEE_ID_NAME(a.CHR_CREATED_BY),a.CHR_TRANSFERD,  ";
         sql = sql + " a.CHR_ADVANCEID,a.CHR_TYPE,";
         sql = sql + " a.DOU_TRANSFERAMOUNT,(a.DOU_ADVANCEAMOUNT - a.DOU_TRANSFERAMOUNT), b.INT_CUSTOMERGROUPID  ";
         sql = sql + " FROM inv_t_advancepayment a, inv_m_customerinfo b ,inv_m_division c ";
         sql = sql + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND a.CHR_DELETEFLAG !='Y'";
         sql = sql + " AND a.INT_DIVIID = c.INT_DIVIID ";
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         sql = sql + " AND MONTH(DAT_CREATEDATE)=" + month + " ";
         sql = sql + " AND YEAR(DAT_CREATEDATE)=" + year + " ";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(DAT_CREATEDATE)= " + day;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(advanceto)) {
            sql = sql + " AND a.CHR_TYPE = '" + advanceto + "'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY a.INT_ADVANCEID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Advancesss>" + sb.toString() + "</Advancesss>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String search = request.getParameter("search");
         String customergroupid = request.getParameter("customergroupid");
         String stype = request.getParameter("type");
         String sql = "";
         sql = " SELECT a.INT_CUSTOMERGROUPID ,b.CHR_NAME  ,  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,  ";
         sql = sql + " a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3, f.CHR_CITYNAME, e.CHR_DISTRICT,d.CHR_STATENAME, ";
         sql = sql + " c.CHR_COUNTRYNAME, a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE ";
         sql = sql + " FROM inv_m_customerinfo a,inv_m_customergroup b, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
         sql = sql + " WHERE a.INT_CUSTOMERGROUPID = b.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.INT_COUNTRYID= c.INT_COUNTRYID  ";
         sql = sql + " AND a.INT_STATEID = d.INT_STATEID  ";
         sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
         sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
         if (!"0".equals(customergroupid)) {
            sql = sql + " AND b.INT_CUSTOMERGROUPID = " + customergroupid;
         }

         if ("2".equals(stype)) {
            sql = sql + " AND( (b.CHR_NAME LIKE '%" + search.trim() + "%' ) OR (a.CHR_MOBILE LIKE '%" + search.trim() + "%' )  )";
         } else if ("1".equals(stype) && !"0".equals(search)) {
            sql = sql + " AND a.CHR_STAFFNAME LIKE '" + search.trim() + "%'  ";
         }

         sql = sql + " ORDER BY b.CHR_NAME limit 1000 ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.CHR_DES,a.INT_DCSTATUS,e.CHR_STAFFNAME,SUM(c.DOU_UNITPRICE)  ";
         sql = sql + " FROM inv_t_directdc a,inv_t_directdcitem b,inv_t_vendorgoodsreceived c,inv_m_customerinfo d,com_m_staff e  ";
         sql = sql + " WHERE a.CHR_DCNO = b.CHR_DCNO AND   c.CHR_SERIALNO is not null AND   c.CHR_SERIALNO !=''  ";
         sql = sql + " AND b.CHR_SERIALNO= c.CHR_SERIALNO  ";
         sql = sql + " AND a.INT_CUSTOMERID=d.INT_CUSTOMERID  ";
         sql = sql + " AND a.CHR_REF  = e.CHR_EMPID  ";
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_DCDATE)=" + month + " ";
         }

         sql = sql + " AND YEAR(a.DAT_DCDATE)=" + year + " ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"2".equals(dcstatus)) {
            sql = sql + " AND a.INT_DCSTATUS=" + dcstatus;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         sql = sql + " GROUP BY a.CHR_DCNO  ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Services>" + sb.toString() + "</Services>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var13) {
         System.out.println(var13.getMessage());
         request.setAttribute("error", var13.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String usertype = "" + session.getAttribute("USRTYPE");
         String cancel = request.getParameter("cancel");
         String sql = "SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, ";
         sql = sql + " DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),";
         sql = sql + " a.INT_ONHOLD,a.INT_PURCHASESTATUS,a.CHR_PAYMENTSTATUS,";
         sql = sql + " c.CHR_BRANCHNAME,a.CHR_POREQUESTNO ,FUN_INV_DIVISION(a.INT_DIVIID), ";
         sql = sql + " a.CHR_EDD_STATUS,DATE_FORMAT(a.DAT_EDD ,'%d-%b-%Y'), a.CHR_VERIFIED, ";
         sql = sql + " a.CHR_CANCEL , ";
         sql = sql + " (NOW() > DATE_ADD(a.DAT_ORDERDATE, INTERVAL (SELECT INT_INVOCECHANGES FROM m_inventorysetting WHERE INT_ROWID= 1) DAY )) ";
         sql = sql + " FROM  inv_t_vendorpurchaseorder  a, inv_m_vendorsinformation b, com_m_branch c ";
         sql = sql + " WHERE a.INT_VENDORID =b.INT_VENDORID AND a.INT_BRANCHID = c.INT_BRANCHID ";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_ORDERDATE) =" + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_ORDERDATE) =" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_ORDERDATE) = " + year;
         }

         if (!"0".equals(vendorid)) {
            sql = sql + " AND a.INT_VENDORID = " + vendorid;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_VERIFIED = '" + status + "' ";
         }

         if (!"0".equals(cancel)) {
            sql = sql + " AND a.CHR_CANCEL = '" + cancel + "' ";
         }

         if ("1".equals(type)) {
            if (!"0".equals(StartLetter)) {
               sql = sql + " AND b.CHR_VENDORNAME LIKE '" + StartLetter + "%'   ";
            }
         } else {
            sql = sql + " AND ( (a.CHR_PURCHASEORDERNO LIKE '%" + StartLetter + "%') OR ( b.CHR_VENDORNAME LIKE '" + StartLetter.toUpperCase() + "%') )";
         }

         sql = sql + " ORDER BY INT_PURCHASEORDERID   ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               sb.append("<Usertype>" + usertype + "</Usertype>");
               sb.append("</purchase>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<purchases>" + sb.toString() + "</purchases>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, ";
         sql = sql + "  DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'), ";
         sql = sql + "  FUN_GET_BRANCH_NAME(a.INT_ADDRESSID1),FUN_GET_BRANCH_NAME(a.INT_ADDRESSID2), ";
         sql = sql + "  a.INT_ONHOLD,a.INT_PURCHASESTATUS,a.CHR_PAYMENTSTATUS,a.CHR_RECIVEDID,a.DAT_RECIVEDDATE,FUN_INV_DIVISION(a.INT_DIVIID)  ";
         sql = sql + "  FROM  inv_t_vendorpurchaseorder a  , inv_m_vendorsinformation b ";
         sql = sql + "  WHERE a.INT_VENDORID =b.INT_VENDORID  AND a.CHR_VERIFIED = 'Y'";
         sql = sql + "  AND a.CHR_CANCEL ='N' ";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_ORDERDATE) =" + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_ORDERDATE) =" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_ORDERDATE) = " + year;
         }

         if (!"0".equals(vendorid)) {
            sql = sql + " AND a.INT_VENDORID = " + vendorid;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(startLetter)) {
            sql = sql + " AND b.CHR_VENDORNAME LIKE '" + startLetter + "%' ";
         }

         sql = sql + "  ORDER BY b.CHR_VENDORNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            sql = sql + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
            sql = sql + " IF( a.CHR_TYPE ='I' ,  ";
            sql = sql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
            sql = sql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) ";
            sql = sql + " ) productcode,   ";
            sql = sql + " a.CHR_SERIALNO, ";
            sql = sql + " a.CHR_FLAG ";
            sql = sql + " FROM  inv_t_vendorgoodsreturn a  , inv_t_vendorpurchaseorder b , inv_m_vendorsinformation c ";
            sql = sql + " WHERE a.CHR_PURCHASEORDERNO=b.CHR_PURCHASEORDERNO ";
            sql = sql + " AND b.INT_VENDORID = c.INT_VENDORID  ";
            if (!"0".equals(month)) {
               sql = sql + " AND MONTH(a.DAT_RETURNDATE ) = " + month;
            }

            if (!"0".equals(year)) {
               sql = sql + " AND YEAR(a.DAT_RETURNDATE ) = " + year;
            }

            if (!"0".equals(StartLetter)) {
               sql = sql + " AND c.CHR_VENDORNAME  LIKE '" + StartLetter + "%' ";
            }
         } else {
            sql = " SELECT a.CHR_GRTNO ,a.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME, ";
            sql = sql + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
            sql = sql + " IF( a.CHR_TYPE ='I' ,  ";
            sql = sql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
            sql = sql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) ";
            sql = sql + " ) productcode,   ";
            sql = sql + " a.CHR_SERIALNO, ";
            sql = sql + " a.CHR_FLAG ";
            sql = sql + " FROM  inv_t_vendorgoodsreturn a  , inv_t_directpurchase b , inv_m_vendorsinformation c ";
            sql = sql + " WHERE a.CHR_PURCHASEORDERNO=b.CHR_PURCHASEORDERNO ";
            sql = sql + " AND b.INT_VENDORID = c.INT_VENDORID  ";
            if (!"0".equals(month)) {
               sql = sql + " AND MONTH(a.DAT_RETURNDATE ) = " + month;
            }

            if (!"0".equals(year)) {
               sql = sql + " AND YEAR(a.DAT_RETURNDATE ) = " + year;
            }

            if (!"0".equals(StartLetter)) {
               sql = sql + " AND c.CHR_VENDORNAME  LIKE '" + StartLetter + "%' ";
            }
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            sql = sql + " WHERE  a.INT_VENDORID = b.INT_VENDORID AND a.CHR_PURCHASEORDERNO <> 'null' ";
            if (!"0".equals(divis)) {
               sql = sql + "  AND  a.INT_DIVIID=" + divis + "  ";
            }

            if (!"0".equals(vendorid)) {
               sql = sql + "  AND  a.INT_VENDORID=" + vendorid + "  ";
            }

            if ("1".equals(Status)) {
               sql = sql + "   AND  a.CHR_PAYMENTSTATUS='N'   ";
            } else if ("2".equals(Status)) {
               sql = sql + "   AND  a.CHR_PAYMENTSTATUS='Y'   ";
            }

            if (!"0".equals(month)) {
               sql = sql + "   AND  MONTH(a.DAT_ORDERDATE) = " + month;
            }

            if (!"0".equals(year)) {
               sql = sql + "   AND  YEAR(a.DAT_ORDERDATE) = " + year;
            }

            if (!"0".equals(Branch)) {
               sql = sql + " AND  a.INT_BRANCHID =" + Branch + " ";
            }

            if ("1".equals(type)) {
               if (!"0".equals(searchid)) {
                  sql = sql + " AND b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%'";
               }
            } else {
               sql = sql + " AND ( (a.CHR_PURCHASEORDERNO LIKE '%" + searchid + "%') OR ( b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%') )";
            }

            sql = sql + " ORDER BY b.CHR_VENDORNAME ";
         } else if ("Direct".equals(payment)) {
            sql = " SELECT a.CHR_PURCHASEORDERNO  ,b.CHR_VENDORNAME ,a.DOU_TOTALAMOUNT ,   FUN_INV_GET_VENDORPAYMENT(a.CHR_PURCHASEORDERNO), ";
            sql = sql + "  (a.DOU_TOTALAMOUNT-FUN_INV_GET_VENDORPAYMENT(a.CHR_PURCHASEORDERNO)),a.CHR_PAYMENTSTATUS, a.CHR_VENDORPO ";
            sql = sql + "  FROM inv_t_directpurchase  a, inv_m_vendorsinformation  b   ";
            sql = sql + " WHERE a.INT_VENDORID=b.INT_VENDORID ";
            if (!"0".equals(divis)) {
               sql = sql + "  AND  a.INT_DIVIID=" + divis + "  ";
            }

            if (!"0".equals(vendorid)) {
               sql = sql + "  AND  a.INT_VENDORID=" + vendorid + "  ";
            }

            if ("1".equals(Status)) {
               sql = sql + "   AND  a.CHR_PAYMENTSTATUS !='Y'   ";
            } else if ("2".equals(Status)) {
               sql = sql + "   AND  a.CHR_PAYMENTSTATUS='Y'   ";
            }

            if (!"0".equals(month)) {
               sql = sql + "   AND  MONTH(a.DAT_ORDERDATE) = " + month;
            }

            if (!"0".equals(year)) {
               sql = sql + "   AND  YEAR(a.DAT_ORDERDATE) = " + year;
            }

            if (!"0".equals(Branch)) {
               sql = sql + " AND  a.INT_BRANCHID =" + Branch + " ";
            }

            if ("1".equals(type)) {
               if (!"0".equals(searchid)) {
                  sql = sql + " AND b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%'";
               }
            } else {
               sql = sql + " AND ( (a.CHR_PURCHASEORDERNO LIKE '%" + searchid + "%') OR ( b.CHR_VENDORNAME LIKE '" + searchid.toUpperCase() + "%') )";
            }

            sql = sql + "  ORDER BY b.CHR_VENDORNAME, a.CHR_PURCHASEORDERNO ";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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

         if (!"".equals(search) && !"null".equals(search)) {
            sql = sql + " AND (  (CHR_PURCHASEORDERNO LIKE '" + search + "%')  OR (CHR_VENDORPO LIKE '%" + search + "%')     ) ";
         }

         sql = sql + "  ORDER BY CHR_PURCHASEORDERNO ";
         System.out.println("loadSearchVendorPO=====> " + sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadReceivedId(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String rid = request.getParameter("rid");
         String purchasetype = request.getParameter("purchasetype");
         String sql = "";
         if ("V".equals(purchasetype)) {
            sql = "  SELECT a.INT_ID, ";
            sql = sql + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
            sql = sql + "  IF( a.CHR_TYPE ='I' ,  ";
            sql = sql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
            sql = sql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
            sql = sql + " ) productcode,   ";
            sql = sql + "  a.CHR_SERIALNO ,a.CHR_WARRANTY, a.CHR_GRTFLAG, ";
            sql = sql + " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y')   ";
            sql = sql + " FROM inv_t_vendorgoodsreceived  a ";
            sql = sql + " WHERE a.CHR_FLAG='N' AND a.CHR_RECEIVEDMODE ='P' AND a.CHR_RECIVEDID is not null ";
            sql = sql + " AND a.CHR_PURCHASEORDERNO = '" + rid + "'";
            sql = sql + " ORDER BY a.INT_ID ";
         } else {
            sql = "  SELECT a.INT_ID, ";
            sql = sql + " IF(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
            sql = sql + "  IF( a.CHR_TYPE ='I' ,  ";
            sql = sql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
            sql = sql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
            sql = sql + " ) productcode,   ";
            sql = sql + "  a.CHR_SERIALNO ,a.CHR_WARRANTY, a.CHR_GRTFLAG, ";
            sql = sql + " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y')   ";
            sql = sql + " FROM inv_t_vendorgoodsreceived  a ";
            sql = sql + " WHERE a.CHR_FLAG='N' AND a.CHR_RECEIVEDMODE ='D' AND a.CHR_RECIVEDID is not null ";
            sql = sql + " AND a.CHR_RECIVEDID = '" + rid + "'";
            sql = sql + " ORDER BY a.INT_ID ";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadSalesPaymentBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String rid = request.getParameter("salesid");
         String branchId = "" + session.getAttribute("BRANCHID");
         System.out.println("loadSalesPaymentBalance  branchId=================>" + branchId);
         String sql = "SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_customersalespayment   WHERE CHR_SALESORDERNO='" + rid + "' ";
         System.out.println("loadSalesPaymentBalance=================>" + sql);
         String[][] amounts = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         double amt = 0.0D;
         if (amounts.length > 0) {
            sql = "SELECT  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) FROM inv_t_directsales a ,inv_m_customerinfo b WHERE a.CHR_SALESNO='" + rid + "'\tAND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
            String[][] cdata = CommonFunctions.QueryExecute(sql);
            sb.append("<Amount>");
            if (!"-".equals(amounts[0][0])) {
               amt = Double.parseDouble(amounts[0][0]);
            }

            sb.append("<Balance>" + amt + "</Balance>");
            sb.append("<Customer>" + cdata[0][0].replaceAll("&", " AND ") + "</Customer>");
            sb.append("</Amount>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Amounts>" + sb.toString() + "</Amounts>");
         } else {
            response.setStatus(204);
         }

         System.out.println("loadSalesPaymentBalance=================>" + sb);
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDirectBillingValue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String invno = request.getParameter("invno");
         String Branch = request.getParameter("Branch");
         String sql = "";
         sql = " SELECT  a.CHR_SALESNO,a.DOU_NETAMOUNT,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,";
         sql = sql + " (SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_directbillingpayment   WHERE CHR_SALESNO='" + invno + "' AND INT_BRANCHID =" + Branch + ")";
         sql = sql + " ,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_directbilling a ,inv_m_customerinfo b ";
         sql = sql + " where a.INT_CUSTOMERID = b.INT_CUSTOMERID";
         sql = sql + " AND a.CHR_SALESNO='" + invno + "'";
         sql = sql + " AND a.INT_BRANCHID=" + Branch;
         String[][] amounts = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         double amt = 0.0D;
         double paid = 0.0D;
         if (amounts.length > 0) {
            sb.append("<Amount>");
            if (!"-".equals(amounts[0][1])) {
               amt = Double.parseDouble(amounts[0][1]);
            }

            if (!"-".equals(amounts[0][3])) {
               paid = Double.parseDouble(amounts[0][3]);
            }

            sb.append("<Invoiceamount>" + amounts[0][1] + "</Invoiceamount>");
            sb.append("<Paid>" + paid + "</Paid>");
            sb.append("<Balance>" + (amt - paid) + "</Balance>");
            sb.append("<Customer>" + amounts[0][2] + "</Customer>");
            sb.append("<Invoicedate>" + amounts[0][4] + "</Invoicedate>");
            sb.append("</Amount>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Amounts>" + sb.toString() + "</Amounts>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadServiceBillingValue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String invno = request.getParameter("invno");
         String Branch = request.getParameter("Branch");
         String sql = "";
         sql = " SELECT  a.CHR_SALESNO,a.DOU_NETAMOUNT,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,";
         sql = sql + " (SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_servicebillingpayment   WHERE CHR_SALESNO='" + invno + "' AND INT_BRANCHID =" + Branch + ")";
         sql = sql + " ,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_servicebilling a ,inv_m_customerinfo b ";
         sql = sql + " where a.INT_CUSTOMERID = b.INT_CUSTOMERID";
         sql = sql + " AND a.CHR_SALESNO='" + invno + "'";
         sql = sql + " AND a.INT_BRANCHID=" + Branch;
         String[][] amounts = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         double amt = 0.0D;
         double paid = 0.0D;
         if (amounts.length > 0) {
            sb.append("<Amount>");
            if (!"-".equals(amounts[0][1])) {
               amt = Double.parseDouble(amounts[0][1]);
            }

            if (!"-".equals(amounts[0][3])) {
               paid = Double.parseDouble(amounts[0][3]);
            }

            sb.append("<Invoiceamount>" + amounts[0][1] + "</Invoiceamount>");
            sb.append("<Paid>" + paid + "</Paid>");
            sb.append("<Balance>" + (amt - paid) + "</Balance>");
            sb.append("<Customer>" + amounts[0][2].replace("&", "") + "</Customer>");
            sb.append("<Invoicedate>" + amounts[0][4] + "</Invoicedate>");
            sb.append("</Amount>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Amounts>" + sb.toString() + "</Amounts>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadTaxcalculations(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String id = request.getParameter("id");
         String sql = "";
         sql = " SELECT  DOU_VALUE FROM inv_m_tax WHERE INT_TAXID=" + id;
         String[][] datas = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (datas.length > 0) {
            sb.append("<Tax>");
            sb.append("<Taxvalue>" + datas[0][0] + "</Taxvalue>");
            sb.append("</Tax>");
            System.out.println(sb.toString());
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Taxs>" + sb.toString() + "</Taxs>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
         request.setAttribute("error", var6.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c";
         sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SALESDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALESDATE) = " + month;
         }

         sql = sql + " AND YEAR(a.DAT_SALESDATE) = " + year;
         if ("1".equals(Payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='N'";
         } else if ("2".equals(Payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='Y'";
         } else if ("3".equals(Payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='P'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER  BY a.INT_ID ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Directs>" + sb.toString() + "</Directs>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c";
         sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SALESDATE) =  " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALESDATE)   = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND  YEAR(a.DAT_SALESDATE) = " + year;
         }

         if ("1".equals(Payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='N'";
         } else if ("2".equals(Payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='Y'";
         } else if ("3".equals(Payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='P'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER  BY FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Directs>" + sb.toString() + "</Directs>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadCustomerQuotation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String startletter = request.getParameter("startletter");
         String status = request.getParameter("status");
         String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_QUOTATIONDATE,'%d-%b-%Y'),";
         sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  a.CHR_ONHOLD ,a.DOU_TOTALAMOUNT,a.CHR_STATUS, ";
         sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID ),a.CHR_CANCEL,a.INT_PROGRESSBAR,datediff(NOW(),a.DAT_CREATIONTIME ),a.CHR_MODE";
         sql = sql + " FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
         sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_QUOTATIONDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_QUOTATIONDATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_QUOTATIONDATE) = " + year;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_STATUS = '" + status + "' AND a.CHR_CANCEL='N' ";
         }

         if (!"0".equals(startletter)) {
            sql = sql + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + startletter + "%' ";
         }

         sql = sql + " AND a.INT_BRANCHID=" + branchid + " ORDER BY  a.DAT_QUOTATIONDATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadProforma(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String startletter = request.getParameter("startletter");
         String status = request.getParameter("status");
         String sql = " SELECT a.INT_PROFORMAID,a.CHR_PROFORMANO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_PROFORMADATE,'%d-%b-%Y'),";
         sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  a.CHR_ONHOLD ,a.DOU_TOTALAMOUNT,a.CHR_STATUS, ";
         sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID ),a.CHR_CANCEL,a.INT_PROGRESSBAR,datediff(NOW(),a.DAT_CREATIONTIME )";
         sql = sql + " FROM  inv_t_proforma  a ,inv_m_customerinfo b";
         sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_PROFORMADATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_PROFORMADATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_PROFORMADATE) = " + year;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_STATUS = '" + status + "' AND a.CHR_CANCEL='N' ";
         }

         if (!"0".equals(startletter)) {
            sql = sql + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + startletter + "%' ";
         }

         sql = sql + " AND a.INT_BRANCHID=" + branchid + " ORDER BY  a.DAT_PROFORMADATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadPOVerification(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         String usertype = "" + session.getAttribute("USRTYPE");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String startletter = request.getParameter("startletter");
         String status = request.getParameter("status");
         String cancel = request.getParameter("cancel");
         String Usertype = "-";
         if ("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString())) {
            Usertype = "F";
         }

         String sql = "  SELECT a.INT_ROWID,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_SALESORDERNO,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
         sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_VERIFICATIED,DATE_FORMAT(a.DAT_SALEDATE,'%d-%b-%Y'), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y' ,a.CHR_POREQUESTNO,'No'), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF( b.CHR_CLOSEDSTATUS = 'Y','Closed','Pending') FROM inv_t_purchaserequest b WHERE b.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),''), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF(c.CHR_PR_PARTIALLY_RECEIVED='P','Partillay received',IF(c.CHR_PR_PARTIALLY_RECEIVED='Y','Fully Receive','Pending') ) FROM inv_t_purchaserequest c WHERE c.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),'') ,";
         sql = sql + "  a.DOU_TOTALAMOUNT , a.CHR_RFC , a.CHR_PR_MODIFICATION , a.CHR_CANCEL, a.CHR_BILLED ,a.INT_PROGRESSBAR ";
         sql = sql + "  FROM  inv_t_customersalesorder a WHERE  a.INT_ROWID >0     ";
         if (!"0".equals(customer)) {
            sql = sql + " AND  a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND  a.INT_DIVIID = " + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SALEDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALEDATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_SALEDATE) = " + year;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_VERIFICATIED = '" + status + "'  ";
         }

         if (!"0".equals(cancel)) {
            sql = sql + " AND a.CHR_CANCEL = '" + cancel + "'  ";
         }

         if (!"0".equals(startletter)) {
            sql = sql + " AND  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + startletter + "%' ";
         }

         sql = sql + " AND a.INT_BRANCHID=" + branchid + " ORDER BY  a.DAT_SALEDATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               sb.append("<RFC>" + readData[u][12] + "</RFC>");
               sb.append("<PRModify>" + readData[u][13] + "</PRModify>");
               sb.append("<Cancel>" + readData[u][14] + "</Cancel>");
               sb.append("<Billed>" + readData[u][15] + "</Billed>");
               sb.append("<Bar>" + readData[u][16].trim() + "</Bar>");
               sb.append("<Usertype>" + Usertype + "</Usertype>");
               sb.append("</Row>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var18) {
         System.out.println(var18.getMessage());
         request.setAttribute("error", var18.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void POSaleOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String status = request.getParameter("status");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String startletter = request.getParameter("startletter");
         String sql = "  SELECT a.INT_ROWID,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_SALESORDERNO,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
         sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_VERIFICATIED,DATE_FORMAT(a.DAT_SALEDATE,'%d-%b-%Y'), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y' ,a.CHR_POREQUESTNO,'-'), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF( b.CHR_CLOSEDSTATUS = 'Y','Closed','Pending') FROM inv_t_purchaserequest b WHERE b.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),''), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF(c.CHR_PR_PARTIALLY_RECEIVED='P','Partillay received',IF(c.CHR_PR_PARTIALLY_RECEIVED='Y','Fully Receive','Pending') ) FROM inv_t_purchaserequest c WHERE c.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),'') ,";
         sql = sql + "  a.DOU_TOTALAMOUNT , a.CHR_SALEORDER_APPROVAL,a.INT_PROGRESSBAR";
         sql = sql + "  FROM  inv_t_customersalesorder a WHERE  a.INT_ROWID >0  ";
         sql = sql + "  AND CHR_VERIFICATIED='Y'   ";
         if (!"0".equals(customer)) {
            sql = sql + " AND  a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_SALEORDER_APPROVAL = '" + status + "'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND  a.INT_DIVIID = " + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SALEDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALEDATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_SALEDATE) = " + year;
         }

         if (!"0".equals(startletter)) {
            sql = sql + " AND  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + startletter + "%' ";
         }

         sql = sql + " AND a.INT_BRANCHID=" + branchid + " ORDER BY  a.DAT_SALEDATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadPOBilling(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         String usertype = "" + session.getAttribute("USRTYPE");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String status = request.getParameter("status");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String startletter = request.getParameter("startletter");
         String cancel = request.getParameter("cancel");
         String type = request.getParameter("type");
         String txtSer = request.getParameter("txtSer");
         txtSer = txtSer.toUpperCase();
         String Usertype = "-";
         if ("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString())) {
            Usertype = "F";
         }

         String sql = "  SELECT a.INT_ROWID,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),a.CHR_SALESORDERNO,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
         sql = sql + "  FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_VERIFICATIED,DATE_FORMAT(a.DAT_SALEDATE,'%d-%b-%Y'), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y' ,a.CHR_POREQUESTNO,'-'), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF( b.CHR_CLOSEDSTATUS = 'Y','Closed','Pending') FROM inv_t_purchaserequest b WHERE b.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),''), ";
         sql = sql + "  IF(a.CHR_PR_AVAILABLE='Y',(SELECT IF(c.CHR_PR_PARTIALLY_RECEIVED='P','Partillay received',IF(c.CHR_PR_PARTIALLY_RECEIVED='Y','Fully Receive','Pending') ) FROM inv_t_purchaserequest c WHERE c.CHR_POREQUESTNO=Trim(a.CHR_POREQUESTNO) ),'') ,";
         sql = sql + "  a.DOU_TOTALAMOUNT ,a.CHR_BILLED,a.CHR_SALEORDER_APPROVAL, ";
         sql = sql + "  FUN_INV_GET_CPO_SALESINVOICE_COUNT(a.CHR_SALESORDERNO),  ";
         sql = sql + "   a.CHR_CANCEL, a.CHR_BILLED,a.INT_PROGRESSBAR   ";
         sql = sql + "  FROM  inv_t_customersalesorder a WHERE  a.INT_ROWID >0   AND CHR_VERIFICATIED='Y' ";
         if (!"0".equals(customer)) {
            sql = sql + " AND  a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_BILLED = '" + status + "'";
         }

         if (!"0".equals(cancel)) {
            sql = sql + " AND a.CHR_CANCEL = '" + cancel + "'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND  a.INT_DIVIID = " + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SALEDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALEDATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_SALEDATE) = " + year;
         }

         if ("1".equals(type)) {
            if (!"0".equals(startletter)) {
               sql = sql + " AND FIND_A_CUSTOMER_NAME(A.INT_CUSTOMERID) LIKE '" + startletter + "%'";
            }
         } else {
            sql = sql + " AND ( (a.CHR_SALESORDERNO LIKE '%" + txtSer + "%') OR ( FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + txtSer.toUpperCase() + "%') )";
         }

         sql = sql + " AND a.INT_BRANCHID=" + branchid + " ORDER BY  a.DAT_SALEDATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               sb.append("<Billing>" + readData[u][12] + "</Billing>");
               sb.append("<SaleOrder>" + readData[u][13] + "</SaleOrder>");
               if (!"Y".equals(readData[u][12])) {
                  sb.append("<CPOFlag>" + InventoryInvoiceFunctions.CPOReasdytoBill(readData[u][2]) + "</CPOFlag>");
               } else {
                  sb.append("<CPOFlag>-</CPOFlag>");
               }

               sb.append("<NoofBilling>" + readData[u][14] + "</NoofBilling>");
               sb.append("<Cancel>" + readData[u][15] + "</Cancel>");
               sb.append("<Billed>" + readData[u][16] + "</Billed>");
               sb.append("<Bar>" + readData[u][17] + "</Bar>");
               sb.append("<Usertype>" + Usertype + "</Usertype>");
               sb.append("</Row>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var20) {
         System.out.println(var20.getMessage());
         request.setAttribute("error", var20.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

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
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
         request.setAttribute("error", var6.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
         request.setAttribute("error", var6.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadCustomerPurchaseOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchid = "" + session.getAttribute("INVBRANCH");
         String division = request.getParameter("division");
         String customer = request.getParameter("customer");
         String poattach = request.getParameter("poattach");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String startletter = request.getParameter("startletter");
         String status = request.getParameter("status");
         String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_QUOTATIONDATE,'%d-%b-%Y'),";
         sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), a.CHR_ONHOLD,a.DOU_TOTALAMOUNT,a.CHR_STATUS,";
         sql = sql + "  (SELECT COUNT(*) FROM inv_t_customersalesorder c WHERE c.CHR_QUOTATIONNO=a.CHR_QUOTATIONNO ), ";
         sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID ) ,a.INT_PROGRESSBAR, datediff(NOW(),a.DAT_CREATIONTIME )";
         sql = sql + " FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
         sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID  AND a.CHR_ONHOLD='N' ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(poattach)) {
            sql = sql + " AND a.CHR_STATUS = '" + poattach + "' ";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_QUOTATIONDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_QUOTATIONDATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_QUOTATIONDATE) = " + year;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_STATUS = '" + status + "' AND a.CHR_CANCEL='N' ";
         }

         if (!"0".equals(startletter)) {
            sql = sql + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + startletter + "%' ";
         }

         sql = sql + " AND a.INT_BRANCHID=" + branchid + " ORDER BY  a.DAT_QUOTATIONDATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String filepath = request.getRealPath("/");
         File f = null;
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               f = new File(filepath + "uploadfiles/CPO_Order/" + readData[u][1].replaceAll("/", "_") + ".pdf");
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
      } catch (Exception var18) {
         System.out.println(var18.getMessage());
         request.setAttribute("error", var18.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDelData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String txtSer = request.getParameter("txtSer");
         if (txtSer.equals("null")) {
            txtSer = "";
         }

         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         String sql = "SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),";
         sql = sql + " a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
         sql = sql + " where a.DAT_SALEDATE>='" + fDate + "' ";
         sql = sql + " AND a.DAT_SALEDATE<='" + tDate + "' ";
         sql = sql + " AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               String query = "select CHR_SALESORDERNO,CHR_DELIVERYNO,DT_DELIVERYDATE from  inv_t_customersalesorderitemserial   WHERE CHR_SALESORDERNO='" + readData[u][2] + "' AND  CHR_DELIVERYNO is not null GROUP by CHR_DELIVERYNO";
               String[][] data = CommonFunctions.QueryExecute(query);
               if (readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer)) {
                  sb.append("<Delivery>");
                  sb.append("<Qno>" + readData[u][0] + "</Qno>");
                  sb.append("<Custpurchaseno>" + readData[u][1] + "</Custpurchaseno>");
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
            response.getWriter().write("<Deliverys>" + sb.toString() + "</Deliverys>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDelivaryData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String txtSer = request.getParameter("txtSer");
         if (txtSer.equals("null")) {
            txtSer = "";
         }

         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         String sql = "SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),";
         sql = sql + " a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
         sql = sql + " where a.DAT_SALEDATE>='" + fDate + "' ";
         sql = sql + " AND a.DAT_SALEDATE<='" + tDate + "' ";
         sql = sql + " AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               if (readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer)) {
                  sb.append("<Delivery>");
                  sb.append("<Qno>" + readData[u][0] + "</Qno>");
                  sb.append("<Custpurchaseno>" + readData[u][1] + "</Custpurchaseno>");
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
            response.getWriter().write("<Deliverys>" + sb.toString() + "</Deliverys>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadInvoiceData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String txtSer = request.getParameter("txtSer");
         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         String sql = " SELECT  a.CHR_QUOTATIONNO,a.CHR_INVOICENO,a.DT_INVOICEDATE,a.CHR_SALESORDERNO,";
         sql = sql + " FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,a.CHR_INVOICESTATUS ";
         sql = sql + " FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
         sql = sql + " where a.DAT_SALEDATE>='" + fDate + "'  ";
         sql = sql + " AND a.DAT_SALEDATE<='" + tDate + "' ";
         sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
         sql = sql + "  and CHR_DELIVERYSTATUS='Y' order by a.DAT_SALEDATE ";
         String[][] readData = CommonInfo.KRecordSetArray(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               if (readData[u][0].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer)) {
                  sb.append("<Invoice>");
                  sb.append("<Quotationid>" + readData[u][0] + "</Quotationid>");
                  sb.append("<Invnumber>" + readData[u][1] + "</Invnumber>");
                  sb.append("<Invdate>" + readData[u][2] + "</Invdate>");
                  sb.append("<SalesOrderNo>" + readData[u][3] + "</SalesOrderNo>");
                  sb.append("<Customername>" + readData[u][4] + "</Customername>");
                  sb.append("<Invstatus>" + readData[u][5] + "</Invstatus>");
                  sb.append("</Invoice>");
               }
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<invoices>" + sb.toString() + "</invoices>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadCashSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String txtSer = request.getParameter("txtSer");
         if (txtSer.equals("null")) {
            txtSer = "";
         }

         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         String sql = "SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS FROM inv_t_cashsales  where DAT_SALESDATE>='" + fDate + "' AND DAT_SALESDATE<='" + tDate + "' " + " order by DAT_SALESDATE";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               if (readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer)) {
                  sb.append("<cashSale>");
                  sb.append("<salId>" + readData[u][0] + "</salId>");
                  sb.append("<salNo>" + readData[u][1] + "</salNo>");
                  sb.append("<salDate>" + readData[u][3] + "</salDate>");
                  sb.append("<salTotal>" + readData[u][4] + "</salTotal>");
                  if (!readData[u][2].equals("-")) {
                     String csql = "Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID=" + readData[u][2];
                     String custName = CommonInfo.stringGetAnySelectField(csql, "CHR_CUSTOMERNAME");
                     sb.append("<quoCust>" + custName + "</quoCust>");
                  } else {
                     sb.append("<quoCust>-</quoCust>");
                  }

                  sb.append("</cashSale>");
               }
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<cashSales>" + sb.toString() + "</cashSales>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDirectSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String txtSer = request.getParameter("txtSer");
         txtSer = txtSer.toUpperCase();
         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         String sql = "SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,INT_SALESSTATUS FROM inv_t_directsales  where CHR_SALESTYPE='D' AND DAT_SALESDATE>='" + fDate + "' AND DAT_SALESDATE<='" + tDate + "' ";
         if (!"0".equals(txtSer)) {
            sql = sql + " AND CHR_SALESNO LIKE '" + txtSer + "%'";
         }

         sql = sql + "  order by DAT_SALESDATE";
         String[][] readData = CommonFunction.RecordSetArray(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<directSale>");
               sb.append("<salId>" + readData[u][0] + "</salId>");
               sb.append("<salNo>" + readData[u][1] + "</salNo>");
               sb.append("<salDate>" + readData[u][3] + "</salDate>");
               sb.append("<salTotal>" + readData[u][4] + "</salTotal>");
               String csql = "Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID=" + readData[u][2];
               String custName = CommonInfo.stringGetAnySelectField(csql, "CHR_CUSTOMERNAME");
               sb.append("<quoCust>" + custName + "</quoCust>");
               sb.append("<Status>" + readData[u][6] + "</Status>");
               sb.append("<PStatus>" + readData[u][5] + "</PStatus>");
               sb.append("</directSale>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDSwapSale(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         (new StringBuilder()).append(session.getAttribute("BRANCHID")).toString();
         String usertype = "" + session.getAttribute("USRTYPE");
         String txtSer = request.getParameter("txtSer");
         txtSer = txtSer.toUpperCase();
         String month = request.getParameter("month");
         String customer = request.getParameter("customer");
         String division = request.getParameter("division");
         int year = Integer.parseInt(request.getParameter("year"));
         String day = request.getParameter("day");
         String delivery = request.getParameter("delivery");
         String type = request.getParameter("type");
         String cancel = request.getParameter("cancel");
         String taxtype = request.getParameter("taxtype");
         String Usertype = "-";
         if ("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString())) {
            Usertype = "F";
         }

         String query = "";
         query = " SELECT a.INT_SALESID,a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') ,";
         query = query + " a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS,a.INT_SALESSTATUS,";
         query = query + "  FUN_INV_GET_PAYMENTCOMMITMENTCOUNT(a.CHR_SALESNO ), ";
         query = query + " a.DOU_TOTALAMOUNT,  FUN_INV_GET_STAFFNAMEBYUSERNAME(a.CHR_USRNAME), ";
         query = query + " a.CHR_INVOICEBLOCK,a.CHR_SALESTYPE,a.CHR_DELIVERY,DATEDIFF(DATE(a.DAT_COURIERDATE),a.DAT_SALESDATE),a.CHR_CANCEL,   ";
         query = query + " FUN_INV_DIVISION(a.INT_DIVIID) ,a.CHR_CPONUMBER ,";
         query = query + " (NOW() > DATE_ADD(a.DAT_SALESDATE, INTERVAL (SELECT INT_INVOCECHANGES FROM m_inventorysetting WHERE INT_ROWID= 1) DAY ))  dd";
         query = query + " ,IF(CHR_GST_TYPE='S','State','Central'),CHR_DISCOUNTBILL FROM inv_t_directsales  a ,inv_m_customerinfo b   ";
         query = query + " where  a.INT_CUSTOMERID = b.INT_CUSTOMERID   ";
         if (!"0".equals(month)) {
            query = query + " AND MONTH(a.DAT_SALESDATE) =" + month;
         }

         if (!"0".equals(year)) {
            query = query + " AND YEAR(a.DAT_SALESDATE) =" + year;
         }

         if (!"0".equals(delivery)) {
            query = query + " AND  a.CHR_DELIVERY  = '" + delivery + "' ";
         }

         if (!"0".equals(cancel)) {
            query = query + " AND  a.CHR_CANCEL  = '" + cancel + "' ";
         }

         if (!"0".equals(day)) {
            query = query + " AND DAY(a.DAT_SALESDATE)=" + day;
         }

         if (!"0".equals(customer)) {
            query = query + "  AND a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            query = query + "  AND a.INT_DIVIID = " + division;
         }

         if ("S".equals(taxtype)) {
            query = query + "  AND a.CHR_GST_TYPE = 'S'";
         } else if ("D".equals(taxtype)) {
            query = query + "  AND a.CHR_GST_TYPE = 'D'";
         }

         if ("1".equals(type)) {
            if (!"0".equals(txtSer)) {
               query = query + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer.toUpperCase() + "%'";
            }
         } else {
            query = query + " AND ( (a.CHR_SALESNO LIKE '%" + txtSer + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer.toUpperCase() + "%') )";
         }

         query = query + "   GROUP BY  a.INT_SALESID ";
         System.out.println(query);
         String[][] readData = CommonFunctions.QueryExecute(query);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<directSale>");
               sb.append("<salId>" + readData[u][0] + "</salId>");
               sb.append("<salNo>" + readData[u][1] + "</salNo>");
               sb.append("<salDate>" + readData[u][3] + "</salDate>");
               sb.append("<salTotal>" + readData[u][4] + "</salTotal>");
               sb.append("<quoCust>" + readData[u][2].replace("&", "9865043008") + "</quoCust>");
               sb.append("<Status>" + readData[u][6] + "</Status>");
               sb.append("<PStatus>" + readData[u][5] + "</PStatus>");
               sb.append("<PayCommitment>" + readData[u][7] + "</PayCommitment>");
               sb.append("<Entryby>" + readData[u][9] + "</Entryby>");
               sb.append("<Block>" + readData[u][10] + "</Block>");
               sb.append("<Saletype>" + readData[u][11] + "</Saletype>");
               sb.append("<Courier>" + readData[u][12] + "</Courier>");
               sb.append("<Courierdiff>" + readData[u][13] + "</Courierdiff>");
               sb.append("<Cancel>" + readData[u][14].trim() + "</Cancel>");
               sb.append("<Division>" + readData[u][15] + "</Division>");
               sb.append("<CPO>" + readData[u][16] + "</CPO>");
               sb.append("<Dtcheck>" + readData[u][17] + "</Dtcheck>");
               sb.append("<Taxtype>" + readData[u][18] + "</Taxtype>");
               sb.append("<Discount>" + readData[u][19] + "</Discount>");
               sb.append("<Usertype>" + Usertype + "</Usertype>");
               sb.append("<CpyShortName>" + CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME from com_m_company  WHERE INT_COMPANYID=" + session.getAttribute("INVCOMPANY"))[0][0] + "</CpyShortName>");
               sb.append("</directSale>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
            System.out.println("=============" + sb.toString());
         } else {
            response.setStatus(204);
         }
      } catch (Exception var20) {
         System.out.println(var20.getMessage());
         request.setAttribute("error", var20.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

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
         sql = sql + "  a.CHR_ACCOUNTFLAG  ,d.CHR_BRANCHNAME,a.DOU_TOTALAMOUNT,a.CHR_CANCEL,CONCAT('DR-',b.INT_CUSTOMERGROUPID),FUN_INV_DIVISION(a.INT_DIVIID)    FROM inv_t_directsales a , inv_m_customerinfo b , com_m_branch d ";
         sql = sql + " where b.INT_CUSTOMERID = a.INT_CUSTOMERID AND a.INT_BRANCHID =d.INT_BRANCHID AND a.INT_SALESSTATUS=1 ";
         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SALESDATE) =" + mon;
         }

         sql = sql + " AND year(a.DAT_SALESDATE)=" + year;
         if (!"0".equals(Accbranch)) {
            sql = sql + " AND a.INT_BRANCHID = " + Accbranch;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(Aflag)) {
            if ("1".equals(Aflag)) {
               sql = sql + "  AND a.CHR_ACCOUNTFLAG ='Y'";
            } else {
               sql = sql + "  AND a.CHR_ACCOUNTFLAG ='N'";
            }
         }

         if (!"0".equals(txtSer)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer + "%'";
         }

         sql = sql + " order by    SUBSTRING_INDEX( a.CHR_SALESNO, '/',1) , a.DAT_SALESDATE DESC ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         String filepath = request.getRealPath("/");
         File f = null;
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               f = new File(filepath + "uploadfiles/DCIMAGE/" + readData[u][0].replaceAll("/", "_") + ".pdf");
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
      } catch (Exception var16) {
         System.out.println(var16.getMessage());
         request.setAttribute("error", var16.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.CHR_PAYMENTSTATUS ,a.CHR_ACCOUNTFLAG ,d.CHR_BRANCHNAME,a.DOU_NETAMOUNT ,a.CHR_CANCEL ,CONCAT('DR-',b.INT_CUSTOMERGROUPID),FUN_INV_DIVISION(a.INT_DIVIID)";
         sql = sql + " FROM inv_t_servicebilling a , inv_m_customerinfo b , com_m_branch d ";
         sql = sql + " where b.INT_CUSTOMERID = a.INT_CUSTOMERID AND a.INT_BRANCHID =d.INT_BRANCHID ";
         if (!"0".equals(Accbranch)) {
            sql = sql + "  AND a.INT_BRANCHID = " + Accbranch;
         }

         if ("1".equals(Aflag)) {
            sql = sql + "  AND a.CHR_ACCOUNTFLAG ='Y'";
         } else if ("2".equals(Aflag)) {
            sql = sql + "  AND a.CHR_ACCOUNTFLAG ='N'";
         }

         if (!"0".equals(customer)) {
            sql = sql + "  AND a.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + "   AND  a.INT_DIVIID = " + division;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND month(a.DAT_SALESDATE) =" + mon;
         }

         sql = sql + " AND year(a.DAT_SALESDATE)=" + year;
         if (!"0".equals(txtSer)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer + "%'";
         }

         sql = sql + " order by SUBSTRING_INDEX(a.CHR_SALESNO, '/',1) , a.DAT_SALESDATE DESC ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         String filepath = request.getRealPath("/");
         File f = null;
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<directSale>");
               sb.append("<salesno>" + readData[u][0] + "</salesno>");
               sb.append("<custname>" + readData[u][1].trim().replace("&", "98650") + "</custname>");
               sb.append("<saledate>" + readData[u][2] + "</saledate>");
               f = new File(filepath + "uploadfiles/DCIMAGE/" + readData[u][0].replaceAll("/", "_") + ".pdf");
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
      } catch (Exception var16) {
         System.out.println(var16.getMessage());
         request.setAttribute("error", var16.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadDirectPurchase(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String branchId = "" + session.getAttribute("BRANCHID");
         String usertype = "" + session.getAttribute("USRTYPE");
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
         sql = sql + " a.DOU_TOTALAMOUNT, if(a.CHR_PAYMENTSTATUS='Y','Paid','Pending') ,a.CHR_FLAG,a.CHR_SALEFLAG,a.DOU_TOTALAMOUNT,a.CHR_POREQUESTNO,a.CHR_CANCEL, ";
         sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID),FIND_A_EMPLOYEE_ID_NAMEONLY_BY_USERID(a.CHR_USRNAME),a.CHR_GST_TYPE,if(a.CHR_GST_TYPE='S','GST','IST')  FROM inv_t_directpurchase  a, inv_m_vendorsinformation  b ";
         sql = sql + " where   a.INT_VENDORID=b.INT_VENDORID ";
         if (!"F".equals(usertype)) {
            sql = sql + " AND a.INT_BRANCHID =" + branchId;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND month(a.DAT_ORDERDATE) = " + month;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_ORDERDATE)=" + day;
         }

         sql = sql + " AND year(a.DAT_ORDERDATE)=   " + year;
         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(vendor)) {
            sql = sql + "  AND a.INT_VENDORID = " + vendor;
         }

         if (!"0".equals(cancel)) {
            sql = sql + " AND a.CHR_CANCEL = '" + cancel + "' ";
         }

         if (!"0".equals(taxtype)) {
            sql = sql + " AND a.CHR_GST_TYPE = '" + taxtype + "' ";
         }

         if (!"0".equals(txtSer)) {
            sql = sql + " AND b.CHR_VENDORNAME LIKE '" + txtSer + "%'";
         }

         sql = sql + "   order by a.INT_PURCHASEORDERID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               sb.append("<usertype>" + usertype + "</usertype>");
               sb.append("</directPurchase>");
            }

            System.out.println("\n\n" + sb.toString());
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<DirectPurchases>" + sb.toString() + "</DirectPurchases>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var18) {
         System.out.println(var18.getMessage());
         request.setAttribute("error", var18.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.CHR_PAYMENTSTATUS  ,a.CHR_ACCOUNTFLAG,d.CHR_BRANCHNAME,a.IMG_INVOICE,a.DOU_TOTALAMOUNT, ";
         sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID) FROM inv_t_directpurchase a ,  inv_m_vendorsinformation  b , com_m_branch d";
         sql = sql + " where  a.INT_VENDORID = b.INT_VENDORID AND a.INT_BRANCHID =d.INT_BRANCHID ";
         if (!"0".equals(Accbranch)) {
            sql = sql + " AND a.INT_BRANCHID = " + Accbranch;
         }

         if ("0".equals(Aflag)) {
            sql = sql + "  AND a.CHR_ACCOUNTFLAG ='Y'";
         } else if ("1".equals(Aflag)) {
            sql = sql + " AND a.CHR_ACCOUNTFLAG ='N'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals(vendor)) {
            sql = sql + " AND a.INT_VENDORID = " + vendor;
         }

         if (!"0".equals(month)) {
            sql = sql + "   AND MONTH(a.DAT_ORDERDATE) =" + mon;
         }

         sql = sql + " AND year(a.DAT_ORDERDATE)= " + year;
         if (!"0".equals(txtSer)) {
            sql = sql + " AND  b.CHR_VENDORNAME LIKE '" + txtSer + "%'";
         }

         sql = sql + " ORDER BY a.INT_PURCHASEORDERID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         String filepath = request.getRealPath("/");
         File f = null;
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<directPurchase>");
               sb.append("<Pono>" + readData[u][0] + "</Pono>");
               sb.append("<Vendor>" + readData[u][1].trim().replace("&", "98650") + "</Vendor>");
               sb.append("<Podate>" + readData[u][2] + "</Podate>");
               f = new File(filepath + "uploadfiles/DCIMAGE/" + readData[u][0].replaceAll("/", "_") + ".pdf");
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
      } catch (Exception var16) {
         System.out.println(var16.getMessage());
         request.setAttribute("error", var16.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadCustomerAddress(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String id = request.getParameter("id");
         String sql = "";
         sql = "  SELECT CONCAT(f.CHR_NAME,'~', a.CHR_ADDRESS1, '~',a.CHR_ADDRESS2, '~', a.CHR_ADDRESS3, '~', e.CHR_CITYNAME,'~',d.CHR_DISTRICT,'~',   ";
         sql = sql + " c.CHR_STATENAME,'~', CONCAT(a.INT_PINCODE),'~' )   ";
         sql = sql + " , a.INT_STATEID   FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,   ";
         sql = sql + " com_m_city e  ,inv_m_customergroup f      ";
         sql = sql + " WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   ";
         sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID       ";
         sql = sql + " AND a.INT_STATEID =c.INT_STATEID       ";
         sql = sql + "  AND a.INT_DISTRICTID= d.INT_DISTRICTID     ";
         sql = sql + " AND a.INT_CITYID =e.INT_CITYID        ";
         sql = sql + " AND a.INT_CUSTOMERID=" + id;
         sql = sql + " ORDER BY f.CHR_NAME   ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static synchronized void loadcheckSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String[] serial = request.getParameter("serial").split(",");
         String sql = "";
         boolean flag = false;
         String id = "";
         String serials = "";
         String item = "";
         String type = "";
         System.out.println();
         System.out.println();
         System.out.println("Serial number Checking");
         System.out.println("======================");

         for(int x = 0; x < serial.length; ++x) {
            String[] cserial = serial[x].split("~");
            serials = cserial[0];
            item = cserial[1];
            type = cserial[2];
            sql = "SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO='" + serials.trim() + "'";
            sql = sql + " AND CHR_TYPE='" + type.trim() + "'  AND CHR_ITEMID = '" + item.trim() + "' ";
            System.out.println(sql + " \nSwap Serial Number checking " + (x + 1) + "    " + serials.trim() + "/" + flag + "/" + !CommonFunction.RecordExist(sql));
            if (!CommonFunction.RecordExist(sql)) {
               flag = false;
               id = serials;
               break;
            }

            flag = true;
         }

         System.out.println("======================");
         System.out.println();
         System.out.println();
         StringBuffer sb = new StringBuffer();
         if (serial.length > 0) {
            sb.append("<Serial>");
            sb.append("<Id>" + id + "</Id>");
            sb.append("<Flag>" + ("" + flag).toUpperCase() + "</Flag>");
            sb.append("</Serial>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Serials>" + sb.toString() + "</Serials>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static synchronized void LoadSwapcheckSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String Serial = request.getParameter("Serial");
         String Item = request.getParameter("Item");
         String Type = request.getParameter("Type");
         String sql = "";
         sql = "SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO='" + Serial.trim() + "'";
         sql = sql + " AND CHR_TYPE='" + Type.trim() + "'  AND CHR_ITEMID = '" + Item.trim() + "' AND CHR_QUALITY='Y'";
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadcremovedItemSerial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String[] serial = request.getParameter("serial").split(",");
         String sql = "";
         boolean flag = false;
         String id = "";

         for(int x = 0; x < serial.length; ++x) {
            String serials = serial[x];
            sql = "SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO='" + serials + "'";
            System.out.println(sql);
            if (CommonFunction.RecordExist(sql)) {
               flag = false;
               id = serials;
               break;
            }

            flag = true;
         }

         StringBuffer sb = new StringBuffer();
         if (serial.length > 0) {
            sb.append("<Serial>");
            sb.append("<Id>" + id + "</Id>");
            sb.append("<Flag>" + ("" + flag).toUpperCase() + "</Flag>");
            sb.append("</Serial>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Serials>" + sb.toString() + "</Serials>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadSalesReturn(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String returnType = request.getParameter("returnType");
         String branchId = "" + session.getAttribute("BRANCHID");
         String month = request.getParameter("month");
         int year = Integer.parseInt(request.getParameter("year"));
         int mon = Integer.parseInt(month);
         String fDate = year + "-" + month + "-01";
         String tDate = year + "-" + month + "-" + DateUtil.totalDays(mon, year);
         String sql = "";
         if ("Invoice".equals(returnType)) {
            sql = " SELECT a.CHR_SALESORDERNO,a.DAT_SALEDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SALESORDERNO  ,c.CHR_GRTFLAG ";
            sql = sql + "  from  inv_t_customersalesorder   a  ,inv_m_customerinfo b , inv_t_customersalesorderitemserial c where ";
            sql = sql + " a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.DAT_SALEDATE>='" + fDate + "'";
            sql = sql + " AND a.CHR_SALESORDERNO = c.CHR_SALESORDERNO AND c.CHR_GRTFLAG ='Y' ";
            sql = sql + " AND a.DAT_SALEDATE<='" + tDate + "' AND a.INT_BRANCHID=" + branchId;
            sql = sql + " AND CHR_INVOICESTATUS='Y'  GROUP BY c.CHR_SALESORDERNO ";
         } else if ("Direct".equals(returnType)) {
            sql = " SELECT a.CHR_SALESNO,a.DAT_SALESDATE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SALESNO  ,c.CHR_GRTFLAG ";
            sql = sql + "  from inv_t_directsales a  ,inv_m_customerinfo b ,inv_t_swapsalesserialno c  where ";
            sql = sql + " a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.DAT_SALESDATE>='" + fDate + "'";
            sql = sql + " AND a.CHR_SALESNO = c.CHR_SALESNO AND c.CHR_GRTFLAG ='Y' ";
            sql = sql + " AND a.DAT_SALESDATE<='" + tDate + "' AND a.INT_BRANCHID=" + branchId;
            sql = sql + " AND INT_SALESSTATUS='1' GROUP BY c.CHR_SALESNO ";
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String StartLetter = request.getParameter("id");
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadBranchData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String cpyid = request.getParameter("companyid");
         String sql = "select * from com_m_branch where INT_COMPANYID=" + cpyid + " ORDER BY INT_BRANCHID";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         sb.append("<Branch>");
         sb.append("<Branchid>0</Branchid>");
         sb.append("<Branchname>Select</Branchname>");
         sb.append("</Branch>");
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String invbranchid = "" + session.getAttribute("INVBRANCH");
         String sql = " SELECT INT_ID,CHR_STOCKTRANSFERID,DATE_FORMAT(DAT_TRANSFERDATE,'%d-%b-%Y'),";
         sql = sql + " FUN_GET_BRANCH_NAME(INT_BRANCHID_FROM),INT_BRANCHID_FROM,FUN_GET_BRANCH_NAME(INT_BRANCHID_TO),";
         sql = sql + " INT_BRANCHID_TO,INT_STATUS ,INT_TRANSFERSTATUS,CHR_DELIVERY ";
         sql = sql + " from inv_t_stocktransfer  WHERE INT_ID >0 ";
         sql = sql + "  AND (INT_BRANCHID_TO=" + Integer.parseInt(branchid);
         sql = sql + " OR INT_BRANCHID_FROM=" + Integer.parseInt(branchid) + ")";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(DAT_TRANSFERDATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(DAT_TRANSFERDATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(DAT_TRANSFERDATE) = " + year;
         }

         if ("1".equals(type)) {
            if (!"0".equals(id)) {
               sql = sql + " AND CHR_STOCKTRANSFERID LIKE '" + id.toUpperCase() + "%'";
            }
         } else {
            sql = sql + " AND CHR_STOCKTRANSFERID LIKE '%" + id.toUpperCase() + "%'";
         }

         if (!"".equals(status)) {
            if (!"1".equals(status)) {
               sql = sql + " AND INT_STATUS = " + status;
            } else {
               sql = sql + " AND INT_STATUS = " + status;
            }
         }

         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<StockTrans>");
               sb.append("<Id>" + readData[u][0] + "</Id>");
               sb.append("<TransId>" + readData[u][1] + "</TransId>");
               sb.append("<TransDate>" + readData[u][2] + "</TransDate>");
               sb.append("<FromBranch>" + readData[u][3] + "</FromBranch>");
               sb.append("<FromBranchid>" + readData[u][4] + "</FromBranchid>");
               sb.append("<ToBranch>" + readData[u][5] + "</ToBranch>");
               sb.append("<ToBranchid>" + readData[u][6] + "</ToBranchid>");
               sb.append("<invbranchid>" + invbranchid + "</invbranchid>");
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " WHERE INT_CUSTOMERID >= 1 ";
         if (!"0".equals(group)) {
            sql = sql + " AND INT_GROUPID=" + group;
         }

         if (!"0".equals(branch)) {
            sql = sql + " AND INT_BRANCHID  =" + branch;
         }

         if (!"0".equals(servicecenter)) {
            sql = sql + " AND INT_SERVICECENTERID=" + servicecenter;
         }

         if (!"0".equals(startLetter)) {
            sql = sql + " AND CHR_CUSTOMERNAME like '" + startLetter + "%' ";
         } else {
            sql = sql + " AND CHR_CUSTOMERNAME like '%' ";
         }

         sql = sql + "ORDER BY  CHR_CUSTOMERNAME ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadServiceItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String startLetter = request.getParameter("startLetter");
         String sql = " ";
         sql = " SELECT INT_SERVICEITEMID ,CHR_SERVICEITEMNAME FROM  inv_m_serviceitems ";
         sql = sql + " WHERE INT_SERVICEITEMID >= 1 ";
         if (!"0".equals(startLetter)) {
            sql = sql + " AND CHR_SERVICEITEMNAME like '" + startLetter + "%' ";
         } else {
            sql = sql + " AND CHR_SERVICEITEMNAME like '%' ";
         }

         sql = sql + "ORDER BY  CHR_SERVICEITEMNAME ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadServiceGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String startLetter = request.getParameter("startLetter");
         String branch = request.getParameter("branch");
         String sql = " ";
         sql = " SELECT INT_GROUPID ,CHR_GROUPNAME FROM  inv_m_servicecustomergroup ";
         sql = sql + " WHERE INT_GROUPID >= 1 ";
         if (!"0".equals(branch)) {
            sql = sql + " AND  INT_BRANCHID =" + branch;
         }

         if (!"0".equals(startLetter)) {
            sql = sql + " AND CHR_GROUPNAME like '" + startLetter + "%' ";
         } else {
            sql = sql + " AND CHR_GROUPNAME like '%' ";
         }

         sql = sql + "ORDER BY  CHR_GROUPNAME ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadServiceCenter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String startLetter = request.getParameter("startLetter");
         String sql = " ";
         sql = " SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME,CHR_MOBILE,CHR_MAIL FROM  inv_m_servicecenter";
         sql = sql + " WHERE INT_SERVICECENTERID >= 1 ";
         if (!"0".equals(startLetter)) {
            sql = sql + " AND CHR_CENTERNAME like '" + startLetter + "%' ";
         } else {
            sql = sql + " AND CHR_CENTERNAME like '%' ";
         }

         sql = sql + "ORDER BY  CHR_CENTERNAME ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + "   WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID   AND a.INT_SERVICEITEMID = c.INT_SERVICEITEMID";
         if (!"0".equals(branch)) {
            sql = sql + " AND b.INT_BRANCHID  =" + branch;
         }

         if (!"0".equals(customerid)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customerid;
         }

         if (!"0".equals(servicecenter)) {
            sql = sql + " AND b.INT_SERVICECENTERID=" + servicecenter;
         }

         if (!"0".equals(peripheralid)) {
            sql = sql + " AND c.INT_SERVICEITEMID=" + peripheralid;
         }

         if (!"0".equals(startLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) like '" + startLetter + "%' ";
         } else {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) like '%' ";
         }

         sql = sql + " GROUP BY a.INT_CUSTOMERID,c.CHR_SERVICEITEMNAME  ORDER BY  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            sql = sql + " WHERE CHR_STATUS ='Y'AND " + fieldname + " like '" + startLetter + "%' ";
         } else {
            sql = sql + "  WHERE CHR_STATUS ='Y'AND  " + fieldname + " like '%' ";
         }

         sql = sql + "ORDER BY  " + fieldname;
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadAMCSerialNumberCustomerwise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String id = request.getParameter("id");
         String sql = " ";
         sql = " SELECT CHR_SERIALNO FROM inv_m_serviceamc ";
         sql = sql + "  WHERE CHR_STATUS ='Y' AND   INT_CUSTOMERID= " + id;
         sql = sql + " ORDER BY  CHR_SERIALNO";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadAMCcustomerinfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         String serialnumber = request.getParameter("serialnumber");
         String sql = " SELECT d.CHR_SERVICEITEMNAME,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_EMAIL,a.INT_CUSTOMERID,c.CHR_CATEGORY,c.CHR_DESC , ";
         sql = sql + "DATE_FORMAT(c.DT_STARTDATE,'%d-%b-%Y %H:%m:%s %p'),DATE_FORMAT(c.DT_ENDDATE,'%d-%b-%Y %H:%m:%s %p')   FROM inv_m_servicecustomerinfo  a ,inv_m_servicecustomergroup b,inv_m_serviceamc c,inv_m_serviceitems d  ";
         sql = sql + " WHERE a.INT_GROUPID = b.INT_GROUPID  ";
         sql = sql + " AND a.INT_CUSTOMERID=c.INT_CUSTOMERID  ";
         sql = sql + " AND c.INT_SERVICEITEMID = d.INT_SERVICEITEMID  ";
         sql = sql + " AND c.CHR_SERIALNO='" + serialnumber + "' ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND a.CHR_USRNAME =c.CHR_USERID";
         if (!"0".equals(branch)) {
            sql = sql + "  AND a.INT_BRANCHID   =" + branch;
         }

         if (!"0".equals(customerid)) {
            sql = sql + "  AND a.INT_CUSTOMERID =" + customerid;
         }

         if (!"0".equals(bookingtype)) {
            sql = sql + "  AND a.CHR_BOOKINGTYPE= '" + bookingtype + "'";
         }

         if (!"0".equals(bookingunder)) {
            sql = sql + "  AND a.CHR_BOOKINGUNDER='" + bookingunder + "'";
         }

         if (!"0".equals(callstatus)) {
            sql = sql + "  AND a.CHR_STATUS ='" + callstatus + "'";
         }

         if (!"0".equals(month)) {
            sql = sql + "  AND MONTH(DT_BOOKINGDATE)= " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + "  AND YEAR(DT_BOOKINGDATE) =" + year;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + "  AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String usertype = "" + session.getAttribute("USRTYPE");
         String sql = " SELECT a.CHR_SERVICECALLNO, FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H:%i:%s %p'), DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H:%i:%s %p'),a.CHR_BOOKINGTYPE,a.CHR_BOOKINGUNDER,a.CHR_STATUS, a.CHR_ENGGSTATUS,a.CHR_BOOKINGEMPID,a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,a.CHR_SERVICEDESC,c.CHR_CENTERNAME FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,inv_m_servicecenter c ";
         sql = sql + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID = c.INT_SERVICECENTERID";
         if (!"0".equals(branch)) {
            sql = sql + "  AND a.INT_BRANCHID = " + branch + " ";
         }

         if (!"0".equals(callstatus)) {
            sql = sql + "  AND a.CHR_STATUS ='" + callstatus + "'";
         }

         if (!"0".equals(month)) {
            sql = sql + "  AND MONTH(DT_BOOKINGDATE)= " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + "  AND YEAR(DT_BOOKINGDATE) =" + year;
         }

         if (!"0".equals(servicecenter)) {
            sql = sql + "  AND b.INT_SERVICECENTERID =" + servicecenter;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + "  AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadAMCPersonalinfo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String id = request.getParameter("id");
         String sql = " SELECT CHR_CUSTOMERNAME,CHR_STREET,CHR_CITY,CHR_STATE,CHR_PHONE,CHR_MOBILE,CHR_EMAIL FROM  inv_m_servicecustomerinfo  WHERE INT_CUSTOMERID=" + id;
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESORDERNO ";
         sql = sql + "  AND  a.INT_CUSTOMERID= " + id;
         String[][] pendingamount = CommonFunctions.QueryExecute(sql);
         if (pendingamount.length > 0) {
            if (!"-".equals(pendingamount[0][2])) {
               pamount = Double.parseDouble(pendingamount[0][2]);
            } else {
               pamount = 0.0D;
            }
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
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadCustomerServiceCallCreditLimit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String callid = request.getParameter("callid");
         String startdate = request.getParameter("startdate");
         String[] sdate = startdate.split(" ");
         startdate = DateUtil.FormateDateSQL(sdate[0]) + " " + sdate[1];
         String enddate = request.getParameter("enddate");
         String[] edate = enddate.split(" ");
         enddate = DateUtil.FormateDateSQL(edate[0]) + " " + edate[1];
         String bookingdate = request.getParameter("bookingdate");
         String[] bdate = bookingdate.split(" ");
         bookingdate = DateUtil.FormateDateSQL(bdate[0]) + " " + bdate[1];
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
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadCustomerServiceCallSerialnumberCheck(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String serialno = request.getParameter("serialno");
         String startdate = request.getParameter("startdate");
         String[] sdate = startdate.split(" ");
         startdate = DateUtil.FormateDateSQL(sdate[0]) + " " + sdate[1];
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadRuntimeCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String id = request.getParameter("id");
         String branch = request.getParameter("branch");
         String sql = "";
         sql = " SELECT  INT_CUSTOMERID ,CHR_CUSTOMERNAME FROM inv_m_servicecustomerinfo     WHERE INT_CUSTOMERID >= 1 ";
         if (!"0".equals(id)) {
            sql = sql + " AND INT_SERVICECENTERID=" + id;
         }

         if (!"0".equals(branch)) {
            sql = sql + " AND INT_BRANCHID  =" + branch;
         }

         sql = sql + " ORDER BY CHR_CUSTOMERNAME ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadRuntimeNonCustomerGroup(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String id = request.getParameter("id");
         String branch = request.getParameter("branch");
         String sql = "";
         sql = " SELECT a.INT_GROUPID,b.CHR_GROUPNAME FROM  inv_m_servicecustomerinfo a ,inv_m_servicecustomergroup b WHERE a.INT_GROUPID = b.INT_GROUPID ";
         if (!"0".equals(id)) {
            sql = sql + " AND a.INT_SERVICECENTERID=" + id;
         }

         if (!"0".equals(branch)) {
            sql = sql + " AND b.INT_BRANCHID=" + branch;
         }

         sql = sql + " GROUP BY a.INT_GROUPID  ORDER BY b.CHR_GROUPNAME";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadAccessories(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String startLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM inv_m_accessoriesgroup WHERE INT_GROUPID>=1 ";
         if (!"0".equals(startLetter)) {
            sql = sql + " AND CHR_GROUPNAME LIKE '" + startLetter + "%' ";
         }

         sql = sql + " ORDER BY CHR_GROUPNAME ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         if (!"0".equals(group)) {
            sql = sql + "  AND a.INT_GROUPID=" + group + " ";
         }

         sql = sql + ssql;
         sql = sql + " ORDER BY a.CHR_PRODUCTNAME ";
         String[][] Data = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (Data.length > 0) {
            for(int u = 0; u < Data.length; ++u) {
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
         request.setAttribute("error", var9.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadBudgetAssign(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String year = request.getParameter("year");
         String dept = request.getParameter("dept");
         String access = request.getParameter("access");
         String startletter = request.getParameter("startletter");
         String ssql = "";
         if (!"0".equals(startletter)) {
            ssql = " AND b.CHR_DEPARTNAME like '" + startletter + "%'";
         }

         String sql = "";
         sql = "SELECT b.CHR_DEPARTNAME,c.CHR_GROUPNAME,  a.DOU_AMOUNT,a.INT_TARGETID FROM inv_t_budgetassign a  ,com_m_depart b ,inv_m_accessoriesgroup c WHERE a.INT_DEPARTID = b.INT_DEPARTID \tAND a.INT_GROUPID = c.INT_GROUPID ";
         if (!"0".equals(dept)) {
            sql = sql + "  AND a.INT_DEPARTID=" + dept + " ";
         }

         if (!"0".equals(access)) {
            sql = sql + "  AND a.INT_GROUPID=" + access + " ";
         }

         sql = sql + ssql;
         sql = sql + " AND a.INT_YEAR = " + year + "  ORDER BY b.CHR_DEPARTNAME ";
         String[][] Data = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (Data.length > 0) {
            for(int u = 0; u < Data.length; ++u) {
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
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadBudgetCheck(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String dept = request.getParameter("dept");
         String access = request.getParameter("access");
         String year = request.getParameter("year");
         String sql = "";
         sql = "SELECT COUNT(*) FROM inv_t_budgetassign WHERE INT_DEPARTID=" + dept + " AND INT_YEAR=" + year + " AND INT_GROUPID=" + access;
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            response.getWriter().write("<Products>" + sb.toString() + "</Products>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
         request.setAttribute("error", var6.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String usertype = "" + session.getAttribute("USRTYPE");
         sql = " SELECT a.INT_PURCHASEINDENTID,a.CHR_PURCHASENO,DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'),DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME, ";
         sql = sql + " a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO,a.DOU_TOTALAMOUNT,a.CHR_STATUS,a.CHR_ACCEPT,a.CHR_ACCSTATUS,a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME,a.CHR_ACCDESC ";
         sql = sql + " FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c";
         sql = sql + " WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID";
         sql = sql + " AND month(a.DAT_INDENTDATE)= " + month;
         sql = sql + " AND year(a.DAT_INDENTDATE)= " + year;
         sql = sql + " AND  a.INT_DEPARTID=" + dept;
         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_ACCEPT='" + status + "'";
         }

         sql = sql + " ORDER BY a.INT_PURCHASEINDENTID ";
         String[][] datas = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (datas.length > 0) {
            for(int u = 0; u < datas.length; ++u) {
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
               sb.append("<usertype>" + usertype + "</usertype>");
               sb.append("</Product>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Products>" + sb.toString() + "</Products>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String usertype = "" + session.getAttribute("USRTYPE");
         sql = " SELECT a.INT_PURCHASEINDENTID,a.CHR_PURCHASENO,DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'), ";
         sql = sql + " DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME, ";
         sql = sql + " a.DOU_TOTALAMOUNT,a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME,a.CHR_ACCSTATUS , ";
         sql = sql + " a.DAT_ACCDATE,a.CHR_PURCHASEORDERNO,a.DAT_PODATE,a.CHR_PAYMENTSTATUS ";
         sql = sql + " FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c  ";
         sql = sql + " WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID  ";
         sql = sql + " AND CHR_ACCEPT='Y' ";
         sql = sql + " AND month(a.DAT_INDENTDATE)= " + month;
         sql = sql + " AND year(a.DAT_INDENTDATE)= " + year;
         sql = sql + " AND  a.INT_DEPARTID=" + dept;
         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_ACCSTATUS='" + status + "'";
         }

         if (!"0".equals(payment)) {
            sql = sql + " AND a.CHR_PAYMENTSTATUS='" + payment + "'";
         }

         sql = sql + " ORDER BY a.INT_PURCHASEINDENTID ";
         String[][] datas = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (datas.length > 0) {
            for(int u = 0; u < datas.length; ++u) {
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
               sb.append("<usertype>" + usertype + "</usertype>");
               sb.append("</Product>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Products>" + sb.toString() + "</Products>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var13) {
         System.out.println(var13.getMessage());
         request.setAttribute("error", var13.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadIndentPayment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String Status = request.getParameter("Status");
         String vendorid = request.getParameter("vendorid");
         String sql = "";
         String ssql = "";
         if (!"0".equals(vendorid)) {
            ssql = " AND  a.INT_VENDORID=" + vendorid + "  ";
         }

         String sssql = "";
         if ("1".equals(Status)) {
            sssql = " AND  a.CHR_PAYMENTSTATUS='N'   ";
         } else if ("2".equals(Status)) {
            sssql = " AND  a.CHR_PAYMENTSTATUS='Y'   ";
         } else if ("0".equals(Status)) {
            sssql = " ";
         }

         sql = " SELECT a.CHR_PURCHASENO  ,b.CHR_VENDORNAME ,a.DOU_TOTALAMOUNT ,  a.DOU_PAIDAMOUNT, ";
         sql = sql + "  (a.DOU_TOTALAMOUNT-a.DOU_PAIDAMOUNT),a.CHR_PAYMENTSTATUS FROM inv_t_purchaseindent  a, inv_m_vendorsinformation  b ";
         sql = sql + " WHERE a.INT_VENDORID=b.INT_VENDORID " + ssql + sssql;
         sql = sql + " ORDER BY a.DAT_INDENTDATE ";
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         String StartLetter = request.getParameter("id");
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var11) {
         System.out.println(var11.getMessage());
         request.setAttribute("error", var11.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            if (!"0".equals(Branch)) {
               sql = sql + " AND a.INT_BRANCHID = " + Branch;
            }

            if (!"0".equals(customer)) {
               sql = sql + " AND a.INT_CUSTOMERID = " + customer;
            }

            if (!"0".equals(salestype)) {
               sql = sql + " AND b.CHR_INVOICETYPE = '" + salestype + "'";
            }

            if (!"0".equals(division)) {
               sql = sql + " AND a.INT_DIVIID = " + division;
            }

            if (!"0".equals(month)) {
               sql = sql + " AND month(a.DAT_SALESDATE) = " + Integer.parseInt(month);
            }

            sql = sql + " AND year(a.DAT_SALESDATE) = " + year;
            if (!"0".equals(day)) {
               sql = sql + " AND DAY(a.DAT_SALESDATE) = " + day;
            }

            if (!"0".equals(txtSer)) {
               sql = sql + " AND  FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) LIKE '" + txtSer + "%'";
            }

            sql = sql + " GROUP  BY  b.CHR_SALESNO ORDER BY  a.INT_SALESID ";
         } else if ("S".equals(salestype)) {
            sql = " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID), (SELECT count(d.CHR_INVOICETYPE) FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_NETAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_servicebilling a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID  AND a.CHR_CANCEL='N' ";
            if (!"0".equals(Branch)) {
               sql = sql + " AND a.INT_BRANCHID = " + Branch;
            }

            if (!"0".equals(customer)) {
               sql = sql + " AND a.INT_CUSTOMERID = " + customer;
            }

            if (!"0".equals(salestype)) {
               sql = sql + " AND b.CHR_INVOICETYPE = '" + salestype + "'";
            }

            if (!"0".equals(division)) {
               sql = sql + " AND a.INT_DIVIID = " + division;
            }

            if (!"0".equals(month)) {
               sql = sql + " AND month(a.DAT_SALESDATE) = " + Integer.parseInt(month);
            }

            sql = sql + " AND year(a.DAT_SALESDATE) = " + year;
            if (!"0".equals(day)) {
               sql = sql + " AND DAY(a.DAT_SALESDATE) = " + day;
            }

            if (!"0".equals(txtSer)) {
               sql = sql + " AND  FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) LIKE '" + txtSer + "%'";
            }

            sql = sql + "  GROUP  BY  b.CHR_SALESNO  ORDER BY b.CHR_SALESNO";
         } else if ("D".equals(salestype)) {
            sql = " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID), (SELECT count(d.CHR_INVOICETYPE) FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_NETAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_directbilling a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID ";
            if (!"0".equals(Branch)) {
               sql = sql + " AND a.INT_BRANCHID = " + Branch;
            }

            if (!"0".equals(customer)) {
               sql = sql + " AND a.INT_CUSTOMERID = " + customer;
            }

            if (!"0".equals(salestype)) {
               sql = sql + " AND b.CHR_INVOICETYPE = '" + salestype + "'";
            }

            if (!"0".equals(division)) {
               sql = sql + " AND a.INT_DIVIID = " + division;
            }

            if (!"0".equals(month)) {
               sql = sql + " AND month(a.DAT_SALESDATE) = " + Integer.parseInt(month);
            }

            sql = sql + " AND year(a.DAT_SALESDATE) = " + year;
            if (!"0".equals(day)) {
               sql = sql + " AND DAY(a.DAT_SALESDATE) = " + day;
            }

            if (!"0".equals(txtSer)) {
               sql = sql + " AND  FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID) LIKE '" + txtSer + "%'";
            }

            sql = sql + "  GROUP  BY  b.CHR_SALESNO  ORDER BY  SUBSTRING_INDEX(b.CHR_SALESNO, '/',1)  ,a.DAT_SALESDATE  ";
         }

         System.out.println(sql);
         String[][] readData = CommonFunction.RecordSetArray(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            sql = sql + " ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME    ";
            sql = sql + "  from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d, com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'   ";
            sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID  ";
            sql = sql + " AND a.INT_DIVIID=d.INT_DIVIID  AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID  ";
            sql = sql + " AND DATEDIFF(NOW(),a.DAT_SALESDATE) >= 20 ";
            sql = sql + " AND b.INT_CUSTOMERID=  " + customerId;
            sql = sql + " ORDER BY  a.DAT_SALESDATE";
         } else if ("D".equals(type)) {
            sql = "";
            sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS   ";
            sql = sql + "  ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME  from inv_t_directbilling a , inv_m_customerinfo b ,   ";
            sql = sql + "  com_m_staff c ,inv_m_division d ,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'    ";
            sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID   ";
            sql = sql + "  AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID    ";
            sql = sql + " AND DATEDIFF(NOW(),a.DAT_SALESDATE) >= 20 ";
            sql = sql + " AND b.INT_CUSTOMERID=  " + customerId;
            sql = sql + " ORDER BY  a.DAT_SALESDATE";
         } else if ("S".equals(type)) {
            sql = "";
            sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS   ";
            sql = sql + "  ,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME  from inv_t_servicebilling a , inv_m_customerinfo b ,    ";
            sql = sql + "  com_m_staff c ,inv_m_division d,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'    ";
            sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID   ";
            sql = sql + "  AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID   ";
            sql = sql + " AND DATEDIFF(NOW(),a.DAT_SALESDATE) >= 20 ";
            sql = sql + " AND b.INT_CUSTOMERID=  " + customerId;
            sql = sql + " ORDER BY  a.DAT_SALESDATE";
         }

         System.out.println(sql);
         StringBuffer sb = new StringBuffer();
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
         request.setAttribute("error", var10.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
         request.setAttribute("error", var6.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         if (!"0".equals(division)) {
            dsql = " AND a.INT_DIVIID=" + division + "   ";
         }

         sql = "SELECT INT_DIVIID,CHR_DIVICODE FROM inv_m_division  WHERE INT_DIVIID>=1";
         if (!"0".equals(division)) {
            sql = sql + " AND  INT_DIVIID=" + division + "   ";
         }

         if (!"0".equals(divisionid)) {
            sql = sql + " AND CHR_DIVICODE LIKE '" + divisionid + "%'";
         }

         sql = sql + " ORDER BY CHR_DIVICODE ";
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
            int u;
            String[][] jandata;
            String[][] mardata;
            if ("1".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  totalnumber = 0;
                  totalamount = 0.0D;
                  sb.append("<Row>");
                  sb.append("<Divid>" + data[u][0] + "</Divid>");
                  sb.append("<Divname>" + data[u][1] + "</Divname>");
                  dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM " + tablename + " ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-04-01' AND DAT_SALESDATE <='" + year + "-04-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("April : " + sql);
                  jandata = CommonFunctions.QueryExecute(sql);
                  if (jandata.length > 0) {
                     sb.append("<Month1>" + jandata[0][3] + "</Month1>");
                     sb.append("<AmtMonth1>" + jandata[0][4] + "</AmtMonth1>");
                     totalnumber += Integer.parseInt(jandata[0][3]);
                     totalamount += Double.parseDouble(jandata[0][4]);
                  } else {
                     sb.append("<Month1>0</Month1>");
                     sb.append("<AmtMonth1>0</AmtMonth1>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-05-01' AND DAT_SALESDATE <='" + year + "-05-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("May : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month2>" + mardata[0][3] + "</Month2>");
                     sb.append("<AmtMonth2>" + mardata[0][4] + "</AmtMonth2>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month2>0</Month2>");
                     sb.append("<AmtMonth2>0</AmtMonth2>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-06-01' AND DAT_SALESDATE <='" + year + "-06-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("June : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month3>" + mardata[0][3] + "</Month3>");
                     sb.append("<AmtMonth3>" + mardata[0][4] + "</AmtMonth3>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month3>0</Month3>");
                     sb.append("<AmtMonth3>0</AmtMonth3>");
                  }

                  sb.append("<Totalnumber>" + totalnumber + "</Totalnumber>");
                  sb.append("<TotalAmount>" + totalamount + "</TotalAmount>");
                  sb.append("</Row>");
               }
            }

            if ("2".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  totalnumber = 0;
                  totalamount = 0.0D;
                  sb.append("<Row>");
                  sb.append("<Divid>" + data[u][0] + "</Divid>");
                  sb.append("<Divname>" + data[u][1] + "</Divname>");
                  dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-07-01' AND DAT_SALESDATE <='" + year + "-07-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("July : " + sql);
                  jandata = CommonFunctions.QueryExecute(sql);
                  if (jandata.length > 0) {
                     sb.append("<Month1>" + jandata[0][3] + "</Month1>");
                     sb.append("<AmtMonth1>" + jandata[0][4] + "</AmtMonth1>");
                     totalnumber += Integer.parseInt(jandata[0][3]);
                     totalamount += Double.parseDouble(jandata[0][4]);
                  } else {
                     sb.append("<Month1>0</Month1>");
                     sb.append("<AmtMonth1>0</AmtMonth1>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-08-01' AND DAT_SALESDATE <='" + year + "-08-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("August : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month2>" + mardata[0][3] + "</Month2>");
                     sb.append("<AmtMonth2>" + mardata[0][4] + "</AmtMonth2>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month2>0</Month2>");
                     sb.append("<AmtMonth2>0</AmtMonth2>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-09-01' AND DAT_SALESDATE <='" + year + "-09-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("September : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month3>" + mardata[0][3] + "</Month3>");
                     sb.append("<AmtMonth3>" + mardata[0][4] + "</AmtMonth3>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month3>0</Month3>");
                     sb.append("<AmtMonth3>0</AmtMonth3>");
                  }

                  sb.append("<Totalnumber>" + totalnumber + "</Totalnumber>");
                  sb.append("<TotalAmount>" + totalamount + "</TotalAmount>");
                  sb.append("</Row>");
               }
            }

            if ("3".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  totalnumber = 0;
                  totalamount = 0.0D;
                  sb.append("<Row>");
                  sb.append("<Divid>" + data[u][0] + "</Divid>");
                  sb.append("<Divname>" + data[u][1] + "</Divname>");
                  dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-10-01' AND DAT_SALESDATE <='" + year + "-10-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("October : " + sql);
                  jandata = CommonFunctions.QueryExecute(sql);
                  if (jandata.length > 0) {
                     sb.append("<Month1>" + jandata[0][3] + "</Month1>");
                     sb.append("<AmtMonth1>" + jandata[0][4] + "</AmtMonth1>");
                     totalnumber += Integer.parseInt(jandata[0][3]);
                     totalamount += Double.parseDouble(jandata[0][4]);
                  } else {
                     sb.append("<Month1>0</Month1>");
                     sb.append("<AmtMonth1>0</AmtMonth1>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-11-01' AND DAT_SALESDATE <='" + year + "-11-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("November : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month2>" + mardata[0][3] + "</Month2>");
                     sb.append("<AmtMonth2>" + mardata[0][4] + "</AmtMonth2>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month2>0</Month2>");
                     sb.append("<AmtMonth2>0</AmtMonth2>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1   ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + year + "-12-01' AND DAT_SALESDATE <='" + year + "-12-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("December : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month3>" + mardata[0][3] + "</Month3>");
                     sb.append("<AmtMonth3>" + mardata[0][4] + "</AmtMonth3>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month3>0</Month3>");
                     sb.append("<AmtMonth3>0</AmtMonth3>");
                  }

                  sb.append("<Totalnumber>" + totalnumber + "</Totalnumber>");
                  sb.append("<TotalAmount>" + totalamount + "</TotalAmount>");
                  sb.append("</Row>");
               }
            }

            if ("4".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  totalnumber = 0;
                  totalamount = 0.0D;
                  sb.append("<Row>");
                  sb.append("<Divid>" + data[u][0] + "</Divid>");
                  sb.append("<Divname>" + data[u][1] + "</Divname>");
                  dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";
                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + (year + 1) + "-01-01' AND DAT_SALESDATE <='" + (year + 1) + "-01-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("January : " + sql);
                  jandata = CommonFunctions.QueryExecute(sql);
                  if (jandata.length > 0) {
                     sb.append("<Month1>" + jandata[0][3] + "</Month1>");
                     sb.append("<AmtMonth1>" + jandata[0][4] + "</AmtMonth1>");
                     totalnumber += Integer.parseInt(jandata[0][3]);
                     totalamount += Double.parseDouble(jandata[0][4]);
                  } else {
                     sb.append("<Month1>0</Month1>");
                     sb.append("<AmtMonth1>0</AmtMonth1>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID  AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1  ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + (year + 1) + "-02-01' AND DAT_SALESDATE <='" + (year + 1) + "-02-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("February : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month2>" + mardata[0][3] + "</Month2>");
                     sb.append("<AmtMonth2>" + mardata[0][4] + "</AmtMonth2>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month2>0</Month2>");
                     sb.append("<AmtMonth2>0</AmtMonth2>");
                  }

                  sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                  sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                  sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                  sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                  sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                  if (!"0".equals(Branch)) {
                     sql = sql + " AND a.INT_BRANCHID=" + Branch;
                  }

                  sql = sql + dsql;
                  sql = sql + " AND  DAT_SALESDATE >='" + (year + 1) + "-03-01' AND DAT_SALESDATE <='" + (year + 1) + "-03-31' ";
                  sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                  System.out.println("March : " + sql);
                  mardata = CommonFunctions.QueryExecute(sql);
                  if (mardata.length > 0) {
                     sb.append("<Month3>" + mardata[0][3] + "</Month3>");
                     sb.append("<AmtMonth3>" + mardata[0][4] + "</AmtMonth3>");
                     totalnumber += Integer.parseInt(mardata[0][3]);
                     totalamount += Double.parseDouble(mardata[0][4]);
                  } else {
                     sb.append("<Month3>0</Month3>");
                     sb.append("<AmtMonth3>0</AmtMonth3>");
                  }

                  sb.append("<Totalnumber>" + totalnumber + "</Totalnumber>");
                  sb.append("<TotalAmount>" + totalamount + "</TotalAmount>");
                  sb.append("</Row>");
               }
            }

            if ("5".equals(period)) {
               for(u = 0; u < data.length; ++u) {
                  totalnumber = 0;
                  totalamount = 0.0D;
                  sb.append("<Row>");
                  sb.append("<Divid>" + data[u][0] + "</Divid>");
                  sb.append("<Divname>" + data[u][1] + "</Divname>");
                  dsql = " AND a.INT_DIVIID=" + data[u][0] + "   ";

                  for(int x = 1; x < 13; ++x) {
                     if (x <= 3) {
                        sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                        sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                        sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                        sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                        sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                        if (!"0".equals(Branch)) {
                           sql = sql + " AND a.INT_BRANCHID=" + Branch;
                        }

                        sql = sql + dsql;
                        sql = sql + " AND  DAT_SALESDATE >='" + (year + 1) + "-" + x + "-01' AND DAT_SALESDATE <='" + (year + 1) + "-" + x + "-31' ";
                        sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                     } else {
                        sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( " + columnname + " ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
                        sql = sql + " FROM  " + tablename + "  ,inv_m_division b,com_m_branch c,com_m_company d  ";
                        sql = sql + " where a.INT_DIVIID=b.INT_DIVIID  ";
                        sql = sql + " AND a.INT_BRANCHID=c.INT_BRANCHID   ";
                        sql = sql + " AND c.INT_COMPANYID=d.INT_COMPANYID   AND  a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
                        if (!"0".equals(Branch)) {
                           sql = sql + " AND a.INT_BRANCHID=" + Branch;
                        }

                        sql = sql + dsql;
                        sql = sql + " AND  DAT_SALESDATE >='" + year + "-" + x + "-01' AND DAT_SALESDATE <='" + year + "-" + x + "-31' ";
                        sql = sql + " GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
                     }

                     mardata = CommonFunctions.QueryExecute(sql);
                     if (mardata.length > 0) {
                        sb.append("<Month" + x + ">" + mardata[0][3] + "</Month" + x + ">");
                        sb.append("<AmtMonth" + x + ">" + mardata[0][4] + "</AmtMonth" + x + ">");
                        totalnumber += Integer.parseInt(mardata[0][3]);
                        totalamount += Double.parseDouble(mardata[0][4]);
                     } else {
                        sb.append("<Month" + x + ">0</Month" + x + ">");
                        sb.append("<AmtMonth" + x + ">0</AmtMonth" + x + ">");
                     }
                  }

                  sb.append("<Totalnumber>" + totalnumber + "</Totalnumber>");
                  sb.append("<TotalAmount>" + totalamount + "</TotalAmount>");
                  sb.append("</Row>");
               }
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var22) {
         System.out.println(var22.getMessage());
         request.setAttribute("error", var22.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
         sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
         sql = sql + " f.CHR_PAYMENTNAME, ";
         sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ,a.CHR_PR_PARTIALLY_RECEIVED,";
         sql = sql + " if(a.CHR_PR_PARTIALLY_RECEIVED ='N','Pending',(if(CHR_PR_PARTIALLY_RECEIVED='Y','Closed','Partially Inward'))) ,";
         sql = sql + " if(a.CHR_CLOSEDSTATUS ='Y', ";
         sql = sql + "     if( (DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock + "),'N','Y'  ) ";
         sql = sql + "     ,'' ";
         sql = sql + "   )        ";
         sql = sql + " , a.CHR_BYBACK, a.CHR_SALESNO, ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS,a.INT_PROGRESSBAR ";
         sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d, inv_m_customergroup h,  ";
         sql = sql + " inv_m_paymentterms f,com_m_staff g ";
         sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
         sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
         sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID = h.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
         sql = sql + " AND a.CHR_REF=g.CHR_EMPID ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_REQUESTDATE)=" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_REQUESTDATE)=" + year;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_REQUESTDATE)=" + day;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_APPROVEDSTATUS='" + status + "'";
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND h.CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY a.INT_POREQUESTID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var17) {
         System.out.println(var17.getMessage());
         request.setAttribute("error", var17.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadPurchaseRequestdependsonVendor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String vendorid = request.getParameter("vendorid");
         String datelock = CommonFunctions.QueryExecute("SELECT INT_PURCHASEREQUEST_LOCK FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0];
         String sql = " ";
         sql = " SELECT  a.CHR_POREQUESTNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
         sql = sql + " FROM inv_t_purchaserequest a ,inv_t_purchaserequestitem b  ";
         sql = sql + " WHERE a.CHR_POREQUESTNO =b.CHR_POREQUESTNO AND a.CHR_CLOSEDSTATUS='Y' ";
         if (!"0".equals(vendorid)) {
            sql = sql + " AND b.INT_VENDORID=" + vendorid;
         }

         sql = sql + " AND a.CHR_PR_PARTIALLY_RECEIVED !='Y'  ";
         sql = sql + "   AND  DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock;
         sql = sql + "  GROUP BY a.CHR_POREQUESTNO  ";
         sql = sql + " ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadBybackSalesnumber(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "SELECT CHR_SALESNO FROM  inv_t_directsales  WHERE CHR_CANCEL ='N' AND CHR_BYBACK='Y' AND CHR_BYBACKINWARD ='N' ORDER BY DAT_SALESDATE ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
         request.setAttribute("error", var6.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
         sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
         sql = sql + " FIND_A_VENDOR_NAME(b.INT_VENDORID), ";
         sql = sql + " if(b.CHR_TYPE='I','Item','Product'), ";
         sql = sql + " if(b.CHR_TYPE='I', ";
         sql = sql + "  (SELECT  e.CHR_ITEMNAME FROM inv_m_item e WHERE e.CHR_ITEMID= b.CHR_ITEMID), ";
         sql = sql + "  (SELECT f.CHR_PRODUCTCODE FROM inv_m_produtlist f WHERE f.CHR_PRODUCTID= b.CHR_ITEMID) ";
         sql = sql + " ) , ";
         sql = sql + " if(b.CHR_TYPE='I', ";
         sql = sql + "  (SELECT  e1.CHR_DES FROM inv_m_item e1 WHERE e1.CHR_ITEMID= b.CHR_ITEMID), ";
         sql = sql + "  (SELECT f1.CHR_PRODUCTDESC FROM inv_m_produtlist f1 WHERE f1.CHR_PRODUCTID= b.CHR_ITEMID) ";
         sql = sql + " ) ,b.INT_QUANTITY, ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ";
         sql = sql + " FROM  inv_t_purchaserequest a, inv_t_purchaserequestitem  b, com_m_branch c, inv_m_division d ";
         sql = sql + " WHERE a.CHR_POREQUESTNO =b.CHR_POREQUESTNO ";
         sql = sql + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
         sql = sql + " AND a.INT_DIVIID =d.INT_DIVIID ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND a.INT_BRANCHID=" + Branch;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_REQUESTDATE)=" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_REQUESTDATE)=" + year;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_REQUESTDATE)=" + day;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(vendor)) {
            sql = sql + " AND b.INT_VENDORID=" + vendor;
         }

         if (!"0".equals(itype)) {
            if ("1".equals(itype)) {
               sql = sql + " AND b.CHR_TYPE = 'I'";
            } else {
               sql = sql + " AND b.CHR_TYPE = 'P'";
            }
         }

         if (!"0".equals(item)) {
            sql = sql + " AND b.CHR_ITEMID = '" + item + "'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '" + StartLetter + "%'";
         }

         sql = sql + " GROUP BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
         sql = sql + " FIND_A_VENDOR_NAME(b.INT_VENDORID), ";
         sql = sql + " a.CHR_POREQUESTNO,a.INT_BRANCHID,a.INT_DIVIID,b.CHR_TYPE ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var16) {
         System.out.println(var16.getMessage());
         request.setAttribute("error", var16.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadPurchaseRequestDate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String purchaserequest = request.getParameter("purchaserequest");
         String sql = "";
         sql = " SELECT  DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y')  ";
         sql = sql + " FROM inv_t_purchaserequest a ";
         sql = sql + " WHERE a.CHR_POREQUESTNO = '" + purchaserequest + "' ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               sb.append("<Row>");
               sb.append("<Date>" + readData[u][0].trim() + "</Date>");
               sb.append("</Row>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadPurchaseRequestDetails(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String purchaserequest = request.getParameter("purchaserequest");
         String sql = "";
         sql = " SELECT  DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y')  ";
         sql = sql + " FROM inv_t_purchaserequest a ";
         sql = sql + " WHERE a.CHR_POREQUESTNO = '" + purchaserequest + "' ";
         System.out.println(sql);
         String[][] Data = CommonFunctions.QueryExecute(sql);
         sql = " SELECT a.CHR_TYPE, ";
         sql = sql + " if(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
         sql = sql + " if(a.CHR_TYPE='I',(SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
         sql = sql + " (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID) ";
         sql = sql + " ), ";
         sql = sql + " if(a.CHR_TYPE='I',(SELECT d.INT_TAXID FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
         sql = sql + " (SELECT e.INT_TAXID  FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID) ";
         sql = sql + " ), ";
         sql = sql + " a.CHR_ITEMID,UPPER(a.CHR_DESC),a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_PURCHASEPRICE,  ";
         sql = sql + " a.DOU_UNITSALEPRICE,a.DOU_SALESPRICE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, ";
         sql = sql + " a.CHR_ACCEPT,a.INT_ROWID ,a.CHR_PURCHASEWARRANTY,a.CHR_SALESWARRANTY  FROM inv_t_purchaserequestitem a  ";
         sql = sql + " WHERE a.CHR_ACCEPT='Y' AND a.CHR_POREQUESTNO='" + purchaserequest + "'  ORDER BY a.CHR_TYPE ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + "  a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO, ";
         sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  ";
         sql = sql + "  h.CHR_NAME,  ";
         sql = sql + " a.CHR_REF,g.CHR_STAFFNAME, ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,       ";
         sql = sql + "  a.CHR_MODE, a.CHR_CPOREF_NUMBER ,";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ";
         sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c, ";
         sql = sql + "  inv_m_customerinfo d,inv_m_customergroup h,   ";
         sql = sql + "  com_m_staff g ,inv_t_purchaserequestitem i   ";
         sql = sql + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
         sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID   ";
         sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
         sql = sql + " AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.CHR_REF=g.CHR_EMPID   ";
         sql = sql + " AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND   a.INT_BRANCHID =" + Branch;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_REQUESTDATE)=" + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_REQUESTDATE)=" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_REQUESTDATE)=" + year;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_LOW_CONTRIBUTION1='" + status + "'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND h.CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " GROUP BY  a.CHR_POREQUESTNO  ORDER BY a.INT_POREQUESTID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + "  a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO, ";
         sql = sql + " DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  ";
         sql = sql + "  h.CHR_NAME,  ";
         sql = sql + " a.CHR_REF,g.CHR_STAFFNAME, ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION2,       ";
         sql = sql + "  a.CHR_MODE, a.CHR_CPOREF_NUMBER, ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS ";
         sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c, ";
         sql = sql + "  inv_m_customerinfo d,inv_m_customergroup h,   ";
         sql = sql + "  com_m_staff g ,inv_t_purchaserequestitem i   ";
         sql = sql + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
         sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID   ";
         sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
         sql = sql + " AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.CHR_REF=g.CHR_EMPID   ";
         sql = sql + " AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND   a.INT_BRANCHID =" + Branch;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_REQUESTDATE)=" + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_REQUESTDATE)=" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_REQUESTDATE)=" + year;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_LOW_CONTRIBUTION2='" + status + "'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND h.CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " GROUP BY  a.CHR_POREQUESTNO  ORDER BY a.INT_POREQUESTID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
         sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
         sql = sql + " f.CHR_PAYMENTNAME, ";
         sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_APPROVEDSTATUS, ";
         sql = sql + "a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y') ,a.CHR_CLOSEDSTATUS,SUM(i.DOU_PURCHASEPRICE),  ";
         sql = sql + " if(a.CHR_CLOSEDSTATUS ='Y', ";
         sql = sql + "     if( (DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock + "),'N','Y'  ) ";
         sql = sql + "     ,'' ";
         sql = sql + "   )        ";
         sql = sql + " , a.CHR_BYBACK, a.CHR_SALESNO ,a.CHR_MODE, a.CHR_CPOREF_NUMBER  ";
         sql = sql + " ,a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2, ";
         sql = sql + " FUN_INV_OVERALL_CONTRIBUTION(a.CHR_POREQUESTNO) , a.CHR_MODE, ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS,a.INT_PROGRESSBAR ";
         sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,inv_m_customergroup h, ";
         sql = sql + " inv_m_paymentterms f,com_m_staff g ,inv_t_purchaserequestitem i ";
         sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
         sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
         sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
         sql = sql + " AND a.CHR_REF=g.CHR_EMPID ";
         sql = sql + " AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
         if (!"0".equals(Branch)) {
            sql = sql + " AND   a.INT_BRANCHID =" + Branch;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_REQUESTDATE)=" + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_REQUESTDATE)=" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_REQUESTDATE)=" + year;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_APPROVEDSTATUS='" + status + "'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND h.CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " GROUP BY  a.CHR_POREQUESTNO  ORDER BY a.INT_POREQUESTID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + "  DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'),  h.CHR_NAME,h.CHR_NAME, ";
         sql = sql + " f.CHR_PAYMENTNAME,  ";
         sql = sql + " DATE_FORMAT(a.DAT_PURCHASEDATE,'%d-%b-%Y'),a.INT_CUSTOMERCOMMITMENTDAYS,DATE_FORMAT(a.DAT_COMMITMENTDATE,'%d-%b-%Y'), ";
         sql = sql + " a.CHR_CLOSEDSTATUS ,SUM(i.DOU_PURCHASEPRICE), a.CHR_PR_PARTIALLY_RECEIVED ,";
         sql = sql + " if(a.CHR_CLOSEDSTATUS ='Y', ";
         sql = sql + "     if( (DATEDIFF(NOW(),a.DAT_REQUESTDATE) <=" + datelock + "),'N','Y'  ) ";
         sql = sql + "     ,'' ";
         sql = sql + "   )        ";
         sql = sql + " , a.CHR_BYBACK, a.CHR_SALESNO ,a.CHR_MODE,a.CHR_CPOREF_NUMBER , ";
         sql = sql + " a.CHR_LOW_CONTRIBUTION1,a.CHR_LOW_CONTRIBUTION2,a.CHR_APPROVEDSTATUS,a.CHR_CLOSEDSTATUS  ,a.INT_PROGRESSBAR";
         sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c, ";
         sql = sql + " inv_m_customerinfo d,    ";
         sql = sql + "  inv_m_paymentterms f, inv_m_customergroup h ,inv_t_purchaserequestitem i  ";
         sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID   ";
         sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID   ";
         sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID    AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
         sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID   AND a.CHR_POREQUESTNO  = i.CHR_POREQUESTNO ";
         sql = sql + " AND ( a.CHR_APPROVEDSTATUS='Y' OR a.CHR_APPROVEDSTATUS='P')";
         if (!"0".equals(Branch)) {
            sql = sql + " AND   a.INT_BRANCHID =" + Branch;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_REQUESTDATE)=" + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_REQUESTDATE)=" + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_REQUESTDATE)=" + year;
         }

         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"0".equals(status)) {
            sql = sql + " AND a.CHR_CLOSEDSTATUS ='" + status + "'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND h.CHR_NAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " GROUP BY  a.CHR_POREQUESTNO   ORDER BY a.INT_POREQUESTID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " if(a.CHR_DELIVERY='P','PROGRESS',if(a.CHR_DELIVERY='Y','DELIVERED',if(a.CHR_DELIVERY='R','REJECT','PENDING'))) ";
         sql = sql + " FROM inv_t_directsales a , inv_m_customerinfo b ";
         sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_DELIVERY NOT IN ('N','R') ";
         sql = sql + " AND a.CHR_INSTALLATION ='Y'   AND a.INT_SALESSTATUS=1  AND a.CHR_CANCEL='N' ";
         if (!"0".equals(branch)) {
            sql = sql + "  AND a.INT_BRANCHID = " + branch;
         }

         if (!"0".equals(customer)) {
            sql = sql + "   AND a.INT_CUSTOMERID = " + customer;
         }

         if ("Y".equals(status)) {
            sql = sql + "    AND a.CHR_INSTALLATION_STATUS ='Y'";
         } else if ("N".equals(status)) {
            sql = sql + "    AND a.CHR_INSTALLATION_STATUS ='N'";
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID = " + division;
         }

         if (!"0".equals("" + mon)) {
            sql = sql + " AND MONTH(a.DAT_SALESDATE) =" + mon;
         }

         sql = sql + " AND YEAR(a.DAT_SALESDATE)=" + year;
         if (!"0".equals(txtSer)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + txtSer + "%'";
         }

         sql = sql + " order by a.INT_SALESID  ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + "   FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),b.CHR_CONTACTDETAILS,b.CHR_CONTACTNO,  ";
         sql = sql + " a.CHR_SERIALNO, DATE_FORMAT(a.DAT_INSTALLATION,'%d-%b-%Y %h:%i:%s'),a.CHR_EMPID,a.CHR_STATUS  ";
         sql = sql + " FROM inv_t_directsales_installation a, inv_t_directsales b, inv_m_customerinfo c  ";
         sql = sql + " WHERE a.CHR_SALESNO  = b.CHR_SALESNO   ";
         sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID  ";
         if (!"0".equals(branch)) {
            sql = sql + "  AND b.INT_BRANCHID = " + branch;
         }

         if (!"0".equals(customer)) {
            sql = sql + "   AND b.INT_CUSTOMERID = " + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND b.INT_DIVIID = " + division;
         }

         if (!"0".equals("" + mon)) {
            sql = sql + " AND MONTH(a.DAT_SALESDATE) =" + mon;
         }

         sql = sql + " AND YEAR(b.DAT_SALESDATE)=" + year;
         if ("Y".equals(status)) {
            sql = sql + "    AND a.CHR_STATUS ='Y'";
         } else if ("A".equals(status)) {
            sql = sql + "    AND a.CHR_STATUS ='A'";
         } else if ("P".equals(status)) {
            sql = sql + "    AND a.CHR_STATUS ='P'";
         }

         if (!"0".equals(txtSer)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)  LIKE '" + txtSer + "%'";
         }

         sql = sql + " order by a.INT_INSTALLATIONID    ";
         System.out.println(sql);
         File file = null;
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
               file = new File(request.getRealPath("/") + "uploadfiles/CCFR/" + readData[u][0] + ".pdf");
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String bid = "" + session.getAttribute("BRANCHID");
         String sql = "";
         sql = "  SELECT b.CHR_EMPID,b.CHR_STAFFNAME, ";
         sql = sql + "  if(a.CHR_TYPE='I','Item','Product'), ";
         sql = sql + "  if(a.CHR_TYPE='I',   ";
         sql = sql + "  (SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID) ";
         sql = sql + "  , ";
         sql = sql + "  (SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID) ";
         sql = sql + "  ),   ";
         sql = sql + "   a.INT_ASSETID,a.CHR_SERIALNO, ";
         sql = sql + "  DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y'),a.CHR_STATUS ";
         sql = sql + "  FROM inv_t_asset a,com_m_staff b,inv_t_vendorgoodsreceived c ";
         sql = sql + "  WHERE a.CHR_EMPID=b.CHR_EMPID ";
         sql = sql + "  AND a.CHR_ITEMID = c.CHR_ITEMID ";
         sql = sql + "  AND a.CHR_SERIALNO =c.CHR_SERIALNO ";
         if (!"0".equals(status)) {
            sql = sql + " AND  a.CHR_STATUS ='" + status + "' ";
         }

         if (!"0".equals(bid)) {
            sql = sql + " AND  a.INT_BRANCHID =" + bid;
         }

         if (!"0".equals(offic)) {
            sql = sql + " AND  b.INT_OFFICEID =" + offic;
         }

         if (!"0".equals(deptment)) {
            sql = sql + " AND b.INT_DEPARTID =" + deptment;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_CREATIONDATE) = " + month;
         }

         sql = sql + " AND YEAR(a.DAT_CREATIONDATE) = " + year;
         sql = sql + " ORDER BY b.CHR_STAFFNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
         request.setAttribute("error", var14.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
            for(int x = 0; x < serialnoData.length; ++x) {
               sb.append("<serial>");
               sb.append("<id>" + serialnoData[x][1] + "</id>");
               sb.append("<serialNo>" + serialnoData[x][0] + "</serialNo>");
               sb.append("</serial>");
            }

            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Rowserial>" + sb.toString() + "</Rowserial>");
         } else {
            System.out.println("elsepath..");
            sb.append("<serial>");
            sb.append("<id>0</id>");
            sb.append("<serialNo>" + str + "</serialNo>");
            sb.append("</serial>");
         }
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
         request.setAttribute("error", var8.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String bid = "" + session.getAttribute("BRANCHID");
         String sql = "SELECT a.INT_EMDID,a.CHR_EMD_REFNUMBER,if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),UPPER(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID )) ,a.DOU_EMD_AMOUNT,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),a.CHR_APPROVAL,a.CHR_STATUS,d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)";
         sql = sql + " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID";
         sql = sql + " AND  a.CHR_REF =c.CHR_EMPID";
         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) LIKE '" + StartLetter + "%'";
         }

         if (!"0".equals(bid)) {
            sql = sql + " AND  a.INV_BRANCHID =" + bid;
         }

         if (!"0".equals(offic)) {
            sql = sql + " AND  c.INT_OFFICEID =" + offic;
         }

         if (!"0".equals(EmdType)) {
            sql = sql + " AND a.INT_EMD_TYPE ='" + EmdType + "'";
         }

         if (!"0".equals(accept)) {
            sql = sql + " AND a.CHR_APPROVAL ='" + accept + "'";
         }

         if (!"0".equals(returned)) {
            sql = sql + " AND a.CHR_STATUS ='" + returned + "'";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_CREATION) = " + month;
         }

         sql = sql + " AND YEAR(a.DAT_CREATION) = " + year;
         sql = sql + " ORDER BY a.INT_CUSTOMERID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            String filepath = request.getRealPath("/");

            for(int u = 0; u < readData.length; ++u) {
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
               if (FileFunctions.fileIsThere(filepath + "uploadfiles/EMD_File/" + readData[u][0] + ".pdf")) {
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
      } catch (Exception var16) {
         System.out.println(var16.getMessage());
         request.setAttribute("error", var16.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         String bid = "" + session.getAttribute("BRANCHID");
         String sql = "SELECT a.INT_EMDID,a.CHR_EMD_REFNUMBER,if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),a.DOU_EMD_AMOUNT,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),a.CHR_APPROVAL,a.CHR_STATUS,d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)";
         sql = sql + " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID";
         sql = sql + " AND  a.CHR_REF =c.CHR_EMPID";
         if (!"0".equals(bid)) {
            sql = sql + " AND  a.INV_BRANCHID =" + bid;
         }

         if (!"0".equals(offic)) {
            sql = sql + " AND  c.INT_OFFICEID =" + offic;
         }

         if (!"0".equals(EmdType)) {
            sql = sql + " AND a.INT_EMD_TYPE ='" + EmdType + "'";
         }

         if (!"0".equals(accept)) {
            sql = sql + " AND a.CHR_APPROVAL ='" + accept + "'";
         }

         if (!"0".equals(returned)) {
            sql = sql + " AND a.CHR_STATUS ='" + returned + "'";
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) LIKE '" + StartLetter + "%'";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_CREATION) = " + month;
         }

         sql = sql + " AND YEAR(a.DAT_CREATION) = " + year;
         sql = sql + " AND a.CHR_REF='" + session.getAttribute("EMPID") + "' ";
         sql = sql + " ORDER BY a.INT_CUSTOMERID ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
               if (readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter)) {
                  sb.append("<Emddetail>");
                  sb.append("<Emdid>" + readData[u][0] + "</Emdid>");
                  sb.append("<Emdnumber>" + readData[u][1] + "</Emdnumber>");
                  sb.append("<EmdType>" + readData[u][2] + "</EmdType>");
                  sb.append("<CustomerName>" + readData[u][3].replaceAll("&", " AND") + "</CustomerName>");
                  sb.append("<EmdAmt>" + readData[u][4] + "</EmdAmt>");
                  sb.append("<TenderLastDate>" + readData[u][5] + "</TenderLastDate>");
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadProject(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String StartLetter = request.getParameter("startLetter");
         String sql = "";
         sql = " SELECT INT_PROJECTID,CHR_PROJECTNAME,CHR_STATUS  FROM inv_m_project ";
         if (!"0".equals(StartLetter)) {
            sql = sql + " WHERE  CHR_PROJECTNAME LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY CHR_PROJECTNAME ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var7) {
         System.out.println(var7.getMessage());
         request.setAttribute("error", var7.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.CHR_CALLNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y  %h:%m:%s %p'), ";
         sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY),a.CHR_DESPATCH_LOCATION,a.CHR_ISSUED ";
         sql = sql + " FROM inv_t_sparedemand a , com_m_branch b";
         sql = sql + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
         if (!"0".equals(branch)) {
            sql = sql + " AND  a.INT_BRANCHID = " + branch;
         }

         if (!"0".equals(calltype)) {
            sql = sql + " AND  a.CHR_CALLTYPE = '" + calltype + "' ";
         }

         if (!"0".equals(day)) {
            sql = sql + " AND  DAY(a.DAT_DEMAND_RAISED_DATE)= " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND  MONTH(a.DAT_DEMAND_RAISED_DATE)= " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND  YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND  a.CHR_CUSTOMER LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY a.CHR_CUSTOMER ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.CHR_CALLNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y  %h:%m:%s %p'), ";
         sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY),a.CHR_DESPATCH_LOCATION,a.CHR_ISSUED, ";
         sql = sql + " a.CHR_ISSUED_SERIALNUMBER,FIND_A_EMPLOYEE_ID_NAME(a.CHR_ISSUED_BY),DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%b-%Y  %h:%m:%s %p'),";
         sql = sql + " a.CHR_RETURN_STATUS ,DATEDIFF(a.DAT_ISSUED_DATE,a.DAT_DEMAND_RAISED_DATE),";
         sql = sql + " if(a.CHR_ISSUE_THROUGH='C','Courier',if(a.CHR_ISSUE_THROUGH='P','Person','Vechicle') ), ";
         sql = sql + "  a.CHR_ISSUE_DESC ";
         sql = sql + " FROM inv_t_sparedemand a , com_m_branch b";
         sql = sql + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
         if (!"0".equals(branch)) {
            sql = sql + " AND  a.INT_BRANCHID = " + branch;
         }

         if (!"0".equals(calltype)) {
            sql = sql + " AND  a.CHR_CALLTYPE = '" + calltype + "' ";
         }

         if (!"0".equals(day)) {
            sql = sql + " AND  DAY(a.DAT_DEMAND_RAISED_DATE)= " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND  MONTH(a.DAT_DEMAND_RAISED_DATE)= " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND  YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND a.CHR_CUSTOMER LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY a.CHR_CUSTOMER ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
            response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " a.CHR_CALLNUMBER,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y  %h:%m:%s %p'), ";
         sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY),a.CHR_DESPATCH_LOCATION,a.CHR_ISSUED, ";
         sql = sql + " a.CHR_ISSUED_SERIALNUMBER,FIND_A_EMPLOYEE_ID_NAME(a.CHR_ISSUED_BY),DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%b-%Y  %h:%m:%s %p'),";
         sql = sql + " a.CHR_RETURN_STATUS ,DATEDIFF(a.DAT_ISSUED_DATE,a.DAT_DEMAND_RAISED_DATE),";
         sql = sql + " if(a.CHR_ISSUE_THROUGH='C','Courier',if(a.CHR_ISSUE_THROUGH='P','Person','Vechicle') ), ";
         sql = sql + "  a.CHR_ISSUE_DESC, DATEDIFF(a.DAT_RETURN_DATE,a.DAT_ISSUED_DATE)";
         sql = sql + " FROM inv_t_sparedemand a , com_m_branch b";
         sql = sql + "  WHERE a.INT_BRANCHID = b.INT_BRANCHID  AND a.CHR_ISSUED ='Y' ";
         if (!"0".equals(returnstatus)) {
            sql = sql + " AND  a.CHR_RETURN_STATUS = '" + returnstatus + "' ";
         }

         if (!"0".equals(branch)) {
            sql = sql + " AND  a.INT_BRANCHID = " + branch;
         }

         if (!"0".equals(calltype)) {
            sql = sql + " AND  a.CHR_CALLTYPE = '" + calltype + "' ";
         }

         if (!"0".equals(day)) {
            sql = sql + " AND  DAY(a.DAT_DEMAND_RAISED_DATE)= " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND  MONTH(a.DAT_DEMAND_RAISED_DATE)= " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND  YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year;
         }

         if (!"0".equals(StartLetter)) {
            sql = sql + " AND  a.CHR_CUSTOMER LIKE '" + StartLetter + "%'";
         }

         sql = sql + " ORDER BY a.CHR_CUSTOMER ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var13) {
         System.out.println(var13.getMessage());
         request.setAttribute("error", var13.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_DCDATE)=" + day + " ";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_DCDATE)=" + month + " ";
         }

         sql = sql + " AND YEAR(a.DAT_DCDATE)=" + year + " ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"2".equals(dcstatus)) {
            sql = sql + " AND a.CHR_DCSTATUS='" + dcstatus + "' ";
         }

         if ("1".equals(type)) {
            if (!"0".equals(StartLetter)) {
               sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%'";
            }
         } else {
            sql = sql + " AND ( (a.CHR_DCNO LIKE '%" + StartLetter + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%') )";
         }

         sql = sql + " GROUP BY a.CHR_DCNO  ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
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
         sql = sql + " AND a.INT_BRANCHID=" + Branch + " ";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_SCRABDATE)=" + day + " ";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_SCRABDATE)=" + month + " ";
         }

         sql = sql + " AND YEAR(a.DAT_SCRABDATE)=" + year + " ";
         if (!"0".equals(customer)) {
            sql = sql + " AND a.INT_CUSTOMERID=" + customer;
         }

         if (!"0".equals(division)) {
            sql = sql + " AND a.INT_DIVIID=" + division;
         }

         if (!"2".equals(dcstatus)) {
            sql = sql + " AND a.CHR_STATUS='" + dcstatus + "' ";
         }

         if ("1".equals(type)) {
            if (!"0".equals(StartLetter)) {
               sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%'";
            }
         } else {
            sql = sql + " AND ( (a.CHR_SCRABNO LIKE '%" + StartLetter + "%') OR ( FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '" + StartLetter.toUpperCase() + "%') )";
         }

         sql = sql + " GROUP BY a.CHR_SCRABNO  ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
         request.setAttribute("error", var15.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void loadStockAdjustment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         (new StringBuilder()).append(request.getParameter("id")).toString();
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String dcstatus = request.getParameter("dcstatus");
         String day = request.getParameter("day");
         String type = request.getParameter("type");
         String sql = "";
         sql = " SELECT  a.CHR_ADJUSTMENTNO,date_format(a.DAT_ADJUSTMENTDATE,'%d-%b-%Y'),FUN_GET_BRANCH_NAME(a.INT_TO_BRANCHID),a.CHR_REF ,a.CHR_DES,a.CHR_DCSTATUS,a.CHR_STATUS,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)  FROM inv_t_stockadjustment a  WHERE  INT_STOCKADJUSTMENT_ID >= 0  ";
         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_ADJUSTMENTDATE)=" + day + " ";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_ADJUSTMENTDATE)=" + month + " ";
         }

         sql = sql + " AND YEAR(a.DAT_ADJUSTMENTDATE)=" + year + " ";
         if (!"0".equals(dcstatus)) {
            sql = sql + " AND a.CHR_DCSTATUS='" + dcstatus + "' ";
         }

         sql = sql + " GROUP BY a.CHR_ADJUSTMENTNO  ";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         StringBuffer sb = new StringBuffer();
         if (readData.length > 0) {
            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var12) {
         System.out.println(var12.getMessage());
         request.setAttribute("error", var12.getMessage());
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
         dispatchers.forward(request, response);
      }

   }

   public static void LoadSSparedemand(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         HttpSession session = request.getSession();
         String usertype = "" + session.getAttribute("USRTYPE");
         String issue = request.getParameter("Issue");
         String startLetter = request.getParameter("startLetter");
         String day = request.getParameter("day");
         String month = request.getParameter("month");
         String year = request.getParameter("year");
         String stype = request.getParameter("stype");
         String branch = request.getParameter("branch");
         String sql = "";
         sql = sql + " SELECT a.INT_DEMANID,a.CHR_DEMANDNO,a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.CHR_DESC, ";
         sql = sql + " a.CHR_ISSUED,DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y'), ";
         sql = sql + "  b.CHR_BRANCHNAME ,  ";
         sql = sql + " if(a.CHR_CALLTYPE='Q', ";
         sql = sql + " ( SELECT c.CHR_CUSTOMERNAME FROM inv_ss_sparemaster c  WHERE   a.CHR_PRODUCT_SERIALNUMBER = c.CHR_SERIALNO ), ";
         sql = sql + " a.CHR_CUSTOMER ";
         sql = sql + " ) customer, ";
         sql = sql + "    if(a.CHR_CALLTYPE='Q', ";
         sql = sql + " ( SELECT if(c1.CHR_CATEGORY='A','AMC','Warranty') FROM inv_ss_sparemaster c1  WHERE   a.CHR_PRODUCT_SERIALNUMBER = c1.CHR_SERIALNO ), ";
         sql = sql + " 'NM CALL' ";
         sql = sql + " ) category,  ";
         sql = sql + " if(a.CHR_CALLTYPE='Q', ";
         sql = sql + " ( SELECT c2.CHR_CUSTOMERADDRESS FROM inv_ss_sparemaster c2 WHERE   a.CHR_PRODUCT_SERIALNUMBER = c2.CHR_SERIALNO ), ";
         sql = sql + " a.CHR_CUSTOMER_ADDRESS ";
         sql = sql + " )  address , FIND_A_EMPLOYEE_ID_NAME_BY_USERID(a.CHR_USRNAME)";
         sql = sql + " FROM inv_ss_sparedemand a,com_m_branch b ";
         sql = sql + " WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID ";
         if (!"0".equals(issue)) {
            sql = sql + " AND a.CHR_ISSUED ='" + issue + "'";
         }

         if (!"0".equals(branch)) {
            sql = sql + " AND a.INT_BRANCHID = " + branch;
         }

         if (!"0".equals(day)) {
            sql = sql + " AND DAY(a.DAT_DEMAND_RAISED_DATE) = " + day;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND MONTH(a.DAT_DEMAND_RAISED_DATE) = " + month;
         }

         if (!"0".equals(year)) {
            sql = sql + " AND YEAR(a.DAT_DEMAND_RAISED_DATE) = " + year;
         }

         if (!"1".equals(stype) && !"".equals(startLetter)) {
            sql = sql + " AND a.CHR_PRODUCT_SERIALNUMBER LIKE '%" + startLetter + "%' ";
         }

         sql = sql + " ORDER BY a.DAT_DEMAND_RAISED_DATE";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
               sb.append("<Usertype>" + usertype + "</Usertype>");
               sb.append("</Row>");
            }

            sb.toString();
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<RowsSpare>" + sb.toString() + "</RowsSpare>");
         } else {
            response.setStatus(204);
         }
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
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
         sql = sql + " if(c.CHR_CALLTYPE='Q', ";
         sql = sql + " ( SELECT c2.CHR_CUSTOMERNAME FROM inv_ss_sparemaster c2 ";
         sql = sql + " WHERE   c.CHR_PRODUCT_SERIALNUMBER = c2.CHR_SERIALNO ),  ";
         sql = sql + " c.CHR_CUSTOMER ";
         sql = sql + " ) customer, ";
         sql = sql + " a.CHR_STATUS ";
         sql = sql + " FROM inv_ss_t_sparedemandissue a ,inv_m_produtlist b,inv_ss_sparedemand c ";
         sql = sql + " WHERE a.INT_ISSUEID>0 AND a.CHR_PRODUCTCODE = b.CHR_PRODUCTID AND c.CHR_DEMANDNO = a.CHR_DEMANDNO";
         sql = sql + " AND a.CHR_ISSUED_BY='" + userid + "'";
         if (!"0".equals(type)) {
            sql = sql + " AND a.CHR_TYPE = '" + type + "'";
         }

         if (!"0".equals(sparetype)) {
            sql = sql + " AND a.CHR_SPARETYPE = '" + sparetype + "' ";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND month(a.DAT_ISSUED_DATE) = " + Integer.parseInt(month);
         }

         if (!"0".equals(year)) {
            sql = sql + " AND year(a.DAT_ISSUED_DATE) = " + year;
         }

         if ("1".equals(stype)) {
            if (!"0".equals(startLetter)) {
               sql = sql + " AND TRIM(b.CHR_PRODUCTCODE) LIKE '" + startLetter.trim() + "%' ";
            }
         } else if (!"".equals(startLetter)) {
            sql = sql + " AND TRIM(b.CHR_PRODUCTCODE) LIKE '%" + startLetter + "%' ";
         }

         sql = sql + " ORDER BY a.CHR_DEMANDNO";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
      }

   }

   public static void LoadAssignsparedemand(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String demandnumber = request.getParameter("demandnumber");
         String sql1 = " Select CHR_DEMANDNO from inv_ss_sparedemand   WHERE INT_DEMANID = '" + demandnumber + "'";
         String[][] readData1 = CommonFunctions.QueryExecute(sql1);
         String sql = "";
         sql = " SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.DAT_DEMAND_RAISED_DATE,a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION";
         sql = sql + " FROM inv_ss_sparedemand a,com_m_branch b ";
         sql = sql + " WHERE  a.INT_BRANCHID=b.INT_BRANCHID ";
         sql = sql + " AND a.CHR_DEMANDNO = '" + readData1[0][0] + "' ";
         sql = sql + " ORDER BY a.CHR_DEMANDNO";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
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
         sql = sql + " if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT'), ";
         sql = sql + "a.INT_QTY,a.CHR_ISSUED_SERIALNUMBER,a.CHR_PRODUCTCODE,";
         sql = sql + " if( a.CHR_TYPE ='I',";
         sql = sql + "(SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_PRODUCTCODE),";
         sql = sql + "(SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_PRODUCTCODE))productcode,";
         sql = sql + " if(c.CHR_CALLTYPE='Q', ";
         sql = sql + " ( SELECT d.CHR_CUSTOMERNAME FROM inv_ss_sparemaster d  WHERE   c.CHR_PRODUCT_SERIALNUMBER = d.CHR_SERIALNO ), ";
         sql = sql + " c.CHR_CUSTOMER";
         sql = sql + " ) ";
         sql = sql + " FROM inv_ss_t_sparedemandissue a ,inv_ss_sparedemand c ";
         sql = sql + " WHERE a.INT_ISSUEID>0  AND c.CHR_DEMANDNO = a.CHR_DEMANDNO";
         sql = sql + " AND a.CHR_ISSUED_BY='" + userid + "'";
         if (!"0".equals(type)) {
            sql = sql + " AND a.CHR_TYPE = '" + type + "'";
         }

         if (!"0".equals(sparetype)) {
            sql = sql + " AND a.CHR_SPARETYPE = '" + sparetype + "' ";
         }

         if (!"0".equals(branch)) {
            sql = sql + " AND c.INT_BRANCHID =  " + branch;
         }

         if (!"0".equals(month)) {
            sql = sql + " AND month(a.DAT_ISSUED_DATE) = " + Integer.parseInt(month);
         }

         if (!"0".equals(year)) {
            sql = sql + " AND year(a.DAT_ISSUED_DATE) = " + year;
         }

         if (!"0".equals(startLetter)) {
            sql = sql + " AND (   ";
            sql = sql + " \t\t if( a.CHR_TYPE ='I' ,  ";
            sql = sql + " \t\t    (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_PRODUCTCODE),  ";
            sql = sql + " \t\t    (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_PRODUCTCODE)  ";
            sql = sql + " \t\t ) ) LIKE '" + startLetter + "%'  ";
         }

         sql = sql + " ORDER BY a.CHR_DEMANDNO";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var14) {
         System.out.println(var14.getMessage());
      }

   }

   public static void CheckQtyno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String qtyno = request.getParameter("qtyno");
         HttpSession session = request.getSession();
         String bid = "" + session.getAttribute("INVBRANCH");
         String consumable = request.getParameter("consumable");
         StringBuffer sb = new StringBuffer();
         if (!qtyno.equals("0")) {
            String sql = " SELECT if((SUM(INT_PQTY)-SUM(INT_SQTY))> 0,if((SUM(INT_PQTY)-SUM(INT_SQTY)) >= '" + qtyno + "','Valid','Invalid'),'Invalid') ";
            sql = sql + " FROM inv_t_vendorgoodsreceivedconsumable  WHERE INT_BRANCHID = '" + bid + "' AND CHR_ITEMID= '" + consumable + "'";
            sql = sql + " GROUP BY CHR_ITEMID";
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
      } catch (Exception var9) {
         System.out.println(var9.getMessage());
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
      } catch (Exception var6) {
         System.out.println(var6.getMessage());
      }

   }

   public static void Checkproductcode(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         boolean flag = false;
         String productcode = request.getParameter("productcode");
         String demandno = request.getParameter("demandno");
         String demand = null;
         StringBuffer sb = new StringBuffer();
         String sql1;
         if (!productcode.equals("0")) {
            sql1 = "SELECT INT_DEMANID,CHR_DEMANDNO FROM inv_ss_sparedemand WHERE CHR_ISSUED!='Y' AND INT_DEMANID='" + demandno + "'";
            sql1 = sql1 + " ORDER BY CHR_DEMANDNO";
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
            sql1 = "0";
            sb.append("<productnumber>");
            sb.append("<PStatus>" + sql1 + "</PStatus>");
            sb.append("</productnumber>");
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<Productcode>" + sb.toString() + "</Productcode>");
         }
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
      }

   }

   public static void LoadSparedemandissue(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String sql = "";
         String demandnumber = request.getParameter("demandnumber");
         String[][] readData;
         if (!"0".equals(demandnumber)) {
            String sql1 = " Select CHR_DEMANDNO from inv_ss_sparedemand   WHERE INT_DEMANID = '" + demandnumber + "'";
            readData = CommonFunctions.QueryExecute(sql1);
            sql = " SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.DAT_DEMAND_RAISED_DATE,a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION";
            sql = sql + " FROM inv_ss_sparedemand a,com_m_branch b";
            sql = sql + " WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID ";
            sql = sql + " AND a.CHR_DEMANDNO = '" + readData[0][0] + "' ";
            sql = sql + " ORDER BY a.CHR_DEMANDNO";
         } else {
            sql = " SELECT a.CHR_CALLNUMBER,a.CHR_PRODUCT_SERIALNUMBER,a.DAT_DEMAND_RAISED_DATE,a.CHR_DEMAND_RAISED_BY,a.CHR_DESPATCH_LOCATION";
            sql = sql + " FROM inv_ss_sparedemand a,com_m_branch b";
            sql = sql + " WHERE a.INT_DEMANID>0 AND a.INT_BRANCHID=b.INT_BRANCHID ";
            sql = sql + " AND a.CHR_DEMANDNO = '0' ";
            sql = sql + " ORDER BY a.CHR_DEMANDNO";
         }

         System.out.println("spareissuedetail...." + sql);
         readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var8) {
         System.out.println(var8.getMessage());
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
            if (readDataProductcode.length > 0) {
               for(int u = 0; u < readDataProductcode.length; ++u) {
                  demanids = demanids + "'" + readDataProductcode[u][0] + "',";
               }
            }

            demanids = demanids + "'0')";
            if (id.equals("I")) {
               sql = " Select CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME";
            }

            if (id.equals("P") && "S".equals(sparetype)) {
               sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE CHR_PTYPE!= 'S' ORDER BY CHR_PRODUCTCODE";
            }

            if (id.equals("P") && "C".equals(sparetype)) {
               sql = " select CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE CHR_PTYPE = 'S' AND CHR_PRODUCTID NOT IN " + demanids + " ORDER BY CHR_PRODUCTCODE";
            }

            String[][] readData = CommonFunctions.QueryExecute(sql);
            if (readData.length > 0) {
               for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var15) {
         System.out.println(var15.getMessage());
      }

   }

   public static void CheckQtyconsumno(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      try {
         String spoldqty = request.getParameter("oldqty");
         String newqtyno = request.getParameter("qtyno");
         HttpSession session = request.getSession();
         String bid = "" + session.getAttribute("INVBRANCH");
         String consumable = request.getParameter("consumable");
         String sql = " SELECT if((SUM(INT_PQTY)-SUM(INT_SQTY))>= 0,if((SUM(INT_PQTY)-SUM(INT_SQTY))+'" + spoldqty + "' >= '" + newqtyno + "','Valid','Invalid'),'Invalid') ";
         sql = sql + " FROM inv_t_vendorgoodsreceivedconsumable  WHERE INT_BRANCHID = '" + bid + "' AND CHR_ITEMID= '" + consumable + "'";
         sql = sql + " GROUP BY CHR_ITEMID";
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
      } catch (Exception var10) {
         System.out.println(var10.getMessage());
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
         sql = sql + " if(c.CHR_CALLTYPE='Q', ";
         sql = sql + " ( SELECT d.CHR_CUSTOMERNAME FROM inv_ss_sparemaster d  WHERE   c.CHR_PRODUCT_SERIALNUMBER = d.CHR_SERIALNO ), ";
         sql = sql + " c.CHR_CUSTOMER";
         sql = sql + " ) ,";
         sql = sql + " a.INT_RETURN_QTY,a.INT_USED_QTY FROM inv_ss_t_sparedemandissue a ,inv_m_produtlist b,inv_ss_sparedemand c ";
         sql = sql + " WHERE a.INT_ISSUEID>0 AND a.CHR_PRODUCTCODE = b.CHR_PRODUCTID AND c.CHR_DEMANDNO = a.CHR_DEMANDNO";
         sql = sql + " AND a.CHR_ISSUED_BY='" + userid + "'";
         if (!"0".equals(type)) {
            sql = sql + " AND a.CHR_TYPE = '" + type + "'";
         }

         if (!"0".equals(sparetype)) {
            sql = sql + " AND a.CHR_SPARETYPE = '" + sparetype + "' ";
         }

         if (!"0".equals(month)) {
            sql = sql + " AND month(a.DAT_ISSUED_DATE) = " + Integer.parseInt(month);
         }

         if (!"0".equals(year)) {
            sql = sql + " AND year(a.DAT_ISSUED_DATE) = " + year;
         }

         if (!"0".equals(startLetter)) {
            sql = sql + " AND b.CHR_PRODUCTCODE LIKE '" + startLetter + "%' ";
         }

         sql = sql + " ORDER BY a.CHR_DEMANDNO";
         System.out.println(sql);
         String[][] readData = CommonFunctions.QueryExecute(sql);
         if (readData.length > 0) {
            StringBuffer sb = new StringBuffer();

            for(int u = 0; u < readData.length; ++u) {
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
      } catch (Exception var13) {
         System.out.println(var13.getMessage());
      }

   }
}
