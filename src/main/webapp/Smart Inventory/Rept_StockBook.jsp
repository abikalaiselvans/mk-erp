<%@ page import="java.io.*,java.util.*,DBConnection.DBCon" errorPage="../error/index.jsp"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body >
<script language="javascript">
 function Print(query)
	{
		var width="600", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
  		var styleStr = 'menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}
	
</script>
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<%
	try
	{
	String usertype=""+session.getAttribute("USRTYPE");
	String branchid = ""+session.getAttribute("BRANCHID");
	String cpyshortname = ""+session.getAttribute("COMPANYSHORTNAME");
	
	if(!"F".equals(usertype))
		response.sendRedirect("InventoryMain.jsp");
		
	String sql="";
	sql=" select day(now()),monthname(now()),year(now()) ";
	String daydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	int d = Integer.parseInt(daydata[0][0]);
	String month=daydata[0][1];
	String year=daydata[0][2];
	if(d>=29)
	{
	
	sql="Select d.CHR_SHORTNAME ,c.CHR_BRANCHNAME ,c.INT_BRANCHID from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND  d.CHR_SHORTNAME='"+cpyshortname+"' ";
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql = "SELECT CHR_ITEMID ,CHR_ITEMNAME,CHR_DES FROM inv_m_item  ORDER BY CHR_ITEMNAME ";
	String itemdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql="SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PTYPE<>'S' ORDER BY CHR_PRODUCTCODE ";
	String productdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql="SELECT CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PTYPE ='S' ORDER BY CHR_PRODUCTCODE ";
	String consumabledata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 
	int column = data.length;
	String stockbooksql="";
	String stockbooksql1="";
	String value="0";
	if(data.length>0) 
	{
		Connection co1=null;	
		DBCon con1 = new DBCon();
		co1 = con1.getConnection();
		Statement st1 = co1.createStatement();
		stockbooksql =" DELETE FROM inv_t_stockbook WHERE CHR_MONTH='"+month+"' AND INT_YEAR = "+year;
		st1.executeQuery(stockbooksql);
		stockbooksql ="";		
		out.println("<center><table cellpadding=2 cellspacing=1 bgcolor='#9900CC' id='myTable'><tr bgcolor='#ffffff'>");
		out.println("<td colspan="+(column+4)+" class='boldEleven'><center><h3>Stock Book</h3></center>");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven'><b>S.NO");
		out.println("<td class='boldEleven'><b>Type");
		out.println("<td class='boldEleven'><b>Item / Product");
		out.println("<td class='boldEleven'><b>Description");
		for(int u=0;u<data.length;u++)
			out.println("<td class='boldEleven'><b>"+data[u][0]+" @ "+data[u][1]);
			
		
		if(itemdata.length>0)
		{
			//out.println("<tr class='MRow1'><td colspan="+(column+3)+" class='boldEleven'><center><h3>Item</h3></center>");	
			for(int u=0;u<itemdata.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else	
					out.println("<tr class='MRow2'>");
					
				out.println("<td class='boldEleven' valign='top'>"+(u+1));
				out.println("<td class='boldEleven' valign='top'>Item");
				out.println("<td class='boldEleven' valign='top'>"+itemdata[u][1]);
				out.println("<td class='boldEleven' valign='top'>"+itemdata[u][2]);
				
				stockbooksql= 	" INSERT INTO inv_t_stockbook (CHR_MONTH,INT_YEAR,CHR_TYPE,CHR_ITEMID,";
				for(int x=0;x<data.length;x++)
					stockbooksql =stockbooksql+"INT_BRANCH"+(x+1)+",";
				stockbooksql =stockbooksql+"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( 	";	
				stockbooksql =stockbooksql+" '"+month+"' , "+year+ " , 'I' , '"+itemdata[u][0]+"' , ";
				
				for(int v=0;v<data.length;v++)
				{
					value="0";
					sql = "SELECT count(*) FROM inv_t_vendorgoodsreceived WHERE INT_BRANCHID="+data[v][2];
					sql = sql+"  AND CHR_TYPE ='I'  AND CHR_ITEMID='"+itemdata[u][0]+"' AND CHR_FLAG='Y' ";
					ResultSet rs1 = st1.executeQuery(sql);
					if(rs1.next())
					{
						value=rs1.getString(1);
						out.println("<td class='boldEleven'>"+value);
					}	
					else
						out.println("<td class='boldEleven'>"+value);
						
					stockbooksql =stockbooksql+""+value+" , ";
				}
					
				stockbooksql =stockbooksql+	"'ADMIN',now(),'Y' )";
				st.executeQuery(stockbooksql);
				stockbooksql="";
			}		
		}
		
 
		if(productdata.length>0)
		{
			//out.println("<tr class='MRow1'><td colspan="+(column+3)+" class='boldEleven'><center><h3>Product</h3></center>");
			for(int u=0;u<productdata.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else	
					out.println("<tr class='MRow2'>");
				
				out.println("<td class='boldEleven' valign='top'>"+(u+1));
				out.println("<td class='boldEleven' valign='top'>Product");
				out.println("<td class='boldEleven' valign='top'>"+productdata[u][1]);
				out.println("<td class='boldEleven' valign='top'>"+productdata[u][2]);
				
				stockbooksql= 	" INSERT INTO inv_t_stockbook (CHR_MONTH,INT_YEAR,CHR_TYPE,CHR_ITEMID,";
				for(int x=0;x<data.length;x++)
					stockbooksql =stockbooksql+"INT_BRANCH"+(x+1)+",";
				stockbooksql =stockbooksql+"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( 	";	
				stockbooksql =stockbooksql+" '"+month+"' , "+year+ " , 'P' , '"+productdata[u][0]+"' , ";
				
				
				for(int v=0;v<data.length;v++)
				{
					value="0";
					sql = "SELECT count(*) FROM inv_t_vendorgoodsreceived WHERE INT_BRANCHID="+data[v][2];
					sql = sql+"  AND CHR_TYPE ='P'  AND CHR_ITEMID='"+productdata[u][0]+"' AND CHR_FLAG='Y' ";
					ResultSet rs1 = st1.executeQuery(sql);
					if(rs1.next())
					{
						value=rs1.getString(1);
						out.println("<td class='boldEleven'>"+value);
					}	
					else
						out.println("<td class='boldEleven'>"+value);
					stockbooksql =stockbooksql+""+value+" , ";
					
				}
				stockbooksql =stockbooksql+	"'ADMIN',now(),'Y' )";
				st.executeQuery(stockbooksql);
				stockbooksql ="";
			}		
		}
		
		if(consumabledata.length>0)
		{
			//out.println("<tr class='MRow1'><td colspan="+(column+3)+" class='boldEleven'><center><h3>Consumable</h3></center>");	
			for(int u=0;u<consumabledata.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else	
					out.println("<tr class='MRow2'>");
				
				out.println("<td class='boldEleven'>"+(u+1));
				out.println("<td class='boldEleven' valign='top'>Consumable");
				out.println("<td class='boldEleven' valign='top'>"+consumabledata[u][1]);
				out.println("<td class='boldEleven' valign='top'>"+consumabledata[u][2]);
				
				stockbooksql= 	" INSERT INTO inv_t_stockbook (CHR_MONTH,INT_YEAR,CHR_TYPE,CHR_ITEMID,";
				for(int x=0;x<data.length;x++)
					stockbooksql =stockbooksql+"INT_BRANCH"+(x+1)+",";
				stockbooksql =stockbooksql+"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( 	";	
				stockbooksql =stockbooksql+" '"+month+"' , "+year+ " , 'P' , '"+consumabledata[u][0]+"' , ";
				
				
				for(int v=0;v<data.length;v++)
				{
					value="0";
					sql = "SELECT count(*) FROM inv_t_stock WHERE INT_BRANCHID="+data[v][2];
					sql = sql+"  AND CHR_TYPE ='P'  AND CHR_ITEMID='"+consumabledata[u][0]+"'  ";
					ResultSet rs1 = st1.executeQuery(sql);
					if(rs1.next())
					{
						value=rs1.getString(1);
						out.println("<td class='boldEleven'>"+value);
					}	
					else
						out.println("<td class='boldEleven'>"+value);
					stockbooksql =stockbooksql+""+value+" , ";
					
				}
				stockbooksql =stockbooksql+	"'ADMIN',now(),'Y' )";
				st.executeQuery(stockbooksql);
				stockbooksql ="";
			}		
		} 
		st1.close();
		co1.close();
	
	}
	
	}
	else
	{
		%>
			<script language="javascript" >
			alert("Stock book creation only for month end ..");
			</script>
		<%
		 
	}
		out.println("</table></center>");
	}
	catch(Exception e)
	{
	}
	%>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="184" align="center" cellpadding="15" cellspacing="0">
      <tr>
        <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
        <td class="boldEleven"><div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a> </div></td>
        <td class="boldEleven"><div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('stockbook.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div></td>
        <td class="boldEleven"><div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('stockbook.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
        <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('stockbook.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
        <td class="boldEleven"><div align="center"><a
			href="javascript:redirect( 'InventoryMains.jsp')">Close</a></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
