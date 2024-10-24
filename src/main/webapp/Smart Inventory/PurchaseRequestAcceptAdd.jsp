<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.Math.*"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.InventoryInvoiceFunctions"%>
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
<table width="900" border="0" cellspacing="1" cellpadding="1">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">PURCHASE REQUEST APPROVAL
									
									
									<%
				String Requestno = request.getParameter("Requestno");							
				String sql = " ";
				sql = " SELECT "; 
				sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
				sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
				sql = sql + " f.CHR_PAYMENTNAME, ";
				sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
				sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID ,IF(a.CHR_BYBACK='Y','BUY BACK',''),a.CHR_SALESNO , ";
				sql = sql + " a.CHR_MODE, a.CHR_CPOREF_NUMBER";
				sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d, inv_m_customergroup h, ";
				sql = sql + " inv_m_paymentterms f,com_m_staff g ";
				sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
				sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID= h.INT_CUSTOMERGROUPID ";
				 
				sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
				sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
				//out.println(sql);
				String data[][] =  CommonFunctions.QueryExecute(sql);
				
				double contributionlevel =0;
				boolean contributionflag = false;
				boolean contributionflag1 = false;
				String cdata[][] =  CommonFunctions.QueryExecute("SELECT INT_CONTRIBUTION_LEVEL1 FROM  m_inventorysetting WHERE INT_ROWID=1");
				if(cdata.length>0)
					contributionlevel = Double.parseDouble(cdata[0][0]);
				
				
									%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
								<td width="118" height="17" valign="top" class="bold1">Request date </td>
							  <td width="199" align="left" valign="top"><span class="boldEleven"><%=data[0][3] +"  dated on " +data[0][4]%></span></td>
							    <td width="105" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
						        <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="bold1"><div align="left">CustomerName</div></td>
							  <td align="left"><span class="boldEleven"><%=data[0][5]%>
                                  <input name="customer" type="hidden" id="customer" value="<%=data[0][18]%>">
                              </span></td>
						      <td class="bold1">Vendor Payment </td>
						      <td class="boldEleven"><%=data[0][7]%> </td>
							</tr>
							<tr>
							  <td class="bold1">Division</td>
							  <td class="boldEleven"><%=data[0][2]%>
                                <input name="divis" type="hidden" id="divis" value="<%=data[0][17]%>"></td>
							  <td class="bold1">Customer Commitment days </td>
							  <td class="boldEleven"><%=data[0][8]+"- Days"%> </td>
							</tr>
							<tr>
							  <td valign="top" class="bold1">Description </td>
							  <td valign="top" class="boldEleven"><%=data[0][11]%>  </td>
							  <td valign="top" class="bold1">M.E </td>
							  <td valign="top" class="boldEleven"><%=data[0][9]+" / "+data[0][10]%> </td>
							</tr>
							<tr>
							  <td valign="top" class="bold1">Accept
							  <%
							  String s1="";
							  String s2="";
							  String s3="";
							  if("Y".equals(data[0][12]))
							  	s1= " checked = 'checked' ";
							  
							  if("N".equals(data[0][12]) || "H".equals(data[0][12]) )
							  	s2= " checked = 'checked' ";
								
							  if("R".equals(data[0][12]))
							  	s3= " checked = 'checked' ";
							 
							  %>							  </td>
							  <td valign="top" class="boldEleven"><table width="239" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="boldEleven"><input name="Accept" type="radio" value="Y" <%=s1%>></td>
                                  <td class="boldEleven">Accept</td>
                                  <td class="boldEleven"><input name="Accept" type="radio" value="H" <%=s2%>></td>
                                  <td class="boldEleven">Hold</td>
                                  <td class="boldEleven"><input name="Accept" type="radio" value="R" <%=s3%>></td>
                                  <td class="boldEleven">Reject</td>
                                </tr>
                              </table></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1"><span class="bold1">Description </span><span class="errormessage">*</span> </td>
							  <td valign="top" class="boldEleven"><textarea name="memo" cols="30"
										rows="5" onKeyUp="textArea('memo','500')" class="formText135" id="memo" tabindex="9"><%=data[0][15]%></textarea></td>
							  <td valign="top" class="bold1">Accepted By </td>
							  <td valign="top" class="boldEleven">
							  <select name="ref" id="ref"
										class="formText135" size="5">
										<jsp:include page="staffloadReportinghead.jsp" flush="true" />
