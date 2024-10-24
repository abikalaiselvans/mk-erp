<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >

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
		String sql="";
		String division=request.getParameter("division");
		String divisionname="&nbsp;";
		if(!"0".equals(division))
		{
			sql="SELECT CHR_DIVICODE FROM inv_m_division  WHERE INT_DIVIID="+division;
			String divisiondata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			divisionname = divisiondata[0][0] ;
		}
		
		//INT_BRANCHID="+branchid
		if("0".equals(division))
			sql = "SELECT a.CHR_ITEMID,a.CHR_ITEMNAME,a.CHR_DES,b.CHR_DIVICODE FROM inv_m_item a ,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID ORDER BY CHR_ITEMID ";//CHR_ITEMNAME
		else
			sql = "SELECT a.CHR_ITEMID,a.CHR_ITEMNAME,a.CHR_DES,b.CHR_DIVICODE  FROM inv_m_item a,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID AND a.INT_DIVIID="+division+" ORDER BY CHR_ITEMID "; 
	   String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		 
		out.println("<table   id='myTable' align=center width='70%' border='1' cellspacing='0' cellpadding='5'   >");
		out.println("<tr>");
		out.println("<td colspan=9 class='boldEleven' align=center><b>STOCK ( "+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(updatedate)+" ) </b></td>");
		out.println("<tr>");
		out.println("<td class='boldEleven'><b>S.No </td>");
		out.println("<td class='boldEleven'><b>Type</td>");
		out.println("<td class='boldEleven'><b>Item / Product Code</td>");
		out.println("<td class='boldEleven'><b>Division</td>");
		out.println("<td class='boldEleven'><b>Description</td>");
		out.println("<td class='boldEleven'><b>No </td>");
		out.println("<td class='boldEleven'><b>Average Price </td>");
		out.println("<td class='boldEleven'><b>Toal Price </td>");
		out.println("</tr>");
		int rcount=0;
		if(data.length>0)
		{
			//out.println("<tr><td class='boldEleven' colspan=7 align=center> <b>Item</b> ");
			for(int u=0;u<data.length;u++) 
			{
				
				sql =" SELECT COUNT(*),sum(DOU_UNITPRICE),(sum(DOU_UNITPRICE)/COUNT(*))  FROM inv_t_vendorgoodsreceived ";
				sql = sql+"	WHERE CHR_FLAG ='N' AND CHR_SERIALNO is not null and CHR_GRTFLAG='N' AND CHR_ITEMID='"+data[u][0]+"' AND CHR_TYPE='I' AND INT_BRANCHID="+branchid;
				
				String count[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
				int qty = 0;
				qty=Integer.parseInt(count[0][0]);	
				if(qty>0)
				{
				 	
					if(u%2 == 0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");
				 rcount=rcount+1;
				 out.println("<td class='boldEleven'  valign='top'>"+(rcount)+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>Item</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+data[u][1]+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+data[u][3].toUpperCase()+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+data[u][2].toUpperCase()+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+qty+" </td>");
				 double s=0.0;
				 double s1=0;
				 s = Double.parseDouble(count[0][2]);
				 s1 = Double.parseDouble(count[0][1]);
				 out.println("<td class='boldEleven'  valign='top' align=right>"+com.my.org.erp.common.CommonFunctions.Round(s));
				 out.println("<td class='boldEleven'  valign='top' align=right>"+com.my.org.erp.common.CommonFunctions.Round((s1))); 
				 totalsum = totalsum+com.my.org.erp.common.CommonFunctions.Round((s1)); 
				}
			}
		}
		/*else
		{
			out.println("<tr>");
			out.println("<td height=200 colspan=7 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}
			*/
		 
		 
			if("0".equals(division))
				sql = "SELECT a.CHR_PRODUCTID,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC ,b.CHR_DIVICODE FROM inv_m_produtlist a ,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID  AND a.CHR_PTYPE !='S' ORDER BY a.CHR_PRODUCTID ";//CHR_PRODUCTCODE
			else
				sql = "SELECT a.CHR_PRODUCTID,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC ,b.CHR_DIVICODE FROM inv_m_produtlist a ,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID AND a.CHR_PTYPE !='S' AND a.INT_DIVIID= "+division+" ORDER BY a.CHR_PRODUCTID ";//CHR_PRODUCTCODE
					
			String pdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			if(pdata.length>0)
			{
			//out.println("<tr><td class='boldEleven' colspan=7 align=center> <b>Product</b> ");
			for(int u=0;u<pdata.length;u++) 
			{
				sql =" SELECT COUNT(*),sum(DOU_UNITPRICE),(sum(DOU_UNITPRICE)/COUNT(*))  FROM inv_t_vendorgoodsreceived ";
				sql = sql+"	WHERE CHR_FLAG ='N' and CHR_GRTFLAG='N'  AND CHR_SERIALNO is not null AND CHR_ITEMID='"+pdata[u][0]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;
				String count[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
				int qty = 0;
				qty=Integer.parseInt(count[0][0]);
				if(qty>0)
				{
				 if(u%2 == 0)
					out.println("<tr class='MRow1'>");
				 else
					out.println("<tr class='MRow2'>");
					rcount=rcount+1;
				 out.println("<td class='boldEleven'  valign='top'>"+(rcount)+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>Product</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+pdata[u][1]+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+pdata[u][3]+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+pdata[u][2].toUpperCase()+"</td>");
				 out.println("<td class='boldEleven'  valign='top'>"+qty+" </td>");
				 double s=0.0;
				 double s1=0;
				 s = Double.parseDouble(count[0][2]);
				 s1 = Double.parseDouble(count[0][1]);
				 out.println("<td class='boldEleven'  valign='top' align=right>"+com.my.org.erp.common.CommonFunctions.Round(s));
				 out.println("<td class='boldEleven'  valign='top' align=right>"+com.my.org.erp.common.CommonFunctions.Round((s1))); 
				 totalsum = totalsum+com.my.org.erp.common.CommonFunctions.Round((s1)); 
				} 
			}
		}
		/*else
		{
			out.println("<tr>");
			out.println("<td height=200 colspan=7 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}
		*/
		
		//consumables only	
		if("0".equals(division))		
		sql = "SELECT a.CHR_PRODUCTID,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC ,b.CHR_DIVICODE FROM inv_m_produtlist a ,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID  AND a.CHR_PTYPE ='S' ORDER BY a.CHR_PRODUCTCODE";
		else
			sql = "SELECT a.CHR_PRODUCTID,a.CHR_PRODUCTCODE,a.CHR_PRODUCTDESC ,b.CHR_DIVICODE FROM inv_m_produtlist a ,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID  AND a.CHR_PTYPE ='S' AND a.INT_DIVIID="+division+" ORDER BY CHR_PRODUCTCODE";
		String cdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		if(cdata.length>0)
		{
			out.println("<tr><td class='boldEleven' colspan=8 align=center> <b>Consumables</b> ");
			for(int u=0;u<cdata.length;u++) 
			{
				int qty = 0;
				sql= "SELECT count(*) FROM inv_t_stock WHERE CHR_ITEMID='"+cdata[u][0].trim()+"' AND CHR_TYPE='P' AND  INT_BRANCHID="+branchid;
				
    		 	if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			    {
					sql= "SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID='"+cdata[u][0].trim()+"' AND CHR_TYPE='P' AND  INT_BRANCHID="+branchid;
					String count[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 		qty=Integer.parseInt(count[0][0]);
				}	
				if(qty>0)
				{
				 	if(u%2 == 0)
						out.println("<tr class='MRow1'>");
				 	else
						out.println("<tr class='MRow2'>");
					rcount=rcount+1;	
				out.println("<td class='boldEleven'  valign='top'>"+(rcount)+"</td>");
				out.println("<td class='boldEleven'  valign='top'>Consumables</td>");
				out.println("<td class='boldEleven'  valign='top'>"+cdata[u][1].trim()+"</td>");
				out.println("<td class='boldEleven'  valign='top'>"+cdata[u][3].trim()+"</td>");
				out.println("<td class='boldEleven'  valign='top'>"+cdata[u][2].trim().toUpperCase()+"</td>");
				out.println("<td class='boldEleven'  valign='top'>"+qty+" </td>");
				
				double s=0.0;
				sql =" select COUNT(*) FROM inv_t_averageprice WHERE CHR_ITEMID='"+cdata[u][0]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;
				 
				if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
			    {
		        	sql =" select DOU_AVGPRICE FROM inv_t_averageprice WHERE CHR_ITEMID='"+cdata[u][0]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;
					String stockAverageprice[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		        	s = Double.parseDouble(stockAverageprice[0][0]);
				}
				out.println("<td class='boldEleven'  valign='top' align=right>"+com.my.org.erp.common.CommonFunctions.Round(s));
				out.println("<td class='boldEleven'  valign='top' align=right>"+com.my.org.erp.common.CommonFunctions.Round((s*qty))); 
				totalsum = totalsum+com.my.org.erp.common.CommonFunctions.Round((s*qty)); 
			  }			
			}
		}
		/*else
		{
			out.println("<tr>");
			out.println("<td height=200 colspan=8 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}*/
	 
			out.println("<tr>");
			out.println("<td colspan=7 class='boldEleven' align=right><b>Total Value  </td>");
			out.println("<td align=right class='boldEleven'  valign='top'>"+com.my.org.erp.common.CommonFunctions.Round(totalsum));
			out.println("<tr><td colspan=8 class='boldEleven' align=center>");
			%>
<div id="Rupees"><script language="javascript">
							numberWord("<%=totalsum%>","Rupees") 
						  </script></div>
<%
	out.println("</table>");
	out.print(" <br> ");
 
	  	

 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
	  	
  %>