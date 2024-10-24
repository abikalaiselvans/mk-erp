<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.InventoryInvoiceFunctions"%>
<%@ page import="com.my.org.erp.Math.*"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
 
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="90%"
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
					<td>
					<table cellspacing="2" cellpadding="2" width="99%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">PURCHASE REQUEST CLOSE
									
									
									<%
				String Requestno = request.getParameter("Requestno");							
				String sql = " ";
				sql = " SELECT "; 
				sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
				sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
				sql = sql + " f.CHR_PAYMENTNAME, ";
				sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
				sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID  ";
				sql = sql + ", DATE_FORMAT(a.DAT_COMMITMENTDATE,'%d-%b-%Y') ,DATE_FORMAT(a.DAT_PURCHASEDATE,'%d-%b-%Y'),DATE_FORMAT(a.DAT_PURCHASEDATE,'%Y-%m-%d'),a.INT_BRANCHID ,IF(a.CHR_BYBACK='Y','BUY BACK',''),a.CHR_SALESNO, ";
				sql = sql + " a.CHR_MODE, a.CHR_CPOREF_NUMBER " ;
				
				 
				
				 sql = sql + "  FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d, inv_m_customergroup h,  ";
				sql = sql + " inv_m_paymentterms f,com_m_staff g ";
				sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
				sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID  AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID  ";
			 
				sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID AND (a.CHR_APPROVEDSTATUS='Y' OR a.CHR_APPROVEDSTATUS='P') ";
				sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				String link="";
				
									%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
								<td width="118" height="17" valign="top" class="bold1">Request Number / Date </td>
							  <td width="199" align="left" valign="top"><span class="boldEleven"><%=data[0][3] +"  dated on " +data[0][4]%></span></td>
							    <td width="105" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
						        <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="bold1"><div align="left">CustomerName</div></td>
							  <td align="left"><span class="boldEleven"><%=data[0][5]%></span></td>
						      <td class="bold1">Vendor Payment </td>
						      <td class="boldEleven"><%=data[0][7]%> </td>
							</tr>
							<tr>
							  <td class="bold1">Division</td>
							  <td class="boldEleven"><%=data[0][2]%>
                                <input name="divis" type="hidden" id="divis" value="<%=data[0][17]%>"></td>
							  <td class="bold1">Proposed Purchase Date</td>
							  <td class="boldEleven"> <%=data[0][20]%></td>
							</tr>
							<tr>
							  <td valign="top" class="bold1">Description </td>
							  <td valign="top" class="boldEleven"><%=data[0][11]%>  <input name="customer" type="hidden" id="customer" value="<%=data[0][18]%>"></td>
							  <td valign="top" class="bold1">Commitment days &amp; Date </td>
							  <td valign="top" class="boldEleven"><%=data[0][8]+"- Days  / "+data[0][19]%></td>
							</tr>
							<tr>
							  <td valign="top" class="bold1">Status
							    <%
							  String s1="";
							  String s2="";
							  String s3="";
							  if("Y".equals(data[0][12]))
							  	s1= " checked = 'checked' ";
							  
							  if("N".equals(data[0][12]))
							  	s2= " checked = 'checked' ";
								
							  if("R".equals(data[0][12]))
							  	s3= " checked = 'checked' ";
							 
							  %>							  </td>
							  <td valign="top" class="boldEleven"><table width="123" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="boldEleven"><input name="Accept" type="radio" value="Y" <%=s1%>></td>
                                  <td class="boldEleven">Close</td>
                                  <td class="boldEleven"><input name="Accept" type="radio" value="N" <%=s2%>></td>
                                  <td class="boldEleven">Pending</td>
                                </tr>
                              </table></td>
							  <td valign="top" class="boldEleven"><span class="bold1">M.E </span></td>
							  <td valign="top" class="boldEleven"><%=data[0][9]+" / "+data[0][10]%></td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1"><span class="bold1">Description</span></td>
							  <td valign="top" class="boldEleven"><textarea name="memo" cols="30"
										rows="5" class="formText135" id="memo" tabindex="9">Ok, Approved</textarea></td>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td valign="top" class="boldEleven">							     						  </td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Buy Back </td>
							  <td valign="top" class="boldEleven"><%=data[0][23]%> </td>
							  <td valign="top" class="bold1"> Sales Number </td>
							  <td valign="top" class="boldEleven"><a target='_blank' href='SwapSaleSerialView.jsp?salno=<%=data[0][24]%>'><font class='boldgreen'><%=data[0][24]%></font></a> </td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Stock Mode </td>
							  <td valign="top" class="boldEleven">
							  <%
							if("S".equals(data[0][25]))
							  		out.println("DIRECT TO STOCK");
							else
								out.println("CUSTOMER PURCHASE ORDER");	
							 
							 if("C".equals(data[0][25]))
							  	 out.println("<br> CPO REF NUMBER : <a target='_blank' href='POVerificationViewin_PR_side.jsp?cporefnumber="+data[0][26]+"'>"+data[0][26]+"</a>");
								 
								  
							  %>							   </td>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td colspan="4" valign="top" class="bold1"><span class="boldEleven">
							    <%
