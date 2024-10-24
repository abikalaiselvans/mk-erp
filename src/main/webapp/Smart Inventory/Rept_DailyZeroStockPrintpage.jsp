<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%
	try
	{
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = new java.util.Date();
		String updatedate = "" + datetime.format(date);
		String branchid = session.getAttribute("BRANCHID").toString();
		double sum=0.0;
		double totalsum=0.0;
		java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(2);
   		formatter.setMinimumFractionDigits(2); 
		out.print("<br><br><br>");
		//INT_BRANCHID="+branchid
		String sql = "SELECT CHR_ITEMID,CHR_ITEMNAME,CHR_DES FROM inv_m_item ORDER BY CHR_ITEMID ";//CHR_ITEMNAME
		String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		 
		out.println("<table   id='myTable' align=center width='70%' border='1' cellspacing='0' cellpadding='5'   >");
		out.println("<tr>");
		out.println("<td colspan=8 class='boldEleven' align=center><b>ZERO STOCK ( "+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(updatedate)+" ) </b></td>");
		out.println("<tr>");
		out.println("<td class='boldEleven'><b>S.No </td>");
		out.println("<td class='boldEleven'><b>Type</td>");
		out.println("<td class='boldEleven'><b>Item / Product Code</td>");
		out.println("<td class='boldEleven'><b>Description</td>");
		out.println("</tr>");
		int rcount=0;
		if(data.length>0)
		{
			//out.println("<tr><td class='boldEleven' colspan=7 align=center> <b>Item</b> ");
			for(int u=0;u<data.length;u++) 
			{
				
				sql =" SELECT COUNT(*) FROM inv_t_vendorgoodsreceived ";
				sql = sql+"	WHERE CHR_FLAG ='N' AND CHR_SERIALNO is not null and CHR_GRTFLAG='N' AND CHR_ITEMID='"+data[u][0]+"' AND CHR_TYPE='I' AND INT_BRANCHID="+branchid;
				
				String count[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
				int qty = 0;
				qty=Integer.parseInt(count[0][0]);	
				if(qty<1)
				{
				 	
					if(u%2 == 0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");
					 rcount=rcount+1;
					 out.println("<td class='boldEleven'  valign='top'>"+(rcount)+"</td>");
					 out.println("<td class='boldEleven'  valign='top'>Item</td>");
					 out.println("<td class='boldEleven'  valign='top'>"+data[u][1]+"</td>");
					 out.println("<td class='boldEleven'  valign='top'>"+data[u][2].toUpperCase()+"</td>");
				 }
			}
		}
		else
		{
			out.println("<tr>");
			out.println("<td height=200 colspan=6 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}
			
		 
			
			sql = "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PRODUCTDESC FROM inv_m_produtlist  WHERE CHR_PTYPE !='S' ORDER BY CHR_PRODUCTID ";//CHR_PRODUCTCODE
			String pdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			if(pdata.length>0)
			{
			//out.println("<tr><td class='boldEleven' colspan=7 align=center> <b>Product</b> ");
			for(int u=0;u<pdata.length;u++) 
			{
				sql =" SELECT COUNT(*) FROM inv_t_vendorgoodsreceived ";
				sql = sql+"	WHERE CHR_FLAG ='N' and CHR_GRTFLAG='N'  AND CHR_SERIALNO is not null AND CHR_ITEMID='"+pdata[u][0]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;
				String count[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
				int qty = 0;
				qty=Integer.parseInt(count[0][0]);
				if(qty<1)
				{
					 if(u%2 == 0)
						out.println("<tr class='MRow1'>");
				 	else
						out.println("<tr class='MRow2'>");
					rcount=rcount+1;
					out.println("<td class='boldEleven'  valign='top'>"+(rcount)+"</td>");
					out.println("<td class='boldEleven'  valign='top'>Product</td>");
					out.println("<td class='boldEleven'  valign='top'>"+pdata[u][1]+"</td>");
					out.println("<td class='boldEleven'  valign='top'>"+pdata[u][2].toUpperCase()+"</td>");
				} 
			}
		}
		else
		{
			out.println("<tr>");
			out.println("<td height=200 colspan=6 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}
		
		//consumables only			
		sql = "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PRODUCTDESC FROM inv_m_produtlist  WHERE CHR_PTYPE ='S' ORDER BY CHR_PRODUCTCODE";
		String cdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		if(cdata.length>0)
		{
			//out.println("<tr><td class='boldEleven' colspan=7 align=center> <b>Consumables</b> ");
			for(int u=0;u<cdata.length;u++) 
			{
				int qty = 0;
				sql= "SELECT count(*) FROM inv_t_stock WHERE CHR_ITEMID='"+cdata[u][1].trim()+"' AND CHR_TYPE='P' AND  INT_BRANCHID="+branchid;
    		 	if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			    {
					sql= "SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+cdata[u][1].trim()+"' AND CHR_TYPE='P' AND  INT_BRANCHID="+branchid;
					String count[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 		qty=Integer.parseInt(count[0][0]);
				}	
				if(qty<1)
				{
				 	if(u%2 == 0)
						out.println("<tr class='MRow1'>");
				 	else
						out.println("<tr class='MRow2'>");
					rcount=rcount+1;	
					out.println("<td class='boldEleven'  valign='top'>"+(rcount)+"</td>");
					out.println("<td class='boldEleven'  valign='top'>Consumables</td>");
					out.println("<td class='boldEleven'  valign='top'>"+cdata[u][1].trim()+"</td>");
					out.println("<td class='boldEleven'  valign='top'>"+cdata[u][2].trim().toUpperCase()+"</td>");
				
			  }			
			}
		}
		else
		{
			out.println("<tr>");
			out.println("<td height=200 colspan=6 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}
	 
			
	out.println("</table>");
	out.print(" <br> ");
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
	  	
  %>
  
  
  
  
  
  