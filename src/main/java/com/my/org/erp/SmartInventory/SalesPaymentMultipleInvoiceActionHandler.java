package com.my.org.erp.SmartInventory;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartInventory.PaymentMail;
import com.my.org.erp.SmartInventory.SalesPaymentMultipleInvoiceActionHandler;
import com.my.org.erp.common.CommonFunctions;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SalesPaymentMultipleInvoiceActionHandler extends AbstractActionHandler {
  public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
      String action = request.getParameter("actionS");
      HttpSession session = request.getSession();
      Object object = session.getAttribute("USRID");
      String branchid = session.getAttribute("INVBRANCH").toString();
      if (action.equals("INVSalesPaymenMultipleinvoice")) {
        String paymentMethod = request.getParameter("paymentMethod");
        String[] payment = paymentMethod.split(",");
        String Bank = request.getParameter("Bank");
        String Challanno = request.getParameter("Challanno");
        String chequeDate = request.getParameter("chequeDate");
        String paymentDate = request.getParameter("paymentDate");
        paymentDate = DateUtil.FormateDateSQL(paymentDate);
        String remarks = request.getParameter("remarks");
        String ref = request.getParameter("ref");
        String creditto = request.getParameter("creditto");
        if ("Select".equals(Bank) || "".equals(Bank))
          Bank = "1"; 
        String transactionid = CommonFunctions.QueryExecute("SELECT REPLACE(REPLACE(REPLACE(now(),'-',''),':',''),' ' ,'')")[0][0];
        String totalrecords = request.getParameter("totalrecords");
        int count = Integer.parseInt(totalrecords);
        System.out.println(count);
        
        String pagerepeat = request.getParameter("pagerepeat");
        String diffamount = request.getParameter("diffamount");
        String salesnumberids = request.getParameter("salesnumberids");
        
        
        
        if (count > 0) {
          String customerid = request.getParameter("customerid");
          for (int u = 0; u < count; u++) {
            String salesOrderId = request.getParameter("salesnumber" + u);
            String salesAmount = request.getParameter("salesAmount" + u);
            String Balance = request.getParameter("Balance" + u);
            String Paid = request.getParameter("Paid" + u);
            String tickyes = request.getParameter("paidrow" + u);
            String transactiontype = request.getParameter("transactiontype" + u);
            String payType = "Direct";
            String divisionid = "";
            asql = "SELECT INT_BRANCHID FROM inv_t_directsales  WHERE   CHR_SALESNO='" + salesOrderId + "'";
            String[][] readData = CommonFunctions.QueryExecute(asql);
            if (readData.length > 0)
              branchid = readData[0][0]; 
            if ("Y".equals(tickyes)) {
              double bal1 = Double.parseDouble(Balance) - Double.parseDouble(Paid);
              int bal = (int)bal1;
              asql = "INSERT INTO   inv_t_customersalespayment  ";
              asql = String.valueOf(asql) + "( INT_BRANCHID,INT_CUSTOMERID,CHR_SALESORDERNO,";
              asql = String.valueOf(asql) + " INT_PAYMENTTERMID,CHR_BANKNAME,CHR_PAYNO,DAT_PAYMENTDATE,";
              asql = String.valueOf(asql) + " DOU_OPENDEBIT,DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT,CHR_REMARK,CHR_PAYEMENTCOLLECTEDBY,CHR_CHKDATE,CHR_USRNAME, ";
              asql = String.valueOf(asql) + "  DT_UPDATEDATE,CHR_UPDATESTATUS,INT_DEPOSITID,INT_TRANSACTIONID,INT_TRANSACTIONTYPE  )";
              asql = String.valueOf(asql) + " VALUES   ";
              asql = String.valueOf(asql) + "( ?,?,?,";
              asql = String.valueOf(asql) + " ?,?,?,DATE(NOW()),";
              asql = String.valueOf(asql) + " ?,?,?,?,?,?,?, ";
              asql = String.valueOf(asql) + "  DATE(NOW()),'Y',?,?,? )";
              apstm = con.prepareStatement(asql);
              apstm.setString(1, branchid);
              apstm.setString(2, customerid);
              apstm.setString(3, salesOrderId);
              apstm.setString(4, payment[0]);
              apstm.setString(5, Bank);
              apstm.setString(6, Challanno);
              apstm.setString(7, salesAmount);
              apstm.setString(8, Paid);
              apstm.setString(9, ""+bal);
              apstm.setString(10, remarks);
              apstm.setString(11, ref);
              apstm.setString(12, DateUtil.FormateDateSQL(chequeDate));
              apstm.setString(13, (String)object);
              apstm.setString(14, creditto);
              apstm.setString(15, transactionid);
              apstm.setString(16, transactiontype);
              System.out.println(""+apstm);
              apstm.execute();
              apstm.close();
              String paymentid = CommonFunctions.QueryExecute(" SELECT MAX(INT_PAYMENTID) FROM inv_t_customersalespayment")[0][0];
              String rowid = request.getParameter("checkboxs" + u);
              asql = "UPDATE inv_t_paymentcommitment SET INT_PAYMENTID=?,DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,";
              asql = String.valueOf(asql) + " CHR_PAYMENTFLAG='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE CHR_INVOICETYPE ='C' AND INT_PAYMENTCOMMITMENTID=? AND ";
              asql = String.valueOf(asql) + " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
              apstm = con.prepareStatement(asql);
              apstm.setString(1, paymentid);
              apstm.setString(2, paymentDate);
              apstm.setString(3, Paid);
              apstm.setString(4, auserid);
              apstm.setString(5, rowid);
              apstm.setString(6, salesOrderId);
              System.out.println(""+apstm);
              apstm.execute();
              apstm.close();
              asql = "update  inv_t_customersalesorder   SET CHR_PAYMENTSTATUS='P'  where CHR_INVOICENO='" + salesOrderId + "'";
              apstm = con.prepareStatement(asql);
              System.out.println(""+apstm);
              apstm.execute();
              apstm.close();
              divisionid = CommonFunctions.QueryExecute("SELECT INT_DIVIID from inv_t_directsales WHERE  CHR_SALESNO ='" + salesOrderId + "'")[0][0];
              String[][] cpodata = CommonFunctions.QueryExecutecon(con, " SELECT CHR_CPONUMBER FROM inv_t_directsales WHERE CHR_ROOT ='C' AND  CHR_SALESNO ='" + salesOrderId + "' ");
              String cponumber = "";
              boolean cpoflag = false;
              if (cpodata.length > 0) {
                cponumber = cpodata[0][0];
                cpoflag = true;
              } 
              if (bal == 0) {
                asql = "update inv_t_directsales SET CHR_PAYMENTSTATUS='Y'  where CHR_SALESNO='" + salesOrderId + "'";
                apstm = con.prepareStatement(asql);
                System.out.println(""+apstm);
                apstm.execute();
                apstm.close();
                if (cpoflag) {
                  asql = "UPDATE  inv_t_customersalesorder SET INT_PROGRESSBAR = 95 WHERE CHR_SALESORDERNO=?";
                  apstm = con.prepareStatement(asql);
                  apstm.setString(1, cponumber);
                  System.out.println(""+apstm);
                  apstm.execute();
                  apstm.close();
                } 
              } else if (bal > 0) {
                if (payType.equals("Direct")) {
                  asql = "update inv_t_directsales SET CHR_PAYMENTSTATUS='P'  where CHR_SALESNO='" + salesOrderId + "'";
                  apstm = con.prepareStatement(asql);
                  System.out.println(""+apstm);
                  apstm.execute();
                  apstm.close();
                  String newcomitmentdate = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(DT_COMMITMENTDATE, INTERVAL 7 DAY),'%Y-%m-%d') FROM inv_t_paymentcommitment  WHERE INT_PAYMENTCOMMITMENTID =" + rowid)[0][0];
                  asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DT_COMMITMENTDATE,DOU_COMMITMENTAMOUNT,CHR_STATUS) ";
                  asql = String.valueOf(asql) + " VALUES(?,?,?,?,?,'Y')";
                  apstm = con.prepareStatement(asql);
                  apstm.setString(1, salesOrderId);
                  apstm.setString(2, "C");
                  apstm.setString(3, salesAmount);
                  apstm.setString(4, newcomitmentdate);
                  apstm.setString(5, ""+bal);
                  System.out.println(""+apstm);
                  apstm.execute();
                  apstm.close();
                  asql = " UPDATE inv_t_directsales SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT+1) WHERE CHR_SALESNO =? ";
                  apstm = con.prepareStatement(asql);
                  apstm.setString(1, salesOrderId);
                  System.out.println(""+apstm);
                  apstm.execute();
                  apstm.close();
                } 
                if (cpoflag) {
                  asql = "UPDATE  inv_t_customersalesorder SET INT_PROGRESSBAR = 95 WHERE CHR_SALESORDERNO=?";
                  apstm = con.prepareStatement(asql);
                  apstm.setString(1, cponumber);
                  System.out.println(""+apstm);
                  apstm.execute();
                  apstm.close();
                } 
              } 
              PaymentMail.sendSalesPaymentAddMail(branchid, divisionid, salesOrderId, Path);
            } 
          } 
        } 
        con.close();
        
        
        System.out.println("pagerepeat============>"+pagerepeat);
        System.out.println("salesnumberids============>"+salesnumberids);
        if(pagerepeat.equalsIgnoreCase("Y")) {
        	/*request.setAttribute("To", salesnumberids.split(","));
        	request.setAttribute("repeatsalesnumber", salesnumberids);
        	request.setAttribute("reqpagerepeat", pagerepeat);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Smart Inventory/MultiPaymentsresponse.jsp?reqpagerepeat="+pagerepeat+"&repeatsalesnumber="+salesnumberids);
            dispatcher.forward(request, response);*/
            response.sendRedirect("Smart Inventory/MultiPaymentsresponse.jsp?reqpagerepeat="+pagerepeat+"&repeatsalesnumber="+salesnumberids);
            
        }
        else
        {
        	 response.sendRedirect("Smart Inventory/InventoryMains.jsp");
        }
       
        
        
      } 
    } catch (Exception e) {
      request.setAttribute("error", e.getMessage());
      RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
      dispatchers.forward((ServletRequest)request, (ServletResponse)response);
    } 
  }
}