if("C".equals(data[0][25]))
{ 
 	sql = " SELECT   a.CHR_TYPE ,a.CHR_ITEMID,a.CHR_DESC,";
	sql = sql +"  if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT' ), ";
	
	sql = sql +"  if( a.CHR_TYPE ='I' , ";
	sql = sql +"  (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
	sql = sql +"  (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
	sql = sql +"  ) productcode, ";
	
	sql = sql +"  if( a.CHR_TYPE ='I' , ";
	sql = sql +"  (SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID), ";
	sql = sql +"  (SELECT sa2.CHR_PRODUCTDESC FROM inv_m_produtlist sa2 WHERE sa2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
	sql = sql +"  ) productdescription, ";
	
	sql = sql +"  a.INT_QUANTITY, a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT, ";
	sql = sql +"  b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT, ";
	sql = sql +"  a.DOU_TOTAL,  ";
	sql = sql +"  if( a.CHR_TYPE ='I' , 'F' , ";
	sql = sql +"  (SELECT sa3.CHR_PTYPE  FROM inv_m_produtlist sa3 WHERE sa3.CHR_PRODUCTID =a.CHR_ITEMID)  ";
	sql = sql +"  ) ptype ,";
	
	
	sql = sql +" if( a.CHR_TYPE ='I' , (SELECT FUN_INV_ITEM_STOCK(a.CHR_ITEMID) ) ,  ";
	sql = sql +" if(((SELECT sa3.CHR_PTYPE FROM inv_m_produtlist sa3 WHERE sa3.CHR_PRODUCTID =a.CHR_ITEMID) = 'S') , ";
	sql = sql +" (SELECT FUN_INV_CONSUMABLE_STOCK(a.CHR_ITEMID) ),(SELECT FUN_INV_PRODUCT_STOCK(a.CHR_ITEMID))) )  ";
	sql = sql +"  stock ,a.INT_ID,  ";
	
	
	sql = sql +"  if( a.CHR_TYPE ='I' , "; 
	sql = sql +"  (SELECT FUN_INV_BRANCH_ITEM_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ) ,  ";
	sql = sql +"  if(((SELECT sa4.CHR_PTYPE FROM inv_m_produtlist sa4 WHERE sa4.CHR_PRODUCTID =a.CHR_ITEMID)= 'S'),"; 
	sql = sql +"  (SELECT FUN_INV_BRANCH_CONSUMABLE_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ), ";
	sql = sql +"  (SELECT FUN_INV_BRANCH_PRODUCT_STOCK(a.CHR_ITEMID,a.INT_BRANCHID)))  ";
	sql = sql +" ) branchstock1 ,";
	
	sql = sql +" IF(a.CHR_PR_FLAG ='Y','YES','NO') ,a.INT_PR_QTY,  ";
	sql = sql +" FIND_A_VENDOR_NAME(a.INT_PR_VENDOR_ID), a.DOU_PR_PRICE, a.CHR_PR_DESC , ";
	sql = sql +"  a.INT_WARRANTY, a.INT_PR_WARRANTY,  ";
	
	sql = sql +"  IF(  ";
	sql = sql +"  a.CHR_PR_FLAG ='Y' ,(a.INT_QUANTITY*a.DOU_PR_PRICE),  ";
	sql = sql +"  IF(  ";
	sql = sql +"  a.CHR_TYPE ='I' , a.INT_QUANTITY*(SELECT FUN_INV_BRANCH_STOCK_AVERAGEPRICE(a.CHR_TYPE,a.CHR_ITEMID,a.INT_BRANCHID)),  ";
	sql = sql +"  if(  ";
	sql = sql +"  (SELECT sa4.CHR_PTYPE FROM inv_m_produtlist sa4 WHERE sa4.CHR_PRODUCTID =a.CHR_ITEMID)= 'S',  ";
	sql = sql +"  a.INT_QUANTITY*(SELECT FUN_INV_BRANCH_CONSUMABLE_STOCK(a.CHR_ITEMID,a.INT_BRANCHID)) ,     ";    
	sql = sql +"  a.INT_QUANTITY*(SELECT FUN_INV_BRANCH_STOCK_AVERAGEPRICE(a.CHR_TYPE,a.CHR_ITEMID,a.INT_BRANCHID))  ";
	sql = sql +"  )  ";
	sql = sql +"  )  ";
	sql = sql +"  ) pprice  ";
	
	sql = sql +"  from inv_t_customersalesorderitem a ,inv_m_tax b  where a.INT_TAXID=b.INT_TAXID AND CHR_SALESORDERNO='"+data[0][26]+"'";
	//out.println(sql);
	 
	String itemDatas[][]=  CommonFunctions.QueryExecute(sql);
	int rlength=0;
	if(itemDatas.length>0)
		rlength=itemDatas.length;
		
	out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.print("<tr  class='MRow1'>");
	out.print("<th  class='boldEleven'  rowspan='2'><b>S.No</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Type</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Item / Product</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Description</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Quantity</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Warranty</b></th>");
	out.print("<th  class='boldEleven' colspan='2'><b>Stock Availability</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Unit Price</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Discount(%)</b></th>");
	out.print("<th  class='boldEleven  rowspan='2'><b>Unit Discount</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Tax</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Tax Value</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Tax Amount</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Total</b></th>");
	
	out.print("<th  class='boldEleven' rowspan='2'><b>Purchase Request</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Purchase Quantity</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Purchase Warranty</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Vendor</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>Purchase Unit price</b></th>");
	out.print("<th  class='boldEleven' rowspan='2'><b>NET PRICE</b></th> ");
	out.print("<th  class='boldEleven' rowspan='2'><b>Contribution</b></th> ");
	out.print("<th  class='boldEleven' rowspan='2'><b>Contribution(%)</b></th> ");
	
	
	
	out.print("</tr> ");
	out.print("<tr  class='MRow1'> ");
	out.print("<th class='boldEleven' ><b>Branch</th> ");
	out.print("<th class='boldEleven' ><b>Over All </th> ");
	out.print("</tr> ");
	int stock=0;
	int qty=0;
	double salesprice=0;
	double purchaseprice=0;	
	double contribution=0;
	double contributionpercentage=0;
	String  cc=" checked = 'checked' ";
	for(int u=0; u<itemDatas.length;u++)
	{
		
		stock=0;
		qty=0; 
		qty=Integer.parseInt(itemDatas[u][6]);
		stock=Integer.parseInt(itemDatas[u][15]);
		
		salesprice  = salesprice + (qty * Double.parseDouble(itemDatas[u][7]));
		purchaseprice = purchaseprice + Double.parseDouble(itemDatas[u][25]);
		contribution =((qty * Double.parseDouble(itemDatas[u][7])) - Double.parseDouble(itemDatas[u][25]) );
		
		contributionpercentage = (contribution /  Double.parseDouble(itemDatas[u][25])) *100;
		
		
		if(qty >stock)
			cc=" checked = 'checked' ";
		else
			cc="";	
			
		if(qty >stock)
			out.println("<tr  class='MRow2'>");
		else
			out.println("<tr bgcolor='#99FF00'>");	 
		
		out.println(" <td   class='boldEleven' >"+(u+1)+".</td>");
		out.println(" <td   class='boldEleven' >"+itemDatas[u][3]+"</td>");
		out.println("<td  class='boldEleven' >"+itemDatas[u][4] +"</td>");
		out.println("<td  class='boldEleven' >&nbsp;</td>");//"+itemDatas[u][5] +"
		out.println("<td  class='boldEleven' align='right' >"+itemDatas[u][6] +"</td>");
		out.println("<td  class='boldEleven' align='center' >"+itemDatas[u][23] +"-Yrs</td>");
		
		out.println("<td  class='boldEleven' ><font class='boldgreen'>"+itemDatas[u][17]+"</font></td>" );//Stock
		
		
		out.println("<td  class='boldEleven' ><font class='boldgreen'>"+itemDatas[u][15]+"</font> / " );//Stock
		
		if("S".equals(itemDatas[u][14]))
		{
			out.println(" CONSUMABLES / <a target='_blank' href='Rept_ConsumablesStocksPrint.jsp?Branch=0&division=0&product="+itemDatas[u][1] +"'>  Details</a> ");
		}
		else
		{
		//"Rept_ConsumablesStocksPrint.jsp?Branch=0&division=0product="+itemDatas[u][1]
		  out.println(" SERIALS / <a target='_blank' href='CPO_Rept_StockSerialPrint.jsp?Branch="+session.getAttribute("INVBRANCH")+"&itype="+itemDatas[u][0]+"&item="+itemDatas[u][1]+"&division=0&pgroup=0'> Details</a> ");
		}
		out.println("</td>");
		
		out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][7] +"</td>");
		out.println("<td  class='boldEleven'  align='right'  >"+itemDatas[u][8] +"</td>");
		out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][9] +"</td>");
		out.println("<td  class='boldEleven' >"+itemDatas[u][10] +"</td>");
	
		out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][11] +"</td>");
		out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][12] +"</td>");
		out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][13] +"</td>");
		
		//PR FLAG
		out.println("<td  class='boldEleven' >"+itemDatas[u][18] +"</td>");
		
		//Purchase Quantity
		 out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][19] +"</td>");
		 
		 //Purchase Warranty
		 out.println("<td  class='boldEleven'  align='center' >"+itemDatas[u][24] +"-Yrs</td>");
				
		//Vendor Name
		out.println("<td  class='boldEleven' >"+itemDatas[u][20] +"</td>");
		
		//unit purchase Price
		out.println("<td  class='boldEleven'  align='right' >"+itemDatas[u][21] +"</td>");
		
		//PRICE
		out.println("<td  class='boldEleven' align='right' >"+itemDatas[u][25] +"</td>");
		
		//Contribution
		out.println("<td  class='boldEleven' align='right' >"+MathFunction.keep2Digit(contribution)+"</td>");
		
		//Contribution(%)
		if(contributionpercentage <10)
			out.println("<td class='boldEleven' align='right'><img src='../images/alert.gif'>"+MathFunction.keep2Digit(contributionpercentage)+"%</td>");
		else
			out.println("<td class='boldEleven' align='right'>"+MathFunction.keep2Digit(contributionpercentage)+"%</td>");	
	
		out.println("</tr>");
	}
	
	out.println("<tr class='MRow1'>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven'  colspan='3' ><b>SUM OF SALES PRICE </b></td>");
	out.println("<td  class='boldEleven' align='right'><b>"+MathFunction.keep2Digit(salesprice)+"</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' colspan='2'><b>PURCHASE PRICE</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven'  align='right'><b>"+MathFunction.keep2Digit(purchaseprice)+"</td>");
	out.println("<td  class='boldEleven'  align='right'><b>"+MathFunction.keep2Digit(salesprice-purchaseprice)+"</td>");
	out.println("<td  class='boldEleven'  align='right'><b>"+MathFunction.keep2Digit( ((salesprice-purchaseprice) / purchaseprice )*100 ) +" % </td>");
	out.println("</tr>");
	
	
	 
	out.println("<tr class='MRow1'>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven'  colspan='3' ><b>CONTRIBUTION  PERCENTAGE </b></td>");
	out.println("<td  class='boldEleven' align='right'><b>"+MathFunction.keep2Digit( ((salesprice-purchaseprice) / purchaseprice )*100 ) +" % </td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("<td  class='boldEleven' >&nbsp;</td>");
	out.println("</tr>");
	out.print("</table> ");
					
}
%>
</span></td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
						<tr>
							  <td height="17" colspan="4" valign="top" class="formTableOuterDesign">PURCHASE REQUEST DETAILS </td>
						  </tr>
							
							 
							 
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto">
							<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >
								<tr class="MRow1">
									  <th class="boldEleven"><b>S.No</b></th>
									  <th class="boldEleven"><b>Vendor</b></th>
									  <th class="boldEleven"><b>Type</b></th>
									  <th class="boldEleven"><b>Item / Product Code</b></th>
									  <th class="boldEleven"><b>Description</b></th>
									  <th class="boldEleven"><b>Quantity</b></th>
									  <th class="boldEleven"><strong><b>Unit PurchasePrice</strong></th>
									  <th class="boldEleven"><strong><b>PurchasePrice</strong></th>
									  <th class="boldEleven"><strong><b>Unit Sale Price</strong></th>
									  <th class="boldEleven"><strong><b>Sale Price</strong></th>
									  
									  <th class="boldEleven"><strong><b>If Installation /Delivery/Additional Warranty Required: Yes/No</strong></th>
									  <th class="boldEleven"><strong><b>Installation</strong></th>
									  <th class="boldEleven"><strong><b>Delivery</strong></th>
									  <th class="boldEleven"><strong><b>Additional Warranty</strong></th>
									  <th class="boldEleven"><strong><b>Gross Sale Value</strong></th>
								</tr>
								<%
		  
		   sql = " SELECT if(a.CHR_TYPE=\"I\",\"Item\",\"Product\"), ";
		 sql = sql +" if(a.CHR_TYPE=\"I\",(SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID=a.CHR_ITEMID) , ";
		 sql = sql +" (SELECT d.CHR_PRODUCTCODE  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID) ";
		 sql = sql +"  ), ";
		 sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_PURCHASEPRICE,DOU_UNITSALEPRICE,a.DOU_SALESPRICE, ";
		 sql = sql +" if(a.CHR_ADDITIONALWARRANTY=\"Y\",\"Yes\",\"No\"), a.DOU_INSTALLATION, a.DOU_DELIVERY,a.DOU_ADDITIONALWARRANTY, ";
		 sql = sql +" a.DOU_GROSSVALUE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, a.CHR_ACCEPT,a.INT_ROWID,a.DOU_UNITSALEPRICE, ";
		 sql = sql +" ROUND(a.DOU_SALESPRICE/a.INT_QUANTITY,2)  ,b.CHR_VENDORNAME  "; 
		 sql = sql +"  FROM inv_t_purchaserequestitem  a , inv_m_vendorsinformation  b ";
		 sql = sql +" WHERE a.INT_VENDORID  =b.INT_VENDORID  AND a.CHR_POREQUESTNO='"+Requestno+"' ORDER BY a.CHR_TYPE  ";
		 String itemDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 if(itemDatas.length>0)
		 {
				for(int u=0;u<itemDatas.length;u++)
				{
				 
					if(u%2==0)
						out.print("<tr class='MRow1'>");
					else
						out.print("<tr class='MRow1'>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+(u+1)+".</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][19] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][0] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>"+itemDatas[u][1] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   valign='top'>&nbsp;</td>");//"+itemDatas[u][2] +"
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][3] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][4] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][5] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][6] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][7] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='left'>"+itemDatas[u][8] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][9] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][10] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][11] +"</td>");
					out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][12] +"</td>");
				}
			}
		%>	 
							</table>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="22" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="buttonbold14">COMMITMENT DETAILS </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><table width="90%" height="205" border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#9900CC">
                                <tr>
                                  <td><div align="center"><strong>SALES</strong></div></td>
                                  <td><div align="center"><strong>PURCHASE REQUEST </strong></div></td>
                                </tr>
                                <tr>
                                  <td width="50%"><table width="90%"   align="center" cellpadding="2" cellspacing="1" bordercolor="#000000">
                                    <tr class="MRow1">
                                      <td width="35%" class="boldEleven"><strong>CUSTOMER SALES</strong></td>
                                      <td width="22%" class="boldEleven"><div align="right">
                                        <%
