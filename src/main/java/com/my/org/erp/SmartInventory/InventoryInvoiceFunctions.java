package com.my.org.erp.SmartInventory;

import java.sql.Connection;
import java.util.Arrays;

import DBConnection.DBCon;

import com.my.org.erp.common.CommonFunctions;
 
public class InventoryInvoiceFunctions 
{
	
	
	public static String AccountYear() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql =" select month(now())";
			String months[][] =CommonFunctions.RecordSetArray(co,sql);
			int month = Integer.parseInt(months[0][0]);
			if(month<4)
				sql = "select (year(now())-1)";
			else
				sql = "select year(now())";
			String accountyear="";
			String years[][] =CommonFunctions.RecordSetArray(co,sql);
			int year = Integer.parseInt(years[0][0]);
			int year1= year+1;
			accountyear=((""+year).substring(2))+"-"+((""+year1).substring(2));
			return accountyear;
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	public static String accountYear() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql =" select month(now())";
			String months[][] =CommonFunctions.RecordSetArray(co,sql);
			int month = Integer.parseInt(months[0][0]);
			if(month<4)
				sql = "select (year(now())-1)";
			else
				sql = "select year(now())";
			String accountyear="";
			String years[][] =CommonFunctions.RecordSetArray(co,sql);
			int year = Integer.parseInt(years[0][0]);
			int year1= year+1;
			accountyear=((""+year) )+""+((""+year1).substring(2));
			return accountyear;
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	public static String invoiceMonth() 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("SELECT if(MONTH(NOW()) <10,(concat('0',MONTH(NOW()))),(MONTH(NOW())))")[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	
	public static String invoiceLocation(String officeid) 
	 {
		try 
	 	{
			 
			String sql =" SELECT  CHR_OFFICESHORTNAME  FROM  com_m_office  WHERE INT_OFFICEID="+officeid;
			String Officename[][] =CommonFunctions.QueryExecute(sql);
			return Officename[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage()); 
	 	}
	 	return null;
	 }
	
	
	
	
	

	public static String invoiceDivision(String divisionid) 
	 {
		try 
	 	{
			String sql =" SELECT CHR_DIVISHORTCODE FROM inv_m_division WHERE INT_DIVIID="+divisionid;
			String Officename[][] =CommonFunctions.QueryExecute(sql);
			return Officename[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	
	
	public static String purchasePONumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_PURCHASEID)+1),'1')   FROM inv_m_vendorpogenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
		 
			
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	
	public static String directPurchasePONumber() 
	 {
		try 
	 	{

			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_PURCHASEID)+1),'1')   FROM inv_m_pogenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	 
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	
	
