package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class SalesReturnActionHandler extends AbstractActionHandler
{
	
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("INVBRANCH").toString();
				Statement st = con.createStatement();
				String sql="";
				if("INVSalesReturnAdd".equals(action))
				{
					String refids[] = request.getParameterValues("refid");
					String grtDate=request.getParameter("grtDate");		
					grtDate=DateUtil.FormateDateSQL(grtDate);
					String delivNo=request.getParameter("dcno");
					String returnType=request.getParameter("returnType");
					String grtno="SARTN/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.salesReturnNumber();
				 	 
					for(int u=0;u<refids.length;u++)
					{
						if("Invoice".equals(returnType))
						{
							asql="SELECT CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_FLAG from  inv_t_customersalesorderitemserial   "+
							" where CHR_SERIALNO='"+refids[u]+"'";
						}
						else if("Cash".equals(returnType))
						{
							asql="SELECT CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_GRTFLAG from inv_t_cashserialno "+
							" where CHR_SERIALNO='"+refids[u]+"'";
						}
						else if("Direct".equals(returnType))
						{
							asql="SELECT CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_GRTFLAG from inv_t_directsalesserialno "+
							" where CHR_SERIALNO='"+refids[u]+"'";
						}
					  	String recdData[][]=CommonFunctions.QueryExecute(asql);
					  	
						asql = "INSERT INTO   inv_t_customersalesreturn (INT_BRANCHID,CHR_RETURNNO,"; 
						asql = asql +   " DAT_RETURNDATE ,CHR_DELIVARYNO ,CHR_ITEMID ,CHR_SERIALNO," ;
						asql = asql +   " CHR_WARRANTY,INT_RETURNSTATUS,CHR_USRNAME," ;
						asql = asql +   " DT_UPDATEDATE,CHR_UPDATESTATUS) ";
						asql = asql +" VALUES(?,?,?,?,?,?,?,'N',?,DATE(NOW()),'Y') ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,branchid);
						apstm.setString(2,grtno);
						apstm.setString(3,grtDate);
						apstm.setString(4,delivNo);
						apstm.setString(5,recdData[0][0]);
						apstm.setString(6,recdData[0][1]);
						apstm.setString(7,recdData[0][2]);
						apstm.setString(8,auserid);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						 
						
						
						if("Invoice".equals(returnType))
						{
							asql=" UPDATE  inv_t_customersalesorderitemserial   SET "
							+" CHR_FLAG='Y' WHERE "
							+" CHR_SERIALNO='"+recdData[0][1]+"' "
							+" AND CHR_ITEMID='"+recdData[0][0]+"'";	
						}
						else if("Cash".equals(returnType))
						{
							asql=" UPDATE inv_t_cashserialno SET "
								+" CHR_GRTFLAG='Y' WHERE "
								+" CHR_SERIALNO='"+recdData[0][1]+"' "
								+" AND CHR_ITEMID='"+recdData[0][0]+"'";
						}
						else if("Direct".equals(returnType))
						{
							asql=" UPDATE inv_t_directsalesserialno SET "
								+" CHR_GRTFLAG='Y' WHERE "
								+" CHR_SERIALNO='"+recdData[0][1]+"' "
								+" AND CHR_ITEMID='"+recdData[0][0]+"'";
						}	
						apstm = con.prepareStatement(asql);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						
						
					}
					con.close();     
					response.sendRedirect("Smart Inventory/Sales Return.jsp");
				}
				else if("INVGoodsReturnDelete".equals(action))
				{
					String grtnos[] = request.getParameterValues("grtno");
					for(int u=0; u<grtnos.length;u++)
					{
						sql = "SELECT * FROM  inv_t_vendorgoodsreturn  WHERE CHR_GRTNO ='"+grtnos[u]+"'";
						String recdData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						for(int x=0; x<recdData.length;x++)
						{
							@SuppressWarnings("unused")
							String purchaseid =	recdData[u][3];
							@SuppressWarnings("unused")
							String itemid =	recdData[u][4];
							@SuppressWarnings("unused")
							String recdid =	recdData[u][5];
						}	
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Sales Return.jsp");
				}
				else if("INVSalesReturn".equals(action))
				{
					 
					 
					String saleno =request.getParameter("saleno");						 
					String rowids[] = request.getParameterValues("rowid");
					String type=""+request.getParameter("returnType");
	    		 
	    		 	st = con.createStatement();
	    		 	String sql0="";
	    		 	if(type.equals("Invoice"))
			 			sql0 = " UPDATE  inv_t_customersalesorderitemserial SET CHR_GRTFLAG ='Y' WHERE CHR_SALESORDERNO ='"+saleno+"' AND INT_ID =" ;
			 		if(type.equals("Direct"))
			 			sql0 =" UPDATE inv_t_swapsalesserialno  SET CHR_GRTFLAG ='Y'   WHERE CHR_SALESNO ='"+saleno+"'  AND INT_ID =" ;
			 		
			 		 
			 		String sql1="";
			 		String sql2="";
			 		for(int u=0;u<rowids.length;u++)
			 		{
			 			sql1 = sql0 + rowids[u];
			 			sql2 =" SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO FROM inv_t_swapsalesserialno WHERE  CHR_SALESNO ='"+saleno+"'  AND INT_ID ="+rowids[u];
			 			String returndata[][] =  CommonFunctions.RecordSetArray(con, sql2);
			 			st.execute(sql1);
			 			//update the goods received
			 			sql = "UPDATE inv_t_vendorgoodsreceived SET";
						sql = sql+" CHR_FLAG ='N'  , CHR_RECEIVEDMODE ='B', CHR_SALESRETURN='Y'";			
						sql = sql+" WHERE CHR_ITEMID ='"+returndata[0][1]+"' AND CHR_TYPE='"+returndata[0][0]+"' AND CHR_SERIALNO='"+returndata[0][2]+"'";
						st.execute(sql);
			 			 
						 
					}
			 		
			 		if("Invoice".equals(type))
						asql="UPDATE  inv_t_customersalesorderitemserial  SET CHR_SALESTYPE = 'R'  where CHR_SERIALNO='"+saleno+"'";
					else if("Cash".equals(type))
						asql=" UPDATE inv_t_cashserialno  SET CHR_SALESTYPE = 'R'   where CHR_SERIALNO='"+saleno+"'";
					else if("Direct".equals(type))
						asql="UPDATE inv_t_directsales  SET CHR_SALESTYPE = 'R'  where CHR_SALESNO='"+saleno+"'";
					
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
			 		con.close();    
			 		response.sendRedirect("Smart Inventory/Sales Return.jsp");
				}
				else if("INVSalesReturnReplacement".equals(action))
				{
					
					String rowid =request.getParameter("rowid");
					String tablename =request.getParameter("tablename");						 
					String replacementno=request.getParameter("replacementno");
					String replacementdt=request.getParameter("replacementdt");
					String newserial=request.getParameter("newserial");
					String newwarranty=request.getParameter("newwarranty");
					String Status=request.getParameter("Status");
					st = con.createStatement();
	    		 	sql = "UPDATE " +tablename +" SET CHR_REPLACEMENTNO = '"+replacementno+"' ,";
	    		 	sql =sql + " DAT_REPLACEMENTDATE = '"+DateUtil.FormateDateSQL(replacementdt)+"' , ";
	    		 	sql =sql + " CHR_NEWSERIAL = '"+newserial+"' , ";
	    		 	sql =sql + " CHR_NEWWARRANTY = '"+newwarranty+"' WHERE INT_ID = "+rowid;
	    		 	if(Status.equals("Y"))
	    		 		st.execute(sql);
	    		 	con.close();    
	    		 	response.sendRedirect("Smart Inventory/Sales Return.jsp");
	    		 	
			 	}
				else if("INVSalesReturnReceivedAdd".equals(action))
				{
					String grtn =request.getParameter("retNo");
					String serial =request.getParameter("serial");						 
					String newserial = request.getParameter("newserial");
					String newwarranty = request.getParameter("newwarranty");				
					String replacementdt= request.getParameter("replacementdt");
					String Status= request.getParameter("Status");
					String returnType=request.getParameter("returnType");					
					sql = " UPDATE   inv_t_customersalesreturn  SET ";
					sql = sql +" INT_RETURNSTATUS = '"+Status+"' ,";				
					sql = sql +" DAT_REPLACEMENT = '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(replacementdt)+"' ,";
					sql = sql +" CHR_NEWSERIALNO = '"+newserial+"' ,";
					sql = sql +" CHR_NEWWARRANTY = '"+newwarranty+"' ,";
					sql = sql +" CHR_USRNAME = '"+userId+"' ,";
					sql = sql +" DT_UPDATEDATE = now() ,";
					sql = sql +" CHR_UPDATESTATUS = 'Y' ";
					sql = sql +" WHERE CHR_RETURNNO ='"+grtn+"'";
					sql = sql +" AND CHR_SERIALNO ='"+serial+"'";
					st.execute(sql);
					if("Invoice".equals(returnType)){
						sql = " UPDATE  inv_t_customersalesorderitemserial   SET ";
						sql = sql +" CHR_NEWSERIALNO = '"+newserial+"' ,";
						sql = sql +" CHR_NEWWARRANTY = '"+newwarranty+"', ";
						sql = sql +" CHR_FLAG = 'P'";
						sql = sql +" WHERE CHR_SERIALNO ='"+serial+"'";					
					}else if("Cash".equals(returnType)){
						sql = " UPDATE inv_t_cashserialno SET ";
						sql = sql +" CHR_NEWSERIAL = '"+newserial+"' ,";
						sql = sql +" CHR_NEWWARRANTY = '"+newwarranty+"', ";
						sql = sql +" CHR_GRTFLAG = 'P'";
						sql = sql +" WHERE CHR_SERIALNO ='"+serial+"'";
					}else if("Direct".equals(returnType)){
						sql = " UPDATE inv_t_directsalesserialno SET ";
						sql = sql +" CHR_NEWSERIAL = '"+newserial+"' ,";
						sql = sql +" CHR_NEWWARRANTY = '"+newwarranty+"', ";
						sql = sql +" CHR_GRTFLAG = 'P'";
						sql = sql +" WHERE CHR_SERIALNO ='"+serial+"'";
					}
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/Sales Return.jsp");
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