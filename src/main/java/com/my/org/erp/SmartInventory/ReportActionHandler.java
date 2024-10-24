package com.my.org.erp.SmartInventory;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class ReportActionHandler extends AbstractActionHandler
{
	String sql=null;
	String repName=null;
	String repHeader=null;
	ResultSet rs;
	Statement st; 
	int totdays;
	int year;
	int i;	
	String s="";
	String branch="";
	String tims;
	int doctorId;
	String startdate;
	String enddate;
	private String FormatDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				//System.out.println("action---------------------------------------------------"+action);
												
				if(action.equals("INVcustomerInfo"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String branchId=request.getParameter("branchId");
					@SuppressWarnings("unused")
					String brch[]=branch.split(",");
					repName="Customer Report ";
					repHeader="Customer Id^Customer Name^State^Mobile No^E-mail^Active,Account No,Bank Name,Balance,Balance Date,Credit Limit";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					if(branchId.equals("all"))
					  sql="SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_STATE,CHR_PHONE,CHR_EMAIL,INT_ACTIVE,CHR_ACCNO,CHR_BANKNAME,DOU_BALANCE,DAT_BALANCEASOF,DOU_CREDITLIMIT FROM INV_M_CUSTOMERINFO";
					else
					  sql="SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_STATE,CHR_PHONE,CHR_EMAIL,INT_ACTIVE,CHR_ACCNO,CHR_BANKNAME,DOU_BALANCE,DAT_BALANCEASOF,DOU_CREDITLIMIT FROM INV_M_CUSTOMERINFO WHERE INT_BRANCHID="+Integer.parseInt(branchId);
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=11;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="CustomerReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();
					con.close();   
					response.sendRedirect("Smart Inventory/CustomerReportView.jsp");
				}
				
				if(action.equals("INVvendorInfo"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String branchId=request.getParameter("branchId");
					
					@SuppressWarnings("unused")
					String brch[]=branch.split(",");
					repName="Vendor Report ";
					repHeader="Customer Id^Customer Name^State^Mobile No^E-mail^Active^Since^Account No^Bank Name^Balance^Balance Date";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					if(branchId.equals("all"))
					sql="SELECT INT_VENDORID,CHR_VENDORNAME,CHR_STATE,CHR_PHONE,CHR_EMAIL,INT_ACTIVE,DAT_SINCE,CHR_ACCNO,CHR_BANKNAME,DOU_BALANCE,DAT_BALANCEASOF FROM INV_M_VENDORSINFO";
					else
						sql="SELECT INT_VENDORID,CHR_VENDORNAME,CHR_STATE,CHR_PHONE,CHR_EMAIL,INT_ACTIVE,DAT_SINCE,CHR_ACCNO,CHR_BANKNAME,DOU_BALANCE,DAT_BALANCEASOF FROM INV_M_VENDORSINFO WHERE INT_BRANCHID="+Integer.parseInt(branchId);
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=11;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="VendorReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Inventory/VendorReportView.jsp");
				}
				
				if(action.equals("INVpurchaseDateWise"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String vendorId=request.getParameter("vendorId");
					String fromDate=FormatDateSQL(request.getParameter("fromdt"));
					String toDate=FormatDateSQL(request.getParameter("todt"));
													
					@SuppressWarnings("unused")
					String brch[]=branch.split(",");
					repName="Vendor Report ";
					repHeader="Order Id^Vendor Name^Request Date^Payment Mode^Due Amount^Tax Amount^Total Amount^Purchase Status^Payment Status";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					if(vendorId.equals("all"))
					{
					sql="SELECT A.INT_PURCHASEORDERID,B.CHR_VENDORNAME,A.DAT_REQUESTDATE,C.CHR_PAYMENTNAME,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_PURCHASESTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_vendorpurchaseorder  A,INV_M_VENDORSINFO B,INV_M_PAYMENTTERMS C WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_VENDORID=B.INT_VENDORID AND A.INT_PAYMENTTERMID=C.INT_PAYMENTTERMID";
					}
					else
					{	
					sql="SELECT A.INT_PURCHASEORDERID,B.CHR_VENDORNAME,A.DAT_REQUESTDATE,C.CHR_PAYMENTNAME,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_PURCHASESTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_vendorpurchaseorder  A,INV_M_VENDORSINFO B,INV_M_PAYMENTTERMS C WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_PAYMENTTERMID=C.INT_PAYMENTTERMID AND A.INT_VENDORID=B.INT_VENDORID AND A.INT_VENDORID="+vendorId;
					}
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=9;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="PurchaseReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseReportView.jsp");
				}
				
				
				if(action.equals("INV_purchaseMonthwise"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String vendorId=request.getParameter("vendorId");
					String month=request.getParameter("Month");
					String year=request.getParameter("Year");
					String fromDate=""+year +"-"+month+"-"+1;
					String toDate=""+year +"-"+month+"-"+31;
					
					@SuppressWarnings("unused")
					String brch[]=branch.split(",");
					repName="Vendor Report ";
					repHeader="Order Id^Vendor Name^Request Date^Payment Mode^Due Amount^Tax Amount^Total Amount^Purchase Status^Payment Status";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					if(vendorId.equals("all"))
					{
					sql="SELECT A.INT_PURCHASEORDERID,B.CHR_VENDORNAME,A.DAT_REQUESTDATE,C.CHR_PAYMENTNAME,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_PURCHASESTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_vendorpurchaseorder  A,INV_M_VENDORSINFO B,INV_M_PAYMENTTERMS C WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_VENDORID=B.INT_VENDORID AND A.INT_PAYMENTTERMID=C.INT_PAYMENTTERMID";
					}
					else
					{	
					sql="SELECT A.INT_PURCHASEORDERID,B.CHR_VENDORNAME,A.DAT_REQUESTDATE,C.CHR_PAYMENTNAME,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_PURCHASESTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_vendorpurchaseorder  A,INV_M_VENDORSINFO B,INV_M_PAYMENTTERMS C WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_PAYMENTTERMID=C.INT_PAYMENTTERMID AND A.INT_VENDORID=B.INT_VENDORID AND A.INT_VENDORID="+vendorId;
					}
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=9;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="PurchaseReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseMonthWise.jsp");
				}
				
				if(action.equals("INVsalesDateWise"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String customerId=request.getParameter("customerId");
					String fromDate=FormatDateSQL(request.getParameter("fromdt"));
					String toDate=FormatDateSQL(request.getParameter("todt"));
													
					@SuppressWarnings("unused")
					String brch[]=branch.split(",");
					repName="Sales Report ";
					repHeader="Order Id^Sales Name^Request Date^Payment Mode^Due Amount^Tax Amount^Total Amount^Purchase Status^Payment Status";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					if(customerId.equals("all"))
					{
					sql="SELECT A.INT_SALESORDERID,B.CHR_CUSTOMERNAME,A.DAT_ORDERDATE,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_ORDERSTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_customersalesorder   A,INV_M_CUSTOMERINFO B WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_CUSTOMERID=B.INT_CUSTOMERID";
					}
					else
					{	
					sql="SELECT A.INT_PURCHASEORDERID,B.CHR_CUSTOMERNAME,A.DAT_ORDERDATE,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_ORDERSTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_customersalesorder   A,INV_M_CUSTOMERINFO B WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_CUSTOMERID=B.INT_CUSTOMERID AND A.INT_CUSTOMERID="+customerId;
					}
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=8;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="SalesReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Inventory/SalesReportView.jsp");
				}
				
				if(action.equals("INV_salesMonthwise"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String customerId=request.getParameter("customerId");
					String month=request.getParameter("Month");
					String year=request.getParameter("Year");
					String fromDate=""+year +"-"+month+"-"+1;
					String toDate=""+year +"-"+month+"-"+31;
													
					@SuppressWarnings("unused")
					String brch[]=branch.split(",");
					repName="Sales Report ";
					repHeader="Order Id^Sales Name^Request Date^Payment Mode^Due Amount^Tax Amount^Total Amount^Purchase Status^Payment Status";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					if(customerId.equals("all"))
					{
					sql="SELECT A.INT_SALESORDERID,B.CHR_CUSTOMERNAME,A.DAT_ORDERDATE,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_ORDERSTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_customersalesorder   A,INV_M_CUSTOMERINFO B WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_CUSTOMERID=B.INT_CUSTOMERID";
					}
					else
					{	
					sql="SELECT A.INT_PURCHASEORDERID,B.CHR_CUSTOMERNAME,A.DAT_ORDERDATE,";
                    sql=sql+"A.DOU_AMOUNT,A.DOU_TAXAMOUNT,A.DOU_TOTALAMOUNT,A.INT_ORDERSTATUS,A.INT_PAYMENTSTATUS"; 
                    sql=sql+" FROM  inv_t_customersalesorder   A,INV_M_CUSTOMERINFO B WHERE A.DAT_ORDERDATE>='"+fromDate+"' AND ";
                    sql=sql+" A.DAT_ORDERDATE<='"+toDate+"' AND A.INT_CUSTOMERID=B.INT_CUSTOMERID AND A.INT_CUSTOMERID="+customerId;
					}
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=8;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="SalesReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();
					con.close();   
					response.sendRedirect("Smart Inventory/SalesMonthReport.jsp");
				}
				
				
				if(action.equals("INVstockInfo"))
				{
					String fline="";
					Statement st=con.createStatement();	
					String branchId=request.getParameter("branchId");
					String productId=request.getParameter("productId");					
					repName="Product Report ";
					repHeader="Product Id^Item Id^Item Name^Active^Purchase Price^Sales Price^Stock In Hand^Outside Stock";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
				    sql="select I.CHR_PRODUCTID,I.CHR_ITEMID,I.CHR_ITEMNAME,I.INT_ACTIVE,I.DOU_PURCHASEPRICE,";
				    sql=sql+" I.DOU_SALESPRICE,S.INT_STOCKINHAND "; 
				    sql=sql+" from INV_M_ITEM I,INV_T_STOCK S WHERE I.CHR_PRODUCTID='"+productId+"' AND I.INT_BRANCHID="+Integer.parseInt(branchId);
				    sql=sql+" AND I.CHR_ITEMID=S.CHR_ITEMID AND I.INT_BRANCHID=S.INT_BRANCHID ";
					rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=8;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="StockReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Inventory/StockReportView.jsp");
				}
				if(action.equals("INVstockDateWise"))
				{
					String fline="";
					Statement st=con.createStatement();				
					String fromDate=FormatDateSQL(request.getParameter("fromdt"));
					String toDate=FormatDateSQL(request.getParameter("todt"));											
					
					repName="Stock Report DateWise ";
					repHeader="Order Id^Order Date^Item Id^Quantity^Unit Price^Discount^Price";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					
					sql="select a.INT_PURCHASEORDERID,a.DAT_ORDERDATE,b.chr_ItemId,b.INT_QUANTITY,";
					sql=sql+" b.DOU_UNITPRICE,b.DOU_DISCOUNT,b.DOU_PRICE from  inv_t_vendorpurchaseorder  a ,";
					sql=sql+"  inv_t_vendorpurchaseorderitem b where a.DAT_ORDERDATE>='"+fromDate+"' ";
					sql=sql+" AND a.DAT_ORDERDATE<='"+toDate+"' AND a.INT_PURCHASEORDERID=b.INT_PURCHASEORDERID ";
					
						rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=7;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="StockReportDate.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Inventory/StockReportDatewiseView.jsp");
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


