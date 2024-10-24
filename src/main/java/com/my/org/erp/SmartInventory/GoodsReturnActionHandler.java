package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class GoodsReturnActionHandler extends AbstractActionHandler
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
				 
				if("INVGoodsReturnAdd".equals(action))
				{
					
					String refids[] = request.getParameterValues("refid");
					String purchasetype = request.getParameter("purchasetype");
					String grtno="GRTN/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.purchaseReturnNumber();
					
					String rowid="";
					String serial="";
					for(int u=0;u<refids.length;u++)
					{
						String Rtdata[] = refids[u].split("~");
						rowid="";
						serial="";
						rowid=Rtdata[0];
						serial=Rtdata[1];
						
						String field="INT_ID,INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,CHR_RECIVEDID,";
						field = field+"DAT_RECIVEDDATE,CHR_RECIVEDBY,CHR_SERIALNO,CHR_WARRANTY";
						sql = "SELECT "+field+" FROM inv_t_vendorgoodsreceived WHERE INT_ID='"+Integer.parseInt(rowid)+"' AND CHR_SERIALNO='"+serial+"'";
						String recdData[][] =  CommonFunctions.QueryExecute(sql);
						
						asql ="INSERT INTO  inv_t_vendorgoodsreturn  (  INT_RECEIVEDROWID,CHR_GRTNO,INT_BRANCHID , ";
						asql = asql +"CHR_PURCHASEORDERNO ,CHR_PURCHASEMODE,CHR_TYPE,CHR_ITEMID ,CHR_RECIVEDID, ";
						asql = asql +" DAT_RECIVEDDATE ,CHR_RECIVEDBY ,CHR_SERIALNO, ";
						asql = asql +" CHR_WARRANTY,DAT_RETURNDATE ,CHR_FLAG,CHR_USRNAME,DT_UPDATEDATE,";
						asql = asql +" CHR_UPDATESTATUS,INT_SERIAL_ROWID ) ";
						asql = asql +"VALUES (?,?,?,?,?,?,?,?,?,?,?,?,now() , 'N' ,?,now() , 'N' ,? ) ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,recdData[0][0]);
						apstm.setString(2,grtno);
						apstm.setString(3,branchid);
						apstm.setString(4,recdData[0][2]);
						apstm.setString(5,purchasetype);
						apstm.setString(6,recdData[0][3]);
						apstm.setString(7,recdData[0][4]);
						apstm.setString(8,recdData[0][5]);
						apstm.setString(9,recdData[0][6]);
						apstm.setString(10,recdData[0][7]);
						apstm.setString(11,recdData[0][8]);
						apstm.setString(12,recdData[0][9]);
						System.out.println(""+apstm);
						apstm.setString(13,userId);
						apstm.setString(14,recdData[0][0]);
						apstm.execute();
						apstm.close();
						
						asql = "UPDATE inv_t_vendorgoodsreceived SET ";
						asql = asql +" CHR_GRTFLAG = 'Y'  "; //CHR_SERIALNO = null,
						asql = asql +" WHERE CHR_TYPE=? AND CHR_ITEMID  = ? AND INT_ID= ?";
						asql = asql +" AND  CHR_PURCHASEORDERNO = ? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,recdData[0][3]);
						apstm.setString(2,recdData[0][4]);
						apstm.setString(3,recdData[0][0]);
						apstm.setString(4,recdData[0][2]);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "INSERT INTO  inv_t_vendorgoodsreplacement ";
						asql = asql +"(  CHR_PURCHASEORDERNO,CHR_GRTNO ," ;
						asql = asql +" CHR_TYPE , CHR_ITEMID, CHR_RECIVEDID, ";
						asql = asql +" CHR_OLDSERIAL,	CHR_NEWSERIAL,CHR_REPLACEFLAG,";
						asql = asql +" CHR_USRNAME, DT_UPDATEDATE,CHR_UPDATESTATUS )";
						asql = asql +" VALUES (?,?,?,?,?,?, '','N',?,now() ,'Y') ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,recdData[0][2]);
						apstm.setString(2,grtno);
						apstm.setString(3,recdData[0][3]);
						apstm.setString(4,recdData[0][4]);
						apstm.setString(5,recdData[0][5]);
						apstm.setString(6,recdData[0][9] );
						apstm.setString(7,userId);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						 
						
						/*sql = " INSERT INTO  inv_t_vendorgoodsreturn  (  INT_RECEIVEDROWID,CHR_GRTNO,INT_BRANCHID , " +
								" CHR_PURCHASEORDERNO ,CHR_PURCHASEMODE,CHR_TYPE,CHR_ITEMID ,CHR_RECIVEDID," +
								" DAT_RECIVEDDATE ,CHR_RECIVEDBY ,CHR_SERIALNO, " +
								" CHR_WARRANTY,DAT_RETURNDATE ,CHR_FLAG,CHR_USRNAME,DT_UPDATEDATE," +
								" CHR_UPDATESTATUS )";
						sql = sql +" VALUES ( ";
						 
						sql =sql +Integer.parseInt(recdData[0][0])+" , ";
						sql =sql +"'"+grtno+"' , ";
						sql =sql +"'"+branchid+"' , ";
						sql =sql +"'"+recdData[0][2]+"' , ";//CHR_PURCHASEORDERNO
						sql =sql +"'"+purchasetype+"' , "; //CHR_PURCHASEMODE
						sql =sql +"'"+recdData[0][3]+"' , ";//CHR_TYPE
						sql =sql +"'"+recdData[0][4]+"' , ";//CHR_ITEMID
						sql =sql +"'"+recdData[0][5]+"' , ";//CHR_RECIVEDID
						sql =sql +"'"+recdData[0][6]+"' , ";//DAT_RECIVEDDATE
						sql =sql +"'"+recdData[0][7]+"' , ";//CHR_RECIVEDBY
						sql =sql +"'"+recdData[0][8]+"' , ";//CHR_SERIALNO
						sql =sql +"'"+recdData[0][9]+"' , ";//CHR_WARRANTY
						sql =sql +" now() , 'N' , ";
						sql =sql +"'"+userId+"' ,";
						sql =sql +" now() ,";
						sql =sql +"'Y' ) ";
						st.execute(sql);
						
						
						sql = "UPDATE inv_t_vendorgoodsreceived SET ";
						sql = sql +" CHR_GRTFLAG = 'Y'  ";
						sql = sql +" WHERE CHR_TYPE='"+recdData[0][3]+"' AND CHR_ITEMID  = '"+recdData[0][4]+"' AND INT_ID="+Integer.parseInt(recdData[0][0]);
						sql = sql +" AND  CHR_PURCHASEORDERNO ='"+recdData[0][2]+"'";
						st.execute(sql); 
						
						
						
						
						sql = "INSERT INTO  inv_t_vendorgoodsreplacement ";
						sql = sql +"(  CHR_PURCHASEORDERNO,CHR_GRTNO ," +
								" CHR_TYPE , CHR_ITEMID, CHR_RECIVEDID," +
								" CHR_OLDSERIAL,	CHR_NEWSERIAL,CHR_REPLACEFLAG," +
								" CHR_USRNAME, DT_UPDATEDATE," +
							" CHR_UPDATESTATUS )";
						sql = sql +" VALUES ( ";
						sql =sql +"'"+ recdData[0][2]+"' , ";
						sql =sql +"'"+ grtno+"' , ";
						sql =sql +"'"+recdData[0][3] +"' , ";//CHR_TYPE
						sql =sql +"'"+recdData[0][4] +"' , ";//CHR_ITEMID
						sql =sql +"'"+recdData[0][5] +"' , ";//CHR_RECIVEDID
						sql =sql +"'"+recdData[0][9] +"' , ";//CHR_OLDSERIAL
						sql =sql +"'' , " ;
						sql =sql +"'N' , ";
						sql =sql +"'"+userId+"' , ";
						sql =sql +" now() , ";
						sql =sql +"'Y' ) ";
						st.execute(sql);
						*/
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Goods Return.jsp");
				}
				else if("INVGoodsReturnDelete".equals(action))
				{
					String rowids[] = request.getParameterValues("rowid");
					for(int u=0; u<rowids.length;u++)
					{
						String Rowid=	rowids[u];
						//System.out.println(Rowid);
						sql = "SELECT CHR_GRTNO,CHR_PURCHASEORDERNO,CHR_RECIVEDID,CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_FLAG,INT_RECEIVEDROWID FROM  inv_t_vendorgoodsreturn  WHERE INT_ID ="+Rowid;
						String recdData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						sql = "DELETE FROM inv_t_vendorgoodsreturn WHERE INT_ID="+Rowid;
						st.execute(sql);
						sql = "DELETE FROM inv_t_vendorgoodsreplacement WHERE  CHR_GRTNO='"+recdData[0][0]+"' ";
						sql = sql+" AND CHR_PURCHASEORDERNO='"+recdData[0][1]+"' ";
						sql = sql+" AND CHR_RECIVEDID='"+recdData[0][2]+"' ";
						sql = sql+" AND CHR_TYPE='"+recdData[0][3]+"' ";
						sql = sql+" AND CHR_ITEMID='"+recdData[0][4]+"' ";
						sql = sql+" AND CHR_OLDSERIAL='"+recdData[0][5]+"' ";
						st.execute(sql);
						
						if("N".equals(recdData[0][6]))
						{
							sql ="SELECT INT_STOCKINHAND FROM inv_t_stock  WHERE CHR_TYPE='"+recdData[0][3]+"' AND CHR_ITEMID  = '"+recdData[0][4]+"'  AND INT_BRANCHID="+branchid;
							int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
							sdbrqty = sdbrqty+ 1;
							if(sdbrqty <0)
								sdbrqty =0;
							sql = "UPDATE inv_t_stock SET ";
							sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
							sql = sql +" WHERE CHR_TYPE='"+recdData[0][3]+"' AND CHR_ITEMID  = '"+recdData[0][4]+"' AND INT_BRANCHID="+branchid;
							st.execute(sql);	
							sql = "UPDATE inv_t_vendorgoodsreceived SET ";
							sql = sql +" CHR_GRTFLAG = 'N'  ";
							sql = sql +" WHERE CHR_TYPE='"+recdData[0][3]+"' AND CHR_ITEMID  = '"+recdData[0][4]+"' AND INT_ID="+Integer.parseInt(recdData[0][7]);
							st.execute(sql);
						}
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Goods Return.jsp");
				}
				else if("INVGoodsReturnReceivedAdd".equals(action))
				{
					String grtn= request.getParameter("grtn");
					String pid= request.getParameter("pid");
					String rowid= request.getParameter("rowid");
					String goodsreceivedrowid= request.getParameter("goodsreceivedrowid");
					String itemid = request.getParameter("itemid");
					String type = request.getParameter("type");
					String newserial = request.getParameter("newserial");
					String newwarranty = request.getParameter("newwarranty");
					String replacementno= request.getParameter("replacementno");
					String replacementdt= request.getParameter("replacementdt");
					String Status= request.getParameter("Status");
					
					
					asql = " UPDATE  inv_t_vendorgoodsreturn  SET ";
					asql = asql +" CHR_FLAG = ? ,";
					asql = asql +" CHR_REPLACEMENTNO = ? ,";
					asql = asql +" DAT_REPLACEMENTDATE = ? ,";
					asql = asql +" CHR_NEWSERIAL = ? ,";
					asql = asql +" CHR_NEWWARRANTY = ? ,";
					asql = asql +" CHR_USRNAME = ? ,";
					asql = asql +" DT_UPDATEDATE = now() ,";
					asql = asql +" CHR_UPDATESTATUS = 'Y' ";
					asql = asql +" WHERE CHR_GRTNO =?";
					asql = asql +" AND CHR_PURCHASEORDERNO =?";
					asql = asql +" AND INT_ID = ? " ;
					apstm = con.prepareStatement(asql);
					apstm.setString(1,Status);
					apstm.setString(2,replacementno);
					apstm.setString(3,DateUtil.FormateDateSQL(replacementdt));
					apstm.setString(4,newserial);
					apstm.setString(5,newwarranty);
					apstm.setString(6,userId);
					apstm.setString(7,grtn);
					apstm.setString(8,pid);
					apstm.setString(9,rowid);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					
					asql = " UPDATE inv_t_vendorgoodsreceived SET ";
					asql = asql +" CHR_SERIALNO = ? ,";
					asql = asql +" CHR_WARRANTY = ? , ";
					asql = asql +" CHR_GRTFLAG = 'N', ";
					asql = asql +" CHR_RECEIVEDMODE = 'R' ";
					asql = asql +" WHERE CHR_PURCHASEORDERNO =?";
					asql = asql +" AND CHR_TYPE =? ";
					asql = asql +" AND CHR_ITEMID =? ";
					asql = asql +" AND INT_ID =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,newserial);
					apstm.setString(2,newwarranty);
					apstm.setString(3,pid);
					apstm.setString(4,type);
					apstm.setString(5,itemid);
					apstm.setString(6,goodsreceivedrowid);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					 
					con.close();   
					response.sendRedirect("Smart Inventory/Goods Return.jsp");
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