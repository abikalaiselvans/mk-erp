package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.bean.inventory.Purchase; 
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class PurchaseOrderActionHandler extends AbstractActionHandler
{

/*
 * 
 * This method is used for inserting the individual quantit in a database
 */	
private static 	String aauserid="";
private static 	String abranchid="";
private static 	String sql="";

public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String ponumber ,Connection con, PreparedStatement apstm )throws ServletException, IOException 
{
	try 
	{
		 
		sql="";
		String param[] = request.getParameter("param").split(",");
		String itype="";
		for(int p=0;p<param.length; p++)
		{
			String e =""+request.getParameter("itype"+param[p].trim());
			if(e.equals("1") || e.equals("I") )
				itype="I";
			if(e.equals("2")|| e.equals("P") )
				itype="P";
			 
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
			apstm = con.prepareStatement(sql);
			apstm.setString(1,abranchid);
			apstm.setString(2,ponumber);
			apstm.setString(3,request.getParameter("item"+param[p].trim()));
			apstm.setString(4,itype);
			apstm.setString(5,request.getParameter("desc"+param[p].trim()));
			apstm.setString(6,request.getParameter("qty"+param[p].trim()));
			apstm.setString(7,request.getParameter("warranty"+param[p].trim()));
			apstm.setString(8,request.getParameter("uprice"+param[p].trim()));
			apstm.setString(9,request.getParameter("discount"+param[p].trim()));
			apstm.setString(10,request.getParameter("unitdiscount"+param[p].trim()));
			apstm.setString(11,request.getParameter("stax"+param[p].trim()));
			apstm.setString(12,request.getParameter("staxpercentage"+param[p].trim()));
			apstm.setString(13,request.getParameter("staxamount"+param[p].trim()));
			apstm.setString(14,request.getParameter("total"+param[p].trim()));
			apstm.setString(15,aauserid);
			System.out.println(""+apstm);
			apstm.execute();
			
			/*
			sql = "";
			sql = "INSERT INTO inv_t_vendorgoodsreceived ( ";
			sql =sql + " INT_BRANCHID,INT_DIVIID,CHR_PURCHASEORDERNO ," ;
			sql =sql + " CHR_ITEMID,CHR_TYPE,CHR_RECEIVEDMODE,DOU_UNITPRICE," ;
			sql =sql + " CHR_WARRANTY,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  " ;
			sql =sql + " ) VALUES ( " ;
			sql =sql + " ?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y'  " ;
			sql =sql + " )  " ;
			apstm = con.prepareStatement(sql); 
		
			for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
			{
				apstm.setString(1,abranchid);
				apstm.setString(2,request.getParameter("division"));
				apstm.setString(3,ponumber);
				apstm.setString(4,request.getParameter("item"+param[p].trim()));
				apstm.setString(5,itype);
				apstm.setString(6, "P");
				apstm.setString(7,request.getParameter("uprice"+param[p].trim()));
				apstm.setString(8,request.getParameter("warranty"+param[p].trim()));
				apstm.setString(9,aauserid);
				System.out.println(""+apstm);
				apstm.addBatch();
			}
			apstm.executeBatch();
			*/
			
			
			apstm.close();
			
		}
	} 
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 

	}
	 
}


