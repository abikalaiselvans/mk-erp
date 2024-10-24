package com.my.org.erp.SmartInventory;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DBConnection.DBCon;

 

import com.my.org.erp.bean.Branch; 
import com.my.org.erp.common.CommonFunctions;




/*
String filepath = request.getRealPath("/");
File f = null;
 f = new File(filepath+"uploadfiles/CPO_Order/"+readData[u][1].replaceAll("/","_")+".pdf");
	if(f.exists())
		sb.append("<Download>Y</Download>");
	else
	 sb.append("<Download>N</Download>");
	 */
	
@WebServlet("/inventory")
public class InventoryAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];
	ArrayList<Branch> branchList = new ArrayList<Branch>();
    ArrayList<Product> productList = new ArrayList<Product>();
    ArrayList<Item> itemList = new ArrayList<Item>();
    ArrayList<Products> productsList = new ArrayList<Products>();
    ArrayList<Stock> stockList = new ArrayList<Stock>();  
    ArrayList<Quotation> quotationList = new ArrayList<Quotation>();
    ArrayList<Customer> customerList = new ArrayList<Customer>();
    ArrayList<GoodsReceive> goodsList = new ArrayList<GoodsReceive>();
    ArrayList<GoodsReceive> goodsReturnList = new ArrayList<GoodsReceive>();
    ArrayList<com.my.org.erp.SmartInventory.SearchProduct> searchProductList = new ArrayList<com.my.org.erp.SmartInventory.SearchProduct>();
    int i;
   
    public InventoryAJAX() 
    {
		super();
		i=1;
		 
	}
    
    public void init(ServletConfig config) throws ServletException 
    {        
        try
        {
          i=2;
        }
        catch(Exception e)
        {
        	 
        	 
        }   
    }   
  
    
    
    private void searchProductData(HttpServletRequest request, HttpServletResponse  response)throws IOException, ServletException 
    {
    	 try 
    	 {
    		 String productId=request.getParameter("id");
    		 String producttxtstr=request.getParameter("startLetter");
    	     String sql ="";
    		 sql="SELECT A.CHR_PRODUCTID,A.CHR_PRODUCTNAME FROM INV_M_PRODUCT A,INV_M_PRODUCTGROUP B WHERE ";
    	     sql=sql+"A.INT_PRODUCTGROUPID=B.INT_PRODUCTGROUPID AND B.INT_PRODUCTGROUPID="+Integer.parseInt(productId);
    		 String readData[][] = CommonFunctions.QueryExecute(sql);
		 	 StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 {
		 			if(readData[u][1].startsWith(producttxtstr) || "".equals(producttxtstr))
		    	     { 
		    	 		sb.append("<Searche>");
	     				sb.append("<Id>" + readData[u][0] +"</Id>");
	     				sb.append("<Name>" + readData[u][1]+ "</Name>");
	     				sb.append("</Searche>");	
		    	     }
	     		}	
		 		response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<Searches>" + sb.toString() + "</Searches>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}		
		} 
    	catch (Exception e) 
    	{
    		 
		} 
    }
    
    
    private void searchItemData(HttpServletRequest request, HttpServletResponse  response)throws IOException, ServletException 
    {
    	 try 
    	 {
    		 String productId=request.getParameter("id");
    		 String producttxtstr=request.getParameter("txtSer");
    	     String sql ="";
    		 sql="SELECT A.CHR_ITEMID,A.CHR_ITEMNAME,A.DOU_PURCHASEPRICE,A.DOU_SALESPRICE,A.INT_STOCKINHAND FROM INV_M_ITEM A,INV_M_PRODUCT B WHERE ";
    	     sql=sql+"A.CHR_PRODUCTID=B.CHR_PRODUCTID AND B.CHR_PRODUCTID='"+productId+"'";
    	     // //System.out.println("---------------In Item ----------------------"+sql); 
    		 String readData[][] = CommonFunctions.QueryExecute(sql);
		 	 StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 {
		 			if(readData[u][1].startsWith(producttxtstr) || "".equals(producttxtstr))
		    	     { 
		    	     
		 				sb.append("<ISearch>");
	     				sb.append("<Id>" + readData[u][0] +"</Id>");
	     				sb.append("<Name>" + readData[u][1]+ "</Name>");
	     				sb.append("<PurAmt>" + readData[u][2]+ "</PurAmt>");
	     				sb.append("<SalAmt>" + readData[u][3]+ "</SalAmt>");
	     				sb.append("<Stock>" + readData[u][4]+ "</Stock>");
	     				sb.append("</ISearch>");	
		    	     }
	     		}	
		 	
	        	response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<ISearches>" + sb.toString() + "</ISearches>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}		
		} 
    	catch (Exception e) 
    	{
    		 
		} 
    }
    
    
    private void searchCustomerData(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {
    		 String customerId=request.getParameter("id");
    		 String producttxtstr=request.getParameter("txtSer");    		    
    		 String sql="SELECT B.INT_CUSTOMERID,B.CHR_CUSTOMERNAME,B.CHR_CITY,B.CHR_PHONE,B.CHR_FAX FROM INV_M_CUSTOMERGROUP A,INV_M_CUSTOMERINFO B WHERE";
    	     sql=sql+" A.INT_CUSTOMERGROUPID=B.INT_CUSTOMERGROUPID AND B.INT_CUSTOMERGROUPID='"+customerId+"'";
    	     ////System.out.println("---------------In Customer ----------------------"+sql); 
    		 String readData[][] = CommonFunctions.QueryExecute(sql);
		 	 StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 {
		 			if(readData[u][1].startsWith(producttxtstr) || "".equals(producttxtstr))
		    	     { 
		 				sb.append("<CSearch>");
	     				sb.append("<No>" + readData[u][0] +"</No>");
	     				sb.append("<Name>" + readData[u][1]+ "</Name>");
	     				sb.append("<City>" + readData[u][2]+ "</City>");
	     				sb.append("<Phone>" + readData[u][3]+ "</Phone>");
	     				sb.append("<Fax>" + readData[u][4]+ "</Fax>");
	     				sb.append("</CSearch>");	
		    	     }
	     		}	
	        	response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<CSearches>" + sb.toString() + "</CSearches>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}		
		} 
    	catch (Exception e) 
    	{
    		 
		} 
    }
    
    
    
//-----Customer Info---------------    
    private void loadCustomerData(HttpServletRequest request, HttpServletResponse  response)throws IOException, ServletException 
    {
    	 try 
    	 {    		 
//    		 String branchId=request.getParameter("id"); 
    		 String sql="SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_CITY,CHR_PHONE,CHR_STATE,CHR_EMAIL,INT_ACTIVE FROM INV_M_CUSTOMERINFO  ";
//    	     sql=sql+"WHERE INT_BRANCHID="+Integer.parseInt(branchId);
    	     String producttxtstr=request.getParameter("startLetter");   
    	     String readData[][] = CommonFunctions.QueryExecute(sql);
		 	 StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 { 		
		 			if(readData[u][1].startsWith(producttxtstr) || "".equalsIgnoreCase(producttxtstr))
		    	     { 
		 		       	sb.append("<Customer>");
	     				sb.append("<Id>" + readData[u][0] +"</Id>");
	     				sb.append("<Name>" + readData[u][1]+ "</Name>");
	     				sb.append("<City>" + readData[u][2]+ "</City>");
	     				sb.append("<Phone>" + readData[u][3]+ "</Phone>");
	     				sb.append("<State>" + readData[u][4]+ "</State>");	
	     				sb.append("<Email>" + readData[u][5]+ "</Email>");
	     				sb.append("<Active>" + readData[u][6]+ "</Active>");
	     				sb.append("</Customer>");
		    	     }
		    	}			 		
		 		response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}		
		} 
    	catch (Exception e) 
    	{
    		 
		} 
    } 
