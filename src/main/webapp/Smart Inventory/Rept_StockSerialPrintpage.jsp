<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<title>:: INVENTORY ::</title><script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
body {
	margin-left: .5cm;
	margin-top: 1cm;
	margin-right: .5px;
	margin-bottom: 1cm;
}
-->
</style>
 <%


		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String item = request.getParameter("item");
		String sql=""; 
		
		
		out.println("<center>");
		out.println(com.my.org.erp.common.CommonFunctions.QueryExecute("Select CONCAT(b.CHR_COMPANYNAME,'  @  ',a.CHR_BRANCHNAME   ) from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID="+Branch)[0][0] +"<br><br>");
		
		
		if("I".equals(itype))
		{
				sql = " SELECT b.CHR_ITEMID,b.CHR_ITEMNAME ,b.CHR_DES,  COUNT(*)  ";
				sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_item b ";
				sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_ITEMID  ";
				sql = sql+ "  AND a.CHR_TYPE='I'   AND a.CHR_FLAG='N' ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND b.INT_DIVIID="+division;
				sql = sql+ "  AND  a.INT_BRANCHID = "+Branch;
				sql = sql+ "  GROUP BY a.CHR_ITEMID ";
				sql = sql+ "  ORDER BY b.CHR_ITEMNAME ";
				
				 
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				
				out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>S.No</b></td>");
				out.println("<td class='boldEleven'><b>Type</b></td>");
				out.println("<td class='boldEleven'><b>Name</b></td>");
				out.println("<td class='boldEleven'><b>Descritpion</b></td>");
				out.println("<td class='boldEleven'><b>Total Numbers</b></td>");
				out.println("</tr>");
				 if(data.length>0)
				{
					int count=0;
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");
						out.println("<td class='boldEleven'>"+(u+1)+"</td>");
						out.println("<td class='boldEleven'>Item</td>");
						out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("</tr>");
						if(!"-".equals(data[u][3]))
							count = Integer.parseInt(data[u][3]);
						
						
						
						if(count>0)
						{
								sql = "";
								sql = sql+ "  SELECT a.CHR_TYPE,a.CHR_ITEMID  ,a.CHR_SERIALNO,a.CHR_QUALITY  ";
								sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_item b  ";
								sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_ITEMID   ";
								sql = sql+ "  AND a.CHR_TYPE='I'   AND a.CHR_FLAG='N'  ";
								sql = sql+ "  AND  a.INT_BRANCHID ="+Branch;
								sql = sql+ "  AND  a.CHR_ITEMID ='"+data[u][0]+"'";
								sql = sql+ "  ORDER BY b.CHR_ITEMNAME  ";
						
								if(u%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");
								
								
								
								out.println("<td>&nbsp;<td colspan='4' class='boldEleven'><b>Serial Numbers ::</b><br>");
								out.println("<br><table width='100%'  class='boldEleven'   border='1'   id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#ffffff' >");
								 
								 
								String sdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								 
								for(int k=0;k<sdata.length;k++)
								{
									
									if(k%5==0)
										out.println("<tr bgcolor='#ffffff'>");
									
									if(!"-".equals(sdata[k][2]))
										if("H".equals(sdata[k][3]))
											out.println("<td class='boldEleven'><font  class='tMLAscreenHead'>"+sdata[k][2]+"</font></td>");
										else
											out.println("<td class='boldEleven'>"+sdata[k][2]+"</td>");	
									
									
									 
									 
								}	
								out.println("</tr></table><br>");
								out.println("</td>");
								out.println("</tr>");
								
								
								
								 
								
						}
						
							
								
					}
					
				} 
				  out.println("</table>");
				 
		}
			
			
			
		
		
		
		
		
		//PRODUCT
		
		if("P".equals(itype))
		{
				sql = " SELECT b.CHR_PRODUCTID,b.CHR_PRODUCTCODE ,b.CHR_PRODUCTDESC,  COUNT(*)  ";
				sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_produtlist b ";
				sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_PRODUCTID  ";
				sql = sql+ "  AND a.CHR_TYPE='P'   AND a.CHR_FLAG='N' ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND b.INT_DIVIID="+division;
				sql = sql+ "  AND  a.INT_BRANCHID = "+Branch;
				sql = sql+ "  GROUP BY a.CHR_ITEMID ";
				sql = sql+ "  ORDER BY b.CHR_PRODUCTCODE ";
				
				 
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				
				out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven'><b>S.No</b></td>");
				out.println("<td class='boldEleven'><b>Type</b></td>");
				out.println("<td class='boldEleven'><b>Name</b></td>");
				out.println("<td class='boldEleven'><b>Descritpion</b></td>");
				out.println("<td class='boldEleven'><b>Total Numbers</b></td>");
				out.println("</tr>");
				 if(data.length>0)
				{
					int count=0;
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");
						out.println("<td class='boldEleven'>"+(u+1)+"</td>");
						out.println("<td class='boldEleven'>Product</td>");
						out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
						out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
						out.println("</tr>");
						if(!"-".equals(data[u][3]))
							count = Integer.parseInt(data[u][3]);
						
						
						
						if(count>0)
						{
								sql = "";
								sql = sql+ "  SELECT a.CHR_TYPE,a.CHR_ITEMID  ,a.CHR_SERIALNO,a.CHR_QUALITY  ";
								sql = sql+ "  FROM inv_t_vendorgoodsreceived  a , inv_m_produtlist b  ";
								sql = sql+ "  WHERE  a.CHR_ITEMID =b.CHR_PRODUCTID   ";
								sql = sql+ "  AND a.CHR_TYPE='P'   AND a.CHR_FLAG='N'  ";
								sql = sql+ "  AND  a.INT_BRANCHID ="+Branch;
								sql = sql+ "  AND  a.CHR_ITEMID ='"+data[u][0]+"'";
								sql = sql+ "  ORDER BY b.CHR_PRODUCTCODE  ";
						
						
						
					 
								if(u%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");
									
								out.println("<td>&nbsp;<td colspan='4' class='boldEleven'><b>Serial Numbers ::</b><br>");
								out.println("<br><table width='60%'  class='boldEleven'  id='myTable'  border='1'   cellpadding=2 cellspacing=1 bgcolor='#ffffff' >");
								 
								 
								String sdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								 
								for(int k=0;k<sdata.length;k++)
								{
									
									if(k%5==0)
										out.println("<tr bgcolor='#ffffff'>");
									
									if(!"-".equals(sdata[k][2]))
										if("H".equals(sdata[k][3]))
											out.println("<td class='boldEleven'><font  class='tMLAscreenHead'>"+sdata[k][2]+"</font></td>");
										else
											out.println("<td class='boldEleven'>"+sdata[k][2]+"</td>");	
									
									
									 
									 
								}	
								out.println("</tr></table><br>");
								out.println("</td>");
								out.println("</tr>");
								
						}
						
							
								
					}
					
				} 
				  out.println("</table>");
				 
		}
		

		 
			 
	%>