double sum1=0;	
double sum2=0;									  
sql = " SELECT   f.CHR_BRANCHNAME , a.CHR_INVOICETYPE,   ";
sql = sql + " SUM(a.DOU_COMMITMENTAMOUNT), SUM(a.DOU_RECEIVEDAMOUNT),  SUM(a.DOU_COMMITMENTAMOUNT-a.DOU_RECEIVEDAMOUNT)   ";
sql = sql + " FROM inv_t_paymentcommitment a,inv_t_directsales b,  com_m_branch f   ";
sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESNO   ";
sql = sql + " AND a.CHR_INVOICETYPE='C'	 	AND a.CHR_PAYMENTFLAG != 'Y' 	 ";
sql = sql + " AND b.INT_BRANCHID =f.INT_BRANCHID  	  ";  
sql = sql + " AND  a.DT_COMMITMENTDATE  >= '"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0]  +"'"; 
sql = sql + " AND  a.DT_COMMITMENTDATE  <= '"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0] +"'"; 
sql = sql + " AND  b.INT_BRANCHID="+data[0][22];
sql = sql + " GROUP BY b.INT_BRANCHID  	";
 
link="CommitmentDetails.jsp?salestype=C&Branch="+data[0][22]+"&division="+data[0][17]+"&fromdate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT( DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' )")[0][0]+"&todate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' ) ")[0][0];