//  -----All Customer Info---------------    
  
    
    private void searchVendorData(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
   	 	try 
   	 	{
	   		 String vendorId=request.getParameter("id");
	   		 String vrtxtstr=request.getParameter("sval");
	   	     String sql ="";
	   	     String query="";
	   	 
	   	     if(vendorId.equalsIgnoreCase("all"))
	   	     {
	   	    	 query="SELECT INT_VENDORID,CHR_VENDORNAME,CHR_CITY,CHR_PHONE,CHR_FAX FROM INV_M_VENDORSINFO";  
	   	    	 readData= CommonFunctions.QueryExecute(query);
	   	     }
	   	     else{
	   		 sql="SELECT A.INT_VENDORID,A.CHR_VENDORNAME,CHR_CITY,CHR_PHONE,CHR_FAX FROM INV_M_VENDORSINFO A,INV_M_VENDORSGROUP B WHERE ";
	   	     sql=sql+"A.INT_GROUPID=B.INT_GROUPID AND B.INT_GROUPID="+Integer.parseInt(vendorId);
	   	     readData= CommonFunctions.QueryExecute(sql);
	   	     }
			 	 StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			if(readData[u][1].startsWith(vrtxtstr) || "".equals(vrtxtstr))
			    	     { 
			    	     
			 				sb.append("<vendor>");
		     				sb.append("<Id>" + readData[u][0] +"</Id>");
		     				sb.append("<Name>" + readData[u][1]+ "</Name>");
		     				sb.append("<City>" + readData[u][2]+ "</City>");
		     				sb.append("<Phone>" + readData[u][3]+ "</Phone>");
		     				sb.append("<Fax>" + readData[u][4]+ "</Fax>");
		     				sb.append("</vendor>");	
			    	     }
		     		}	
			 		////System.out.println(sb);
		        	response.setContentType("text/xml");
		     		response.setHeader("Cache-Control", "no-cache");
		     		response.getWriter().write("<vendors>" + sb.toString() + "</vendors>");
		     	} 
		     	else 
		     	{
		     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		     	}		
   	 	} 
   	 	catch (Exception e) 
   	 	{
   		 
		} 
   }

    
//------------------------- Checking Leave Avilablity for Online Apply -------------
    
    private void loadLeaveAvl (HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	 try 
    	 {    		 
    		 String empId=request.getParameter("empId");
    		 String Ltype = request.getParameter("value");
    		 String yr = request.getParameter("year");
    		 String afield="", gfield=""; 	
    		 if (Ltype.equals("P")){
    			 afield=" INT_NOD1BALANCE ";
    			 gfield=" INT_NOD1 ";
    		 } else if (Ltype.equals("C")){
    			 afield=" INT_NOD2BALANCE ";
    			 gfield=" INT_NOD2 ";
    		 } else if (Ltype.equals("S")) {
    			 afield=" INT_NOD3BALANCE ";
    			 gfield=" INT_NOD3 ";
    		 } else if (Ltype.equals("M")) {
    			 afield=" INT_NOD4BALANCE ";
    			 gfield=" INT_NOD4 ";
    		 } else if (Ltype.equals("A")) {
    			 afield=" INT_NOD5BALANCE ";
    			 gfield=" INT_NOD5 ";
    		 }

    		 String sql="SELECT "+gfield+", "+afield+" FROM att_m_leave WHERE CHR_EMPID='"+empId+"' AND INT_YEAR="+yr;
    		 System.out.println(sql);
    		 String readData[][] = CommonFunctions.QueryExecute(sql);
    	    
    	     StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 { 		
		 		       sb.append("<Customer>");
		 		       sb.append("<permit>" + readData[u][0] +"</permit>");
		 		       sb.append("<taken>" + readData[u][1] +"</taken>");
	     			   sb.append("</Customer>");
		 		 }			 		
		 		
		 		
				response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}		
		} 
    	catch (Exception e) 
    	{
    		 
		} 
    } 
    
    
    
    
    
    
