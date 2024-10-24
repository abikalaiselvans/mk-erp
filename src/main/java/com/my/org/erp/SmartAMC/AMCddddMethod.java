package com.my.org.erp.SmartAMC;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.DateUtil;
 
@SuppressWarnings("serial")
public class AMCddddMethod extends HttpServlet
{
	public static void loadItemsData(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
			String search=""+request.getParameter("search");
			String group=""+request.getParameter("group");
			
			String sql="";
			
			
			sql = "  SELECT b.CHR_GROUPNAME,a.CHR_ITEMID,a.CHR_ITEMNAME,a.CHR_DES,a.INT_ACTIVE,a.DOU_PURCHASEPRICE,a.DOU_SALESPRICE,a.CHR_WARRANTY "; 
			sql = sql + " FROM inv_m_item  a, inv_m_itemgroup b WHERE a.INT_ITEMGROUPID = b.INT_ITEMGROUPID";
			if(!"0".equals(group))
				sql = sql + " AND a.INT_ITEMGROUPID="+group+"   ";
			
			if(!"".equals(search)|| !"0".equals(search))
				sql = sql + " AND a.CHR_ITEMNAME LIKE '"+search+"%' ";
			 
			sql = sql + " ORDER BY a.CHR_ITEMNAME ";
			 
			
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<item>");
	 				sb.append("<group>" + readData[u][0]+ "</group>");
	 				sb.append("<id>" + readData[u][1]+ "</id>");
                    sb.append("<itemName>" + readData[u][2]+ "</itemName>");  
                    sb.append("<itemDes>" + readData[u][3].replace("&", "")+ "</itemDes>");
                    sb.append("<itemActive>" + readData[u][4]+ "</itemActive>");
                    sb.append("<itemPurPrice>" + readData[u][5]+ "</itemPurPrice>");
                    sb.append("<itemSalesPrice>" + readData[u][6]+ "</itemSalesPrice>");
                    sb.append("<itemWarranty>" + readData[u][7]+ "</itemWarranty>");
                    sb.append("</item>");	                    
	 			}
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<items>" + sb.toString() + "</items>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        	 
		}
		catch(Exception e){
			
		}
	}	
		
	
	public static void loadItemData(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
				
			
			String search=""+request.getParameter("search");
			String sql="";
			if("".equals(search)||"null".equals(search))
				sql = " SELECT CHR_ITEMID,CHR_ITEMNAME  FROM inv_m_item ORDER BY CHR_ITEMNAME";
			else
				sql = " SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMNAME LIKE '"+search+"%' ORDER BY CHR_ITEMNAME";
			
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<item>");
                    sb.append("<id>" + readData[u][0]+ "</id>");
                    sb.append("<itemName>" + readData[u][1]+ "</itemName>");  
                    sb.append("</item>");	                    
	 			}
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<items>" + sb.toString() + "</items>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        	 
		}
		catch(Exception e){
			 
		}
	}	

	
	public static void loadStock(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
					
			
			String type=""+request.getParameter("type");
			String search=""+request.getParameter("search");
			String sval=""+request.getParameter("sval");
			String Branch=""+request.getParameter("branch");
			String division=""+request.getParameter("division");
			
			
			String sql="";
			if("".equals(search)|| "null".equals(search))
			{	
				if("I".equals(type))
				    if(sval.equals("0"))
				    	sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE  FROM inv_m_item WHERE INT_DIVIID = "+division+" ORDER BY CHR_ITEMNAME ";				    	
				    else
				    	sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE  FROM inv_m_item  WHERE INT_DIVIID = "+division+" AND CHR_ITEMNAME LIKE '"+sval+"%' ORDER BY CHR_ITEMNAME";
				   
				if("P".equals(type))
					if(sval.equals("0"))
						sql =" SELECT CHR_PRODUCTID, CHR_PRODUCTCODE,CHR_PTYPE FROM inv_m_produtlist WHERE INT_DIVIID = "+division+" ORDER BY CHR_PRODUCTCODE";
					else
						sql =" SELECT CHR_PRODUCTID, CHR_PRODUCTCODE ,CHR_PTYPE FROM inv_m_produtlist WHERE  INT_DIVIID = "+division+" AND CHR_PRODUCTCODE LIKE '"+sval+"%' ORDER BY CHR_PRODUCTCODE";
				 
			}
			else
			{
				if("I".equals(type))
					sql = " SELECT CHR_ITEMID, CHR_ITEMNAME,INT_ACTIVE FROM inv_m_item  WHERE  INT_DIVIID = "+division+"  AND CHR_ITEMNAME LIKE '"+search+"%'ORDER BY CHR_ITEMNAME";
				
				if("P".equals(type))
					sql = "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PTYPE   FROM inv_m_produtlist   WHERE INT_DIVIID = "+division+" AND CHR_PRODUCTCODE LIKE '"+search+"%' ORDER BY CHR_PRODUCTCODE";
			}
			 
			
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{
	 				sb.append("<stock>");
	                sb.append("<id>" + readData[u][0]+  "</id>");
	                sb.append("<itemName>" + readData[u][1]+"</itemName>");  
	                sql = "SELECT COUNT(*)  FROM inv_t_stock WHERE CHR_ITEMID ='"+readData[u][0]+"' AND  CHR_TYPE='"+type+"' AND INT_BRANCHID ="+Branch; 
	                int sth=0;
	                if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
	                {	
	                	sb.append("<itemStockIn>"+sth+"</itemStockIn>");
	                	sb.append("<itemAveragePrice>0</itemAveragePrice>");
	                	sb.append("<itemLastSale>-</itemLastSale>");
	                	sb.append("<ptype>-</ptype>");
	                }	
	                else
	                {
	                	sql = "SELECT INT_STOCKINHAND,DAT_SALESDATE FROM inv_t_stock WHERE CHR_ITEMID ='"+readData[u][0]+"' AND  CHR_TYPE='"+type+"' AND INT_BRANCHID ="+Branch;
	                	String stockData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	                	sb.append("<itemLastSale>"+stockData[0][1]+"</itemLastSale>");
	                	if(("P".equals(type)) && ("S".equals(readData[u][2] )))
	                	{
	                		sql = " SELECT DOU_AVGPRICE FROM inv_t_averageprice"; 
							sql = sql+"	WHERE  CHR_TYPE='"+type+"' "; 
							sql = sql+"	AND CHR_ITEMID='"+readData[u][0]+"'  "; 
							sql = sql+"	AND INT_BRANCHID= "+Branch; 
							sb.append("<itemStockIn>"+stockData[0][0]+"</itemStockIn>");
							if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			                {
		                		String stockAverageprice[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		                		sb.append("<itemAveragePrice>"+com.my.org.erp.common.CommonFunctions.Round(Double.parseDouble(stockAverageprice[0][0]))+"</itemAveragePrice>");
			                }
		                	else 
		                		sb.append("<itemAveragePrice>0</itemAveragePrice>");
							 
							sb.append("<ptype>S</ptype>");

	                	}
	                	else
	                	{
	                		String sssql= "SELECT COUNT(*)  FROM inv_t_vendorgoodsreceived WHERE CHR_ITEMID ='"+readData[u][0].trim()+"' AND CHR_FLAG <> 'Y'  AND CHR_SERIALNO is not null  AND  CHR_TYPE='"+type.trim()+"' AND INT_BRANCHID ="+Branch.trim(); 
	                		sth = com.my.org.erp.common.CommonFunction.intRecordCount(sssql);
		                	sb.append("<itemStockIn>"+sth+"</itemStockIn>");
	                		sql =" SELECT (sum(DOU_UNITPRICE)/(SELECT count(*) FROM inv_t_vendorgoodsreceived "; 
		                	sql = sql+"	WHERE CHR_FLAG ='N' and CHR_GRTFLAG='N' AND CHR_ITEMID='"+readData[u][0]+"'  AND CHR_SERIALNO is not null AND CHR_TYPE='"+type+"'AND INT_BRANCHID="+Branch+" ))  FROM inv_t_vendorgoodsreceived ";
		                	sql = sql+"	WHERE CHR_FLAG ='N' and CHR_GRTFLAG='N' AND CHR_ITEMID='"+readData[u][0]+"'  AND CHR_SERIALNO is not null AND CHR_TYPE='"+type+"' AND INT_BRANCHID="+Branch;
		                	sql = sql+"	group by CHR_ITEMID ";
		                	if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			                {
		                		String stockAverageprice[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		                		sb.append("<itemAveragePrice>"+com.my.org.erp.common.CommonFunctions.Round(Double.parseDouble(stockAverageprice[0][0]))+"</itemAveragePrice>");
			                }
		                	else 
		                		sb.append("<itemAveragePrice>0</itemAveragePrice>");
		                	sb.append("<ptype>-</ptype>");
	                	}
	                	
	                }
	                sb.append("<Branch>"+Branch+"</Branch>");
	                sb.append("</stock>");	                    
	 			}
	 			
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<stocks>" + sb.toString() + "</stocks>");
			} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        }
		}
		catch(Exception e){
			//System.out.println(e.getMessage());
		}
			
	}	
	
	
	
	
	public static void loadStockAll(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
	{
		try
		{	
			
				
			
			String sql="";
			
			
			
			
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{
	 				sb.append("<stock>");
	                sb.append("<id>" + readData[u][0]+  "</id>");
	                sb.append("<itemName>" + readData[u][1]+"</itemName>");  
	                //sql = "SELECT COUNT(*)  FROM inv_t_stock WHERE CHR_ITEMID ='"+readData[u][0]+"' AND  CHR_TYPE='"+type+"' AND INT_BRANCHID ="+branchid; 
	                if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
	                {	
	                	sb.append("<itemStockIn>0</itemStockIn>");
	                }	
	                else
	                {
	                	//sql = "SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID ='"+readData[u][0]+"' AND  CHR_TYPE='"+type+"' AND INT_BRANCHID ="+branchid;
	                	String stockData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	                	sb.append("<itemStockIn>"+stockData[0][0]+"</itemStockIn>");
	                }
	                sb.append("</stock>");	                    
	 			}
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<stocks>" + sb.toString() + "</stocks>");
			} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	        }
		}
		catch(Exception e){
			 
		}
			
	}	
	
	public static void INVSalesNumberItems(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String type=""+request.getParameter("returnType");
    		 	
    		 	
    		 	String saleno=""+request.getParameter("saleno");
    		 
		 		String tablename="";
		 		String field =" SELECT INT_ID,CHR_SALESORDERNO,CHR_ITEMID,CHR_TYPE,CHR_SERIALNO,CHR_WARRANTY,CHR_GRTFLAG FROM";
		 		String field1 =" SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_SERIALNO,CHR_WARRANTY,CHR_GRTFLAG FROM "; 
		 		if(type.equals("Invoice"))
		 			tablename = field+" inv_t_customersalesorderitemserial WHERE CHR_SALESORDERNO ='"+saleno+"'  ORDER BY INT_ID";
		 		else if(type.equals("CashPay"))
		 			tablename =field1 +" inv_t_cashserialno  WHERE CHR_SALESNO ='"+saleno+"'  ORDER BY INT_ID";
		 		else if(type.equals("Direct"))
		 			tablename =field1+" inv_t_swapsalesserialno  WHERE CHR_SALESNO ='"+saleno+"'  ORDER BY INT_ID";
		 		sql = tablename;
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 		 		sb.append("<Record>");
		 		 		for(int y=0;y<7;y++)
		 		 			sb.append("<Column"+(y+1)+">"+readData[u][y]+"</Column"+(y+1)+">");
	     				sb.append("</Record>");
	     			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Records>" + sb.toString() + "</Records>");
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
	
	
	
	public static void LoadBranchess(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		String officeid=""+request.getParameter("office");
 			int id = Integer.parseInt( officeid);
 			String sql="";
 			sql = " SELECT b.INT_COMPANYID,UPPER(a.CHR_COMPANYNAME),b.INT_BRANCHID,UPPER(b.CHR_BRANCHNAME) FROM com_m_branch b, com_m_company a   WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
 			sql = sql +" AND SOUNDEX(b.CHR_BRANCHNAME) = SOUNDEX((SELECT CHR_OFFICENAME FROM  com_m_office  WHERE INT_OFFICEID = "+id+")) AND b.INT_ACTIVE =1 ORDER BY a.CHR_COMPANYNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			String Selection = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_COMPANYSELECTION FROM m_institution WHERE INT_ID=1")[0][0];
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<branch>");
                     sb.append("<Companyid>" + readData[u][0]+ "</Companyid>");
                     sb.append("<CompanyName>" + readData[u][1]+ "</CompanyName>");
                     sb.append("<Branchid>" + readData[u][2]+ "</Branchid>");
                     sb.append("<Selection>" + Selection+ "</Selection>");
                     sb.append("<BranchName>" + readData[u][3]+ "</BranchName>");
                    
                     sb.append("</branch>");	             
 	 			}
 	 			 
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<branches>" + sb.toString() + "</branches>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	
	public static void LoadConveyance(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		String fromdate=""+request.getParameter("fromdate");
    		String todate=""+request.getParameter("todate");
    		fromdate = DateUtil.FormateDateSQL(fromdate);
    		todate = DateUtil.FormateDateSQL(todate);
    		String sql="";
       		HttpSession session=request.getSession();	
    		//String admin =""+session.getAttribute("USRTYPE");
   		 	//String userid =""+session.getAttribute("USRID");
   		 	String empid =""+session.getAttribute("EMPID");
   		 	sql= "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_REPTO='"+empid+"' AND CHR_TYPE!='T' AND CHR_HOLD!='Y'order by CHR_STAFFNAME ";
   		 	String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
   		 	StringBuffer sb = new StringBuffer();
 			int entry=0;
 			if (Data.length > 0)
 	 		{	
 	 			for(int u=0; u<Data.length;u++)
 	 			{	
 	 				
 	 				sql =" SELECT count(*),sum(DOU_TOTAL) FROM conveyance_t_conveyance WHERE CHR_STATUS='N' AND  (DAT_CONDATE)>='"+fromdate+"' AND (DAT_CONDATE)<='"+todate+"'AND CHR_EMPID='"+Data[u][0]+"'";
 					String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 		   		 	entry = Integer.parseInt(readData[0][0]);
 					if(entry > 0)
 		   		 	{
 		   		 		sb.append("<Conveyance>");
 		   		 		sb.append("<Staffid>" + Data[u][0]+ "</Staffid>");
 		   		 		sb.append("<Staffname>" + Data[u][1]+ "</Staffname>");
 		   		 		sb.append("<noofentry>" + readData[0][0]+ "</noofentry>");
 		   		 		sb.append("<amount>" + readData[0][1]+ "</amount>");
 		   		 		sb.append("</Conveyance>");
 		   		 		//Staffid,Staffname,noofentry
 		   		 	}         
 	 			}
 	 			//System.out.println(sb.toString());
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Conveyances>" + sb.toString() + "</Conveyances>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	
	
	public static void LoadTargetAssign(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		String year= request.getParameter("year");
    		String office= request.getParameter("office");
    		String dept= request.getParameter("dept");
    		String startletter= request.getParameter("startletter");
    		
    		String ssql="";
    		if(!"0".equals(startletter))
    			  ssql=" AND a.CHR_STAFFNAME like '"+startletter+"%'";
    			  
    		String sql="";
       		
    		sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN, b.INT_JUL, b.INT_AUG, b.INT_SEP, b.INT_OCT, b.INT_NOV, b.INT_DEC, b.INT_JAN, b.INT_FEB, b.INT_MAR,b.INT_TARGETID FROM com_m_staff a , inv_t_targetassign b ";
    		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
    		sql = sql+ssql;
    		sql = sql+" AND a.INT_OFFICEID="+office+" AND a.INT_DEPARTID="+dept+" AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
   		 	StringBuffer sb = new StringBuffer();
 			if (Data.length > 0)
 	 		{	
 	 			for(int u=0; u<Data.length;u++)
 	 			{	
			 		sb.append("<TargetAssign>");
	   		 		sb.append("<Staffid>" + Data[u][0]+ "</Staffid>");
	   		 		sb.append("<Staffname>" + Data[u][1]+ "</Staffname>");
	   		 		sb.append("<APR>" + Data[u][2]+ "</APR>");
	   		 		sb.append("<MAY>" + Data[u][3]+ "</MAY>");
	   		 		sb.append("<JUN>" + Data[u][4]+ "</JUN>");
	   		 		sb.append("<JUL>" + Data[u][5]+ "</JUL>");
	   		 		sb.append("<AUG>" + Data[u][6]+ "</AUG>");
	   		 		sb.append("<SEP>" + Data[u][7]+ "</SEP>");
	   		 		sb.append("<OCT>" + Data[u][8]+ "</OCT>");
	   		 		sb.append("<NOV>" + Data[u][9]+ "</NOV>");
	   		 		sb.append("<DEC>" + Data[u][10]+ "</DEC>");
	   		 		sb.append("<JAN>" + Data[u][11]+ "</JAN>");
	   		 		sb.append("<FEB>" + Data[u][12]+ "</FEB>");
	   		 		sb.append("<MAR>" + Data[u][13]+ "</MAR>");
	   		 		sb.append("<ROW>" + Data[u][14]+ "</ROW>");
	   		 		sb.append("</TargetAssign>");
	   		 	
	   		 	}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	
	
	
	public static void LoadTargetAssignAll(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		HttpSession session = request.getSession();
    		String usertype=""+session.getAttribute("USRTYPE");
    		String userid=""+session.getAttribute("EMPID");
    		
    		String years= request.getParameter("year");
    		String office= request.getParameter("office");
    		String dept= request.getParameter("dept");
    		String period= request.getParameter("period");
    		String sql="";
    		int year = Integer.parseInt(years);
       		
       		if("1".equals(period))
       		{
       			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN,(b.INT_APR+ b.INT_MAY+ b.INT_JUN)  " +
       					"FROM com_m_staff a , inv_t_targetassign b ";
        		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
        		
        		if("A".equals(usertype))
        			sql = sql+" AND a.CHR_EMPID='"+userid+"' ";
        		
        		
        		if(!"0".equals(office))
        			sql = sql+" AND a.INT_OFFICEID="+office;
        		
        		if(!"0".equals(dept))
        			sql = sql+" AND a.INT_DEPARTID="+dept;
        		
        		
        		sql = sql+"  AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
        		 
        		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double salessum=0;
				double achieve=0;
				double percent=0;
				StringBuffer sb = new StringBuffer();
				if(data.length>0)
				{	
					for(int u=0;u<data.length;u++)
					{
						salessum=0;
						//This is for Direct Sales
						sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
							//Direct Sales
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
						}	
						//Direct Billing
						sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
						}
						
						//Service Billing
						sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
						}
						salessum=CommonFunctions.Round(salessum);
						achieve=CommonFunctions.Round((salessum)/100000);
						percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][5])*100);
						sb.append("<TargetAssign>");
		   		 		sb.append("<Staffid>" + data[u][0]+ "</Staffid>");
		   		 		sb.append("<Staffname>" + data[u][1]+ "</Staffname>");
		   		 		sb.append("<Month1>" + data[u][2]+ "</Month1>");
		   		 		sb.append("<Month2>" + data[u][3]+ "</Month2>");
		   		 		sb.append("<Month3>" + data[u][4]+ "</Month3>");
		   		 		sb.append("<Target>" + data[u][5]+ "</Target>");
		   		 		sb.append("<Sales>" + salessum+ "</Sales>");
		   		 		sb.append("<achieve>" + achieve+ "</achieve>");
		   		 		sb.append("<percent>" + percent+ "</percent>");
		   		 		sb.append("</TargetAssign>");
					 
					}
					response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
       		}
       		else if("2".equals(period))
       		{
       			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JUL, b.INT_AUG, b.INT_SEP,(b.INT_JUL+ b.INT_AUG+ b.INT_SEP)  FROM com_m_staff a , inv_t_targetassign b ";
        		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
        		if(!"0".equals(office))
        			sql = sql+" AND a.INT_OFFICEID="+office;
        		
        		if(!"0".equals(dept))
        			sql = sql+" AND a.INT_DEPARTID="+dept;
        		
        		
        		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
        		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double salessum=0;
				double achieve=0;
				double percent=0;
				StringBuffer sb = new StringBuffer();
				if(data.length>0)
				{	
					for(int u=0;u<data.length;u++)
					{
						salessum=0;
						//This is for Direct Sales
						sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
							
							//Direct Sales
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
						}	
						//Direct Billing
						sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
						}
						
						//Service Billing
						sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
						}
						salessum=CommonFunctions.Round(salessum);
						achieve=CommonFunctions.Round(salessum/100000);
						percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][5])*100);
						sb.append("<TargetAssign>");
		   		 		sb.append("<Staffid>" + data[u][0]+ "</Staffid>");
		   		 		sb.append("<Staffname>" + data[u][1]+ "</Staffname>");
		   		 		sb.append("<Month1>" + data[u][2]+ "</Month1>");
		   		 		sb.append("<Month2>" + data[u][3]+ "</Month2>");
		   		 		sb.append("<Month3>" + data[u][4]+ "</Month3>");
		   		 		sb.append("<Target>" + data[u][5]+ "</Target>");
		   		 		sb.append("<Sales>" + salessum+ "</Sales>");
		   		 		sb.append("<achieve>" + achieve+ "</achieve>");
		   		 		sb.append("<percent>" + percent+ "</percent>");
		   		 		sb.append("</TargetAssign>");
					 
					}
					response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
       		}
       		else if("3".equals(period))
       		{
       			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_OCT, b.INT_NOV, b.INT_DEC,(b.INT_OCT+ b.INT_NOV+ b.INT_DEC)  FROM com_m_staff a , inv_t_targetassign b ";
       			//INT_OCT INT_NOV INT_DEC INT_JAN INT_FEB INT_MAR
       			sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
       			if(!"0".equals(office))
        			sql = sql+" AND a.INT_OFFICEID="+office;
        		
        		if(!"0".equals(dept))
        			sql = sql+" AND a.INT_DEPARTID="+dept;
        		
        		
        		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
        		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double salessum=0;
				double achieve=0;
				double percent=0;
				StringBuffer sb = new StringBuffer();
				if(data.length>0)
				{	
					for(int u=0;u<data.length;u++)
					{
						salessum=0;
						//This is for Direct Sales
						sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
							
							//Direct Sales
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
						}	
						//Direct Billing
						sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
							
						}
						
						//Service Billing
						sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
						}
						salessum=CommonFunctions.Round(salessum);
						achieve=CommonFunctions.Round(salessum/100000);
						percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][5])*100);
						sb.append("<TargetAssign>");
		   		 		sb.append("<Staffid>" + data[u][0]+ "</Staffid>");
		   		 		sb.append("<Staffname>" + data[u][1]+ "</Staffname>");
		   		 		sb.append("<Month1>" + data[u][2]+ "</Month1>");
		   		 		sb.append("<Month2>" + data[u][3]+ "</Month2>");
		   		 		sb.append("<Month3>" + data[u][4]+ "</Month3>");
		   		 		sb.append("<Target>" + data[u][5]+ "</Target>");
		   		 		sb.append("<Sales>" + salessum+ "</Sales>");
		   		 		sb.append("<achieve>" + achieve+ "</achieve>");
		   		 		sb.append("<percent>" + percent+ "</percent>");
		   		 		sb.append("</TargetAssign>");
					 
					}
					response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
       		}
       		else if("4".equals(period))
       		{
       			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JAN, b.INT_FEB, b.INT_MAR,(b.INT_JAN+ b.INT_FEB+b.INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
       			sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
       			if(!"0".equals(office))
        			sql = sql+" AND a.INT_OFFICEID="+office;
        		
        		if(!"0".equals(dept))
        			sql = sql+" AND a.INT_DEPARTID="+dept;
        		
        		
        		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
        		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double salessum=0;
				double achieve=0;
				double percent=0;
				StringBuffer sb = new StringBuffer();
				if(data.length>0)
				{	
					for(int u=0;u<data.length;u++)
					{
						salessum=0;
						//This is for Direct Sales
						sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
							//	Direct Sales
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
						}	
						//Direct Billing
						sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
						}
						
						//Service Billing
						sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
						}
						salessum=CommonFunctions.Round(salessum);
						achieve=CommonFunctions.Round(salessum/100000);
						percent =CommonFunctions.Round((achieve/Double.parseDouble(data[u][5]))*100);
						//percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][14])*100);
						sb.append("<TargetAssign>");
		   		 		sb.append("<Staffid>" + data[u][0]+ "</Staffid>");
		   		 		sb.append("<Staffname>" + data[u][1]+ "</Staffname>");
		   		 		sb.append("<Month1>" + data[u][2]+ "</Month1>");
		   		 		sb.append("<Month2>" + data[u][3]+ "</Month2>");
		   		 		sb.append("<Month3>" + data[u][4]+ "</Month3>");
		   		 		sb.append("<Target>" + data[u][5]+ "</Target>");
		   		 		sb.append("<Sales>" + salessum+ "</Sales>");
		   		 		sb.append("<achieve>" + achieve+ "</achieve>");
		   		 		sb.append("<percent>" + percent+ "</percent>");
		   		 		sb.append("</TargetAssign>");
					 
					}
					response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
       		}
       		else if("5".equals(period))
       		{
       			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, INT_APR,INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,INT_DEC,INT_JAN,INT_FEB,INT_MAR ,(INT_APR+INT_MAY+INT_JUN+INT_JUL+INT_AUG+INT_SEP+INT_OCT+INT_NOV+INT_DEC+INT_JAN+INT_FEB+INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
       			sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
       			if(!"0".equals(office))
        			sql = sql+" AND a.INT_OFFICEID="+office;
        		
        		if(!"0".equals(dept))
        			sql = sql+" AND a.INT_DEPARTID="+dept;
        		
        		
        		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
        		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double salessum=0;
				
				double achieve=0;
				double percent=0;
				StringBuffer sb = new StringBuffer();
				if(data.length>0)
				{	
					for(int u=0;u<data.length;u++)
					{
						salessum=0;
						//This is for Direct Sales
						sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
							//Direct Sales
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
						}	
						//Direct Billing
						sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
						}
						
						//Service Billing
						sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{
							sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
						}
						
						salessum=CommonFunctions.Round(salessum);
						achieve=CommonFunctions.Round(salessum/100000);
						percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][14])*100);
						
						sb.append("<TargetAssign>");
		   		 		sb.append("<Staffid>" + data[u][0]+ "</Staffid>");
		   		 		sb.append("<Staffname>" + data[u][1]+ "</Staffname>");
		   		 		sb.append("<Month1>" + data[u][2]+ "</Month1>");
		   		 		sb.append("<Month2>" + data[u][3]+ "</Month2>");
		   		 		sb.append("<Month3>" + data[u][4]+ "</Month3>");
		   		 		sb.append("<Month4>" + data[u][5]+ "</Month4>");
		   		 		sb.append("<Month5>" + data[u][6]+ "</Month5>");
		   		 		sb.append("<Month6>" + data[u][7]+ "</Month6>");
		   		 		sb.append("<Month7>" + data[u][8]+ "</Month7>");
		   		 		sb.append("<Month8>" + data[u][9]+ "</Month8>");
		   		 		sb.append("<Month9>" + data[u][10]+ "</Month9>");
		   		 		sb.append("<Month10>" + data[u][11]+ "</Month10>");
		   		 		sb.append("<Month11>" + data[u][12]+ "</Month11>");
		   		 		sb.append("<Month12>" + data[u][13]+ "</Month12>");
	 			 		sb.append("<Target>" + data[u][14]+ "</Target>");
		   		 		sb.append("<Sales>" + salessum+ "</Sales>");
		   		 		sb.append("<achieve>" + achieve+ "</achieve>");
		   		 		sb.append("<percent>" + percent+ "</percent>");
		   		 		sb.append("</TargetAssign>");
					}
					 
					response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
       		}
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	public static void LoadTargetAssignMonth(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		HttpSession session = request.getSession();
     		String usertype=""+session.getAttribute("USRTYPE");
     		String userid=""+session.getAttribute("EMPID");
     		

    		String years= request.getParameter("year");
    		String office= request.getParameter("office");
    		String dept= request.getParameter("dept");
    		String months= request.getParameter("month");
    		String sql="";
    		int year = Integer.parseInt(years);
    		int month = Integer.parseInt(months);
    		int yea = year;
       		
    		
       		sql= "SELECT a.CHR_EMPID,b.INT_JAN,b.INT_FEB,b.INT_MAR, b.INT_APR, b.INT_MAY, b.INT_JUN,b.INT_JUL,b.INT_AUG,b.INT_SEP,b.INT_OCT,b.INT_NOV,b.INT_DEC,a.CHR_STAFFNAME" +
       				" FROM com_m_staff a , inv_t_targetassign b ";
    		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
    		if("A".equals(usertype))
    			sql = sql+" AND a.CHR_EMPID='"+userid+"' ";
    		if(!"0".equals(office))
    			sql = sql+" AND a.INT_OFFICEID="+office;
    		if(!"0".equals(dept))
    			sql = sql+" AND a.INT_DEPARTID="+dept;
    		sql = sql+"  AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		
    		
    		 
    	 
    		
    		
    		if((month >=1 )&& (month <=3))
				yea=yea+1;
			String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		if(data.length>0)
			{	
    			double salessum=0;
				double achieve=0;
				double percent=0;
				StringBuffer sb = new StringBuffer();
				for(int u=0;u<data.length;u++)
				{
    				salessum=0;
    				achieve=0;
    				percent=0;
    				sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
					//Direct Sales
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					}
					
					//Direct Billing
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
					}
					
					//Service Billing
					sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
					}
				
					salessum=CommonFunctions.Round(salessum);
					achieve=CommonFunctions.Round(salessum/100000);
					percent =CommonFunctions.Round((achieve/Double.parseDouble(data[u][month]))*100);
					
					/*sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+yea+"-"+month+"-01' AND DAT_SALESDATE <='"+(yea)+"-"+month+"-31' AND CHR_PAYMENTSTATUS !='S'";
					//System.out.println(sql);
					String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					salessum = CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					achieve=CommonFunctions.Round((salessum)/100000);
					percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][month])*100);
					*/
					sb.append("<TargetAssign>");
	   		 		sb.append("<Staffid>" + data[u][0]+ "</Staffid>");
	   		 		sb.append("<Staffname>" + data[u][13]+ "</Staffname>");
	   		 		sb.append("<Target>" + data[u][month]+ "</Target>");
	   		 		sb.append("<Sales>" + salessum+"</Sales>");
	   		 		sb.append("<achieve>" + achieve+ "</achieve>");
	   		 		sb.append("<percent>" + percent+ "</percent>");
	   		 		sb.append("</TargetAssign>");
				
				}
				response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	

	public static void LoadTargetAssignAvgCollection(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		String years= request.getParameter("year");
    		String Branch= request.getParameter("Branch");
    		String division= request.getParameter("division");
    		String months= request.getParameter("month");
    		String sql="";
    		int year = Integer.parseInt(years);
    		int month = Integer.parseInt(months);
    		sql ="SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		if(data.length>0)
			{	
    			StringBuffer sb = new StringBuffer();
    			
				for(int u=0;u<data.length;u++)
				{
					sql = " SELECT count(*) ";
					sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
					sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
					sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
					sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
					sql = sql+ " AND a.INT_BRANCHID= "+Branch;
					if(!"0".equals(division))
						sql = sql+ " AND b.INT_DIVIID= "+division;
					sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
					sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
					sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
					
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						sql = " SELECT count(*) ,sum(a.DOU_PAIDAMOUNT),sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE)), ";
						sql = sql+ " sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE))/count(*) ";
						sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
						sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
						sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
						sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
						sql = sql+ " AND a.INT_BRANCHID= "+Branch;
						if(!"0".equals(division))
							sql = sql+ " AND b.INT_DIVIID= "+division;
						sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
						sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
						sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
						String vdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						sb.append("<TargetAssign>");
		   		 		sb.append("<Groupname>" + data[u][1]+ "</Groupname>");
		   		 		sb.append("<NoofINV>" + vdata[0][0]+ "</NoofINV>");
		   		 		sb.append("<Collectionamt>" +com.my.org.erp.common.CommonFunctions.Round((Double.parseDouble(vdata[0][1]))) +"</Collectionamt>");
		   		 		sb.append("<Collectionday>" + vdata[0][2]+ "</Collectionday>");
		   		 		sb.append("<Avg>" + com.my.org.erp.common.CommonFunctions.Round((Double.parseDouble(vdata[0][3])))+ "</Avg>");
		   		 		 
						sb.append("<Detailed>"+data[u][0]+"</Detailed>");
		   		 		sb.append("</TargetAssign>");
		   		 	}
					else
					{
						sb.append("<TargetAssign>");
		   		 		sb.append("<Groupname>" + data[u][1]+ "</Groupname>");
		   		 		sb.append("<NoofINV>0</NoofINV>");
		   		 		sb.append("<Collectionamt>0</Collectionamt>");
		   		 		sb.append("<Collectionday>0</Collectionday>");
		   		 		sb.append("<Avg>0</Avg>");
		   		 		sb.append("<Detailed>0</Detailed>");
		   		 		sb.append("</TargetAssign>");
					}
				}
				 
				response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	public static void LoadTargetAssignCGroup(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		 
    		String years= request.getParameter("year");
    		String Branch= request.getParameter("Branch");
    		String period= request.getParameter("period");
    		String division= request.getParameter("division");
    		
    		String sql="";
    		String ssql="";
    		String dsql="";
    		int year = Integer.parseInt(years);
    		if(!"0".equals(division))
       			dsql=" AND a.INT_DIVIID="+division+"   ";
       		sql = "SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
       		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		if(data.length>0)
			{	
    			StringBuffer sb = new StringBuffer();
    			//First Quarter..............
    			if("1".equals(period))
           		{	
           			for(int u=0;u<data.length;u++)
					{
           				sb.append("<TargetAssign>");
		   		 		sb.append("<Cgroup>" + data[u][0]+ "</Cgroup>");
		   		 		sb.append("<Cgroupname>" + data[u][1]+ "</Cgroupname>");
		   		 		//Total sales for April Month
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+year+"-04-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month1>" + salesdata[0][0]+ "</Month1>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month1>0</Month1>");
					
		   		 		//Total sales for MAY
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-05-01' AND DAT_SALESDATE <='"+year+"-05-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month2>" + salesdata[0][0]+ "</Month2>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month2>0</Month2>");
		   		 		
		   		 		//Total Sales for JUNE
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-06-01' AND DAT_SALESDATE <='"+year+"-06-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month3>" + salesdata[0][0]+ "</Month3>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month3>0</Month3>");
				
		   		 		
		   		 		//Total Sales for April to June
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+year+"-06-31' ";
           				sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
	    				sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
		    				sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		    				sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		    				String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							sb.append("<Target>" + salesdata[0][0]+ "</Target>");
			   		 		
						}
						else
							sb.append("<Target>0</Target>");
						
						sb.append("</TargetAssign>");
					}
           		}
           		//Second Quarter..............
        		if("2".equals(period))
               	{	
            		for(int u=0;u<data.length;u++)
					{
           				sb.append("<TargetAssign>");
		   		 		sb.append("<Cgroup>" + data[u][0]+ "</Cgroup>");
		   		 		sb.append("<Cgroupname>" + data[u][1]+ "</Cgroupname>");
		   		 		//Total sales for JULY Month
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+year+"-07-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month1>" + salesdata[0][0]+ "</Month1>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month1>0</Month1>");
					
		   		 		//Total sales for AUG
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-08-01' AND DAT_SALESDATE <='"+year+"-08-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month2>" + salesdata[0][0]+ "</Month2>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month2>0</Month2>");
		   		 		
		   		 		//Total Sales for SEP
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-09-01' AND DAT_SALESDATE <='"+year+"-09-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month3>" + salesdata[0][0]+ "</Month3>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month3>0</Month3>");
				
		   		 		
		   		 		//Total Sales for April to June
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+year+"-09-31' ";
	   		 			sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
	    				sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
		    				sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		    				sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		    				String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							sb.append("<Target>" + salesdata[0][0]+ "</Target>");
			   		 		
						}
						else
							sb.append("<Target>0</Target>");
						
						sb.append("</TargetAssign>");
					}
           		}
				//Third Quarter
        		if("3".equals(period))
               	{	
        			for(int u=0;u<data.length;u++)
					{
           				sb.append("<TargetAssign>");
		   		 		sb.append("<Cgroup>" + data[u][0]+ "</Cgroup>");
		   		 		sb.append("<Cgroupname>" + data[u][1]+ "</Cgroupname>");
		   		 		//Total sales for OCT Month
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+year+"-10-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month1>" + salesdata[0][0]+ "</Month1>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month1>0</Month1>");
					
		   		 		//Total sales for NOV
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-11-01' AND DAT_SALESDATE <='"+year+"-11-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month2>" + salesdata[0][0]+ "</Month2>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month2>0</Month2>");
		   		 		
		   		 		//Total Sales for DEC
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-12-01' AND DAT_SALESDATE <='"+year+"-12-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month3>" + salesdata[0][0]+ "</Month3>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month3>0</Month3>");
				
		   		 		
		   		 		//Total Sales for OCT to DEC
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+year+"-12-31' ";
		       			sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
	    				sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
		    				sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		    				sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		    				String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							sb.append("<Target>" + salesdata[0][0]+ "</Target>");
			   		 		
						}
						else
							sb.append("<Target>0</Target>");
						
						sb.append("</TargetAssign>");
					}
           		}
        		// Fourth Quarter
        		if("4".equals(period))
               	{	
        			for(int u=0;u<data.length;u++)
					{
           				sb.append("<TargetAssign>");
		   		 		sb.append("<Cgroup>" + data[u][0]+ "</Cgroup>");
		   		 		sb.append("<Cgroupname>" + data[u][1]+ "</Cgroupname>");
		   		 		//Total sales for JAN Month
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-01-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month1>" + salesdata[0][0]+ "</Month1>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month1>0</Month1>");
					
		   		 		//Total sales for FEB
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+(year+1)+"-02-01' AND DAT_SALESDATE <='"+(year+1)+"-02-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month2>" + salesdata[0][0]+ "</Month2>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month2>0</Month2>");
		   		 		
		   		 		//Total Sales for MAR
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+(year+1)+"-03-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' ";
		   		 		sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 		sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 		{	
		   		 			sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 			sb.append("<Month3>" + salesdata[0][0]+ "</Month3>");
		   		 		}
		   		 		else
		   		 			sb.append("<Month3>0</Month3>");
				
		   		 		
		   		 		//Total Sales for OCT to DEC
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' ";
		       			sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
	    				sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
		    				sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		    				sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		    				String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							sb.append("<Target>" + salesdata[0][0]+ "</Target>");
			   		 		
						}
						else
							sb.append("<Target>0</Target>");
						
						sb.append("</TargetAssign>");
					}
           		}
        		//All Quarter
        		if("5".equals(period))
               	{	
        			for(int u=0;u<data.length;u++)
					{
           				sb.append("<TargetAssign>");
		   		 		sb.append("<Cgroup>" + data[u][0]+ "</Cgroup>");
		   		 		sb.append("<Cgroupname>" + data[u][1]+ "</Cgroupname>");
		   		 		for(int x=1;x<13;x++)
		   		 		{
		   		 			if(x<=3)
		   		 				ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+(year+1)+"-"+x+"-01' AND DAT_SALESDATE <='"+(year+1)+"-"+x+"-31' ";
		   		 			else
		   		 				ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+(year)+"-"+x+"-01' AND DAT_SALESDATE <='"+(year)+"-"+x+"-31' ";
		   		 			//System.out.println(data[u][0]+" / "+ssql);
		   		 			sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 			sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 			if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
		   		 			{	
		   		 				sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		   		 				sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		   		 				String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		   		 				sb.append("<Month"+x+">" + salesdata[0][0]+ "</Month"+x+">");
		   		 			}
		   		 			else
		   		 			sb.append("<Month"+x+">0</Month"+x+">");
						}
		   		 		
		   		 		//Total Sales for APR to MAR
		   		 		ssql=dsql+"  AND a.INT_BRANCHID="+Branch+" AND  DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' ";
		       			sql = " SELECT COUNT(*) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
	    				sql = sql +" WHERE CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
						if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
						{	
		    				sql = " SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales a, inv_m_customerinfo b , inv_m_customergroup c ";
		    				sql = sql +" WHERE  CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERGROUPID= c.INT_CUSTOMERGROUPID AND c.INT_CUSTOMERGROUPID="+data[u][0]+ssql;
		    				String salesdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							sb.append("<Target>" + salesdata[0][0]+ "</Target>");
			   		 	}
						else
							sb.append("<Target>0</Target>");
						
						sb.append("</TargetAssign>");
					}
           		}
        		response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	
	public static void LoadContribution(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		String month=""+request.getParameter("month");
    		String ref=""+request.getParameter("ref");
    		String year=""+request.getParameter("year");
    		
    		String sql="";
    	 

    		
    		HttpSession session=request.getSession();	
    		String admin =""+session.getAttribute("USRTYPE");
   		 	String empid =""+session.getAttribute("EMPID");
   		 	
    		 
    		sql = " SELECT a.CHR_SALESNO,a.CHR_EMPID,d.CHR_STAFFNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y'),a.DOU_CONTRIBUTION,UPPER(c.CHR_CUSTOMERNAME) ";
    		sql = sql+" FROM inv_t_contribution a,inv_t_directsales b,inv_m_customerinfo c , com_m_staff d ";
    		sql = sql+" WHERE a.CHR_SALESNO=b.CHR_SALESNO ";
    		sql = sql+" AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
    		sql = sql+" AND a.CHR_EMPID =d.CHR_EMPID ";
    		if(!"F".equals(admin))
    			sql = sql+"  AND a.CHR_EMPID='"+empid+"'";
    		
    		if(!"0".equals(month))
    			sql = sql+"  AND month(a.DAT_SALESDATE) = "+month;
    		sql = sql+"  AND YEAR(a.DAT_SALESDATE) = "+year;
    		if(!ref.equals("0"))
    			sql = sql+" AND a.CHR_EMPID LIKE '"+ref+"%' ";
    		
    		sql = sql+" ORDER BY d.CHR_STAFFNAME ";
    		
    		// System.out.println(sql);
    		StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Row>");
                     sb.append("<Saleno>" + readData[u][0]+ "</Saleno>");
                     sb.append("<Empid>" + readData[u][1]+ "</Empid>");
                     sb.append("<Empname>" + readData[u][2]+ "</Empname>");
                     sb.append("<Date>" + readData[u][3]+ "</Date>");
                     sb.append("<Amount>" + readData[u][4]+ "</Amount>");
                     sb.append("<Customer>" + readData[u][5].replaceAll("&", " AND " ).trim()+ "</Customer>");
                     sb.append("</Row>");
                             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	
	
	public static void LoadAssignPaymentCommitment(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 
		try
		{
    		String salno = request.getParameter("invoicenumber");
    		String billtype = request.getParameter("billtype");
    		String sql="";
   			sql=" SELECT INT_PAYMENTCOMMITMENTID, CHR_SALESNO,CHR_INVOICETYPE,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%b-%Y'),DOU_COMMITMENTAMOUNT,";
   			sql = sql + " CHR_STATUS,DATE_FORMAT(DT_RECIEVEDDATE,'%d-%b-%Y'),DOU_RECEIVEDAMOUNT,CHR_PAYMENTFLAG,CHR_NEXTFLAG  FROM inv_t_paymentcommitment  WHERE CHR_SALESNO='"+salno+"' AND CHR_INVOICETYPE='"+billtype+"'  ";
   			 
   			com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
   			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Commitment>");
 	 				sb.append("<Id>" + readData[u][0]+ "</Id>"); 
 	 				sb.append("<Date>" + readData[u][3]+ "</Date>");
                    sb.append("<Amount>" + readData[u][4]+ "</Amount>");
                    sb.append("<RDate>" + readData[u][6]+ "</RDate>");
                    sb.append("<RAmount>" + readData[u][7]+ "</RAmount>");
                    sb.append("<RStatus>" + readData[u][8]+ "</RStatus>");
                    sb.append("<Next>" + readData[u][9]+ "</Next>");
                     
                    sb.append("</Commitment>");
 	 			}
 	 			 
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Commitments>" + sb.toString() + "</Commitments>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
	
	public static void LoadSalesNumber(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String type=""+request.getParameter("returnType");
    		 	String month=""+request.getParameter("month");
    		 	
    		 	int year=Integer.parseInt(request.getParameter("year"));
    		 	
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		if(type.equals("Invoice"))
		 		{
			 		sql=" SELECT CHR_INVOICENO ";
			 		sql = sql +" FROM  inv_t_customersalesorder   ";
			 		sql = sql +" WHERE DT_INVOICEDATE >='"+fDate+"'"; 
			 		sql = sql +" AND DT_INVOICEDATE <='"+tDate+"'";
			 		sql = sql +" ORDER BY DT_INVOICEDATE ";
		 		}
		 		else if(type.equals("CashPay"))
		 		{
		 			sql=" SELECT CHR_SALESNO ";
			 		sql = sql +" FROM inv_t_cashsales ";
			 		sql = sql +" WHERE DAT_SALESDATE >='"+fDate+"'"; 
			 		sql = sql +" AND DAT_SALESDATE <='"+tDate+"'";
			 		sql = sql +" ORDER BY DAT_SALESDATE ";
		 		}
		 		else if(type.equals("Direct")){
		 			sql=" SELECT CHR_SALESNO  ";
			 		sql = sql +" FROM inv_t_directsales ";
			 		sql = sql +" WHERE DAT_SALESDATE >='"+fDate+"'"; 
			 		sql = sql +" AND DAT_SALESDATE <='"+tDate+"'";
			 		sql = sql +" ORDER BY DAT_SALESDATE ";
		 		}
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 		 		sb.append("<Option>");
	     				sb.append("<Optionval>"+readData[u][0]+"</Optionval>");
	     				sb.append("<Optiondis>"+readData[u][0]+"</Optiondis>");
	     				sb.append("</Option>");
	     			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Optionss>" + sb.toString() + "</Optionss>");
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

	public static void ItemProductAssignStock(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String type=""+request.getParameter("type");
    		 	String itemid=""+request.getParameter("typeid");
    		 	HttpSession session=request.getSession();			
    			
    			String branchid = session.getAttribute("BRANCHID").toString();
    			if(type.equals("1"))
    		 		sql = "SELECT CHR_ITEMID,INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+itemid+"'	AND CHR_TYPE='I' AND INT_BRANCHID = "+branchid; 
    		 	if(type.equals("2"))
    		 		sql = "SELECT CHR_ITEMID,INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+itemid+"'	AND CHR_TYPE='P' AND INT_BRANCHID = "+branchid;
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 		 		sb.append("<Assign>");
	     				if(!readData[u][1].equals("-"))
	     					sb.append("<Stock>"+readData[u][1]+"</Stock>");
	     				else
	     					sb.append("<Stock>0</Stock>");
	     				sb.append("</Assign>");
	     			}
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

	
	public static void ItemProductAssign(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String type=""+request.getParameter("type");
    		 	String typeid=""+request.getParameter("typeid");
    		 	HttpSession session=request.getSession();
    			String branchid=""+session.getAttribute("BRANCHID");
    		 	int  stock=0;
    		 	String ssql="";
    		 	//9865043008
    		 	if(type.equals("1"))
    		 	{	
    		 		sql = " SELECT COUNT(*) ";
					sql = sql +" FROM inv_t_vendorgoodsreceived ";
					sql = sql +" WHERE CHR_FLAG <> 'Y'  AND CHR_SERIALNO IS NOT NULL ";
					sql = sql +" AND  CHR_TYPE ='I' ";
					sql = sql +" AND  CHR_ITEMID ='"+typeid+"' ";
					sql = sql +" AND  INT_BRANCHID ='"+branchid+"' ";
					// System.out.println(sql);
					stock = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
					ssql = " Select CHR_DES,DOU_PURCHASEPRICE,DOU_SALESPRICE from inv_m_item WHERE CHR_ITEMID ='"+typeid+"'";
    		 	}
    		 	if(type.equals("2"))
    		 	{	
    		 		
    		 		sql = "SELECT count(*) FROM inv_m_produtlist WHERE CHR_PTYPE='S' AND CHR_PRODUCTID='"+typeid+"'";
    		 		if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
    		 		{
    		 			sql = " SELECT COUNT(*) ";
    					sql = sql +" FROM inv_t_vendorgoodsreceived ";
    					sql = sql +" WHERE CHR_FLAG <> 'Y'   AND CHR_SERIALNO IS NOT NULL    ";
    					sql = sql +" AND  CHR_TYPE ='P' ";
    					sql = sql +" AND  CHR_ITEMID ='"+typeid+"' ";
    					sql = sql +" AND  INT_BRANCHID ='"+branchid+"' ";
    					// System.out.println(sql);
    					stock = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
    		 		}
    		 		else
    		 		{	
    		 			sql= "SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+typeid+"' AND CHR_TYPE='P' AND  INT_BRANCHID="+branchid;
    		 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 			if(readData.length >0)
    		 			stock = Integer.parseInt(readData[0][0]);
    		 		}
    		 		 
    		 		ssql= " select CHR_PRODUCTDESC,DOU_PURCHASEPRICE,DOU_SALESPRICE ,CHR_ITEMLIST,CHR_PTYPE from inv_m_produtlist WHERE CHR_PRODUCTID ='"+typeid+"'";
    	 		}
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
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
	     				if(type.equals("2"))
	     				{
	     					String listname="";
	     					if("C".equals(readData[u][4]))
	     					{	
	     						String listdata[] = readData[u][3].split("~");
	     						for(int x=0;x<listdata.length;x++)
	     						{
	     							String query = " SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+listdata[x]+"'";
	     							String itemnames[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(query);
	     							listname = listname+itemnames[0][0]+" / "+listdata[x]  +" / ~";
	     						}
	     						sb.append("<Plist>"+listname+"</Plist>");
	     						sb.append("<Ptype>"+readData[u][4]+"</Ptype>");
	     					}
	     					else
	     					{	
	     						sb.append("<Plist>-</Plist>");
	     						sb.append("<Ptype>"+readData[u][4]+"</Ptype>");
	     					}
	     				}
	     				else
	     				{
	     					sb.append("<Plist>-</Plist>");
	     					sb.append("<Ptype>-</Ptype>");
	     				}
	     				sb.append("</Assign>");
	     			}
		 			//System.out.println(sb);
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

	
	public static void ItemProduct(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String id=""+request.getParameter("id");
    		 	if(id.equals("1"))
    		 		sql = " Select CHR_ITEMID,CHR_ITEMNAME from inv_m_item   WHERE INT_ACTIVE=1 ORDER BY CHR_ITEMNAME";
    		 	if(id.equals("2"))
    		 		sql= " select CHR_PRODUCTID,CHR_PRODUCTCODE from inv_m_produtlist  WHERE INT_ACTIVE=1 ORDER BY CHR_PRODUCTCODE";
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	    		 		sb.append("<item>");
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Idname>"+readData[u][1]+"</Idname>");
	     				sb.append("</item>");
		 			}
		 			 
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<items>" + sb.toString() + "</items>");
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
	
	
	public static void LoadItemProductGroup(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String id=""+request.getParameter("id");
    		 	if(id.equals("1"))
    		 		sql = " Select INT_ITEMGROUPID,CHR_GROUPNAME from inv_m_itemgroup    ORDER BY CHR_GROUPNAME";
    		 	if(id.equals("2"))
    		 		sql= " select INT_PRODUCTGROUPID,CHR_NAME from inv_m_productgroup   ORDER BY CHR_NAME";
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	    		 		sb.append("<Row>");
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1]+"</Name>");
	     				sb.append("</Row>");
		 			}
		 			 
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
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


	public static void QuotationEdit(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String itype=""+request.getParameter("type");
    		 	if(itype.equals("1"))
    		 		sql = " Select CHR_ITEMID,CHR_ITEMNAME from inv_m_item ";
    		 	if(itype.equals("2"))
    		 		sql= " select CHR_PRODUCTID,CHR_PRODUCTCODE from inv_m_produtlist ";
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	    		 		sb.append("<item>");
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Idname>"+readData[u][1]+"</Idname>");
	     				sb.append("</item>");
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<items>" + sb.toString() + "</items>");
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

	
	public static void AMCUniqueId(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String tablename=""+request.getParameter("tablename");
    		 	String fieldname=""+request.getParameter("fieldname");
    		 	String value=""+request.getParameter("value");
    		 	sql  = "SELECT COUNT(*) FROM "+tablename+" WHERE "+fieldname+"  = '"+value+"'";
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
    	 } 
    }	


	public static void AMCCustomer(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String customertype = ""+request.getParameter("types");
    		 	String StartLetter=""+request.getParameter("StartLetter");
    		 	String sql="";
    		 	String tablename="";
    		 	if(customertype.equals("C"))
    		 		tablename = " inv_m_customerinfo ";
    		 	if(customertype.equals("N"))
    		 		tablename = " inv_m_noncustomerinfo ";
    		 	if(StartLetter.equals("") || StartLetter.equals("null") )
    		 		sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM "+tablename +" ORDER BY CHR_CUSTOMERNAME";
    		 	else
    				sql = "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM "+tablename +" WHERE CHR_CUSTOMERNAME LIKE '"+StartLetter+"%' ORDER BY CHR_CUSTOMERNAME";
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<ID>");
	 	 				sb.append("<Customerid>"+readData[u][0] +"</Customerid>");
	 	 				sb.append("<Customername>"+readData[u][1]  +"</Customername>");
	 	 				sb.append("</ID>");
		 	 		}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<IDs>" + sb.toString() + "</IDs>");
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

	public static void loadAMC(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String customertype = request.getParameter("customertype");
    		 	String StartLetter=""+request.getParameter("StartLetter");
    		 	int year=Integer.parseInt(request.getParameter("year"));
    		 	String sql=""; 
    		 	String flag="";
    		 	String start="";
    		 	if(customertype.equals("0"))
    		 		flag = " ";
    		 	if(customertype.equals("C"))
    		 		flag = " AND CHR_CUSTOMERFLAG ='C'";
    		 	if(customertype.equals("N"))
    		 		flag = " AND CHR_CUSTOMERFLAG ='N'";
    		 	if(StartLetter.equals("0"))
    		 			start =" ";
    		 	else
    		 		 start =" AND CHR_AMCID LIKE '"+StartLetter+"%'";
    		 	sql = "SELECT INT_AMCID,CHR_AMCID,INT_CUSTOMERID, CHR_CUSTOMERFLAG,DT_STARTDATE,DT_ENDDATE FROM inv_t_amc WHERE  YEAR(DT_STARTDATE) = "+year +flag +start +" ORDER BY CHR_AMCID";
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	
    		 	StringBuffer sb = new StringBuffer();
    		 	String name ="";
    		 	
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<AMC>");
	 	 				sb.append("<Amcid>"+readData[u][1] +"</Amcid>");
	 	 				if(readData[u][3].equals("C"))
	 	 					if(com.my.org.erp.common.CommonInfo.RecordExist("SELECT COUNT(*) FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" +readData[u][2]))
	 	 					{
	 	 						sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_customerinfo WHERE INT_CUSTOMERID=" +readData[u][2];
	 	 						String readName[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 	 						name=readName[0][0];
	 	 					}
	 	 					else
	 	 						name="-";
	 	 				
	 	 				if(readData[u][3].equals("N"))
	 	 					if(com.my.org.erp.common.CommonInfo.RecordExist("SELECT COUNT(*) FROM inv_m_noncustomerinfo WHERE INT_CUSTOMERID=" +readData[u][2]))
	 	 					{	
	 	 						sql = "SELECT CHR_CUSTOMERNAME FROM inv_m_noncustomerinfo WHERE INT_CUSTOMERID=" +readData[u][2];
	 	 						String readName[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 	 						name=readName[0][0];
	 	 					}
	 	 					else
	 	 						name="-";
	 	 				 
	 	    		 	 	 				
	 	 				sb.append("<Customername>-"+name +"</Customername>");
	 	 				sb.append("<Startdate>"+readData[u][4] +"</Startdate>");
	 	 				sb.append("<Enddate>"+readData[u][5] +"</Enddate>");
	 	 				sb.append("<Renewal>Renewal</Renewal>");
	 	 				sb.append("</AMC>");
		 	 		}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
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

	public static void ServiceCompalintID(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String StartLetter=""+request.getParameter("servicecompalintid");
    		 	sql  = "SELECT COUNT(*) FROM inv_t_service WHERE CHR_SERVICEID  = '"+StartLetter+"'";
    		 	StringBuffer sb = new StringBuffer();
    		 	boolean flag = false;
    		 	if(com.my.org.erp.common.CommonInfo.RecordExist(sql))
    		 		flag = true;
    		 	String name = ""+flag;
    		 	name = name.toUpperCase();
    		 	sb.append("<ComplaintId>");
 				sb.append("<Exsist>"+name +"</Exsist>");
 				sb.append("</ComplaintId>");
 				response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<ComplaintIds>" + sb.toString() + "</ComplaintIds>");
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	


	public static void loadServiceAmountAssign(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String payType=""+request.getParameter("type");
    		 	String id=""+request.getParameter("id");
    		 	String sql ="";
    		 	String sql1 ="";
    		 	if(payType.equals("Invoice"))
    		 	{	
    		 		sql=" select DOU_AMCAMOUNT FROM  inv_t_amc WHERE CHR_AMCID = '"+id+"'";
    		 		sql1 = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='"+id+"' and CHR_FLAG='A' group by CHR_SERVICEID";
    		 	}
    		 	
    		 	if(payType.equals("CashPay"))
    		 	{	
    		 		sql="select DOU_SERVICEAMOUNT FROM  inv_t_service WHERE CHR_SERVICEID = '"+id+"'" ;
    		 		sql1 = "select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='"+id+"' and CHR_FLAG='S' group by CHR_SERVICEID";
    		 	}
    		 	double total=0.0;
    		 	double paid=0.0;
    		 	if(com.my.org.erp.common.CommonInfo.RecordExist(sql1))
    		 	{
    		 		String readDatas[][] = com.my.org.erp.common.CommonInfo.doubleRecordSetArray(sql1);
    		 		paid=Double.parseDouble(readDatas[0][0]);
    		 	}
    		 	if(com.my.org.erp.common.CommonInfo.RecordExist(sql))
    		 	{
    		 		String readDatas[][] = com.my.org.erp.common.CommonInfo.doubleRecordSetArray(sql);
    		 		total=Double.parseDouble(readDatas[0][0]);
    		 	}
    		 	
	 		 	StringBuffer sb = new StringBuffer();
 				sb.append("<ServiceId>");
 				sb.append("<Serviceamount>"+total +"</Serviceamount>");
 				sb.append("<Paidamount>"+paid+"</Paidamount>");
 				sb.append("</ServiceId>");
 				response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<ServiceIds>" + sb.toString() + "</ServiceIds>");
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	

	
	public static void loadAMCServiceids(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	
    		 	String payType=""+request.getParameter("type");
    		 	String StartLetter=""+request.getParameter("StartLetter");
    		 	String sql ="";
    		 	if(payType.equals("Invoice"))
    		 	{	
    		 		sql=" select CHR_AMCID FROM  inv_t_amc WHERE CHR_AMCID LIKE '"+StartLetter+"%' ORDER BY CHR_AMCID";
    		 	}
			 	if(payType.equals("CashPay"))
			 	{	
    		 		sql=" select CHR_SERVICEID from inv_t_service WHERE CHR_SERVICEID LIKE '"+StartLetter+"%' ORDER BY CHR_SERVICEID";
			 	}	
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 				sb.append("<ServiceId>");
		 	 				sb.append("<Serviceid>"+readData[u][0] +"</Serviceid>");
		 	 				sb.append("</ServiceId>");
		 	 		}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<ServiceIds>" + sb.toString() + "</ServiceIds>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}		
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	
	
	public static void loadAMCPayment(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String payType=request.getParameter("payType");
    		 	String month=request.getParameter("month");
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		
		 		String sql="";
		 		if(payType.equals("") || payType.equals("null"))
		 			payType = "Invoice";
		 		if(payType.equals("Invoice"))
		 		{
			 		sql=" SELECT CHR_AMCID,INT_CUSTOMERID,CHR_CUSTOMERFLAG,DT_STARTDATE,DOU_AMCAMOUNT,INT_AMCID";
			 		sql = sql +" FROM  inv_t_amc Where year(DT_STARTDATE) = "+year +" and month(DT_STARTDATE) ="+mon ;
				}
		 		if(payType.equals("CashPay"))
		 		{
		 			sql=" SELECT CHR_SERVICEID,INT_CUSTOMERID,CHR_CUSTOMERFLAG,DT_ATTENDATE,DOU_SERVICEAMOUNT,INT_SERVICEID";
			 		sql = sql +" FROM inv_t_service  Where year(DT_ATTENDATE) = "+year +" and month(DT_ATTENDATE) ="+mon ;
		 		}
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		String StartLetter = ""+request.getParameter("id");
		 		String name="";
		 		double paidamount=0.0;
		 		double totalamount=0.0;
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 				paidamount=0.0;
		 				totalamount=0.0;
		 				name="-";
		 				if(readData[u][0].startsWith(StartLetter) || "0".startsWith(StartLetter))
		 	 			{
		 	 				if(payType.equals("Invoice"))
		 	 				{
		 	 					
		 	 					sql =" Select CHR_CUSTOMERNAME from  inv_m_customerinfo WHERE INT_CUSTOMERID ="+readData[u][1];
		 	 					if(com.my.org.erp.common.CommonInfo.RecordExist("Select count(*) from  inv_m_customerinfo WHERE INT_CUSTOMERID ="+readData[u][1]))
		 	 					{	
		 	 						String customername[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 						name =	customername[0][0];
		 	 					}
		 	 					
			 	 				sql ="select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='"+readData[u][0]+"' and CHR_FLAG='A' group by CHR_SERVICEID ";
			 	 				if(com.my.org.erp.common.CommonInfo.RecordExist("select count(*)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='"+readData[u][0]+"' and CHR_FLAG='A' group by CHR_SERVICEID "))
		 	 					{	
		 	 						String paids[][]= com.my.org.erp.common.CommonInfo.doubleRecordSetArray(sql);
		 	 						paidamount = Double.parseDouble(paids[0][0]);
		 	 					}	
		 	 				}
		 	 				if(payType.equals("CashPay"))
		 	 				{
		 	 					sql =" Select CHR_CUSTOMERNAME from  inv_m_noncustomerinfo WHERE INT_CUSTOMERID ="+Integer.parseInt(readData[u][1]);
		 	 					if(com.my.org.erp.common.CommonInfo.RecordExist(" Select count(*) from  inv_m_noncustomerinfo WHERE INT_CUSTOMERID ="+Integer.parseInt(readData[u][1])))
		 	 					{	
		 	 						String customername[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 						name =	customername[0][0];
		 	 					}	
			 	 				sql =" select sum(DOU_PAIDAMOUNT)  FROM  inv_t_serviceamount WHERE CHR_SERVICEID='"+readData[u][0]+"' and CHR_FLAG='S' group by CHR_SERVICEID ";
			 	 				if(com.my.org.erp.common.CommonInfo.RecordExist(" select count(*) FROM  inv_t_serviceamount WHERE CHR_SERVICEID='"+readData[u][0]+"' and CHR_FLAG='S' group by CHR_SERVICEID "))
		 	 					{	
		 	 						String paids[][]= com.my.org.erp.common.CommonInfo.doubleRecordSetArray(sql);
		 	 						paidamount = Double.parseDouble(paids[0][0]);
		 	 					}	
		 	 				}
		 	 				if(!readData[u][4].equals("-")) 
		 	 				{
		 	 					totalamount = Double.parseDouble(readData[u][4]);
		 	 				}
		 	 				sb.append("<Payment>");
		 	 				sb.append("<AmcServiceid>" + readData[u][0]+  "</AmcServiceid>");
		 	 				sb.append("<Customername>" +name+ "</Customername>");
		    	     		sb.append("<Date>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(readData[u][3]) +"</Date>");
		    	     		sb.append("<Amount>"+readData[u][4] +"</Amount>");
		    	     		sb.append("<PaidAmount>"+paidamount+"</PaidAmount>");
		    	     		sb.append("<Balance>"+(totalamount-paidamount) +"</Balance>");
		    	     		if((totalamount-paidamount)==0)
		    	     			sb.append("<Status>Y</Status>");
		    	     		else
		    	     			sb.append("<Status>N</Status>");
		    	     		sb.append("</Payment>");
 	 	 	 			}
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
		 		}	
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	
	

	public static void loadServiceCall(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String StartLetter = ""+request.getParameter("StartLetter");
    		 	String sql =" Select INT_SERVICEID,	CHR_SERVICEID	,CHR_EMPID,	INT_CUSTOMERID	,CHR_CUSTOMERFLAG,";
    		 	sql = sql +" CHR_SERVICEDESC,	DT_ARAISEDATE,	DT_ATTENDATE	,DT_COMPLETEDATE,	CHR_SERVICESTATUS ";
    		 	sql = sql +" From inv_t_service	WHERE month(DT_ARAISEDATE) = "+month ;
    		 	sql = sql +" AND  year(DT_ARAISEDATE) = "+year;
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 			if(readData[u][1].startsWith(StartLetter) || "0".startsWith(StartLetter))
		 	 			{
		 	 				sb.append("<Servicecall>");
		 	 				sb.append("<Servicerowid>"+readData[u][0] +"</Servicerowid>");
		 	 				sb.append("<Serviceid>"+readData[u][1] +"</Serviceid>");
		 	 				
		 	 				
		 	 				if(!readData[u][2].equals("-"))
		 	 				{
		 	 					if(com.my.org.erp.common.CommonInfo.RecordExist("Select count(*) from com_m_staff WHERE CHR_EMPID = '"+readData[u][2]+"'"))
		 	 					{	
		 	 						sql = "Select CHR_STAFFNAME from com_m_staff WHERE CHR_EMPID = '"+readData[u][2]+"'";
		 	 						String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 						sb.append("<Staff>"+readDatas[0][0] +"</Staff>");
		 	 					}	
		 	 					else
		 	 						sb.append("<Staff>-</Staff>");
		 	 				}
		 	 				else
		 	 					sb.append("<Staff>-</Staff>");
		 	 				
		 	 				
		 	 				if(readData[u][4].equals("C"))
		 	 				{
		 	 					if(com.my.org.erp.common.CommonInfo.RecordExist("select count(*) from inv_m_customerinfo where INT_CUSTOMERID ="+readData[u][3]))
		 	 					{	
		 	 						sql = "select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID ="+readData[u][3];
		 	 						String readDatass[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 						sb.append("<Customername>"+readDatass[0][0] +"</Customername>");
		 	 					}
		 	 					else
		 	 						sb.append("<Customername>-</Customername>");
		 	 				}
		 	 				
		 	 				
		 	 				if(readData[u][4].equals("N"))
		 	 				{
		 	 					if(com.my.org.erp.common.CommonInfo.RecordExist("select count(*) from inv_m_noncustomerinfo where INT_CUSTOMERID ="+readData[u][3]))
		 	 					{
		 	 						sql = "select CHR_CUSTOMERNAME from inv_m_noncustomerinfo where INT_CUSTOMERID ="+readData[u][3];
		 	 						String readDatass[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 						sb.append("<Customername>"+readDatass[0][0] +"</Customername>");
		 	 					}
		 	 					else
		 	 						sb.append("<Customername>-</Customername>");
		 	 				}
		 	 				
		 	 				
		 	 				sb.append("<Customerid>"+readData[u][4] +"</Customerid>");
		 	 				sb.append("<Customerflag>"+readData[u][5] +"</Customerflag>");
		 	 				sb.append("<Desc>"+readData[u][5] +"</Desc>");
		 	 				sb.append("<Startdt>"+readData[u][6] +"</Startdt>");
		 	 				sb.append("<Attendt>"+readData[u][7] +"</Attendt>");
		 	 				sb.append("<Enddt>"+readData[u][8] +"</Enddt>");
		 	 				sb.append("<Status>"+readData[u][9] +"</Status>"); 
		 	 	 			sb.append("</Servicecall>");
		 	 			}	
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Servicecalls>" + sb.toString() + "</Servicecalls>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
 	 		      	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	
	
	
	public static void loadSalesPayment(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	HttpSession session=request.getSession();	
    		 	String payType=request.getParameter("payType");
    		 	String division=request.getParameter("division");
    		 	String Payment=request.getParameter("Payment");
    		 	String custid=request.getParameter("customer");
    		 	String bid=""+session.getAttribute("BRANCHID");
    		 	int month=Integer.parseInt(request.getParameter("month"));
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		String sql="";
		 		String ssql="";
		 		String sssql="";
		 		String cust="";

		 		if(!"0".equals(custid))
		 			cust = " AND a.INT_CUSTOMERID="+custid;
		 		
		 		if(!"0".equals(division))
		 			ssql= " AND a.INT_DIVIID="+ division;
		 		
		 		if("1".equals(Payment))
		 			sssql= " AND a.CHR_PAYMENTSTATUS ='N' " ;
		 		else if("2".equals(Payment))
		 			sssql= " AND a.CHR_PAYMENTSTATUS='Y' " ;
		 		else if("3".equals(Payment))
		 			sssql= " AND a.CHR_PAYMENTSTATUS='P' " ;
		 		else
		 			sssql = "";
		 		 
		 		if(payType.equals("Invoice"))
		 		{
			 		/*
			 		 * 
			 		 sql=" SELECT CHR_INVOICENO,INT_CUSTOMERID,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,DT_INVOICEDATE";
			 		sql = sql +" FROM  inv_t_customersalesorder    WHERE INT_BRANCHID >"+bid+" "+cust;
			 		sql = sql +" WHERE DT_INVOICEDATE >='"+fDate+"'"; 
			 		sql = sql +" AND DT_INVOICEDATE <='"+tDate+"'";
			 		sql = sql +" ORDER BY DT_INVOICEDATE  DESC";
			 		*/
		 		}
		 		else if(payType.equals("CashPay"))
		 		{
		 			/*sql=" SELECT CHR_SALESNO,INT_CUSTOMERID,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,DAT_SALESDATE";
			 		sql = sql +" FROM inv_t_cashsales ";
			 		//sql = sql +" WHERE DAT_SALESDATE >='"+fDate+"' ";
			 		//sql = sql +" AND DAT_SALESDATE <='"+tDate+"' ";
			 		sql = sql +" ORDER BY DAT_SALESDATE  DESC";
			 		*/
		 		}
		 		else if(payType.equals("Direct"))
		 		{
		 			
		 			
		 			sql = " SELECT a.CHR_SALESNO,a.INT_CUSTOMERID,b.CHR_CUSTOMERNAME,round(a.DOU_TOTALAMOUNT),a.CHR_PAYMENTSTATUS, "; 
		 			sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') , "; 
		 			sql = sql + " (select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO), "; 
		 			sql = sql + " ((select ROUND(sum(DOU_PAIDAMOUNT)) from   inv_t_customersalespayment c where c.CHR_SALESORDERNO = a.CHR_SALESNO)-round(a.DOU_TOTALAMOUNT)), "; 
		 			sql = sql + " a.INT_BRANCHID,a.INT_DIVIID,a.DAT_SALESDATE ";
		 			sql = sql + " FROM inv_t_directsales a ,inv_m_customerinfo b ";
		 			sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID ";
		 			sql = sql + " AND  a.INT_BRANCHID ="+bid+" ";
			 		sql = sql+cust;
			 		sql = sql +ssql+sssql;
			 		sql = sql + " AND MONTH(a.DAT_SALESDATE) = "+month;
			 		sql = sql + " AND YEAR(a.DAT_SALESDATE) = "+year;
			 		sql = sql +" ORDER BY a.DAT_SALESDATE  DESC";
		 		}
		 		
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		 StringBuffer sb = new StringBuffer();
		 		
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 				sb.append("<Payment>");
		 	 				sb.append("<Customerid>"+readData[u][0]+"</Customerid>");
		 	 				sb.append("<Customername>" +readData[u][2]+ "</Customername>");
		 	 				sb.append("<Totalamount>" + readData[u][3]+ "</Totalamount>");
		 	 				sb.append("<Status>" +  readData[u][4]+"</Status>");
		 	 				sb.append("<Paidamount>"+readData[u][6]+"</Paidamount>");
		 	 				String bal="0";
		 	 				if(!"-".equals(readData[u][7]))
		 	 					bal=readData[u][7];
		 	 				
		 	 				double balance=Integer.parseInt(bal);
		 	 				String ck="";
		    	     		if(balance<0)
		    	     		{
		    	     			balance=0.0;
		    	     			
		    	     			ck="(Check)";
		    	     		}	
		    	     		sb.append("<Balance>"+readData[u][7]+ck+"</Balance>");
		    	     		sb.append("<OrderDate>"+readData[u][10]+"</OrderDate>");
		    	     		sb.append("</Payment>");
		 	 			
		 			}
		 			 
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
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
	//	End - Author :: Kalaiselvan----------------------Sales Payment-----------------------
	

	public static void LoadDirectBilling(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	
    		 	String division=request.getParameter("division");
    		 	String customer=request.getParameter("customer");
    		 	String Branch=request.getParameter("Branch");
    		 	String StartLetter = ""+request.getParameter("id");
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String sql="";
    		 	sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_CUSTOMERNAME,a.CHR_REF , a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME,  (SELECT   count(*) FROM inv_t_paymentcommitment e WHERE   e.CHR_SALESNO =a.CHR_SALESNO  AND e.CHR_STATUS='N' GROUP BY  e.CHR_SALESNO ),(SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME)    FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c  ,inv_t_paymentcommitment d WHERE  a.CHR_SALESNO =d.CHR_SALESNO  AND a.INT_CUSTOMERID=b.INT_CUSTOMERID  AND c.CHR_EMPID = a.CHR_REF   ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		sql = sql + " AND MONTH(a.DAT_SALESDATE)="+month+" ";
		 		sql = sql + " AND YEAR(a.DAT_SALESDATE)="+year+" ";
		 		if(!"0".equals(customer))
		 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
		 		sql=sql+"   GROUP BY a.CHR_SALESNO ORDER BY  a.CHR_SALESNO";
		 		
		 		 
    		 	
    		 	
    		 	
    		 	
    		 	
    		 	
		 		/*sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_CUSTOMERNAME,a.CHR_REF , a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ";
		 		sql = sql + " FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c";
		 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		sql = sql + " AND MONTH(a.DAT_SALESDATE)="+month+" ";
		 		sql = sql + " AND YEAR(a.DAT_SALESDATE)="+year+" ";
		 		if(!"0".equals(customer))
		 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
		 		sql=sql+" ORDER BY  a.CHR_SALESNO";*/
		 		
		 	 
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Direct>");
	 					sb.append("<Invoiceno>"+readData[u][0]+"</Invoiceno>");
	 					sb.append("<Date>"+readData[u][1]+"</Date>");
	 					sb.append("<Customer>"+readData[u][2]+"</Customer>");
	 					sb.append("<Ref>"+readData[u][6]+"</Ref>");
	 					sb.append("<Amount>"+readData[u][4]+"</Amount>");
	 					sb.append("<Status>"+readData[u][5]+"</Status>");
	 					sb.append("<Commitment>"+readData[u][6]+"</Commitment>");
	 					sb.append("<Userid>"+readData[u][8]+"</Userid>");
	 					sb.append("</Direct>");
	 					
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Directs>" + sb.toString() + "</Directs>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
 	 		 
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
			//System.out.println(e);
    	 } 
    }	
	
	
	
	
	public static void LoadServiceBilling(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	
    		 	String division=request.getParameter("division");
    		 	String customer=request.getParameter("customer");
    		 	String Branch=request.getParameter("Branch");
    		 	String StartLetter = ""+request.getParameter("id");
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String sql="";
    		 	sql = "  SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_CUSTOMERNAME,a.CHR_REF , a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ,  (SELECT   count(*) FROM inv_t_paymentcommitment e WHERE   e.CHR_SALESNO =a.CHR_SALESNO  AND e.CHR_STATUS='N' GROUP BY  e.CHR_SALESNO ), (SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME) ,d.CHR_STATUS  FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c ,inv_t_paymentcommitment d   WHERE  a.CHR_SALESNO =d.CHR_SALESNO  AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF    ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		sql = sql + " AND MONTH(a.DAT_SALESDATE)="+month+" ";
		 		sql = sql + " AND YEAR(a.DAT_SALESDATE)="+year+" ";
		 		if(!"0".equals(customer))
		 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
		 		sql=sql+" GROUP BY a.CHR_SALESNO ORDER BY  a.CHR_SALESNO";
		 		 
    		 	
		 		// System.out.println(sql);
    		 	
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Service>");
	 					sb.append("<Invoiceno>"+readData[u][0].trim()+"</Invoiceno>");
	 					sb.append("<Date>"+readData[u][1].trim()+"</Date>");
	 					sb.append("<Customer>"+readData[u][2].replace("&", "").trim()+"</Customer>");
	 					sb.append("<Ref>"+readData[u][6].trim()+"</Ref>");
	 					sb.append("<Amount>"+readData[u][4].trim()+"</Amount>");
	 					sb.append("<Status>"+readData[u][5].trim()+"</Status>");
	 					sb.append("<Commitment>"+readData[u][9].trim()+"</Commitment>");
	 					sb.append("<Userid>"+ readData[u][8].trim()+"</Userid>");
	 					sb.append("</Service>");
	 				}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Services>" + sb.toString() + "</Services>");
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
	
	
	
	public static void loadDirectDC(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	
    		 	String division=request.getParameter("division");
    		 	String customer=request.getParameter("customer");
    		 	String Branch=request.getParameter("Branch");
    		 	String StartLetter = ""+request.getParameter("id");
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String dcstatus=request.getParameter("dcstatus");
    		 	
    		 	String sql="";
		 		 
		 		sql = " SELECT  a.CHR_DCNO,date_format(a.DAT_DCDATE,'%d-%b-%Y'),d.CHR_CUSTOMERNAME,a.CHR_REF ,   ";
		 		sql = sql + " a.CHR_DES,a.INT_DCSTATUS,e.CHR_STAFFNAME,SUM(c.DOU_UNITPRICE)  ";
		 		sql = sql + " FROM inv_t_directdc a,inv_t_directdcitem b,inv_t_vendorgoodsreceived c,inv_m_customerinfo d,com_m_staff e  ";
		 		sql = sql + " WHERE a.CHR_DCNO = b.CHR_DCNO AND   c.CHR_SERIALNO is not null AND   c.CHR_SERIALNO !=''  ";
		 		sql = sql + " AND b.CHR_SERIALNO= c.CHR_SERIALNO  ";
		 		sql = sql + " AND a.INT_CUSTOMERID=d.INT_CUSTOMERID  ";
		 		sql = sql + " AND a.CHR_REF  = e.CHR_EMPID  ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		if(!"0".equals(month))
		 			sql = sql + " AND MONTH(a.DAT_DCDATE)="+month+" ";
		 		sql = sql + " AND YEAR(a.DAT_DCDATE)="+year+" ";
		 		if(!"0".equals(customer))
		 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		if(!"2".equals(dcstatus))
		 			sql= sql+" AND a.INT_DCSTATUS="+ dcstatus;
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND d.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
		 		sql = sql + " GROUP BY a.CHR_DCNO  ";

		 		 
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Service>");
	 					sb.append("<Invoiceno>"+readData[u][0]+"</Invoiceno>");
	 					sb.append("<Date>"+readData[u][1]+"</Date>");
	 					sb.append("<Customer>"+readData[u][2]+"</Customer>");
	 					sb.append("<Status>"+readData[u][5]+"</Status>");
	 					sb.append("<Ref>"+readData[u][6]+"</Ref>");
	 					sb.append("<Dcamount>"+readData[u][7]+"</Dcamount>");
	 					sb.append("</Service>");
	 				}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Services>" + sb.toString() + "</Services>");
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
	
	
	
	
	/*	
	 *	Start - Author :: Kalaiselvan----------------------Purchase Order-----------------------
	 * 	Date: 22/01/2006
	 *  
	*/
	public static void loadPurchaseData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
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
 	     	
 		 	String division=request.getParameter("division");
		 	String vendorid=request.getParameter("vendor");
		 	String ssql ="";
		 	String sssql ="";
		 	if(!"0".equals(division))
		 		ssql= "  AND  INT_DIVIID="+division;
		 	
		 	if(!"0".equals(vendorid))
		 		sssql= "  AND  INT_VENDORID="+vendorid;
		 	
		 	
		 	String sql="SELECT CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_ADDRESSID1,INT_ADDRESSID2,INT_ONHOLD,INT_PURCHASESTATUS,CHR_PAYMENTSTATUS FROM  inv_t_vendorpurchaseorder  " +
 	     		" WHERE INT_BRANCHID="+branchId+" AND DAT_ORDERDATE >='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' " +ssql+sssql+" ORDER BY DAT_ORDERDATE DESC";
 	     	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 	     	StringBuffer sb = new StringBuffer();
 	     	String StartLetter = ""+request.getParameter("id");
 	     	if(readData.length >0)
 	     	{	
 	     		for(int u=0; u<readData.length;u++)
 	     		{
 	     			sql = "SELECT CHR_VENDORNAME FROM  inv_m_vendorsinformation  WHERE INT_VENDORID ="+Integer.parseInt(readData[u][1]);
 	     			String vendor= com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_VENDORNAME");
 	     			if(readData[u][0].toUpperCase().startsWith(StartLetter.toUpperCase()) || "0".startsWith(StartLetter.toUpperCase()))
 	     			{
 	     				sb.append("<purchase>");
 	     				sb.append("<Refid>" + readData[u][0].trim()+ "</Refid>");
 	     				if(!"-".equals(readData[u][2].trim()))
 	     					sb.append("<OrderDate>" +com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(readData[u][2]) + "</OrderDate>");
 	     				else
 	     					sb.append("<OrderDate>" +readData[u][2].trim() + "</OrderDate>");
 	                	sb.append("<Branch>" +vendor.trim() + "</Branch>");
 	                	sb.append("<Vendor>" +vendor.trim() + "</Vendor>");  
 	                	sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+Integer.parseInt(readData[u][3].trim());
 	                	sb.append("<OrderFrom>" +com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME") + "</OrderFrom>");
 	                	sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+Integer.parseInt(readData[u][4].trim());
 	                	sb.append("<ShippingTo>" +com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME") + "</ShippingTo>");
 	                	sb.append("<onHold>" +readData[u][5].trim() + "</onHold>");
 	                	sb.append("<Status>" +readData[u][6].trim() + "</Status>");  
 	                	sb.append("<Payment>" +readData[u][7].trim() + "</Payment>");
 	                	sb.append("<Received>0</Received>");
 	                	sb.append("</purchase>");	    	                
 	     			}
 	     		}
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
			 System.out.println(e.getMessage());
    	 } 
    }	
	//	End - Author :: Kalaiselvan----------------------Purchase Order-----------------------
	 
	
	
	


	/*	
	 *	Start - Author :: Kalaiselvan----------------------GoodsReceived-----------------------
	 * 	Date: 22/01/2006
	 *  
	*/
	public static void loadReceiveData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		String month=request.getParameter("month");
 		 	int year=Integer.parseInt(request.getParameter("year"));
 		 	int mon=Integer.parseInt(month);
 		 	String fDate=year+"-"+month+"-01";
 		 	String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
 	     	String sql="SELECT CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_ADDRESSID1,INT_ADDRESSID2,INT_ONHOLD,INT_PURCHASESTATUS,CHR_PAYMENTSTATUS,CHR_RECIVEDID,DAT_RECIVEDDATE FROM  inv_t_vendorpurchaseorder  " +
 	     		" WHERE DAT_ORDERDATE >='"+fDate+"' AND DAT_ORDERDATE<='"+tDate+"' " +
 	     		" ORDER BY DAT_ORDERDATE DESC";
 		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 	     	StringBuffer sb = new StringBuffer();
 	     	String StartLetter = ""+request.getParameter("id");
 	     	@SuppressWarnings("unused")
			boolean flag = false;
 	     	if(readData.length>0)
 	     	{	
 	     		for(int u=0; u<readData.length;u++)
 	     		{
 	     			sql = "SELECT CHR_VENDORNAME FROM  inv_m_vendorsinformation  WHERE INT_VENDORID ="+Integer.parseInt(readData[u][1]);
 	     			String vendor= com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_VENDORNAME");
 	     			if(readData[u][0].toUpperCase().startsWith(StartLetter.toUpperCase()) || "0".startsWith(StartLetter.toUpperCase()))
 	     			{
 	     				flag = true;
 	     				sb.append("<Receive>");
 	     				sb.append("<Refid>" + readData[u][0]+ "</Refid>");
 	     				sb.append("<Receiveid>" + "-"+readData[u][8]+ "</Receiveid>");
 	     				if("-".equals(readData[u][2]))
 	     					sb.append("<OrderDate>-</OrderDate>");
 	     				else
 	     					sb.append("<OrderDate>" +DateUtil.FormateDateSys(readData[u][2]) + "</OrderDate>");
 	     				
 	     				sb.append("<Vendor>" +vendor + "</Vendor>");  
 	     				sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+Integer.parseInt(readData[u][3]);
 	     				sb.append("<OrderFrom>" +com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME") + "</OrderFrom>");
 	     				sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+Integer.parseInt(readData[u][4]);
 	     				sb.append("<ShippingTo>" +com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME") + "</ShippingTo>");
 	     				sb.append("<onHold>" +readData[u][5] + "</onHold>");
 	     				sb.append("<Status>" +readData[u][6] + "</Status>");  
 	     				sb.append("<Payment>" +readData[u][7] + "</Payment>");
 	     				sb.append("<ReceiveDate>" +readData[u][8] + "</ReceiveDate>");
 	     				sb.append("</Receive>");	
 	     			}
 	     		}
 	     	 	response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<Receives>" + sb.toString() + "</Receives>");
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
	//	End - Author :: Kalaiselvan----------------------GoodsReceived-----------------------
	 
	
	
	
	
	


	/*	
	 *	Start - Author :: Kalaiselvan----------------------GoodsReturn----------------------
	 * 	Date: 22/01/2006
	 *  
	*/
	
	public static void loadReturnData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		 	
		 		
		 		String month=request.getParameter("month");
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		String StartLetter = ""+request.getParameter("id");
		 		
		 		String sql=" SELECT CHR_PURCHASEORDERNO,CHR_RECIVEDID, CHR_GRTNO ,CHR_ITEMID,CHR_SERIALNO,CHR_FLAG FROM  inv_t_vendorgoodsreturn  " ;
		 		sql = sql +" WHERE DAT_RETURNDATE >='"+fDate+"' AND DAT_RETURNDATE<='"+tDate+"' " ;
		 		sql = sql +" GROUP BY CHR_GRTNO ORDER BY DAT_RETURNDATE ";
		 		 
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if(readData.length>0)
		 		{
		 			for(int u=0; u<readData.length;u++)
		 			{
		 				if(readData[u][0].toUpperCase().startsWith(StartLetter.toUpperCase()) || "0".startsWith(StartLetter))
		 				{
		 					sb.append("<Return>");
		 					sb.append("<purchaseid>" + readData[u][0]+ "</purchaseid>");
		 					sb.append("<Receiveid>" + readData[u][1]+ "</Receiveid>");
		 					sb.append("<Grtno>" +readData[u][2] + "</Grtno>");
		 					sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID ='"+readData[u][3]+"'";
		 					String itemname= com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_ITEMNAME");
		 					sb.append("<Itemid>" +itemname + "</Itemid>");  
		 					sb.append("<Serial>" +readData[u][4] + "</Serial>");
		 					sb.append("<Flag>" +readData[u][5] + "</Flag>");
		 					sb.append("</Return>");	
		 				}	
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Returns>" + sb.toString() + "</Returns>");
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
	//	End - Author :: Kalaiselvan----------------------GoodsReturn----------------------
	
	
	
	
	
	
	
	/*	
	 *	Start - Author :: Kalaiselvan----------------------Payment-----------------------
	 * 	Date: 22/01/2006
	 *  
	*/
	public static void loadPaymentData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String payment=request.getParameter("payment");
    		 	String Status=request.getParameter("Status");
    		 	String divis=request.getParameter("divis");
    		 	String vendorid=request.getParameter("vendorid");
    		 	
    		 	String sql="";
		 		String ssql ="";
		 		
		 		if(!"0".equals(divis))
		 			ssql = " AND  a.INT_DIVIID="+divis+"  ";
		 		
		 		
		 		if(!"0".equals(vendorid))
		 			ssql = " AND  a.INT_VENDORID="+vendorid+"  ";
		 		
		 		
		 		String sssql ="";
		 		if("1".equals(Status))
		 			sssql = " AND  a.CHR_PAYMENTSTATUS='N'   ";
		 		else if("2".equals(Status))
		 			sssql = " AND  a.CHR_PAYMENTSTATUS='Y'   ";
		 		else if("0".equals(Status))
		 			sssql = " ";
		 		
		 		if("Purchase".equals(payment))
		 		{
			 		sql=" SELECT a.CHR_PURCHASEORDERNO  , " +
			 			" a.INT_VENDORID,a.DOU_TOTALAMOUNT , " +
			 			" a.DOU_PAIDAMOUNT,(a.DOU_TOTALAMOUNT-a.DOU_PAIDAMOUNT), a.CHR_PAYMENTSTATUS  " +
			 			"  FROM  inv_t_vendorpurchaseorder  a " ;
			 		sql = sql +" WHERE  a.CHR_PURCHASEORDERNO <> 'null' " ;
			 		sql = sql +ssql+sssql;
			 		sql = sql +" ORDER BY a.DAT_ORDERDATE";
			 		
		 		}
		 		else if("Direct".equals(payment))
		 		{
			 		
			 		sql =" SELECT a.CHR_PURCHASEORDERNO  ,b.CHR_VENDORNAME ,a.DOU_TOTALAMOUNT ,  a.DOU_PAIDAMOUNT, ";
			 		sql = sql +"  (a.DOU_TOTALAMOUNT-a.DOU_PAIDAMOUNT),a.CHR_PAYMENTSTATUS FROM inv_t_directpurchase  a, inv_m_vendorsinformation  b ";
			 		sql = sql +" WHERE a.INT_VENDORID=b.INT_VENDORID "+ssql+sssql;
			 		sql = sql +" ORDER BY a.DAT_ORDERDATE ";
			 		
		 		}
		 		
		 		 
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		String StartLetter = ""+request.getParameter("id");
		 		if(readData.length>0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 				if(readData[u][0].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter))
		 				{
		 					sb.append("<Payment>");
		 					sb.append("<Purchaseid>" + readData[u][0].replace("&", " AND ")+  "</Purchaseid>");
		 					sb.append("<Vendorname>" + readData[u][1].replace("&", " AND ") +"</Vendorname>");
		 					sb.append("<Totalamount>" + readData[u][2]+ "</Totalamount>");
		 					sb.append("<Paidamount>" + readData[u][3]+ "</Paidamount>");  
		 					sb.append("<Blanace>" +readData[u][4] + "</Blanace>");
		 					sb.append("<Status>" +  readData[u][5]+"</Status>");
		 					sb.append("</Payment>");	
		 				}	
		 			}
		 			
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
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
	//	End - Author :: Kalaiselvan----------------------Payment-----------------------
	 
	
	
	
	
	
	
	
	
	/*	
	 *	Start - Author :: Kalaiselvan----------------------Received Id-----------------------
	 * 	Date: 22/01/2006
	 *  
	*/
	public static void loadReceivedId(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 
		 		String rid=request.getParameter("rid");
		 		String sql="SELECT CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_RECIVEDID ='"+rid+"'";
		 		String pid = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_PURCHASEORDERNO");
		 		sql="SELECT INT_ID,CHR_ITEMID,CHR_SERIALNO ,CHR_WARRANTY, CHR_GRTFLAG,DAT_RECIVEDDATE, CHR_TYPE FROM inv_t_vendorgoodsreceived" +
		 				" WHERE CHR_PURCHASEORDERNO = '"+pid+"' AND CHR_RECIVEDID ='"+rid+"' AND CHR_FLAG='N' ";
		 		 
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		String itemname="";
		 		String itype="";
		 		String type="";
		 		if(readData.length>0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 				itemname ="";
		 				itype = readData[u][6];
		 				if(itype.equals("I"))
						{
							sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+readData[u][1]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							type = "Item";
						}
						if(itype.equals("P"))
						{
							sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+readData[u][1]+"'";
							itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							type = "Product";
						}
		 				
		 				sb.append("<Rid>");
		 				sb.append("<Refid>" + readData[u][0]+ "</Refid>"); 
		 				sb.append("<Reddate>" + readData[u][5]+ "</Reddate>");
		 				sb.append("<Itemname>" + itemname+ "</Itemname>");
		 				sb.append("<Itemtype>" + type+ "</Itemtype>");
		 				sb.append("<Srial>" +readData[u][2] + "</Srial>");
		 				sb.append("<Warranty>" +readData[u][3] + "</Warranty>");  
		 				sb.append("<Flag>" +readData[u][4] + "</Flag>");
		 				sb.append("</Rid>");
	     			}
		 			//System.out.println(sb);
	     			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<RcdIds>" + sb.toString() + "</RcdIds>");
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
	 
	
	public static void loadSalesPaymentBalance(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	HttpSession session=request.getSession();
    		 	String rid=request.getParameter("salesid");
    		 	String branchId=""+session.getAttribute("BRANCHID");
		 		String sql="SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_customersalespayment   WHERE CHR_SALESORDERNO='"+rid+"' AND INT_BRANCHID ="+branchId;
		 		String amounts[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		double amt =0.0;
		 		if(amounts.length>0)
		 		{	
		 			
		 			sql ="SELECT  b.CHR_CUSTOMERNAME FROM inv_t_directsales a ,inv_m_customerinfo b WHERE a.CHR_SALESNO='"+rid+"'	AND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
		 			String cdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 			sb.append("<Amount>");
		 			if(!"-".equals(amounts[0][0]))
		 				amt =Double.parseDouble(amounts[0][0]);
		 			sb.append("<Balance>" +amt + "</Balance>");
		 			sb.append("<Customer>" +cdata[0][0] + "</Customer>");
		 			sb.append("</Amount>");
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Amounts>" + sb.toString() + "</Amounts>");
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
	
	
	
	
	public static void loadDirectBillingValue(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 
    		 	String invno=request.getParameter("invno");
    		 	String Branch = request.getParameter("Branch");
    		 	String sql="";
    		 	sql =" SELECT  a.CHR_SALESNO,a.DOU_NETAMOUNT,b.CHR_CUSTOMERNAME ,";
    		 	sql = sql +" (SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_directbillingpayment   WHERE CHR_SALESNO='"+invno+"' AND INT_BRANCHID ="+Branch+")";
    		 	sql = sql +" ,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_directbilling a ,inv_m_customerinfo b " ;
    		 	sql = sql +" where a.INT_CUSTOMERID = b.INT_CUSTOMERID";  
    		 	sql = sql +" AND a.CHR_SALESNO='"+invno+"'";	
    		 	sql = sql +" AND a.INT_BRANCHID="+Branch;
    		 	//System.out.println(sql);
    		 	String amounts[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		double amt =0.0;
		 		double paid=0.0;
		 		if(amounts.length>0)
		 		{	
		 			sb.append("<Amount>");
		 			if(!"-".equals(amounts[0][1]))
		 				amt =Double.parseDouble(amounts[0][1]);
		 			if(!"-".equals(amounts[0][3]))
		 				paid =Double.parseDouble(amounts[0][3]);
		 			sb.append("<Invoiceamount>" +amounts[0][1] + "</Invoiceamount>");
		 			sb.append("<Paid>" +paid + "</Paid>");
		 			sb.append("<Balance>" +(amt-paid) + "</Balance>");
		 			sb.append("<Customer>" +amounts[0][2] + "</Customer>");
		 			sb.append("<Invoicedate>" +amounts[0][4] + "</Invoicedate>");
		 			sb.append("</Amount>");
		 			
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Amounts>" + sb.toString() + "</Amounts>");
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
	

	public static void loadServiceBillingValue(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 
    		 	String invno=request.getParameter("invno");
    		 	String Branch = request.getParameter("Branch");
    		 	String sql="";
    		 	sql =" SELECT  a.CHR_SALESNO,a.DOU_NETAMOUNT,b.CHR_CUSTOMERNAME ,";
    		 	sql = sql +" (SELECT SUM(DOU_PAIDAMOUNT) FROM   inv_t_servicebillingpayment   WHERE CHR_SALESNO='"+invno+"' AND INT_BRANCHID ="+Branch+")";
    		 	sql = sql +" ,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_servicebilling a ,inv_m_customerinfo b " ;
    		 	sql = sql +" where a.INT_CUSTOMERID = b.INT_CUSTOMERID";  
    		 	sql = sql +" AND a.CHR_SALESNO='"+invno+"'";	
    		 	sql = sql +" AND a.INT_BRANCHID="+Branch;
    		 	String amounts[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		double amt =0.0;
		 		double paid=0.0;
		 		if(amounts.length>0)
		 		{	
		 			sb.append("<Amount>");
		 			if(!"-".equals(amounts[0][1]))
		 				amt =Double.parseDouble(amounts[0][1]);
		 			if(!"-".equals(amounts[0][3]))
		 				paid =Double.parseDouble(amounts[0][3]);
		 			
		 			sb.append("<Invoiceamount>" +amounts[0][1] + "</Invoiceamount>");
		 			sb.append("<Paid>" +paid + "</Paid>");
		 			sb.append("<Balance>" +(amt-paid) + "</Balance>");
		 			sb.append("<Customer>" +amounts[0][2].replace("&", "") + "</Customer>");
		 			sb.append("<Invoicedate>" +amounts[0][4] + "</Invoicedate>");
		 			sb.append("</Amount>");
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Amounts>" + sb.toString() + "</Amounts>");
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
	
	public static void loadTaxcalculations(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 
    		 	String id=request.getParameter("id");
    		 	String sql="";
    		 	sql =" SELECT  DOU_VALUE FROM inv_m_tax WHERE INT_TAXID="+id;
    		 	String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if(datas.length>0)
		 		{	
		 			sb.append("<Tax>");
		 			sb.append("<Taxvalue>" +datas[0][0] + "</Taxvalue>");
		 			sb.append("</Tax>");
		 			System.out.println(sb.toString());
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Taxs>" + sb.toString() + "</Taxs>");
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
	
	
	public static void loadServiceBillingPayment(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 
    		 	String Branch = request.getParameter("Branch");
    		 	String StartLetter = request.getParameter("id");
    		 	String division = request.getParameter("division");
    		 	String Payment = request.getParameter("Payment");
    		 	String customer = request.getParameter("customer");
    		 	String sql="";
    		 	
    		 	sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_CUSTOMERNAME,a.CHR_REF , a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ";
		 		sql = sql + " FROM inv_t_servicebilling a, inv_m_customerinfo b ,com_m_staff c";
		 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		if(!"0".equals(customer))
		 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		
		 		if("1".equals(Payment))
		 			sql= sql+" AND a.CHR_PAYMENTSTATUS='N'";
		 		else if("2".equals(Payment))
		 			sql= sql+" AND a.CHR_PAYMENTSTATUS='Y'";
		 		else if("3".equals(Payment))
		 			sql= sql+" AND a.CHR_PAYMENTSTATUS='P'";
		 		
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
		 		sql = sql +" ORDER  BY a.CHR_SALESNO";
		 		
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Direct>");
	 					sb.append("<Invoiceno>"+readData[u][0]+"</Invoiceno>");
	 					sb.append("<Date>"+readData[u][1]+"</Date>");
	 					sb.append("<Customer>"+readData[u][2].replace("&", "")+"</Customer>");
	 					sb.append("<Ref>"+readData[u][6]+"</Ref>");
	 					sb.append("<Amount>"+readData[u][4]+"</Amount>");
	 					sb.append("<Status>"+readData[u][5]+"</Status>");
	 					sb.append("</Direct>");
	 					
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Directs>" + sb.toString() + "</Directs>");
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

	

	public static void loadDirectBillingPayment(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	 
    		 	String Branch = request.getParameter("Branch");
    		 	String StartLetter = request.getParameter("id");
    		 	String division = request.getParameter("division");
    		 	String Payment = request.getParameter("Payment");
    		 	String customer = request.getParameter("customer");
    		 	String sql="";
    		 	
    		 	sql = " SELECT a.CHR_SALESNO ,date_format(a.DAT_SALESDATE,'%d-%b-%Y'),b.CHR_CUSTOMERNAME,a.CHR_REF , a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS,c.CHR_STAFFNAME ";
		 		sql = sql + " FROM inv_t_directbilling a, inv_m_customerinfo b ,com_m_staff c";
		 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND c.CHR_EMPID = a.CHR_REF ";
		 		sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
		 		if(!"0".equals(customer))
		 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
		 		if(!"0".equals(division))
		 			sql= sql+" AND a.INT_DIVIID="+ division;
		 		
		 		if("1".equals(Payment))
		 			sql= sql+" AND a.CHR_PAYMENTSTATUS='N'";
		 		else if("2".equals(Payment))
		 			sql= sql+" AND a.CHR_PAYMENTSTATUS='Y'";
		 		else if("3".equals(Payment))
		 			sql= sql+" AND a.CHR_PAYMENTSTATUS='P'";
		 		
		 		if(!"0".equals(StartLetter))
		 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
		 		sql = sql +" ORDER  BY a.CHR_SALESNO";
		 		
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
	 	 				sb.append("<Direct>");
	 					sb.append("<Invoiceno>"+readData[u][0]+"</Invoiceno>");
	 					sb.append("<Date>"+readData[u][1]+"</Date>");
	 					sb.append("<Customer>"+readData[u][2]+"</Customer>");
	 					sb.append("<Ref>"+readData[u][6]+"</Ref>");
	 					sb.append("<Amount>"+readData[u][4]+"</Amount>");
	 					sb.append("<Status>"+readData[u][5]+"</Status>");
	 					sb.append("</Direct>");
	 					
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Directs>" + sb.toString() + "</Directs>");
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
	 
	public static void loadQuotation(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	HttpSession session=request.getSession();
    		 	String branchid=""+session.getAttribute("BRANCHID");
    		 
    		 	String month=request.getParameter("month");
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		String sql=" SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,b.CHR_CUSTOMERNAME,a.DAT_QUOTATIONDATE,";
		 		sql = sql +" a.DAT_REQUESTDATE , a.INT_ONHOLD,a.INT_CONDITIONID,a.CHR_DES,a.DOU_TOTALAMOUNT,a.INT_QUOTATIONSTATUS"; 
		 		sql = sql +" FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
		 		sql = sql +" where a.DAT_QUOTATIONDATE>='"+fDate+"' ";
		 		sql = sql +" AND a.DAT_QUOTATIONDATE<='"+tDate+"'  ";
		 		sql = sql +" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID";
		 		sql = sql +" AND a.INT_BRANCHID="+branchid+" order by a.DAT_QUOTATIONDATE";
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		String StartLetter = ""+request.getParameter("id");
		 		if(readData.length>0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 				if(readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter))
		 				{
		 					sb.append("<quotation>");
		 				    sb.append("<id>" + readData[u][0]+ "</id>");
		 	                sb.append("<quotationNo>" + readData[u][1]+ "</quotationNo>");
		 	                if(!readData[u][3].equals("-"))
		 	                	sb.append("<quotationDate>" + DateUtil.FormateDateSys(readData[u][3])+ "</quotationDate>");
		 	                else
		 	                	sb.append("<quotationDate>" + readData[u][3]+ "</quotationDate>");
		 	                
		 	                sb.append("<customerName>" + readData[u][2]+ "</customerName>");
		 	               
		 	                if(!readData[u][4].equals("-"))
		 	                	sb.append("<reqDate>" + DateUtil.FormateDateSys(readData[u][4])+ "</reqDate>");
		 	                else
		 	                	sb.append("<reqDate>" + readData[u][4]+ "</reqDate>");
		 	                sb.append("<onHold>" + readData[u][5]+ "</onHold>");
		 	                sb.append("<quotationStatus>" + readData[u][9] + "</quotationStatus>");
		 	                sb.append("<credit>" + readData[u][7]+ "</credit>");
		 	                sb.append("<totalAmount>" +readData[u][8]+ "</totalAmount>");                
		 	                sb.append("</quotation>");	
 		 				}	
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");		 			
		 			response.getWriter().write("<quotations>" + sb.toString() + "</quotations>");
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
	 
	public static void PurchaseIdCheck(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		String username=request.getParameter("userName");
		 	String sql = " SELECT count(*) FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO='"+username+"'";
		 	boolean flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
		 	StringBuffer sb = new StringBuffer(); 
 	     	sb.append("<Username>");    	     		
 	     	sb.append("<Status>"+flag+"</Status>");
 	     	sb.append("</Username>");
 	     	response.setContentType("text/xml");
 	     	response.setHeader("Cache-Control", "no-cache");
 	     	response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
 	     	 	
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
    	 } 
    }	
	 
	public static void QuotationIdCheck(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		String quoNumber=request.getParameter("quoNumber");
		 	String sql = " SELECT count(*) FROM  inv_t_customerquotation  WHERE CHR_QUOTATIONNO='"+quoNumber+"'";
		 	boolean flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
		 	StringBuffer sb = new StringBuffer(); 
 	     	sb.append("<Username>");    	     		
 	     	sb.append("<Status>"+flag+"</Status>");
 	     	sb.append("</Username>");
 	     	response.setContentType("text/xml");
 	     	response.setHeader("Cache-Control", "no-cache");
 	     	response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
 	     	 	
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
    	 } 
    }	
	
	
	public static void CheckUnique(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		boolean flag=false;
    		String quoNumber=""+request.getParameter("quoNumber");
    		quoNumber=quoNumber.trim();
    		if(!quoNumber.equals("null") && !quoNumber.equals("")){
	    		String fieldName=request.getParameter("fieldName");
	    		String tableName=request.getParameter("tableName");
			 	String sql = " SELECT count(*) FROM "+tableName+" WHERE "+fieldName+"='"+quoNumber+"'";
			 	flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
    		}
		 	StringBuffer sb = new StringBuffer();    		
 	     	sb.append("<Username>");    	     		
 	     	sb.append("<Status>"+flag+"</Status>");
 	     	sb.append("</Username>");
 	     	response.setContentType("text/xml");
 	     	response.setHeader("Cache-Control", "no-cache");
 	     	response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
    	 } 
    }	
	
	
	
	
	 public static void loadSalesOrder(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 
	    		
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 String month=request.getParameter("month");
	    	     int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,b.CHR_CUSTOMERNAME,a.DAT_QUOTATIONDATE,a.INT_QUOTATIONSTATUS"; 
	    	     sql = sql +" FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
	    	     sql = sql +" where a.DAT_QUOTATIONDATE>='"+fDate+"' ";
	    	     sql = sql +" AND a.DAT_QUOTATIONDATE<='"+tDate+"'  ";
	    	     sql = sql +" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID";
	    	     sql = sql +" order by a.INT_QUOTATIONID";
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {	    	     
			 				sb.append("<SalesOrder>");
		     				sb.append("<quoId>" + readData[u][0] +"</quoId>");
		     				sb.append("<quoNo>" + readData[u][1] +"</quoNo>");
		     				if(!readData[u][3].equals("-"))
		     					sb.append("<quoDate>" + DateUtil.FormateDateSys(readData[u][3])+ "</quoDate>");
		     				else
		     					sb.append("<quoDate>" +readData[u][3]+ "</quoDate>");
		     				sb.append("<quoStatus>" + readData[u][4]+ "</quoStatus>");	
		     				sb.append("<quoCust>" + readData[u][2]+ "</quoCust>");
		     				sql="SELECT CHR_SALESORDERNO,DAT_SALEDATE,CHR_DELIVERYSTATUS FROM  inv_t_customersalesorder   " +
		     				"WHERE CHR_QUOTATIONNO= '"+readData[u][1]+"'";
		                	String salesOrder[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		                	if(salesOrder.length>0)
		                	{
		                		sb.append("<salNo>" + salesOrder[0][0]+ "</salNo>");
			     				sb.append("<salDate>" + salesOrder[0][1]+ "</salDate>");
			     				sb.append("<salStatus>" + salesOrder[0][2]+ "</salStatus>");
		                	}
		                	else
		                	{	
		                		sb.append("<salNo>-</salNo>");
		                		sb.append("<salDate>-</salDate>");
		                		sb.append("<salStatus>-</salStatus>");
		                	}
		                	sb.append("</SalesOrder>");	
			    	     }
		     		}
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<SalesOrders>" + sb.toString() + "</SalesOrders>");
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
	 
	 public static  void loadDelData(HttpServletRequest request, HttpServletResponse response) 
		{
		 try 
		  	{
			 		
		    		
		    		String txtSer=""+request.getParameter("txtSer");
		    		if(txtSer.equals("null")) txtSer="";
		    	     	String month=request.getParameter("month");
		    	    int year=Integer.parseInt(request.getParameter("year"));    	     
		    	    int mon=Integer.parseInt(month);    	     
		    	    String fDate=year+"-"+month+"-01";
		    	    String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		    	    String sql ="SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,b.CHR_CUSTOMERNAME,";
		    	    sql = sql +" a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
		    	    sql = sql +" where a.DAT_SALEDATE>='"+fDate+"' ";
		    	    sql = sql+" AND a.DAT_SALEDATE<='"+tDate+"' ";
		    	    sql = sql+" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
		    	    String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		    	    StringBuffer sb = new StringBuffer();
		            if(readData.length >0)
				 	{
				 		 for(int u=0; u<readData.length;u++)
				 		 {
				 			  String query = "select CHR_SALESORDERNO,CHR_DELIVERYNO,DT_DELIVERYDATE from  inv_t_customersalesorderitemserial   WHERE CHR_SALESORDERNO='"+readData[u][2]+"' AND  CHR_DELIVERYNO is not null GROUP by CHR_DELIVERYNO" ;
					    	  @SuppressWarnings("unused")
							String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);			  
					    	  if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
				    	     {	    	     
				 				sb.append("<Delivery>");
			     				sb.append("<Qno>" + readData[u][0] +"</Qno>");
			     				sb.append("<Custpurchaseno>" + readData[u][1] +"</Custpurchaseno>");
			     				sb.append("<Saleno>" + readData[u][2]+ "</Saleno>");
			     				sb.append("<Saleby>" + readData[u][3]+ "</Saleby>"); 				
			     	           	sb.append("<Saledate>" + readData[u][4]+ "</Saledate>");
			                	sb.append("<Custname>" + readData[u][5]+ "</Custname>");
				     			sb.append("<Status>" + readData[u][6]+ "</Status>");
				     			sb.append("<Did>" + readData[0][1]+ "</Did>");
				     			sb.append("</Delivery>");	
				    	     }
			     		}	
				 		response.setContentType("text/xml");
		 	     		response.setHeader("Cache-Control", "no-cache");
		 	     		response.getWriter().write("<Deliverys>" + sb.toString() + "</Deliverys>");
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
	
	 
	 
	 
	public static  void loadDelivaryData(HttpServletRequest request, HttpServletResponse response) 
	{
	 try 
	  	{
		 
		 		
	    		
	    		String txtSer=""+request.getParameter("txtSer");
	    		if(txtSer.equals("null")) txtSer="";
	    	     	String month=request.getParameter("month");
	    	    int year=Integer.parseInt(request.getParameter("year"));    	     
	    	    int mon=Integer.parseInt(month);    	     
	    	    String fDate=year+"-"+month+"-01";
	    	    String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	    String sql ="SELECT a.CHR_QUOTATIONNO,a.CHR_CUSTPURCHASENO ,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,b.CHR_CUSTOMERNAME,";
	    	    sql = sql +" a.CHR_DELIVERYSTATUS  FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
	    	    sql = sql +" where a.DAT_SALEDATE>='"+fDate+"' ";
	    	    sql = sql+" AND a.DAT_SALEDATE<='"+tDate+"' ";
	    	    sql = sql+" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID  order by a.DAT_SALEDATE";
	    	    String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	    StringBuffer sb = new StringBuffer();
	            if(readData.length >0)
			 	{
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {	    	     
			 				sb.append("<Delivery>");
		     				sb.append("<Qno>" + readData[u][0] +"</Qno>");
		     				sb.append("<Custpurchaseno>" + readData[u][1] +"</Custpurchaseno>");
		     				sb.append("<Saleno>" + readData[u][2]+ "</Saleno>");
		     				sb.append("<Saleby>" + readData[u][3]+ "</Saleby>"); 				
		     	           	sb.append("<Saledate>" + readData[u][4]+ "</Saledate>");
		                	sb.append("<Custname>" + readData[u][5]+ "</Custname>");
			     			sb.append("<Status>" + readData[u][6]+ "</Status>");
			     			sb.append("</Delivery>");	
			    	     }
		     		}	
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<Deliverys>" + sb.toString() + "</Deliverys>");
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

	    public static  void loadInvoiceData(HttpServletRequest request, HttpServletResponse response) 
	    {
	    	try 
	    		{
	    		 
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 String month=request.getParameter("month");
	    	     int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String sql=" SELECT  a.CHR_QUOTATIONNO,a.CHR_INVOICENO,a.DT_INVOICEDATE,a.CHR_SALESORDERNO,";
	    	     sql = sql + " b.CHR_CUSTOMERNAME ,a.CHR_INVOICESTATUS ";
	    	     sql = sql + " FROM  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
	    	     sql = sql + " where a.DAT_SALEDATE>='"+fDate+"'  ";
	    	     sql = sql + " AND a.DAT_SALEDATE<='"+tDate+"' ";
	    	     sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
	    	     sql = sql + "  and CHR_DELIVERYSTATUS='Y' order by a.DAT_SALEDATE ";
	    	     String readData[][] = com.my.org.erp.common.CommonInfo.KRecordSetArray(sql);
	             StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
	                	if(readData[u][0].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {
			 				sb.append("<Invoice>");
			 				sb.append("<Quotationid>" + readData[u][0]+ "</Quotationid>");
			 				sb.append("<Invnumber>" + readData[u][1]+ "</Invnumber>");
			     			sb.append("<Invdate>" +readData[u][2]+ "</Invdate>");
			     			sb.append("<SalesOrderNo>" +readData[u][3]+ "</SalesOrderNo>");
			     			sb.append("<Customername>" + readData[u][4]+ "</Customername>");
			     			sb.append("<Invstatus>" + readData[u][5]+ "</Invstatus>");
		                	sb.append("</Invoice>");	
			    	     }
		     		}
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<invoices>" + sb.toString() + "</invoices>");
	 	     	} 
	 	     	else 
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	    	 	} 
	    	 	catch (Exception e) 
	    	 	{
				 
				 System.out.println(e.getMessage());
	    	 	} 
		}
	    
	    
	    
	    
	    public static  void loadCashSale(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 if(txtSer.equals("null")) txtSer="";
	    	     String month=request.getParameter("month");
	    	     int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String sql="SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE" +
	    	     		" ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS FROM inv_t_cashsales " +
	    	     		" where DAT_SALESDATE>='"+fDate+"' AND DAT_SALESDATE<='"+tDate+"' " +	    	     		
	    	     		" order by DAT_SALESDATE";
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	             StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 if(readData[u][2].toUpperCase().startsWith(txtSer.toUpperCase()) || "0".equals(txtSer))
			    	     {	    	     
			 				sb.append("<cashSale>");
		     				sb.append("<salId>" + readData[u][0] +"</salId>");
		     				sb.append("<salNo>" + readData[u][1] +"</salNo>");
		     				sb.append("<salDate>" + readData[u][3]+ "</salDate>");
		     				sb.append("<salTotal>" + readData[u][4]+ "</salTotal>");
		     				if(!readData[u][2].equals("-"))
		     				{
		     					String csql="Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID="+readData[u][2];
		     					String custName=CommonInfo.stringGetAnySelectField(csql,"CHR_CUSTOMERNAME");
		     					sb.append("<quoCust>" +custName + "</quoCust>");
		     				}
		     				else
		     					sb.append("<quoCust>-</quoCust>");
		                	sb.append("</cashSale>");
			    	     }
		     		}	
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<cashSales>" + sb.toString() + "</cashSales>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} catch (Exception e) {
				
			} 
	    }
	    
	    
	    
	    
	    public  static void loadDirectSale(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 txtSer = txtSer.toUpperCase();
	    		 String month=request.getParameter("month");
	    	     int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String sql="SELECT INT_SALESID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE" +
	    	     		" ,DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS,INT_SALESSTATUS FROM inv_t_directsales " +
	    	     		" where CHR_SALESTYPE='D' AND DAT_SALESDATE>='"+fDate+"' AND DAT_SALESDATE<='"+tDate+"' " ;
	    	     if( ! "0".equals(txtSer))
	    	    	 sql = sql +" AND CHR_SALESNO LIKE '"+txtSer+"%'";
	    	     sql = sql+ "  order by DAT_SALESDATE";
	    	     String readData[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	             StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directSale>");
		     				sb.append("<salId>" + readData[u][0] +"</salId>");
		     				sb.append("<salNo>" + readData[u][1] +"</salNo>");
		     				sb.append("<salDate>" + readData[u][3]+ "</salDate>");
		     				sb.append("<salTotal>" + readData[u][4]+ "</salTotal>");
		     				String csql="Select CHR_CUSTOMERNAME from  inv_m_customerinfo where INT_CUSTOMERID="+readData[u][2];
		     				String custName=CommonInfo.stringGetAnySelectField(csql,"CHR_CUSTOMERNAME");
		                	sb.append("<quoCust>" + custName+ "</quoCust>"); 
		                	sb.append("<Status>" + readData[u][6]+ "</Status>");
		                	sb.append("<PStatus>" + readData[u][5]+ "</PStatus>");
		                	sb.append("</directSale>");
			 		 }
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
	    
	   
	    public  static void loadDSwapSale(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 HttpSession session=request.getSession();
	    		 String branchid=""+session.getAttribute("BRANCHID");
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 txtSer = txtSer.toUpperCase();
	    		 String month=request.getParameter("month");
	    		 String customer=""+request.getParameter("customer");
	    		 String division=""+request.getParameter("division");
	    		 int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     String fDate=year+"-"+month+"-01";
	    	     String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
	    	     String admin =""+session.getAttribute("USRTYPE");
	    	      
	    		 String query="";
	    		 query = " SELECT a.INT_SALESID,a.CHR_SALESNO,b.CHR_CUSTOMERNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%m-%Y') ,a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS,a.INT_SALESSTATUS,(SELECT   count(*) FROM inv_t_paymentcommitment d WHERE   d.CHR_SALESNO =a.CHR_SALESNO  AND d.CHR_STATUS='N' GROUP BY  d.CHR_SALESNO ),a.DOU_TOTALAMOUNT,  (SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME)  FROM inv_t_directsales  a ,inv_m_customerinfo b   ,inv_t_paymentcommitment c";
	    		 query = query+" where a.CHR_SALESNO =c.CHR_SALESNO  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_SALESTYPE='S'  ";
	    		 query = query+" AND a.INT_BRANCHID = "+branchid+"  ";
	    		 query = query+" AND a.DAT_SALESDATE>='"+fDate+"'  ";
	    		 query = query+" AND a.DAT_SALESDATE<='"+tDate+"' ";
	    		 if(!"0".equals(customer))
	    			 query = query+"  AND a.INT_CUSTOMERID = "+customer;
	    		 if(!"0".equals(division))
	    			 query = query+"  AND a.INT_DIVIID = "+division;
	    		 if( ! "0".equals(txtSer))
	    			 query = query+" AND CHR_SALESNO LIKE '"+txtSer+"%'";
	    		 query = query+"   GROUP BY a.CHR_SALESNO order by CHR_SALESNO, DAT_SALESDATE"; 
	    		  
	    		 
	    		 
	    		  
	    		 
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(query);
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directSale>");
		     				sb.append("<salId>" + readData[u][0] +"</salId>");
		     				sb.append("<salNo>" + readData[u][1] +"</salNo>");
		     				sb.append("<salDate>" + readData[u][3]+ "</salDate>");
		     				sb.append("<salTotal>" + readData[u][4]+ "</salTotal>");
		     				sb.append("<quoCust>" + readData[u][2].replace("&", "9865043008")+ "</quoCust>"); 
		                	sb.append("<Status>" + readData[u][6]+ "</Status>");
		                	sb.append("<PStatus>" + readData[u][5]+ "</PStatus>");
		                	sb.append("<PayCommitment>" + readData[u][7]+ "</PayCommitment>");
		                	sb.append("<Userid>" + readData[u][9]+ "</Userid>");
		                	sb.append("<Usertype>" + admin+ "</Usertype>");
		                	sb.append("</directSale>");
			 		 }
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
	    
	    public  static void loadDACCSwapSale(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 txtSer = txtSer.toUpperCase();
	    		 String month=request.getParameter("month");
	    		 String customer=""+request.getParameter("customer");
	    		 String division=""+request.getParameter("division");
	    		 String ssql="";
	    		 String Aflag=""+request.getParameter("Aflag");
	    		 String Accbranch=""+request.getParameter("Accbranch");
	    		 String accflag="";
	    		 String Accbranchid="";
	    		 if(!"0".equals(Accbranch))
	    			 Accbranchid=" AND a.INT_BRANCHID = "+Accbranch;
	    		 
	    		 
	    		 if("0".equals(Aflag))
	    			 accflag = " AND a.CHR_ACCOUNTFLAG ='Y'";
	    		 else
	    			 accflag = " AND a.CHR_ACCOUNTFLAG ='N'";
	    		 
	    		 if("0".equals(customer))
	    			 ssql="";
	    		 else
	    			 ssql= " AND INT_CUSTOMERID = "+customer;
	    		  
	    		 if("0".equals(division))
	    			 ssql=ssql+" ";
	    		 else
	    			 ssql = ssql+" AND INT_DIVIID = "+division;
	    		 
	    		
	    		 
	    		 int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    
	    	     String sql=" SELECT a.CHR_SALESNO,b.CHR_CUSTOMERNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), a.CHR_PAYMENTSTATUS ,a.CHR_ACCOUNTFLAG ,d.CHR_BRANCHNAME,a.DOU_TOTALAMOUNT  FROM inv_t_directsales a , inv_m_customerinfo b , com_m_branch d ";
	    	     sql = sql +" where b.INT_CUSTOMERID = a.INT_CUSTOMERID AND a.INT_BRANCHID =d.INT_BRANCHID ";
	    	     sql = sql + Accbranchid;
	    	     sql = sql +ssql ;
	    	     sql = sql +accflag;
	    	     sql = sql +" AND month(a.DAT_SALESDATE) ="+mon;
	    	     sql = sql +" AND year(a.DAT_SALESDATE)="+year;
	    	     if( ! "0".equals(txtSer))
	    	    	 sql = sql +" AND CHR_SALESNO LIKE '"+txtSer+"%'";
	    	     sql = sql +" order by a.DAT_SALESDATE DESC ";
	    	      
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	             StringBuffer sb = new StringBuffer();
	             if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directSale>");
		     				sb.append("<salesno>" + readData[u][0] +"</salesno>");
		     				sb.append("<custname>" + readData[u][1].trim().replace("&", "98650")+ "</custname>");  
		     				sb.append("<saledate>" + readData[u][2]+ "</saledate>");
		     				if("Y".equalsIgnoreCase(readData[u][3]))
		     					sb.append("<PStatus>Paid</PStatus>");
		     				else
		     					sb.append("<PStatus>Pending</PStatus>");
		                	if("Y".equalsIgnoreCase(readData[u][4]))
		     					sb.append("<InvoiceStatus>Received</InvoiceStatus>");
		     				else
		     					sb.append("<InvoiceStatus>Not Received</InvoiceStatus>");
		                	sb.append("<Branch>" + readData[u][5]+ "</Branch>");
		                	sb.append("<NetAmount>" + readData[u][6]+ "</NetAmount>");
		     				sb.append("</directSale>");
		     				
			    	}
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
	    
	    
	    
	    
	    public  static void INVACCServiceBill(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 txtSer = txtSer.toUpperCase();
	    		 String month=request.getParameter("month");
	    		 String customer=""+request.getParameter("customer");
	    		 String division=""+request.getParameter("division");
	    		 String Aflag=""+request.getParameter("Aflag");
	    		 String Accbranch=""+request.getParameter("Accbranch");
	    		 
	    		 int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    
	    	     String sql=" SELECT a.CHR_SALESNO,b.CHR_CUSTOMERNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), a.CHR_PAYMENTSTATUS ,a.CHR_ACCOUNTFLAG ,d.CHR_BRANCHNAME,a.DOU_NETAMOUNT  FROM inv_t_servicebilling a , inv_m_customerinfo b , com_m_branch d ";
	    	     sql = sql +" where b.INT_CUSTOMERID = a.INT_CUSTOMERID AND a.INT_BRANCHID =d.INT_BRANCHID ";
	    	     if(!"0".equals(Accbranch))
	    	    	 sql = sql +"  AND a.INT_BRANCHID = "+Accbranch;
	    	     if("1".equals(Aflag))
	    	    	 sql = sql +"  AND a.CHR_ACCOUNTFLAG ='Y'";
	    		 else if("2".equals(Aflag))
	    			 sql = sql +"  AND a.CHR_ACCOUNTFLAG ='N'";

	    		 if(!"0".equals(customer))
	    			 sql = sql +"  AND INT_CUSTOMERID = "+customer;
	    	     
	    		 if(!"0".equals(division))
	    			 sql = sql +"   AND INT_DIVIID = "+division;
	    		 
	    		 sql = sql +" AND month(a.DAT_SALESDATE) ="+mon;
	    	     sql = sql +" AND year(a.DAT_SALESDATE)="+year;
	    	     if( ! "0".equals(txtSer))
	    	    	 sql = sql +" AND CHR_SALESNO LIKE '"+txtSer+"%'";
	    	     sql = sql +" order by a.DAT_SALESDATE DESC ";
	    	     // System.out.println(sql);
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	             StringBuffer sb = new StringBuffer();
	             if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directSale>");
		     				sb.append("<salesno>" + readData[u][0] +"</salesno>");
		     				sb.append("<custname>" + readData[u][1].trim().replace("&", "98650")+ "</custname>");  
		     				sb.append("<saledate>" + readData[u][2]+ "</saledate>");
		     				if("Y".equalsIgnoreCase(readData[u][3]))
		     					sb.append("<PStatus>Paid</PStatus>");
		     				else
		     					sb.append("<PStatus>Pending</PStatus>");
		                	if("Y".equalsIgnoreCase(readData[u][4]))
		     					sb.append("<InvoiceStatus>Received</InvoiceStatus>");
		     				else
		     					sb.append("<InvoiceStatus>Not Received</InvoiceStatus>");
		                	sb.append("<Branch>" + readData[u][5]+ "</Branch>");
		                	sb.append("<NetAmount>" + readData[u][6]+ "</NetAmount>");
		     				sb.append("</directSale>");
		     				
			    	}
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
	    
	    
	    
	    
	    public  static void loadDirectPurchase(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
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
	    		 
	    		 int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     String sql = " SELECT a.INT_PURCHASEORDERID,a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') , ";
	    	     sql = sql +" a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS ,a.CHR_FLAG,a.CHR_SALEFLAG,a.DOU_TOTALAMOUNT FROM inv_t_directpurchase  a, inv_m_vendorsinformation  b ";
	    	     sql = sql +" where   a.INT_VENDORID=b.INT_VENDORID ";
	    	     sql = sql +" AND a.INT_BRANCHID ="+branchId+ " "+ssql;
	    	     
	    	     if(!"0".equals(month))
	    	    	 sql = sql +" AND month(a.DAT_ORDERDATE) = "+month;
	    	    
	    	     
	    	     sql = sql +" AND year(a.DAT_ORDERDATE)=   "+year;
	    	     if(!"0".equals(division))
	    	    	 sql = sql +" AND a.INT_DIVIID = "+division;
	    	     
	    	     if(!"0".equals(vendor))
	    	    	 sql = sql +"  AND a.INT_VENDORID = "+vendor;
	    	     if( ! "0".equals(txtSer))
	    	    	 sql = sql +" AND CHR_PURCHASEORDERNO LIKE '"+txtSer+"%'";
	    	     sql = sql +" order by a.CHR_PURCHASEORDERNO,a.DAT_ORDERDATE ";
	    	     // System.out.println(sql);
	    	     String readData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
	    
	    
	    
	    public  static void loadACCDirectPurchase(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 
	    		 
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 String month=request.getParameter("month");
	    		 String vendor=""+request.getParameter("vendor");
	    		 String division=""+request.getParameter("division");
	    		 String Aflag=""+request.getParameter("Aflag");
	    		 String Accbranch=""+request.getParameter("Accbranch");
	    		 
	    		 String accflag="";
	    		 String Accbranchid="";
	    		 if(!"0".equals(Accbranch))
	    			 Accbranchid=" AND a.INT_BRANCHID = "+Accbranch;
	    		 
	    		 if("0".equals(Aflag))
	    			 accflag = " AND a.CHR_ACCOUNTFLAG ='Y'";
	    		 else
	    			 accflag = " AND a.CHR_ACCOUNTFLAG ='N'";
	    		 
	    		 String ssql="";
	    		 if("0".equals(division))
	    			 ssql=ssql+" ";
	    		 else
	    			 ssql = ssql+" AND a.INT_DIVIID = "+division;
	    		 
	    		 if("0".equals(vendor))
	    			 ssql = ssql+" "  ;
	    		 else
	    			 ssql = ssql+"  AND a.INT_VENDORID = "+vendor;
	    		 
	    		 //if(!"F".equals(admin))
	    		 	// ssql = ssql+" AND CHR_USRNAME='"+userid+"'";
	    		 int year=Integer.parseInt(request.getParameter("year"));    	     
	    	     int mon=Integer.parseInt(month);    	     
	    	     
	    		 String sql = " SELECT  a.CHR_PURCHASEORDERNO,CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),  a.CHR_PAYMENTSTATUS  ,a.CHR_ACCOUNTFLAG,d.CHR_BRANCHNAME,a.IMG_INVOICE,a.DOU_TOTALAMOUNT FROM inv_t_directpurchase a ,  inv_m_vendorsinformation  b , com_m_branch d";
	    		 sql = sql +" where  a.INT_VENDORID = b.INT_VENDORID AND a.INT_BRANCHID =d.INT_BRANCHID ";
	    		 sql = sql + Accbranchid;
	    		 sql = sql + ssql;
	    		 sql = sql + accflag;
	    		 sql = sql +" AND month(a.DAT_ORDERDATE) ="+mon;
	    		 sql = sql +" AND year(a.DAT_ORDERDATE)= "+year;
	    		 if( ! "0".equals(txtSer))
	    	    	 sql = sql +" AND a.CHR_PURCHASEORDERNO LIKE '"+txtSer+"%'";
	    	     sql = sql+ "  order by a.DAT_ORDERDATE DESC";
	    	      
	    	     String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directPurchase>");
		     				sb.append("<Pono>" + readData[u][0] +"</Pono>");
		     				sb.append("<Vendor>" + readData[u][1].trim().replace("&", "98650")+ "</Vendor>");  
		     				sb.append("<Podate>" + readData[u][2]+ "</Podate>");
		     				if("Y".equalsIgnoreCase(readData[u][3]))
		     					sb.append("<PStatus>Paid</PStatus>");
		     				else
		     					sb.append("<PStatus>Pending</PStatus>");
		                	if("Y".equalsIgnoreCase(readData[u][4]))
		     					sb.append("<InvoiceStatus>Received</InvoiceStatus>");
		     				else
		     					sb.append("<InvoiceStatus>Not Received</InvoiceStatus>");
		                	sb.append("<Branch>" + readData[u][5]+ "</Branch>");
		                	sb.append("<NetAmount>" + readData[u][7]+ "</NetAmount>");
		                	sb.append("</directPurchase>");
		     				
			    	}	
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<directPurchases>" + sb.toString() + "</directPurchases>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} catch (Exception e) {
				 
				 System.out.println(e.getMessage());
			} 
	    }
	    
	    
	    
	    public  static void loadCustomerAddress(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		  
	    		 String tablename = request.getParameter("table"); 
	    		 String fieldname= request.getParameter("field"); 
	    		 String condition= request.getParameter("condition");
	    		 String type= request.getParameter("type");
	    		 String added[]= (request.getParameter("added")).split(",");
	    		 String addedstring[]= (request.getParameter("addedstring")).split(",");
	    		 String id = request.getParameter("id");
	    		 String sql ="";
	    		 if("0".equals(type))
	    			 sql ="SELECT "+fieldname+" FROM "+tablename +" WHERE "+condition +" = '"+id+"'";
	    		 else
	    			 sql ="SELECT "+fieldname+" FROM "+tablename +" WHERE "+condition +" = "+id;
	    		 String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     int columcount = com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<Address>");
			 			 	String s="";
			 			 	int g=0;
		     				for(int x=0;x<columcount;x++)
		     				{
		     					if(addedstring[g].equals(""+x))
		     					{	
		     						s= s+added[g]+" : "+readData[u][x]+",";
		     						g= g+1;
		     						 
		     					}
		     					else
		     						s=s+readData[u][x]+",";
		     				}
		     				s=s.replace("?", ",");
		     				sb.append("<A>" + s +"</A>");
		     				sb.append("</Address>");
			    	}	
			 		
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<Addresss>" + sb.toString() + "</Addresss>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} catch (Exception e) {
				 
				 System.out.println(e.getMessage());
			} 
	    }
	    
	
	
	    

	    public  static void loadcheckSerial(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 String serial[] = (request.getParameter("serial")).split(","); 
	    		 String sql ="";
	    		 boolean flag = false;
	    		 String id = "";
	    		 for(int x=0;x<serial.length;x++)
	    		 {
	    			 String cserial[] = serial[x].split("~");
	    			 String serials = cserial[0];
	    			 String item = cserial[1];
	    			 String type = cserial[2];
	    			 
	    			 sql ="SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO='"+serials+"'";
	    			 sql = sql +" AND CHR_TYPE='"+type+"'  AND CHR_ITEMID = '"+item+"' AND CHR_QUALITY='Y'";
	    			 if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
	    			 {
	    			 	flag = false;
	    			 	id = serials ;
	    			 	break;
	    			 }	
	    			 flag =true;
	    		 }
	    		StringBuffer sb = new StringBuffer();
	    		 if(serial.length>0) 
	    		 {
			 		sb.append("<Serial>");
			 		sb.append("<Id>" + id +"</Id>");
			 		sb.append("<Flag>" + (""+flag).toUpperCase() +"</Flag>");
		     		sb.append("</Serial>");
			    	response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<Serials>" + sb.toString() + "</Serials>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} catch (Exception e) {
				 
				 System.out.println(e.getMessage());
			} 
	    }
	    
	
	    public  static void loadcremovedItemSerial(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 String serial[] = (request.getParameter("serial")).split(","); 
	    		 String sql ="";
	    		 boolean flag = false;
	    		 String id = "";
	    		 for(int x=0;x<serial.length;x++)
	    		 {
	    			 String serials = serial[x];
	    			 sql ="SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  WHERE CHR_FLAG = 'N' AND CHR_SERIALNO='"+serials+"'";
	    			 if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
	    			 {
	    			 	flag = false;
	    			 	id = serials ;
	    			 	break;
	    			 }	
	    			 flag =true;
	    		 }
	    		StringBuffer sb = new StringBuffer();
	    		 if(serial.length>0) 
	    		 {
			 		sb.append("<Serial>");
			 		sb.append("<Id>" + id +"</Id>");
			 		sb.append("<Flag>" + (""+flag).toUpperCase() +"</Flag>");
		     		sb.append("</Serial>");
			    	response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<Serials>" + sb.toString() + "</Serials>");
	 	     	} 
	 	     	else 
	 	     	{
	 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	     	}             
			} catch (Exception e) {
				 
				 System.out.println(e.getMessage());
			} 
	    }
	    
	    
	    /*	
		 *	Start - Author :: Kalaiselvan----------------------Sales Payment-----------------------
		 * 	Date: 21/03/2006
		 *  
		 */
		public static void loadSalesReturn(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		    HttpSession session=request.getSession();
	    		    String returnType=request.getParameter("returnType");
	    		    String branchId=""+session.getAttribute("BRANCHID");
	    		 	String month=request.getParameter("month");	    		 	
			 		int year=Integer.parseInt(request.getParameter("year"));
			 		int mon=Integer.parseInt(month);
			 		String fDate=year+"-"+month+"-01";
			 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
			 		String sql="";
			 		if("Invoice".equals(returnType))
			 		{
				 		sql= " SELECT a.CHR_SALESORDERNO,a.DAT_SALEDATE,b.CHR_CUSTOMERNAME,a.CHR_SALESORDERNO  ,c.CHR_GRTFLAG ";
				 		sql = sql + "  from  inv_t_customersalesorder   a  ,inv_m_customerinfo b , inv_t_customersalesorderitemserial c where ";
				 		sql = sql + " a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.DAT_SALEDATE>='"+fDate+"'";
				 		sql = sql + " AND a.CHR_SALESORDERNO = c.CHR_SALESORDERNO AND c.CHR_GRTFLAG ='Y' AND a.DAT_SALEDATE<='"+tDate+"' AND a.INT_BRANCHID="+branchId +" AND CHR_INVOICESTATUS='Y'  GROUP BY c.CHR_SALESORDERNO";
			 		}
			 		else if("Direct".equals(returnType))
			 		{
			 			sql= " SELECT a.CHR_SALESNO,a.DAT_SALESDATE,b.CHR_CUSTOMERNAME,a.CHR_SALESNO  ,c.CHR_GRTFLAG ";
				 		sql = sql + "  from inv_t_directsales a  ,inv_m_customerinfo b ,inv_t_swapsalesserialno c  where ";
				 		sql = sql + " a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.DAT_SALESDATE>='"+fDate+"'";
				 		sql = sql + " AND a.CHR_SALESNO = c.CHR_SALESNO AND c.CHR_GRTFLAG ='Y' AND a.DAT_SALESDATE<='"+tDate+"' AND a.INT_BRANCHID="+branchId +" AND INT_SALESSTATUS='1' GROUP BY c.CHR_SALESNO";
			 		}
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		String StartLetter = ""+request.getParameter("id");
			 		if (readData.length > 0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 				if(readData[u][0].startsWith(StartLetter) || "0".startsWith(StartLetter))
			 	 			{
			 	 				sb.append("<Return>");
			 	 				sb.append("<DCNO>"+readData[u][0]+"</DCNO>");
			 	 				sb.append("<DCdate>"+readData[u][1]+"</DCdate>");
			 	 				sb.append("<CustName>"+readData[u][2]+"</CustName>");
			 	 				if(readData[u][4].equals("Y"))
			 	 					sb.append("<ReturnStatus>true</ReturnStatus>");
			 	 				else
			 	 					sb.append("<ReturnStatus>false</ReturnStatus>");
			 	 				sb.append("<SalesNo>"+readData[u][3]+"</SalesNo>");
			 	 				sb.append("</Return>");			 	 				
			 	 			}
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Returns>" + sb.toString() + "</Returns>");
			 		}
			 		else 
			 		{
			 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			 		}			     	 	 
	    	 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
				//System.out.println(e);
	    	 } 
	    }	
		//	End - Author :: Kalaiselvan----------------------Sales Payment-----------------------
		
	
	
		
	
		  /*	
		 *	Start - Author :: Kalaiselvan----------------------Sales Payment-----------------------
		 * 	Date: 2/04/2007
		 *  
		 */
		public static void loadBranchData(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	String cpyid=request.getParameter("companyid");
			 		String sql="select * from com_m_branch where INT_COMPANYID="+cpyid +" ORDER BY INT_BRANCHID";
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
					sb.append("<Branch>");
 	 				sb.append("<Branchid>0</Branchid>");
 	 				sb.append("<Branchname>Select</Branchname>");
 	 				sb.append("</Branch>");
 	 		 		if (readData.length > 0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
			 	 				sb.append("<Branch>");
			 	 				sb.append("<Branchid>"+readData[u][0]+"</Branchid>");
			 	 				sb.append("<Branchname>"+readData[u][2]+"</Branchname>");
			 	 				sb.append("</Branch>");
			 			}	
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Branchs>" + sb.toString() + "</Branchs>");
			 		} 
			 		else 
			 		{
			 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			 		}			     	 	 
	 		 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
				//System.out.println(e);
	    	 } 
	    }	
		 

		public static void loadStockTransfer(HttpServletRequest request, HttpServletResponse response) {
			try
	    	 {
				String month=request.getParameter("month");
		 		int year=Integer.parseInt(request.getParameter("year"));
		 		int mon=Integer.parseInt(month);
		 		String fDate=year+"-"+month+"-01";
		 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
		 		
		 		String id =request.getParameter("id");
		 		String ssql="";
		 		if("0".equals(id))
		 			ssql="";
		 		else
		 			ssql = " AND CHR_STOCKTRANSFERID LIKE'"+id+"%' ";
		 		
		 		HttpSession session=request.getSession();			
				 
				String branchid = session.getAttribute("BRANCHID").toString();
				 
				String invbranchid=""+session.getAttribute("INVBRANCH"); 
		 		String sql=" SELECT INT_ID,CHR_STOCKTRANSFERID,DAT_TRANSFERDATE," +
		 		" INT_BRANCHID_FROM,INT_BRANCHID_TO,INT_STATUS ,INT_TRANSFERSTATUS" +
		 		" from inv_t_stocktransfer  where DAT_TRANSFERDATE>='"+fDate+"' and DAT_TRANSFERDATE<='"+tDate+"' " +ssql+"AND (INT_BRANCHID_TO="+Integer.parseInt(branchid)+" OR INT_BRANCHID_FROM="+Integer.parseInt(branchid)+")";
		 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		
		 		
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)		 				
		 	 		{
		 	 				sb.append("<StockTrans>");
		 	 				sb.append("<Id>"+readData[u][0]+"</Id>");		 	 				
		 	 				sb.append("<TransId>"+readData[u][1]+"</TransId>");
		 	 				if(!readData[u][2].equals("-"))
		 	 					sb.append("<TransDate>"+DateUtil.FormateDateSys(readData[u][2])+"</TransDate>");
		 	 				else
		 	 					sb.append("<TransDate>"+readData[u][2]+"</TransDate>");
		 	 				sql="SELECT CHR_BRANCHNAME from com_m_branch where INT_BRANCHID="+readData[u][3];
		 	 				String fBarnch=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
		 	 				sb.append("<FromBranch>"+fBarnch+"</FromBranch>");
		 	 				sb.append("<FromBranchid>"+readData[u][3]+"</FromBranchid>");
		 	 				sql="SELECT CHR_BRANCHNAME from com_m_branch where INT_BRANCHID="+readData[u][4];
		 	 				fBarnch=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
		 	 				sb.append("<ToBranch>"+fBarnch+"</ToBranch>");
		 	 				sb.append("<ToBranchid>"+readData[u][4]+"</ToBranchid>");
		 	 				sb.append("<invbranchid>"+invbranchid+"</invbranchid>");
		 	 				sb.append("<Status>"+readData[u][5]+"</Status>");
		 	 				sb.append("<TStatus>"+readData[u][6]+"</TStatus>");
		 	 				if(branchid.equals(readData[u][3]))
		 	 					sb.append("<TransferLink>false</TransferLink>");
		 	 				else
		 	 					sb.append("<TransferLink>true</TransferLink>");
		 	 				
		 	 				if(branchid.equals(readData[u][4]))
		 	 					sb.append("<ReceivedLink>false</ReceivedLink>");
		 	 				else
		 	 					sb.append("<ReceivedLink>true</ReceivedLink>");
		 	 				sb.append("</StockTrans>");
		 	 		}	
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");		 		
		 			response.getWriter().write("<StockTransfer>" + sb.toString() + "</StockTransfer>");
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
	
		
		
		
		
		
		
		
		
		
		

		
		
		
		public static void LoadAMCcustomerinfo(HttpServletRequest request, HttpServletResponse response) {
			try
	    	 {
				
				String serialnumber =request.getParameter("serialnumber");
				String sql = " SELECT d.CHR_SERVICEITEMNAME,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_EMAIL,a.INT_CUSTOMERID,c.CHR_CATEGORY,c.CHR_DESC ";  
				sql = sql + " FROM inv_m_servicecustomerinfo  a ,inv_m_servicecustomergroup b,inv_m_serviceamc c,inv_m_serviceitems d  ";
				sql = sql + " WHERE a.INT_GROUPID = b.INT_GROUPID  ";
				sql = sql + " AND a.INT_CUSTOMERID=c.INT_CUSTOMERID  ";
				sql = sql + " AND c.INT_SERVICEITEMID = d.INT_SERVICEITEMID  ";
				sql = sql + " AND c.CHR_SERIALNO='"+serialnumber+"' ";
		 	 
				String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)		 				
		 	 		{
		 	 				sb.append("<Customer>");
		 	 				sb.append("<Type>"+readData[u][0]+"</Type>");
		 	 				sb.append("<Group>"+readData[u][1]+"</Group>");
		 	 				sb.append("<Name>"+readData[u][2]+"</Name>");
		 	 				sb.append("<Street>"+readData[u][3]+"</Street>");
		 	 				sb.append("<City>"+readData[u][4]+"</City>");
		 	 				sb.append("<State>"+readData[u][5]+"</State>");
		 	 				sb.append("<Phone>"+readData[u][6]+"</Phone>");
		 	 				sb.append("<Mobile>"+readData[u][7]+"</Mobile>");
		 	 				sb.append("<Email>"+readData[u][8]+"</Email>");
		 	 				sb.append("<Id>"+readData[u][9]+"</Id>");
		 	 				sb.append("<Category>"+readData[u][10]+"</Category>");
		 	 				sb.append("<Descs>"+readData[u][11].replaceAll("&", " and ")+"</Descs>");
		 	 				sb.append("</Customer>");
		 	 				//Type,Group,Name,City,State,Phone,Mobile,Email
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
				 System.out.println(e.getMessage());
	    	 }			
		}

		
	
		
		public static void LoadCustomerCreditLimit(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
		    		 	String id=request.getParameter("customerid");
		    		 	String nettotal=request.getParameter("nettotal");
		    		 	double pamount=0;
		    		 	double camount=0;
		    		 	double percentage=0;
		    		 	
		    		 	String sql= " SELECT sum(a.DOU_TOTALAMOUNT),SUM(DOU_PAIDAMOUNT),(sum(a.DOU_TOTALAMOUNT)-SUM(DOU_PAIDAMOUNT)) FROM inv_t_directsales a ,inv_t_customersalespayment b ";
		    		 	sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESORDERNO ";
		    		 	sql = sql + "  AND  a.INT_CUSTOMERID= "+id;
		    		 	
		    		 	String pendingamount[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		    		 	if(pendingamount.length>0)
		    		 		if(!"-".equals(pendingamount[0][2]))
		    		 			pamount = Double.parseDouble(pendingamount[0][2]);
		    		 		else
		    		 			pamount=0;
		    		 	
		    		 	
		    		 	sql = " SELECT DOU_CREDITLIMIT FROM inv_m_customerinfo WHERE INT_CUSTOMERID="+id;
		    		 	String creditamount[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		    		 	if(creditamount.length>0)
		    		 		camount = Double.parseDouble(creditamount[0][0]);
		    		 	else
		    		 		camount=0;
		    		 	
		    		 	
		    		 	sql = " SELECT DOU_RESELLERPERCENTAGE FROM m_institution  WHERE INT_ID=1 ";
		    		 	String percentageamount[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		    		 	if(percentageamount.length>0)
		    		 		percentage = Double.parseDouble(percentageamount[0][0]);
		    		 	else
		    		 		percentage=10;
		    		 	
		    		 	percentage = (percentage/100*camount);
		    		 	camount=camount+percentage;
		    		 	double valid = Double.parseDouble(nettotal)+pamount;
		    		 	StringBuffer sb = new StringBuffer();
	    	 			sb.append("<Details>");
	 	 				if(camount>0)
	 	 				{
	 	 					if (valid > camount)
	 	 						sb.append("<Valid>False</Valid>");
	 	 					else
	 	 						sb.append("<Valid>True</Valid>");
	 	 					sb.append("<Amount>"+pamount+"</Amount>");
	 	 					sb.append("<Amount1>"+nettotal+"</Amount1>");
	 	 				}
	 	 				else
	 	 				{
	 	 					sb.append("<Valid>True</Valid>");
	 	 					sb.append("<Amount>"+pamount+"</Amount>");
	 	 					sb.append("<Amount1>"+nettotal+"</Amount1>");
	 	 				}
	 	 				sb.append("</Details>");
	 	 				 
	 	 	 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
			 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
				 
	    	 } 
	    }	
		
		

		
		
		
		
		
		

		
		//==========================================================================
		
		
		
		
		public static void LoadAccessories(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    	 		String startLetter=request.getParameter("startLetter");
	    	 		 
	    	 		String sql="";
	    	 		    
	    	 		sql =" SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM inv_m_accessoriesgroup WHERE INT_GROUPID>=1 ";
	    	 	 	if(!"0".equals(startLetter))
	    	 			sql = sql + " AND CHR_GROUPNAME LIKE '"+startLetter+"%' ";
	    	 		sql = sql +" ORDER BY CHR_GROUPNAME ";
	    	 		
	    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
	    			if(readData.length>0)
	    	 		{	
	    	 			StringBuffer sb = new StringBuffer();    	     	
	    	 			for(int u=0; u<readData.length;u++)
	    	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					sb.append("<Name>" +readData[u][1].toUpperCase() + "</Name>");
		 					sb.append("<Desc>" +readData[u][2]+ "</Desc>");
		 					sb.append("</Row>");
		 					
		 				}	
	    	 			sb.toString();
		 				response.setContentType("text/xml");
		 				response.setHeader("Cache-Control", "no-cache");
		 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
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
		
		public static void LoadAccessoriesProduct(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		
	    		String group= request.getParameter("group");
	    		String startletter= request.getParameter("startLetter");
	    		String ssql="";
	    		if(!"0".equals(startletter))
	    			  ssql=" AND a.CHR_PRODUCTNAME like '"+startletter+"%'";
	    		else	
	    			  ssql=" AND a.CHR_PRODUCTNAME like '%'";
	    		String sql="";
	       		sql= "SELECT a.INT_PRODUCTID,a.CHR_PRODUCTNAME ,b.CHR_GROUPNAME,a.CHR_DESC ,a.DOU_AMOUNT FROM inv_m_accessoriesproduct a,inv_m_accessoriesgroup b WHERE a.INT_GROUPID=b.INT_GROUPID ";
	    		if(!"0".equals(group))
	    			sql = sql+"  AND a.INT_GROUPID="+group+" ";
	    		sql = sql+ssql;
	    		sql = sql+" ORDER BY a.CHR_PRODUCTNAME ";
	    		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	   		 	StringBuffer sb = new StringBuffer();
	 			if (Data.length > 0)
	 	 		{	
	 	 			for(int u=0; u<Data.length;u++)
	 	 			{	
				 		sb.append("<AccessoriesProduct>");
				 		sb.append("<Productid>" + Data[u][0]+ "</Productid>");
				 		sb.append("<Product>" + Data[u][1]+ "</Product>");
		   		 		sb.append("<Group>" + Data[u][2]+ "</Group>");
		   		 		sb.append("<Desc>" + Data[u][3]+ "</Desc>");
		   		 		sb.append("<Amount>" + Data[u][4]+ "</Amount>");
		   		 		sb.append("</AccessoriesProduct>");
		   		 	
		   		 	}
	 	 			response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<AccessoriesProducts>" + sb.toString() + "</AccessoriesProducts>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	    	 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
			 } 
	    }	

		
		public static void LoadBudgetAssign(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		
	    		String year= request.getParameter("year");
	    		String dept= request.getParameter("dept");
	    		String access= request.getParameter("access");
	    		
	    		
	    		String startletter= request.getParameter("startletter");
	    		
	    		String ssql="";
	    		if(!"0".equals(startletter))
	    			  ssql=" AND b.CHR_DEPARTNAME like '"+startletter+"%'";
	    			  
	    		String sql="";
	       		sql= "SELECT b.CHR_DEPARTNAME,c.CHR_GROUPNAME,  a.DOU_AMOUNT,a.INT_TARGETID FROM inv_t_budgetassign a  ,com_m_depart b ,inv_m_accessoriesgroup c WHERE a.INT_DEPARTID = b.INT_DEPARTID 	AND a.INT_GROUPID = c.INT_GROUPID ";
	    		if(!"0".equals(dept))
	    			sql = sql+"  AND a.INT_DEPARTID="+dept+" ";
	    		if(!"0".equals(access))
	    			sql = sql+"  AND a.INT_GROUPID="+access+" ";
	    		sql = sql+ssql;
	    		sql = sql+" AND a.INT_YEAR = "+year+"  ORDER BY b.CHR_DEPARTNAME ";
	    		 
	    		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	   		 	StringBuffer sb = new StringBuffer();
	 			if (Data.length > 0)
	 	 		{	
	 	 			for(int u=0; u<Data.length;u++)
	 	 			{	
				 		sb.append("<BudgetAssign>");
		   		 		sb.append("<Deptname>" + Data[u][0]+ "</Deptname>");
		   		 		sb.append("<Accessname>" + Data[u][1]+ "</Accessname>");
		   		 		sb.append("<Amount>" + Data[u][2]+ "</Amount>");
		   		 		sb.append("<ROW>" + Data[u][3]+ "</ROW>");
		   		 		sb.append("</BudgetAssign>");
		   		 	
		   		 	}
	 	 			response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<BudgetAssigns>" + sb.toString() + "</BudgetAssigns>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	    	 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
			 } 
	    }	
		
		

		public static void LoadBudgetCheck(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    	 		String dept=request.getParameter("dept");
	    	 		String access=request.getParameter("access");
	    	 		String year=request.getParameter("year");
	    	 		
	    	 		String sql="";
	    	 		sql = "SELECT COUNT(*) FROM inv_t_budgetassign " +
		 			"WHERE INT_DEPARTID="+dept+" AND INT_YEAR="+year+" AND INT_GROUPID="+access;
	    	 		boolean flag = false;
	    	 		if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
	    	 			flag =true;
	    	 		else
	    	 			flag = false;
	    	 		
	    	 		StringBuffer sb = new StringBuffer();    	     	
	    	 		sb.append("<Row>");    	            
		 			if(flag)
		 				sb.append("<Value>True</Value>");
		 			else
		 				sb.append("<Value>False</Value>");
		 			sb.append("</Row>");
		 			sb.toString();
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
		 				
			 	} 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
			 } 
	    }	
		
		
		
		public static void loadPurchaseProduct(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	
	    		 	String id=request.getParameter("id");
	    		 	String sql="";
	    		 	sql ="SELECT CHR_DESC,DOU_AMOUNT FROM  inv_m_accessoriesproduct WHERE INT_PRODUCTID="+id;
	    		 	String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		if(datas.length>0)
			 		{	
			 			sb.append("<Product>");
			 			sb.append("<Desc>" +datas[0][0] + "</Desc>");
			 			sb.append("<Amount>" +datas[0][1] + "</Amount>");
			 			sb.append("</Product>");
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Products>" + sb.toString() + "</Products>");
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
		
		public static void loadIndentRaise(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	
	    		 	String dept=request.getParameter("dept");
	    		  
	    		 	String month=request.getParameter("month");
	    		 	String year=request.getParameter("year");
	    		 	String status=request.getParameter("status");
	    		 	
	    		 	String sql="";
	    		 	HttpSession session=request.getSession();
	    		 	String usertype=""+session.getAttribute("USRTYPE");
	    		 	sql =" SELECT a.INT_PURCHASEINDENTID,a.CHR_PURCHASENO,DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'),DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME, ";
	    		 	sql = sql + " a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO,a.DOU_TOTALAMOUNT,a.CHR_STATUS,a.CHR_ACCEPT,a.CHR_ACCSTATUS,a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME,a.CHR_ACCDESC ";
	    		 	sql = sql + " FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c";
	    		 	sql = sql + " WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID";
	    		 	sql = sql + " AND month(a.DAT_INDENTDATE)= "+month; 
	    		 	sql = sql + " AND year(a.DAT_INDENTDATE)= "+year ; 
	    		 	sql = sql + " AND  a.INT_DEPARTID="+dept;
	    		 	if(!"0".equals(status))
	    		 		sql = sql + " AND a.CHR_ACCEPT='"+status+"'";
	    		 	sql = sql + " ORDER BY a.INT_PURCHASEINDENTID ";
	    		 	
	    		 	String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		if(datas.length>0)
			 		{	
			 			for(int u=0;u<datas.length;u++)
			 			{
				 			sb.append("<Product>");
				 			sb.append("<Id>" +datas[u][0] + "</Id>");
				 			sb.append("<Po>" +datas[u][1] + "</Po>");
				 			sb.append("<Indentdate>" +datas[u][2] + "</Indentdate>");
				 			sb.append("<Expectdate>" +datas[u][3] + "</Expectdate>");
				 			sb.append("<Depart>" +datas[u][4] + "</Depart>");
				 			sb.append("<Contact>" +datas[u][5] + "</Contact>");
				 			sb.append("<Number>" +datas[u][6] + "</Number>");
				 			sb.append("<Amount>" +datas[u][7] + "</Amount>");
				 			sb.append("<Status>" +datas[u][8] + "</Status>");
				 			sb.append("<AdminStatus>" +datas[u][9] + "</AdminStatus>");
				 			sb.append("<SuperAdminStatus>" +datas[u][10] + "</SuperAdminStatus>");
				 			sb.append("<Empid>" +datas[u][11] + "</Empid>");
				 			sb.append("<Name>" +datas[u][12] + "</Name>");
				 			sb.append("<Desc>" +datas[u][13] + "</Desc>");
				 			sb.append("<usertype>" +usertype + "</usertype>");
				 			sb.append("</Product>");
			 			}
			 			 
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Products>" + sb.toString() + "</Products>");
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
		
		public static void loadIndentClose(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	
	    		 	String dept=request.getParameter("dept");
	    		 	 
	    		 	String month=request.getParameter("month");
	    		 	String year=request.getParameter("year");
	    		 	String status=request.getParameter("status");
	    		 	String payment=request.getParameter("payment");
	    		 	String sql="";
	    		 	HttpSession session=request.getSession();
	    		 	String usertype=""+session.getAttribute("USRTYPE");
	    		 	
	    		 	
	    		 	  
	    		 	sql =" SELECT a.INT_PURCHASEINDENTID,a.CHR_PURCHASENO,DATE_FORMAT(a.DAT_INDENTDATE,'%d-%m-%Y'), ";
	    		 	sql = sql + " DATE_FORMAT(a.DAT_EXPECTDATE,'%d-%m-%Y'),b.CHR_DEPARTNAME, ";  
	    		 	sql = sql + " a.DOU_TOTALAMOUNT,a.CHR_INDENTRAISEFROM,c.CHR_STAFFNAME,a.CHR_ACCSTATUS , ";
	    		 	sql = sql + " a.DAT_ACCDATE,a.CHR_PURCHASEORDERNO,a.DAT_PODATE,a.CHR_PAYMENTSTATUS ";
	    		 	sql = sql + " FROM inv_t_purchaseindent a,com_m_depart b, com_m_staff c  ";
	    		 	sql = sql + " WHERE a.INT_DEPARTID=b.INT_DEPARTID AND a.CHR_INDENTRAISEFROM = c.CHR_EMPID  ";
	    		 	sql = sql + " AND CHR_ACCEPT='Y' ";
	    		 	sql = sql + " AND month(a.DAT_INDENTDATE)= "+month; 
	    		 	sql = sql + " AND year(a.DAT_INDENTDATE)= "+year ; 
	    		 	sql = sql + " AND  a.INT_DEPARTID="+dept;
	    		 	if(!"0".equals(status))
	    		 		sql = sql + " AND a.CHR_ACCSTATUS='"+status+"'";
	    		 	if(!"0".equals(payment))
	    		 		sql = sql + " AND a.CHR_PAYMENTSTATUS='"+payment+"'";
	    		 	sql = sql + " ORDER BY a.INT_PURCHASEINDENTID ";
	    		 	
	    		 	String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		if(datas.length>0)
			 		{	
			 			for(int u=0;u<datas.length;u++)
			 			{
				 			sb.append("<Product>");
				 			sb.append("<Id>" +datas[u][0] + "</Id>");
				 			sb.append("<Po>" +datas[u][1] + "</Po>");
				 			sb.append("<Indentdate>" +datas[u][2] + "</Indentdate>");
				 			sb.append("<Expectdate>" +datas[u][3] + "</Expectdate>");
				 			sb.append("<Depart>" +datas[u][4] + "</Depart>");
				 			sb.append("<Amount>" +datas[u][5] + "</Amount>");
				 			sb.append("<Empid>" +datas[u][6] + "</Empid>");
				 			sb.append("<Name>" +datas[u][7] + "</Name>");
				 			sb.append("<Approval>" +datas[u][8] + "</Approval>");
				 			sb.append("<Approvaldate>" +datas[u][9] + "</Approvaldate>");
				 			sb.append("<Ponumber>" +datas[u][10] + "</Ponumber>");
				 			sb.append("<Podate>" +datas[u][11] + "</Podate>");
				 			sb.append("<Payment>" +datas[u][12] + "</Payment>");
				 			sb.append("<usertype>" +usertype + "</usertype>");
				 			sb.append("</Product>");
			 			}
			 			 
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Products>" + sb.toString() + "</Products>");
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
		
		
		public static void LoadIndentPayment(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	String Status=request.getParameter("Status");
	    		 	String vendorid=request.getParameter("vendorid");
	    		 	
	    		 	String sql="";
			 		String ssql ="";
			 		
			 		if(!"0".equals(vendorid))
			 			ssql = " AND  a.INT_VENDORID="+vendorid+"  ";
			 		
			 		
			 		String sssql ="";
			 		if("1".equals(Status))
			 			sssql = " AND  a.CHR_PAYMENTSTATUS='N'   ";
			 		else if("2".equals(Status))
			 			sssql = " AND  a.CHR_PAYMENTSTATUS='Y'   ";
			 		else if("0".equals(Status))
			 			sssql = " ";
			 		
			 		sql =" SELECT a.CHR_PURCHASENO  ,b.CHR_VENDORNAME ,a.DOU_TOTALAMOUNT ,  a.DOU_PAIDAMOUNT, ";
				 	sql = sql +"  (a.DOU_TOTALAMOUNT-a.DOU_PAIDAMOUNT),a.CHR_PAYMENTSTATUS FROM inv_t_purchaseindent  a, inv_m_vendorsinformation  b ";
				 	sql = sql +" WHERE a.INT_VENDORID=b.INT_VENDORID "+ssql+sssql;
				 	sql = sql +" ORDER BY a.DAT_INDENTDATE ";
				 	 
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		String StartLetter = ""+request.getParameter("id");
			 		if(readData.length>0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
			 				if(readData[u][0].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter))
			 				{
			 					sb.append("<Payment>");
			 					sb.append("<Purchaseid>" + readData[u][0].replace("&", " AND ")+  "</Purchaseid>");
			 					sb.append("<Vendorname>" + readData[u][1].replace("&", " AND ") +"</Vendorname>");
			 					sb.append("<Totalamount>" + readData[u][2]+ "</Totalamount>");
			 					sb.append("<Paidamount>" + readData[u][3]+ "</Paidamount>");  
			 					sb.append("<Blanace>" +readData[u][4] + "</Blanace>");
			 					sb.append("<Status>" +  readData[u][5]+"</Status>");
			 					sb.append("</Payment>");	
			 				}	
			 			}
			 			
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
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
		
		
		public  static void loadPaymentCommitment(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
	    {
	    	 try 
	    	 {
	    		 String txtSer=""+request.getParameter("txtSer");
	    		 txtSer = txtSer.toUpperCase();
	    		 String month=request.getParameter("month");
	    		 String customer=""+request.getParameter("customer");
	    		 String division=""+request.getParameter("division");
	    		 String salestype =""+request.getParameter("salestype");
	    		 int year=Integer.parseInt(request.getParameter("year"));
	    		 String Branch=  request.getParameter("Branch") ;
	    		 String sql="";
	    	    if("C".equals(salestype))
	    		 {	 
		    		sql=   " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), c.CHR_CUSTOMERNAME, (SELECT count(d.CHR_INVOICETYPE)  FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_TOTALAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_directsales a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID "; //count(b.CHR_INVOICETYPE),
		    	    if(!"0".equals(Branch))
		    			 sql= sql + " AND a.INT_BRANCHID = "+Branch;
		    	    if(!"0".equals(customer))
		    			 sql= sql + " AND a.INT_CUSTOMERID = "+customer;
		    	     if(!"0".equals(salestype))
		    			 sql= sql + " AND b.CHR_INVOICETYPE = '"+salestype+"'";
		    	     if(!"0".equals(division))
		    			 sql= sql + " AND a.INT_DIVIID = "+division;
		    	     sql= sql + " AND month(a.DAT_SALESDATE) = "+Integer.parseInt(month);
		    	     sql= sql + " AND year(a.DAT_SALESDATE) = "+year ;
		    	      if( ! "0".equals(txtSer))
		    	    	 sql = sql +" AND b.CHR_SALESNO LIKE '"+txtSer+"%'";
		    	      sql = sql+" GROUP  BY  b.CHR_SALESNO ORDER BY  b.CHR_SALESNO,a.DAT_SALESDATE ";
	    		 } 
	    		 else if("S".equals(salestype))
	    		 {	 
		    		 sql=   " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), c.CHR_CUSTOMERNAME, (SELECT count(d.CHR_INVOICETYPE) FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_NETAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_servicebilling a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID "; //count(b.CHR_INVOICETYPE),
		    		 if(!"0".equals(Branch))
		    			 sql= sql + " AND a.INT_BRANCHID = "+Branch;
		    		 if(!"0".equals(customer))
		    			 sql= sql + " AND a.INT_CUSTOMERID = "+customer;
		    	     if(!"0".equals(salestype))
		    			 sql= sql + " AND b.CHR_INVOICETYPE = '"+salestype+"'";
		    	     if(!"0".equals(division))
		    			 sql= sql + " AND a.INT_DIVIID = "+division;
		    	     sql= sql + " AND month(a.DAT_SALESDATE) = "+Integer.parseInt(month);
		    	     sql= sql + " AND year(a.DAT_SALESDATE) = "+year ;
		    	      if( ! "0".equals(txtSer))
		    	    	 sql = sql +" AND b.CHR_SALESNO LIKE '"+txtSer+"%'";
		    	      sql = sql+"  GROUP  BY  b.CHR_SALESNO  ORDER BY  b.CHR_SALESNO,a.DAT_SALESDATE   ";
	    		 } 
	    		 else if("D".equals(salestype))
	    		 {	 
		    		 sql=   " SELECT  b.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%M-%Y'), c.CHR_CUSTOMERNAME, (SELECT count(d.CHR_INVOICETYPE) FROM inv_t_paymentcommitment d WHERE d.CHR_SALESNO=b.CHR_SALESNO), a.DOU_NETAMOUNT   ,DATE_FORMAT(b.DT_COMMITMENTDATE,'%d-%M-%Y'),b.DOU_COMMITMENTAMOUNT,b.CHR_STATUS FROM inv_t_directbilling a  ,inv_t_paymentcommitment b,inv_m_customerinfo c   where  a.CHR_SALESNO=b.CHR_SALESNO   AND a.INT_CUSTOMERID = c.INT_CUSTOMERID "; //count(b.CHR_INVOICETYPE),
		    		 if(!"0".equals(Branch))
		    			 sql= sql + " AND a.INT_BRANCHID = "+Branch;
		    		 if(!"0".equals(customer))
		    			 sql= sql + " AND a.INT_CUSTOMERID = "+customer;
		    	     if(!"0".equals(salestype))
		    			 sql= sql + " AND b.CHR_INVOICETYPE = '"+salestype+"'";
		    	     if(!"0".equals(division))
		    			 sql= sql + " AND a.INT_DIVIID = "+division;
		    	     sql= sql + " AND month(a.DAT_SALESDATE) = "+Integer.parseInt(month);
		    	     sql= sql + " AND year(a.DAT_SALESDATE) = "+year ;
		    	      if( ! "0".equals(txtSer))
		    	    	 sql = sql +" AND b.CHR_SALESNO LIKE '"+txtSer+"%'";
		    	      sql = sql+"  GROUP  BY  b.CHR_SALESNO  ORDER BY  b.CHR_SALESNO,a.DAT_SALESDATE  ";
	    		 } 
	    		  
	    		 
	    	     String readData[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	    	     
	    	     StringBuffer sb = new StringBuffer();
			 	 if(readData.length >0)
			 	 {
			 		 for(int u=0; u<readData.length;u++)
			 		 {
			 			 	sb.append("<directSale>");
		     				sb.append("<InvoiceNumber>" + readData[u][0] +"</InvoiceNumber>");
		     				sb.append("<InvoiceDate>" + readData[u][1]+ "</InvoiceDate>");
		     				sb.append("<Customer>" + readData[u][2].replace("&", " AND ")+ "</Customer>");
		     				sb.append("<NoofDue>" + readData[u][3]+ "</NoofDue>");
		     				sb.append("<InvoiceAmount>" + readData[u][4]+ "</InvoiceAmount>");
		     				sb.append("<Cdate>" + readData[u][5]+ "</Cdate>");
		     				sb.append("<CAmount>" + readData[u][6]+ "</CAmount>");
		     				sb.append("<Status>" + readData[u][7]+ "</Status>");
		                	sb.append("</directSale>");
		                	
			 		 }
			 		 
			 		response.setContentType("text/xml");
	 	     		response.setHeader("Cache-Control", "no-cache");
	 	     		response.getWriter().write("<directSales>" + sb.toString() + "</directSales>");
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
		
		
		public static void LoadCustomerSalesCreditlimt(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 
			try
			{
	    		String customerId = request.getParameter("customerId");
	    		String type = request.getParameter("type");
	    		double customercreditlimit = Double.parseDouble(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DOU_CREDITLIMIT  FROM inv_m_customerinfo  WHERE INT_CUSTOMERID="+customerId)[0][0]);
	    		String sql="";
	    		
	    		if("C".equals(type))
	    		{
	    			sql=" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS  ";
	    			sql = sql + " ,b.CHR_CUSTOMERNAME ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME    ";
	    			sql = sql + "  from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d, com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'   ";
	    			sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID  ";
	    			sql = sql + " AND a.INT_DIVIID=d.INT_DIVIID  AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID  ";
	    			sql = sql + " AND b.INT_CUSTOMERID=  "+customerId;
	    			sql = sql + " ORDER BY  a.DAT_SALESDATE";
	    		}
	    		else if ("D".equals(type))
	    		{
	    			sql = "";
	    			sql=" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_AMOUNT,a.CHR_PAYMENTSTATUS   ";
					sql = sql + "  ,b.CHR_CUSTOMERNAME ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME  from inv_t_directbilling a , inv_m_customerinfo b ,   ";
					sql = sql + "  com_m_staff c ,inv_m_division d ,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'    ";
					sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID   ";
					sql = sql + "  AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID    ";
					sql = sql + " AND b.INT_CUSTOMERID=  "+customerId;		
					sql = sql + " ORDER BY  a.DAT_SALESDATE"; 		
	    		}
	    		else if ("S".equals(type))
	    		{
	    			sql = "";
	    			sql=" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),datediff(now(),a.DAT_SALESDATE),a.DOU_NETAMOUNT,a.CHR_PAYMENTSTATUS   ";
    				sql = sql + "  ,b.CHR_CUSTOMERNAME ,c.CHR_STAFFNAME,d.CHR_DIVICODE,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME  from inv_t_servicebilling a , inv_m_customerinfo b ,    ";
    				sql = sql + "  com_m_staff c ,inv_m_division d,com_m_branch e,com_m_company f WHERE a.CHR_PAYMENTSTATUS !='Y'    ";
    				sql = sql + "  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID   ";
    				sql = sql + "  AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID   ";
    				sql = sql + " AND b.INT_CUSTOMERID=  "+customerId;		
    				sql = sql + " ORDER BY  a.DAT_SALESDATE"; 		
	    		}
    			com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	   			StringBuffer sb = new StringBuffer();
	 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 			if (readData.length > 0)
	 	 		{	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{	
	 	 				sb.append("<Row>");
	 	 				sb.append("<Saleno>" + readData[u][0]+ "</Saleno>");
	 	 				sb.append("<creditsum>" + customercreditlimit+ "</creditsum>"); 
	 	 				sb.append("<Date>" + readData[u][1]+ "</Date>");
	                    sb.append("<Daysleft>" + readData[u][2]+ "</Daysleft>");
	                    sb.append("<Amount>" + readData[u][3]+ "</Amount>");
	                    sb.append("<PaymentStatus>" + readData[u][4]+ "</PaymentStatus>");
	                    sb.append("<Customer>" + readData[u][5]+ "</Customer>");
	                    sb.append("<Stafff>" + readData[u][6]+ "</Stafff>");
	                    sb.append("<Division>" + readData[u][7]+ "</Division>");
	                    sb.append("<Company>" + readData[u][8]+ "</Company>");
	                    sb.append("<Branch>" + readData[u][9]+ "</Branch>");
	                    sb.append("</Row>");
	 	 			}
	 	 			 
	 	 			response.setContentType("text/xml");
	 	            response.setHeader("Cache-Control", "no-cache");
	 		        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
	 			} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	    	 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
			 } 
	    }	
	    
		
		
		
		
		public static void LoadCustomerSalesCreditAmount(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 
			try
			{
	    		String customerId = request.getParameter("customerId");
	    		double customercreditlimit = Double.parseDouble(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DOU_CREDITLIMIT  FROM inv_m_customerinfo  WHERE INT_CUSTOMERID="+customerId)[0][0]);
	    		if (customercreditlimit > 0)
	 	 		{
	    			StringBuffer sb = new StringBuffer();
		 			sb.append("<Row>");
		 	 		sb.append("<creditsum>" + customercreditlimit+ "</creditsum>"); 
		 	 		sb.append("</Row>");
		 	 		 
		 	 		response.setContentType("text/xml");
		 	        response.setHeader("Cache-Control", "no-cache");
		 		    response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
				} 
	 	 		else 
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		    	 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
			 } 
	    }
		
		
		
		
		
		
		
		
		
		
		public static void loadSalesAnalysisGroup(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		
	    		String years= request.getParameter("year");
	    		String Branch= request.getParameter("Branch");
	    		String period= request.getParameter("period");
	    		String division= request.getParameter("division");
	    		String payType= request.getParameter("payType");
	    		
	    		String sql="";
	    		String dsql="";
	    		int year = Integer.parseInt(years);
	    		if(!"0".equals(division))
	       			dsql=" AND a.INT_DIVIID="+division+"   ";
	    		
	       		sql = "SELECT INT_DIVIID,CHR_DIVICODE FROM inv_m_division  WHERE INT_DIVIID>=1";
	       		if(!"0".equals(division))
	       			sql= sql +" AND  INT_DIVIID="+division+"   ";
	       		sql= sql +" ORDER BY CHR_DIVICODE ";
	       		 
	       		 
	       		String tablename="";
	       		String columnname="";
	       		if("CustomerSales".equals(payType))
	       		{
	       			tablename= " inv_t_directsales a ";
	       			columnname = " a.DOU_TOTALAMOUNT ";
	       		}	
	       		else if("DirectBilling".equals(payType))
	       		{
	       			tablename= " inv_t_directbilling a";
	       			columnname = "  a.DOU_NETAMOUNT ";
	       		}
	       		else if("ServiceBilling".equals(payType))
	       		{
	       			tablename= " inv_t_servicebilling a  ";
	       			columnname = " a.DOU_NETAMOUNT ";
	       		}
	       		 
	       		
	       		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    		if(data.length>0)
				{	
	    			StringBuffer sb = new StringBuffer();
	    			
	    			//First Quarter..............
	    			int totalnumber=0;
	    			double totalamount=0; 
	    			if("1".equals(period))
	           		{	
	           			for(int u=0;u<data.length;u++)
						{
	           				totalnumber =0;
		   		 			totalamount = 0;
	           				sb.append("<Row>");
			   		 		sb.append("<Divid>" + data[u][0]+ "</Divid>");
			   		 		sb.append("<Divname>" + data[u][1]+ "</Divname>");
			   		 		dsql=" AND a.INT_DIVIID="+data[u][0]+"   ";
			   		 		//Total sales for April Month
			   		 		
			   		 		sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM " +tablename +" ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+year+"-04-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		 
			   		 		 
			   		 		String aprildata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(aprildata.length>0)
			   		 		{
			   		 			sb.append("<Month1>"+aprildata[0][3]+"</Month1>");
			   		 			sb.append("<AmtMonth1>"+aprildata[0][4]+"</AmtMonth1>");
			   		 			totalnumber = totalnumber+Integer.parseInt(aprildata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(aprildata[0][4]);
			   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month1>0</Month1>");
			   		 			sb.append("<AmtMonth1>0</AmtMonth1>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total sales for MAY
			   		 		  
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
				   		 	if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-05-01' AND DAT_SALESDATE <='"+year+"-05-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String maydata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(maydata.length>0)
			   		 		{
			   		 			sb.append("<Month2>"+maydata[0][3]+"</Month2>");
			   		 			sb.append("<AmtMonth2>"+maydata[0][4]+"</AmtMonth2>");
			   		 			totalnumber = totalnumber+Integer.parseInt(maydata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(maydata[0][4]);
		   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month2>0</Month2>");
			   		 			sb.append("<AmtMonth2>0</AmtMonth2>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total Sales for JUNE
			   		 		  
			   		 		
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-06-01' AND DAT_SALESDATE <='"+year+"-06-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String junedata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(junedata.length>0)
			   		 		{
			   		 			sb.append("<Month3>"+junedata[0][3]+"</Month3>");
			   		 			sb.append("<AmtMonth3>"+junedata[0][4]+"</AmtMonth3>");
			   		 			totalnumber = totalnumber+Integer.parseInt(junedata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(junedata[0][4]);
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month3>0</Month3>");
			   		 			sb.append("<AmtMonth3>0</AmtMonth3>");
			   		 		}
			   		 		sb.append("<Totalnumber>"+totalnumber+"</Totalnumber>");
			   		 		sb.append("<TotalAmount>"+totalamount+"</TotalAmount>");
							sb.append("</Row>");
							
						}
	           		}
	    			
	    			
	    			//Second Quarter 
	    			if("2".equals(period))
	               	{
	    				
	           			for(int u=0;u<data.length;u++)
						{
	           				totalnumber =0;
		   		 			totalamount = 0;
	           				sb.append("<Row>");
			   		 		sb.append("<Divid>" + data[u][0]+ "</Divid>");
			   		 		sb.append("<Divname>" + data[u][1]+ "</Divname>");
			   		 		dsql=" AND a.INT_DIVIID="+data[u][0]+"   ";
			   		 		
			   		 		//Total sales for JULY Month
			   		 		sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 			sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+year+"-07-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String julydata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(julydata.length>0)
			   		 		{
			   		 			sb.append("<Month1>"+julydata[0][3]+"</Month1>");
			   		 			sb.append("<AmtMonth1>"+julydata[0][4]+"</AmtMonth1>");
			   		 			totalnumber = totalnumber+Integer.parseInt(julydata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(julydata[0][4]);
			   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month1>0</Month1>");
			   		 			sb.append("<AmtMonth1>0</AmtMonth1>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total sales for AUGUST
			   		 		  
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
				   		 	if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-08-01' AND DAT_SALESDATE <='"+year+"-08-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String augdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(augdata.length>0)
			   		 		{
			   		 			sb.append("<Month2>"+augdata[0][3]+"</Month2>");
			   		 			sb.append("<AmtMonth2>"+augdata[0][4]+"</AmtMonth2>");
			   		 			totalnumber = totalnumber+Integer.parseInt(augdata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(augdata[0][4]);
		   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month2>0</Month2>");
			   		 			sb.append("<AmtMonth2>0</AmtMonth2>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total Sales for SEPTEMBER
			   		 		  
			   		 		
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-09-01' AND DAT_SALESDATE <='"+year+"-09-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String sepdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(sepdata.length>0)
			   		 		{
			   		 			sb.append("<Month3>"+sepdata[0][3]+"</Month3>");
			   		 			sb.append("<AmtMonth3>"+sepdata[0][4]+"</AmtMonth3>");
			   		 			totalnumber = totalnumber+Integer.parseInt(sepdata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(sepdata[0][4]);
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month3>0</Month3>");
			   		 			sb.append("<AmtMonth3>0</AmtMonth3>");
			   		 		}
			   		 		sb.append("<Totalnumber>"+totalnumber+"</Totalnumber>");
			   		 		sb.append("<TotalAmount>"+totalamount+"</TotalAmount>");
							sb.append("</Row>");
							
						}
	           		
	               	}
	    			
	    			 
	    			
	           		 
					//Third Quarter
	        		if("3".equals(period))
	               	{ 

	    				
	           			for(int u=0;u<data.length;u++)
						{
	           				totalnumber =0;
		   		 			totalamount = 0;
	           				sb.append("<Row>");
			   		 		sb.append("<Divid>" + data[u][0]+ "</Divid>");
			   		 		sb.append("<Divname>" + data[u][1]+ "</Divname>");
			   		 		dsql=" AND a.INT_DIVIID="+data[u][0]+"   ";
			   		 		
			   		 		//Total sales for OCTOBER Month
			   		 		sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+year+"-10-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String octdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(octdata.length>0)
			   		 		{
			   		 			sb.append("<Month1>"+octdata[0][3]+"</Month1>");
			   		 			sb.append("<AmtMonth1>"+octdata[0][4]+"</AmtMonth1>");
			   		 			totalnumber = totalnumber+Integer.parseInt(octdata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(octdata[0][4]);
			   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month1>0</Month1>");
			   		 			sb.append("<AmtMonth1>0</AmtMonth1>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total sales for NOVEMBER
			   		 		  
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-11-01' AND DAT_SALESDATE <='"+year+"-11-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String novdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(novdata.length>0)
			   		 		{
			   		 			sb.append("<Month2>"+novdata[0][3]+"</Month2>");
			   		 			sb.append("<AmtMonth2>"+novdata[0][4]+"</AmtMonth2>");
			   		 			totalnumber = totalnumber+Integer.parseInt(novdata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(novdata[0][4]);
		   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month2>0</Month2>");
			   		 			sb.append("<AmtMonth2>0</AmtMonth2>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total Sales for DECEMBER
			   		 		  
			   		 		
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+year+"-12-01' AND DAT_SALESDATE <='"+year+"-12-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String decdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(decdata.length>0)
			   		 		{
			   		 			sb.append("<Month3>"+decdata[0][3]+"</Month3>");
			   		 			sb.append("<AmtMonth3>"+decdata[0][4]+"</AmtMonth3>");
			   		 			totalnumber = totalnumber+Integer.parseInt(decdata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(decdata[0][4]);
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month3>0</Month3>");
			   		 			sb.append("<AmtMonth3>0</AmtMonth3>");
			   		 		}
			   		 		sb.append("<Totalnumber>"+totalnumber+"</Totalnumber>");
			   		 		sb.append("<TotalAmount>"+totalamount+"</TotalAmount>");
							sb.append("</Row>");
							
						}
	           		
	               	
	               	}
	        		
	        		 
	        		// Fourth Quarter
	        		if("4".equals(period))
	               	{  
	        			for(int u=0;u<data.length;u++)
						{
	        				totalnumber =0;
		   		 			totalamount = 0;
	        				sb.append("<Row>");
			   		 		sb.append("<Divid>" + data[u][0]+ "</Divid>");
			   		 		sb.append("<Divname>" + data[u][1]+ "</Divname>");
			   		 		dsql=" AND a.INT_DIVIID="+data[u][0]+"   ";
			   		 		
			   		 		//Total sales for January Month
			   		 		sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-01-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String jandata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(jandata.length>0)
			   		 		{
			   		 			sb.append("<Month1>"+jandata[0][3]+"</Month1>");
			   		 			sb.append("<AmtMonth1>"+jandata[0][4]+"</AmtMonth1>");
			   		 			totalnumber = totalnumber+Integer.parseInt(jandata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(jandata[0][4]);
			   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month1>0</Month1>");
			   		 			sb.append("<AmtMonth1>0</AmtMonth1>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total sales for FEBUARY
			   		 		  
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+(year+1)+"-02-01' AND DAT_SALESDATE <='"+(year+1)+"-02-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String febdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(febdata.length>0)
			   		 		{
			   		 			sb.append("<Month2>"+febdata[0][3]+"</Month2>");
			   		 			sb.append("<AmtMonth2>"+febdata[0][4]+"</AmtMonth2>");
			   		 			totalnumber = totalnumber+Integer.parseInt(febdata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(febdata[0][4]);
		   		 			
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month2>0</Month2>");
			   		 			sb.append("<AmtMonth2>0</AmtMonth2>");
			   		 		}
			   		 		
			   		 		
			   		 		//Total Sales for MARCH
			   		 		  
			   		 		
				   		 	sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 		sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 		sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 		sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 		sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 		if(!"0".equals(Branch))
			   		 			sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 		
			   		 		sql = sql +dsql;
			   		 		sql = sql +" AND  DAT_SALESDATE >='"+(year+1)+"-03-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' ";
			   		 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 		 
			   		 		String mardata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			   		 		if(mardata.length>0)
			   		 		{
			   		 			sb.append("<Month3>"+mardata[0][3]+"</Month3>");
			   		 			sb.append("<AmtMonth3>"+mardata[0][4]+"</AmtMonth3>");
			   		 			totalnumber = totalnumber+Integer.parseInt(mardata[0][3]);
			   		 			totalamount = totalamount+Double.parseDouble(mardata[0][4]);
			   		 		}	
			   		 		else
			   		 		{
			   		 			sb.append("<Month3>0</Month3>");
			   		 			sb.append("<AmtMonth3>0</AmtMonth3>");
			   		 		}
			   		 		sb.append("<Totalnumber>"+totalnumber+"</Totalnumber>");
			   		 		sb.append("<TotalAmount>"+totalamount+"</TotalAmount>");
							sb.append("</Row>");
							
						}
	           		
	               	
	               	
	        			
	               	}
	        		
	        		//All Quarter 
	        		if("5".equals(period))
	               	{
	        			for(int u=0;u<data.length;u++)
						{
	        				totalnumber =0;
		   		 			totalamount = 0;
	        				sb.append("<Row>");
			   		 		sb.append("<Divid>" + data[u][0]+ "</Divid>");
			   		 		sb.append("<Divname>" + data[u][1]+ "</Divname>");
			   		 		dsql=" AND a.INT_DIVIID="+data[u][0]+"   ";
			   		 		for(int x=1;x<13;x++)
			   		 		{
			   		 			 
			   		 			if(x<=3)
			   		 			{	
			   		 				sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 				sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 				sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 				sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 				sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 				if(!"0".equals(Branch))
			   		 					sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 			 		sql = sql +dsql;
		   		 			 		sql = sql +" AND  DAT_SALESDATE >='"+(year+1)+"-"+x+"-01' AND DAT_SALESDATE <='"+(year+1)+"-"+x+"-31' ";
		   		 			 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 			}
			   		 			else
			   		 			{
				   		 			sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM( "+columnname+" ), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) "; 
			   		 				sql = sql +" FROM  " +tablename +"  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			   		 				sql = sql +" where a.INT_DIVIID=b.INT_DIVIID  ";
			   		 				sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID   ";
			   		 				sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID   ";
			   		 				if(!"0".equals(Branch))
			   		 					sql = sql +" AND a.INT_BRANCHID="+Branch;
		   		 			 		sql = sql +dsql;
		   		 			 		sql = sql +" AND  DAT_SALESDATE >='"+(year)+"-"+x+"-01' AND DAT_SALESDATE <='"+(year)+"-"+x+"-31' ";
		   		 			 		sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)   ";
			   		 			}
				   		 		String mardata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				   		 		if(mardata.length>0)
				   		 		{
				   		 			sb.append("<Month"+x+">"+mardata[0][3]+"</Month"+x+">");
				   		 			sb.append("<AmtMonth"+x+">"+mardata[0][4]+"</AmtMonth"+x+">");
				   		 			totalnumber = totalnumber+Integer.parseInt(mardata[0][3]);
				   		 			totalamount = totalamount+Double.parseDouble(mardata[0][4]);
				   		 		}	
				   		 		else
				   		 		{
				   		 			sb.append("<Month"+x+">0</Month"+x+">");
				   		 			sb.append("<AmtMonth"+x+">0</AmtMonth"+x+">");
				   		 		}
				   		 		
			   		 		 
							}
			   		 	 	sb.append("<Totalnumber>"+totalnumber+"</Totalnumber>");
			   		 		sb.append("<TotalAmount>"+totalamount+"</TotalAmount>");
							sb.append("</Row>");
						}
	               	}
	        		
	        		 
	        		
	        		 
	        		response.setContentType("text/xml");
		            response.setHeader("Cache-Control", "no-cache");
			        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
				} 
		 		else 
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	    	 } 
	    	 catch (Exception e) 
	    	 {
				 System.out.println(e.getMessage());
			 } 
	    }	
		
		
		
		
		
		
		public static void loadPurchaseRequest(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	
	    		 	String division=request.getParameter("division");
	    		 	String customer=request.getParameter("customer");
	    		 	String Branch=request.getParameter("Branch");
	    		 	String StartLetter = ""+request.getParameter("id");
	    		 	String month=request.getParameter("month");
	    		 	String year=request.getParameter("year");
	    		 	String sql="";
	    		 	
	    		 	sql = " SELECT "; 
	    		 	sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
	    		 	sql = sql + " d.CHR_CUSTOMERNAME,e.CHR_VENDORNAME, ";
	    		 	sql = sql + " f.CHR_PAYMENTNAME, ";
	    		 	sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_APPROVEDSTATUS ";	
	    		 	sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,  inv_m_vendorsinformation  e, ";
	    		 	sql = sql + " inv_m_paymentterms f,com_m_staff g ";
	    		 	sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
	    		 	sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
	    		 	sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
	    		 	sql = sql + " AND a.INT_VENDORID = e.INT_VENDORID      ";  
	    		 	sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
	    		 	sql = sql + " AND a.CHR_REF=g.CHR_EMPID ";
	    		 	
	    		 	sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
			 		sql = sql + " AND MONTH(a.DAT_REQUESTDATE)="+month+" ";
			 		sql = sql + " AND YEAR(a.DAT_REQUESTDATE)="+year+" ";
			 		if(!"0".equals(customer))
			 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
			 		if(!"0".equals(division))
			 			sql= sql+" AND a.INT_DIVIID="+ division;
			 		if(!"0".equals(StartLetter))
			 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
			 		 
			 		sql = sql + " ORDER BY a.INT_POREQUESTID ";
			 		// System.out.println(sql);
	    		 	
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		if (readData.length > 0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
		 	 				sb.append("<Row>");
		 					sb.append("<RowID>"+readData[u][0].trim()+"</RowID>");
		 					sb.append("<Branch>"+readData[u][1].trim()+"</Branch>");
		 					sb.append("<Division>"+readData[u][2].trim()+"</Division>");
		 					sb.append("<Requestno>"+readData[u][3].trim()+"</Requestno>");
		 					sb.append("<Date>"+readData[u][4].trim()+"</Date>");
		 					sb.append("<Customer>"+readData[u][5].replace("&", "").trim()+"</Customer>");
		 					sb.append("<Vendor>"+readData[u][6].replace("&", "").trim()+"</Vendor>");
		 					sb.append("<Vendorpayment>"+readData[u][7].replace("&", "").trim()+"</Vendorpayment>");
		 					sb.append("<Customerpayment>"+readData[u][8].replace("&", "").trim()+"</Customerpayment>");
		 					sb.append("<Ref>"+readData[u][9].trim()+"</Ref>");
		 					sb.append("<Staff>"+readData[u][10].trim()+"</Staff>");
		 					sb.append("<Status>"+readData[u][11].trim()+"</Status>");
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
				
	    	 } 
	    }
		
		
		

		public static void loadPurchaseRequestAccept(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	
	    		 	String division=request.getParameter("division");
	    		 	String customer=request.getParameter("customer");
	    		 	String Branch=request.getParameter("Branch");
	    		 	String StartLetter = ""+request.getParameter("id");
	    		 	String month=request.getParameter("month");
	    		 	String year=request.getParameter("year");
	    		 	String status=request.getParameter("status");
	    		 	String sql="";
	    		 	
	    		 	sql = " SELECT "; 
	    		 	sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
	    		 	sql = sql + " d.CHR_CUSTOMERNAME,e.CHR_VENDORNAME, ";
	    		 	sql = sql + " f.CHR_PAYMENTNAME, ";
	    		 	sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_APPROVEDSTATUS, ";
	    		 	sql = sql + "a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y')  ";
	    		 	sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,  inv_m_vendorsinformation  e, ";
	    		 	sql = sql + " inv_m_paymentterms f,com_m_staff g ";
	    		 	sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
	    		 	sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
	    		 	sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
	    		 	sql = sql + " AND a.INT_VENDORID = e.INT_VENDORID      ";  
	    		 	sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
	    		 	sql = sql + " AND a.CHR_REF=g.CHR_EMPID ";
	    		 	
	    		 	sql = sql + " AND a.INT_BRANCHID="+Branch+" ";
			 		sql = sql + " AND MONTH(a.DAT_REQUESTDATE)="+month+" ";
			 		sql = sql + " AND YEAR(a.DAT_REQUESTDATE)="+year+" ";
			 		if(!"0".equals(customer))
			 			sql=sql+ " AND a.INT_CUSTOMERID="+customer;
			 		if(!"0".equals(division))
			 			sql= sql+" AND a.INT_DIVIID="+ division;
			 		
			 		if(!"0".equals(status))
			 			sql= sql+" AND a.CHR_APPROVEDSTATUS='"+ status+"'";
			 		
			 		if(!"0".equals(StartLetter))
			 			sql= sql+" AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter+"%'";
			 		 
			 		sql = sql + " ORDER BY a.INT_POREQUESTID ";
			 		// System.out.println(sql);
	    		 	
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		if (readData.length > 0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
		 	 				sb.append("<Row>");
		 					sb.append("<RowID>"+readData[u][0].trim()+"</RowID>");
		 					sb.append("<Branch>"+readData[u][1].trim()+"</Branch>");
		 					sb.append("<Division>"+readData[u][2].trim()+"</Division>");
		 					sb.append("<Requestno>"+readData[u][3].trim()+"</Requestno>");
		 					sb.append("<Date>"+readData[u][4].trim()+"</Date>");
		 					sb.append("<Customer>"+readData[u][5].replace("&", "").trim()+"</Customer>");
		 					sb.append("<Vendor>"+readData[u][6].replace("&", "").trim()+"</Vendor>");
		 					sb.append("<Vendorpayment>"+readData[u][7].replace("&", "").trim()+"</Vendorpayment>");
		 					sb.append("<Customerpayment>"+readData[u][8].replace("&", "").trim()+"</Customerpayment>");
		 					sb.append("<Ref>"+readData[u][9].trim()+"</Ref>");
		 					sb.append("<Staff>"+readData[u][10].trim()+"</Staff>");
		 					sb.append("<Status>"+readData[u][11].trim()+"</Status>");
		 					sb.append("<Approved>"+readData[u][12].trim()+"</Approved>");
		 					//sb.append("<Approvedby>"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+readData[u][12].trim()+"'")[0][0]+"</Approvedby>");
		 					sb.append("<Approveddate>"+readData[u][13].trim()+"</Approveddate>");
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
				
	    	 } 
	    }
		
		
}

