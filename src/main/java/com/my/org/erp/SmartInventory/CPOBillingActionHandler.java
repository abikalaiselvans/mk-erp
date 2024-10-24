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

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
import com.my.org.erp.bean.inventory.SwapSale;
import com.my.org.erp.common.CommonFunctions;
public class CPOBillingActionHandler extends AbstractActionHandler
{
	static String salesordernumber=null;
	static String blockinvoice ="N";
	public synchronized  void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("INVBRANCH").toString();
				if("INVCPOBillingAdd".equals(action))
				{ 
					 
					SwapSale d = new  SwapSale();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					if(atleastOneBillRow(request,response))
					{
						CPOMethod.addSwapSale(con,apstm, d, request, response);
						String SwapSaleNo=""+session.getAttribute("INVNO");
						salesordernumber = request.getParameter("salesordernumber");
						blockinvoice = d.getBlockinvoice();
						itemInsert(request,response,SwapSaleNo,con,branchid,d.getDivision(),salesordernumber);
						//Insert the Payment commitment table
						int noofpayment = Integer.parseInt(request.getParameter("noofpaymentcommitment"));
						for(int h=0;h<noofpayment;h++)
						{
							asql="INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) VALUE('"+SwapSaleNo+"','C',"+request.getParameter("nettotal")+")";
							CommonFunctions.Execute(asql);
						}
						con.close();   
						response.sendRedirect("Smart Inventory/SwapSaleSerial.jsp?salno="+SwapSaleNo);
					}
					else
					{
						con.close();   
						response.sendRedirect("Smart Inventory/POBilling.jsp");
					
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
	
	
	public static boolean  atleastOneBillRow(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException 
	{
		boolean flag =false;
		try 
		{
			String param[] = request.getParameter("param").split(",");
			String billrow = "";
			for(int p=0;p<param.length; p++)
			{
				billrow =""+request.getParameter("billrow"+param[p].trim());
				if("Y".equals(billrow))
					flag =true;
			}
		
			return flag;
		}
	  
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response); 
		}
		return flag;
	}
	
	
	
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String SwapSaleNo ,Connection con, String branch,String division,String salesordernumber)throws ServletException, IOException 
	{
		try 
		{
			String field="";
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			String itype="",warranty="",rowid="";
			String itemid = "";
			String consumables="";
			String billrow="";
			int pqty=0;
			for(int p=0;p<param.length; p++)
			{
				billrow =""+request.getParameter("billrow"+param[p].trim());
				if(!"Y".equals(billrow))
					billrow ="N";
				if("Y".equals(billrow))
				{
						String e =""+request.getParameter("itype"+param[p].trim());
						itemid =""+request.getParameter("item"+param[p].trim());
						consumables =""+request.getParameter("consumables"+param[p].trim());
						
						pqty =Integer.parseInt(""+request.getParameter("qty"+param[p].trim()));
						
						 
						String productswap="N";
						if(e.equals("1") )
							itype="I";
						if(e.equals("2") )
							itype="P";
						//other products 
						if("P".equals(itype))
						{
							String producttype =  CommonFunctions.QueryExecute( "SELECT CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemid+"'")[0][0];
							if("C".equals(producttype))
							{	
								String checkvalue = ""+request.getParameter("SwapCheckbox"+param[p].trim());
								if(!"Y".equals(checkvalue))
									productswap="N";
								else
									productswap="Y";
							}		
						}
						else
							productswap="N";
						
					 
						//insert into total item 
						field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,INT_WARRANTY, "; 
						field = field+" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_TAXID,DOU_TAX_PERCENTAGE, ";
						field = field+" DOU_TAX_AMOUNT,DOU_TOTAL,CHR_SWAP,INT_CPO_ROWID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS " ;
						sql=" INSERT INTO inv_t_swapsalesitem (" +field+" ) VALUES ( ";
						sql = sql +" ?,?,?,?,?,?,?,"; 
						sql = sql +" ?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' " ;
						sql = sql +")";
						PreparedStatement  apstm = con.prepareStatement(sql);
						apstm.setString(1, branch);
						apstm.setString(2, SwapSaleNo);
						apstm.setString(3, itemid);
						apstm.setString(4, itype);
						apstm.setString(5, (request.getParameter("desc"+param[p].trim()).replace("\"", "")).replaceAll("&", " and"));
						apstm.setString(6, ""+pqty);
						apstm.setString(7, (request.getParameter("warranty"+param[p].trim())));
						apstm.setString(8, (request.getParameter("uprice"+param[p].trim())));
						apstm.setString(9, request.getParameter("discount"+param[p].trim()));
						apstm.setString(10, (request.getParameter("unitdiscount"+param[p].trim())));
						apstm.setString(11, request.getParameter("stax"+param[p].trim()));
						apstm.setString(12, request.getParameter("staxpercentage"+param[p].trim()));
						apstm.setString(13, request.getParameter("staxamount"+param[p].trim()));
						apstm.setString(14, (request.getParameter("total"+param[p].trim())));
						apstm.setString(15, productswap);
						apstm.setString(16,request.getParameter("rowid"+param[p].trim()));
						apstm.setString(17,userId);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						 
						 
						
						//salesordernumber
						
						sql = " UPDATE inv_t_customersalesorderitem SET ";
						sql = sql +" INT_BILLEDQUANTITY = (INT_BILLEDQUANTITY+"+pqty+")";
						sql = sql +" WHERE CHR_SALESORDERNO =? AND CHR_TYPE=? AND CHR_ITEMID=? AND INT_ID=? ";
						apstm = con.prepareStatement(sql);
						apstm.setString(1,salesordernumber);
						apstm.setString(2, itype);
						apstm.setString(3, itemid);
						apstm.setString(4, request.getParameter("rowid"+param[p].trim()));
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						//(INT_QUANTITY-INT_BILLEDQUANTITY)
						sql = " SELECT  IF( ( (SUM(INT_QUANTITY)-SUM(INT_BILLEDQUANTITY)) >0 ) ='0','Y','P') FROM inv_t_customersalesorderitem ";
						sql = sql +" WHERE CHR_SALESORDERNO='"+salesordernumber+"'  ";//  AND CHR_TYPE='"+itype+"' AND CHR_ITEMID='"+itemid+"' 
						String data[][] = CommonFunctions.QueryExecute(sql);
						if(data.length>0)
						{
							sql = " UPDATE inv_t_customersalesorder SET ";
							sql = sql +" CHR_BILLED = ? ,DAT_BILLED_TIME =?, INT_PROGRESSBAR =? ";
							sql = sql +" WHERE CHR_SALESORDERNO =? ";
							apstm = con.prepareStatement(sql);
							apstm.setString(1, data[0][0]);
							apstm.setString(2, DateUtil.getCurrentDateTime());
							if("P".equals(data[0][0]))
								apstm.setString(3, "80");
							else
								apstm.setString(3, "90");
							
							apstm.setString(4, salesordernumber);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
						
						if(!consumables.equals("S"))
						{
							//insert into individual serial number and warranty
							sql ="";
							field ="  INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,DOU_UNITPRICE,CHR_SWAP ," +
							" CHR_USRNAME,DT_UPDATEDATE ,CHR_DESC,CHR_UPDATESTATUS ,CHR_WARRANTY ";
							sql ="INSERT INTO inv_t_swapsalesserialno ( " + field  +" ) ";
							sql = sql+	" VALUES ( ";
							sql = sql+	" ?,?,?,? ,? ,? ,?,DATE(NOW()) ,?,'Y' ,? ";
							sql = sql +")";
							apstm = con.prepareStatement(sql);
							for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
							{
								apstm.setString(1, branch);
								apstm.setString(2, SwapSaleNo);
								apstm.setString(3, itemid);
								apstm.setString(4, itype);
								apstm.setString(5,(request.getParameter("uprice"+param[p].trim())) );
								apstm.setString(6, productswap);
								apstm.setString(7, userId );
								apstm.setString(8, request.getParameter("desc"+param[p].trim()) );
								apstm.setString(9, request.getParameter("warranty"+param[p].trim()) );
								System.out.println(""+apstm);
								apstm.addBatch();
							}
							apstm.executeBatch();
							apstm.close();
						}
						else
						{
							//consumable products
							
							sql = " SELECT FUN_GET_CONSUMABLESTOCK("+branchid+",'"+itemid+"')";
							int stock =Integer.parseInt(CommonFunctions.QueryExecute(sql)[0][0]);
							 
							
							sql = " select DOU_AVGPRICE from inv_t_vendorgoodsreceivedconsumable "; 
							sql = sql + " WHERE  INT_BRANCHID ="+branchid+" AND CHR_ITEMID='"+itemid+"' ORDER BY INT_ROWID desc ";
							String ccdata[][] =CommonFunctions.QueryExecute(sql);
							double averageprice = 0;
							if(ccdata.length>0)
								averageprice=Double.parseDouble(ccdata[0][0]);
							
							sql = "INSERT INTO inv_t_vendorgoodsreceivedconsumable  ";
							sql = sql+" (INT_DIVIID,INT_BRANCHID,CHR_SALESNO,CHR_TYPE,CHR_ITEMID,INT_SQTY,  ";
							sql = sql+" CHR_RDSTATUS,DOU_SALESUNITPRICE,";
							sql = sql + " INT_STOCK,DOU_AVGPRICE ,CHR_INVOICEBLOCK,";
							sql = sql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  "; 
							sql = sql+" VALUES(?,?,?,?,?,?,?,?, ?,?,?,?,DATE(NOW()),'Y' )";
							apstm = con.prepareStatement(sql);
							apstm.setString(1,division );
							apstm.setString(2,branchid );
							apstm.setString(3,SwapSaleNo );
							apstm.setString(4,itype );
							apstm.setString(5,itemid );
							apstm.setString(6,""+pqty );
							apstm.setString(7,"O" );
							apstm.setString(8,request.getParameter("uprice"+param[p].trim()) );
							 
							if((stock-pqty) < 1)
							{
								apstm.setString(9,"0" );
								apstm.setString(10,""+averageprice);
							}
							else
							{
								apstm.setString(9,""+(stock-pqty) );
								apstm.setString(10,""+averageprice );
							} 
							apstm.setString(11,blockinvoice );
							apstm.setString(12,userId );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
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
	
	
}