public static void  itemUpdate(HttpServletRequest request,HttpServletResponse response, String ponumber ,Statement st )throws ServletException, IOException 
{
	try 
	{
		String field="";
		String sql="";
		HttpSession session=request.getSession();			
		String userId=""+session.getAttribute("USRID");
		String branchid = session.getAttribute("BRANCHID").toString();
		String param[] = request.getParameter("param").split(",");
		String itype="";
		int rowmax=0;
		for(int p=0;p<param.length; p++)
		{
			itype =""+request.getParameter("itype"+param[p].trim());
			if(itype.equals("1") )
				itype="I";
			if(itype.equals("2") )
				itype="P";
			rowmax=0;
			sql = "SELECT MAX(INT_ID) FROM inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO='"+ponumber+"'";
			rowmax = CommonFunction.intMaxCount(sql)+1;
			field ="INT_ID,INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE," +
					"CHR_DESC,INT_QUANTITY," +
			"DOU_UNITPRICE,CHR_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL," +
			"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS";
			sql=" INSERT INTO  inv_t_vendorpurchaseorderitem (" +field+" ) VALUES (";
			sql = sql +rowmax +" , ";
			sql = sql +Integer.parseInt(branchid)+" , ";
			sql = sql +"'"+ponumber+"' , ";
			sql = sql +"'"+request.getParameter("item"+param[p].trim())+"' , ";
			sql = sql +"'"+itype+"' , ";
			sql = sql +"'"+request.getParameter("desc"+param[p].trim())+"' , ";
			sql = sql +Integer.parseInt(request.getParameter("qty"+param[p].trim()))+" , ";
			sql = sql +Double.parseDouble(request.getParameter("uprice"+param[p].trim()))+" , ";
			sql = sql +"'"+request.getParameter("discount"+param[p].trim())+"' , ";
			sql = sql +Double.parseDouble(request.getParameter("unitdiscount"+param[p].trim()))+" , ";
			sql = sql +Double.parseDouble(request.getParameter("total"+param[p].trim()))+" , ";
			sql = sql +"'"+userId+"' , ";
			sql = sql +" now() , 'Y' ) ";
			st.execute(sql);
			for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
			{
					sql ="INSERT INTO inv_t_vendorgoodsreceived " +
							" ( INT_BRANCHID,CHR_PURCHASEORDERNO ," +
							" CHR_ITEMID,CHR_TYPE,CHR_RECEIVEDMODE,DOU_UNITPRICE,CHR_USRNAME,DT_UPDATEDATE," +
							" CHR_UPDATESTATUS ) VALUES (";
					
					sql = sql +Integer.parseInt(branchid)+" , ";
					sql = sql +"'"+ponumber+"' , ";
					sql = sql +"'"+request.getParameter("item"+param[p].trim())+"' , ";
					sql = sql +"'"+itype+"' , 'P',";
					sql = sql +""+Double.parseDouble(request.getParameter("uprice"+param[p].trim()))+" , ";
					sql = sql +"'"+userId+"' , ";
					sql = sql +" now() , 'Y' ) ";
					st.execute(sql);
			}
			
		}
	} 
	catch (Exception e) 
	{
		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    	dispatchers.forward(request, response); 

	}
	 
}
/*
 * 
 * (non-Javadoc)
 * @see com.my.org.erp.ServiceLogin.ActionHandler#handle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
 * this is the controller of this servlet
 */
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String branchid = session.getAttribute("INVBRANCH").toString();
				 
				aauserid = auserid;
				abranchid = branchid;
				if("INVPurchaseOrderAdd".equals(action))
				{
					Purchase d = new Purchase();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					String ponumber=InventoryInvoiceFunctions.purchasePONumberGet(""+session.getAttribute("INVSTATE"));
					DirectPurchaseMethod.addPurchase(ponumber,con, d, request, response);
					itemInsert(request,response,ponumber,con,apstm);
					
					String purchaserequest=request.getParameter("purchaserequest");
					String partialreceived = request.getParameter("partialreceived");
					if("Y".equals(partialreceived))
						partialreceived = "P";
					else
						partialreceived = "Y";
					asql = "UPDATE inv_t_purchaserequest SET CHR_PR_PARTIALLY_RECEIVED=? WHERE CHR_POREQUESTNO= ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,partialreceived);
					apstm.setString(2,purchaserequest);
					apstm.execute();
					apstm.close();
					
					con.close();    
					response.sendRedirect("Smart Inventory/PurchaseOrderView.jsp?ponumber="+ponumber);
				}
				else if("INVPurchaseOrderUpdate".equals(action))
				{
					
					String purchaseno = request.getParameter("ponumber");
					String ponumber =""+request.getParameter("ponumber");
					asql = " DELETE FROM  inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO = ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,purchaseno );
					apstm.execute();
					
					asql = " DELETE FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,purchaseno );
					apstm.execute();
					 
					Purchase d = new Purchase();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					DirectPurchaseMethod.addPurchaseUpdate(purchaseno,con, d, request, response);
					
					itemInsert(request,response,ponumber,con,apstm);
					con.close();    
					response.sendRedirect("Smart Inventory/PurchaseOrderUpdateView.jsp?ponumber="+purchaseno);
				}
				else if("INVPurchaseOrderDelete".equals(action))
				{
					String purchaseno[] = request.getParameterValues("ponumber");
					String purchaserequest ="";
					for(int u=0; u<purchaseno.length;u++)
					{
						asql = "SELECT CHR_POREQUESTNO FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno[u]+"'"; 
						purchaserequest= CommonFunctions.QueryExecute(asql)[0][0];
						
						
						asql = " DELETE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,purchaseno[u] );
						apstm.execute();
						
						asql = " DELETE FROM  inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO = ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,purchaseno[u] );
						apstm.execute();
						
						asql = " DELETE FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,purchaseno[u] );
						apstm.execute();
						
						asql = "UPDATE inv_t_purchaserequest SET CHR_PR_PARTIALLY_RECEIVED=? WHERE CHR_POREQUESTNO= ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"N");
						apstm.setString(2,purchaserequest);
						apstm.execute();
						 
						
	 
					}
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/Purchase Order.jsp");
				}
				else if("INVPurchaseOrderView".equals(action))
				{
					String purchaseno = request.getParameter("purchaseno");
					if("Accept".equals(request.getParameter("Submit")))
						response.sendRedirect("Smart Inventory/Purchase Order.jsp");
					if("Denied".equals(request.getParameter("Submit")))
					{
						asql = " DELETE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,purchaseno );
						apstm.execute();
						
						asql = " DELETE FROM  inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO = ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,purchaseno );
						apstm.execute();
						
						asql = " DELETE FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,purchaseno );
						apstm.execute();
						  
						con.close();   
						response.sendRedirect("Smart Inventory/Purchase Order.jsp");
					}
				}
				else if("INVPurchaseOrderEDDAdd".equals(action))
				{
					String refno= request.getParameter("refno");
					String edddt= request.getParameter("edddt");
					String memo= request.getParameter("memo");
					asql = "UPDATE inv_t_vendorpurchaseorder SET CHR_EDD_STATUS='Y', DAT_EDD=?, CHE_EDD_DESC =?";
					asql = asql + " WHERE CHR_PURCHASEORDERNO = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,DateUtil.FormateDateSQL(edddt));
					apstm.setString(2,memo);
					apstm.setString(3,refno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();   
					response.sendRedirect("Smart Inventory/Purchase Order.jsp");
				
				}
				else if("INVPurchaseOrderCancel".equals(action))
				{
					String purchaseno = request.getParameter("purchaseno");
					String reason = request.getParameter("reason");
					asql = " UPDATE   inv_t_vendorpurchaseorder SET ";
					asql = asql +" CHR_CANCEL='Y',";
					asql = asql +" CHR_CANCELDESC=?,";
					asql = asql +" CHR_CANCELID=?,";
					asql = asql +" DAT_CANCELDATE= NOW()";
					asql = asql +" WHERE CHR_PURCHASEORDERNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, reason);
					apstm.setString(2, ""+session.getAttribute("EMPID"));
					apstm.setString(3, purchaseno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();
					
					//Send a mail for cancel invoice
					String email = ""+request.getParameter("email");
					String a[] =(email+","+CommonData.mailid).split(",") ;
					com.my.org.erp.mail.Mail.SimpleHTMLMail(  a,  "CANCELL  VENDOR PURCHASE ORDER :: "+purchaseno, reason );
					
					response.sendRedirect("Smart Inventory/Purchase Order.jsp");
				}
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