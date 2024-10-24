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
public class QutotationMethod extends HttpServlet
{
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
 
public static void QutotationAdd(HttpServletRequest request, HttpServletResponse  response,Connection con)  throws IOException, ServletException 
    {
    	 try
    	 {
	    		HttpSession session=request.getSession();			
	 			String user=""+session.getAttribute("USRID");
	 			String branch=""+session.getAttribute("STKBRANCH");
	 			CallableStatement cs ;
	 			String sql="";
	 			 
				String customerId = request.getParameter("customerId");
				String Shipping = request.getParameter("Shipping");
				String shippingaddress = request.getParameter("shippingaddress");
				String division = request.getParameter("division");
				String Financialyear = request.getParameter("Financialyear");
				String quotationDate = request.getParameter("saleDate");
				String payment = request.getParameter("payment");
				String oref = request.getParameter("oref");
				String dnote = request.getParameter("dnote");
				String dthru = request.getParameter("dthru");
				String destination = request.getParameter("destination");
				String tdelivery = request.getParameter("tdelivery");
				String cdetails = request.getParameter("cdetails");
				String cnumber = request.getParameter("cnumber");
				String memo = request.getParameter("memo");
				String ref = request.getParameter("ref");
				String totals = request.getParameter("totals");
				String totaldiscount = request.getParameter("totaldiscount");
				String tax = request.getParameter("tax");
				String taxamount = request.getParameter("salestaxamount");
				String nettotal = request.getParameter("nettotal");
				String ids[] = request.getParameter("param").split(",");
				String quotationnumber=StockFunctions.quotationNumber()+"/QUOT/"+StockFunctions.AccountYear()+"/"+StockFunctions.invoiceLocation(branch)+"/"+StockFunctions.invoiceDivision(division);
				
				 
				//Send a data to con_inv_t_quotation 
				cs = con.prepareCall("{call  CON_INV_PRO_QUOTATION(?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,? )}");
				cs.setString(1, "INSERT");
				cs.setString(2, "");
				cs.setString(3,branch);
				cs.setString(4,quotationnumber);
				cs.setString(5,customerId);
				cs.setString(6,Shipping);
				cs.setString(7, shippingaddress);
				cs.setString(8,Financialyear);
				cs.setString(9,division);
				cs.setString(10,DateUtil.FormateDateSQL(quotationDate));
				cs.setString(11,payment);
				cs.setString(12,oref); 
				cs.setString(13,dnote);
				cs.setString(14,dthru); 
				cs.setString(15,destination);
				cs.setString(16,tdelivery);
				cs.setString(17,cdetails);
				cs.setString(18,cnumber);
				cs.setString(19,memo); 
				cs.setString(20,ref);
				cs.setString(21,totals);
				cs.setString(22,totaldiscount);
				cs.setString(23,tax);
				cs.setString(24,taxamount);
				cs.setString(25,nettotal);
				cs.setString(26,user);
				// System.out.println(""+cs);
				cs.execute();
				cs.close();

				
				sql=" INSERT INTO con_inv_m_startingquotationno VALUES ("+StockFunctions.quotationNumber()+")";
				// System.out.println(sql);
				Statement st = con.createStatement();
				st.execute(sql);
				st.close();
				
				 
				//Send a data to con_inv_t_quotationdetail 
				cs = con.prepareCall("{call CON_INV_PRO_QUOTATIONDETAIL (?,?,?,?,?,?,?,?,?,?,?,?)}");
				for(int u=0;u<ids.length;u++)
				{
					cs.setString(1,"INSERT");
					cs.setString(2,"");
					cs.setString(3,quotationnumber);
					cs.setString(4,""+request.getParameter("itype"+ids[u]));
					cs.setString(5,""+request.getParameter("item"+ids[u]));
					cs.setString(6,""+request.getParameter("qty"+ids[u]));
					cs.setString(7,""+request.getParameter("uprice"+ids[u]));
					cs.setString(8,"0.0");
					cs.setString(9,""+request.getParameter("discount"+ids[u]));
					cs.setString(10,""+request.getParameter("unitdiscount"+ids[u]));
					cs.setString(11,""+request.getParameter("total"+ids[u]));
					// System.out.println(""+cs);
					cs.setString(12,user);
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
	
  
  
  
  
  
  
  
  
  
  
  public static void QutotationDelete(HttpServletRequest request, HttpServletResponse  response,Connection con)  throws IOException, ServletException 
  {
  	 try
  	 {
	    		HttpSession session=request.getSession();			
	 			String user=""+session.getAttribute("USRID");
	 			String branch=""+session.getAttribute("STKBRANCH");
	 			CallableStatement cs ;
	 			String sql="";
	 			String ids[] = request.getParameterValues("ID");
	 			String reason =request.getParameter("reason");
	 			for(int u=0;u<ids.length;u++)
	 			{
	 				sql = "SELECT a.CHR_SALESNUMBER, a.INT_GROUPID,a.INT_ITEMID,a.INT_QUANTITY FROM  con_inv_t_salesdetail  a WHERE a.CHR_SALESNUMBER =(SELECT b.CHR_SALESNUMBER FROM con_inv_t_sales b WHERE INT_SALESID="+ids[u]+")";
	 				String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 				
	 				// Delete a record from con_inv_sales
	 				cs = con.prepareCall("{call  STOCK_PRO_SALE(?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?)}");
					cs.setString(1, "DELETE");
					cs.setString(2, ids[u]);
					cs.setString(3,"");
					cs.setString(4,"");
					cs.setString(5,"");
					cs.setString(6,"");
					cs.setString(7,"");
					cs.setString(8, "");
					cs.setString(9,"");
					cs.setString(10,"");
					cs.setString(11,null);
					cs.setString(12,"");
					cs.setString(13,""); 
					cs.setString(14,"");
					cs.setString(15,""); 
					cs.setString(16,"");
					cs.setString(17,"");
					cs.setString(18,"");
					cs.setString(19,"");
					cs.setString(20,"");
					cs.setString(21,"");
					cs.setString(22,"");
					cs.setString(23,"");
					cs.setString(24,"");
					cs.setString(25,"");
					cs.setString(26,"");
					cs.setString(27,"");
					cs.setString(28,user);
					cs.execute();
					cs.close();
					
					
					// Delete a record from con_inv_salesdetails
					cs = con.prepareCall("{call STOCK_PRO_SALESDETAIL (?,?,?,?,?,?,?,?,?,?,?,?)}");
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
					cs.setString(12,"");
					cs.execute();
					cs.close();
					
					
					//Add a quantity from con_ inv_t_stock 
					cs = con.prepareCall("{call STOCK_PRO_STOCKADD (?,?,?,?)}");
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
					
					
					//Send a data to con_inv_t_salesdelete
					cs = con.prepareCall("{call STOCK_COM_SALEDELETE (?,?,?,?,?)}");
					cs.setString(1,"INSERT");
					cs.setString(2,branch);
					cs.setString(3,data[0][0]);
					cs.setString(4,reason);
					cs.setString(5,user);
					cs.execute();
					cs.close();
					
					//Delete a data to con_inv_t_purchasepayment
					cs = con.prepareCall("{call STOCK_COM_SALEPAYMENT (?,?)}");
					cs.setString(1,"DELETE");
					cs.setString(2,data[0][0]);
					cs.execute();
					cs.close();
					
					
	 			}
				 

  	 } 
  	 catch (Exception e) 
  	 {
  		
		 } 
  }	
	
  
}