</select><script language="javascript">setOptionValue('ref','<%=""+session.getAttribute("EMPID")%>')</script>							  </td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Buy Back </td>
							  <td valign="top" class="boldEleven"><%=data[0][19]%> </td>
							  <td valign="top" class="bold1"> Sales Number </td>
							  <td valign="top" class="boldEleven"><a target='_blank' href='SwapSaleSerialView.jsp?salno=<%=data[0][20]%>'><font class='boldgreen'><%=data[0][20]%></font></a> </td>
						  </tr>
							 
							<tr>
							  <td valign="top" class="bold1"><span class="boldEleven">OVERALL STOCK AVAILABILITY </span></td>
							  <td valign="top" class="boldEleven"><%
							  
							 if("C".equals(data[0][21]))
							 {  
								String sflag = InventoryInvoiceFunctions.CPOReasdytoBill(data[0][22]);
								if(sflag =="B")
									out.println("<font class='bolddeepred'><h1>Stock Available</h1></font>");
								else if(sflag =="P")
									out.println(" <font class='boldgreen'><h1>Stock Partially Available</h1></font> ");
								else	
									out.println(" <font class='boldgreen'><h1>Stock not Available</h1></font> ");
								
						   out.println("<input id='saleorderapproval' name='saleorderapproval' type='hidden' id='saleorderapproval' value='Y'>");
									
							}			
								
						 %></td>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="bold1">Stock Mode </td>
							  <td valign="top" class="boldEleven"><font class='boldgreen'>
							  <%
							if("S".equals(data[0][21]))
							  		out.println("DIRECT TO STOCK");
							else
								out.println("CUSTOMER PURCHASE ORDER");	
							 
							 if("C".equals(data[0][21]))
							  	 out.println("<br> CPO REF NUMBER : <a target='_blank' href='POVerificationViewin_PR_side.jsp?cporefnumber="+data[0][22]+"'>"+data[0][22]+"</a>");
								 
								  
							  %>
							   <input name="stockmode" type="hidden" id="stockmode" value="<%=data[0][21]%>">
							   <input name="cporefnumber" type="hidden" id="cporefnumber"  value="<%=data[0][22]%>">
							  </font></td>
							  <td valign="top" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							 
							
							
							 
							 
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
<%
if("C".equals(data[0][21]))
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
	
	sql = sql +"  from inv_t_customersalesorderitem a ,inv_m_tax b  where a.INT_TAXID=b.INT_TAXID AND CHR_SALESORDERNO='"+data[0][22]+"'";
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
		if(contributionpercentage < contributionlevel)
		{
			out.println("<td class='boldEleven' align='right'><img src='../images/alert.gif'>"+MathFunction.keep2Digit(contributionpercentage)+"%</td>");
			contributionflag = true;
		}	
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
%>							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="formTableOuterDesign">PURCHASE REQUEST DETAILS </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">

 
<%
sql = " SELECT if(a.CHR_TYPE=\"I\",\"Item\",\"Product\"), ";
sql = sql +" if(a.CHR_TYPE=\"I\",(SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID=a.CHR_ITEMID) , ";
sql = sql +" (SELECT d.CHR_PRODUCTCODE  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID) ";
sql = sql +"  ), ";
sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_PURCHASEPRICE,DOU_UNITSALEPRICE,a.DOU_SALESPRICE, ";
sql = sql +" if(a.CHR_ADDITIONALWARRANTY=\"Y\",\"Yes\",\"No\"), a.DOU_INSTALLATION, a.DOU_DELIVERY,a.DOU_ADDITIONALWARRANTY, ";
sql = sql +" a.DOU_GROSSVALUE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, a.CHR_ACCEPT,a.INT_ROWID,a.DOU_UNITSALEPRICE, ";
sql = sql +" ROUND(a.DOU_SALESPRICE/a.INT_QUANTITY,2)  ,b.CHR_VENDORNAME,DOU_MARGIN,a.CHR_TYPE ,a.CHR_ITEMID "; 
sql = sql +"  FROM inv_t_purchaserequestitem  a , inv_m_vendorsinformation  b ";
sql = sql +" WHERE a.INT_VENDORID  =b.INT_VENDORID  AND a.CHR_POREQUESTNO='"+Requestno+"' ORDER BY a.CHR_TYPE  ";
String itemDatas[][] =  CommonFunctions.QueryExecute(sql);
if(itemDatas.length>0)
{
	out.print("<div id='divscroll' style='OVERFLOW:auto;width:100%;height:auto'>  ");
	out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ");
	out.print("<tr class='MRow1'> ");
	out.print("<th class='boldEleven'><b>S.No</b></th> ");
	out.print("<th class='boldEleven'><b>Vendor</b></th> ");
	out.print("<th class='boldEleven'><b>Type</b></th> ");
	out.print("<th class='boldEleven'><b>Item / Product Code</b></th> ");
	out.print("<th class='boldEleven'><b>Description</b></th> ");
	out.print("<th class='boldEleven'><b>Quantity</b></th> ");
	out.print("<th class='boldEleven'><strong><b>Unit PurchasePrice</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>PurchasePrice</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Unit Sale Price</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Sale Price</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Contribution</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Contribution(%)</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>If Installation /Delivery/Additional Warranty Required: Yes/No</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Installation</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Delivery</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Additional Warranty</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Gross Margin</strong></th> ");
	out.print("<th class='boldEleven'><strong><b>Margin (%)</strong></th> ");
	out.print("<th class='boldEleven' colspan='2' align='center' > ");
	/*out.print("<table width='169' height='22' border='0' cellpadding='0' cellspacing='0'   align='center'> ");
	out.print("<tr> ");
	out.print("<td width='20' class='boldEleven'><label>  ");
	//out.print("<input id='Astatus' name='Astatus' type='checkbox' value='A' onClick=\"Acceptall('Astatus')\" > ");
	out.print("</label></td> ");
	out.print("<td width='69' class='boldEleven'>Accept All</td> ");
	out.print("<td width='20' class='boldEleven'> ");
	//out.print("<input name='Rstatus'  id='Rstatus' type='checkbox' value='R' onClick=\"Rjectall('Rstatus')\" ></td> ");
	out.print("<td width='60' class='boldEleven'>Reject All</td> ");
	out.print("</tr> ");
	out.print("</table>	 ");*/
	out.print("</th> </tr> ");

		
		
		for(int u=0;u<itemDatas.length;u++)
		{
			 
			if(u%2==0)
				out.print("<tr class='MRow1'>");
			else
				out.print("<tr class='MRow2'>");
				
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
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][13] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][14] +"</td>");//Contribution
		    out.println("<td  class='boldEleven' valign='top'   align='left'>"+itemDatas[u][8] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][9] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][10] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][11] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][12] +"</td>");
			out.println("<td  class='boldEleven' valign='top'   align='right'>"+itemDatas[u][20] +"</td>");
			if(Double.parseDouble(itemDatas[u][14]) < contributionlevel)
					contributionflag1 = true;
				
			if("N".equals(itemDatas[u][15]))
				out.println("<td class='boldEleven' ><table border='0'><tr><td><input type='checkbox' id='accept"+u+"' name='accept"+u+"' checked  onclick=Accept('accept"+u+"')></td><td>Accept</td><td><input type='checkbox' id='reject"+u+"' name='reject"+u+"' onclick=Reject('reject"+u+"') ></td><td>Reject</td></table></td>");
			else if("Y".equals(itemDatas[u][15]))
				out.println("<td class='boldEleven'><font >Accept</font></td>");
			else if("R".equals(itemDatas[u][15]))
				out.println("<td class='boldEleven'><font >Reject</font></td>");
				
			out.println("<td class='boldEleven'><input name='dec"+u+"' type='text' class='formText135' id='dec"+u+"' size='15' maxlength='100'> ");
			
			out.println("<input name='rowid"+u+"' type='hidden'  id='rowid"+u+"' size='15'  value='"+itemDatas[u][16]+"'>");
		}
		
			
		sql = " SELECT SUM(INT_QUANTITY),SUM(DOU_UNITPRICE),SUM(DOU_PURCHASEPRICE),SUM(DOU_UNITSALEPRICE), ";
		sql = sql + "SUM(DOU_SALESPRICE), SUM(DOU_GROSSVALUE),SUM(DOU_CONTRIBUTION), SUM(DOU_CONTRIBUTION_PERCENTAGE) ";
		sql = sql + " FROM inv_t_purchaserequestitem WHERE CHR_POREQUESTNO='"+Requestno+"' ORDER BY CHR_TYPE ";
		String sumdata[][] = CommonFunctions.QueryExecute(sql);
		out.print("<tr class='MRow1'>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][2] +"</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][4] +"</td>");
		out.print("<td  class='boldEleven' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>&nbsp;"+ sumdata[0][6] +"</td>");
		out.println("<th class='boldEleven'><strong><b>&nbsp; </strong></th>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'><img src=\"../Image/report/Rupee.gif\" width='10' height='10'>"+ sumdata[0][5] +"</td>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.println("<th class='boldEleven'><strong><b>&nbsp; </strong></th>");
		out.print("<td  class='boldEleven'  valign='top' align='right'>&nbsp;</td>");
		out.print("</tr>"); 	
		
		out.print("</table>");
	out.print("</div>");

		
}
	
