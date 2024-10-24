package com.my.org.erp.SmartAset;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
 

 
public class AssetMethod extends HttpServlet
{ 
	 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static void loadItemData(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String itemgroup=request.getParameter("itemgroup");
    		 	String startLetter=request.getParameter("startLetter");
    		 	
    		 	String sql="";
    		 	sql = sql + " SELECT a.INT_ITEMID, b.CHR_GROUPNAME,a.CHR_ITEMNAME,a.CHR_DES,a.INT_ACTIVE,a.CHR_RETURNABLE ";
    		 	sql = sql + " FROM asset_m_item a,asset_m_itemgroup b ";
    		 	sql = sql + " WHERE a.INT_ITEMGROUPID = b.INT_ITEMGROUPID ";
    		 	if(!"0".equals(itemgroup))
		 			sql= sql+" AND a.INT_ITEMGROUPID="+ itemgroup;
		 		if(!"0".equals(startLetter))
		 			sql= sql+" AND a.CHR_ITEMNAME LIKE '"+startLetter+"%'";
		 		sql=sql+" ORDER BY  a.CHR_ITEMNAME";
		 		System.out.println(sql);
		 		String readData[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Row>");
	 	 				sb.append("<Id>"+readData[u][0].trim()+"</Id>");
	 	 				sb.append("<Group>"+readData[u][1].trim()+"</Group>");
	 					sb.append("<Item>"+readData[u][2].trim()+"</Item>");
	 					sb.append("<Desc>"+readData[u][3].replace("&", "").trim()+"</Desc>");
	 					sb.append("<Active>"+readData[u][4].trim()+"</Active>");
	 					sb.append("<Return>"+readData[u][5].trim()+"</Return>");
	 					sb.append("</Row>");
	 				}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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

	public static void LoadAssetEntry(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String division=request.getParameter("division");
    		 	String Branch=request.getParameter("Branch");
    		 	String StartLetter = ""+request.getParameter("id");
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String sql="";
    			sql = "SELECT a.INT_ASSETSERIALID,f.CHR_GROUPNAME,e.CHR_ITEMNAME,e.CHR_DES,c.CHR_COMPANYNAME,b.CHR_BRANCHNAME,d.CHR_DIVICODE, DATE_FORMAT(a.DT_PURCHASE,'%d-%m-%Y'),a.CHR_INVOICENUMBER, a.CHR_SERIALNUMBER,a.CHR_STATUS,a.CHR_FLAG FROM  asset_t_assetserilano a  ,com_m_branch b,com_m_company c,inv_m_division d, asset_m_item e,asset_m_itemgroup f  WHERE a.INT_BRANCHID= b.INT_BRANCHID AND b.INT_COMPANYID= c.INT_COMPANYID AND a.INT_DIVIID=d.INT_DIVIID 	AND a.CHR_ITEMID = e.CHR_ITEMID AND e.INT_ITEMGROUPID= f.INT_ITEMGROUPID  ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		if(!"0".equals(month))
		 			sql = sql + " AND MONTH(a.DT_PURCHASE)="+month+" ";
		 		sql = sql + " AND YEAR(a.DT_PURCHASE)="+year+" ";
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND e.CHR_ITEMNAME LIKE '"+StartLetter+"%'";
		 		sql=sql+" ORDER BY  e.CHR_ITEMNAME";
		 		
		 		System.out.println(sql);;
		 		String readData[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Row>");
	 	 				sb.append("<Id>"+readData[u][0].trim()+"</Id>");
	 	 				sb.append("<Group>"+readData[u][1].trim()+"</Group>");
	 					sb.append("<Item>"+readData[u][2].trim()+"</Item>");
	 					sb.append("<Desc>"+readData[u][3].replace("&", "").trim()+"</Desc>");
	 					sb.append("<Company>"+readData[u][4].trim()+"</Company>");
	 					sb.append("<Branch>"+readData[u][5].trim()+"</Branch>");
	 					sb.append("<Division>"+readData[u][6].trim()+"</Division>");
	 					sb.append("<PDate>"+readData[u][7].trim()+"</PDate>");
	 					sb.append("<PO>"+readData[u][8].trim()+"</PO>");
	 					sb.append("<Serial>"+readData[u][9].trim()+"</Serial>");
	 					sb.append("<Status>"+readData[u][10].trim()+"</Status>");
	 					sb.append("<Stock>"+readData[u][11].trim()+"</Stock>");
	 					sb.append("</Row>");
	 				}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
	
	
	

	public static void loadUniqueSerialNumber(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 	
    		 	String serialnumber=request.getParameter("serialnumber");
    		 	String sql="";
    		 	sql = " SELECT COUNT(*) FROM asset_t_assetserilano WHERE CHR_SERIALNUMBER='"+serialnumber+"'";
    		 	System.out.println(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	if(com.my.org.erp.common.CommonInfo.RecordExist(sql))
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>TRUE</Exsist>");
     				sb.append("</UniqueId>");
     			}
    		 	else
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>FALSE</Exsist>");
     				sb.append("</UniqueId>");
    		 	}
    		 	response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<UniqueIds>" + sb.toString() + "</UniqueIds>");
	
    		 	
    		  		     	 	 
 	 		 
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
			 
    	 } 
    }
	
	

