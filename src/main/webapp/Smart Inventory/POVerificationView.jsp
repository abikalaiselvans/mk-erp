 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{

String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,UPPER(CHR_VENDORNAME) from  inv_m_vendorsinformation ");
String vendoroption="<option value=''>Select Vendor</option>";
for(int u=0; u<vendorids.length; u++)
	vendoroption = vendoroption +"<option value='"+vendorids[u][0]+"'>"+vendorids[u][1].replaceAll("&","AND") +"</option>" ;


%>
<html>
<head>
<title>:: INVENTORY ::</title> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
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
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
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
             <td width="412"><table width="800" border="0" align="center" cellpadding="1"
						cellspacing="1">
                 <tr>
                   <td width="650"></td>
                 </tr>
                 <tr>
                   <td><div align="center"><strong>CUSTOMER PURCHASE ORDER VERIFICATION 
<%
String sql ="";
sql ="";
String rowid = request.getParameter("rowid");
sql = "SELECT a.INT_ROWID, a.CHR_SALESORDERNO	,a.CHR_QUOTATIONNO,		";
sql = sql+ " a.CHR_CUSTPURCHASENO,	";
sql = sql+ " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),FUN_INV_DIVISION(a.INT_DIVIID),	";
sql = sql+ " DATE_FORMAT(a.CHR_PURCHASEORDER_DATE,'%d-%b-%Y'),		";
sql = sql+ " DATE_FORMAT(a.CHR_DELIVERY_DATE,'%d-%b-%Y'),		";
sql = sql+ " a.CHR_BILLINGADDRESS,a.CHR_SHIPINGADDRESS,a.CHR_ONHOLD,a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO,		";
sql = sql+ " c.CHR_PAYMENTNAME,a.CHR_DES,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_AMOUNT,		";
sql = sql+ " a.DOU_DISCOUNT,b.CHR_TAXNAME,b.DOU_VALUE,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT, 	";
sql = sql+ " a.INT_PAYMENT_COMMITMENT_DAYS, 		";
sql = sql+ " a.CHR_OTHERREF,a.CHR_DELIVERYNOTE,a.CHR_DESPATCHTHRU,a.CHR_DESTINATION,a.CHR_TERMSOFDELIVERY,"; 
sql = sql+ " IF(a.CHR_TAXTYPE='S','SINGLE','MULTIPLE'),d.CHR_PROJECTNAME,";
sql = sql+ " IF(a.CHR_INSTALLATION='Y','YES','NO'),IF(a.CHR_MULTIPLE_LOCATION='Y','YES','NO') ,";
sql = sql+ " a.INT_DIVIID, a.CHR_REF,a.INT_PAYMENTTERMID,a.INT_CUSTOMERID,a.CHR_POREQUESTNO, ";
sql = sql+ " a.CHR_RFC_DESC, a.CHR_PR_MOFICIATION_DESC,a.CHR_ORCDESC ";
sql = sql+ " FROM inv_t_customersalesorder a , inv_m_tax b , inv_m_paymentterms c  , inv_m_project d WHERE a.INT_TAXID =b.INT_TAXID	  AND a.INT_PROJECTID =d.INT_PROJECTID ";
sql = sql+ " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID AND a.INT_ROWID = "+rowid;
//out.println(sql);
String cpodata[][] =  CommonFunctions.QueryExecute(sql);	


%>
				   
				   </strong></div></td>
                 </tr>
                 <tr>
                   <td><table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
                        
                       <tr>
                         <td align="left" valign="top" class="bold1">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="bold1">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       <tr>
                         <td width="269" align="left" valign="top" class="bold1"><div align="left">Customer <span class="boldEleven"> </span></div></td>
                         <td width="180" align="left" valign="top" class="boldEleven"><%=cpodata[0][4]%>
                            
                           <br>
                           <%=cpodata[0][8]%></td>
                         <td align="left" valign="top" class="bold1"><div align="left">Shipping To</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][9]%> </td>
                       </tr>
                       <tr>
                         <td align="left" class="bold1"><div align="left">Quotaion Ref No</div></td>
                         <td class="boldEleven"><%=cpodata[0][2]%></td>
                         <td width="160" align="left" valign="top" class="bold1"><div align="left">Order Reference</div></td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][23]%></td>
                       </tr>
                       <tr>
                         <td align="left" class="bold1">P.O Ref No</td>
                         <td class="boldEleven"><%=cpodata[0][1]%>
                          </td>
                         <td width="160" align="left" valign="top" class="bold1"><div align="left">Delivery Note</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][24]%></td>
                       </tr>
                       <tr>
                         <td align="left" class="bold1"> P.O Number </td>
                         <td class="boldEleven"><%=cpodata[0][3]%></td>
                         <td width="160" align="left" valign="top" class="bold1"><div align="left">Despatch Through</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][25]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven"><span class="bold1"> P.O date </span></td>
                         <td class="boldEleven"><%=cpodata[0][6]%></td>
                         <td width="160" align="left" valign="top" class="bold1"><div align="left">Destiantion</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][26]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven"><span class="bold1">Payment Terms<span class="ui-state-error-text"> </span></span></td>
                         <td class="boldEleven">
                         
                          <input name="payment" type="hidden" id="payment" value="<%=cpodata[0][34]%>"></td>
                         <td width="160" align="left" valign="top" class="bold1"><div align="left">Terms of Delivery</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][27]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven"><span class="bold1">Delivery Date </span></td>
                         <td class="boldEleven"><%=cpodata[0][7]%></td>
                         <td width="160" align="left" valign="top" class="bold1">Contact Person<span class="ui-state-error-text"> </span></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][11]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="bold1">Payment Commitment Days <span class="ui-state-error-text"> </span></td>
                         <td class="boldEleven"><%=cpodata[0][22]+"- Days"%>
                          </td>
                         <td width="160" align="left" valign="top" class="bold1">Contact No.<span class="ui-state-error-text"> </span></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][12]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="bold1">Installation / Implementation Required</td>
                         <td class="boldEleven"><%=cpodata[0][30]%></td>
                         <td width="160" align="left" valign="top" class="bold1">Division</td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][5]%>
                           
                          </td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven"><span class="bold1">Billed in Multiple Location</span></td>
                         <td class="boldEleven"><%=cpodata[0][31]%></td>
                         <td class="bold1">Tax Type</td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][28]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="bold1"> <span class="boldElevenlink">PURCHASE REQUEST </span></td>
                         <td class="boldEleven"><%=cpodata[0][36]%> </td>
                         <td valign="top" class="bold1">Project</td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][29]%></td>
                       </tr>
                        
                       <tr>
                         <td align="left" valign="top" class="boldEleven">RFC Description </td>
                         <td class="boldEleven"><%=cpodata[0][37]%></td>
                         <td align="left" valign="top" class="bold1"><span class="boldEleven">ORC Description </span></td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][39]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven">PR Description</td>
                         <td class="boldEleven"><%=cpodata[0][38]%></td>
                         <td align="left" valign="top" class="bold1">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven">&nbsp; </td>
                         <td class="boldEleven">&nbsp;</td>
                         <td width="160" align="left" valign="top" class="bold1">&nbsp;</td>
                         <td width="174" align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                        
                   </table></td>
                 </tr>
                 <tr>
                   <td>&nbsp; </td>
                 </tr>
                 <tr>
                   <td>
				   
				   <%
					 	
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
				sql = sql +"  a.INT_WARRANTY, a.INT_PR_WARRANTY  ";
				sql = sql +"  from inv_t_customersalesorderitem a ,inv_m_tax b  where a.INT_TAXID=b.INT_TAXID AND CHR_SALESORDERNO='"+cpodata[0][1]+"'";
				 //out.println(sql);
				 
				String itemDatas[][]=  CommonFunctions.QueryExecute(sql);
				int rlength=0;
				if(itemDatas.length>0)
					rlength=itemDatas.length;
				out.print("<table width='100%'  class='boldEleven' border='1'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.print("<tr  class='MRow1'>");
				out.print("<td  class='boldEleven'  rowspan='2'><b>S.No</b></td>");
				out.print("<td  class='boldEleven' rowspan='2'><b>Type</b></td>");
				out.print("<td  class='boldEleven' rowspan='2'><b>Item / Product</b></td>");
          		out.print("<td  class='boldEleven' rowspan='2'><b>Description</b></td>");
                out.print("<td  class='boldEleven' rowspan='2'><b>Quantity</b></td>");
				out.print("<td  class='boldEleven' rowspan='2'><b>Warranty</b></td>");
				out.print("<td  class='boldEleven' colspan='2'><b>Stock Availability</b></td>");
                out.print("<td  class='boldEleven' rowspan='2'><b>Unit Price</b></td>");
                out.print("<td  class='boldEleven' rowspan='2'><b>Discount(%)</b></td>");
                out.print("<td  class='boldEleven'  rowspan='2'><b>Unit Discount</b></td>");
				out.print("<td  class='boldEleven' rowspan='2'><b>Tax</b></td>");
				out.print("<td  class='boldEleven' rowspan='2'><b>Tax Value</b></td>");
				out.print("<td  class='boldEleven' rowspan='2'><b>Tax Amount</b></td>");
                out.print("<td  class='boldEleven' rowspan='2'><b>Total</b></td>");
				out.print("<td  class='headerBackground' rowspan='2'><b>Purchase Request</b></td>");
				out.print("<td  class='headerBackground' rowspan='2'><b>Purchase Quantity</b></td>");
				out.print("<td  class='headerBackground' rowspan='2'><b>Purchase Warranty</b></td>");
				out.print("<td  class='headerBackground' rowspan='2'><b>Vendor</b></td>");
				out.print("<td  class='headerBackground' rowspan='2'><b>Purchase Unit price</b></td>");
				out.print("<td  class='headerBackground' rowspan='2'><b>Description</b></td> ");
				out.print("</tr> ");
				out.print("<tr  class='MRow1'> ");
				out.print("<td class='boldEleven' ><b>Branch</td> ");
				out.print("<td class='boldEleven' ><b>Over All </td> ");
				out.print("</tr> ");
				
				int stock=0;
				int qty=0;
				String  cc=" checked = 'checked' ";
				for(int u=0; u<itemDatas.length;u++)
				{
					
					stock=0;
					qty=0; 
					qty=Integer.parseInt(itemDatas[u][6]);
					stock=Integer.parseInt(itemDatas[u][15]);
					
					
					if(qty >stock)
				  		cc=" checked = 'checked' ";
					else
						cc="";	
						
					if(qty >stock)
					{
						out.println("<tr class='MRow4'>");
					}
					else
					{	
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr  class='MRow2'>");	 
					}	
					out.println(" <td   class='boldEleven' >"+(u+1)+".</td>");
					out.println(" <td   class='boldEleven' >"+itemDatas[u][3]+"</td>");
					out.println("<td  class='boldEleven' >"+itemDatas[u][4] +"</td>");
					out.println("<td  class='boldEleven' >"+itemDatas[u][5] +"</td>");
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
					  out.println(" SERIALS / <a target='_blank' href='Rept_StockSerialPrint.jsp?Branch=0&itype="+itemDatas[u][0]+"&item="+itemDatas[u][1]+"&division=0&pgroup=0'> Details</a> ");
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
					out.println("<td  class='headerBackground' >"+itemDatas[u][18] +"</td>");
					
					//Purchase Quantity
					 out.println("<td  class='headerBackground'  align='right' >"+itemDatas[u][19] +"</td>");
					 
					 //Purchase Warranty
					 out.println("<td  class='headerBackground'  align='center' >"+itemDatas[u][24] +"-Yrs</td>");
							
					//Vendor Name
					out.println("<td  class='headerBackground' >"+itemDatas[u][20] +"</td>");
					
					//unit purchase Price
					out.println("<td  class='headerBackground'  align='right' >"+itemDatas[u][21] +"</td>");
					
					//description
					out.println("<td  class='headerBackground' >"+itemDatas[u][22] +"</td>");
				}
				out.print("</table> ");
					
					
				   %>
				   </td>
                 </tr>
                 <tr>
                   <td></td>
                 </tr>
                 <tr>
                   <td valign="top" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
                       <tr>
                         <td width="165" rowspan="4" valign="top" class="boldEleven"><div align="left" class="bold1">Description</div></td>
                         <td width="342" rowspan="4" valign="top" class="boldEleven"><div align="left"><%=cpodata[0][14]%>
                            
                         </div></td>
                         <td width="151" valign="top" class="bold1"><div align="left">Total</div></td>
                         <td   valign="top" class="boldEleven" id="totals1"><div align="right"><%=cpodata[0][16]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td valign="top" class="bold1"><div align="left">Total Discount</div></td>
                         <td valign="top" class="boldEleven"
										id="totaldiscount1"><div align="right"><%=cpodata[0][17]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td valign="top" class="bold1"><div align="left">Tax Group</div></td>
                         <td valign="top" class="boldEleven" id="tax1"><div align="right"><%=cpodata[0][18]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td valign="top" class="bold1"><div align="left">Sales Tax (%)</div></td>
                         <td valign="top" class="boldEleven" id="salestax1"><div align="right"><%=cpodata[0][19]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven"><div align="left" class="bold1">Reference
                            
                                  
                                  
                                  
                                  
                             <input name="filename" type="hidden" value="CPOVerification" />
                             <input name="actionS"  type="hidden" value="INVCPOVerificationAdd" />
                         </div></td>
                         <td rowspan="3" align="left" valign="top" class="boldEleven"><div align="left"><%=cpodata[0][15]%>
                              
                             </div>
                             <div align="left"></div></td>
                         <td class="bold1"><div align="left">Sales Tax Amount</div></td>
                         <td class="boldEleven" id="salestaxamount1"><div align="right"><%=cpodata[0][20]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven"><div align="left"></div></td>
                         <td class="bold1"><div align="left">
                             <div align="left">Net Total</div>
                         </div></td>
                         <td class="boldEleven" id="nettotal1"><div align="right"><%=cpodata[0][21]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="bold1">&nbsp;</td>
                         <td class="boldEleven" id="nettotal1">&nbsp;</td>
                       </tr>
                       <tr>
                         <td colspan="4" class="boldEleven"><table width="75" border="0" align="center" cellpadding="3"
										cellspacing="3">
                             <tr>
                                
                               <td width="95"><input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onclick="redirect('InventoryMains.jsp')"  /></td>
                             </tr>
                         </table></td>
                       </tr>
                        
                   </table></td>
                 </tr>
             </table></td>
             <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
             <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
           </tr>
           <tr>
             <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
             <td height="6"><spacer height="1" width="1" type="block" />
                 <div align="center"></div></td>
             <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
           </tr>
           <tr>
             <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
           </tr>
         </tbody>
       </table>
      </form></td>
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
<%@ include file="../footer.jsp"%>
 <script language="JavaScript">

function Validate()
{
	var len = document.getElementById('rlength').value;
	for( u=0; u<len;u++)
	{
		 
		 
		 if(CheckRows(u))
		    d=1;
		 else
		 	return false;
	}

 			
} 	
 
  
  function CheckRows(u)
  {
  		if(document.getElementById('purchaserequestflag'+(u+1)).checked)
		{		
				if(
					 checkNull('pqty'+(u+1),'Enter the purchase Quantity') 
					&& checkNullSelect('Vendor'+(u+1),'Select Vendor','') 
			    	&& checkNull('unitpurchaseprice'+(u+1),'Enter the Unitprice') 
					&& checkNull('descriptions'+(u+1),'Enter the descriptions ') 
			  	 )
					return true;
				else
					return false;		   
		}
		else
		{
			return true;			
		}	
  }

</script>
 <%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