%>														   
<input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= itemDatas.length%>> </td>
						  </tr>
							 
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							   
							   							  </td>
							  <td colspan="3" align="left">
							   							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><input name="filename" type="hidden" value="PurchaseRequest" />
							    <input name="actionS"
									type="hidden" value="INVPurchaseRequestAccept" />
							    <input name="Requestno" type="hidden" id="Requestno" value="<%=Requestno%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Approval"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('PurchaseRequestAccept.jsp')"></td>
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
	
	 checkNull( "ref","Select reference" )
	 && checkNull( "memo","Enter Description" )
	 
	 && valid()
	 
	 
 	
	)
		return true;
	else
		return false;				
		
 } 	
 
 
 function disabletxt()
	{
	
		var len=document.getElementById("dec").value;
		for(var i=0;i<len;i++)
		{
		  var fline="dec"+i;
		  document.getElementById(fline).style.visibility="hidden";
	    }
	}
	
	function Reject(ctr)
	{
		var len=document.getElementById(ctr).value;
		var l=ctr.substring(6);
		var fline="dec"+l;
		var f ="accept"+l;
		if(document.getElementById(ctr).checked )
		{
			document.getElementById(f).style.visibility="hidden";
			document.getElementById(fline).style.visibility="visible";
		}
		else
		{
			document.getElementById(f).style.visibility="visible";
			document.getElementById(fline).style.visibility="hidden";
		}
	}

	function Accept(ctr)
	{
		var len=document.getElementById(ctr).value;
		var l=ctr.substring(6);
		var fline="dec"+l;
		var f ="reject"+l;
		if(document.getElementById(ctr).checked )
		{
			document.getElementById(f).style.visibility="hidden";
			document.getElementById(fline).style.visibility="hidden";
		}
		else
		{
			document.getElementById(f).style.visibility="visible";
			//document.getElementById(fline).style.visibility="visible";
		}
	}
 
 function Acceptall(ctr)
	{
		var len=document.getElementById("dec").value;
		 
		if(document.getElementById(ctr).checked)
		{
			document.getElementById('Rstatus').style.visibility="hidden";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=true;
				document.getElementById(f).style.visibility="hidden";
				document.getElementById(f).checked=false;
				document.getElementById(f0).style.visibility="hidden";
	    	}
		}
		else
		{
			
			document.getElementById('Rstatus').style.visibility="visible";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=false;
				document.getElementById(f).style.visibility="visible";
				document.getElementById(f).checked=false;
				document.getElementById(f0).style.visibility="hidden";
	    	}
		}
	}
	
	
	function Rjectall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			document.getElementById('Astatus').style.visibility="hidden";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="hidden";
		  		document.getElementById(fline).checked=false;
				document.getElementById(f).style.visibility="visible";
				document.getElementById(f).checked=true;
				document.getElementById(f0).style.visibility="visible";
	    	}
		}
		else
		{
			document.getElementById('Astatus').style.visibility="visible";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var f = "reject"+i;
				var f0 = "dec"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=false;
				document.getElementById(f).style.visibility="visible";
				document.getElementById(f).checked=false;
				document.getElementById(f0).style.visibility="hidden";
	    	}
		}
	}
	
  
  
function valid()
{
	try
	{
		var len=document.getElementById("dec").value;
		var acount=0;
		var rcount=0;
		for(var i=0;i<len;i++)
		 if(document.getElementById("accept"+i).checked)	  	
			acount=acount+1;
		
		for(var i=0;i<len;i++)
		 if(document.getElementById("reject"+i).checked)	  	
			rcount=rcount+1;
		
		if((acount<=0)&&(rcount<=0))
		{
			alert("Select Atleast One  Accept or Reject");
			return false;
		}	
		else
		{
			return true;
		}	
	}
	catch(err)
	{
		alert(err);
	}	
}	


function atleastOneAccept()
{
	var len=document.getElementById("dec").value;
	var acount=0;
	for(var i=0;i<len;i++)
	 if(document.getElementById("accept"+i).checked)	  	
	 	acount=acount+1;
	
	if((acount<=0) )
	{
		alert("Select Atleast One  Accept or Reject");
		return false;
	}	
	else
	{
		return true;
	}	
}
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch (Exception e) 
{
	System.out.println(e.getMessage());
	
}

%>