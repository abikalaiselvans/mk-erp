package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class DelivaryChallanActionHandler extends AbstractActionHandler {
	static String delivId = null;

	public static void itemInsert(HttpServletRequest request,
			HttpServletResponse response, String delivaryId, String salesId,
			Statement st) throws ServletException, IOException {
		try {
			String field = "";
			String sql = "";
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			for (int p = 0; p < param.length; p++) {
				field = "INT_BRANCHID,INT_DELIVARYID,CHR_ITEMID,CHR_DESC,INT_QUANTITY,"
						+ "INT_SALESQUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,"
						+ "CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS";
				sql = " INSERT INTO inv_t_delivaryitem (" + field
						+ ") VALUES (";
				sql = sql + branchid + " , ";
				sql = sql + delivaryId + " , ";
				sql = sql + "'"	+ request.getParameter("item" + param[p].trim())+ "' , ";
				sql = sql + "'"	+ request.getParameter("desc" + param[p].trim())+ "' , ";
				sql = sql + Integer.parseInt(request.getParameter("qty"+ param[p].trim())) + " , ";
				sql = sql + Integer.parseInt(request.getParameter("sqty"+ param[p].trim())) + " , ";
				sql = sql + Double.parseDouble(request.getParameter("uprice"+ param[p].trim())) + " , ";
				sql = sql + "'"	+ request.getParameter("discount" + param[p].trim())+ "' , ";
				sql = sql + Double.parseDouble(request.getParameter("unitdiscount"+ param[p].trim())) + " , ";
				sql = sql + Double.parseDouble(request.getParameter("total"	+ param[p].trim())) + " , ";
				sql = sql + "'" + userId + "' , ";
				sql = sql + " now() , 'Y' ) ";
				st.execute(sql);
				for (int u = 0; u < Integer.parseInt(request
						.getParameter("sqty" + param[p].trim())); u++) {
					sql = "INSERT INTO inv_t_delivaryitemserial "
							+ " ( INT_BRANCHID,INT_SALESORDERID,INT_DELIVARYID,"
							+ " CHR_ITEMID,CHR_USRNAME,DT_UPDATEDATE,"
							+ " CHR_UPDATESTATUS ) VALUES (";
					sql = sql + branchid + " , ";
					sql = sql + salesId + ",";
					sql = sql + delivaryId + ",";
					sql = sql + "'"
							+ request.getParameter("item" + param[p].trim())
							+ "' , ";
					sql = sql + "'" + userId + "' , ";
					sql = sql + " now() , 'Y' ) ";
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

	public static void itemUpdate(HttpServletRequest request,
			HttpServletResponse response, String delivaryId, String salesId,
			Statement st) throws ServletException, IOException {
		try {
			
			String sql = "";
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			for (int p = 0; p < param.length; p++) {
				

				sql = " update inv_t_delivaryitem SET ";
				sql = sql 	+ " CHR_ITEMID='"	+ request.getParameter("item" + param[p].trim())+ "' , ";
				sql = sql 	+ " CHR_DESC='"		+ request.getParameter("desc" + param[p].trim())+ "' , ";
				sql = sql	+ " INT_QUANTITY="	+ Integer.parseInt(request.getParameter("qty"+ param[p].trim())) + " , ";
				sql = sql	+ " INT_SALESQUANTITY="	+ Integer.parseInt(request.getParameter("sqty"+ param[p].trim())) + " , ";
				sql = sql	+ " DOU_UNITPRICE="	+ Double.parseDouble(request.getParameter("uprice"+ param[p].trim())) + " , ";
				sql = sql 	+ " DOU_DISCOUNT='"+ request.getParameter("discount" + param[p].trim())+ "' , ";
				sql = sql	+ " DOU_UNITDISCOUNT="+ Double.parseDouble(request.getParameter("unitdiscount"+ param[p].trim())) + " , ";
				sql = sql	+ " DOU_TOTAL="	+ Double.parseDouble(request.getParameter("total"+ param[p].trim())) + " , ";				sql = sql + " CHR_USRNAME='" + userId + "'";
				sql = sql + " where INT_DELIVARYID=" + delivaryId;
				sql = sql + " AND CHR_ITEMID='"	+ request.getParameter("item" + param[p].trim()) + "'";
				
				
				st.execute(sql);
				sql = "delete from inv_t_delivaryitemserial";
				sql = sql + " WHERE INT_DELIVARYID =" + delivaryId + "";
				sql = sql + " AND CHR_ITEMID = '"
						+ request.getParameter("item" + param[p].trim()) + "'";
				
				st.execute(sql);
				for (int u = 0; u < Integer.parseInt(request
						.getParameter("sqty" + param[p].trim())); u++) {
					sql = "INSERT INTO inv_t_delivaryitemserial "
							+ " ( INT_BRANCHID,INT_SALESORDERID,INT_DELIVARYID,"
							+ " CHR_ITEMID,CHR_USRNAME,DT_UPDATEDATE,"
							+ " CHR_UPDATESTATUS ) VALUES (";
					sql = sql + branchid + " , ";
					sql = sql + salesId + ",";
					sql = sql + delivaryId + ",";
					sql = sql + "'"
							+ request.getParameter("item" + param[p].trim())
							+ "' , ";
					sql = sql + "'" + userId + "' , ";
					sql = sql + " now() , 'Y' ) ";
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

	 

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			Statement st = con.createStatement();
			String sql = "";
			if ("INVDelivaryChallanAdd".equals(action)) 
			{
				String dcnumber = request.getParameter("dcnumber");
				String deldate = request.getParameter("delDate");
				deldate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(deldate);
				String saleno = request.getParameter("salno");
				String dcparam = request.getParameter("dcparam");
				
				for(int v=1; v<=Integer.parseInt(dcparam);v++)
				{
					int dcqty =Integer.parseInt(request.getParameter("txtname"+v));
					String itmname =request.getParameter("item"+v);
					String itype =request.getParameter("itype"+v);
					sql = "";
					sql = " select INT_ID  FROM inv_t_customersalesorderitemserial ";
					sql = sql + " WHERE CHR_SALESORDERNO = '"+saleno+"'";
					sql = sql + " AND  CHR_ITEMID = '"+itmname+"'";
					sql = sql + " AND  CHR_TYPE = '"+itype+"'";
					sql = sql + " AND  isNull(CHR_DELIVERYNO)";
					String dcdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
					for(int x=0;x<dcqty;x++)
					{
						sql = "";
						sql = " UPDATE inv_t_customersalesorderitemserial SET ";
						sql = sql + " CHR_DELIVERYNO = '"+dcnumber+"' ,";
						sql = sql + " DT_DELIVERYDATE = '"+deldate+"' ";
						sql = sql + " WHERE INT_ID = "+dcdata[x][0];
						st.execute(sql);
						
					}
					//Stock Updation in Item Table
					
					sql ="SELECT count(*) FROM inv_t_stock  WHERE  AND CHR_TYPE='"+itype+"' AND CHR_ITEMID  = '"+itmname+"' AND INT_BRANCHID="+branchid;
					if(CommonInfo.RecordExist(sql))  
					{
						sql ="SELECT * FROM inv_t_stock  WHERE CHR_TYPE='"+itype+"' AND CHR_ITEMID  = '"+itmname+"' AND INT_BRANCHID="+branchid;						
						int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
						sdbrqty = sdbrqty-dcqty;
						sql = "UPDATE inv_t_stock SET ";
						sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
						sql = sql +" WHERE  CHR_TYPE='"+itype+"' AND CHR_ITEMID  = '"+itmname+"' AND INT_BRANCHID="+branchid;
						st.execute(sql);
						
					}
					 
					 
				}
				//Update delivery status 
				sql = " select count(*) from inv_t_customersalesorderitemserial";
				sql = sql +" WHERE CHR_SALESORDERNO = '"+saleno+"'";
				int totalrow = CommonFunction.intRecordCount(sql);
				if (CommonFunction.RecordExist(sql))
				{
					sql = " select count(*) from inv_t_customersalesorderitemserial";
					sql = sql +" WHERE CHR_SALESORDERNO = '"+saleno+"'";
					sql = sql +" AND  NOT isNull(CHR_DELIVERYNO) ";
					int rowexist = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
					if((rowexist > 0) &&(rowexist < totalrow))
					{
						sql =" UPDATE  inv_t_customersalesorder   SET ";
						sql = sql +" CHR_DELIVERYSTATUS ='P'  ";
						sql = sql +"  WHERE CHR_SALESORDERNO='"+saleno+"'";
						st.execute(sql);
					}
					if(rowexist == totalrow)
					{
						sql =" UPDATE  inv_t_customersalesorder   SET ";
						sql = sql +" CHR_DELIVERYSTATUS ='Y' ";
						sql = sql +"  WHERE CHR_SALESORDERNO='"+saleno+"'";
						st.execute(sql);
					}
				}
				
				con.close();    
				response.sendRedirect("Smart Inventory/DeliveryOrderSerialno.jsp?saleno="+saleno+"&dcnumber="+dcnumber+"&delDate="+deldate+"&dcparam="+dcparam);
			} 
			else if("INVDelivaryChallanAddSerial".equals(action))
			{
				
				String dcnumber = request.getParameter("dcnumber");
				String saleno = request.getParameter("salno");
				String serialparam  =request.getParameter("serialparam");
				for(int u=1; u<=Integer.parseInt(serialparam); u++)
				{
					String rowid=request.getParameter("rowid"+u);
					String serial=""+request.getParameter("serial"+u);
					String warranty=""+request.getParameter("warranty"+u);
					if(serial.equals("null"))
						serial="";
					if(warranty.equals("null"))
						warranty="";
					sql= " UPDATE  inv_t_customersalesorderitemserial   SET ";
					sql = sql + " CHR_SERIALNO ='" +serial+"', ";
					sql = sql + " CHR_WARRANTY ='" +warranty+"' ";
					sql = sql + " WHERE  INT_ID = " +Integer.parseInt(rowid);
					st.execute(sql);
					sql ="UPDATE inv_t_vendorgoodsreceived SET  CHR_FLAG ='Y' WHERE CHR_SERIALNO='"+serial+"'";
					st.execute(sql);
				}
				con.close();    
				response.sendRedirect("Smart Inventory/DeliveryOrderPrint.jsp?saleno="+saleno+"&dcnumber="+dcnumber);				
			}
			else if ("INVDelivarySerialAdd".equals(action)) {
				
				String deliveredId = "" + request.getParameter("deliveredId");
				String rlength = "" + request.getParameter("length");
				String recddate = "" + request.getParameter("deliveredDate");
				String recdby = "" + request.getParameter("receivedby");
				for (int u = 1; u <= Integer.parseInt(rlength); u++) 
				{
					String itemid = "" + request.getParameter("item" + u);
					String rowid = "" + request.getParameter("row" + u);
					String serial = "" + request.getParameter("serail" + u);
					String waranty = "" + request.getParameter("warranty" + u);
					sql = "UPDATE  inv_t_delivaryitemserial SET";
					sql = sql + " DAT_SALESDATE = '" + recddate + "' ,";
					sql = sql + " CHR_RECIVEDBY = '" + recdby + "' ,";
					sql = sql + " CHR_SERIALNO = '" + serial + "' ,";
					sql = sql + " CHR_WARRANTY = '" + waranty + "' ";
					sql = sql + " WHERE INT_DELIVARYID =" + deliveredId + "";
					sql = sql + " AND CHR_ITEMID = '" + itemid + "'";
					sql = sql + " AND INT_ID = '" + rowid + "'";
					st.execute(sql);
				}
				con.close();    
				response.sendRedirect("Smart Inventory/Delivary Challan.jsp");
			} 
			else if ("INVDelivaryChallanEdit".equals(action)) 
			{
				sql = "";
				String collectname = "";
				collectname = collectname
						+ "quoNumber,salesOrderNo,customerId,"
						+ "delivaryNO,delivaryDate,hold,billingTo,ship,shipingTo,memo,ref,totals,totaldiscount,tax,salestax,nettotal,";
				
				String salesOrderId = "" + request.getParameter("salesOrderId");
				String delivaryNO = "" + request.getParameter("delivaryNO");
				
				String recivedBy = "" + request.getParameter("recivedBy");
				String delivaryDate = "" + request.getParameter("delivaryDate");
				delivaryDate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(delivaryDate);
				
				String memo = "" + request.getParameter("memo");
				String ref = "" + request.getParameter("ref");
				String tot = "" + request.getParameter("totals");
				String totaldiscount = ""
						+ request.getParameter("totaldiscount");
				String tax = "" + request.getParameter("tax");
				
				String salestaxamount = ""
						+ request.getParameter("salestaxamount");
				String nettotal = "" + request.getParameter("nettotal");
				
				sql = " update inv_t_delivary SET ";
				sql = sql + " CHR_DELIVARYNO='" + delivaryNO + "', ";
				sql = sql + " CHR_RECIVEDBY='" + recivedBy + "',";
				sql = sql + " DAT_DELIVARYDATE='" + delivaryDate + "' , ";
				sql = sql + " CHR_DES=" + "'" + memo + "',";
				sql = sql + " CHR_REF=" + "'" + ref + "',";
				sql = sql + " INT_TAXID=" + Integer.parseInt(tax) + " , ";
				sql = sql + " DOU_AMOUNT=" + Double.parseDouble(tot) + " , ";
				sql = sql + " DOU_DISCOUNT="+ Double.parseDouble(totaldiscount) + " , ";
				sql = sql + " DOU_TAXAMOUNT=" + salestaxamount + " , ";
				sql = sql + " DOU_TOTALAMOUNT=" + Double.parseDouble(nettotal)+ " , ";
				sql = sql + " CHR_USRNAME='" + userId + "'";
				sql = sql + " WHERE CHR_DELIVARYNO='" + delivaryNO + "'";
				st.execute(sql);
				sql = "update  inv_t_customersalesorder   SET INT_ORDERSTATUS=1 WHERE INT_SALESORDERID="+ salesOrderId;
				st.execute(sql);
				String salesId = ""	+ (com.my.org.erp.common.CommonInfo.intRecordCount("SELECT MAX(INT_DELIVARYID) FROM inv_t_delivary"));
				itemUpdate(request, response, salesId, salesOrderId, st);
				con.close();    
				response.sendRedirect("Smart Inventory/SalesItemSerialnoEntry.jsp?delivaryId="+ salesId + "&salesId=" + salesOrderId);
			}
			else if ("INVDelivaryChallanSerialChange".equals(action)) 
			{
				
				String serialparam  =request.getParameter("serialparam");
				for(int u=1; u<=Integer.parseInt(serialparam); u++)
				{
					String rowid=request.getParameter("rowid"+u);
					String serial=""+request.getParameter("serial"+u);
					String warranty=""+request.getParameter("warranty"+u);
					if(serial.equals("null"))
						serial="";
					if(warranty.equals("null"))
						warranty="";
					sql= " UPDATE  inv_t_customersalesorderitemserial   SET ";
					sql = sql + " CHR_SERIALNO ='" +serial+"', ";
					sql = sql + " CHR_WARRANTY ='" +warranty+"' ";
					sql = sql + " WHERE  INT_ID = " +Integer.parseInt(rowid);
					st.execute(sql);
				}	
				con.close();   
				response.sendRedirect("Smart Inventory/Delivary Challan.jsp");
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