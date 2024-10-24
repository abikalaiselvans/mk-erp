package com.my.org.erp.SmartInventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class VendorPOAutomate 
{
	public static void vendorPORaised(String pr,Connection con ,HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			String sql="";
			HttpSession session=request.getSession();			
			String branchid = session.getAttribute("INVBRANCH").toString();
			String userid=""+session.getAttribute("USRID");	
			sql = " SELECT b.INT_VENDORID,SUM(DOU_PURCHASEPRICE) ";
			sql = sql + " FROM inv_t_purchaserequest a, inv_t_purchaserequestitem b ";
			sql = sql + " WHERE a.CHR_POREQUESTNO = b.CHR_POREQUESTNO ";
			sql = sql + " AND a.CHR_POREQUESTNO =  '"+pr+"' GROUP BY b.INT_VENDORID";
			System.out.println(sql);
			String vdata[][] = CommonFunctions.QueryExecute(sql);
			if(vdata.length>0)
			{
				for(int u=0;u<vdata.length;u++)
				{
					sql = " SELECT a.INT_DIVIID,b.INT_VENDORID,a.INT_PAYMENTTERMID,a.INT_BRANCHID, ";
					sql = sql + " a.CHR_POREQUESTNO,DATE(NOW()),b.CHR_TYPE,b.CHR_ITEMID,b.INT_QUANTITY, ";
					sql = sql + " b.CHR_PURCHASEWARRANTY,b.DOU_UNITPRICE,b.DOU_DISCOUNT,b.DOU_UNITDISCOUNT, ";
					sql = sql + " b.INT_P_TAXID,b.DOU_P_TAX_PERCENTAGE,b.DOU_P_TAX_AMOUNT,b.DOU_PURCHASEPRICE, ";
					sql = sql + " a.CHR_REF,b.CHR_DESC ";
					sql = sql + " FROM inv_t_purchaserequest a, inv_t_purchaserequestitem b ";
					sql = sql + " WHERE a.CHR_POREQUESTNO = b.CHR_POREQUESTNO ";
					sql = sql + " AND b.INT_VENDORID = "+vdata[u][0];
					sql = sql + " AND a.CHR_POREQUESTNO =  '"+pr+"' ";
					System.out.println(sql);
					String pdata[][] = CommonFunctions.QueryExecute(sql);
					if(pdata.length>0)
					{
						//Insert the Purchase order
						String ponumber=InventoryInvoiceFunctions.purchasePONumberGet(""+session.getAttribute("INVSTATE"));
						String dt =DateUtil.getCurrentDateTime() ;
						String field="(INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE ,DAT_REQUESTDATE, " +
						" INT_ADDRESSID1,INT_ADDRESSID2,INT_ONHOLD,INT_CONDITIONID,INT_PAYMENTTERMID,CHR_DES,CHR_REF ,CHR_DISCOUNT, " +
						" INT_TAXID,DOU_AMOUNT,DOU_TAXAMOUNT , DOU_FRIEGHT_CHARGE, " +
						" DOU_TOTALAMOUNT,INT_PURCHASESTATUS, " +
						" CHR_PAYMENTSTATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,  INT_DIVIID ,CHR_POREQUESTNO)";
						sql = " INSERT INTO  inv_t_vendorpurchaseorder  "+field+" VALUES ";
						sql = sql+" (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  ) ";
						PreparedStatement ps=con.prepareStatement(sql);
						ps.setString(1, branchid);
						ps.setString(2, ponumber);
						ps.setString(3, pdata[0][1]);
						ps.setString(4, DateUtil.getCurrentDate());
						ps.setString(5, DateUtil.getCurrentDate());
						ps.setString(6, branchid );
						ps.setString(7, branchid);
						ps.setString(8, "1");//On hold
						ps.setString(9, "1");//	Payment Mode
						ps.setString(10, pdata[0][2]); //Payment Terms
						ps.setString(11, "Automatic");//Description 
						ps.setString(12, pdata[0][17]);
						ps.setString(13, "0");//Total Discount
						ps.setString(14, "5");//Tax
						ps.setString(15, vdata[u][1]);// Total
						ps.setString(16, "0");//taxamount
						ps.setString(17, "0" );//Frieight charge
						ps.setString(18, vdata[u][1]);//NetTotal
						ps.setInt(19, 0);
						ps.setString(20, "N");
						ps.setString(21, userid);
						ps.setString(22, dt);
						ps.setString(23, "Y");
						ps.setString(24, pdata[0][0]);
						ps.setString(25, pr);
						System.out.println(""+ps);
						ps.execute();
						
						ps=con.prepareStatement("  SELECT FUN_INV_PURCHASEORDER_NUMBER_INSERT(?) ");
						ps.setString(1,""+session.getAttribute("INVSTATE"));
						ps.execute();
						ps.close();
						for(int i=0;i<pdata.length;i++)
						{
							
							//Insert the purchase order item
							sql = "INSERT INTO  inv_t_vendorpurchaseorderitem ( "; 
							sql = sql + " INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE, ";
							sql = sql + " CHR_DESC,INT_QUANTITY,INT_WARRANTY, ";
							sql = sql + " DOU_UNITPRICE,CHR_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE, ";
							sql = sql + " DOU_TAX_AMOUNT,DOU_TOTAL, ";
							sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
							sql = sql + " ) ";
							sql = sql + " VALUES (";
							sql = sql + " ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ";
							sql = sql + " )";
							ps = con.prepareStatement(sql);
							ps.setString(1,branchid);
							ps.setString(2,ponumber);
							ps.setString(3,pdata[i][7]);//pcode
							ps.setString(4,pdata[i][6]);//itype
							ps.setString(5,pdata[i][18]);//description
							ps.setString(6,pdata[i][8]);//quantity
							ps.setString(7,pdata[i][9]);//warranty
							ps.setString(8,pdata[i][10]);//unit price
							ps.setString(9,pdata[i][11]);//discount
							ps.setString(10,pdata[i][12]);//unitdiscount
							ps.setString(11,pdata[i][13]);//tax
							ps.setString(12,pdata[i][14]);//taxpercentage
							ps.setString(13,pdata[i][15]);//taxamount
							ps.setString(14,pdata[i][16]);//total
							ps.setString(15,userid);
							System.out.println(""+ps);
							ps.execute();
 						}
 					}
 				}
			}	
  		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static void vendorPODeleteAfterPRModified(String prnumber,Connection con ,PreparedStatement apstm, HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			String sql ="";
			sql = "SELECT  CHR_PURCHASEORDERNO FROM inv_t_vendorpurchaseorder WHERE CHR_POREQUESTNO='"+prnumber+"'";
			String data[][] = CommonFunctions.QueryExecutecon(con, sql);
			
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					System.out.println();
					sql = "DELETE FROM inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO =? ";
					apstm = con.prepareStatement(sql);
					apstm.setString(1, data[u][0]);
					System.out.println(""+apstm);
					apstm.execute();  
					
					sql = "DELETE FROM inv_t_vendorpurchaseorder WHERE CHR_PURCHASEORDERNO =? ";
					apstm = con.prepareStatement(sql);
					apstm.setString(1, data[u][0]);
					System.out.println(""+apstm);
					apstm.execute();  
					
					
					/*sql = "DELETE FROM inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO ='"+data[0][0]+"' ";
					CommonFunctions.Execute(sql);
					
					sql = "DELETE FROM inv_t_vendorpurchaseorder WHERE CHR_PURCHASEORDERNO ='"+data[0][0]+"' ";
					CommonFunctions.Execute(sql);*/
					 
				}
			}

		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
}