String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(data1.length>0)
{
	out.println(data1[0][4]);
	sum1 = sum1+Double.parseDouble(data1[0][4]);
}
else
	out.println("0");
	%>                                      
                                      </div></td>
									  
									  
                                      <td width="43%" class="boldEleven"><div align="right"><a href="<%=link%>" target="_blank"><font class="bolddeepred">Details</font>&nbsp;&nbsp;<img src="../Image/report/text.png"></a></div></td>
                                    </tr>
                                    <tr class="MRow1">
                                      <td class="boldEleven"><strong>DIRECT BILLING</strong></td>
                                      <td class="boldEleven"><div align="right">
                                        <%
sql = " SELECT   f.CHR_BRANCHNAME , a.CHR_INVOICETYPE,   ";
sql = sql + " SUM(a.DOU_COMMITMENTAMOUNT), SUM(a.DOU_RECEIVEDAMOUNT),  SUM(a.DOU_COMMITMENTAMOUNT-a.DOU_RECEIVEDAMOUNT)   ";
sql = sql + " FROM inv_t_paymentcommitment a,inv_t_directbilling b,  com_m_branch f   ";
sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESNO   ";
sql = sql + " AND a.CHR_INVOICETYPE='D'	  	AND a.CHR_PAYMENTFLAG != 'Y' 	";
sql = sql + " AND b.INT_BRANCHID =f.INT_BRANCHID  	  ";  
sql = sql + " AND  a.DT_COMMITMENTDATE  >= '"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0]  +"'"; 
sql = sql + " AND  a.DT_COMMITMENTDATE  <= '"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0] +"'"; 
sql = sql + " AND  b.INT_BRANCHID="+data[0][22];
sql = sql + " GROUP BY b.INT_BRANCHID  	";	
link="CommitmentDetails.jsp?salestype=D&Branch="+data[0][22]+"&division="+data[0][17]+"&fromdate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT( DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' )")[0][0]+"&todate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT( DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y') ")[0][0];