//------------------------------------
    
    
    
    
    
    
    
    private void loadGoodsReturnData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	 try 
    	 {
    	
    		
    		
    		 
    		 DBCon conbean=new DBCon();
    	     PreparedStatement pst=null;
    	     ResultSet rs=null;
    	     Connection con=conbean.getConnection();
    	     
    	     String month=request.getParameter("month");
    	     int year=Integer.parseInt(request.getParameter("year"));
    	     int mon=Integer.parseInt(month);
    	     String fDate=year+"-"+month+"-01";
    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    	     String sql="SELECT A.INT_PURCHASEORDERID,B.DAT_ORDERDATE,B.DAT_RECIVEDDATE,C.CHR_VENDORNAME,B.DOU_TOTALAMOUNT FROM  inv_t_vendorgoodsreturn  A, inv_t_vendorpurchaseorder  B,INV_M_VENDORSINFO C" +
    	     		" where DAT_RETURNDATE>='"+fDate+"' AND DAT_RETURNDATE<='"+tDate+"' " +
    	     		" AND B.INT_VENDORID=C.INT_VENDORID AND A.INT_PURCHASEORDERID=B.INT_PURCHASEORDERID order by DAT_RETURNDATE ";
    	    // //System.out.println("SQL ----------------Barathi--------------------------------------------:"+sql);
    		 pst=con.prepareStatement(sql);            
             rs=pst.executeQuery();
             goodsReturnList.clear();
             while(rs.next()){
            	GoodsReceive goodsRet=new GoodsReceive();
            	goodsRet.setPurchaseId(rs.getString("INT_PURCHASEORDERID"));
            	goodsRet.setOrderDate(rs.getString("DAT_ORDERDATE"));
            	goodsRet.setReceiveDate(rs.getString("DAT_RECIVEDDATE"));
            	goodsRet.setVendorName(rs.getString("CHR_VENDORNAME"));
            	goodsRet.setTotalAmount(rs.getString("DOU_TOTALAMOUNT"));
               	goodsReturnList.add(goodsRet);  	
             }           
	         rs.close();
	         pst.close();
	     	  
	     	loadGoodsReturn(request,response);
		} catch (Exception e) {
			 
		} 
    }
    
    private void loadGoodsReturn(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	StringBuffer sb = new StringBuffer();
    	String cID=""+request.getParameter("id");		
		if(cID.equals("null")) cID="";
		
		boolean namesAdded = false;				
        for(int id=0;id<goodsReturnList.size();id++){
        	GoodsReceive e = (GoodsReceive)goodsReturnList.get(id);
        	String vendName=e.getVendorName().toUpperCase();
        	if(vendName.startsWith(cID)||cID.equals("")){
        		namesAdded=true;
            	sb.append("<gReturn>");
                sb.append("<id>" + e.getPurchaseId()+ "</id>");
                sb.append("<orderDate>" + e.getOrderDate()+ "</orderDate>");
                sb.append("<receiveDate>" + e.getReceiveDate()+ "</receiveDate>");
                sb.append("<vendorName>" + e.vendorName+ "</vendorName>");  
                sb.append("<totalAmount>" + e.getTotalAmount()+ "</totalAmount>");
                sb.append("</gReturn>");	             
        	}
        	            	
        }		     
	    if (namesAdded) {
		    response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
	        response.getWriter().write("<goodsReturn>" + sb.toString() + "</goodsReturn>");
		} else {
            //nothing to show
        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }		
    }
    
    
    private void loadGoodsReceiveData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	 try {
    		 DBCon conbean=new DBCon();
    	     PreparedStatement pst=null;
    	     ResultSet rs=null;
    	     Connection con=conbean.getConnection();
    	     String month=request.getParameter("month");
    	     int year=Integer.parseInt(request.getParameter("year"));
    	     int mon=Integer.parseInt(month);
    	     String fDate=year+"-"+month+"-01";
    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);    	        	     
    	     String sql="select A.chr_vendorname,b.INT_PURCHASEORDERID,B.DAT_ORDERDATE,B.DAT_RECIVEDDATE,B.DOU_TOTALAMOUNT " +
    	     		" FROM INV_M_VENDORSINFO A, inv_t_vendorpurchaseorder  B where B.DAT_RECIVEDDATE>='"+fDate+"' AND B.DAT_RECIVEDDATE<='"+tDate+"' " +
    	     		" AND a.INT_VENDORID=B.INT_VENDORID order by b.DAT_RECIVEDDATE";
    	     ////System.out.println("SQL ELAM:"+sql);
    		 pst=con.prepareStatement(sql);            
             rs=pst.executeQuery();
             goodsList.clear();
             while(rs.next()){
            	GoodsReceive goodsReceive=new GoodsReceive();
            	goodsReceive.setPurchaseId(rs.getString("INT_PURCHASEORDERID"));            	
            	goodsReceive.setOrderDate(rs.getString("DAT_ORDERDATE"));
            	goodsReceive.setReceiveDate(rs.getString("DAT_RECIVEDDATE"));
            	goodsReceive.setVendorName(rs.getString("CHR_VENDORNAME"));
            	goodsReceive.setTotalAmount(rs.getString("DOU_TOTALAMOUNT"));            	
            	goodsList.add(goodsReceive);  	
             }           
	         rs.close();
	         pst.close();
	     	  	     	
	     	loadGoods(request,response);
	     	
		} catch (Exception e) {
			 
		} 
    }
    private void loadGoods(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	StringBuffer sb = new StringBuffer();
    	String cID=""+request.getParameter("id");		
		if(cID.equals("null")) cID="";
		boolean namesAdded = false;				
        for(int id=0;id<goodsList.size();id++)
        {
        	GoodsReceive e = (GoodsReceive)goodsList.get(id);
        	String vendorName=e.getVendorName().toUpperCase();
        	if(vendorName.startsWith(cID)||cID.equals(""))
        	{
        		namesAdded=true;
            	sb.append("<good>");
                sb.append("<id>" + e.getPurchaseId()+ "</id>");
                sb.append("<orderDate>" + e.getOrderDate()+ "</orderDate>");
                sb.append("<receiveDate>" + e.getReceiveDate()+ "</receiveDate>");
                sb.append("<vendorName>" + e.getVendorName()+ "</vendorName>");  
                sb.append("<totalAmount>" +e.getTotalAmount()+ "</totalAmount>");                
                sb.append("</good>");	             
        	}
        }		     
	    if (namesAdded)    
	    {	    	
		    response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
	        response.getWriter().write("<goods>" + sb.toString() + "</goods>");
		} 
	    else 
	    {
	    	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }		
    }
    
    private void addStock() 
    {   	
    	 try {
    		 DBCon conbean=new DBCon();
    	     PreparedStatement pst=null;
    	     ResultSet rs=null;
    	     Connection con=conbean.getConnection();
    	     String sql="select I.CHR_PRODUCTID,I.CHR_ITEMID,I.CHR_ITEMNAME,S.INT_STOCKINHAND "; 
         	 sql=sql+" from INV_M_ITEM I,INV_T_STOCK S WHERE I.CHR_ITEMID=S.CHR_ITEMID;";
         	 pst=con.prepareStatement(sql);            
             rs=pst.executeQuery();
             stockList.clear();
             while(rs.next()){            	
             	String productId = rs.getString("CHR_PRODUCTID");
             	String itemId = rs.getString("CHR_ITEMID");
 				String itemName=rs.getString("CHR_ITEMNAME");
 				int stockIn=rs.getInt("INT_STOCKINHAND"); 				
 				Stock stock=new Stock();
 				stock.setProductId(productId);
 				stock.setItemId(itemId);
 				stock.setItemName(itemName);
 				stock.setStockIn(stockIn); 				
 				stockList.add(stock);            	
             }        
	         rs.close();
	         pst.close();
	     	  
		} catch (Exception e) {
			 
		} 
    }
    
    
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
		try
        {
			String action=request.getParameter("actionS");	
			action=action.trim();
			if(action.equals("INVProduct"))
			{					
				StringBuffer sb = new StringBuffer();
				boolean namesAdded = false;
	            for(int id=0;id<productList.size();id++)
	            {                
	            	 	Product e = (Product)productList.get(id);		               
	                	sb.append("<product>");
	                    sb.append("<id>" + e.getProductId() + "</id>");
	                    sb.append("<productName>" + e.getProductName()+ "</productName>");                    
	                    sb.append("</product>");
	                    namesAdded = true;		                
		        }		     
				if (namesAdded) 
				{
					    response.setContentType("text/xml");
		                response.setHeader("Cache-Control", "no-cache");
				        response.getWriter().write("<products>" + sb.toString() + "</products>");
				} 
				else 
				{
		                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		        }				    
			}
			else if(action.equals("LoadTermsandconditions"))
			{
				 
				InventoryMethod.LoadTermsandconditions(request,response);		
			}
			else if(action.equals("LoadPaymentTermView"))
			{
				InventoryMethod.LoadPaymentTermView(request,response);		
			}
			else if(action.equals("LoadTax"))
			{
				InventoryMethod.LoadTax(request,response);		
			}
			else if(action.equals("LoadPaymentCondition"))
			{
				InventoryMethod.LoadPaymentCondition(request,response);		
			}
			else if(action.equals("loadBanks"))
			{
				InventoryMethod.loadBanks(request,response);			    
			} 
 
			else if(action.equals("LoadDivision"))
			{
				InventoryMethod.LoadDivision(request,response);		
			}
			else if(action.equals("LoadModel"))
			{
				InventoryMethod.LoadModel(request,response);		
			}
			else if(action.equals("LoadColor"))
			{
				InventoryMethod.LoadColor(request,response);		
			}
			else if(action.equals("LoadMake"))
			{
				InventoryMethod.LoadMake(request,response);		
			}
			else if(action.equals("LoadUnit"))
			{
				InventoryMethod.LoadUnit(request,response);		
			}
			else if(action.equals("LoadProcessor"))
			{
				InventoryMethod.LoadProcessor(request,response);		
			}
			else if(action.equals("LoadChipset"))
			{
				InventoryMethod.LoadChipset(request,response);		
			}
			else if(action.equals("LoadMemory"))
			{
				InventoryMethod.LoadMemory(request,response);		
			}
			else if(action.equals("LoadHarddisk"))
			{
				InventoryMethod.LoadHarddisk(request,response);		
			}
			else if(action.equals("LoadGraphics"))
			{
				InventoryMethod.LoadGraphics(request,response);		
			}
			else if(action.equals("LoadMonitor"))
			{
				InventoryMethod.LoadMonitor(request,response);		
			}
			else if(action.equals("LoadWireless"))
			{
				InventoryMethod.LoadWireless(request,response);		
			}
			else if(action.equals("LoadLAN"))
			{
				InventoryMethod.LoadLAN(request,response);		
			}
			else if(action.equals("LoadOpticalDrive"))
			{
				InventoryMethod.LoadOpticalDrive(request,response);		
			}
			else if(action.equals("LoadOperatingSystem"))
			{
				InventoryMethod.LoadOperatingSystem(request,response);		
			}
			else if(action.equals("LoadCourier"))
			{
				InventoryMethod.LoadCourier(request,response);		
			}
			
			else if(action.equals("LoadItemGroup"))
			{
				InventoryMethod.LoadItemGroup(request,response);		
			}
			
			else if(action.equals("INVItem"))
			{
				InventoryMethod.loadItemData(request,response);		
			}
			
			
			else if(action.equals("INVItems"))
			{
				InventoryMethod.loadItemsData(request,response);		
			}
			else if(action.equals("LoadProductGroup"))
			{
				InventoryMethod.LoadProductGroup(request,response);		
			}
			else if(action.equals("loadProductList"))
			{
				InventoryMethod.loadProductList(request,response);		
			}
			
			else if(action.equals("LoadCustomerType"))
			{
				InventoryMethod.LoadCustomerType(request,response);		
			}
			else if(action.equals("LoadCustomerGroup"))
			{
				InventoryMethod.LoadCustomerGroup(request,response);		
			}
			else if(action.equals("INVAllCustomerData"))
			{
				InventoryMethod.loadAllCustomerData(request,response);			    
			} 
 
			else if(action.equals("LoadVendorGroup"))
			{
				InventoryMethod.LoadVendorGroup(request,response);		
			}
			
			else if(action.equals("loadAllVendor"))
			{
				InventoryMethod.loadAllVendor(request,response);			    
			} 
 
			
			else if(action.equals("INVSearchProd")){
				searchProductData(request,response);    
			}
			else if(action.equals("INVSearchItem")){
				searchItemData(request,response);    
			}
			else if(action.equals("INVSearchCustomer")){
				searchCustomerData(request,response);    
			}
			else if(action.equals("INVSearchVendor")){
				searchVendorData(request,response);    
			}
			else if(action.equals("INVPurchaseOrder")){				
				loadPurchaseOrder(request,response);  				
			}
			else if(action.equals("INVcustomerSearch")){				
				loadCustomerSearch(request,response);  				
			}
			
			 
			else if(action.equals("INVDelivary")){
				loadDelivaryData(request,response);    
			}
			
			else if(action.equals("INVCustomerQuotation"))
			{
				InventoryMethod.loadCustomerQuotation(request, response);
			}
			else if(action.equals("loadProforma"))
			{
				InventoryMethod.loadProforma(request, response);
			}
			else if(action.equals("loadPOVerification"))
			{
				InventoryMethod.loadPOVerification(request, response);
			}
			else if(action.equals("POSaleOrder"))
			{
				InventoryMethod.POSaleOrder(request, response);
			}
			else if(action.equals("loadPOBilling"))
			{
				InventoryMethod.loadPOBilling(request, response);
			}
			
			else if(action.equals("INVStockLoad"))
			{
				addStock();
				loadStockData(request,response);			    
			}
			else if(action.equals("INVStock")){
				InventoryMethod.loadStock(request,response);			    
			}
			else if(action.equals("INVStockAll")){
				InventoryMethod.loadStockAll(request,response);			    
			}
			else if(action.equals("INVDemo")){
				InventoryMethod.loadDemo(request,response);			    
			}
			else if(action.equals("INVSalesPayment")){
				
				loadSalesPayment(request,response);			    
			}
			else if(action.equals("INVCustomer")){
				loadCustomer(request,response);			    
			}
			else if(action.equals("INVCustomerData")){
				loadCustomerData(request,response);			    
			}
			
			else if(action.equals("INVpaymentSearch"))
			{	
				loadPaymentSearch(request,response);			    
			}
			else if(action.equals("INVcustomerPayment"))
			{	
				loadCustomerPayment(request,response);			    
			}
			else if(action.equals("INVgoodsReturnData")){
				loadGoodsReturnData(request,response);			    
			}
			else if(action.equals("INVSerGoodsReturn")){
				loadGoodsReturn(request,response);			    
			}
			else if(action.equals("INVPurchasePaymentData")){
				//purchasePaymentData(request,response);			    
			}
			else if(action.equals("INVSerPurchasePayment")){
				//purchasePayment(request,response);			    
			}
			
			else if(action.equals("INVgoodsReceiveData")){
				loadGoodsReceiveData(request,response);			    
			}
			else if(action.equals("INVSergood")){
				loadGoods(request,response);    
			}	
			else if(action.equals("INVbranchData")){
				loadBranchData(request,response);			    
			}
			else if(action.equals("INVloadInvoice")){
				loadInvoice(request,response);			    
			}
			else if(action.equals("INVloadBranch"))
			{
				InventoryMethod.loadBranchData(request,response);			    
			}
			else if(action.equals("INVPurchase"))
			{
				InventoryMethod.loadPurchaseData(request,response);			    
			}
			else if(action.equals("INVReceive")) 
			{	
				InventoryMethod.loadReceiveData(request,response);			    
			}
			else if(action.equals("INVGoodsReturn"))
			{	
				InventoryMethod.loadReturnData(request,response);			    
			}
			else if(action.equals("INVPurchasePayment"))
			{	
				InventoryMethod.loadPaymentData(request,response);			    
			}
			else if(action.equals("loadSearchVendorPO"))
			{	
				InventoryMethod.loadSearchVendorPO(request,response);			    
			}
			else if(action.equals("INVLoadSalesPayment"))
			{	
				InventoryMethod.loadSalesPayment(request, response);
			}
			else if(action.equals("loadSearchSalesPaymentno"))
			{	
				InventoryMethod.loadSearchSalesPaymentno(request, response);
			}
			else if(action.equals("INVGoodsReceivedId"))
			{	
				InventoryMethod.loadReceivedId(request,response);			    
			}
			else if(action.equals("INVPurchaseIdCheck"))
			{	
				InventoryMethod.PurchaseIdCheck(request,response);			    
			}
			else if(action.equals("INVQuotationIdCheck"))
			{	
				InventoryMethod.QuotationIdCheck(request,response);			    
			}
			else if(action.equals("INVCheckUnique"))
			{	
				InventoryMethod.CheckUnique(request,response);			    
			}
			else if(action.equals("INVSalesPayamounts"))
			{				
				InventoryMethod.loadSalesPaymentBalance(request,response);			    
			}
			else if(action.equals("INVSalesReturn"))
			{	
				InventoryMethod.loadSalesReturn(request, response);
			}
			else if(action.equals("INVStockTransfer"))
			{	
				InventoryMethod.loadStockTransfer(request, response);
			}
			else if(action.equals("INVAMC"))
			{
				InventoryMethod.loadAMC(request,response);    
			}
			else if(action.equals("INVAMCPayment"))
			{
				InventoryMethod.loadAMCPayment(request,response);    
			}
			else if(action.equals("INVServiceCall"))
			{
				InventoryMethod.loadServiceCall(request,response);    
			}
			else if(action.equals("INVAMCServiceids"))
			{
				InventoryMethod.loadAMCServiceids(request,response);    
			}
			else if(action.equals("INVServiceAmountAssign"))
			{
				InventoryMethod.loadServiceAmountAssign(request,response);    
			}
			else if(action.equals("INVServiceCompalintID"))
			{
				InventoryMethod.ServiceCompalintID(request,response);    
			}
			else if(action.equals("INVAMCCustomer"))
			{
				InventoryMethod.AMCCustomer(request,response);    
			}
			else if(action.equals("INVUniqueId"))
			{
				InventoryMethod.AMCUniqueId(request,response);    
			}
			else if(action.equals("INVItemProductGroup"))
			{
				InventoryMethod.ItemProductGroup(request,response);    
			}
			else if(action.equals("LoaditemproductdependsGroup"))
			{
				InventoryMethod.itemproductdependsGroup(request,response);    
			}
			
			else if(action.equals("INVItemProduct"))
			{
				InventoryMethod.ItemProduct(request,response);    
			}
			else if(action.equals("INVItemProductdependsPurchaseRequest"))
			{
				InventoryMethod.INVItemProductdependsPurchaseRequest(request,response);    
			}
			else if(action.equals("INVItemProductSparemodule"))
			{
				InventoryMethod.INVItemProductSparemodule(request,response);    
			}
			else if(action.equals("LoadItemProductGroup"))
			{
				InventoryMethod.LoadItemProductGroup(request,response);    
			}
			else if(action.equals("INVQuotationEdit"))
			{
				InventoryMethod.QuotationEdit(request,response);    
			}
			else if(action.equals("INVItemProductAssign"))
			{
				InventoryMethod.ItemProductAssign(request,response);    
			}
			else if(action.equals("INVItemProductAssignstock"))
			{
			 	InventoryMethod.ItemProductAssignStock(request,response);    
			}
			else if(action.equals("INVSalesNumber"))
			{
				InventoryMethod.LoadSalesNumber(request,response);    
			}
			else if(action.equals("INVSalesNumberItems"))
			{
				InventoryMethod.INVSalesNumberItems(request,response);    
			}
			else if(action.equals("LoadBranchess"))
			{
				InventoryMethod.LoadBranchess(request,response);    
			}
			else if(action.equals("LeaveAvl"))
			{
				loadLeaveAvl(request,response);    
			}
			else if(action.equals("INVContribution"))
			{
				InventoryMethod.LoadContribution(request,response);   
			}
			else if(action.equals("INVConveyance"))
			{
				InventoryMethod.LoadConveyance(request,response);   
			}
			else if(action.equals("INVTargetAssign"))
			{
				InventoryMethod.LoadTargetAssign(request,response);   
			}
			else if(action.equals("loadDivisionTargetAssign"))
			{
				InventoryMethod.loadDivisionTargetAssign(request,response);   
			}
			else if(action.equals("LoadAccessories"))
			{
				InventoryMethod.LoadAccessories(request,response);   
			}
			else if(action.equals("LoadAccessoriesProduct"))
			{
				InventoryMethod.LoadAccessoriesProduct(request,response);   
			}
			else if(action.equals("INVBudgetAssign"))
			{
				InventoryMethod.LoadBudgetAssign(request,response);   
			}
			else if(action.equals("INVBudgetCheck"))
			{
				InventoryMethod.LoadBudgetCheck(request,response); 
			}
			else if(action.equals("loadPurchaseProduct"))
			{
				InventoryMethod.loadPurchaseProduct(request,response); 
			}
			else if(action.equals("loadIndentRaise"))
			{
				InventoryMethod.loadIndentRaise(request,response); 
			}
			else if(action.equals("loadIndentClose"))
			{
				InventoryMethod.loadIndentClose(request,response); 
			}
			else if(action.equals("LoadIndentPayment"))
			{
				InventoryMethod.LoadIndentPayment(request,response); 
			}
			
			
			//=============================================================================
			else if(action.equals("INVTargetAssignAll"))
			{
				InventoryMethod.LoadTargetAssignAll(request,response);   
			}
			else if(action.equals("INVTargetAssignMonth"))
			{
				InventoryMethod.LoadTargetAssignMonth(request,response);   
			}
			else if(action.equals("INVTargetAssignCGroup"))
			{
				InventoryMethod.LoadTargetAssignCGroup(request,response);   
			}
			else if(action.equals("INVTargetAssignAvgCollection"))
			{
				InventoryMethod.LoadTargetAssignAvgCollection(request,response);   
			}
			else if(action.equals("INVDirectBilling"))
			{
				InventoryMethod.LoadDirectBilling(request,response);
			}
			else if(action.equals("INVDirectBillingValue"))//
			{	
				InventoryMethod.loadDirectBillingValue(request, response);
			}
			else if("loadDirectBillingPayment".equals(action))
			{
				InventoryMethod.loadDirectBillingPayment(request, response);
			}
			else if(action.equals("INVServiceBillingPO"))
			{
				InventoryMethod.INVServiceBillingPO(request,response);   
			}
			else if(action.equals("INVServiceBilling"))
			{
				InventoryMethod.LoadServiceBilling(request,response);   
			}
			else if(action.equals("loadAdvanceAmount"))
			{
				InventoryMethod.loadAdvanceAmount(request,response);   
			}
			else if(action.equals("loadCustomer"))
			{
				InventoryMethod.loadCustomer(request,response);   
			}
			else if(action.equals("loadServiceBillingPayment"))
			{
				InventoryMethod.loadServiceBillingPayment(request,response);   
			}
			else if(action.equals("INVServiceBillingValue"))//
			{	
				InventoryMethod.loadServiceBillingValue(request, response);
			}
			else if(action.equals("INVLoadTaxcalculations"))//
			{	
				InventoryMethod.loadTaxcalculations(request, response);
			}
			else if(action.equals("INVDirectDC"))//
			{	
				InventoryMethod.loadDirectDC(request, response);
			}
			else if(action.equals("LoadNonCustomer"))//
			{	
				InventoryMethod.LoadNonCustomer(request, response);
			}
			else if(action.equals("LoadServiceItems"))//
			{	
				InventoryMethod.LoadServiceItems(request, response);
			}
			else if(action.equals("LoadServiceGroup"))//
			{	
				InventoryMethod.LoadServiceGroup(request, response);
			}
			else if(action.equals("LoadServiceCenter"))//
			{	
				InventoryMethod.LoadServiceCenter(request, response);
			}
			else if(action.equals("LoadServiceAMC"))//
			{	
				InventoryMethod.LoadServiceAMC(request, response);
			}
			else if(action.equals("LoadAMCSerialnumber"))//
			{	
				InventoryMethod.LoadAMCSerialnumber(request, response);
			}
			else if(action.equals("LoadAMCSerialNumberCustomerwise"))//
			{	
				InventoryMethod.LoadAMCSerialNumberCustomerwise(request, response);
			}
			else if(action.equals("LoadAMCcustomerinfo"))//
			{	
				InventoryMethod.LoadAMCcustomerinfo(request, response);
			}
			else if(action.equals("LoadAMCCallBooking"))//
			{	
				InventoryMethod.LoadAMCCallBooking(request, response);
			}
			else if(action.equals("LoadAMCCallAssign"))//
			{	
				InventoryMethod.LoadAMCCallAssign(request, response);
			}
			else if(action.equals("LoadAMCPersonalinfo"))//
			{	
				InventoryMethod.LoadAMCPersonalinfo(request, response);
			}
			else if(action.equals("INVCustomerCreditLimit"))//
			{	
				InventoryMethod.LoadCustomerCreditLimit(request, response);
			}
			else if(action.equals("LoadRuntimeCustomer"))//
			{	
				InventoryMethod.LoadRuntimeCustomer(request, response);
			}
			else if(action.equals("LoadRuntimeNonCustomerGroup"))//
			{	
				InventoryMethod.LoadRuntimeNonCustomerGroup(request, response);
			}
			else if(action.equals("INVCustomerServiceCallCreditLimit"))//
			{	
				InventoryMethod.LoadCustomerServiceCallCreditLimit(request, response);
			}
			else if(action.equals("CustomerServiceCallSerialnumberCheck"))//
			{	
				InventoryMethod.LoadCustomerServiceCallSerialnumberCheck(request, response);
			}
			else if(action.equals("INVAssignPaymentCommitment"))//
			{	
				InventoryMethod.LoadAssignPaymentCommitment(request, response);
			}
			else if(action.equals("INVCustomerSalesCreditlimt"))//
			{	
				InventoryMethod.LoadCustomerSalesCreditlimt(request, response);
			}
			else if(action.equals("INVCustomerSalesCreditAmount"))//
			{	
				InventoryMethod.LoadCustomerSalesCreditAmount(request, response);
			}
			else if("loadSalesAnalysisGroup".equals(action) )//
			{	
				InventoryMethod.loadSalesAnalysisGroup(request, response);
			}
			else if(action.equals("loadPurchaseRequest"))
			{
				InventoryMethod.loadPurchaseRequest(request,response);   
			}
			else if(action.equals("loadPurchaseRequestDate"))
			{
				InventoryMethod.loadPurchaseRequestDate(request,response);   
			}
			else if(action.equals("loadPurchaseRequestDetails"))
			{
				InventoryMethod.loadPurchaseRequestDetails(request,response);   
			}
			else if(action.equals("LoadPurchaseRequest"))
			{
				InventoryMethod.LoadPurchaseRequestdependsonVendor(request,response);   
			}
			else if(action.equals("loadBybackSalesnumber"))
			{
				InventoryMethod.loadBybackSalesnumber(request,response);   
			}
			else if(action.equals("loadPurchaseRequestTaken"))
			{
				InventoryMethod.loadPurchaseRequestTaken(request,response);   
			}
			else if(action.equals("loadPurchaseRequestDivision"))
			{
				InventoryMethod.loadPurchaseRequestDivision(request,response);   
			}
			else if(action.equals("loadPurchaseRequestAdmin"))
			{
				InventoryMethod.loadPurchaseRequestAdmin(request,response);   
			}
			else if(action.equals("loadPurchaseRequestAccept"))
			{
				InventoryMethod.loadPurchaseRequestAccept(request,response);   
			}
			else if(action.equals("loadPurchaseRequestClosed"))
			{
				InventoryMethod.loadPurchaseRequestClosed(request,response);   
			}
			else if(action.equals("INVLoadStaffAsset"))
			{	
				InventoryMethod.LoadStaffAsset(request, response);
			}
			else if(action.equals("serialNum"))
			{
				InventoryMethod.LoadSerial(request,response);		
			}
			else if(action.equals("INVloadEMD"))
			{	
				InventoryMethod.INVloadEMDAsset(request, response);
			}
			else if(action.equals("INVloadStaffEMD"))
			{	
				InventoryMethod.INVloadStaffEMD(request, response);
			}
			else if(action.equals("LoadProject"))
			{
				InventoryMethod.LoadProject(request,response);		
			}
			else if(action.equals("LoadSpareDemand"))
			{
				InventoryMethod.LoadSpareDemand(request,response);		
			}
			else if(action.equals("LoadSpareIssued"))
			{
				InventoryMethod.LoadSpareIssued(request,response);		
			}
			else if(action.equals("LoadSpareReturn"))
			{
				InventoryMethod.LoadSpareReturn(request,response);		
			}
			else if(action.equals("INVDeliveryChallan"))//
			{	
				InventoryMethod.loadDeliveryChallan(request, response);
			}
			else if(action.equals("INVScrab"))//
			{	
				InventoryMethod.INVScrab(request, response);
			}
			
			else if(action.equals("loadStockAdjustment"))//
			{	
				InventoryMethod.loadStockAdjustment(request, response);
			}
			
			//Spare Module Start
			else if(action.equals("LoadEquipementType"))//
			{	
				ServiceSpareMethod.LoadEquipementType(request, response);
			}
			else if(action.equals("LoadEquipementModel"))//
			{	
				ServiceSpareMethod.LoadEquipementModel(request, response);
			}
			else if(action.equals("LoadEquipementPartNumber"))//
			{	
				ServiceSpareMethod.LoadEquipementPartNumber(request, response);
			}
			else if(action.equals("loadEquipmentMaster"))
			{
				ServiceSpareMethod.loadEquipmentMaster(request,response);    
			}
			else if(action.equals("LoadProblemgroups"))
			{
				ServiceSpareMethod.LoadProblemgroups(request,response);    
			}
			else if(action.equals("LoadProblems"))
			{
				ServiceSpareMethod.LoadProblems(request,response);    
			}
			else if(action.equals("loadSpareCallAssign"))
			{
				ServiceSpareMethod.loadSpareCallAssign(request,response);    
			}
			else if(action.equals("LoadSpareProduct"))//
			{	
				ServiceSpareMethod.LoadSpareProduct(request, response);
			} 
			else if(action.equals("LoadSpareModel"))//
			{	
				ServiceSpareMethod.LoadSpareModel(request, response);
			}
			else if(action.equals("LoadSpareCustomer"))//
			{	
				ServiceSpareMethod.LoadSpareCustomer(request, response);
			}
			else if(action.equals("LoadSpareCustomerAddress"))//
			{	
				ServiceSpareMethod.LoadSpareCustomerAddress(request, response);
			}
			
			else if(action.equals("LoadSSpare"))
			{
				ServiceSpareMethod.LoadSpare(request,response);    
			}
			//Spare Module End
			
 		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response); 
			
		}			
    }
    
  
    private void loadDelivaryData(HttpServletRequest request, HttpServletResponse response) 
    {
    	try 
    		{
    			HttpSession session=request.getSession();
    		 	String branchId=""+session.getAttribute("BRANCHID");
    		 	String month=request.getParameter("month");
    		 	int year=Integer.parseInt(request.getParameter("year"));
    		 	int mon=Integer.parseInt(month);
    		 	String fDate=year+"-"+month+"-01";
    		 	String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    	     	String sql="SELECT INT_QUOTATIONID,INT_CUSTOMERID,DAT_QUOTATIONDATE," +
    		 	 		"DAT_REQUESTDATE,INT_ONHOLD,INT_CONDITIONID," +
    		 	 		"CHR_DES,DOU_TOTALAMOUNT,INT_QUOTATIONSTATUS" +
    		 	 		" FROM  inv_t_customerquotation  " +
 	     			" where DAT_QUOTATIONDATE>='"+fDate+"' AND DAT_QUOTATIONDATE<='"+tDate+"' " +
 	     			" AND INT_QUOTATIONSTATUS=0 order by DAT_QUOTATIONDATE";
 	         	String readData[][] = CommonFunctions.QueryExecute(sql);
    	     	StringBuffer sb = new StringBuffer();  	     	
    	     	if(readData.length > 0)
    	     	{	
    	     		for(int u=0; u<readData.length;u++)
    	     		{
    	     			sql="SELECT CHR_CUSTOMERNAME,DOU_BALANCE FROM " +
    	     			"inv_m_customerinfo WHERE INT_BRANCHID="+branchId+" " +
    	     			"AND INT_CUSTOMERID="+readData[u][1];
	                	String customerData[][]=CommonFunctions.QueryExecute(sql);
	                	sb.append("<quotation>");
	                    sb.append("<id>" + readData[u][0]+ "</id>");
	                    sb.append("<quotationDate>" + readData[u][2]+ "</quotationDate>");
	                    sb.append("<customerName>" + customerData[0][0]+ "</customerName>");
	                    sb.append("<reqDate>" + readData[u][3]+ "</reqDate>");  
	                    sb.append("<onHold>" + readData[u][4]+ "</onHold>");
	                    sb.append("<quotationStatus>" + readData[u][8] + "</quotationStatus>");
	                    sb.append("<credit>" + customerData[0][1]+ "</credit>");
	                    sb.append("<totalAmount>" +readData[u][7]+ "</totalAmount>");                
	                    sb.append("</quotation>");	    	     		
	    	     	}    	     	
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		response.getWriter().write("<quotations>" + sb.toString() + "</quotations>");
    	     	
    	     	} 
    	     	else 
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	 
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
	}
    
    
	
    private void loadStockData(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {
		try{	
			String productId=""+request.getParameter("id");
			String txtSer=""+request.getParameter("txtSer");
			if(productId.equals("null")) productId="";
			if(txtSer.equals("null")) txtSer="";
			txtSer=txtSer.toLowerCase();				
			StringBuffer sb = new StringBuffer();
			boolean namesAdded = false;				
	        for(int id=0;id<stockList.size();id++){
	        	Stock st = (Stock)stockList.get(id);
	        	String itemName=st.getItemName().toLowerCase();
	        	if ((st.getProductId().equals(productId) || productId.equals(""))
	        			&&(itemName.startsWith(txtSer)||txtSer.equals("")))  
	            {			            		          
	        		namesAdded=true;
	            	sb.append("<stock>");
	                sb.append("<id>" + st.getItemId()+ "</id>");
	                sb.append("<itemName>" + st.getItemName()+ "</itemName>");  
	                sb.append("<itemStockIn>" + st.getStockIn()+ "</itemStockIn>");
	                sb.append("<itemStockOut>" +st.getStockOut()+ "</itemStockOut>");
	                sb.append("</stock>");	                    
	            }	            	
	        }		     
		    if (namesAdded) {
			    response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<stocks>" + sb.toString() + "</stocks>");
			} else {
	            //nothing to show
	        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        }
		}
		catch(Exception e){
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 
		}
			
	}	
	
	@SuppressWarnings("unused")
	private void loadStock(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {
		try{	
			String productId=""+request.getParameter("id");
			String txtSer=""+request.getParameter("txtSer");
			if(productId.equals("null")) productId="";
			if(txtSer.equals("null")) txtSer="";
			txtSer=txtSer.toLowerCase();				
			StringBuffer sb = new StringBuffer();
			boolean namesAdded = false;				
	        for(int id=0;id<stockList.size();id++){
	        	Stock st = (Stock)stockList.get(id);
	        	String itemName=st.getItemName().toLowerCase();
	        	if ((st.getProductId().equals(productId) || productId.equals(""))
	        			&&(itemName.startsWith(txtSer)||txtSer.equals("")))  
	            {			            		          
	        		namesAdded=true;
	            	sb.append("<stock>");
	                sb.append("<id>" + st.getItemId()+ "</id>");
	                sb.append("<itemName>" + st.getItemName()+ "</itemName>");  
	                sb.append("<itemStockIn>" + st.getStockIn()+ "</itemStockIn>");
	                sb.append("</stock>");	                    
	            }	            	
	        }		     
		    if (namesAdded) {
			    response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<stocks>" + sb.toString() + "</stocks>");
			} else {
	            //nothing to show
	        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        }
		}
		catch(Exception e){
			 
		}
			
	}	
	
	
	
	private void loadCustomer(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException {
		try{			
			String txtSer=""+request.getParameter("txtSer");			
			String sql="";
			if(txtSer.equals("null") || "".equals(txtSer) )
				sql= "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_LEGALNAME FROM inv_m_customerinfo ORDER BY CHR_CUSTOMERNAME";
			else
				sql= "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_LEGALNAME FROM inv_m_customerinfo WHERE CHR_CUSTOMERNAME LIKE '"+txtSer+"%' ORDER BY CHR_CUSTOMERNAME";
			 
			StringBuffer sb = new StringBuffer();
			String readData[][] = CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<customer>");
	                sb.append("<id>" + readData[u][0]+ "</id>");
	                sb.append("<customerName>" +  readData[u][1].replaceAll("&", " AND").toUpperCase()+ "</customerName>");  
	                sb.append("<leagalName>" + readData[u][2].replaceAll("&", " AND").toUpperCase()+ "</leagalName>");	                
	                sb.append("</customer>");	      
	            }
	 			 
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<customers>" + sb.toString() + "</customers>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		}
		catch(Exception e){
			 
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
			
	}	
//---Purchase Order----------------------	
	private void loadPurchaseOrder(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String vendorId=request.getParameter("vendorId");
    	 		String month=request.getParameter("month");
    		 	int year=Integer.parseInt(request.getParameter("year"));
    		 	////System.out.println("yr"+year);
    		 	int mon=Integer.parseInt(month);
    		 	String fDate=year+"-"+month+"-01";
    		 	String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    		 	if(vendorId.equalsIgnoreCase("all")){
    		 	String query="SELECT CHR_PURCHASEORDERNO,A.CHR_VENDORNAME,DAT_ORDERDATE,DAT_RECIVEDDATE,DOU_TOTALAMOUNT FROM  inv_t_vendorpurchaseorder ,INV_M_VENDORSINFO A";
    		 	query=query+" WHERE DAT_ORDERDATE >='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' ORDER BY A.CHR_VENDORNAME";
    		 	readData= CommonFunctions.QueryExecute(query);
    		 	}
    		 	else{
    		 	String sql="SELECT B.CHR_PURCHASEORDERNO,A.CHR_VENDORNAME,B.DAT_ORDERDATE,B.DAT_RECIVEDDATE,B.DOU_TOTALAMOUNT FROM  inv_t_vendorpurchaseorder  B,INV_M_VENDORSINFO A";
    		 	sql=sql+" WHERE A.INT_VENDORID=B.INT_VENDORID AND B.INT_VENDORID="+vendorId+" AND  B.DAT_ORDERDATE >='"+fDate+"' AND B.DAT_ORDERDATE<='"+tDate+"' ORDER BY B.DAT_ORDERDATE";
    		  	readData= CommonFunctions.QueryExecute(sql);
    		 	}   	     	
    	     	StringBuffer sb = new StringBuffer();    	     	
    	     	boolean flag = false;
    	     	for(int u=0; u<readData.length;u++)
    	     	{
    	     		flag = true;
    	     			sb.append("<purchase>");    	     			
    	                sb.append("<purchaseNo>" + readData[u][0]+ "</purchaseNo>");
    	                sb.append("<vendorName>" + readData[u][1]+ "</vendorName>");
    	                sb.append("<orderDate>" +readData[u][2] + "</orderDate>");
    	                sb.append("<receivedDate>" +readData[u][3] + "</receivedDate>");    	               
    	                sb.append("<totalAmount>" +readData[u][4] + "</totalAmount>");    	                
    	                sb.append("</purchase>");	
    	     		}    	     	 
    	    	if (flag) 
    	     	{
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		response.getWriter().write("<purchases>" + sb.toString() + "</purchases>");
    	     	} 
    	     	else 
    	     	{
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	}		
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
    }
	
	
	
	
	private void loadCustomerSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String customerId=request.getParameter("id");
    	 		////System.out.println("vendor"+customerId);
    		 	String month=request.getParameter("month");
    		 	////System.out.println("mth"+month);
    		 	int year=Integer.parseInt(request.getParameter("year"));
    		 	////System.out.println("yr"+year);
    		 	int mon=Integer.parseInt(month);
    		 	String fDate=year+"-"+month+"-01";
    		 	String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    		 	if(customerId.equalsIgnoreCase("all")){
    		 		String query="SELECT CHR_SALESORDERNO,DAT_ORDERDATE,DOU_TOTALAMOUNT FROM  inv_t_customersalesorder  ";
    		 		query=query+" WHERE DAT_ORDERDATE >='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' ORDER BY DAT_ORDERDATE";    		 		
    		 		readData= CommonFunctions.QueryExecute(query);
    		 	}
    		 	else{
    		 		String query="SELECT CHR_SALESORDERNO,DAT_ORDERDATE,DOU_TOTALAMOUNT FROM  inv_t_customersalesorder  ";
    		 		query=query+" WHERE INT_CUSTOMERID="+customerId+" AND  DAT_ORDERDATE >='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' ORDER BY DAT_ORDERDATE";
    		 		readData= CommonFunctions.QueryExecute(query);
    		 	}   	     	
    	     	StringBuffer sb = new StringBuffer();    	     	
    	     	boolean flag = false;
    	     	for(int u=0; u<readData.length;u++)
    	     	{
    	     		flag = true;
    	     			sb.append("<purchCust>");    	            
    	                sb.append("<purchaseNo>" +readData[u][0]+ "</purchaseNo>");
    	                sb.append("<orderDate>" +readData[u][1] + "</orderDate>");    	               
    	                sb.append("<totalAmount>" +readData[u][2] + "</totalAmount>");    	                
    	                sb.append("</purchCust>");	
    	     		}    	     	 
    	    	if (flag) 
    	     	{
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		response.getWriter().write("<custPay>" + sb.toString() + "</custPay>");
    	     	} 
    	     	else 
    	     	{
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	}		
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
    }
	
	
	
	
	 
	
	private void loadPaymentSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	String vendor=request.getParameter("id");
    		 	//System.out.println("vendor"+vendor);
		 		String month=request.getParameter("month");
		 		////System.out.println("month"+month);
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		
		 		/*
		 		INT_BRANCHID		INT_PAYMENTID		CHR_PURCHASEORDERNO	
		 		INT_VENDORID		INT_PAYMENTTERMID	DAT_PAYMENTDATE	
		 		CHR_PAYMENTDESC		DOU_PURCHASEAMOUNT	DOU_PAIDAMOUNT	
		 		DOU_BALANCEAMOUNT	CHR_USRNAME			DT_UPDATEDATE	
		 		CHR_UPDATESTATUS
		 		*/
		 		if(vendor.equalsIgnoreCase("all"))
		 		{
		 			String sql="SELECT A.CHR_PURCHASEORDERNO,B.CHR_VENDORNAME,A.DOU_TOTALAMOUNT,A.DOU_PAIDAMOUNT FROM  inv_t_vendorpurchaseorder  A,INV_M_VENDORSINFO B WHERE A.INT_VENDORID=B.INT_VENDORID";
		 			readData= CommonFunctions.QueryExecute(sql);
		 		}
		 		
		 		else{		 		
		 		String sql="SELECT A.CHR_PURCHASEORDERNO,B.CHR_VENDORNAME,A.DOU_TOTALAMOUNT,A.DOU_PAIDAMOUNT FROM  inv_t_vendorpurchaseorder  A,INV_M_VENDORSINFO B"; 
		 		sql=sql+" WHERE A.INT_VENDORID=B.INT_VENDORID AND  A.INT_VENDORID='"+vendor+"' AND  A.DAT_ORDERDATE >='"+fDate+"' AND A.DAT_ORDERDATE<='"+tDate+"' ";
		 		readData = CommonFunctions.QueryExecute(sql);
		 		}
		 		StringBuffer sb = new StringBuffer();
		 		boolean flag = false;
		 		for(int u=0; u<readData.length;u++)
		 		{
		 	 			flag = true;		 	 			
	     				sb.append("<Pay>");
	     				sb.append("<Purchaseid>" + readData[u][0]+  "</Purchaseid>");	
	     				sb.append("<vendorName>" + readData[u][1]+  "</vendorName>");
	     				sb.append("<Totalamount>" + readData[u][2]+ "</Totalamount>");
	     				sb.append("<Paidamount>" + readData[u][3]+ "</Paidamount>");  
	     				sb.append("<Blanace>" +(Double.parseDouble(readData[u][2])-Double.parseDouble(readData[u][3])) + "</Blanace>");
	     				sb.append("</Pay>");	
 	     		}	            
    	     	if (flag) 
    	     	{
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		response.getWriter().write("<Pays>" + sb.toString() + "</Pays>");
    	     	} 
    	     	else 
    	     	{
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	}			     	 	 
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
    }
	
	private void loadCustomerPayment(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	String customer=request.getParameter("id");
    		 	////System.out.println("vendor"+vendor);
		 		String month=request.getParameter("month");
		 		////System.out.println("month"+month);
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		
		 		/*
		 		INT_BRANCHID		INT_PAYMENTID		CHR_PURCHASEORDERNO	
		 		INT_VENDORID		INT_PAYMENTTERMID	DAT_PAYMENTDATE	
		 		CHR_PAYMENTDESC		DOU_PURCHASEAMOUNT	DOU_PAIDAMOUNT	
		 		DOU_BALANCEAMOUNT	CHR_USRNAME			DT_UPDATEDATE	
		 		CHR_UPDATESTATUS
		 		*/
		 		if(customer.equalsIgnoreCase("all"))
		 		{
		 			
		 			
		 		}
		 		
		 		
		 		String sql="SELECT CHR_PURCHASEORDERNO,DOU_TOTALAMOUNT,DOU_PAIDAMOUNT FROM  inv_t_vendorpurchaseorder "; 
		 		sql=sql+" WHERE INT_VENDORID="+customer+" AND  DAT_ORDERDATE >='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' ";
		 		String readData[][] = CommonFunctions.QueryExecute(sql);
		 		
		 		StringBuffer sb = new StringBuffer();
		 		boolean flag = false;
		 		for(int u=0; u<readData.length;u++)
		 		{
		 	 			flag = true;		 	 			
	     				sb.append("<Pay>");
	     				sb.append("<Purchaseid>" + readData[u][0]+  "</Purchaseid>");	     				
	     				sb.append("<Totalamount>" + readData[u][1]+ "</Totalamount>");
	     				sb.append("<Paidamount>" + readData[u][2]+ "</Paidamount>");  
	     				sb.append("<Blanace>" +(Double.parseDouble(readData[u][1])-Double.parseDouble(readData[u][2])) + "</Blanace>");
	     				sb.append("</Pay>");	
 	     		}	            
    	     	if (flag) 
    	     	{
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		response.getWriter().write("<Pays>" + sb.toString() + "</Pays>");
    	     	} 
    	     	else 
    	     	{
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	}			     	 	 
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
    }
	
	
	public void loadBranchData(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	int id=Integer.parseInt(request.getParameter("id"));
    		 	String stltr=""+request.getParameter("startLetter");
    		 	//System.out.println("----Id"+id);
    		 	String sql=null;
    		 	if(stltr.equals("null"))
    		 	{
    		 		sql="SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
        		 	sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id;
        		 
    		 	}
    		 	else
    		 	{
    		 	  sql="SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
    		 	  sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id+" AND CHR_BRANCHNAME LIKE'"+stltr+"%'";
    		 	}
    		 	////System.out.println("Branch sql---------------------------------"+sql);
    	     	String readData[][] = CommonFunctions.QueryExecute(sql);
    	     	StringBuffer sb = new StringBuffer(); 
    	     	////System.out.println(readData.length);
    	     	boolean flag = false;
    	     	for(int u=0; u<readData.length;u++)
    	     	{
    	     		sb.append("<branch>");    	     		
                    sb.append("<id>"+readData[u][0]+"</id>");
                    sb.append("<branchName>"+readData[u][1]+"</branchName>");
                    sb.append("<legalName>"+readData[u][2]+"</legalName>");
                    sb.append("<city>"+readData[u][3]+"</city>");                      
                    sb.append("<country>" +readData[u][4]+"</country>");
                    sb.append("<email>"+readData[u][5]+"</email>");                                
                    sb.append("</branch>");
                    flag = true;
    	     	}    	     	
    	     	if (flag) 
    	     	{
    	     		
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		////System.out.println("---------------------------------"+sb.toString());
    	     		response.getWriter().write("<branches>" + sb.toString() + "</branches>");
    	     	} 
    	     	else 
    	     	{
    	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	     	}			     	 	 
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 
    	 	} 
    }   
	//kalai:---------------------------------------------------	
	
	
	private void loadSalesPayment(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	 try {
    		 HttpSession session=request.getSession();
    		 String branchId=""+session.getAttribute("BRANCHID");    		 
			 @SuppressWarnings("unused")
			int paymentId,salesOrderID,customerId,paymentMethod;
			 String paymentDate,customerName,paymentMName;
			 double openDebit,paidAmount;			 
			 boolean namesAdded = false;			 
    		 DBCon conbean=new DBCon();
    	     PreparedStatement pst=null;
    	     ResultSet rs=null;
    	     Connection con=conbean.getConnection();
    	     String month=request.getParameter("month");
    	     int year=Integer.parseInt(request.getParameter("year"));
    	     int mon=Integer.parseInt(month);
    	     String fDate=year+"-"+month+"-01";
    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    	     String sql="SELECT * FROM   inv_t_customersalespayment   " +
    	     		" where DAT_PAYMENTDATE>='"+fDate+"' AND DAT_PAYMENTDATE<='"+tDate+"' " +
    	     		" order by DAT_PAYMENTDATE";
    		 pst=con.prepareStatement(sql);            
             rs=pst.executeQuery();
             StringBuffer sb = new StringBuffer();
             while(rs.next()){
            	paymentId=rs.getInt("INT_PAYMENTID");
            	salesOrderID=rs.getInt("INT_SALESORDERID");
            	customerId=rs.getInt("INT_CUSTOMERID");
            	paymentMethod=rs.getInt("CHR_PAYMENTMETHOD");
            	paymentDate=rs.getString("DAT_PAYMENTDATE");
            	openDebit=rs.getDouble("DOU_OPENDEBIT");
            	paidAmount=rs.getDouble("DOU_PAIDAMOUNT");            	
            	sql="SELECT CHR_CUSTOMERNAME,DOU_BALANCE FROM inv_m_customerinfo WHERE INT_BRANCHID="+branchId+" AND INT_CUSTOMERID="+rs.getInt("INT_CUSTOMERID");            	
            	String customerData[][]=CommonFunctions.QueryExecute(sql);
            	customerName=customerData[0][0];
            	sql="SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID="+paymentId;
            	String paymentData[][]=CommonFunctions.QueryExecute(sql);
            	paymentMName=paymentData[0][0];            	
            	namesAdded=true;
            	sb.append("<payment>");
                sb.append("<id>" + paymentId+ "</id>");
                sb.append("<paymentDate>" + paymentDate+ "</paymentDate>");
                sb.append("<customerName>" + customerName+ "</customerName>");
                sb.append("<paymentMName>" +paymentMName+ "</paymentMName>");  
                sb.append("<openDebit>" + openDebit+ "</openDebit>");
                sb.append("<paidAmount>" + paidAmount + "</paidAmount>");
                sb.append("<totalAmount>" +(openDebit-paidAmount) + "</totalAmount>");                                
                sb.append("</payment>");	     
             }           
	         rs.close();
	         pst.close();
	     	  
	     	 if (namesAdded) {	     		 
	 		    response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");	             
	 	        response.getWriter().write("<payments>" + sb.toString() + "</payments>");
	 		} else {
	             //nothing to show
	         response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	         }	
		} catch (Exception e) {
			 
			
		} 
    }
	private void loadInvoice(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
    	 try {
    		 HttpSession session=request.getSession();
    		 String branchId=""+session.getAttribute("BRANCHID");    		 
			 @SuppressWarnings("unused")
			int quotationId,salesOrderID,customerId,paymentMethod;
			 @SuppressWarnings("unused")
			String salesOrderNo,paymentDate,customerName,paymentMName,orderBy;
			 String orderDate;
			 double totalAmt;			 
			 boolean namesAdded = false;			 
    		 DBCon conbean=new DBCon();
    	     PreparedStatement pst=null;
    	     ResultSet rs=null;
    	     Connection con=conbean.getConnection();
    	     String month=request.getParameter("month");
    	     int year=Integer.parseInt(request.getParameter("year"));
    	     int mon=Integer.parseInt(month);
    	     
    	     String fDate=year+"-"+month+"-01";
    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
    	     String sql="SELECT * FROM  inv_t_customersalesorder   " +
    	     		" where DAT_ORDERDATE>='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' " +
    	     		" order by DAT_ORDERDATE";
    	     
    		 pst=con.prepareStatement(sql);            
             rs=pst.executeQuery();
             StringBuffer sb = new StringBuffer();
             while(rs.next()){
            	quotationId=rs.getInt("INT_QUOTATIONID");
            	salesOrderID=rs.getInt("INT_SALESORDERID");
            	customerId=rs.getInt("INT_CUSTOMERID");
            	orderBy=rs.getString("CHR_ORDERBY");
            	orderDate=rs.getString("DAT_ORDERDATE");            	
            	paymentMethod=rs.getInt("INT_PAYMENTTERMID");
            	totalAmt=rs.getDouble("DOU_TOTALAMOUNT");
            	sql="SELECT CHR_CUSTOMERNAME,DOU_BALANCE FROM inv_m_customerinfo WHERE INT_BRANCHID="+branchId+" AND INT_CUSTOMERID="+rs.getInt("INT_CUSTOMERID");            	
            	String customerData[][]=CommonFunctions.QueryExecute(sql);
            	customerName=customerData[0][0];
            	sql="SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID="+paymentMethod;
            	String paymentData[][]=CommonFunctions.QueryExecute(sql);
            	paymentMName=paymentData[0][0];            	
            	namesAdded=true;
            	sb.append("<invoice>");
                sb.append("<id>" + salesOrderID + "</id>");
                sb.append("<orderDate>" +orderDate+ "</orderDate>");
                sb.append("<customerName>" + customerName+ "</customerName>");
                sb.append("<paymentMName>" +paymentMName+ "</paymentMName>");                
                sb.append("<totalAmount>" + totalAmt + "</totalAmount>");                                
                sb.append("</invoice>");	     
             }           
	         rs.close();
	         pst.close();
	     	  
	     	 if (namesAdded) {	     		 
	 		    response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
	           
	 	        response.getWriter().write("<invoices>" + sb.toString() + "</invoices>");
	 		} else {
	             //nothing to show
	         response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	         }	
		} catch (Exception e) 
		{
		
			 
		} 
    }

	
}
//-------------------------branch



