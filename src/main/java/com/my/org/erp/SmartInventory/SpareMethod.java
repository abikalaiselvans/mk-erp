package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
 
public class SpareMethod extends HttpServlet
{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static void LoadSpareGroup(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{
			
			String StartLetter = ""+request.getParameter("startLetter");
		 	String sql="";
		 	sql =  " SELECT INT_GROUPID,CHR_GROUPNAME   FROM inv_m_sparegroup ";
			if(!"0".equals(StartLetter))
	 			sql= sql+" WHERE  CHR_GROUPNAME LIKE '"+StartLetter+"%'";
	 		sql = sql + " ORDER BY CHR_GROUPNAME ";	  
			System.out.println(sql);
	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{
 	 				sb.append("<Row>");
 					sb.append("<Rowid>"+readData[u][0].trim()+"</Rowid>");
 					sb.append("<Name>"+readData[u][1].trim()+"</Name>");
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
		catch(Exception e){
			
		}
	}	
	
	
	
	
	public static void LoadSpare(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
			String search=""+request.getParameter("search");
			String group=""+request.getParameter("group");
			String sql="";
			sql = "  SELECT b.CHR_GROUPNAME,a.CHR_SPARENAME,a.CHR_DES,a.INT_ACTIVE,a.DOU_PURCHASEPRICE,a.DOU_SALESPRICE,a.CHR_WARRANTY,a.INT_SPAREID "; 
			sql = sql + " FROM inv_m_spare  a, inv_m_sparegroup b WHERE a.INT_GROUPID = b.INT_GROUPID";
			if(!"0".equals(group))
				sql = sql + " AND a.INT_GROUPID="+group+"   ";
			if(!"".equals(search))
				if(!"0".equals(search))
					sql = sql + " AND a.CHR_SPARENAME LIKE '"+search+"%' ";
			sql = sql + " ORDER BY a.CHR_SPARENAME ";
			 System.out.println(sql);
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<Row>");
	 				sb.append("<group>" + readData[u][0]+ "</group>");
	 				sb.append("<Name>" + readData[u][1]+ "</Name>");  
                    sb.append("<Des>" + readData[u][2].replace("&", "")+ "</Des>");
                    sb.append("<Active>" + readData[u][3]+ "</Active>");
                    sb.append("<PurPrice>" + readData[u][4]+ "</PurPrice>");
                    sb.append("<SalesPrice>" + readData[u][5]+ "</SalesPrice>");
                    sb.append("<Warranty>" + readData[u][6]+ "</Warranty>");
                    sb.append("<Id>" + readData[u][7]+ "</Id>");
	 				sb.append("</Row>");	                    
	 			}
	 			 
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        	 
		}
		catch(Exception e){
			
		}
	}	
		
	
	 public  static void loadSparePurchase(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 HttpSession session=request.getSession();
	    		 String branchId=""+session.getAttribute("BRANCHID");
	    		 @SuppressWarnings("unused")
				 String admin =""+session.getAttribute("USRTYPE");
	    		 @SuppressWarnings("unused")
				 String userid =""+session.getAttribute("USRID");
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 String month=request.getParameter("month");
	    		 String vendor=""+request.getParameter("vendor");
	    		 String division=""+request.getParameter("division");
	    		 String ssql="";
	    		 String day=request.getParameter("day");
	    		 int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     String sql = " SELECT a.INT_PURCHASEID,a.CHR_PURCHASENO,b.CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') , ";
	    	     sql = sql +" a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS ,a.CHR_FLAG,a.CHR_SALEFLAG,a.DOU_TOTALAMOUNT FROM inv_t_sparepurchase  a, inv_m_vendorsinformation  b ";
	    	     sql = sql +" where   a.INT_VENDORID=b.INT_VENDORID ";
	    	     sql = sql +" AND a.INT_BRANCHID ="+branchId+ " "+ssql;
	    	     
	    	     if(!"0".equals(month))
	    	    	 sql = sql +" AND month(a.DAT_ORDERDATE) = "+month;
	    	    
	    	     if(!"0".equals(day))
	    	    	 sql=sql+ " AND DAY(a.DAT_ORDERDATE)="+day;

	    	     sql = sql +" AND year(a.DAT_ORDERDATE)=   "+year;
	    	     if(!"0".equals(division))
	    	    	 sql = sql +" AND a.INT_DIVIID = "+division;
	    	     
	    	     if(!"0".equals(vendor))
	    	    	 sql = sql +"  AND a.INT_VENDORID = "+vendor;
	    	     if( ! "0".equals(txtSer))
	    	    	 sql = sql +" AND b.CHR_VENDORNAME LIKE '"+txtSer+"%'";
	    	     sql = sql +" order by SUBSTRING_INDEX(a.CHR_PURCHASENO, '/',1)  ,a.DAT_ORDERDATE ";
	    	    
	    	     System.out.println(sql);;
	    	     
	    	     String readData[][] =CommonFunctions.QueryExecute(sql);
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directPurchase>");
		     				sb.append("<salId>" + readData[u][0].trim() +"</salId>");
		     				sb.append("<salNo>" + readData[u][1].trim() +"</salNo>");
		     				sb.append("<salDate>" +readData[u][3].trim() + "</salDate>");
		     				sb.append("<salTotal>" + (readData[u][4].trim())+ "</salTotal>");
		     				
		     				if("Y".equalsIgnoreCase(readData[u][5].trim()))
		     					sb.append("<PStatus>Paid</PStatus>");
		     				else
		     					sb.append("<PStatus>Pending</PStatus>");
		                	
		     				if("Y".equalsIgnoreCase(readData[u][6].trim()))
		     					sb.append("<Status>Y</Status>");
		     				else
		     					sb.append("<Status>N</Status>");
		     				
		     				if("Y".equalsIgnoreCase(readData[u][7].trim()))
		     					sb.append("<SalesStatus>Y</SalesStatus>");
		     				else
		     					sb.append("<SalesStatus>N</SalesStatus>");
		     				
		     				sb.append("<quoCust>" + readData[u][2].trim().replace("&", "9865043008")+ "</quoCust>");
		     				sb.append("<salAmount>" +readData[u][4].trim() + "</salAmount>");
		                	sb.append("</directPurchase>");
			    	}	
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<DirectPurchases>" + sb.toString() + "</DirectPurchases>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} catch (Exception e) {
				 
				 System.out.println(e.getMessage());
			} 
	    }
	    
	    
	
	
	public static void LoadSpareAssign(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String spareid=""+request.getParameter("spareid");
    		 	HttpSession session=request.getSession();
    			String branchid=""+session.getAttribute("BRANCHID");
    		 	int  stock=0;
    		 	
    		 	sql = " SELECT COUNT(*) ";
				sql = sql +" FROM inv_t_sparegoodsreceived ";
				sql = sql +" WHERE CHR_FLAG <> 'Y'  AND CHR_FLAG='N' AND CHR_SERIALNO IS NOT NULL ";
				sql = sql +" AND  INT_SPAREID ="+spareid;
				sql = sql +" AND  INT_BRANCHID ='"+branchid+"' ";
				System.out.println(sql);
				stock = CommonFunction.intRecordCount(sql);
				String readData[][] =  CommonFunctions.QueryExecute(" Select CHR_DES,DOU_PURCHASEPRICE,DOU_SALESPRICE from inv_m_spare WHERE  INT_SPAREID ="+spareid);
    		 	StringBuffer sb = new StringBuffer();
    		 	if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 		 		sb.append("<Assign>");
	     				sb.append("<Desc>"+readData[u][0].replace("&", " ")+"</Desc>");
	     				sb.append("<PPrice>"+readData[u][1]+"</PPrice>");
	     				sb.append("<Price>"+readData[u][2]+"</Price>");
	     				sb.append("<Stock>"+stock+"</Stock>");
	     				sb.append("<Plist>-</Plist>");
	     				sb.append("<Ptype>-</Ptype>");
	     				sb.append("</Assign>");
	     			}
		 			System.out.println( sb.toString() );
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Assigns>" + sb.toString() + "</Assigns>");
		 		}
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	

		
}