	public static void LoadAssetTrack(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String division=request.getParameter("division");
    		 	String Branch=request.getParameter("Branch");
    		 	String StartLetter = ""+request.getParameter("id");
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String customer=request.getParameter("customer");
    		 	String sql="";
		 		sql = " SELECT a.INT_ASSETID,c.CHR_COMPANYNAME,b.CHR_BRANCHNAME,d.CHR_DIVICODE,e.CHR_CUSTOMERNAME,a.CHR_REF,f.CHR_STAFFNAME,  DATE_FORMAT(a.DT_SALES,'%D-%b-%Y'),a.CHR_SALEINVOICE,a.CHR_STATUS ";
		 		sql = sql + " FROM  asset_t_asset a ,com_m_branch b,com_m_company c,inv_m_division d,inv_m_customerinfo e,com_m_staff f  WHERE	 a.INT_BRANCHID= b.INT_BRANCHID AND b.INT_COMPANYID= c.INT_COMPANYID AND a.INT_DIVIID= d.INT_DIVIID AND a.INT_CUSTOMERID = e.INT_CUSTOMERID AND a.CHR_REF=f.CHR_EMPID  ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		sql = sql + " AND MONTH(a.DT_SALES)="+month+" ";
		 		sql = sql + " AND YEAR(a.DT_SALES)="+year+" ";
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		if(!"0".equals(customer))
		 			sql= sql+" AND a.INT_CUSTOMERID="+ customer;
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND a.CHR_SALEINVOICE LIKE '"+StartLetter+"%'";
		 		sql=sql+" ORDER BY  a.CHR_SALEINVOICE ";
		 		System.out.println(sql);
		 		
		 		String readData[][] = CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Row>");
	 	 				sb.append("<Id>"+readData[u][0].trim()+"</Id>");
	 	 				sb.append("<Company>"+readData[u][1].trim()+"</Company>");
	 					sb.append("<Branch>"+readData[u][2].trim()+"</Branch>");
	 					sb.append("<Division>"+readData[u][3].trim()+"</Division>");
	 					sb.append("<Customer>"+readData[u][4].trim()+"</Customer>");
	 					sb.append("<Empid>"+readData[u][5].trim()+"</Empid>");
	 					sb.append("<Empname>"+readData[u][6].replace("&", "").trim()+"</Empname>");
	 					sb.append("<SDate>"+readData[u][7].trim()+"</SDate>");
	 					sb.append("<Invoice>"+readData[u][8].trim()+"</Invoice>");
	 					sb.append("<Status>"+readData[u][9].trim()+"</Status>");
	 					sb.append("</Row>");
	 				}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
	
	

	public static void getAssetStockValue(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String id=request.getParameter("id");
    		 	String Branch=request.getParameter("Branch");
    		 	String sql="";
		 		sql = " SELECT COUNT(*) FROM asset_t_assetserilano WHERE CHR_FLAG='N' AND CHR_STATUS ='Y' AND CHR_ITEMID='"+id+"' AND INT_BRANCHID ="+Branch;
		 		System.out.println(sql);
		 		String readData[][] = CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
    		 	if( CommonInfo.RecordExist(sql))
    		 	{
    		 		sb.append("<Row>");
    		 		sb.append("<Stock>"+ readData[0][0]+"</Stock>");
    		 		sb.append("</Row>");
     			}
    		 	else
    		 	{
    		 		sb.append("<Row>");
     				sb.append("<Stock>0</Stock>");
     				sb.append("</Row>");
    		 	}
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");
	 			response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
			 
    	 } 
    }
	

	
	 
	
	public static void loadAssetSerialNumber(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String serialnumber=request.getParameter("serialnumber");
    		 	String itemid=request.getParameter("itemid");
    		 	HttpSession session=request.getSession();
    			String branch=""+session.getAttribute("BRANCHID"); 
    		 	String sql = "SELECT CHR_SERIALNUMBER,CHR_STATUS FROM asset_t_assetserilano  WHERE INT_ASSETSERIALID>=1";
    		 	sql = sql + " AND CHR_FLAG='N' AND CHR_SERIALNUMBER LIKE '"+serialnumber+"%'";
    		 	sql = sql + " AND INT_BRANCHID="+branch+" ";
    		 	sql = sql + " AND CHR_ITEMID='"+itemid+"' ";
		 		sql=sql+" ORDER BY  CHR_SERIALNUMBER";
		 		System.out.println(sql);
		 		String readData[][] = CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Row>");
	 	 				sb.append("<Serial>"+readData[u][0].trim()+"</Serial>");
	 	 				sb.append("<Status>"+readData[u][1].trim()+"</Status>");
	 					sb.append("</Row>");
	 				}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
