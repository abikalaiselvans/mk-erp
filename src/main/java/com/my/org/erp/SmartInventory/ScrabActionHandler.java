package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class ScrabActionHandler extends AbstractActionHandler
{
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action=""+request.getParameter("actionS").trim();
			HttpSession session=request.getSession();			
			String branchid = session.getAttribute("INVBRANCH").toString();
			String user = session.getAttribute("USRID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			Statement st = con.createStatement();
			if (action.equals("INVScrabAdd")) 
			{
 				String divis = request.getParameter("divis");
				String divisionid=divis;
				
				//String dcno=  "DC/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.deliverychallanNumber()+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
				
				String dcno =  InventoryInvoiceFunctions.scrabnumberGet(""+session.getAttribute("INVSTATE"));
				
				
				String DCDate = request.getParameter("saleDate");
				DCDate= DateUtil.FormateDateSQL(DCDate);
				String customer = request.getParameter("customer");
				String ref = request.getParameter("ref");
				String memo = request.getParameter("memo");
				String Shipping = request.getParameter("Shipping");
				String shippingaddress = request.getParameter("shippingaddress");
				String oref = request.getParameter("oref");
				String dnote = request.getParameter("dnote");
				String dthru = request.getParameter("dthru");
				String destination = request.getParameter("destination");
				String tdelivery = request.getParameter("tdelivery");
				String cdetails = request.getParameter("cdetails");
				String cnumber = request.getParameter("cnumber");
				String param[] = request.getParameter("param").split(",");
				asql ="INSERT INTO inv_t_scrab (INT_BRANCHID,CHR_SCRABNO,DAT_SCRABDATE,INT_CUSTOMERID," +
						"CHR_DES,CHR_REF,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE," +
						"CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS," +
						"CHR_CONTACTNO,INT_DIVIID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
				asql = asql +" VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),'Y' )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,branchid);
				apstm.setString(2,dcno);
				apstm.setString(3,DCDate);
				apstm.setString(4,customer);
				apstm.setString(5,memo);
				apstm.setString(6,ref);
				apstm.setString(7,Shipping);
				apstm.setString(8,shippingaddress);
				apstm.setString(9,oref);
				apstm.setString(10,dnote);
				apstm.setString(11,dthru);
				apstm.setString(12,destination);
				apstm.setString(13,tdelivery);
				apstm.setString(14,cdetails);
				apstm.setString(15,cnumber);
				apstm.setString(16,divisionid);
				apstm.setString(17,user);
				System.out.println(""+apstm);
				apstm.execute();
				
				

				apstm=con.prepareStatement("  SELECT FUN_INV_DIRECT_SCRAB_INSERT(?) ");
				apstm.setString(1,""+session.getAttribute("INVSTATE"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				 
				 String consumable="";
				for(int u=0;u<param.length;u++)
				{
					consumable="";
					asql="INSERT INTO inv_t_scrabitem (INT_BRANCHID,CHR_SCRABNO,CHR_ITEMID,CHR_TYPE," +
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
					apstm.setString(2,dcno);
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
							asql="INSERT INTO inv_t_scrabitemserial (INT_BRANCHID,CHR_SCRABNO,CHR_ITEMID,CHR_TYPE," +
							"CHR_DESC,CHR_SERIALNO,CHR_WARRANTY,CHR_USRNAME,DT_UPDATEDATE," +
							"CHR_UPDATESTATUS) VALUES (?,?,?,?,?,?,?,?,now(),'Y')";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,branchid);
							apstm.setString(2,dcno);
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
				response.sendRedirect("Smart Inventory/ScrabSerialNumber.jsp?salesid="+dcno);						
			}
			if (action.equals("INVScrabEdit")) 
			{
				String dcno=""+request.getParameter("dcno");
				String division=""+request.getParameter("division");
				String seriallength = ""+request.getParameter("seriallength");
				int sl = Integer.parseInt(seriallength);
				if(sl>0)
				{
					if(checkSerialNumberSale(seriallength,request, response))
					{
						for(int u=0;u<sl;u++)
						{
							asql = " UPDATE inv_t_scrabitemserial SET ";
							asql = asql +" CHR_SERIALNO = ?";
							asql = asql +" WHERE CHR_SCRABNO =?";
							asql = asql +" AND INT_ROWID =? ";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,request.getParameter("serial"+(u+1)));
							apstm.setString(2,dcno);
							apstm.setString(3,request.getParameter("rowid"+(u+1)));
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							asql = "UPDATE inv_t_vendorgoodsreceived SET  INT_DIVIID =?, ";
							asql = asql + " CHR_QUALITY=?, CHR_DCNO=? WHERE CHR_SERIALNO=? "; 
							apstm = con.prepareStatement(asql);
							apstm.setString(1,division);
							apstm.setString(2,"N");
							apstm.setString(3,dcno);
							apstm.setString(4,request.getParameter("serial"+(u+1)));
							System.out.println(""+apstm);
							apstm.execute();
							 
						}
						asql = " UPDATE inv_t_scrab SET ";
						asql = asql +" CHR_STATUS = ?";
						asql = asql +" WHERE CHR_SCRABNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"Y");
						apstm.setString(2,dcno);
						System.out.println(""+apstm);
						apstm.execute();
						System.out.println("Completed...");
						response.sendRedirect("Smart Inventory/Scrab.jsp");
					}
					else
					{
						con.close();
						response.sendRedirect("Smart Inventory/Scrabserialcheck.jsp?salno="+dcno) ;
					}
				}
				else
				{
					asql = " UPDATE inv_t_scrab SET ";
					asql = asql +" CHR_STATUS = ?";
					asql = asql +" WHERE CHR_SCRABNO =?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y");
					apstm.setString(2,dcno);
					System.out.println(""+apstm);
					apstm.execute();
					
					
					con.close();
					response.sendRedirect("Smart Inventory/Scrab.jsp");
				}
				
					 
			}
			else if("INVScrabDelete".equals(action))
			{
				String dcnos[]=request.getParameterValues("salesid");
				for(int u=0;u<dcnos.length;u++)
				{
					asql ="SELECT CHR_SERIALNO FROM inv_t_scrabitem WHERE CHR_SCRABNO='"+dcnos[u]+"'";
					String data[][] =  CommonFunctions.QueryExecute(asql);
					for(int y=0;y<data.length;y++)
					{
						asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',CHR_QUALITY='Y', CHR_DCNO='"+dcnos[u]+"' WHERE CHR_SERIALNO='"+data[u][0]+"'";
						st.execute(asql);
					}
					asql="DELETE FROM inv_t_scrabitemserial WHERE CHR_SCRABNO='"+dcnos[u]+"'";
					st.execute(asql);
					asql="DELETE FROM inv_t_scrabitem WHERE CHR_SCRABNO='"+dcnos[u]+"'";
					st.execute(asql);
					asql="DELETE FROM inv_t_scrab WHERE CHR_SCRABNO='"+dcnos[u]+"'";
					st.execute(asql);
				}
				con.close();   
				response.sendRedirect("Smart Inventory/Scrab.jsp");
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
