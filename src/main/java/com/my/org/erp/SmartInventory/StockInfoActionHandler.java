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


public class StockInfoActionHandler extends AbstractActionHandler
{
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("BRANCHID").toString();
				Statement st = con.createStatement();
				String sql ="";
				if("INVstockAdd".equals(action))
				{					
					String TxtReference=request.getParameter("TxtReference");
					String TxtReceived=request.getParameter("TxtReceived");	
					String fromdt=request.getParameter("fromdt");
					String dt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdt);	
					String branchId=""+session.getAttribute("BRANCHID");
					//String fromBranch =request.getParameter("fromBranch");
					String param[] = request.getParameter("param").split(",");
					String itemname="";
					String itype="";
					String type="";
					int qty=0;
					for(int p=0;p<param.length; p++)
					{
						itemname=request.getParameter("item"+param[p].trim());
						itype= request.getParameter("itype"+param[p].trim());
						qty =Integer.parseInt(request.getParameter("qty"+param[p].trim()));
						if(itype.equals("1"))
							type="I";
						if(itype.equals("2"))
							type="P";
						//insert into inv_t_vendorgoodsreceived
						for(int y=0;y<qty;y++)
						{
							int rowmax=0;
							sql = "SELECT MAX(INT_ID) FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO='"+TxtReference+"'";
							rowmax = com.my.org.erp.common.CommonFunction.intMaxCount(sql)+1;
							sql = "INSERT INTO inv_t_vendorgoodsreceived ( INT_ID,INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,CHR_RECIVEDID,DAT_RECIVEDDATE,CHR_RECIVEDBY,CHR_INVOICENO,CHR_RECEIVEDMODE ) VALUES ( ";
							sql = sql+rowmax +" , ";
							sql = sql+branchId +" , ";
							sql = sql+" '"+TxtReference +"' , ";
							sql = sql+" '"+type +"' , ";
							sql = sql+" '"+itemname +"' , ";
							sql = sql+" '"+TxtReference +"' , ";
							sql = sql+" '"+dt +"' , ";
							sql = sql+" '"+TxtReceived +"',   ";
							sql = sql+" '"+TxtReference +"','S' ) ";
							st.execute(sql);
						}
					}
					con.close();    
					response.sendRedirect("Smart Inventory/StockSerialno.jsp?recId="+TxtReference);
				}	
				else if("INVStockSerialAdd".equals(action))
				{ 
					String recdid = ""+request.getParameter("recId");					
					String rlength = ""+request.getParameter("seriallength");
					for(int u=1;u<=Integer.parseInt(rlength);u++)
					{	
						String itemid =""+request.getParameter("item"+u);
						String rowid =""+request.getParameter("row"+u);
						String itype =""+request.getParameter("itype"+u);
						String serial =""+request.getParameter("serial"+u);
						String waranty =""+request.getParameter("warranty"+u);
						sql = "UPDATE  inv_t_vendorgoodsreceived SET" ;
						sql = sql +" CHR_SERIALNO = '"+serial+"' ,";
						sql = sql +" CHR_WARRANTY = '"+waranty+"' ";
						sql = sql +" WHERE INT_ID = '"+rowid+"'";
						sql = sql +" AND INT_BRANCHID = "+branchid;
						sql = sql +" AND CHR_PURCHASEORDERNO = '"+recdid+"'";
						sql = sql +" AND CHR_ITEMID = '"+itemid+"'";
						sql = sql +" AND CHR_TYPE = '"+itype+"'";
						st.execute(sql);
						//	Stock update in inv_t_stock
						if(!CommonFunctions.RecordExist(con, "Select count(*) from inv_t_stock where CHR_ITEMID='"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID = "+branchid))
						{
							sql = "INSERT INTO inv_t_stock" +
							" ( INT_BRANCHID ,CHR_ITEMID,CHR_TYPE," +
							" INT_STOCKINHAND,"+ 					
							" CHR_USRNAME," +
							" DT_UPDATEDATE, CHR_UPDATESTATUS )  VALUES (";
							sql = sql +branchid +" , ";
							sql = sql +"'"+itemid+"' , ";
							sql = sql +"'"+itype+"' , ";
							sql = sql +" 1 , ";		
							sql = sql +" '"+userId +"' , ";
							sql = sql +" now() , 'Y' )";
							st.execute(sql);					
						}
						else
						{
							//update the stock to tobranchid
							sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;						
							int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
							sdbrqty = sdbrqty+1;
							sql = "UPDATE inv_t_stock SET ";
							sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
							sql = sql +" WHERE CHR_ITEMID  = '"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;
							st.execute(sql);	
						}
					}
					con.close();    
					response.sendRedirect("Smart Inventory/StockView.jsp");
				}
				else if("INVStockSerialUpdates".equals(action))
				{
					String serial = ""+request.getParameter("serial");					
					String rowid = ""+request.getParameter("rowid");
					String itype = ""+request.getParameter("itype");
					String itemid = ""+request.getParameter("itemid");
					String ponumber = ""+request.getParameter("ponumber");
					String good = ""+request.getParameter("good");
					String pwaranty = (""+request.getParameter("pwaranty")).trim();
					String warranty = (""+request.getParameter("warranty")).trim();
					String unitprice = ""+request.getParameter("unitprice");
					String dbunitprice = ""+request.getParameter("dbunitprice");
					sql = "UPDATE  inv_t_vendorgoodsreceived SET" ;
					sql = sql +" CHR_SERIALNO = '"+serial+"' , ";
					if(!pwaranty.equals(warranty))
					{	
						sql = sql +" CHR_WARRANTY  = '"+warranty+"' , ";
						
						String ssql= " INSERT INTO inv_t_warrantytrack (CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_PURCHASE_WARRANTY,CHR_SALE_WARRANTY,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						ssql = ssql+"'" +itype+"' , ";
						ssql = ssql+"'" +itemid+"' , ";
						ssql = ssql+"'" +serial+"' , ";
						ssql = ssql+"'" +pwaranty+"' , ";
						ssql = ssql+"'" +warranty+"' , ";
						ssql = ssql+"'" +userId+"' , ";
						ssql = ssql+" now() , 'Y' )";
						st.execute(ssql);
					}	
					
					if(!dbunitprice.equals(unitprice))
					{	
						sql = sql +" DOU_UNITPRICE="+unitprice+" , ";
						String ssql= " INSERT INTO inv_t_unitpricetrack (CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,DOU_UNITPRICE,DOU_DBUNITPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						ssql = ssql+"'" +itype+"' , ";
						ssql = ssql+"'" +itemid+"' , ";
						ssql = ssql+"'" +serial+"' , ";
						ssql = ssql+"" +unitprice+" , ";
						ssql = ssql+"" +dbunitprice+" , ";
						ssql = ssql+"'" +userId+"' , ";
						ssql = ssql+" now() , 'Y' )";
						st.execute(ssql);
					}
					sql = sql +" CHR_QUALITY = '"+good+"'";
					
					sql = sql +" WHERE INT_ID = "+rowid;
					sql = sql +" AND INT_BRANCHID = "+branchid;
					sql = sql +" AND CHR_PURCHASEORDERNO = '"+ponumber+"'";
					sql = sql +" AND CHR_ITEMID = '"+itemid+"'";
					sql = sql +" AND CHR_TYPE = '"+itype+"'";
					
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/InventoryMain.jsp");
				}
				else if("INVstockDelete".equals(action))
				{
					String rowid[]= request.getParameterValues("rowid");
					String branchId=""+session.getAttribute("BRANCHID");
					for(int u=0;u<rowid.length;u++)
					{	
						sql = "SELECT CHR_ITEMID,CHR_TYPE FROM inv_t_vendorgoodsreceived  WHERE INT_ID = "+rowid[u];
						String s[][] =com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
						sql = "DELETE FROM inv_t_vendorgoodsreceived  WHERE INT_ID = "+rowid[u];
						st.execute(sql);
						if("I".equals(s[0][1]) ||"P".equals(s[0][1]) )
						{
							sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+s[0][0]+"' AND INT_BRANCHID="+branchId;						
							int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
							sdbrqty = sdbrqty-1;
							sql = "UPDATE inv_t_stock SET ";
							sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
							sql = sql +" WHERE CHR_ITEMID  = '"+s[0][0]+"' AND INT_BRANCHID="+branchId;
							st.execute(sql);		
						}
					}
					con.close();    
					response.sendRedirect("Smart Inventory/StockView.jsp");
				}
				
				else if("INVstockUpdate".equals(action))
				{
					String itemId=request.getParameter("itemId");
					String branchId=""+session.getAttribute("BRANCHID");
					int stockIn=Integer.parseInt(request.getParameter("stockIn"));
					sql = "UPDATE inv_t_stock SET " ;
					sql = sql +" INT_BRANCHID = "+Integer.parseInt(branchId) +" , ";
					sql = sql +" INT_STOCKINHAND = '"+stockIn+"' , ";	
					sql = sql +" CHR_USRNAME ='"+userId +"'  ";
					sql = sql +" WHERE  CHR_ITEMID = '"+itemId+"' AND INT_BRANCHID="+branchId;
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Inventory/Stock.jsp");
				}
				else if("INVstockDelete".equals(action))
				{
					String vendorids[] = request.getParameterValues("vendorid");
					for(int u=0; u<vendorids.length;u++)
					{
						sql = "DELETE FROM  inv_m_vendorsinformation  Where  INT_VENDORID = "+Integer.parseInt(vendorids[u]);
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/VendorInfo.jsp");
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