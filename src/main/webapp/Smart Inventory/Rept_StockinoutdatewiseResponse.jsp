<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >
 <%@ include file="indexinv.jsp"%>
<div>
<%
	try
	{
		double sum=0.0;
		String branchid = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String item = request.getParameter("item");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		fromdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
		todate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
		
		
		
					
		String sql ="";
		String cpydata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT b.CHR_COMPANYNAME ,a.CHR_BRANCHNAME FROM com_m_branch a,com_m_company b WHERE a.INT_COMPANYID=b.INT_COMPANYID AND a.INT_BRANCHID="+branchid);
		
		
		int open1=0;
		double open1value=0;
		int open2=0;
		double open2value=0;
		int open=0;
		double openvalue=0;
		int in=0;
		double invalue=0;
		int outs=0;
		double outvalue=0;
		int balance=0;
		double balancevalue=0;
		
		
		if("1".equals(itype))
		{
			sql = "SELECT CHR_ITEMID,CHR_ITEMNAME,CHR_DES FROM inv_m_item ";
			if(!"0".equals(item))
				sql = sql + " WHERE  CHR_ITEMID='"+item+"'";
			sql = sql + " ORDER BY CHR_ITEMID ";
			String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
			out.println("<br><br><br>");
			out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td colspan=15 class='boldEleven' align=center><b>STOCK IN AND OUT  FOR "+cpydata[0][0].toUpperCase()+" @ "+cpydata[0][1].toUpperCase()+"</b></td>");
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td class='boldEleven'><b>S.NO </td>");
			out.println("<td class='boldEleven'><b>TYPE</td>");
			out.println("<td class='boldEleven'><b>ITEM / PRODUCT CODE</td>");
			out.println("<td class='boldEleven'><b>DESCRIPTION</td>");
			out.println("<td class='boldEleven'><b>OPEN</td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("<td class='boldEleven'><b>IN </td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("<td class='boldEleven'><b>OUT</td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("<td class='boldEleven'><b>BALANCE</td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			 
			out.println("</tr>");
			int row=0;
			 
			if(data.length>0)
			{
				
				
				 for(int u=0;u<data.length;u++)
				{
						
						open1=0;
						open1value=0;
						open2=0;
						open2value=0;
						open=0;
						openvalue=0;
						in=0;
						invalue=0;
 					    outs=0;
						outvalue=0;
						balance=0;
						balancevalue=0;
							
						sql = "";
						sql = sql +" SELECT    b.CHR_ITEMNAME,b.CHR_DES, ";
						sql = sql +" (SELECT count(*) ";
						sql = sql +" FROM inv_t_vendorgoodsreceived ka  "; 
						sql = sql +" WHERE ka.CHR_FLAG !='Y'  AND ka.CHR_SERIALNO is not null   ";
						sql = sql +" AND ka.CHR_ITEMID=b.CHR_ITEMID	 "; 
						sql = sql +" AND ka.CHR_TYPE='I'  ";
						sql = sql +" AND ka.INT_BRANCHID=z.INT_BRANCHID  ";
						sql = sql +" AND ka.DAT_RECIVEDDATE < '"+fromdate+"' ), ";
						
						sql = sql +" (SELECT  SUM(ka1.DOU_UNITPRICE)  ";
						sql = sql +"  FROM inv_t_vendorgoodsreceived ka1   "; 
						sql = sql +" WHERE ka1.CHR_FLAG !='Y'  AND ka1.CHR_SERIALNO is not null    ";
						sql = sql +" AND ka1.CHR_ITEMID=b.CHR_ITEMID	   ";
						sql = sql +" AND ka1.CHR_TYPE='I'   ";
						sql = sql +" AND ka1.INT_BRANCHID=z.INT_BRANCHID   ";
						sql = sql +" AND ka1.DAT_RECIVEDDATE < '"+fromdate+"' ),  ";
						
						sql = sql +" (SELECT count(*)  ";
						sql = sql +" FROM inv_t_vendorgoodsreceived ka2   "; 
						sql = sql +" WHERE ka2.CHR_FLAG ='Y'  AND ka2.CHR_SERIALNO is not null   "; 
						sql = sql +" AND ka2.CHR_ITEMID=b.CHR_ITEMID	   ";
						sql = sql +" AND ka2.CHR_TYPE='I'   ";
						sql = sql +"  AND ka2.INT_BRANCHID=z.INT_BRANCHID   ";
						sql = sql +"  AND ka2.DAT_RECIVEDDATE < '"+fromdate+"'  ";
						sql = sql +" AND ka2.DT_SALEDATE >='"+fromdate+"'  ";
						sql = sql +" ),  ";
						
						sql = sql +" (SELECT SUM(ka3.DOU_UNITPRICE)  ";
						sql = sql +"  FROM inv_t_vendorgoodsreceived ka3    ";
						sql = sql +" WHERE ka3.CHR_FLAG ='Y'  AND ka3.CHR_SERIALNO is not null   "; 
						sql = sql +" AND ka3.CHR_ITEMID=b.CHR_ITEMID	   ";
						sql = sql +" AND ka3.CHR_TYPE='I'   ";
						sql = sql +"  AND ka3.INT_BRANCHID=z.INT_BRANCHID   ";
						sql = sql +"  AND ka3.DAT_RECIVEDDATE < '"+fromdate+"'  ";
						sql = sql +"  AND ka3.DT_SALEDATE >='"+fromdate+"'  ";
						sql = sql +"  ),  ";
						
						sql = sql +" (SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  c	  ";
						sql = sql +" WHERE  c.CHR_SERIALNO is not null   ";
						sql = sql +" AND c.CHR_ITEMID=b.CHR_ITEMID  AND c.CHR_TYPE='I'  ";
						sql = sql +"  AND c.INT_BRANCHID=z.INT_BRANCHID  "; 
						sql = sql +" AND c.DAT_RECIVEDDATE >='"+fromdate+"'   ";
						sql = sql +" AND c.DAT_RECIVEDDATE <='"+todate+"') ,  ";
												
						sql = sql +" (SELECT  SUM(c1.DOU_UNITPRICE)  FROM inv_t_vendorgoodsreceived  c1	  ";
						sql = sql +" WHERE  c1.CHR_SERIALNO is not null   ";
						sql = sql +" AND c1.CHR_ITEMID=b.CHR_ITEMID    ";
						sql = sql +" AND c1.CHR_TYPE='I' AND c1.INT_BRANCHID=z.INT_BRANCHID   ";
						sql = sql +" AND c1.DAT_RECIVEDDATE >='"+fromdate+"'   ";
						sql = sql +" AND c1.DAT_RECIVEDDATE <='"+todate+"') ,  ";
						
						sql = sql +" (SELECT COUNT(*) FROM inv_t_vendorgoodsreceived d  ";
						sql = sql +" WHERE d.CHR_FLAG ='Y'  AND d.CHR_SERIALNO is not null    ";
						sql = sql +" AND d.CHR_ITEMID=b.CHR_ITEMID   ";
						sql = sql +" AND d.CHR_TYPE='I' AND d.INT_BRANCHID=z.INT_BRANCHID  ";
						sql = sql +" AND d.DT_SALEDATE >='"+fromdate+"'  ";
						sql = sql +"  AND d.DT_SALEDATE <='"+todate+"'),     ";
												
						sql = sql +" (SELECT SUM(d1.DOU_UNITPRICE) FROM inv_t_vendorgoodsreceived d1 WHERE d1.CHR_FLAG ='Y'  AND d1.CHR_SERIALNO is not null    "; 
						sql = sql +" AND d1.CHR_ITEMID=b.CHR_ITEMID AND d1.CHR_TYPE='I' AND d1.INT_BRANCHID=z.INT_BRANCHID  ";
						sql = sql +" AND d1.DT_SALEDATE >='"+fromdate+"' AND d1.DT_SALEDATE <='"+todate+"')   ";
						
						
						sql = sql +" FROM inv_m_item b , com_m_branch z  ";
						sql = sql +" WHERE z.INT_BRANCHID="+branchid+"  AND b.CHR_ITEMID='"+data[u][0]+"';  ";
						//out.println(sql);
						String repdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						 if(repdata.length>0)
						{
							
							 if  (   !"-".equals(repdata[0][2]) )  
									open1=Integer.parseInt(repdata[0][2]);
							  if (   !"-".equals(repdata[0][3]) )  
									open1value=Double.parseDouble(repdata[0][3]);
							  
							 
							  if( !"-".equals(repdata[0][4])   )
									open2=Integer.parseInt(repdata[0][4]);
							  if( !"-".equals(repdata[0][5]))  
									open2value=Double.parseDouble(repdata[0][5]);
							  
							   
							  open= open1+open2;
							  openvalue= open1value+open2value;
							  
							  if( !"-".equals(repdata[0][6])    )
									in=Integer.parseInt(repdata[0][6]);
							  if( !"-".equals(repdata[0][7]))  
									invalue=Double.parseDouble(repdata[0][7]);
							  
							  if( !"-".equals(repdata[0][8])   )
									outs=Integer.parseInt(repdata[0][8]);
							  if( !"-".equals(repdata[0][9])    )
									outvalue=Double.parseDouble(repdata[0][9]);
							  
							   
							  balance= (open1+open2+in)-outs;
							  balancevalue= (open1value+open2value+invalue)-outvalue; 
							
								row=row+1;
								if(row%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");
								
								out.println("<td class='boldEleven'>"+row+"</td>");
								out.println("<td class='boldEleven'>ITEM</td>");
								out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
								out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
								out.println("<td class='boldEleven' align='right'>"+open +"</td>");
								out.println("<td class='boldEleven' align='right'>"+openvalue+"</td>");
								out.println("<td class='boldEleven' align='right'>"+in+"</td>");
								out.println("<td class='boldEleven' align='right'>"+invalue+"</td>");
								out.println("<td class='boldEleven' align='right'>"+outs+"</td>");
								out.println("<td class='boldEleven' align='right'>"+outvalue+"</td>");
								out.println("<td class='boldEleven' align='right'>"+balance+"</td>");
								out.println("<td class='boldEleven' align='right'>"+balancevalue+"</td>");
								out.println("</tr>");
							
						} 
						 
					} 
	
				}
				
			out.println("</table>");	
		}
			
		
		
		
		 
		
		
		
		
		
		
		
		
		
		
		
		
		//PRODUCT  
		if("2".equals(itype))
		{
		
			sql = "SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PRODUCTDESC FROM inv_m_produtlist  WHERE CHR_PTYPE !='S' ";
			if(!"0".equals(item))
				sql = sql + " AND   CHR_PRODUCTID='"+item+"'";
			sql = sql + " ORDER BY CHR_PRODUCTCODE";
			
			String pdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			
			out.println("<br><br><br>");
			out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td colspan=15 class='boldEleven' align=center><b>STOCK IN AND OUT  FOR "+cpydata[0][0].toUpperCase()+" @ "+cpydata[0][1].toUpperCase()+"</b></td>");
			out.println("<tr  bgcolor='#ffffff'>");
			out.println("<td class='boldEleven'><b>S.NO </td>");
			out.println("<td class='boldEleven'><b>TYPE</td>");
			out.println("<td class='boldEleven'><b>ITEM / PRODUCT CODE</td>");
			out.println("<td class='boldEleven'><b>DESCRIPTION</td>");
			out.println("<td class='boldEleven'><b>OPEN</td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("<td class='boldEleven'><b>IN </td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("<td class='boldEleven'><b>OUT</td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("<td class='boldEleven'><b>BALANCE</td>");
			out.println("<td class='boldEleven'><b>VALUE</td>");
			out.println("</tr>");
			int row=0;
			if(pdata.length>0)
			{
				for(int u=0;u<pdata.length;u++) 
				{
					 
				  open1=0;
				  open1value=0;
				  open2=0;
				  open2value=0;
				  open=0;
				  openvalue=0;
				  in=0;
				  invalue=0;
				  outs=0;
				  outvalue=0;
				  balance=0;
				  balancevalue=0;
					
					sql = "";
					sql = sql +" SELECT    b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC, ";
					sql = sql +" (SELECT count(*) ";
					sql = sql +" FROM inv_t_vendorgoodsreceived ka  "; 
					sql = sql +" WHERE ka.CHR_FLAG !='Y'  AND ka.CHR_SERIALNO is not null   ";
					sql = sql +" AND ka.CHR_ITEMID=b.CHR_PRODUCTID	 "; 
					sql = sql +" AND ka.CHR_TYPE='P'  ";
					sql = sql +" AND ka.INT_BRANCHID=z.INT_BRANCHID  ";
					sql = sql +" AND ka.DAT_RECIVEDDATE < '"+fromdate+"' ), ";
					
					sql = sql +" (SELECT  SUM(ka1.DOU_UNITPRICE)  ";
					sql = sql +"  FROM inv_t_vendorgoodsreceived ka1   "; 
					sql = sql +" WHERE ka1.CHR_FLAG !='Y'  AND ka1.CHR_SERIALNO is not null    ";
					sql = sql +" AND ka1.CHR_ITEMID=b.CHR_PRODUCTID	   ";
					sql = sql +" AND ka1.CHR_TYPE='P'   ";
					sql = sql +" AND ka1.INT_BRANCHID=z.INT_BRANCHID   ";
					sql = sql +" AND ka1.DAT_RECIVEDDATE < '"+fromdate+"' ),  ";
					
					sql = sql +" (SELECT count(*)  ";
					sql = sql +" FROM inv_t_vendorgoodsreceived ka2   "; 
					sql = sql +" WHERE ka2.CHR_FLAG ='Y'  AND ka2.CHR_SERIALNO is not null   "; 
					sql = sql +" AND ka2.CHR_ITEMID=b.CHR_PRODUCTID	   ";
					sql = sql +" AND ka2.CHR_TYPE='P'   ";
					sql = sql +"  AND ka2.INT_BRANCHID=z.INT_BRANCHID   ";
					sql = sql +"  AND ka2.DAT_RECIVEDDATE < '"+fromdate+"'  ";
					sql = sql +" AND ka2.DT_SALEDATE >='"+fromdate+"'  ";
					sql = sql +" ),  ";
					
					sql = sql +" (SELECT SUM(ka3.DOU_UNITPRICE)  ";
					sql = sql +"  FROM inv_t_vendorgoodsreceived ka3    ";
					sql = sql +" WHERE ka3.CHR_FLAG ='Y'  AND ka3.CHR_SERIALNO is not null   "; 
					sql = sql +" AND ka3.CHR_ITEMID=b.CHR_PRODUCTID	   ";
					sql = sql +" AND ka3.CHR_TYPE='P'   ";
					sql = sql +"  AND ka3.INT_BRANCHID=z.INT_BRANCHID   ";
					sql = sql +"  AND ka3.DAT_RECIVEDDATE < '"+fromdate+"'  ";
					sql = sql +"  AND ka3.DT_SALEDATE >='"+fromdate+"'  ";
					sql = sql +"  ),  ";
					
					sql = sql +" (SELECT COUNT(*) FROM inv_t_vendorgoodsreceived  c	  ";
					sql = sql +" WHERE  c.CHR_SERIALNO is not null   ";
					sql = sql +" AND c.CHR_ITEMID=b.CHR_PRODUCTID  AND c.CHR_TYPE='P'  ";
					sql = sql +"  AND c.INT_BRANCHID=z.INT_BRANCHID  "; 
					sql = sql +" AND c.DAT_RECIVEDDATE >='"+fromdate+"'   ";
					sql = sql +" AND c.DAT_RECIVEDDATE <='"+todate+"') ,  ";
											
					sql = sql +" (SELECT  SUM(c1.DOU_UNITPRICE)  FROM inv_t_vendorgoodsreceived  c1	  ";
					sql = sql +" WHERE  c1.CHR_SERIALNO is not null   ";
					sql = sql +" AND c1.CHR_ITEMID=b.CHR_PRODUCTID    ";
					sql = sql +" AND c1.CHR_TYPE='P' AND c1.INT_BRANCHID=z.INT_BRANCHID   ";
					sql = sql +" AND c1.DAT_RECIVEDDATE >='"+fromdate+"'   ";
					sql = sql +" AND c1.DAT_RECIVEDDATE <='"+todate+"') ,  ";
					
					sql = sql +" (SELECT COUNT(*) FROM inv_t_vendorgoodsreceived d  ";
					sql = sql +" WHERE d.CHR_FLAG ='Y'  AND d.CHR_SERIALNO is not null    ";
					sql = sql +" AND d.CHR_ITEMID=b.CHR_PRODUCTID   ";
					sql = sql +" AND d.CHR_TYPE='P' AND d.INT_BRANCHID=z.INT_BRANCHID  ";
					sql = sql +" AND d.DT_SALEDATE >='"+fromdate+"'  ";
					sql = sql +"  AND d.DT_SALEDATE <='"+todate+"'),     ";
											
					sql = sql +" (SELECT SUM(d1.DOU_UNITPRICE) FROM inv_t_vendorgoodsreceived d1 WHERE d1.CHR_FLAG ='Y'  AND d1.CHR_SERIALNO is not null    "; 
					sql = sql +" AND d1.CHR_ITEMID=b.CHR_PRODUCTID AND d1.CHR_TYPE='P' AND d1.INT_BRANCHID=z.INT_BRANCHID  ";
					sql = sql +" AND d1.DT_SALEDATE >='"+fromdate+"' AND d1.DT_SALEDATE <='"+todate+"')   ";
					
					
					sql = sql +" FROM inv_m_produtlist b , com_m_branch z  ";
					sql = sql +" WHERE z.INT_BRANCHID="+branchid+"  AND b.CHR_PRODUCTID='"+pdata[u][0]+"';  ";
					//out.println(sql);
					String repdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					if(repdata.length>0)
					{
						
						 if  (   !"-".equals(repdata[0][2]) )  
						   		open1=Integer.parseInt(repdata[0][2]);
						  if (   !"-".equals(repdata[0][3]) )  
						  		open1value=Double.parseDouble(repdata[0][3]);
						  
						 
						  if( !"-".equals(repdata[0][4])   )
						  		open2=Integer.parseInt(repdata[0][4]);
						  if( !"-".equals(repdata[0][5]))  
						  		open2value=Double.parseDouble(repdata[0][5]);
						  
						   
						  open= open1+open2;
						  openvalue= open1value+open2value;
						  
						  if( !"-".equals(repdata[0][6])    )
						  		in=Integer.parseInt(repdata[0][6]);
						  if( !"-".equals(repdata[0][7]))  
						  		invalue=Double.parseDouble(repdata[0][7]);
						  
						  if( !"-".equals(repdata[0][8])   )
						 		outs=Integer.parseInt(repdata[0][8]);
						  if( !"-".equals(repdata[0][9])    )
						  		outvalue=Double.parseDouble(repdata[0][9]);
						  
						   
						  balance= (open1+open2+in)-outs;
						  balancevalue= (open1value+open2value+invalue)-outvalue; 
						
							row=row+1;
							if(row%2==0)
								out.println("<tr class='MRow1'>");
							else
								out.println("<tr class='MRow2'>");
							
							out.println("<td class='boldEleven'>"+row+"</td>");
							out.println("<td class='boldEleven'>PRODUCT</td>");
							out.println("<td class='boldEleven'>"+pdata[u][0]+"</td>");
							out.println("<td class='boldEleven'>"+pdata[u][1]+"</td>");
							out.println("<td class='boldEleven' align='right'>"+open +"</td>");
							out.println("<td class='boldEleven' align='right'>"+openvalue+"</td>");
							out.println("<td class='boldEleven' align='right'>"+in+"</td>");
							out.println("<td class='boldEleven' align='right'>"+invalue+"</td>");
							out.println("<td class='boldEleven' align='right'>"+outs+"</td>");
							out.println("<td class='boldEleven' align='right'>"+outvalue+"</td>");
							out.println("<td class='boldEleven' align='right'>"+balance+"</td>");
							out.println("<td class='boldEleven' align='right'>"+balancevalue+"</td>");
							out.println("</tr>");
					 	
					} 
				}
			}
			out.println("</table>");	
		}
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
	  	
  %>
<table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('StockInandOut.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('StockInandOut.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('StockInandOut.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<!--<td class="boldEleven">
		<div align="center"><a
			href="javascript:Print('StockInandOutPrintpage.jsp')"><img
			src="../Image/report/print.gif" width="16" height="16" border="0"></a></div>
		</td>-->
	</tr>
</table>

<p>&nbsp;</p>
<table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
  <tr>
    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
  </tr>
</table>
<p>
  <%
/*sql = "  SELECT  b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,a.CHR_PURCHASEORDERNO,a.CHR_SERIALNO FROM inv_t_vendorgoodsreceived  a ,inv_m_produtlist b	  WHERE  a.CHR_ITEMID = b.CHR_PRODUCTID  AND a.CHR_SERIALNO is not null";
					sql = sql + " AND a.CHR_ITEMID='"+pdata[u][0]+"' AND a.CHR_TYPE='P' AND a.INT_BRANCHID="+branchid+" AND a.DAT_RECIVEDDATE >='"+fromdate+"' AND a.DAT_RECIVEDDATE <='"+todate+"'  "; 
					     out.println("<td class='boldEleven' align='right'><a href=\"Rept_stockinandoutdetailedview.jsp?type=P&inout=IN&sql="+sql+"\"  target='_blank'>"+repdata[0][1]+"</a></td>");
							sql =  "  SELECT   b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,a.CHR_SALESNO,a.CHR_SERIALNO FROM inv_t_vendorgoodsreceived  a ,inv_m_produtlist b  WHERE  a.CHR_ITEMID = b.CHR_PRODUCTID  AND a.CHR_FLAG ='Y'  AND  a.CHR_SERIALNO is not null ";
					sql = sql + " AND  a.CHR_ITEMID='"+pdata[u][0]+"' AND  a.CHR_TYPE='P' AND  a.INT_BRANCHID="+branchid+" AND  a.DAT_RECIVEDDATE >='"+fromdate+"' AND  a.DAT_RECIVEDDATE <='"+todate+"'  ";
					
						    out.println("<td class='boldEleven' align='right'><a href=\"Rept_stockinandoutdetailedview.jsp?type=P&inout=OUT&sql="+sql+"\" target='_blank'>"+repdata[0][2]+"</a></td>");
							*/
							
							
		%>					
</p>
<p>
  <%@ include file="../footer.jsp"%>
</p>
<p>&nbsp;</p>
 <p>&nbsp;</p>
</body>
</html>
