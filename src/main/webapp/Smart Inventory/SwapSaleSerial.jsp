<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<body   >
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/SwapSerialCheckRequest.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>

<%@ include file="indexinv.jsp"%>
<%
try
{ 
	String sql="";
	String salesno = request.getParameter("salno");
	
	String field ="";
	field = field +"  INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
	field = field +"  INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,  ";
	field = field +"  DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
	field = field +"  CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
	field = field +"  CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
	field = field +"  CHR_ACCOUNTDESC ,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
	field = field +"  DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
	field = field +"  INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
	field = field +"  INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,CHR_COURIER_EMPID,  ";
	field = field +"  CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,CHR_STARTING_PLACE,CHR_ENDING_PLACE,  ";
	field = field +"  INT_COURIER_KILOMETER,CHR_COURIER_DESC,DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,  ";
	field = field +"  DAT_DISPATCHEDDATE,CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,CHR_CANCELDESC,  ";
	field = field +"  CHR_CANCELID,DAT_CANCELDATE,CHR_BYBACKINWARD  ";
	String perdata[][]=CommonFunctions.QueryExecute("SELECT "+field+" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'");
	String bid = ""+session.getAttribute("BRANCHID");
	boolean flag= false;
	if(Integer.parseInt(perdata[0][14]) == 1)
		flag = true;
%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()"   >


<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="800" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Swap Sale Serial
							Number </strong> </div>							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="5"
								cellspacing="5">
								<tr>
									<td width="119" valign="top" class="boldEleven">
									<div align="left">Sales .No</div>									</td>
									<td width="143" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][3]%> <input type="hidden"
										name="salesno" value="<%=perdata[0][3]%>">
										
										<input name="filename" id="filename" type="hidden" value="SwapSale" />
										<input name="actionS" id="actionS"  type="hidden" value="INVSwapSaleAddserial" />
										<input name="checkserialflag"  type="hidden" id="checkserialflag" value="false"> 
										<input name="removeserialflag" type="hidden" id="removeserialflag" value="false">
										<input name="conslength" type="hidden" id="conslength">
										<input name="totalflag" type="hidden" id="totalflag">
										
										</div>									</td>
									<td width="168" valign="top" class="boldEleven">
									<div align="left">Sale Date</div>									</td>
									<td width="178" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][4]%> <input name="reqdt"
										type="hidden" id="reqdt" value="<%=perdata[0][4]%>">
									  <input name="division" type="hidden" id="division" value="<%=perdata[0][26]%>">
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">CustomerName</div>									</td>
									<td valign="top" class="boldEleven">
									<div align="left">
									<%
sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_CUSTOMERID="+perdata[0][6];
String vendor[][]=CommonFunctions.QueryExecute(sql);
						 
						
						
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+".");
						
						%>
									</div>									</td>
									<td valign="top" class="boldEleven">&nbsp; </td>
									<td valign="top" class="boldEleven"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="9">
							<%
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					//out.println(sql);
					String iname="";
					String itemname="";
					String cons="";
					double aprice=0.0;
					double avalue =0.0;
					double svalue=0.0;
					double contribution=0.0;
					double contribution1=0.0;
					String datas[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
					out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					out.println("<tr class='MRow1'><th class='boldEleven'><strong>Type</strong></th>");
                    out.println("<th class='boldEleven'><strong >Item / Product Code</strong></th>");
					out.println("<th class='boldEleven'><strong >Quantity</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Price</strong></th>");
					out.println("<th class='boldEleven'><strong >Discount(%)</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Discount</strong></th>");
					out.println("<th class='boldEleven'><strong >Total</strong></th>");
					     
			for(int v=0;v<datas.length; v++)
			{	
				
				
				if(v%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				
				if(datas[v][2].equals("I"))
				{
					iname="Item";
					sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,DOU_PURCHASEPRICE FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
					itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
					cons="";
					String ap[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					aprice =Double.parseDouble(ap[0][2]);
				}	
				if(datas[v][2].equals("P"))
				{
				  iname="Product";
				  sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY ,CHR_PTYPE,DOU_PURCHASEPRICE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
				  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
				  cons=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PTYPE");
				  String ap[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				  aprice =Double.parseDouble(ap[0][3]);
				}	
				out.println(" <td   class='boldEleven' >"+iname+"</td>");
				out.println("<td  class='boldEleven' >"+itemname);
				if("S".equals(cons))
				{
					sql ="";
					sql =" SELECT   a.DOU_AVGPRICE FROM inv_t_vendorgoodsreceivedconsumable a  WHERE   a.INT_BRANCHID="+bid+" AND a.CHR_ITEMID ='"+datas[v][1]+"'  ORDER BY a.INT_ROWID desc limit 1 "; 
					//out.println(sql);
					String ap[][] = CommonFunctions.QueryExecute(sql);
					if(ap.length>0)
						aprice = Double.parseDouble(ap[0][0]);
					else
						aprice = 0;	
					svalue=Integer.parseInt(datas[v][3]) * Double.parseDouble(datas[v][4]);
					avalue=  Integer.parseInt(datas[v][3])* aprice;
					contribution = contribution+avalue;
					
				}
				 	
				out.println("<td  class='boldEleven'  align='right' >"+datas[v][3]);
				out.println("<td  class='boldEleven'  align='right'>"+datas[v][4] );
				out.println("<td  class='boldEleven'  align='right'>"+datas[v][5] );
				out.println("<td  class='boldEleven'  align='right'>"+datas[v][6] );
				out.println("<td  class='boldEleven'  align='right' >"+datas[v][7] );
			}	
			out.println("</table>");	
					  %>							</td>
						</tr>
						<tr>
							<td height="9">
							<table width="367" border="0" align="center" cellpadding="0"
								cellspacing="2">
								<tr>
									<td class="boldEleven">Actual Consumer Purchase Price
									<%
										sql ="SELECT  CHR_ITEMID,CHR_TYPE ,INT_QUANTITY  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
										String stockCheckQtyData[][]=CommonFunctions.QueryExecute(sql);
										String collectSerialNumber="";
										if(stockCheckQtyData.length>0)
										{
											for(int t=0;t<stockCheckQtyData.length;t++) {
												// N for stock / Y forSold / T for stock transfer / D for DC / J for stock adjustment 
												// A - Assest / B - Blocked / S for Spare /Q - QUALITY CHECK / R - Ruin / E - External or Vendor Service / I - Internal Service
												
												sql = " SELECT  a.CHR_SERIALNO   FROM inv_t_vendorgoodsreceived  a  ";
												sql = sql+ " WHERE  a.CHR_QUALITY='Y'  AND a.CHR_FLAG !='Y' AND  a.CHR_GRTFLAG!='Y'  AND a.CHR_SERIALNO IS NOT NULL ";
												if(!"0".equals(perdata[0][1]))
													sql = sql+ "  AND  a.INT_BRANCHID ="+perdata[0][1];
												sql = sql+ "  AND  a.CHR_ITEMID ='"+stockCheckQtyData[t][0]+"'";
												sql = sql+ "  AND  a.CHR_TYPE ='"+stockCheckQtyData[t][1]+"'";
												sql = sql+ "  AND  a.INT_DIVIID ="+perdata[0][26];
												sql = sql+ " ORDER BY a.DAT_RECIVEDDATE limit   "+stockCheckQtyData[t][2];
												System.out.println(sql);
												String stockCollectSerialData[][]=CommonFunctions.QueryExecute(sql);
												if(stockCollectSerialData.length>0) {
													for(int h=0;h<stockCollectSerialData.length;h++) {
											 			collectSerialNumber = collectSerialNumber+stockCollectSerialData[h][0]+"~";
													}
												}
												//System.out.println(collectSerialNumber);	
											}
									
										}
										//System.out.println(collectSerialNumber);
										String stockCollectAssignSerialData[]=collectSerialNumber.split("~");
									%>
									
									</td>
									<td class="boldEleven"><input name="conribution"
										type="text" class="formText135" id="conribution"
										onKeyPress="numericValue('conribution','12')"
										value="<%=contribution%>" readonly></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center" id="error" class="bolddeepred"></div>							</td>
						</tr>
						<tr>
							<td height="9">
							  
							  <div align="center">
<%
//sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAP,CHR_DESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"'";
	 
sql = " SELECT a.INT_ID,a.CHR_SALESNO,a.CHR_ITEMID,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_TYPE,a.CHR_SWAP,a.CHR_DESC, ";
sql = sql+ "  if(a.CHR_TYPE='I','ITEM', 'PRODUCT' ), ";
sql = sql+ "  if(a.CHR_TYPE='I', ";
sql = sql+ "  ( SELECT b.CHR_ITEMNAME  FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql+ "  ( SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID) ";
sql = sql+ "  ), ";
sql = sql+ "  if(a.CHR_TYPE='I', ";
sql = sql+ "  ( SELECT b.CHR_WARRANTY  FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql+ "  ( SELECT c.CHR_WARRANTY  FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID) ";
sql = sql+ "  ) ";
sql = sql+ "   , ";
sql = sql+ "   if(a.CHR_TYPE='I',   ";
sql = sql+ "   ( '0~0'),   ";
sql = sql+ "   ( SELECT d.CHR_ITEMLIST  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID)   ";
sql = sql+ "   ) ,a.DOU_UNITPRICE  ";
sql = sql+ "  FROM inv_t_swapsalesserialno a WHERE a.CHR_SALESNO ='"+salesno+"' ";
//out.println(sql);

	String recdData[][]= CommonFunctions.QueryExecute(sql);
	out.print(" <table width='800' border='0' cellpadding='2' cellspacing='2' > ");
	int row=1;
	iname="";
	itemname="";
	String itemcolor="";
	String masterwarranty="";
	String h="";
	String h1="";
	int swaprow=0;
	int removerow=0;
	int swapdescription=0;
	String kalaiserial= "";
	for(int v=0;v<recdData.length; v++)
	{	
		
		out.println("<tr  class='MRow1'><td>");
		out.print("<center><table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class ='MRow1'>");
		out.print("<th   class='boldEleven'><b>S.No</b></th>");
		out.print("<th   class='boldEleven'><b>Type</b></th>");
		out.print("<th   class='boldEleven'><b>Item / Product</b></th>");
		out.print("<th   class='boldEleven'><b>Swap</b></th> ");
		out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
		out.print("<th   class='boldEleven'>&nbsp; </th> ");
		out.print("<th   class='boldEleven'><b>Warranty</b></th>");
		if(v%2==0)
			out.println("<tr class ='MRow2'>");
		else	 
			out.println("<tr class ='MRow1'>");
		 
		out.print("<th   class='boldEleven'>"+(v+1)+".</th>"); 
		out.println("<td   class='boldEleven' >"+recdData[v][8]+"</td>");
		out.println("<td  class='boldEleven' >"+recdData[v][9]);
		if(recdData[v][6].equals("Y"))
			out.println("<td  class='boldEleven' >Swap" );
		else
			out.println("<td  class='boldEleven' >&nbsp;" );
		
		if(recdData.length>=1)
			h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";

h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+recdData[v][5]+"','"+recdData[v][2]+"')\" ";

	
		
		if("-".equals(recdData[v][3]))		
			recdData[v][3]="";
		kalaiserial ="";
		//if(stockCollectAssignSerialData.length>0)
		//	kalaiserial = stockCollectAssignSerialData[v];
			
		out.print("<td><input name='serial"+row+"'   id='serial"+row+"'  class='formText135' maxlength='50'   size=20 type='text' value='"+kalaiserial+"'   "+h1+"  "+h+">    </td>");// recdData[v][3]
		out.println("<td>&nbsp; <div id='Valid"+row+"'></DIV></TD>");
		
		out.print("<td class='boldEleven'>&nbsp;");
		out.print("<select name='Warrantys"+row+"' id='Warrantys"+row+"' class='formText135' >");
		%> <jsp:include page="Warranty.jsp" flush="true" /> <%
		out.println("</select>");
		out.println("<script language='javascript'>setOptionValue('Warrantys"+row+"','"+recdData[v][4]+"')</script>");
	 
		out.print("<input name='item"+row+"'      id='item"+row+"'       type='hidden'  value='"+recdData[v][2]+"'>");
		out.print("<input name='itype"+row+"'     id='itype"+row+"'      type='hidden'  value='"+recdData[v][5]+"'>");
		out.print("<input name='rowid"+row+"'     id='rowid"+row+"'      type='hidden'  value='"+recdData[v][0]+"'>");
		out.print("<input name='topswap"+row+"'   id='topswap"+row+"'    type='hidden'  value='"+recdData[v][6]+"'>");
		out.print("<input name='saleunitprice"+row+"'   id='saleunitprice"+row+"'    type='hidden'  value='"+recdData[v][12]+"'>");
		
		out.print("</tr>");
		
		
		
		//Swapping serialnumbers
		if(recdData[v][6].equals("Y") && recdData[v][5].equals("P"))
		{
			swapdescription=swapdescription+1;
			out.print("<tr align='center'  class ='MRow2' cellpadding=5 cellspacing=5 >");
			out.print("<td colspan=7  align='center'>");
			String ppitemlist[] = recdData[v][11].split("~");
			out.println("<br><center>");
			out.println("<table width='80%' class='boldEleven'   id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr bgcolor='#B4E7D5' >");
			out.println("<td class='bold1'>S.No</td>");
			out.println("<td class='bold1'>Item name</td>");
			out.println("<td class='bold1'>Swapping</td>");
			out.println("<td class='bold1'>Taken Serial no</td>");
			out.println("<td class='bold1'>Taken Warranty</td>");
			out.println("<td class='bold1'>Taken Price</td>");
			out.println("<td class='bold1'>Item</td>");
			out.println("<td class='bold1'>Given Serail No</td>");
			out.println("<td class='bold1'>&nbsp;</td>");
			out.println("<td class='bold1'>Given  Warranty</td>");
			out.println("</tr>");
			for(int c=0;c<ppitemlist.length;c++)
			{
			 	swaprow=swaprow+1;
			 	if(c%2==0)
					out.println("<tr class ='MRow1'>");
				else	 
					out.println("<tr class ='MRow2'>");
		 
				out.println("<td  class='boldEleven'>"+(c+1)+".</td>");
				
				out.println("<td class='boldEleven'>"+CommonFunctions.QueryExecute("SELECT CHR_ITEMNAME  FROM inv_m_item  WHERE CHR_ITEMID = '"+ppitemlist[c]+"'")[0][0]+"</td>");
				
			 	out.println("<td class='boldEleven'>");
			 	out.println("<input  onClick=SwapCheckbox('"+swaprow+"') id='SwapCheckbox"+swaprow+"' name='SwapCheckbox"+swaprow+"' type='checkbox' /></td>");
			 	
				out.println("<td class='boldEleven'>");
			 	String swaph1="  onkeyup=\"upperMe(this),LoadUniqueCheck('SwapSerial"+(swaprow)+"','SwapValid"+(swaprow)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\"  ";
			 	out.println("<input class='boldEleven' "+swaph1+" name='SwapSerial"+swaprow+"' id='SwapSerial"+swaprow+"' maxlength='50'  size='10' />");
			 	out.println("<div id='SwapValid"+swaprow+"' ></div>" );
				out.println("</td>");
				
				out.println("<td class='boldEleven'>");
 %> 			
 				<select name="SwapWarranty<%=swaprow%>"	id="SwapWarranty<%=swaprow%>" class="formText135">
					<jsp:include page="Warranty.jsp" flush="true" />
				</select> 
<%
				out.println("</td>");
							 	
				out.println("<td class='boldEleven'>"); 
			 	out.println("<input class='boldEleven' onKeyPress=\"return numeric_only(event,'Swapprice"+swaprow+"','10')\"   name='Swapprice"+swaprow+"' id='Swapprice"+swaprow+"' maxlength='8'  size='10' />");
				out.println("</td>");
				
				
				out.println("<td class='boldEleven'>"); 
			 	String swapselect=" onChange=\"LoadUniqueSwapSales('SSwapSerial"+(swaprow)+"','SSwapValid"+(swaprow)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','I','swapitem"+(swaprow)+"')\" ";
				
	  // put into below select box swapselect;
							 
%> 
				
				
				<select name="swapitem<%=swaprow%>" id="swapitem<%=swaprow%>"  <%=swapselect%> class="formText135">
<%
				String query = " SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item WHERE INT_ITEMGROUPID= "+CommonFunctions.QueryExecute("SELECT INT_ITEMGROUPID  FROM inv_m_item  WHERE CHR_ITEMID = '"+ppitemlist[c]+"'")[0][0]+" AND CHR_ITEMID not in ('"+ppitemlist[c]+"') ";
				String idata[][] = CommonFunctions.QueryExecute(query);
				
				//SwapDiabled(swaprow)
				if(idata.length>0)
				{
				 	out.println("<option  value=''>Select</option>");
				 	for(int y=0; y<idata.length;y++)
						out.println("<option  value='"+idata[y][0].trim()+"'  >"+idata[y][1] +"</option>");	
				}
				%>
				<script language="javascript">setOptionValue("swapitem<%=swaprow%>","<%=ppitemlist[c].trim()%>")</script>
				</select> 
<%
			 out.println("</td>");
			 
			 out.println("<td class='boldEleven'>&nbsp;");
			  

			String sswaph1=" onKeyUp=\"LoadUniqueSwapSales('SSwapSerial"+(swaprow)+"','SSwapValid"+(swaprow)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','I','"+ppitemlist[c].trim()+"')\" ";
				
				
				
			 out.println("<input readonly='readonly' class='boldEleven' "+sswaph1+" name='SSwapSerial"+swaprow+"' id='SSwapSerial"+swaprow+"' maxlength='50'  size='10' />");
			 
			 out.println("<td class='bold1'>&nbsp;");
			 out.println("<td class='bold1'>&nbsp;");
			 out.println("<div id='SSwapValid"+swaprow+"' ></div>" );
			 
			 %> <script language="javascript">
				 
					document.getElementById('SwapSerial<%=swaprow%>').style.visibility="hidden"; 
					document.getElementById('SwapWarranty<%=swaprow%>').style.visibility="hidden"; 
					document.getElementById('swapitem<%=swaprow%>').style.visibility="hidden"; 
					document.getElementById('Swapprice<%=swaprow%>').style.visibility="hidden"; 
					document.getElementById('SSwapSerial<%=swaprow%>').style.visibility="hidden"; 
					 
			</script> 
			<%
			 	out.print("</tr>");
		}	
		out.print("</table></center> <br> ");
			
			
			
			//Removable Items
			out.println("<br><center>");
			out.println("<table width='80%' class='boldEleven'   id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr bgcolor='#B4E7D5' >");
			out.println("<td class='bold1'>S.No</td>");
			out.println("<td class='bold1'>Item name</td>");
			out.println("<td class='bold1'>Removable</td>");
			out.println("<td class='bold1'>Taken Serial no</td>");
			out.println("<td class='bold1'>Taken Price</td>");
			out.println("<td class='bold1'>Taken Warranty</td>");
			for(int c=0;c<ppitemlist.length;c++)
			{
			 	removerow=removerow+1;
			 	if(c%2==0)
					out.println("<tr class ='MRow3'>");
				else	 
					out.println("<tr class ='MRow4'>");
		 
				out.println("<td  class='boldEleven'>"+(c+1)+".</td>");
				out.println("<td class='boldEleven'>"+CommonFunctions.QueryExecute("SELECT CHR_ITEMNAME  FROM inv_m_item  WHERE CHR_ITEMID = '"+ppitemlist[c]+"'")[0][0]+"</td>");
				out.println("</td> ");
				
				out.println("<td class='boldEleven'>");
			 	out.println("<input onClick=RemoveCheckbox('"+removerow+"') id='RemoveCheckbox"+removerow+"' name='RemoveCheckbox"+removerow+"' type='checkbox'/>");
			 	out.println("</td> ");
				
				out.println("<td class='boldEleven'>");
			 	String swaph1="  onkeyup=\"upperMe(this),LoadUniqueCheck('RemoveSerial"+(removerow)+"','RemoveValid"+(removerow)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\"  ";
			 	out.println("<input class='boldEleven' "+swaph1+" name='RemoveSerial"+removerow+"' id='RemoveSerial"+removerow+"' maxlength='50'  size='10' />");
			 	out.println("<div id='RemoveValid"+removerow+"' ></div>" );
				out.println("</td> ");
			
			 	out.println("<td class='boldEleven'>&nbsp;"); 
			 	out.println("<input class='boldEleven' onKeyPress=\"return numeric_only(event,'Removeprice"+removerow+"','10')\"  name='Removeprice"+removerow+"' id='Removeprice"+removerow+"' maxlength='8'  size='10' />");
				
			  	out.println("</td> ");
				
				out.println("<td class='boldEleven'>");
%> 
			 	<select name="RemoveWarranty<%=removerow%>" id="RemoveWarranty<%=removerow%>" class="formText135">
			 		<jsp:include page="Warranty.jsp" flush="true" /> 
			 	</select> 
			 	<script language="javascript">
					document.getElementById('RemoveSerial<%=removerow%>').style.visibility="hidden"; 
					document.getElementById('RemoveWarranty<%=removerow%>').style.visibility="hidden"; 
					document.getElementById('Removeprice<%=removerow%>').style.visibility="hidden"; 
				</script> 
<%
				out.println("</td> ");			 
			}	
			
			out.print("</table><center><br> ");
			out.println("<br><center><table width='40%' class='boldEleven'   id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ");
			out.println("<tr bgcolor='#B4E7D5' ><td class='bold1' valign='top'>Modified Description</td>");
			out.println("<td  valign='top' class='boldEleven'>");
			out.println("<textarea class='boldEleven' name='swapdescription"+row+"' cols='25' rows='5'>"+recdData[v][7]+"</textarea>");
			out.println("</td>");
			out.print("</table><center><br> ");
			
			out.print("</tr>");
		}
		row= row+1;
		out.print("</table></center><br><br></td></tr> ");
	}
	out.print("</table> ");
	//out.println("<input type=\"hidden\" name=\"length\" id=\"length\" value=\""+(row-1)+"\">");
	 
  
%> 
 <input name="length" type="hidden" id="length"	value="<%=(row-1) %>"></div>	
<input name="seriallength" type="hidden" id="seriallength"	value="<%=(row-1) %>"></div>							
</td>
						</tr>
						<tr>
						  <td><table width="500" border="0" align="right" cellpadding="5" cellspacing="0">
                            <tr>
                              <td width="267" rowspan="2" valign="top" class="bolddeeplogin"><div align="right">
                                  <textarea name="randomserials" cols="25" rows="5" id="randomserials"></textarea>
                              </div></td>
                              <td width="317" valign="top" class="bolddeeplogin" ><a href='javascript:assignrandomserial()'>Serialnumber Assign </a><br>
                              (E.g S12,S10,S5,)</td>
                              <td width="317" rowspan="2" valign="top" class="bolddeeplogin" ><a href='javascript:assignSerialWarranty()'>Warranty Assign</a></td>
                            </tr>
                            <tr>
                              <td valign="top" class="bolddeeplogin" ><a     href='javascript:checkserialnumbers()' >check serialnumber</a>
							  <script language="javascript">
							  function checkserialnumbers()
							  {
							  	if(checkNull('randomserials','Enter the serial numbers'))
								{
									var query="CheckSerialnumberResponse.jsp?serials="+document.getElementById('randomserials').value;
									var width="800", height="400";
									var left = (screen.width/2) - width/2;
									var top = (screen.height/2) - height/2;
									var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
									newWindow = window.open(query,"subWind",styleStr);
									newWindow.focus( );
									 
								}
								 
								
								
							  }
							  </script>
						      </td>
                            </tr>
                          </table></td>
					  </tr>
						<tr>
						  <td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
						  <td height="38" valign="top" class="boldEleven"><div id="mythra" align="center"></div><br><div id="mkmythra" align="center"></div></td>
					  </tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<table width="147" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="56"  >
									<%
String blockinvoice = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_INVOICEBLOCK FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'")[0][0];
									
							 
								
							if( (flag == false) )
								if ( "N".equals(blockinvoice)  )
									out.println("<input name='Submit' id='Submit' type='submit' class='buttonbold' value='Submit'>");
								else 
									out.println("<font class='bolddeepred'>Invoice Blocked....</font>");
							 
						%>									</td>
									<td width="56"><input name="Submit2" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('SwapSale.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</div>

<script language="JavaScript">
function RemoveCheckbox(removerow)
{
	var f="RemoveCheckbox"+removerow;
	var flag =document.getElementById(f).checked;
	if(flag ===  true)
	{
		document.getElementById("RemoveSerial"+removerow).disabled= false;
		document.getElementById("RemoveWarranty"+removerow).disabled= false; 
		document.getElementById("RemoveSerial"+removerow).style.visibility="visible";
		document.getElementById("RemoveWarranty"+removerow).style.visibility="visible";
		document.getElementById("Removeprice"+removerow).style.visibility="visible";
	}
	else  
	{
		document.getElementById("RemoveSerial"+removerow).disabled= true;
		document.getElementById("RemoveWarranty"+removerow).disabled= true; 
		document.getElementById("RemoveSerial"+removerow).style.visibility="hidden";
		document.getElementById("Removeprice"+removerow).style.visibility="hidden";
		document.getElementById("RemoveWarranty"+removerow).style.visibility="hidden";
	}	
}


function SwapCheckbox(swaprow)
{
	var it = "swapitem"+swaprow;
	var f="SwapCheckbox"+swaprow;
	if(document.getElementById(it).length >0)
	{
	}
	else
	{
		document.getElementById(f).checked = false;
		alert("Kindly check stock");
	}
	
	var flag =document.getElementById(f).checked;
	
	if(flag ===  true)
	{
		document.getElementById("SwapSerial"+swaprow).style.visibility="visible";
		document.getElementById("SwapWarranty"+swaprow).style.visibility="visible";
		document.getElementById("swapitem"+swaprow).style.visibility="visible";
		document.getElementById("Swapprice"+swaprow).style.visibility="visible";
		document.getElementById("SSwapSerial"+swaprow).style.visibility="visible";
		
		 
	}
	else
	{
		document.getElementById("SwapSerial"+swaprow).style.visibility="hidden";
		document.getElementById("SwapWarranty"+swaprow).style.visibility="hidden";
		document.getElementById("swapitem"+swaprow).style.visibility="hidden";
		document.getElementById("Swapprice"+swaprow).style.visibility="hidden";
		document.getElementById("SSwapSerial"+swaprow).style.visibility="hidden";
	}	
}


function SwapDiabled(swaprow)
{
	var f="SwapCheckbox"+swaprow;
	alert(f);
	document.getElementById(f).checked=false;
}


function Validate()
{

	try
	{	 
		var swapr = "<%=swaprow%>";
		var remover= "<%=removerow%>";
		var f ="";
		var flag="false";
		var validation="";
		var checkserialno="";
		var stockserial="";
		var notstockserial="";
		var salesserialno="";
		var removingserialno="";
		//topswap
		var v ="<%=recdData.length%>";
		console.log("Total Number of items::"+v);
		if(v == 0)
			return true; 
			
		for( i=1 ;i<=v;i++)
		{
			validation=validation+"serial"+i+",";
			checkserialno=checkserialno+"serial"+i+",";
			salesserialno = salesserialno+document.getElementById("serial"+i).value+"~"+document.getElementById("item"+i).value+"~"+document.getElementById("itype"+i).value+"~,";
			stockserial=stockserial+"serial"+i+",";
		}	
	
		//checking for changable materials
		for(x=1; x<=swapr;x++)
		{
			f="SwapCheckbox"+x;
			if(document.getElementById(f).checked)
			{
				validation=validation+f+","+"SwapSerial"+x+","+"SwapWarranty"+x+","+"swapitem"+x+","+"SSwapSerial"+x+","+"Swapprice"+x+",";
				checkserialno=checkserialno+"SwapSerial"+x+","+"SSwapSerial"+x+",";
				//salesserialno = salesserialno+document.getElementById("SSwapSerial"+x).value+",";
				stockserial=stockserial+"SSwapSerial"+x+",";
				notstockserial=notstockserial+"SwapSerial"+x+",";
			}
		} 
	
	
	
		//checking for removable materialsSwapprice,Removeprice
		for(x=1; x<=remover;x++)
		{
			f="RemoveCheckbox"+x;
			if(document.getElementById(f).checked)
			{
				validation=validation+f+","+"RemoveSerial"+x+","+"RemoveWarranty"+x+","+"Removeprice"+x+",";
				checkserialno=checkserialno+"RemoveSerial"+x+",";
				notstockserial=notstockserial+"RemoveSerial"+x+",";
				removingserialno=removingserialno+document.getElementById("RemoveSerial"+x).value+",";
			}	
		} 
	
		//Serial number validation
		//checkserialno
		//stockserial
		//notstockserial
		
	
		//Whole Validation
		var wholeflag="false";
		var citems= 	validation.split(",");
		for( i=0 ;i<(citems.length-1);i++)
		if(checkNull(citems[i] ,("Kindly check data") ))
				wholeflag = "true";
		else
		{
				wholeflag = "false";	
				return false;			
		}	
		 
 
	
		/*var checkserialnumbers = salesserialno.split(",");
		for(i=0;i<(checkserialnumbers.length-1);i++)
		{
			var mserial = checkserialnumbers[i].split("~");
			var mserials = mserial[0];
			var mitem = mserial[1];
			var mtype = mserial[2];
			LoadSwapcheckSerial(mserials,mitem,mtype);
			sleep(6000);
			
			
		}*/
	
	  
	  if(v >= 20)
	  {
	    document.getElementById('checkserialflag').value="true";
	  }
	  else {
		 checkSerial(salesserialno,'Submit');
	  }
		 
	  
		sleep(1000);
		
		if(removingserialno.length<1)
			document.getElementById('removeserialflag').value="true";
		//else
			//removedItemSerial(removingserialno,'Submit');
			
		var cfh=document.getElementById('checkserialflag').value;
		var cfhc=document.getElementById('removeserialflag').value;
		console.log("wholeflag===" + (wholeflag ==="true"));
		console.log("cfh-flg===="+(cfh=="true"));
		console.log("Rowlength===="+(document.getElementById('length').value)  );
		console.log("Rowlength seriallength===="+(document.getElementById('seriallength').value)  );
		 
		if((wholeflag ==="true") && (cfh=="true") 	){
			console.log("return true"); 
			alert("Submit.....");
			return true;
		}	
		else
			return false;
			
	}
	catch(err)
	{
		alert("submit error...");
		alert(err.desc);
		 
	}
		 
  } 	
  
 


function sleep(milliseconds) 
{
	try
	{
		  var start = new Date().getTime();
		  for (var i = 0; i < 1e7; i++) 
		  {
			if ((new Date().getTime() - start) > milliseconds)
			{
			  break;
			}
		  }
	}
	catch(err)
	{
		alert(err);
	}
}



  
function assignrandomserial()
 {
 	var l=parseInt("<%=recdData.length%>");
 	var randomss = document.getElementById('randomserials').value;
	if(randomss=="")
	{
		alert("Check Random Serial Number...");
		document.getElementById('randomserials').focus();
	}
	else
	{
		var arrayarandomserial = randomss.split(",");
		if(arrayarandomserial.length<1)
		{
			alert("Check Random Serial Number...");
		}
		else
		{
			var seriallength = parseInt(arrayarandomserial.length);
			for(u=0;u<seriallength;u++)
				{
					var ty="serial"+(u+1);
					var obj = findObj(ty);
					if(obj != null)
						document.getElementById(ty).value=trim(arrayarandomserial[u]);
					
				}
				document.getElementById('serial1').focus();
			
				
		}
	}	
 }  





function assignSerialWarranty()
 {
 	var l=parseInt("<%=recdData.length%>");
	var warranty=prompt("Enter the Warranty for an e.g  3 month means 0.3 , 1 Year means 1","1"); 
 	for(u=0;u<l;u++)
	{
		var ty="Warrantys"+(u+1);
		var obj = findObj(ty);
		if(obj != null)
			setOptionValue(ty,warranty);
			
	}
 }  







  
</script> 

<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
</form>
<%@ include file="../footer.jsp"%>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>
