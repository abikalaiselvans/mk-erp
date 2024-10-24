package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class InventorySettingActionHandler extends AbstractActionHandler{
	
	String compId;
	String branId;
	
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try{
				String action=request.getParameter("actionS");
				//System.out.println("Action In Invetory Settings :"+action);
				if("INVbasicSetting".equals(action)){					
					
					InventorySetting invSetting=new InventorySetting();
					Map map=request.getParameterMap();
					BeanUtils.populate(invSetting,map);
					
					compId=request.getParameter("company");
					branId=request.getParameter("branchId");
					String sql="Select count(*) from inv_m_basicsettings where INT_COMPANYID="+compId+" AND INT_BRANCHID="+branId;
					if(CommonInfo.RecordExist(con, sql))
						updateBasicSetting(invSetting,request,response);
					else
						addBasicSetting(invSetting,request,response);
					//System.out.println("Purchase Order :"+invSetting.getPurchaseCode());
					//System.out.println("Purchase No :"+invSetting.getPurchaseNo());					
					con.close();    
					response.sendRedirect("Smart Inventory/InventorySettings.jsp");
				}
			} catch (Exception e) {
				 System.out.println(e.getMessage());
				response.sendRedirect("error.jsp?error="+e.getMessage());
			}
	}
	private void updateBasicSetting(InventorySetting invSetting, HttpServletRequest request, HttpServletResponse response) throws IOException {
		try{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");		
			//String branchId=""+session.getAttribute("BRANCHID");
			String id=request.getParameter("settingId");
			String year=request.getParameter("Year");
			String sql="UPDATE inv_m_basicsettings SET "+
			"CHR_VENDOR_PURCHASE_CODE=?,INT_VENDOR_PURCHASE_NO=?,"+
			"CHR_VENDOR_GOODSRECEIVE_CODE=?,INT_VENDOR_GOODSRECEIVE_NO=?,"+
			"CHR_VENDOR_GOODSRETURN_CODE=?,INT_VENDOR_GOODSRETURN_NO=?,"+
			"CHR_CUST_QUOTATION_CODE=?,INT_CUST_QUOTATION_NO=?,"+
			"CHR_CUST_SALESORDER_CODE=?,INT_CUST_SALESORDER_NO=?,"+
			"CHR_CUST_DELIVERY_CODE=?,INT_CUST_DELIVERY_NO=?,"+
			"CHR_CUST_INVOICE_CODE=?,INT_CUST_INVOICE_NO=?,"+
			"CHR_CUST_CASHSALE_CODE=?,INT_CUST_CASHSALE_NO=?,"+
			"CHR_CUST_SALESRETURN_CODE=?,INT_CUST_SALESRETURN_NO=?,"+
			"CHR_DIRECT_VENDORPO_CODE=?,INT__DIRECT_VENDORPO_NO=?,"+
			"CHR_DIRECT_CUSTSALES_CODE=?,INT__DIRECT_CUSTSALES_NO=?,"+
			"INT_YEAR=?,CHR_USRNAME=? WHERE  INT_ID=? AND INT_COMPANYID=? AND INT_BRANCHID=?";
						
			PreparedStatement ps=con.prepareStatement(sql);

			ps.setString(1, invSetting.getPurchaseCode());
			ps.setInt(2, invSetting.getPurchaseNo());
			ps.setString(3, invSetting.getGoodsReceiveCode());
			ps.setInt(4, invSetting.getGoodsReceiveNo());
			ps.setString(5, invSetting.getGoodsReturnCode());
			ps.setInt(6, invSetting.getGoodsReturnNo());
			ps.setString(7, invSetting.getQuotationCode());
			ps.setInt(8, invSetting.getQuotationNo());
			ps.setString(9, invSetting.getSalesOrderCode());
			ps.setInt(10, invSetting.getSalesOrderNo());
			ps.setString(11, invSetting.getDeliveryChallanCode());
			ps.setInt(12, invSetting.getDeliveryChallanNo());
			ps.setString(13, invSetting.getInvoiceCode());
			ps.setInt(14, invSetting.getInvoiceNo());
			ps.setString(15, invSetting.getCashSaleCode());
			ps.setInt(16, invSetting.getCashSaleNo());
			ps.setString(17, invSetting.getSalesReturnCode());
			ps.setInt(18, invSetting.getSalesReturnNo());
			ps.setString(19, invSetting.getDirectPurchaseCode());
			ps.setInt(20, invSetting.getDirectPurchaseNo());
			ps.setString(21, invSetting.getDirectSalesCode());
			ps.setInt(22, invSetting.getDirectSalesNo());
			ps.setString(23, year);
			ps.setString(24, userId);
			ps.setString(25, id);
			ps.setString(26, compId);
			ps.setString(27, branId);
	
			ps.execute();
		}
		catch(Exception e){
			 System.out.println(e.getMessage());
			response.sendRedirect("error.jsp?error="+e.getMessage());			
		}
	}
	private void addBasicSetting(InventorySetting invSetting, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		try{			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");		
			//String branchId=""+session.getAttribute("BRANCHID");
			String sql="";
			sql="SELECT MAX(INT_ID) FROM inv_m_basicsettings";
			int maxid=CommonFunction.intRecordCount(con, sql)+1;
			String year=request.getParameter("Year");
			sql="INSERT INTO inv_m_basicsettings(INT_ID,INT_COMPANYID,INT_BRANCHID, "+
			"CHR_VENDOR_PURCHASE_CODE,INT_VENDOR_PURCHASE_NO,"+
			"CHR_VENDOR_GOODSRECEIVE_CODE,INT_VENDOR_GOODSRECEIVE_NO,"+
			"CHR_VENDOR_GOODSRETURN_CODE,INT_VENDOR_GOODSRETURN_NO,"+
			"CHR_CUST_QUOTATION_CODE,INT_CUST_QUOTATION_NO,"+
			"CHR_CUST_SALESORDER_CODE,INT_CUST_SALESORDER_NO,"+
			"CHR_CUST_DELIVERY_CODE,INT_CUST_DELIVERY_NO,"+
			"CHR_CUST_INVOICE_CODE,INT_CUST_INVOICE_NO,"+
			"CHR_CUST_CASHSALE_CODE,INT_CUST_CASHSALE_NO,"+
			"CHR_CUST_SALESRETURN_CODE,INT_CUST_SALESRETURN_NO,"+
			"CHR_DIRECT_VENDORPO_CODE,INT__DIRECT_VENDORPO_NO,"+
			"CHR_DIRECT_CUSTSALES_CODE,INT__DIRECT_CUSTSALES_NO,"+
			"INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) "+
			"values(?,?,?,?,?," +
			"?,?,?,?," +
			"?,?,?,?," +
			"?,?,?,?," +
			"?,?,?,?," +
			"?,?,?,?," +
			"?,?,?,?)";			
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, maxid);
			ps.setString(2, compId);
			ps.setString(3, branId);
			ps.setString(4, invSetting.getPurchaseCode());
			ps.setInt(5, invSetting.getPurchaseNo());
			ps.setString(6, invSetting.getGoodsReceiveCode());
			ps.setInt(7, invSetting.getGoodsReceiveNo());
			ps.setString(8, invSetting.getGoodsReturnCode());
			ps.setInt(9, invSetting.getGoodsReturnNo());
			ps.setString(10, invSetting.getQuotationCode());
			ps.setInt(11, invSetting.getQuotationNo());
			ps.setString(12, invSetting.getSalesOrderCode());
			ps.setInt(13, invSetting.getSalesOrderNo());
			ps.setString(14, invSetting.getDeliveryChallanCode());
			ps.setInt(15, invSetting.getDeliveryChallanNo());
			ps.setString(16, invSetting.getInvoiceCode());
			ps.setInt(17, invSetting.getInvoiceNo());
			ps.setString(18, invSetting.getCashSaleCode());
			ps.setInt(19, invSetting.getCashSaleNo());
			ps.setString(20, invSetting.getSalesReturnCode());
			ps.setInt(21, invSetting.getSalesReturnNo());
			ps.setString(22, invSetting.getDirectPurchaseCode());
			ps.setInt(23, invSetting.getDirectPurchaseNo());
			ps.setString(24, invSetting.getDirectSalesCode());
			ps.setInt(25, invSetting.getDirectSalesNo());
			ps.setString(26, year);
			ps.setString(27, userId);
			ps.setString(28,DateUtil.getCurrentDateTime() );
			ps.setString(29, "Y");	
			ps.execute();
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}	
}

