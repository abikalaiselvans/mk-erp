package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class CashSaleActionHandler extends AbstractActionHandler
{
	
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String cashSaleNo ,Connection con,Statement st )throws ServletException, IOException 
	{
		try 
		{
			String field="";
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			String itemtype="";
			String itemname="";
			String type="";
			int qty=0;
			for(int p=0;p<param.length; p++)
			{
				 
				itemtype="";
				itemname="";
				itemtype=request.getParameter("itype"+param[p].trim());
				itemname=request.getParameter("item"+param[p].trim());
				if(itemtype.equals("1"))
					type="I";
				
				if(itemtype.equals("2"))
					type="P";
				
				
				qty=Integer.parseInt(request.getParameter("qty"+param[p].trim()));
				
				//insert into total item 
				field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,"; 
				field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
				sql=" INSERT INTO inv_t_cashsalesitem (" +field+" ) VALUES (";
				sql = sql +Integer.parseInt(branchid)+" , ";
				sql = sql +" '"+cashSaleNo+"' , ";
				sql = sql +"'"+request.getParameter("item"+param[p].trim())+"' , ";
				sql = sql +"'"+type+"' , ";
				sql = sql +"'"+request.getParameter("desc"+param[p].trim())+"' , ";
				sql = sql +qty+" , ";
				sql = sql +Double.parseDouble(request.getParameter("uprice"+param[p].trim()))+" , ";
				sql = sql +"'"+request.getParameter("discount"+param[p].trim())+"' , ";
				sql = sql +Double.parseDouble(request.getParameter("unitdiscount"+param[p].trim()))+" , ";
				sql = sql +Double.parseDouble(request.getParameter("total"+param[p].trim()))+" , ";
				sql = sql +"'"+userId+"' , ";
				sql = sql +" now() , 'Y' ) ";
				st.execute(sql);	
				
				@SuppressWarnings("unused")
				int dcqty =Integer.parseInt(request.getParameter("qty"+param[p].trim()));
				
				//insert into individual serial number and warranty
				for(int u=0; u<qty;u++)
				{
					field =" (INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE ," +
					" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					sql ="INSERT INTO inv_t_cashserialno " + field ;
					sql = sql+	" VALUES (";
					sql = sql +Integer.parseInt(branchid)+" , ";
					sql = sql +"'"+cashSaleNo+"' , ";
					sql = sql +"'"+request.getParameter("item"+param[p].trim())+"' , ";
					sql = sql +"'"+type+"' , ";
					sql = sql +"'"+userId+"' , ";
					sql = sql +" now() , 'Y' ) ";
					st.execute(sql);
				}
				
				//Stock update in inv_t_stock
				if(!CommonFunctions.RecordExist(con, "Select count(*) from inv_t_stock where CHR_ITEMID='"+itemname+"' AND CHR_TYPE='"+type+"' AND INT_BRANCHID = "+branchid))
				{
					sql = "INSERT INTO inv_t_stock" +
					" ( INT_BRANCHID ,CHR_ITEMID,CHR_TYPE," +
					" INT_STOCKINHAND,"+ 					
					" CHR_USRNAME," +
					" DT_UPDATEDATE, CHR_UPDATESTATUS )  VALUES (";
					sql = sql +branchid +" , ";
					sql = sql +"'"+itemname+"' , ";
					sql = sql +"'"+type+"' , ";
					sql = sql +qty+" , ";		
					sql = sql +" '"+userId +"' , ";
					sql = sql +" now() , 'Y' )";
					st.execute(sql);					
				}
				else
				{
					//update the stock to tobranchid
					sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+itemname+"' AND CHR_TYPE='"+type+"' AND INT_BRANCHID="+branchid;						
					int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
					sdbrqty = sdbrqty-qty;
					sql = "UPDATE inv_t_stock SET ";
					sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
					sql = sql +" WHERE CHR_ITEMID  = '"+itemname+"' AND CHR_TYPE='"+type+"' AND INT_BRANCHID="+branchid;
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
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("BRANCHID").toString();
				Statement st = con.createStatement();
				String sql="";
				if(action.equals("INVCashSaleAdd"))
				{
					sql="";
					@SuppressWarnings("unused")
					String param = request.getParameter("param");
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					String customername =""+request.getParameter("customerId");
					String saleDate =""+request.getParameter("saleDate");
					saleDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					String paymentterm =""+request.getParameter("payment");
					String memo =""+request.getParameter("memo");
					String ref =""+request.getParameter("ref");
					String tot =""+request.getParameter("totals");
					String totaldiscount =""+request.getParameter("totaldiscount");
					String tax =""+request.getParameter("tax");
					@SuppressWarnings("unused")
					String salestax =""+request.getParameter("salestax"); 
					String salestaxamount =""+request.getParameter("salestaxamount");
					String nettotal =""+request.getParameter("nettotal");
					String field="( INT_BRANCHID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE,INT_PAYMENTTERMID,";
					field = field+"	CHR_DES,CHR_REF,INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT,";
					field = field+"	DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_USRNAME,";
					field = field+"	DT_UPDATEDATE,CHR_UPDATESTATUS )";
					sql = " INSERT INTO inv_t_cashsales "+field+" VALUES (";
					sql = sql +Integer.parseInt(branchid)+" , ";
					sql = sql +"'"+cashSaleNo+"', ";
					sql = sql +customername+", ";
					sql = sql +"'"+saleDate+"' , ";
					sql = sql +Integer.parseInt(paymentterm)+" , ";
					sql = sql +"'"+memo+"' , ";
					sql = sql +"'"+ref+"' , ";
					sql = sql +Integer.parseInt(tax)+" , ";
					sql = sql +Double.parseDouble(tot)+" , ";
					sql = sql +Double.parseDouble(totaldiscount)+" , ";
					sql = sql +salestaxamount+" , ";
					sql = sql +Double.parseDouble(nettotal)+" , ";		
					sql = sql +"1 , ";
					sql = sql +"'N' , ";
					sql = sql +"'"+userId+"' , ";
					sql = sql +" now() , 'Y' ) ";
					st.execute(sql);
					sql  = "INSERT INTO   inv_t_customersalespayment  (INT_BRANCHID,CHR_SALESORDERNO)";
					sql = sql +" VALUES ("+Integer.parseInt(branchid)+" , ";
					sql = sql +"'"+cashSaleNo+"') ";
					st.execute(sql);
					sql="";
					itemInsert(request,response,cashSaleNo,con,st);
					con.close();    
					response.sendRedirect("Smart Inventory/CashSaleSerial.jsp?salno="+cashSaleNo);
				}
				else if("INVCashSaleUpdate".equals(action))
				{
					
					String param = request.getParameter("param");
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					String customername =""+request.getParameter("custid");
					String saleDate =""+request.getParameter("saleDate");
					saleDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					String paymentterm =""+request.getParameter("payment");
					String memo =""+request.getParameter("memo");
					String ref =""+request.getParameter("ref");
					String tot =""+request.getParameter("totals");
					String totaldiscount =""+request.getParameter("totaldiscount");
					String tax =""+request.getParameter("tax");
					@SuppressWarnings("unused")
					String salestax =""+request.getParameter("salestax"); 
					String salestaxamount =""+request.getParameter("salestaxamount");
					String nettotal =""+request.getParameter("nettotal");
					sql =" UPDATE inv_t_cashsales SET";
					sql = sql +" DAT_SALESDATE = ' "+saleDate+"' , ";
					sql = sql +" INT_PAYMENTTERMID =  "+paymentterm+" ,";
					sql = sql +" INT_CUSTOMERID = "+customername+" ,";
					sql = sql +" CHR_DES = ' "+memo+"' , ";
					sql = sql +" CHR_REF = ' "+ref+"' , ";
					sql = sql +" DOU_AMOUNT =  "+tot+" , ";
					sql = sql +" DOU_DISCOUNT =  "+totaldiscount+"  , ";
					sql = sql +" INT_TAXID =  "+tax+" , ";
					sql = sql +" DOU_TAXAMOUNT =  "+salestaxamount+" ,  ";
					sql = sql +" DOU_TOTALAMOUNT =  "+nettotal+"   ";
					sql = sql +" WHERE CHR_SALESNO ='"+cashSaleNo+"' "; 
					sql = sql +" AND  INT_BRANCHID ="+branchid;
					st.execute(sql);
					
					sql = "DELETE FROM inv_t_cashsalesitem WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
					sql = sql +" AND  INT_BRANCHID ="+branchid;
					st.execute(sql);
					sql = "DELETE FROM inv_t_cashserialno WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
					sql = sql +" AND  INT_BRANCHID ="+branchid;
					st.execute(sql);
					
					int desclength = Integer.parseInt(param);
					String itype="";
					String itemname="";
					String type= "";
					for(int u=1; u<=desclength;u++)
					{
						itype="";
						itemname="";
						itemname=request.getParameter("item"+u);
						itype= request.getParameter("itype"+u);
						int dcqty =Integer.parseInt(request.getParameter("qty"+u));
						int previousqty =Integer.parseInt(request.getParameter("pstock"+u));
						String field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,"; 
						field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
						sql=" INSERT INTO inv_t_cashsalesitem (" +field+" ) VALUES (";
						sql = sql +Integer.parseInt(branchid)+" , ";
						sql = sql +" '"+cashSaleNo+"' , ";
						sql = sql +"'"+request.getParameter("item"+u)+"' , ";
						sql = sql +"'"+itype+"' , ";
						sql = sql +"'"+request.getParameter("desc"+u)+"' , ";
						sql = sql +dcqty +" , ";
						sql = sql +Double.parseDouble(request.getParameter("uprice"+u))+" , ";
						sql = sql +"'"+request.getParameter("discount"+u)+"' , ";
						sql = sql +Double.parseDouble(request.getParameter("unitdiscount"+u))+" , ";
						sql = sql +Double.parseDouble(request.getParameter("total"+u))+" , ";
						sql = sql +"'"+userId+"' , ";
						sql = sql +" now() , 'Y' ) ";
						st.execute(sql);	
						
						for(int v=0; v<Integer.parseInt(request.getParameter("qty"+u));v++)
						{
							field =" (INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE," +
							" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
							sql ="INSERT INTO inv_t_cashserialno " + field ;
							sql = sql+	" VALUES (";
							sql = sql +Integer.parseInt(branchid)+" , ";
							sql = sql +"'"+cashSaleNo+"' , ";
							sql = sql +"'"+request.getParameter("item"+u)+"' , ";
							sql = sql +"'"+itype+"' , ";
							sql = sql +"'"+userId+"' , ";
							sql = sql +" now() , 'Y' ) ";
							st.execute(sql);
						}
						
						//	update the stock to tobranchid
						sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+itemname+"' AND CHR_TYPE='"+type+"' AND INT_BRANCHID="+branchid;						
						int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
						sdbrqty = (sdbrqty+previousqty)-dcqty;
						sql = "UPDATE inv_t_stock SET ";
						sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
						sql = sql +" WHERE CHR_ITEMID  = '"+itemname+"' AND CHR_TYPE='"+type+"' AND INT_BRANCHID="+branchid;
						st.execute(sql);
					}
					request.setAttribute("serialno", "true");
					con.close();    
					response.sendRedirect("Smart Inventory/CashSaleSerial.jsp?salno="+cashSaleNo);
				}
				else if("INVCashSaleDelete".equals(action))
				{
					String cashsaleids[] = request.getParameterValues("itemId");
					for(int u=0; u<cashsaleids.length;u++)
					{	
						String cashSaleNo = cashsaleids[u].trim();
						sql ="DELETE FROM inv_t_cashsales  WHERE CHR_SALESNO ='"+cashSaleNo+"' "; 
						sql = sql +" AND  INT_BRANCHID ="+branchid;
						st.execute(sql);
						sql = " select CHR_ITEMID,INT_QUANTITY from inv_t_cashsalesitem WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						sql = sql +" AND  INT_BRANCHID ="+branchid;
						//System.out.println(sql);
						String stockdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						sql = "DELETE FROM inv_t_cashsalesitem WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						sql = sql +" AND  INT_BRANCHID ="+branchid;
						st.execute(sql);
						for(int x=0;x<stockdata.length;x++)
						{	
							int prviousstock = com.my.org.erp.common.CommonInfo.intGetAnySelectField("SELECT * FROM  inv_t_stock WHERE CHR_ITEMID ='" + stockdata[x][0]+"' AND INT_BRANCHID="+branchid, "INT_STOCKINHAND");
							sql = "UPDATE inv_t_stock SET ";
							sql = sql +"INT_STOCKINHAND = "+(prviousstock+Integer.parseInt(stockdata[x][1]));
							sql = sql +" WHERE INT_BRANCHID ="+Integer.parseInt(branchid)+" AND CHR_ITEMID ='" +stockdata[x][0]+"'";
							st.execute(sql);
							prviousstock = com.my.org.erp.common.CommonInfo.intGetAnySelectField("SELECT * FROM  inv_m_item WHERE CHR_ITEMID ='" +stockdata[x][0]+"'", "INT_STOCKINHAND");
							sql = "UPDATE inv_m_item SET ";
							sql = sql +"INT_STOCKINHAND = "+(prviousstock+Integer.parseInt(stockdata[x][1]));
							sql = sql +" WHERE  CHR_ITEMID ='" +stockdata[x][0]+"'";
							st.execute(sql);
						}
						sql = "DELETE FROM inv_t_cashserialno WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						sql = sql +" AND  INT_BRANCHID ="+branchid;
						st.execute(sql);
					}
					con.close();   
					response.sendRedirect("Smart Inventory/Cash Sale.jsp ");
				}
				else if("INVCashSaleAddserial".equals(action))
				{
					String salesno =request.getParameter("salesno");
					sql ="SELECT INT_ID,CHR_SALESNO,CHR_ITEMID FROM inv_t_cashserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
					String recdData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					int row=1;
					for(int v=0;v<recdData.length; v++)
					{
						int rowid = Integer.parseInt(recdData[v][0]);
						String itemid=recdData[v][2];
						String serail = request.getParameter("serail"+row);
						String warranty = request.getParameter("warranty"+row);
						sql ="UPDATE  inv_t_cashserialno SET " ; 
						sql = sql +" CHR_SERIALNO ='"+serail+"' , ";
						sql = sql +" CHR_WARRANTY ='"+warranty+"'  ";
						sql = sql +" WHERE INT_ID= "+rowid;
						st.execute(sql);						
						sql = "UPDATE inv_t_vendorgoodsreceived SET";
						sql = sql+" CHR_FLAG ='Y'  ";			
						sql = sql+" WHERE CHR_ITEMID ='"+itemid+"' AND CHR_SERIALNO='"+serail+"'";
						st.execute(sql);						
						row = row+1;
					}	
					request.setAttribute("serialno", "false");
					con.close();    
					response.sendRedirect("Smart Inventory/Cash Sale.jsp ");
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