String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

if(data2.length>0)
{
	out.println(data2[0][4]);
	sum1 = sum1+Double.parseDouble(data2[0][4]);
}
else
	out.println("0");	%>                                      
                                      </div></td>
                                      <td class="boldEleven"><div align="right"><a href="<%=link%>" target="_blank"><font class="bolddeepred">Details </font> &nbsp;&nbsp;<img src="../Image/report/text.png"></a></div></td>
                                    </tr>
                                    <tr class="MRow1">
                                      <td class="boldEleven"><strong>SERVICE BILLING</strong></td>
                                      <td class="boldEleven"><div align="right">
                                        <%							  
 sql = " SELECT   f.CHR_BRANCHNAME , a.CHR_INVOICETYPE,   ";
sql = sql + " SUM(a.DOU_COMMITMENTAMOUNT), SUM(a.DOU_RECEIVEDAMOUNT),  SUM(a.DOU_COMMITMENTAMOUNT-a.DOU_RECEIVEDAMOUNT)   ";
sql = sql + " FROM inv_t_paymentcommitment a,inv_t_servicebilling b,  com_m_branch f   ";
sql = sql + " WHERE a.CHR_SALESNO=b.CHR_SALESNO   ";
sql = sql + " AND a.CHR_INVOICETYPE='S'	  	AND a.CHR_PAYMENTFLAG != 'Y' 	";
sql = sql + " AND b.INT_BRANCHID =f.INT_BRANCHID  	  ";  
sql = sql + " AND  a.DT_COMMITMENTDATE  >= '"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0]  +"'"; 
sql = sql + " AND  a.DT_COMMITMENTDATE  <= '"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0] +"'"; 
sql = sql + " AND  b.INT_BRANCHID="+data[0][22];
sql = sql + " GROUP BY b.INT_BRANCHID  	";	
link="CommitmentDetails.jsp?salestype=S&Branch="+data[0][22]+"&division="+data[0][17]+"&fromdate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT( DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' )")[0][0]+"&todate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' )")[0][0];

 String data3[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(data3.length>0)
{
	out.println(data3[0][4]);
	sum1 = sum1+Double.parseDouble(data3[0][4]);
}
else
	out.println("0");%>                                      
                                      </div></td>
                                      <td class="boldEleven"><div align="right"><a href="<%=link%>" target="_blank"><font class="bolddeepred">Details</font>&nbsp;&nbsp;<img src="../Image/report/text.png"> </a></div></td>
                                    </tr>
                                    <tr class="MRow1">
                                      <td class="boldEleven"><strong>TOTAL</strong></td>
                                      <td class="boldEleven"><div align="right"><%=sum1%></div></td>
                                      <td class="boldEleven"><div align="right"></div></td>
                                    </tr>
                                  </table></td>
                                  <td width="62%" align="center" valign="middle"><table width="80%" cellpadding="2" cellspacing="1" bordercolor="#000000">
                                    <tr class="MRow1">
                                      <td>PURCHASE </td>
                                      <td>
									  
									    <div align="right">
									      <%
									  
sql = " SELECT SUM(b.DOU_SALESPRICE)  ";
sql = sql + " FROM inv_t_purchaserequest a, inv_t_purchaserequestitem b  ";
sql = sql + " WHERE b.CHR_ACCEPT='Y' AND a.CHR_CLOSEDSTATUS='Y' AND a.INT_BRANCHID="+data[0][22];
sql = sql + " AND a.DAT_COMMITMENTDATE >='"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0]  +"'"; 
sql = sql + " AND a.DAT_COMMITMENTDATE <='"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY) ")[0][0]  +"'"; 
sql = sql + " GROUP BY a.INT_BRANCHID  ";
 
