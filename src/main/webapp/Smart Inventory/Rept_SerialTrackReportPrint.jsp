<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
try
{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	function StockTransferview(serialno)
	{
		
		var width="500", height="200";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="Stocktransferview.jsp?serialno="+serialno;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
	}
	
</script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
<body >

<p><%@ include file="indexinv.jsp"%> <%
		
		out.print("<br><br><br>");
		String sql = ""+request.getParameter("sql");
		String serial = ""+request.getParameter("serial");
		
		sql = " SELECT FUN_GET_BRANCH_WITH_COMPANY_NAME(a.INT_BRANCHID),a.CHR_PURCHASEORDERNO,   ";
		sql = sql + " a.CHR_TYPE,a.CHR_ITEMID,a.CHR_RECIVEDID,    ";
		sql = sql + " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y'),a.CHR_RECIVEDBY,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_FLAG,   ";
		sql = sql + " a.CHR_GRTFLAG,a.CHR_DELIVARYNO,a.CHR_INVOICENO,a.CHR_RECEIVEDMODE,a.CHR_SALESNO,   ";
		sql = sql + " a.DOU_UNITPRICE,a.CHR_PURCHASE_WARRANTY,a.CHR_SALESRETURN,a.CHR_SWAPPING_SERIALNO,   ";
		sql = sql + " INT_DIVIID,FUN_INV_DIVISION(a.INT_DIVIID) ,    ";
		sql = sql + " IF(a.CHR_RECEIVEDMODE ='P','Vendor Purchase','Direct Purchase'),   ";
		sql = sql + " if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT' ),   ";
		
		sql = sql + " if( a.CHR_TYPE ='I' ,   ";
		sql = sql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID),   ";
		sql = sql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)   "; 
		sql = sql + " ) productcode,   ";
		
		sql = sql + " if( a.CHR_TYPE ='I' ,   ";
		sql = sql + " (SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID),   ";
		sql = sql + " (SELECT sa2.CHR_PRODUCTDESC FROM inv_m_produtlist sa2  WHERE  sa2.CHR_PRODUCTID =a.CHR_ITEMID)   "; 
		sql = sql + " ) productdescription ,   ";
		sql = sql + "  a.CHR_BUYBACK_STOCK   ";
		sql = sql + " FROM inv_t_vendorgoodsreceived a    WHERE CHR_SERIALNO ='"+serial+"'";  
		//out.println(sql);
					
 
					
		String data[][] =CommonFunctions.QueryExecute(sql);
		out.println("<table align=center width='70%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=0 bgcolor='#9900CC'   >");
		out.println("<tr  bgcolor='#FFFFFF'>");
		out.println("<td colspan=3 class='boldEleven' align=center><h2>SERIAL NUMBER TRACKING ( "+serial.toUpperCase()+" )</h2></td>");
		out.println("<tr  bgcolor='#FFFFFF'>");
		 
		if(data.length>0)
		{
			out.println("<td colspan=3>"); 
		%>

<table width="80%" border="0" align="center" cellpadding="3" cellspacing="0"  class="TableDesign">
  <tr>
    <td class="whiteMedium"><div align="center">TRACK</div></td>
  </tr>
  <tr>
    <td> 
   
<table width='100%'  class='boldEleven'    cellpadding=3 cellspacing=1 bgcolor='#9900CC' >
  <tr bgcolor="#FFFFFF">
	  <td width="200" class="bold1">Company Details</td>
	  <td width="500" class="boldEleven"><%=data[0][0]%>	      </td>
	  <td width="200" class="bold1">Branch</td>
	  <td class="boldEleven"><%=data[0][0]%> </td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1">Purchase Number</td>
	  <td class="boldEleven">
		<%
		if("D".equals(data[0][13]))
	   		out.println("<a  target='_blank' href='DirectGoodsReceiveViewList.jsp?gdreceiveno="+data[0][1]+"'>"+data[0][1]+"</a>");
		else	
		out.println("<a  target='_blank' href='GoodsReceiveViewList.jsp?gdreceiveno="+data[0][4]+"'>"+data[0][1]+"</a>");
	   %>	  </td>
	  <td class="bold1">Sales</td>
	  <td class="boldEleven"> 
		<%
	if("Y".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Sold</font>");
	else if("T".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Stock Transfer</font>");
	else if("A".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Stock given to " +CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID) FROM inv_t_asset WHERE CHR_SERIALNO='"+data[0][7]+"' AND CHR_STATUS='N'")[0][0]+"</font>");
	else if("D".equals(data[0][9]))
	{
		out.println("<font class='bolddeepred'>DC Mode</font>");
		sql = " SELECT a.CHR_DCNO,DATE_FORMAT(b.DAT_DCDATE,'%d-%b-%Y'), a.CHR_SERIALNO  FROM inv_t_deliverychallanitemserial a , inv_t_deliverychallan b WHERE  a.CHR_DCNO = b.CHR_DCNO AND b.CHR_DCSTATUS ='N' AND   a.CHR_SERIALNO='"+serial+"' ";
		String dcdata[][]= CommonFunctions.QueryExecute(sql);
		if(dcdata.length>0)
		{
			out.println("<br> ( D.C Number &nbsp;&nbsp; :&nbsp;&nbsp; <a target='_blank' href='DeliveryChallanPrint.jsp?dcno="+dcdata[0][0]+"'>"+dcdata[0][0]+"</a>");
			out.println("<br>D.C. Date &nbsp;&nbsp;:&nbsp;&nbsp;"+dcdata[0][1] +" ) ");

		}
	}
	else if("J".equals(data[0][9]))
	{
		out.println("<font class='bolddeepred'>Stock Adjustment</font>");
		sql = " SELECT a.CHR_ADJUSTMENTNO,DATE_FORMAT(b.DAT_ADJUSTMENTDATE,'%d-%b-%Y'), a.CHR_SERIALNO  FROM inv_t_stockadjustmentitemserial a , inv_t_stockadjustment b WHERE  a.CHR_ADJUSTMENTNO = b.CHR_ADJUSTMENTNO AND b.CHR_DCSTATUS ='N' AND   a.CHR_SERIALNO='"+serial+"' ";
		String dcdata[][]= CommonFunctions.QueryExecute(sql);
		if(dcdata.length>0)
		{
			out.println("<br> ( REF Number &nbsp;&nbsp; :&nbsp;&nbsp; <a target='_blank' href='StockAdjustmentPrint.jsp?dcno="+dcdata[0][0]+"'>"+dcdata[0][0]+"</a>");
			out.println("<br>Dated : &nbsp;&nbsp;:&nbsp;&nbsp;"+dcdata[0][1] +" ) ");

		}
		
	}
	else if("S".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Spare Issue</font>");
	else if("I".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Internal / Domestic Service</font>");
	else if("E".equals(data[0][9]))
		out.println("<font class='bolddeepred'>External / Vendor Service</font>");
	else if("Q".equals(data[0][9]) || "B".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Bad Stock</font>");
	else  if("N".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Stock Available</font>");
	else  if("X".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Irreparable </font>");
	else  if("R".equals(data[0][9]))
		out.println("<font class='bolddeepred'>Scrap </font>");
	else	
		out.println("<font class='bolddeepred'>Check the status</font>");
		
		
	if(!"-".equals(data[0][18]))	
	{
		sql = " SELECT b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,a.CHR_SERIALNO ";
		sql = sql + " FROM  inv_t_vendorgoodsreceived a, inv_m_produtlist b ";
		sql = sql + " WHERE a.CHR_ITEMID = b.CHR_PRODUCTID ";
		sql = sql + " AND a.CHR_SERIALNO =";
		sql = sql + " ( select distinct c.CHR_SWAPPING_SERIALNO FROM  inv_t_vendorgoodsreceived c WHERE c.CHR_SWAPPING_SERIALNO='"+data[0][18]+"') ";
		 //out.println(sql);
		sql =   " SELECT a.CHR_SWAPPING_SERIALNO ,FUN_INV_PRODUCTCODE(a.CHR_TYPE,a.CHR_ITEMID) ,FUN_INV_PRODUCTDESCRIPTION(a.CHR_TYPE,a.CHR_ITEMID)  ";
		sql = sql + " FROM  inv_t_vendorgoodsreceived a ";
		sql = sql + " WHERE  a.CHR_SERIALNO = '"+serial+"' ";

		String swapdata[][] = CommonFunctions.QueryExecute(sql);
		if(swapdata.length>0)
			out.println("<br><br><font class='bolddeepred'>Swapping from : "+swapdata[0][0] +" @ "+swapdata[0][2] +"</font>");
		

	}

	if("Y".equals(data[0][25]))	
		out.println("<br><br><font class='bolddeepred'> [ BUY BACK ] </font>");
		
		
		
		
	%>	  </td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1">Type</td>
	  <td class="boldEleven">
		<%=data[0][22]%> </td>
	  <td class="bold1">Sales Return</td>
	  <td class="boldEleven">
		<%
		if("Y".equals(data[0][10]))
			out.println("Goods Return");
		else
			out.println("-");
	%>	  </td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1">Product Code / Description</td>
	  <td class="boldEleven"><%=data[0][23]%> / <br><%=data[0][24]%></td>
	  <td class="bold1">Delivery No</td>
	  <td class="boldEleven"><%=data[0][11]%></td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1">Received No</td>
	  <td class="boldEleven"><%=data[0][4]%></td>
	  <td class="bold1">Invoice No</td>
	  <td width="200" class="boldEleven"><%=data[0][12]%></td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1">Received Date</td>
	  <td class="boldEleven"><%=data[0][5]%></td>
	  <td class="bold1">Received Mode</td>
	  <td class="boldEleven">
		<%
	
	String v = data[0][13];
	if("P".equals(v))
		out.println("Purchase");
	else if ("D".equals(v))
		out.println("Direct Purchase");	
	else if ("S".equals(v))
		out.println("Stock Entry");	
	else if ("R".equals(v))
		out.println("Goods Replacement");	
	else if ("T".equals(v))
		out.println("Stock Transfer ");	
	else if ("C".equals(v))
		out.println("Product Swap Entry");	
	else if("B".equals(v))
		out.println("Sales Return ");	
	else
		out.print("--");	
	
	out.println("<a href=\"javascript:StockTransferview('"+data[0][7]+"')\"><font class='boldgreen' >Details</font> </a>");
	
	
	//P -Purchase / D- Direct Purchase / S - Stock Entry/R - Replacement/T - Stock Tansfer/C - Product Split Entry/B - Sales Return
	
	%>	  </td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1">Serial Number</td>
	  <td  class='bolddeepred'><%=data[0][7]%></td>
	  <td class="bold1">Sales No</td>
	  <td class="boldEleven">
		<%
		
		if("Y".equals(data[0][9]))
			out.println("<a class='boldgreen' target='_blank' href='SwapSaleSerialView.jsp?salno="+data[0][14]+"'>"+data[0][14]+"</a>");
		else
			out.println(data[0][14]);
				
			 String ssql=" SELECT  a.CHR_PAYMENTSTATUS,a.DOU_TOTALAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),d.CHR_DIVICODE  FROM inv_t_directsales a ,inv_m_customerinfo b,inv_m_division d WHERE  a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.INT_DIVIID=d.INT_DIVIID  AND a.CHR_SALESNO='"+data[0][14]+"'";

		if("Y".equals(data[0][17]))
			out.println("<font class='boldred'>Sales Return take place...</font>");
	
	%>	  </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td class="bold1" valign="top">Receive Mode </td>
    <td>
	<%=data[0][21]%> 
	 
	</td>
    <td class="bold1">Division</td>
    <td class="boldEleven"><%=data[0][20]%></td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td class="bold1" valign="top">Warranty</td>
		<td class="boldEleven" valign="top">
	  <table>
		  <tr>
			  <td class="boldEleven"><b>Purchase - </b></td>
			  <td class="boldEleven"><%=data[0][16]+" -yrs"%></td>
		  </tr>
		  <tr>
			  <td class="boldEleven"><b>Updated - </b></td>
			  <td class="boldEleven"><%=data[0][8]+" -yrs"%></td>
		  </tr>
		  </td>
	  </table>
	  <td class="bold1">Purchase Price</td>
	  <td class="boldEleven"><%=data[0][15]%></td>
  </tr>
  <tr bgcolor="#FFFFFF">
	  <td colspan="4" class="bold1" align="center">
	  <%

	  String inVoiceData[][] =  CommonFunctions.QueryExecute(ssql);
	  if(inVoiceData.length>0)
	  {
	  	out.println("<table align='center' cellpadding=2 cellspacing=0><tr><td class='boldEleven'  colspan='4'><b>Sales Details</td></tr>");
		out.println("<tr > <td class='boldEleven'><b>Customer Name </b></td><td class='boldEleven'>"+inVoiceData[0][3]+"</td></tr>");
		out.println("<tr> <td class='boldEleven'><b>Sale Date </b></td><td class='boldEleven'>"+inVoiceData[0][2]+"</td></tr>");
		out.println("<tr> <td class='boldEleven'><b>Division</b></td><td class='boldEleven'>"+inVoiceData[0][4]+"</td></tr>");
		out.println("<tr> <td class='boldEleven'><b>Invoice Amount</b></td><td class='boldEleven'>"+inVoiceData[0][1]+"</td></tr>");
		out.println("<tr> <td class='boldEleven'><b>Payment Status </b></td><td class='boldEleven'>");
		if("N".equals(inVoiceData[0][0]))
			out.println(" Payment not paid");
		else if("P".equals(inVoiceData[0][0]))
			out.println(" Payment paritially paid");
		else
			out.println(" Payment paid");
			
		out.println("</td></tr>");
		
		out.println("</table>");
	  }
	  %>	  </td>
  </tr>
</table>

<%		 
				
		out.println("</td>");	 
		}
		else
		{
			out.println("<tr bgcolor='#FFFFFF'>");
			out.println("<td height=200 colspan=3 class='errorMessage' align=center ><center>Data not found ....</center></td>");
			
		}
		out.println("</table>");
		out.print("<br> ");
		
	 
  %>
  
  
 </td>
  </tr>
</table>
<a href=javascript:; onClick="windowSave('sample.html')"> </a>
</div>

<%@ include file="../footer.jsp"%>
</p>

<p>&nbsp;</p>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>