package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Statement;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
 
import com.my.org.erp.common.StockFunctions;
public class DirectPurchaseMethod extends HttpServlet
{
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


public static void purchaseAdd(HttpServletRequest request, HttpServletResponse  response,Connection con)  throws IOException, ServletException 
    {
    	 try
    	 {
	    		HttpSession session=request.getSession();			
	 			String user=""+session.getAttribute("USRID");
	 			String branch=""+session.getAttribute("STKBRANCH");
	 			CallableStatement cs ;
	 			String sql="";
	 			String cashpurchaseno = request.getParameter("cashpurchaseno");
				String vendorid = request.getParameter("vendorid");
				String division = request.getParameter("division");
				String purchasedate = request.getParameter("purchasedate");
				String payment = request.getParameter("payment");
				String memo = request.getParameter("memo");
				String ref = request.getParameter("ref");
				String totals = request.getParameter("totals");
				String totaldiscount = request.getParameter("totaldiscount");
				String tax = request.getParameter("tax");
				String salestaxamount = request.getParameter("salestaxamount");
				String nettotal = request.getParameter("nettotal");
				String ids[] = request.getParameter("param").split(",");
				String ponumber=StockFunctions.purchaseNumber()+"/PO/"+StockFunctions.AccountYear()+"/"+StockFunctions.invoiceLocation(branch)+"/"+StockFunctions.invoiceDivision(division);
				
				//Send a data to con_inv_t_purchse 
				cs = con.prepareCall("{call  STOCK_PRO_PURCHASE (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "");
				cs.setString(3,branch);
				cs.setString(4,ponumber);
				cs.setString(5,vendorid);
				cs.setString(6,division);
				cs.setString(7,cashpurchaseno);
				cs.setString(8,payment);
				cs.setString(9,DateUtil.FormateDateSQL(purchasedate));
				cs.setString(10,"");
				cs.setString(11,memo);
				cs.setString(12,ref);
				cs.setString(13,totals);
				cs.setString(14,totaldiscount);
				cs.setString(15,tax);
				cs.setString(16,salestaxamount);
				cs.setString(17,nettotal);
				cs.setString(18,user);
				cs.execute();
				// System.out.println(""+cs);
				cs.close();
				
				sql=" INSERT INTO con_inv_m_startingpurchaseno VALUES ("+StockFunctions.purchaseNumber()+")";
				// System.out.println(""+sql);
				Statement st = con.createStatement();
				st.execute(sql);
				st.close();
				
				//Send a data to con_inv_t_purchsedetail 
				cs = con.prepareCall("{call STOCK_PRO_PURCHASEDETAIL (?,?,?,?,?,?,?,?,?,?,?)}");
				for(int u=0;u<ids.length;u++)
				{
					cs.setString(1,"INSERT");
					cs.setString(2,"");
					cs.setString(3,ponumber);
					cs.setString(4,""+request.getParameter("itype"+ids[u]));
					cs.setString(5,""+request.getParameter("item"+ids[u]));
					cs.setString(6,""+request.getParameter("qty"+ids[u]));
					cs.setString(7,""+request.getParameter("uprice"+ids[u]));
					cs.setString(8,""+request.getParameter("discount"+ids[u]));
					cs.setString(9,""+request.getParameter("unitdiscount"+ids[u]));
					cs.setString(10,""+request.getParameter("total"+ids[u]));
					cs.setString(11,user);
					// System.out.println(""+cs);
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				
				//	Send a data to con_ inv_t_stock 
				cs = con.prepareCall("{call STOCK_PRO_STOCKADD (?,?,?,?)}");
				for(int u=0;u<ids.length;u++)
				{
					cs.setString(1,branch);
					cs.setString(2,request.getParameter("item"+ids[u]));
					cs.setString(3,request.getParameter("qty"+ids[u]));
					cs.setString(4,user);
					cs.addBatch(); 
				}
				cs.executeBatch();
				cs.close();

    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
    
  public static void purchaseDelete(HttpServletRequest request, HttpServletResponse  response,Connection con)  throws IOException, ServletException 
  {
  	 try
  	 {
	    		HttpSession session=request.getSession();			
	 			String user=""+session.getAttribute("USRID");
	 			String branch=""+session.getAttribute("STKBRANCH");
	 			CallableStatement cs ;
	 			String sql="";
	 			String ids[] = request.getParameterValues("Purchaseid");
	 			String reason =request.getParameter("reason");
	 			for(int u=0;u<ids.length;u++)
	 			{
	 				sql = "SELECT a.CHR_PURCHASEREFNUMBER, a.INT_GROUPID,a.INT_ITEMID,a.INT_QUANTITY FROM  con_inv_t_purchsedetail  a WHERE a.CHR_PURCHASEREFNUMBER =(SELECT b.CHR_PURCHASEREFNUMBER FROM con_inv_t_purchase b WHERE INT_PURCHASEID="+ids[u]+")";
	 				String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 				
	 				// Delete a record from con_inv_purchase
	 				cs = con.prepareCall("{call  STOCK_PRO_PURCHASE (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, "DELETE");
					cs.setString(2, ids[u]);
					cs.setString(3,"");
					cs.setString(4,"");
					cs.setString(5,"");
					cs.setString(6,"");
					cs.setString(7,"");
					cs.setString(8,"");
					cs.setString(9,"");
					cs.setString(10,"");
					cs.setString(11,"");
					cs.setString(12,"");
					cs.setString(13,"");
					cs.setString(14,"");
					cs.setString(15,"");
					cs.setString(16,"");
					cs.setString(17,"");
					cs.setString(18,"");
					cs.execute();
					cs.close();
					
					// Delete a record from con_inv_purchasedetails
					cs = con.prepareCall("{call STOCK_PRO_PURCHASEDETAIL (?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1,"DELETE");
					cs.setString(2,"");
					cs.setString(3,data[0][0]);
					cs.setString(4,"");
					cs.setString(5,"");
					cs.setString(6,"");
					cs.setString(7,"");
					cs.setString(8,"");
					cs.setString(9,"");
					cs.setString(10,"");
					cs.setString(11,"");
					cs.execute();
					cs.close();
					
					//Delete a quantity from con_ inv_t_stock 
					cs = con.prepareCall("{call STOCK_PRO_STOCKDELETE (?,?,?,?)}");
					for(int v=0;v<data.length;v++)
					{
						cs.setString(1,branch);
						cs.setString(2,data[v][2]);
						cs.setString(3,data[v][3]);
						cs.setString(4,user);
						cs.addBatch(); 
					}
					cs.executeBatch();
					cs.close();
					
					
					//Send a data to con_inv_t_purchasedelete
					cs = con.prepareCall("{call STOCK_COM_PURCHASEDELETE (?,?,?,?,?)}");
					cs.setString(1,"INSERT");
					cs.setString(2,branch);
					cs.setString(3,data[0][0]);
					cs.setString(4,reason);
					cs.setString(5,user);
					cs.execute();
					cs.close();
					
					//Delete a data to con_inv_t_purchasepayment
					cs = con.prepareCall("{call STOCK_COM_PURCHASEPAYMENTDELETE (?,?)}");
					cs.setString(1,"DELETE");
					cs.setString(2,data[0][0]);
					cs.execute();
					cs.close();
					
					
	 			}
				 

  	 } 
  	 catch (Exception e) 
  	 {
			 System.out.println(e.getMessage());
		 } 
  }	
	

}
