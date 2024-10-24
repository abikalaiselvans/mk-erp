  <%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >

<%@ include file="indexinv.jsp"%>

<%
	try
	{
		java.text.NumberFormat formatter = java.text.NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(2);
   		formatter.setMinimumFractionDigits(2); 
		String branchid = session.getAttribute("BRANCHID").toString();
				
		out.print("<br><br><br>");
		String dt = ""+request.getParameter("dt");
		String dt2 = request.getParameter("dt2");
		String sql = ""+request.getParameter("sql");
		String division = ""+request.getParameter("division");
		String ref = ""+request.getParameter("ref");
		String custid=request.getParameter("customer");
		String detail=request.getParameter("detail");
		String type=request.getParameter("type");
		String Branch=request.getParameter("Branch");
		 
			
		String refid="";
		String div ="";
		String cust ="";
		 
		out.println("<table width=90%  id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td colspan=11 class='boldEleven' align=center><b>SALES ON  :: ("+dt +" to " +dt2+" )</b></td>");
		 
		out.println("<tr  bgcolor='#ffffff'><td class='boldEleven'><b>S. No </td>");
		out.println("<td class='boldEleven'  ><b>Invoice No</td>");
		out.println("<td class='boldEleven'><b>Company </td>");
		out.println("<td class='boldEleven'><b>Branch </td>");
		out.println("<td class='boldEleven'><b>Division </td>");
		out.println("<td class='boldEleven'><b>Customer </td>");
		out.println("<td class='boldEleven'><b>Marketing Executives </td>");
		out.println("<td class='boldEleven'><b>Payment</td>");
		out.println("<td class='boldEleven' ><b>Sales date</td>");
		out.println("<td class='boldEleven' ><b>Amount </td>");
		out.println("<td class='boldEleven' ><b>Amount with Tax</td>");
		out.println("</tr>");
		 
		 
		
		if(("1".equals(type)) || ("0".equals(type) ))
		{
			 
				
		sql = " SELECT a.CHR_SALESNO,a.DOU_TOTALAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.INT_PAYMENTTERMID,a.CHR_PAYMENTSTATUS,";
		sql = sql + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_directsales  a ,inv_m_customerinfo b ,com_m_staff c  ,com_m_branch d ,com_m_company e, inv_m_division f";
		sql = sql + "  WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID AND a.DAT_SALESDATE >= '"+dt+"' ";
		sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' ";
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID="+division ;
		if(!"0".equals(custid))
			sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
		if(!"0".equals(ref))
			sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
		if(!"0".equals(Branch))
			sql = sql + "  AND a.INT_BRANCHID="+Branch ;
		
		sql = sql + "  AND a.INT_SALESSTATUS=1 AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
		sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
		
		//out.println(sql);
		//AND a.INT_BRANCHID="+branchid+"
		out.println("<tr  bgcolor='#ffffff'><td colspan=11 class='boldEleven' align=center><b>DIRECT SALES </b></td>");
		
			String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);		 
			if(data.length>0)
			{
				double sum=0.0;
				double totalsum=0.0;
				double pprice=0.0;
				double ssum=0.0;	
				
				for(int u=0;u<data.length;u++) 
				{
					String salesno = data[u][0];
					String salesdt = data[u][2];
					pprice=0.0; 
					pprice= Double.parseDouble(data[u][1]);	
					sum = sum+pprice;
					ssum = ssum+Double.parseDouble(data[u][7]);	
					if("Y".equals(detail))
					{
				
						sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT, DOU_UNITDISCOUNT,DOU_TOTAL";
						sql = sql +"  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
						String iname="";
						String itemname="";
						String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						out.println("<tr bgcolor='#ffffff'> <td colspan=11>&nbsp;");
						out.println("<center><table   width='900' border=0   cellpadding=2 cellspacing=1 bgcolor='#9900CC' ><tr  bgcolor='#ffffff'><td colspan=5 class='boldEleven' align=center   ><b>Invoice No  ::  "+salesno  +" Dated on "+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(salesdt));
						out.println("<tr   bgcolor='#ffffff'><td class='boldEleven'><b>Sales No </td>");
						out.println("<td class='boldEleven'><b>Type</td>");
						out.println("<td class='boldEleven'><b>Item / Product Code</td>");
						out.println("<td class='boldEleven' align=right><b>Quantity</td>");
						out.println("<td class='boldEleven' align=right><b>Unitprice  </td>");
			
						for(int v=0;v<datas.length;v++)
						{
							if(datas[v][2].equals("I"))
							{
								iname="Item";
								sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							}	
							if(datas[v][2].equals("P"))
							{
								iname="Product";
							sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
								itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							}
					
							out.println("<tr bgcolor='#ffffff'><td class='boldEleven'>"+salesno+"</td>");
							out.println("<td class='boldEleven'>"+iname+"</td>");
							out.println("<td class='boldEleven'>"+itemname+"</td>");
							out.println("<td class='boldEleven' align=right>"+datas[v][3]+"</td>");
							out.println("<td class='boldEleven' align=right>"+datas[v][4]+"</td>");
					}
					out.print("<tr  bgcolor='#ffFFFF'><td colspan=4 class='boldgreen' align=right><b>Total  : ");
					out.print("<td  align=right class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.Round(pprice));
					out.println("</table></center>");
				
				}	
				else
				{
					out.print("<tr  bgcolor='#ffffff'><td class='boldEleven' > "+(u+1));
					out.print("<td  class='boldEleven' width='200' ><a href='SwapSaleSerialView.jsp?salno="+salesno+"' target=_blank > "+salesno+"</a>");
					
					out.print("<td  class='boldEleven' > "+data[u][8]);
					out.print("<td  class='boldEleven' > "+data[u][9]);
					out.print("<td  class='boldEleven' > "+data[u][10]);
					out.print("<td  class='boldEleven' > "+data[u][3]);
					out.print("<td  class='boldEleven' > "+data[u][6]);
					
				if("N".equals(data[u][5]))
					out.print("<td   width=200  class='boldEleven' > Payment Pending");
				else
					out.print("<td  width=200 class='boldEleven' > Payment Completed");	
			
				out.print("<td  class='boldEleven' width=120 align=right>"+(salesdt));
				out.print("<td  align=right class='boldEleven'>"+data[u][7]);
				out.print("<td  align=right class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.Round(pprice));
			
				}
				
				 
			}
			out.println("<tr bgcolor='#ffffff'><td colspan=9 class='boldEleven' align=right><b>Total :</td>");
			out.println("<td align=right class='boldEleven'><b>"+com.my.org.erp.common.CommonFunctions.Round(ssum));
			out.println("<td align=right class='boldEleven'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum));
			out.println("<tr bgcolor='#ffffff'><td colspan=11 class='boldEleven' align=center>");
		%>
		<div id="Rupees1"><script language="javascript">	numberWord("<%=sum%>","Rupees1") </script></div>
		<%
		}
		else
		{
			out.println("<tr bgcolor='#ffffff'>");
			out.println("<td height=200 colspan=11 class='errorMessage' align=center ><center>Data not found ....</center></td>");
		}
			
		}
		
		
		
		
		
		
		
		
		
		//Direct Billing
		if(("0".equals(type)) || ("2".equals(type)))
		{
			 
			div="";
			cust="";
			Branch=request.getParameter("Branch");;
					
			sql = " SELECT a.CHR_SALESNO,a.DOU_NETAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_PAYMENTSTATUS,";
			sql = sql + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME ,f.CHR_DIVICODE FROM inv_t_directbilling  a ,inv_m_customerinfo b ,com_m_staff c   ";
			sql = sql + " ,com_m_branch d ,com_m_company e,inv_m_division f  WHERE a.INT_BRANCHID = d.INT_BRANCHID  AND a.INT_DIVIID=f.INT_DIVIID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.DAT_SALESDATE >= '"+dt+"' ";
			sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' ";
			
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID="+division ;
			if(!"0".equals(custid))
				sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
			if(!"0".equals(ref))
				sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
			if(!"0".equals(Branch))
				sql = sql + "  AND a.INT_BRANCHID="+Branch ;
			
			
			sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
			sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
			//AND a.INT_BRANCHID="+branchid+"  
			 
			out.println("<tr  bgcolor='#ffffff'><td colspan=11 class='boldEleven' align=center><b>DIRECT BILLING </b></td>");
			
			String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);		 
			if(data.length>0)
			{
				double pprice=0.0;
				double sum=0.0;
				double ssum=0.0;
				for(int u=0;u<data.length;u++)
				{
					String salesno = data[u][0];
					String salesdt = data[u][2];
					pprice=0.0; 
					pprice= Double.parseDouble(data[u][1]);	
					sum = sum+pprice;
					ssum = ssum+Double.parseDouble(data[u][6]);	
					out.print("<tr  bgcolor='#ffffff'><td class='boldEleven' > "+(u+1));
					out.print("<td  class='boldEleven' width='200' ><a href='SwapSaleSerialView.jsp?salno="+salesno+"' target=_blank > "+salesno+"</a>");
					out.print("<td  class='boldEleven' > "+data[u][7]);
					out.print("<td  class='boldEleven' > "+data[u][8]);
					out.print("<td  class='boldEleven' > "+data[u][9]);
					out.print("<td  class='boldEleven' > "+data[u][3]);
					out.print("<td  class='boldEleven' > "+data[u][5]);
					out.print("<td  width=200 class='boldEleven' >&nbsp;");	
			
					out.print("<td  class='boldEleven' width=120 align=right>"+(salesdt));
					out.print("<td  align=right class='boldEleven'>"+data[u][6]);
					out.print("<td  align=right class='boldEleven'>"+data[u][1]);
					//out.print("<td  align=right class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.Round(pprice));
				}
				out.println("<tr bgcolor='#ffffff'><td colspan=9 class='boldEleven' align=right><b>Total :</td>");
			out.println("<td align=right class='boldEleven'><b>"+com.my.org.erp.common.CommonFunctions.Round(ssum));
			out.println("<td align=right class='boldEleven'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum));
			out.println("<tr bgcolor='#ffffff'><td colspan=11 class='boldEleven' align=center>");
		%>
		<div id="Rupees2"><script language="javascript">	numberWord("<%=sum%>","Rupees2") </script></div>
		<%							
			}
		}
		
		
		
		
					
		
		//Service Billing
		if(("3".equals(type) )|| ("0".equals(type)))
		{
			div="";
			cust="";
			Branch=request.getParameter("Branch");;
			 		
			sql = " SELECT a.CHR_SALESNO,a.DOU_NETAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_PAYMENTSTATUS,";
			sql = sql + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_servicebilling  a ,inv_m_customerinfo b ,com_m_staff c,com_m_branch d ,com_m_company e ,inv_m_division f ";
			sql = sql + "WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID  AND a.DAT_SALESDATE >='"+dt+"' ";
			sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' " ;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID="+division ;
			if(!"0".equals(custid))
				sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
			if(!"0".equals(ref))
				sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
			if(!"0".equals(Branch))
				sql = sql + "  AND a.INT_BRANCHID="+Branch ;
			
			 
			sql = sql + "  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
			sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
			//AND a.INT_BRANCHID="+branchid+"   
			out.println("<tr  bgcolor='#ffffff'><td colspan=11 class='boldEleven' align=center><b>SERVICE BILLING </b></td>");
			
			String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);		 
			if(data.length>0)
			{
				double pprice=0.0;
				double sum=0.0;
				double ssum=0.0;
				for(int u=0;u<data.length;u++)
				{
					String salesno = data[u][0];
					String salesdt = data[u][2];
					pprice=0.0; 
					pprice= Double.parseDouble(data[u][1]);	
					sum = sum+pprice;
					ssum = ssum+Double.parseDouble(data[u][6]);	
					out.print("<tr  bgcolor='#ffffff'><td class='boldEleven' > "+(u+1));
					out.print("<td  class='boldEleven' width='200' ><a href='SwapSaleSerialView.jsp?salno="+salesno+"' target=_blank > "+salesno+"</a>");
					
					out.print("<td  class='boldEleven' > "+data[u][7]);
					out.print("<td  class='boldEleven' > "+data[u][8]);
					out.print("<td  class='boldEleven' > "+data[u][9]);
					out.print("<td  class='boldEleven' > "+data[u][3]);
					out.print("<td  class='boldEleven' > "+data[u][5]);
					out.print("<td  width=200 class='boldEleven' >&nbsp;");	
					out.print("<td  class='boldEleven' width=120 align=right>"+(salesdt));
					out.print("<td  align=right class='boldEleven'>"+data[u][6]);
					out.print("<td  align=right class='boldEleven'>"+data[u][1]);
					//out.print("<td  align=right class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.Round(pprice));
			 
				}	
				out.println("<tr bgcolor='#ffffff'><td colspan='9' class='boldEleven' align=right><b>Total :</td>");
				out.println("<td align=right class='boldEleven'><b>"+com.my.org.erp.common.CommonFunctions.Round(ssum));
				out.println("<td align=right class='boldEleven'><b>"+com.my.org.erp.common.CommonFunctions.Round(sum));
				out.println("<tr bgcolor='#ffffff'><td colspan=11 class='boldEleven' align=center>");
				
		%>
		<div id="Rupees3"><script language="javascript">numberWord("<%=sum%>","Rupees3") </script></div>
		<%						
			}
		}
		
		out.println("</table>");
	}
	catch(Exception e)
	{
		
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
			onClick="windowSave('sample.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('sample.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('sample.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a
			href="javascript:window.close()">Close</a></div>
		</td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
