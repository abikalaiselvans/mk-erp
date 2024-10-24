package com.my.org.erp.SmartInventory;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartInventory.ReportsActionHandler;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReportsActionHandler extends AbstractActionHandler {
  String sql = null;
  
  String repName = null;
  
  String repHeader = null;
  
  public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS").trim();
      HttpSession session = request.getSession();
      String branchid = session.getAttribute("BRANCHID").toString();
      String sql = "";
      if ("INVDayinward".equals(action)) {
        String dt = request.getParameter("saleDate");
        sql = "\tSELECT a.CHR_PURCHASEORDERNO,a.CHR_ITEMID,a.CHR_TYPE,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_RECIVEDBY,\ta.DAT_RECIVEDDATE,a.CHR_RECEIVEDMODE,a.DOU_UNITPRICE FROM inv_t_vendorgoodsreceived a WHERE a.CHR_GRTFLAG <> 'Y' AND a.INT_BRANCHID=" + branchid + " AND a.DAT_RECIVEDDATE ='" + DateUtil.FormateDateSQL(dt) + "'";
        repName = " Daily Inward";
        con.close();
        response.sendRedirect("Smart Inventory/Rept_DailyInwardReportPrint.jsp?sql=" + sql + "&dt=" + DateUtil.FormateDateSys(dt));
      } else if ("INVDaysales".equals(action)) {
        String dt = request.getParameter("saleDate");
        String dt2 = request.getParameter("saleDate2");
        String division = request.getParameter("division");
        String custid = request.getParameter("customer");
        String ref = request.getParameter("ref");
        String detail = request.getParameter("withdetails");
        String type = request.getParameter("type");
        String Branch = request.getParameter("Branch");
        boolean f = false;
        if (!"null".equals(detail))
          f = true; 
        String link = "Smart Inventory/Rept_DailySaleReportPrint.jsp?dt=" + DateUtil.FormateDateSys(dt);
        link = String.valueOf(link) + "&dt2=" + DateUtil.FormateDateSys(dt2);
        link = String.valueOf(link) + "&division=" + division + "&ref=" + ref + "&detail=" + f;
        link = String.valueOf(link) + "&customer=" + custid + "&type=" + type + "&Branch=" + Branch;
        con.close();
        response.sendRedirect(link);
      } else if ("INVMyDaysales".equals(action)) {
        String dt = request.getParameter("saleDate");
        String dt2 = request.getParameter("saleDate2");
        String division = request.getParameter("division");
        String custid = request.getParameter("customer");
        Object object = session.getAttribute("EMPID");
        String detail = request.getParameter("withdetails");
        String type = request.getParameter("type");
        String Branch = request.getParameter("Branch");
        boolean f = false;
        if (!"null".equals(detail))
          f = true; 
        String link = "Smart Inventory/Rept_MyDailySaleReportPrint.jsp?dt=" + DateUtil.FormateDateSys(dt);
        link = String.valueOf(link) + "&dt2=" + DateUtil.FormateDateSys(dt2);
        link = String.valueOf(link) + "&division=" + division + "&ref=" + object + "&detail=" + f;
        link = String.valueOf(link) + "&customer=" + custid + "&type=" + type + "&Branch=" + Branch;
        con.close();
        response.sendRedirect(link);
      } else if ("INVDaysaless".equals(action)) {
        String dt = request.getParameter("saleDate");
        String dt2 = request.getParameter("saleDate2");
        String division = request.getParameter("division");
        String custid = request.getParameter("customer");
        String ref = request.getParameter("ref");
        String type = request.getParameter("type");
        String Branch = request.getParameter("Branch");
        String detail = request.getParameter("detail");
        String link = "Smart Inventory/RRept_DailySaleReportPrint.jsp?dt=" + DateUtil.FormateDateSys(dt);
        link = String.valueOf(link) + "&dt2=" + DateUtil.FormateDateSys(dt2);
        link = String.valueOf(link) + "&division=" + division + "&ref=" + ref;
        link = String.valueOf(link) + "&customer=" + custid + "&type=" + type + "&Branch=" + Branch + "&detail=" + detail;
        System.out.println(link);
        con.close();
        response.sendRedirect(link);
      } else if ("INVSerialNumberTracking".equals(action)) {
        String serial = request.getParameter("SerialNumber");
        con.close();
        response.sendRedirect("Smart Inventory/Rept_SerialTrackReportPrint.jsp?serial=" + serial);
      } else if ("INVPaymentPending".equals(action)) {
        String division = request.getParameter("divis");
        String Branch = request.getParameter("Branch");
        String payType = request.getParameter("payType");
        String ref = request.getParameter("ref");
        String From = request.getParameter("From");
        String To = request.getParameter("To");
        String Chequedt = request.getParameter("Chequedt");
        String order = request.getParameter("order");
        con.close();
        response.sendRedirect("Smart Inventory/PaymentPendingResponse.jsp?division=" + division + "&payType=" + payType + "&From=" + From + "&To=" + To + "&ref=" + ref + "&Chequedt=" + Chequedt + "&order=" + order + "&Branch=" + Branch);
      } else if ("INVPaymentPending1".equals(action)) {
        String division = request.getParameter("divis");
        String Branch = request.getParameter("Branch");
        String payType = request.getParameter("payType");
        String ref = request.getParameter("ref");
        String From = request.getParameter("From");
        String To = request.getParameter("To");
        String Chequedt = request.getParameter("Chequedt");
        String order = request.getParameter("order");
        String fromdate = request.getParameter("fromdate");
        String todate = request.getParameter("todate");
        con.close();
        response.sendRedirect("Smart Inventory/PaymentPendingResponse1.jsp?division=" + division + "&payType=" + payType + "&From=" + From + "&To=" + To + "&ref=" + ref + "&Chequedt=" + Chequedt + "&order=" + order + "&Branch=" + Branch + "&fromdate=" + fromdate + "&todate=" + todate);
      } else if ("INVMyPaymentPending1".equals(action)) {
        String division = request.getParameter("divis");
        String Branch = request.getParameter("Branch");
        String payType = request.getParameter("payType");
        Object object = session.getAttribute("EMPID");
        String From = request.getParameter("From");
        String To = request.getParameter("To");
        String Chequedt = request.getParameter("Chequedt");
        String order = request.getParameter("order");
        String fromdate = request.getParameter("fromdate");
        String todate = request.getParameter("todate");
        con.close();
        response.sendRedirect("Smart Inventory/MyPaymentPendingResponse1.jsp?division=" + division + "&payType=" + payType + "&From=" + From + "&To=" + To + "&ref=" + object + "&Chequedt=" + Chequedt + "&order=" + order + "&Branch=" + Branch + "&fromdate=" + fromdate + "&todate=" + todate);
      } else if ("INVMyPaymentPending".equals(action)) {
        String division = request.getParameter("divis");
        String Branch = request.getParameter("Branch");
        String payType = request.getParameter("payType");
        Object object = session.getAttribute("EMPID");
        String From = request.getParameter("From");
        String To = request.getParameter("To");
        String Chequedt = request.getParameter("Chequedt");
        String order = request.getParameter("order");
        con.close();
        response.sendRedirect("Smart Inventory/MyPaymentPendingResponse.jsp?division=" + division + "&payType=" + payType + "&From=" + From + "&To=" + To + "&ref=" + object + "&Chequedt=" + Chequedt + "&order=" + order + "&Branch=" + Branch);
      } else if ("INVStockSerialNumber".equals(action)) {
        String Branch = request.getParameter("Branch");
        String itype = request.getParameter("itype");
        String item = request.getParameter("item");
        String division = request.getParameter("division");
        String pgroup = request.getParameter("pgroup");
        String buyback = request.getParameter("buyback");
        if ("1".equals(itype))
          itype = "I"; 
        if ("2".equals(itype))
          itype = "P"; 
        con.close();
        response.sendRedirect("Smart Inventory/Rept_StockSerialPrint.jsp?Branch=" + Branch + "&itype=" + itype + "&item=" + item + "&division=" + division + "&pgroup=" + pgroup + "&buyback=" + buyback);
      } else if ("INVSalesEmployeeRef".equals(action)) {
        String ref = request.getParameter("ref");
        String saleDate2 = request.getParameter("saleDate2");
        String saleDate = request.getParameter("saleDate");
        con.close();
        response.sendRedirect("Smart Inventory/Rept_CustomerSalesReportresponse.jsp?ref=" + ref + "&from=" + saleDate2 + "&to=" + saleDate);
      } else if ("INVSerialNumberChanging".equals(action)) {
        String serial = request.getParameter("SerialNumber").trim();
        String serial2 = request.getParameter("SerialNumber2").trim();
        asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_SERIALNO =? WHERE CHR_SERIALNO =? AND CHR_SERIALNO NOT IN (?) ";
        apstm = con.prepareStatement(asql);
        apstm.setString(1, serial2);
        apstm.setString(2, serial);
        apstm.setString(3, serial2);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        asql = "UPDATE inv_t_stocktransferitemserial SET CHR_SERIALNO =? WHERE CHR_SERIALNO =? AND CHR_SERIALNO NOT IN (?) ";
        apstm = con.prepareStatement(asql);
        apstm.setString(1, serial2);
        apstm.setString(2, serial);
        apstm.setString(3, serial2);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        asql = "UPDATE inv_t_swapsalesserialno SET CHR_SERIALNO =? WHERE CHR_SERIALNO =? AND CHR_SERIALNO NOT IN (?) ";
        apstm = con.prepareStatement(asql);
        apstm.setString(1, serial2);
        apstm.setString(2, serial);
        apstm.setString(3, serial2);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        asql = "UPDATE inv_t_swapserial SET CHR_SERIALNO =? WHERE CHR_SERIALNO =? AND CHR_SERIALNO NOT IN (?) ";
        apstm = con.prepareStatement(asql);
        apstm.setString(1, serial2);
        apstm.setString(2, serial);
        apstm.setString(3, serial2);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        asql = "UPDATE inv_t_deliverychallanitemserial SET CHR_SERIALNO =? WHERE CHR_SERIALNO =? AND CHR_SERIALNO NOT IN (?) ";
        apstm = con.prepareStatement(asql);
        apstm.setString(1, serial2);
        apstm.setString(2, serial);
        apstm.setString(3, serial2);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        asql = "UPDATE inv_ss_t_sparedemandissue SET CHR_ISSUED_SERIALNUMBER =? WHERE CHR_ISSUED_SERIALNUMBER =? AND CHR_ISSUED_SERIALNUMBER NOT IN (?) ";
        apstm = con.prepareStatement(asql);
        apstm.setString(1, serial2);
        apstm.setString(2, serial);
        apstm.setString(3, serial2);
        System.out.println(apstm);
        apstm.execute();
        apstm.close();
        con.close();
        response.sendRedirect("Smart Inventory/InventoryMains.jsp");
      } else if ("INVQuotationTracking".equals(action)) {
        String quotation = request.getParameter("QuotationNumber");
        con.close();
        response.sendRedirect("Smart Inventory/Rept_QuotationTrackReportPrint.jsp?quotation=" + quotation);
      } 
    } catch (Exception e) {
      System.out.println(e.getMessage());
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
}