	//Direct Sales
	public static String directSalesinvoiceNumber(String inventoryState) 
	 {
		try 
	 	{
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_INVOICEID)+1),'1')   FROM inv_m_invoicegenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	public static String  directSalesinvoiceNumberInsert(String inventoryState) 
	 {
		try 
	 	{
			return " INSERT INTO inv_m_invoicegenerate VALUES ("+InventoryInvoiceFunctions.directSalesinvoiceNumber(inventoryState)+")";
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 	
	 }
	
	
	
	public static String quotationeNumber() 
	 {
		try 
	 	{
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_QUOTATIONID)+1),'1')   FROM inv_m_quotationgenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	 
			 
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	public static String sspareNumber() 
	 {
		try 
	 	{
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_DEMANID)+1),'1')   FROM inv_ss_sparedemand)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	public static String sspareIssueNumber() 
	 {
		try 
	 	{
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_ISSUEID)+1),'1')   FROM inv_ss_t_sparedemandissue)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	public static String spareNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_DEMANID)+1),'1')   FROM inv_t_sparedemand)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	
	 
			 
			 
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	public static String serviceBillNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_SERVICEBILLID)+1),'1')   FROM inv_m_servicebillgenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	
 
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	
	
	public synchronized static String purchaseRequestBillNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_PURCHASEREQUESTID)+1),'1')   FROM inv_m_purchaserequestnogenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	
 			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	public static String sparePurchaseNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_SPAREID)+1),'1')   FROM inv_m_sparegenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	
 	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	 
 
	public static String directDCNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
					"(MAX(INT_DIRECT_DCID)+1),'1')   FROM inv_m_directdcgenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
 	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	public static String deliverychallanNumber() 
	 {
		try 
	 	{
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ,(MAX(INT_DCNUMBER)+1),'1')   FROM inv_t_deliverychallangenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	public static String stockTransferNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_TRANSFERID)+1),'1')   FROM inv_m_stocktransfergenerate)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
 	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	public static String purchaseReturnNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_ID)+1),'1')   FROM inv_t_vendorgoodsreturn)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
 			 
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	public static String salesReturnNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_ID)+1),'1')   FROM inv_t_customersalesreturn)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
 			 
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	public static String advanceNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_ADVANCEID)+1),'1')   FROM inv_t_advancepayment)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
 			 
			 
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	public static String emdNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_EMDID)+1),'1')   FROM inv_t_emd_informations)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
 	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	//DIRECT PURCHASE NUMBER GET
	public static String directPurchaseNumberGet(String state,String office, String division) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_PURCHASENUMBER('"+state+"','"+office+"','"+division+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	//PURCHASE REQUEST NUMBER GET
	public static String directPurchaseRequestGet(String office, String division) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_PURCHASE_REQUEST_NUMBER('"+office+"' ,'"+division+"') ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	//DIRECT SALE INVOICE NUMBER GET
	public static String directSalesNumberGet(String branchid, String state, String officeid,String divisionid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_SALESNUMBER('"+branchid+"', '"+state+"','"+officeid+"','"+divisionid+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println("directSalesNumberGet ERROR : branchid:"+branchid+ " state:"+state + " officeid :" + officeid +" divisionid:"+ divisionid+ " "+e.getMessage());
	 	}
	 	return null;
	 }
	
	

	//DIRECT SERVICE BILLING NUMBER GET
	public static String serviceBillingNumberGet(String state,String officeid,String divisionid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_SERVICEBILLNUMBER('"+state+"','"+officeid+"','"+divisionid+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	

	//DIRECT SERVICE BILLING NUMBER GET
	public static String directDeliveryChallanGet(String state) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_DELIVERYCHALLAN_NUMBER('"+state+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	//STOCK TRANSFER  NUMBER GET
	public static String stockTransferNumberGet(String fromBranch, String toBranch) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_STOCK_TRANSFER_NUMBER("+fromBranch+","+toBranch+" ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	//EMD NUMBER GET
	public static String emdNumberGet(String office, String division) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_EMD_NUMBER('"+office+"','"+division+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	 
	
	//VENDOR PURCHSE ORDER NUMBER GET
	public static String purchasePONumberGet(String state) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_PURCHASEORDER_NUMBER('"+state+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	//PROFORMA  NUMBER GET
	public static String profprmaNumberGet(String state,String officeid,String divisionid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_GET_PROFORMA_NUMBER('"+state+"' ,'"+officeid+"','"+divisionid+"') ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	//CUSTOMER QUOTATION NUMBER GET
	public static String customerQuotationNumberGet(String state,String officeid,String divisionid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_GET_QUOTATION_NUMBER('"+state+"' ,'"+officeid+"','"+divisionid+"') ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	//CUSTOMER SALE ORDER NUMBER GET
	public static String customerSaleorderNumberGet(String state,String officeid, String divisionid ) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_CUSTOMER_SALEORDER_NUMBER('"+state+"'  ,'"+officeid+"','"+divisionid+"') ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	//DIRECT STOCKADJUSTMENT NUMBER GET
	public static String directStockAdjustmentGet( ) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_STOCKADJUSTMENT_NUMBER( ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	//SERVICE BILL  NUMBER GET
	public static String servicePONumberGet(String office, String division) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_SERVICEPO_NUMBER('"+office+"','"+division+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	 
	
	
	//SCRAB NUMBER GET
	public static String scrabnumberGet(String state) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_SCRAB_NUMBER('"+state+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	
	
	//ADVANCE NUMBER GET
	public static String advanceNumberGet(String state, String officeid,String divisionid) 
	 {
		try 
	 	{
			return CommonFunctions.QueryExecute("  SELECT FUN_INV_DIRECT_ADVANCENUMBER('"+state+"','"+officeid+"','"+divisionid+"' ) ")[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	//CPO READY TO BILL
	public static String CPOReasdytoBill(String cponumber) 
	 {
		String flagchar="";
		try 
	 	{
			 String sql = "";
			 String collectionflag="";
			 
			 
			 /*	
			  
			 SELECT  (a.INT_QUANTITY-a.INT_BILLEDQUANTITY),
			 if( a.CHR_TYPE ='I' , (SELECT FUN_INV_BRANCH_ITEM_STOCK(a.CHR_ITEMID,a.INT_BRANCHID)  ) ,    
			      if(
			            ( (SELECT sa4.CHR_PTYPE FROM inv_m_produtlist sa4 WHERE sa4.CHR_PRODUCTID =a.CHR_ITEMID)= 'S'),  
			                      (SELECT FUN_INV_BRANCH_CONSUMABLE_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ), 
			                      (SELECT FUN_INV_BRANCH_PRODUCT_STOCK(a.CHR_ITEMID,a.INT_BRANCHID)) 
			             )
			         )  availablestock 
			                   
			                    FROM inv_t_customersalesorderitem a 
			                     WHERE a.CHR_SALESORDERNO = 'TN/CPO/21/003237/CHE/DAC'
			 */  
			 
			 sql = sql +" SELECT  ";  
			 sql = sql +" IF(  ";
			 sql = sql +" (a.INT_QUANTITY-a.INT_BILLEDQUANTITY) ";
			 sql = sql +" <= ";
			 sql = sql +" if( a.CHR_TYPE ='I' ,   ";
			 sql = sql +" (SELECT FUN_INV_BRANCH_ITEM_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ) ,    ";
			 sql = sql +" if(((SELECT sa4.CHR_PTYPE FROM inv_m_produtlist sa4 WHERE sa4.CHR_PRODUCTID =a.CHR_ITEMID)= 'S'), ";  
			 sql = sql +" (SELECT FUN_INV_BRANCH_CONSUMABLE_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ), ";  
			 sql = sql +" (SELECT FUN_INV_BRANCH_PRODUCT_STOCK(a.CHR_ITEMID,a.INT_BRANCHID))) ";   
			 sql = sql +"  )   ";
			 sql = sql +" ,'TRUE','FALSE'  ";
			 sql = sql +" )stockavilable ";
			 sql = sql +" FROM inv_t_customersalesorderitem a ";
			 sql = sql +" WHERE a.CHR_SALESORDERNO = '"+cponumber+"'";
			// System.out.println();
			 //System.out.println(sql);
			 String data[][] = CommonFunctions.QueryExecute(sql);
			 if(data.length>0)
			 {
				 for(int u=0;u<data.length;u++)
					 collectionflag = collectionflag+data[u][0]+","; 
				 collectionflag = collectionflag.substring(0,collectionflag.length()-1);
				 String f[]   = collectionflag.split(",");
				 boolean f1 = Arrays.asList(f).contains("TRUE");
				 boolean f2 = Arrays.asList(f).contains("FALSE");
				 if(f1 && f2)
					 flagchar="P";
				 else if(f1 && !f2)
					 flagchar="B";
				 else  
					 flagchar="W";
			 }
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
		return flagchar;
	 	 
	 }
}
