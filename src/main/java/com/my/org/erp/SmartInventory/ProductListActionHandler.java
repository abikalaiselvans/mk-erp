package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class ProductListActionHandler extends AbstractActionHandler
{
	String categoryName,categoryDes;
	int categoryId;
	private void productDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
				String productId[] = request.getParameterValues("productId");
				asql = "DELETE FROM inv_m_produtlist Where  INT_PRODUCTIDS = ?";
				apstm = con.prepareStatement(asql);
				for(int u=0; u<productId.length;u++)
				{
					apstm.setString(1, productId[u]);
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
				
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}
	}
	
	
	
	@SuppressWarnings("rawtypes")
	private void productAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			Map map=request.getParameterMap();
			ProductList proList=new ProductList();
			BeanUtils.populate(proList, map);
			String listid= request.getParameter("serialid");
			
			 
			 
			String itemId = "";
			if( CommonFunctions.RecordExist(con, "select count(*) FROM inv_m_produtlist"))
				itemId = CommonFunctions.QueryExecute("SELECT right(CONCAT('000000', MAX(INT_PRODUCTIDS)+1),6) FROM inv_m_produtlist")[0][0];
			else
				itemId = "000001";
			asql="INSERT INTO inv_m_produtlist(CHR_PRODUCTID,";
			asql=asql+"CHR_PRODUCTCODE,CHR_ITEMLIST,DOU_PURCHASEPRICE,DOU_SALESPRICE,";
			asql=asql+"INT_STOCKINHAND,CHR_WARRANTY,INT_MAKEID,CHR_COLOR,CHR_MODEL,CHR_PRODUCTDESC,";
			asql=asql+"INT_PRODUCTGROUPID,INT_ACTIVE,CHR_PTYPE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,  INT_TAXID,CHR_HSNCODE,INT_UNITID ) ";
			asql=asql+" VALUES(?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			apstm=con.prepareStatement(asql);
			apstm.setString(1,  itemId);
			apstm.setString(2, proList.getProductCode().toUpperCase().replaceAll("&", " AND ") );
			apstm.setString(3, listid);
			apstm.setDouble(4, proList.getPurchasePrice());
			apstm.setDouble(5, proList.getSalesPrice() );
			apstm.setInt(6, proList.getStockInHand());
			apstm.setString(7, proList.getWarranty());
			apstm.setString(8, ""+proList.getMake());
			apstm.setString(9, proList.getColorCode());
			apstm.setString(10, proList.getModelCode());
			apstm.setString(11, proList.getProductDesc().toUpperCase().replaceAll("&", " AND ") );
			apstm.setInt(12, proList.getProductGroupId());
			apstm.setInt(13, proList.getActive());
			apstm.setString(14, proList.getPtype());
			apstm.setString(15, auserid);
			apstm.setString(16, DateUtil.getCurrentDateTime());
			apstm.setString(17,"Y");
			apstm.setInt(18,proList.getTax());
			apstm.setString(19,proList.getHsncode());
			apstm.setString(20,proList.getUnits());
			System.out.println(""+apstm);
			apstm.execute();
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
		}
	}
	
	
	@SuppressWarnings("rawtypes")
	private void productEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			   
			Map map=request.getParameterMap();
			ProductList proList=new ProductList();
			BeanUtils.populate(proList, map);
			String listid= request.getParameter("serialid");
			
			asql = "UPDATE inv_m_produtlist SET ";
			asql = asql +" CHR_PRODUCTCODE=?,CHR_ITEMLIST=?,DOU_PURCHASEPRICE=?,DOU_SALESPRICE=?,";
			asql = asql +" INT_STOCKINHAND=?,CHR_WARRANTY=?,CHR_COLOR=?,CHR_MODEL=?,CHR_PRODUCTDESC=?,";
			asql = asql +" CHR_PRODUCTDESC=?,INT_ACTIVE=?, INT_TAXID=?,CHR_USRNAME=?,DT_UPDATEDATE=?,CHR_UPDATESTATUS=?,INT_PRODUCTGROUPID=?, "; //			
			asql = asql +" INT_MAKEID=?,CHR_HSNCODE=?, INT_UNITID=?";
			asql=asql+" WHERE INT_PRODUCTIDS=?";
			
			apstm=con.prepareStatement(asql);			
			apstm.setString(1, proList.getProductCode().toUpperCase().replaceAll("&", " AND ") );
			apstm.setString(2, listid);
			apstm.setDouble(3, proList.getPurchasePrice());
			apstm.setDouble(4, proList.getSalesPrice() );
			apstm.setInt(5, proList.getStockInHand());
			apstm.setString(6, proList.getWarranty());
			apstm.setString(7, proList.getColorCode());
			apstm.setString(8, proList.getModelCode());
			apstm.setString(9, proList.getProductDesc().toUpperCase().replaceAll("&", " AND ") );
			apstm.setString(10, proList.getProductDesc().toUpperCase().replaceAll("&", " AND ")  );//proList.getProductGroupId()
			apstm.setInt(11, proList.getActive());
		 	apstm.setInt(12, proList.getTax());
			apstm.setString(13, userId);
			apstm.setString(14, DateUtil.getCurrentDateTime());
			apstm.setString(15,"Y");
			apstm.setString(16,""+proList.getProductGroupId()); 
			apstm.setString(17, ""+proList.getMake());
			apstm.setString(18, ""+proList.getHsncode());
			apstm.setString(19, proList.getUnits());
			apstm.setString(20, proList.getProductId());
			System.out.println(""+apstm);
			apstm.execute();
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
 
	private void productInnerConfiguration(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			 
			String  make= request.getParameter("make");
			String  model= request.getParameter("model");
			String  processor= request.getParameter("processor");
			String  memory= request.getParameter("memory");
			String  harddisk= request.getParameter("harddisk");
			String  os= request.getParameter("os");
			String  warrantysupport= request.getParameter("warrantysupport");
			String graphics= request.getParameter("graphics");
			String chipset= request.getParameter("chipset");
			String monitor= request.getParameter("monitor");
			String wireless= request.getParameter("wireless");
			String lan= request.getParameter("lan");
			String opticaldrive= request.getParameter("opticaldrive");
			String wifi= request.getParameter("wifi");
			String touchscreen= request.getParameter("touchscreen");
			String cardreader= request.getParameter("cardreader");
			
			//graphics,monitor,wireless,lan,opticaldrive,
			//wifi,touchscreen,cardreader
			
			String  rowid= request.getParameter("rowid");
			asql = "UPDATE inv_m_produtlist SET "; 
			asql = asql +" INT_MAKEID = ? ,";
			asql = asql +" CHR_MODEL = ? ,";
			asql = asql +" INT_PROCESSORID = ? ,";
			asql = asql +" INT_MEMORYID = ? ,";
			asql = asql +" INT_HARDDISKID = ?, ";
			asql = asql +" INT_OSID = ?, ";
			asql = asql +" CHR_WARRANTYSUPPORT = ?, ";
			
			asql = asql +"  INT_MONITORID = ?, ";
			asql = asql +"  INT_OPTICALID = ?, ";
			asql = asql +"  INT_LANID = ?, ";
			asql = asql +"  INT_WIRELESSID = ?, ";
			asql = asql +"  INT_GRAPHICSID = ?, ";
			asql = asql +"  INT_CHIPSETID = ?, ";
			asql = asql +"  CHR_WIFI = ?, ";
			asql = asql +"  CHR_TOUCHSCREEN = ?, ";
			asql = asql +"  CHR_CARDREADER = ?  ";
			asql=asql+" WHERE INT_PRODUCTIDS=?";
			apstm=con.prepareStatement(asql);
			apstm.setString(1,make);
			apstm.setString(2,model);
			apstm.setString(3,processor);
			apstm.setString(4,memory);
			apstm.setString(5,harddisk);
			apstm.setString(6,os);
			apstm.setString(7,warrantysupport);
			apstm.setString(8,monitor);
			apstm.setString(9,opticaldrive);
			apstm.setString(10,lan);
			apstm.setString(11,wireless);
			apstm.setString(12,graphics);
			apstm.setString(13,chipset);
			apstm.setString(14,wifi);
			apstm.setString(15,touchscreen);
			apstm.setString(16,cardreader);
			apstm.setString(17,rowid);
			System.out.println(""+apstm);
			apstm.execute();
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVproductListAdd"))
				{
					productAdd(request, response);				
					con.close();    
					response.sendRedirect("Smart Inventory/ProductVAction.jsp?addMore=Y");
				}
				else if(action.equals("INVproductListEdit"))
				{
					productEdit(request, response);				
					con.close();    
					response.sendRedirect("Smart Inventory/ProductListView.jsp");
				}			
				else if(action.equals("INVInnerConfiguration"))
				{
					productInnerConfiguration(request, response);				
					con.close();    
					response.sendRedirect("Smart Inventory/ProductListView.jsp");
				}			
				else if(action.equals("INVProductDelete"))
				{
					productDelete(request, response);				
					con.close();    
					response.sendRedirect("Smart Inventory/ProductListView.jsp");
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