link="PRCommitmentDetails.jsp?Branch="+data[0][22]+"&fromdate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT( DATE_SUB('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' )")[0][0]+"&todate="+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DATE_ADD('"+data[0][21]+"', INTERVAL 2 DAY),'%d-%m-%Y' )")[0][0];


String data4[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(data4.length>0)
{
	out.println(data4[0][0]);
	sum2 = sum2+Double.parseDouble(data4[0][0]);
}
else
	out.println("0");
	
%>									  
						          </div></td>
                                      <td><div align="right"><a href='<%=link%>' target="_blank"><font class="bolddeepred">Details</font>&nbsp;&nbsp;<img src="../Image/report/text.png"></a></div></td>
                                    </tr>
                                  </table></td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							  							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><input name="filename" type="hidden" value="PurchaseRequest" />
							    <input name="actionS"
									type="hidden" value="INVPurchaseRequestClosed" />
							    <input name="Requestno" type="hidden" id="Requestno" value="<%=Requestno%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="250" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Purchase Request Closed"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('PurchaseRequestClosed.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language="JavaScript">

function Validate()
  {

	 
	 	
	if( 
	
	 checkNull( "memo","Enter Description" )
 	
	)
		return true;
	else
		return false;				
		
 } 	
 
  
 
  
	
  
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
out.println(e.getMessage());
}
%>