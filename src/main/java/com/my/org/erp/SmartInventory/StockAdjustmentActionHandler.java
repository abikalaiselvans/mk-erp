package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.SQLWarning;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StockAdjustmentActionHandler extends AbstractActionHandler
{
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action=""+request.getParameter("actionS").trim();
			HttpSession session=request.getSession();			
			String branchid = session.getAttribute("INVBRANCH").toString();
			String user = session.getAttribute("USRID").toString();
			Statement st = con.createStatement();
			if (action.equals("INVStockAdjustmentAdd")) 
			{
 				String divis = request.getParameter("divis");
				String stockno =  InventoryInvoiceFunctions.directStockAdjustmentGet();
				String stockDate = request.getParameter("saleDate");
				stockDate= DateUtil.FormateDateSQL(stockDate);
				String ref = request.getParameter("ref");
				String memo = request.getParameter("memo");
				String oref = request.getParameter("oref");
				String dnote = request.getParameter("dnote");
				String dthru = request.getParameter("dthru");
				String destination = request.getParameter("destination");
				String tdelivery = request.getParameter("tdelivery");
				String cdetails = request.getParameter("cdetails");
				String cnumber = request.getParameter("cnumber");
				String param[] = request.getParameter("param").split(",");
				
				asql ="INSERT INTO inv_t_stockadjustment (INT_FROM_BRANCHID,INT_TO_BRANCHID, ";
				asql = asql + " CHR_ADJUSTMENTNO, DAT_ADJUSTMENTDATE,INT_DIVIID, ";
				asql = asql + " CHR_DES,CHR_REF,CHR_OTHERREF,CHR_DELIVERYNOTE,";
				asql = asql + " CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,";
				asql = asql + " CHR_CONTACTNO,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
				asql = asql +" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y')";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,branchid);
				apstm.setString(2,branchid);
				apstm.setString(3,stockno);
				apstm.setString(4,stockDate );
				apstm.setString(5,divis);
				apstm.setString(6,memo );
				apstm.setString(7,ref );
				apstm.setString(8,oref );
				apstm.setString(9,dnote );
				apstm.setString(10,dthru );
				apstm.setString(11,destination );
				apstm.setString(12,tdelivery );
				apstm.setString(13,cdetails );
				apstm.setString(14,cnumber );
				apstm.setString(15,auserid );
				System.out.println(""+apstm);
				apstm.execute();
				
				String consumable="";
				for(int u=0;u<param.length;u++)
				{
					consumable="";
					asql="INSERT INTO inv_t_stockadjustmentitem (INT_BRANCHID,CHR_ADJUSTMENTNO,CHR_ITEMID,CHR_TYPE," +
					"CHR_DESC,CHR_CONSUMABLE,INT_QTY,CHR_USRNAME,DT_UPDATEDATE," +
					"CHR_UPDATESTATUS) VALUES (?,?,?,?,?,?,?,?,now(),'Y')";
					apstm = con.prepareStatement(asql);
					String Type=""+request.getParameter("itype"+param[u]); 
					String Item=""+request.getParameter("item"+param[u]);
					String Description=""+request.getParameter("desc"+param[u]);
					String Qty=""+request.getParameter("qty"+param[u]);
					int qty=Integer.parseInt(Qty);
					if("1".equals(Type))
						Type="I";
					else if("2".equals(Type))
						Type="P";
					if("P".equals(Type))
					{
						asql="SELECT CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+Item+"' ";
						consumable=CommonFunctions.QueryExecute(asql)[0][0];
					}
					apstm.setString(1,branchid);
					apstm.setString(2,stockno);
					apstm.setString(3,Item );
					apstm.setString(4,Type);
					apstm.setString(5,Description );
					apstm.setString(6,consumable );
					apstm.setString(7,Qty );
					apstm.setString(8,user );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					if(qty>0 && !"S".equals(consumable) )
					{
						for(int i=0;i<qty;i++)
						{
							asql="INSERT INTO inv_t_stockadjustmentitemserial (INT_BRANCHID,CHR_ADJUSTMENTNO,CHR_ITEMID,CHR_TYPE," +
							"CHR_DESC,CHR_SERIALNO,CHR_WARRANTY,CHR_USRNAME,DT_UPDATEDATE," +
							"CHR_UPDATESTATUS) VALUES (?,?,?,?,?,?,?,?,now(),'Y')";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,branchid);
							apstm.setString(2,stockno);
							apstm.setString(3,Item );
							apstm.setString(4,Type);
							apstm.setString(5,Description );
							apstm.setString(6,"" );
							apstm.setString(7,"" );
							apstm.setString(8,user );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
					}
				}	
				con.close();   
				response.sendRedirect("Smart Inventory/StockAdjustmentSerialNumber.jsp?salesid="+stockno);						
			}
			if (action.equals("INVStockAdjustmentEdit")) 
			{
				String stockno=""+request.getParameter("dcno");
				String division=""+request.getParameter("division");
				String seriallength = ""+request.getParameter("seriallength");
				int sl = Integer.parseInt(seriallength);
				if(sl>0)
				{
					if(checkSerialNumberSale(seriallength,request, response))
					{
						for(int u=0;u<sl;u++)
						{
							asql = " UPDATE inv_t_stockadjustmentitemserial SET ";
							asql = asql +" CHR_SERIALNO = ?";
							asql = asql +" WHERE CHR_ADJUSTMENTNO =?";
							asql = asql +" AND INT_ROWID =? ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,request.getParameter("serial"+(u+1)));
							apstm.setString(2,stockno);
							apstm.setString(3,request.getParameter("rowid"+(u+1)));
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							asql = "UPDATE inv_t_vendorgoodsreceived SET  INT_DIVIID =?,CHR_FLAG=?, ";
							asql = asql + " CHR_QUALITY=?, CHR_DCNO=? WHERE CHR_SERIALNO=? "; 
							apstm = con.prepareStatement(asql);
							apstm.setString(1,division);
							apstm.setString(2,"J");
							apstm.setString(3,"H");
							apstm.setString(4,stockno);
							apstm.setString(5,request.getParameter("serial"+(u+1)));
							System.out.println(""+apstm);
							apstm.execute();
							 
						}
						asql = " UPDATE inv_t_stockadjustment SET ";
						asql = asql +" CHR_STATUS = ?";
						asql = asql +" WHERE CHR_ADJUSTMENTNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"Y");
						apstm.setString(2,stockno);
						System.out.println(""+apstm);
						apstm.execute();
						System.out.println("Completed...");
						response.sendRedirect("Smart Inventory/StockAdjustment.jsp");
					}
					else
					{
						con.close();
						response.sendRedirect("Smart Inventory/StockAdjustmentserialcheck.jsp?salno="+stockno) ;
					}
				}
				else
				{
					asql = " UPDATE inv_t_stockadjustment SET ";
					asql = asql +" CHR_STATUS = ?";
					asql = asql +" WHERE CHR_ADJUSTMENTNO =?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y");
					apstm.setString(2,stockno);
					System.out.println(""+apstm);
					apstm.execute();
					con.close();
					response.sendRedirect("Smart Inventory/StockAdjustment.jsp");
				}
				
					 
			}
			else if("INVStockAdjustmentDelete".equals(action))
			{
				String dcnos[]=request.getParameterValues("salesid");
				for(int u=0;u<dcnos.length;u++)
				{
					asql ="SELECT CHR_SERIALNO FROM inv_t_stockadjustmentitemserial WHERE CHR_ADJUSTMENTNO='"+dcnos[u]+"'";
					String data[][] =  CommonFunctions.QueryExecute(asql);
					for(int y=0;y<data.length;y++)
					{
						asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',CHR_QUALITY='Y', CHR_DCNO='"+dcnos[u]+"' WHERE CHR_SERIALNO='"+data[u][0]+"'";
						st.execute(asql);
					}
					asql="DELETE FROM inv_t_stockadjustmentitemserial WHERE CHR_ADJUSTMENTNO='"+dcnos[u]+"'";
					st.execute(asql);
					asql="DELETE FROM inv_t_stockadjustmentitem WHERE CHR_ADJUSTMENTNO='"+dcnos[u]+"'";
					st.execute(asql);
					asql="DELETE FROM inv_t_stockadjustment WHERE CHR_ADJUSTMENTNO='"+dcnos[u]+"'";
					st.execute(asql);
				}
				con.close();   
				response.sendRedirect("Smart Inventory/StockAdjustment.jsp");
			}
			else if("INVStockAdjustmentClosed".equals(action))
			{
				String dcno=request.getParameter("dcno");
				String reason=request.getParameter("reason");
				asql="UPDATE  inv_t_stockadjustment SET CHR_CLOSEDBY=?,CHR_CLOSEDDATE=NOW(),CHR_DCSTATUS=? , CHR_RETURNDESC=? WHERE CHR_ADJUSTMENTNO=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,""+session.getAttribute("EMPID"));
				apstm.setString(2,"Y");
				apstm.setString(3,reason);
				apstm.setString(4,dcno);
				System.out.println(""+apstm);
				apstm.execute();
			
				asql ="SELECT CHR_SERIALNO FROM inv_t_stockadjustmentitemserial WHERE CHR_ADJUSTMENTNO='"+dcno+"'";
				String data[][] = CommonFunctions.QueryExecute(asql);
				if(data.length>0)
				{
					asql = " UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',CHR_QUALITY='Y',  CHR_DCNO=null   WHERE CHR_SERIALNO IN ( ";
					String s="";
					for(int u=0; u<data.length; u++)
						s = s+ " '"+data[u][0]+"' ," ;
					asql = asql+s ;
					asql = asql.trim();
					asql = asql.substring(0,asql.length()-1);
					asql = asql+" ) ";
					apstm = con.prepareStatement(asql);
					apstm.execute();
				}
				con.close();   
				response.sendRedirect("Smart Inventory/StockAdjustment.jsp");
			}
			else if("INVStockAdjustmentPartiallyClosed".equals(action))
			{
				
				String dcno  = request.getParameter("dcno");
				String length  = request.getParameter("dec");
				String accept="";
				String rowid="";
				boolean f = false;
				for(int u=0;u<Integer.parseInt(length);u++)
				{
					accept = ""+request.getParameter("accept"+u);
					rowid = ""+request.getParameter("rowid"+u);
					if(  "on".equals(accept)   )
					{
						asql = " UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',CHR_QUALITY='Y', ";
						asql = asql +" CHR_DCNO=null   WHERE CHR_SERIALNO  =? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, request.getParameter("serial"+u));
						System.out.println(""+apstm);
						apstm.execute();
						
						asql = "UPDATE inv_t_stockadjustmentitemserial SET CHR_CLOSED ='Y' WHERE INT_ROWID=? AND CHR_SERIALNO=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, request.getParameter("rowid"+u));
						apstm.setString(2, request.getParameter("serial"+u));
						System.out.println(""+apstm);
						apstm.execute();
						f =true;;
						
					}
				}
				
				
				
				if(f)
				{
					asql="UPDATE  inv_t_stockadjustment SET CHR_CLOSEDBY=?,CHR_CLOSEDDATE=NOW(),CHR_DCSTATUS=? , CHR_RETURNDESC=? WHERE CHR_ADJUSTMENTNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,""+session.getAttribute("EMPID"));
					apstm.setString(2,"P");
					apstm.setString(3,"PartiallyClosed");
					apstm.setString(4,dcno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
				}
				
				
				con.close();   
				response.sendRedirect("Smart Inventory/StockAdjustment.jsp");
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

	
	public static synchronized boolean checkSerialNumberSale(String length,HttpServletRequest request, HttpServletResponse response) throws IOException,SQLWarning, ServletException 
	{
		boolean flag = true;
		try
		{
			String sql = " SELECT CHR_FLAG,CHR_SERIALNO FROM  inv_t_vendorgoodsreceived	WHERE  CHR_FLAG='N' AND CHR_SERIALNO IN(";
			String s="";
			for(int u=1; u<=Integer.parseInt(length);u++)
				s = s+ "'"+request.getParameter("serial"+u).trim()+"' ," ;
			sql = sql+s ;
			sql=sql.trim();
			sql = sql.substring(0,sql.length()-1);
			sql = sql+" ) ";
			String checkData[][] = CommonFunctions.QueryExecute(sql);
			if(checkData.length>0)
			{
				for(int u=0;u<checkData.length;u++)
				{
					if(!"N".equals(checkData[u][0]))
					{
						flag = false;
						break;
					}	
				}
			}
			else
				flag = false;
			
			return flag;
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
		return flag;
	}
 

}
