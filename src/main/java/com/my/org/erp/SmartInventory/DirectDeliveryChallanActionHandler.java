package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;


public class DirectDeliveryChallanActionHandler extends AbstractActionHandler
{
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action=""+request.getParameter("actionS").trim();
			HttpSession session=request.getSession();			
			String branchid = session.getAttribute("BRANCHID").toString();
			String user = session.getAttribute("USRID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			Statement st = con.createStatement();
			if (action.equals("INVDirectDeliveryChallanAdd")) 
			{
				String divis = request.getParameter("divis");
				String divisionid=divis;
				String dcno=  "DC/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.directDCNumber()+"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
				String DCDate = request.getParameter("saleDate");
				DCDate = DateUtil.FormateDateSQL(DCDate);
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
				
				asql ="INSERT INTO inv_t_directdc (INT_BRANCHID,CHR_DCNO,DAT_DCDATE,INT_CUSTOMERID," +
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
				
				asql=" INSERT INTO inv_m_directdcgenerate VALUES (?)";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,InventoryInvoiceFunctions.directDCNumber());
				apstm.execute();
				
				asql="INSERT INTO inv_t_directdcitem (INT_BRANCHID,CHR_DCNO,CHR_ITEMID,CHR_TYPE," +
						"CHR_DESC, CHR_SERIALNO,CHR_WARRANTY,CHR_USRNAME,DT_UPDATEDATE," +
						"CHR_UPDATESTATUS) VALUES (?,?,?,?,?,?,?,?,now(),'Y')";
				apstm = con.prepareStatement(asql);
				for(int u=0;u<param.length;u++)
				{
					String Type=""+request.getParameter("itype"+param[u]); 
					String Item=""+request.getParameter("item"+param[u]);
					String Description=""+request.getParameter("desc"+param[u]);
					String Serial=""+request.getParameter("serial"+param[u]);
					String Warranty=""+request.getParameter("Warrantys"+param[u]); 
					if("1".equals(Type))
						Type="I";
					else if("2".equals(Type))
						Type="P";
	 				apstm.setString(1,branchid);
					apstm.setString(2,dcno);
					apstm.setString(3,Item );
					apstm.setString(4,Type);
					apstm.setString(5,Description );
					apstm.setString(6,Serial );
					apstm.setString(7,Warranty );
					apstm.setString(8,user );
					apstm.addBatch();
 					
					asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='D', CHR_QUALITY='H',CHR_DCNO='"+dcno+"' WHERE CHR_SERIALNO='"+Serial+"' "; 
					st.execute(asql);
				}	
				apstm.executeBatch();
				apstm.close();
				con.close();   
 				response.sendRedirect("Smart Inventory/DirectDeliverychallan.jsp");						
			}
			else if("INVDirectDeliveryChallanDelete".equals(action))
			{
				String dcnos[]=request.getParameterValues("salesid");
				for(int u=0;u<dcnos.length;u++)
				{
					asql="DELETE FROM inv_t_directdc WHERE CHR_DCNO='"+dcnos[u]+"'";
					st.execute(asql);
					asql ="SELECT CHR_SERIALNO FROM inv_t_directdcitem WHERE CHR_DCNO='"+dcnos[u]+"'";
					String data[][] =  CommonFunctions.QueryExecute(asql);
					for(int y=0;y<data.length;y++)
					{
						asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',CHR_QUALITY='Y', CHR_DCNO='"+dcnos[u]+"' WHERE CHR_SERIALNO='"+data[u][0]+"'";
						st.execute(asql);
					}
					
					asql="DELETE FROM inv_t_directdcitem WHERE CHR_DCNO='"+dcnos[u]+"'";
					st.execute(asql);
				}
				con.close();   
				response.sendRedirect("Smart Inventory/DirectDeliverychallan.jsp");
			}
			else if("INVDirectDeliveryChallanClosed".equals(action))
			{
				String dcno=request.getParameter("dcno");
				String reason=request.getParameter("reason");
				asql="UPDATE  inv_t_directdc SET CHR_CLOSEDBY=?,CHR_REASON=?,CHR_CLOSEDDATE=NOW(),INT_DCSTATUS=? WHERE CHR_DCNO=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,""+session.getAttribute("EMPID"));
				apstm.setString(2,reason);
				apstm.setString(3,"1");
				apstm.setString(4,dcno);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
 
				asql ="SELECT CHR_SERIALNO FROM inv_t_directdcitem WHERE CHR_DCNO='"+dcno+"'";
				String data[][] = CommonFunctions.QueryExecute(asql);
				for(int u=0;u<data.length;u++)
				{
					asql = "UPDATE inv_t_vendorgoodsreceived SET CHR_FLAG='N',CHR_QUALITY='Y',  CHR_DCNO=null  WHERE CHR_SERIALNO='"+data[u][0]+"'";
					st.execute(asql);
				}
				con.close();   
				response.sendRedirect("Smart Inventory/DirectDeliverychallan.jsp");
			}
			st.close();
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
