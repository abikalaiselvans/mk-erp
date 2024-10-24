<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.InventoryInvoiceFunctions"%>
<%

try
{

String dateCheckData[][] = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y'), DAT_LOCK,MONTHNAME(NOW()),MONTH(NOW()), YEAR(NOW())  FROM m_institution  WHERE INT_ID=1");

String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,UPPER(CHR_VENDORNAME) from  inv_m_vendorsinformation ");
String vendoroption="<option value=''>Select Vendor</option>";
for(int u=0; u<vendorids.length; u++)
	vendoroption = vendoroption +"<option value='"+vendorids[u][0]+"'>"+vendorids[u][1].replaceAll("&","AND") +"</option>" ;

String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax ORDER BY CHR_TAXNAME");
String optiontaxname="<option value=''>Select Tax</option>";//<option value='0'>No Tax</option>
for(int u=0; u<taxids.length; u++)
optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
   $(function() {
		$( "#saleDate" ).datepicker({ minDate: -7, maxDate: "+7D" });
	});
 
</script>

<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>
<script language="javascript" src="../JavaScript/Inventory/CustomerSalesCreditlimit.js"></script>

<script language="javascript">
function resoffval()
{
	
	if(document.frm.Shipping[0].checked==true)
	{
		
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
	}         
	else 
	{
		
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of resoffval

</script>

<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
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
             <td colspan="2" rowspan="2" valign="top">
			 <img height="7" src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
             <td class="BorderLine" height="0"></td>
             <td colspan="2" rowspan="2" valign="top">
			 <img height="7" src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
           </tr>
           <tr>
             <td height="6"></td>
           </tr>
           <tr>
             <td class="BorderLine" width="1"></td>
             <td width="6"></td>
             <td width="412"><table width="800" border="0" align="center" cellpadding="1"
						cellspacing="1">
                 <tr>
                   <td width="650"></td>
                 </tr>
                 <tr>
                   <td><div align="center"><strong>CUSTOMER PURCHASE ORDER BILLING 
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
sql = sql+ " a.INT_DIVIID, a.CHR_REF,a.INT_PAYMENTTERMID,a.INT_CUSTOMERID  ,";
sql = sql+ " IF(a.CHR_ADDRESSFLAG='Y','S','D'), ";
sql = sql+ " IF(a.CHR_MULTIPLE_BILL='Y','YES','NO'), ";
sql = sql+ " IF(a.CHR_PARTIAL_BILL='Y','YES','NO'), ";
sql = sql+ " IF(a.CHR_BG='Y','YES','NO'), ";
sql = sql+ " IF(a.CHR_DELIVERY='Y','YES','NO') ,a.INT_TAXID,a.INT_PAYMENTTERMID,a.CHR_TAXTYPE,a.INT_PROJECTID ,";
sql = sql+ " a.CHR_PARTIAL_BILL ,a.CHR_INVOICEBLOCK, a.CHR_BYBACK ,a.CHR_BYBACKDESC,";
sql = sql+ " ROUND(a.INT_REF_PERCENTAGE1,0),FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1),a.CHR_REF1,ROUND(a.INT_REF_PERCENTAGE2,0), ";
sql = sql+ " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2),a.CHR_REF2,ROUND(a.INT_REF_PERCENTAGE3,0), ";
sql = sql+ " IF( ( a.CHR_MULTIPLE_LOCATION ='Y' && a.CHR_MULTIPLE_BILL ='Y') ,'Y','N') , a.CHR_INSTALLATION , ";
sql = sql+ " a.DOU_BYBACKAMOUNT ";
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
                         <td align="left" valign="top" class="boldEleven">CPO Reference </td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][1]%><input name="cporeference" type="hidden" id="cporeference" value="<%=cpodata[0][1]%>"></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       <tr>
                         <td width="269" align="left" valign="top" class="boldEleven"><div align="left">Customer <span class="boldEleven"> </span></div></td>
                         <td width="180" align="left" valign="top" class="boldEleven">
						 <%
						  if("Y".equals(cpodata[0][56]))
						  {
						  	
							String ssql=" ";
							
							ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y' AND a.INT_CUSTOMERGROUPID  = (SELECT  g.INT_CUSTOMERGROUPID  FROM  inv_m_customerinfo g WHERE   g.INT_CUSTOMERID  = "+cpodata[0][35]+" )  ORDER BY f.CHR_NAME ";
			//out.println(ssql);
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
			String CreditLimitData =  CommonFunctions.QueryExecute("SELECT CHR_CUSTOMERCREDITLIMIT FROM  m_inventorysetting WHERE INT_ROWID=1")[0][0];
			String climit="";
			if("Y".equals(CreditLimitData))
				climit=" onblur=\"LoadCreditLimt('customerId','creditdetail','C')\" ";
			else
				climit="   ";
				
							out.println("<select name='customerId' id='customerId' class='formText135'  onchange=\"loadAddress('customerId','shippingaddress') \"  "+climit+" style='width:170'> ");
							for(int y=0;y<custData.length;y++)
								out.println("<option  style='height:20'  value='"+custData[y][0]+"'>"+custData[y][1]+" / "+custData[y][3]+ "  / "+custData[y][4]+ "</option>");	

							out.println("</select>");


						  }
						  else
						  {
						  	out.println(cpodata[0][4]);
							out.println("<input name='customerId' type='hidden' id='customerId' value='"+cpodata[0][35]+"'>");
						   
							String CreditLimitData =  CommonFunctions.QueryExecute("SELECT CHR_CUSTOMERCREDITLIMIT FROM  m_inventorysetting WHERE INT_ROWID=1")[0][0];
							 
							if("Y".equals(CreditLimitData))
							{
								out.println("<script type='text/javascript'>");
								out.println("LoadCreditLimt('customerId','creditdetail','C') ; ");
								out.println("</script>");
								 
							}	
								
								 
							}
						 %>						 <input name="pendingamount" type="hidden" id="pendingamount" value="0" />
						 <input name="creditamount" type="hidden" id="creditamount" value="0" /></td>
                         <td align="left" valign="top" class="boldEleven">Sale Date</td>
                         <td width="174" align="left" valign="top" class="boldEleven"><input name="saleDate"   type="text" class="formText135" id="saleDate" tabindex="2" value="<%=dateCheckData[0][0]%>" size="15" readonly>						  </td>
                       </tr>
                       <tr>
                         <td width="269" align="left" valign="top" class="boldEleven">Shipping Address</td>
                         <td width="180" align="left" valign="top" class="boldEleven">
<%
if("Y".equals(cpodata[0][56]))
{ 
	String c1="",c2="";
	if("S".equals(cpodata[0][36]))
		c1 = " checked = 'checked' ";
	else
		c2 = " checked = 'checked' ";
	
	out.println("<table width='141' border='0' cellspacing='0' cellpadding='0'>");
	out.println("<tr>");
	out.println("<td ><input name='Shipping' type='radio' value='S' onClick=\"return resoffval()\" "+c1+"/></td>");
	out.println("<td class='boldEleven'>Same</td>");
	out.println("<td class='boldEleven'><input onclick=\"return resoffval()\" name='Shipping' type='radio' "+c2+" value='D'/></td>");
	out.println("<td class='boldEleven'>Different<input name='shipadd' type='hidden' id='shipadd'></td>");
	out.println("</tr>");
	out.println("</table>");
}
else
{
	 if("S".equals(cpodata[0][36]))
		out.println("Same");
	 else
		out.println("Different");
out.println("<input name='Shipping' type='hidden' id='Shipping' value="+cpodata[0][36]+">");
}
	
	
%>                         </td>
                         <td align="left" valign="top" class="boldEleven">Payment Terms<span class="ui-state-error-text"> </span></td>
                         <td width="174" align="left" valign="top" class="boldEleven">
                          <input name="payment" type="hidden" id="payment" value="<%=cpodata[0][42]%>"> 
						  
 <%=CommonFunctions.QueryExecute("Select CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID= "+cpodata[0][42])[0][0]%>
						  
						  </td>
                       </tr>
                       <tr>
                         <td class="boldEleven"><div align="left">Shipping To
                           
                         </div></td>
                         <td rowspan="3" align="left" valign="top" class="boldEleven">
						 <%
						 if("Y".equals(cpodata[0][56]))
						 { 
						  out.println(" <textarea name='shippingaddress' style='text-transform:uppercase;width:170;'						cols='40' rows='7' class='formText135' id='shippingaddress'  >"+cpodata[0][9]+"</textarea> ");
						 }
						 else
						 {
				out.println("<input name='shippingaddress' type='hidden' id='shippingaddress' value='"+cpodata[0][9]+"'> ");
						 }
							%>                           </td>
                         <td width="160" align="left" valign="top" class="boldEleven"><div align="left">Order Reference</div></td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][23]%>
                          <input name="oref" type="hidden" id="oref" value="<%=cpodata[0][23]%>"></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td width="160" align="left" valign="top" class="boldEleven"><div align="left">Delivery Note</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][24]%>
                          <input name="dnote" type="hidden" id="dnote" value="<%=cpodata[0][24]%>"></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td width="160" align="left" valign="top" class="boldEleven"><div align="left">Despatch Through</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][25]%>
                          <input name="dthru" type="hidden" id="dthru" value="<%=cpodata[0][25]%>"></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">Division</td>
                         <td class="boldEleven"><%=cpodata[0][5]%>
                           <input name="division" type="hidden" id="division" value="<%=cpodata[0][32]%>">
                          <input name="noofpaymentcommitment" type="hidden" id="noofpaymentcommitment" value="1">						  </td>
                         <td width="160" align="left" valign="top" class="boldEleven"><div align="left">Destiantion</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven"> 
                          <input name="destination" type="text" class="formText135" id="destination" value="<%=cpodata[0][26]%>" size="25"></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">Payment Commitment Days <span class="ui-state-error-text"> </span></td>
                         <td class="boldEleven"><%=cpodata[0][22]+"- Days"%>
                           <input name="noofpaymentcommitment" type="hidden" id="noofpaymentcommitment" value="<%=cpodata[0][22]%>">
                           <input name="commitmentdays" type="hidden" id="commitmentdays" value="<%=cpodata[0][22]%>">
                           
                           </td>
                         <td width="160" align="left" valign="top" class="boldEleven"><div align="left">Terms of Delivery</div></td>
                         <td width="174" align="left" valign="top" class="boldEleven">
                          <input name="tdelivery" type="text" size="25" id="tdelivery" class="formText135" value="<%=cpodata[0][27]%>"></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">Installation / Implementation Required</td>
                         <td class="boldEleven"><%=cpodata[0][30]%>
                          <input name="installation" type="hidden" id="installation" value="<%=cpodata[0][57]%>"></td>
                         <td width="160" align="left" valign="top" class="boldEleven">Contact Person<span class="ui-state-error-text"> </span></td>
                         <td width="174" align="left" valign="top" class="boldEleven"> 
                          <input name="cdetails" type="text" class="formText135" id="cdetails" value="<%=cpodata[0][11]%>" size="25" maxlength="25"></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven">Partial Bill <span class="ui-state-error-text"></span></td>
                         <td class="boldEleven"><%=cpodata[0][38]%></td>
                         <td width="160" align="left" valign="top" class="boldEleven">Contact No.<span class="ui-state-error-text"> </span></td>
                         <td width="174" align="left" valign="top" class="boldEleven"> 
                          <input name="cnumber" type="text" class="formText135" id="cnumber" value="<%=cpodata[0][12]%>" size="25" maxlength="10"></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven">&nbsp;</td>
                         <td width="160" align="left" valign="top" class="boldEleven">Tax Type</td>
                         <td width="174" align="left" valign="top" class="boldEleven"><%=cpodata[0][28]%>
                          <input name="taxtype" type="hidden" id="taxtype" value="<%=cpodata[0][43]%>"></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven"><span class="boldEleven">Delivery Date </span></td>
                         <td class="boldEleven"><%=cpodata[0][7]%></td>
                         <td class="boldEleven">Project</td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][29]%>
                          <input name="project" type="hidden" id="project" value="<%=cpodata[0][44]%>"></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven">Block Invoice</td>
                         <td class="boldEleven">
						 <input name="blockinvoice" <%="Y".equals(cpodata[0][46])?" checked='checked' ":""%> type="checkbox" id="blockinvoice" value="Y">
                           <span class="boldred">(stocks not checked ) </span></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       
                        
                   </table></td>
                 </tr>
                 <tr>
                   <td>
				   <div id="creditdetail"> </div>
				   <div id="creditdetailerror"> </div>
				   <br><br>
							
							</td>
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
				
				sql = sql +"  a.INT_QUANTITY, a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT, a.INT_TAXID,";
				sql = sql +"  b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT, ";
				sql = sql +"  a.DOU_TOTAL,  ";
				sql = sql +"  if( a.CHR_TYPE ='I' , 'F' , ";
				sql = sql +"  (SELECT sa3.CHR_PTYPE  FROM inv_m_produtlist sa3 WHERE sa3.CHR_PRODUCTID =a.CHR_ITEMID)  ";
				sql = sql +"  ) ptype ,";
				
				
				sql = sql +" if( a.CHR_TYPE ='I' , (SELECT FUN_INV_ITEM_STOCK(a.CHR_ITEMID) ) ,  ";
  				sql = sql +" if(((SELECT sa3.CHR_PTYPE FROM inv_m_produtlist sa3 WHERE sa3.CHR_PRODUCTID =a.CHR_ITEMID) = 'S') , ";
  				sql = sql +" (SELECT FUN_INV_CONSUMABLE_STOCK(a.CHR_ITEMID) ),(SELECT FUN_INV_PRODUCT_STOCK(a.CHR_ITEMID))) )  ";
  				sql = sql +"  stock ,a.INT_ID,  ";
  
  
  				sql = sql +"  if( a.CHR_TYPE ='I' , '-' ,";
				sql = sql +"  (SELECT ka2.CHR_PTYPE FROM inv_m_produtlist ka2  WHERE  ka2.CHR_PRODUCTID =a.CHR_ITEMID)  ";
				sql = sql +"  ) swap, ";
				
				sql = sql +"  if( a.CHR_TYPE ='I' , "; 
				sql = sql +"  (SELECT FUN_INV_BRANCH_ITEM_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ) ,  ";
				sql = sql +"  if(((SELECT sa4.CHR_PTYPE FROM inv_m_produtlist sa4 WHERE sa4.CHR_PRODUCTID =a.CHR_ITEMID)= 'S'),"; 
				sql = sql +"  (SELECT FUN_INV_BRANCH_CONSUMABLE_STOCK(a.CHR_ITEMID,a.INT_BRANCHID) ), ";
				sql = sql +"  (SELECT FUN_INV_BRANCH_PRODUCT_STOCK(a.CHR_ITEMID,a.INT_BRANCHID)))  ";
				sql = sql +" ) branchstock1 , ";
				
				sql = sql +"  a.INT_BILLEDQUANTITY,(a.INT_QUANTITY-a.INT_BILLEDQUANTITY),a.INT_ID,a.INT_WARRANTY  ";
				
				
				sql = sql +"  from inv_t_customersalesorderitem a ,inv_m_tax b  where a.INT_TAXID=b.INT_TAXID";
				sql = sql +"  AND (a.INT_QUANTITY-a.INT_BILLEDQUANTITY) >0  ";
				sql = sql +"  AND CHR_SALESORDERNO='"+cpodata[0][1]+"'";
				
				  //out.println(sql);
				
				 
				String itemDatas[][]=  CommonFunctions.QueryExecute(sql);
				int rlength=0;
				if(itemDatas.length>0)
					rlength=itemDatas.length;
				out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.print("<tr  class='MRow1'>");
				out.print("<th  class='boldEleven' ><b>S.No</b></th>");
				out.print("<th  class='boldEleven' ><b>Type</b></th>");
				out.print("<th  class='boldEleven' ><b>Item / Product</b></th>");
          		out.print("<th  class='boldEleven' ><b>Description</b></th>");
				out.print("<th  class='boldEleven' ><b>&nbsp;</b></th>");
                out.print("<th  class='boldEleven' ><b>Stock </b></th>");
				out.print("<th  class='boldEleven' ><b>CPO </b></th>");
				out.print("<th  class='boldEleven' ><b>Billed </b></th>");
				out.print("<th  class='boldEleven' ><b>UnBilled </b></th>");
				out.print("<th  class='boldEleven' ><b>Quantity</b></th>");
				out.print("<th  class='boldEleven' ><b>Warranty</b></th>"); 
                out.print("<th  class='boldEleven' ><b>Unit Price</b></th>");
                out.print("<th  class='boldEleven' ><b>Discount(%)</b></th>");
              
				out.print("<th  class='boldEleven' ><b>Unit Discount</b></th>");
				out.print("<th  class='boldEleven' ><b>Tax</b></th>");
				out.print("<th  class='boldEleven' ><b>Tax Percentage</b></th>");
				out.print("<th  class='boldEleven' ><b>Tax Amount</b></th>");
                out.print("<th  class='boldEleven' ><b>Total</b></th>");
				
				 
				out.print("</tr> ");
				 
				int stock=0;
				int qty=0;
				int unbilledqty=0;
				String  cc=" checked = 'checked' ";
				boolean bflag=true;
				String param="";
				for(int u=0; u<itemDatas.length;u++)
				{
					
					stock=0;
					qty=0; 
					qty=Integer.parseInt(itemDatas[u][6]); 
					stock=Integer.parseInt(itemDatas[u][19]); 
					unbilledqty=Integer.parseInt(itemDatas[u][21]); 
					 param = param +(u+1)+",";
					if(qty >stock)
				  		cc=" checked = 'checked' ";
					else
						cc="";	
						
					
					//only unbilled quantity row
					if(unbilledqty >0)
					{
						
						if(qty >stock)
							out.println("<tr  bgcolor='#f0ad4e' >");
						else
							out.println("<tr  bgcolor='#5cb85c'>"); //a1e72d 07b3d3  41bc81 ff9900
						
						out.println(" <td   class='boldEleven' >"+(u+1)+".</td>");
						
						//Item/Product
						out.println(" <td   class='boldEleven' >"+itemDatas[u][3] );
						if("I".equals(itemDatas[u][0]))
							out.println(" <input name='itype"+(u+1)+"' type='hidden' value='1'>");
						else
							out.println(" <input name='itype"+(u+1)+"' type='hidden' value='2'>");	
						out.println("</td>");
						
						//Item/Product
						out.println("<td  class='boldEleven' >"+itemDatas[u][4] );
						out.println(" <input name='item"+(u+1)+"' type='hidden' value='"+itemDatas[u][1]+"'>");	
						out.println("</td>");
						
						
						//Description
						out.println("<td  class='boldEleven' >"+itemDatas[u][5]  );
						out.println(" <input name='desc"+(u+1)+"' type='hidden' value='"+itemDatas[u][5]+"'>");	
						out.println("</td>");
						
						
						//Checkbox
						out.println("<td  class='boldEleven' >" );
						out.println(" <input name='billrow"+(u+1)+"' id='billrow"+(u+1)+"' type='checkbox' value='Y' checked='checked' onclick=\" billrowCheckboxClick('billrow"+(u+1)+"') \" >");
						out.println(" <input name='rowid"+(u+1)+"' id='rowid"+(u+1)+"' type='hidden' value='"+itemDatas[u][22]+"'>");
							
						out.println("</td>");
						
						//Stock
						out.println("<td  class='boldEleven' > ");
						out.println(" <input type='text' value='"+stock+"' id='stock"+(u+1)+"' name='stock"+(u+1)+"' size='4' readonly='readonly' class='formText135' >");
						out.println("</td>");
						
						out.println("<td  class='boldEleven' >"+itemDatas[u][6]+"</td>");
						out.println("<td  class='boldEleven' >"+itemDatas[u][20]+"</td>");
						out.println("<td  class='boldEleven' >"+itemDatas[u][21]+"</td>");
						
						//Quantity  "+("N".equals(cpodata[0][45])?" readonly ":"" )+" 
						out.println("<td  class='boldEleven' >" );
						out.println(" <input type='hidden' id='unbilled"+(u+1)+"' name='unbilled"+(u+1)+"'  value='"+itemDatas[u][21]+"'>	");
						//Quantity
						out.println(" <input type='text' maxlength='4' style='text-align:right'   id='qty"+(u+1)+"' name='qty"+(u+1)+"' class='formText135'  onKeyPress=\" return numeric_only(event,'qty"+(u+1)+"','15') \" size='10' value='"+itemDatas[u][21]+"' 	   onblur=\"calculateValue('qty"+(u+1)+"')\" >");
						
							
						if(qty >=stock)
						{
							//out.println("<font class='bolddeepred'>Stock not available</font>");
							bflag=false;
						}	
						out.println("</td>");
						
						//Warranty 23
						out.println("<td  class='boldEleven' >"+itemDatas[u][23]+" - Yrs "  );
						out.println(" <input type='hidden' id='warranty"+(u+1)+"' name='warranty"+(u+1)+"'  value='"+itemDatas[u][23]+"'>	");
						out.println("</td>");
						
						
						//Unit Price
						out.println("<td  class='boldEleven' >"  );
						out.println("<input type='text' maxlength='12' style='text-align:right'  id='uprice"+(u+1)+"' name='uprice"+(u+1)+"' class='formText135'  size='10'  readonly value='"+itemDatas[u][7]+"'>");
						out.println("</td>");
						
						//Discount
						out.println("<td  class='boldEleven' >"  );
						out.println("<input type='text' maxlength='12' style='text-align:right'  id='discount"+(u+1)+"' name='discount"+(u+1)+"' class='formText135'   size='10'  readonly value='"+itemDatas[u][8]+"'>");	
						out.println("</td>");
						
						
						//unitdiscount
						out.println("<td  class='boldEleven' >"  );
						out.println("<input type='text' maxlength='12' style='text-align:right'  id='unitdiscount"+(u+1)+"' name='unitdiscount"+(u+1)+"' class='formText135'  size='10' readonly  value='"+itemDatas[u][9]+"'>");	
						out.println("</td>");
						
						//Tax
						out.println("<td  class='boldEleven' >"+itemDatas[u][11]  );
						out.println(" <input name='stax"+(u+1)+"' type='hidden' value='"+itemDatas[u][10]+"'>");	
						out.println("</td>");
						
						//Tax Percentage
						out.println("<td  class='boldEleven' >"  );
						out.println("<input type='text' maxlength='12' style='text-align:right'  id='staxpercentage"+(u+1)+"' name='staxpercentage"+(u+1)+"' class='formText135' readonly size='10'  value='"+itemDatas[u][12]+"'>");
						out.println("</td>");
						
						//Tax Amount
						out.println("<td  class='boldEleven' >"  );
						out.println("<input type='text' maxlength='12' style='text-align:right'  id='staxamount"+(u+1)+"' name='staxamount"+(u+1)+"' class='formText135'  size='10'  readonly value='"+itemDatas[u][13]+"'>");
						out.println("</td>");
						 
						
						//total
						out.println("<td  class='boldEleven' >" );
						out.println("<input type='text' maxlength='12' style='text-align:right'  id='total"+(u+1)+"' name='total"+(u+1)+"' class='formText135' title='discount '  size='10' readonly  value='"+itemDatas[u][14]+"'>");
						out.println(" <input name='consumables"+(u+1)+"' type='hidden' value='"+itemDatas[u][18]+"'>");	
						
						if("C".equals(itemDatas[u][18]))
								out.println("<input id='SwapCheckbox"+(u+1)+"' type='checkbox' checked='checked' name='SwapCheckbox"+(u+1)+"' value='Y'>");	 		
						
						
						out.println("<script language='javascript'>");
						//out.println(" calculateValue('qty"+(u+1)+"')   ");
						out.println("");
						out.println("</script>");
						
						
						
						out.println("</td>");
						out.println("</tr>");
						
					}//unbilled quantity row end.						 
 			 
				}
				out.print("</table> ");
					
					
				   %>
				   <input name="param" type="hidden" id="param" value="<%=param%>"> 

<script language="javascript">
function billrowCheckboxClick(ctr)
{
	try
	{
		var idposition = ctr.replace("billrow",""); 
		var blokinvoiceflag = document.getElementById('blockinvoice' ).checked;
		var unbilled = parseInt(document.getElementById('unbilled'+idposition).value);
		
		if(document.getElementById('billrow'+idposition ).checked == false)
		{
			 document.getElementById('qty'+idposition).value =unbilled;
			 var quantity = parseInt(document.getElementById('qty'+idposition).value);
			 itemProductRowCalculation(quantity,idposition); 
		}
		else
		{
			
			var idposition = ctr.replace("billrow",""); 
			
			document.getElementById('qty'+idposition).value =unbilled;
			var quantity = parseInt(document.getElementById('qty'+idposition).value);
			if(unbilled < quantity)
			{
				alert("Quantity Should not greater than the unbilled quantity ");
				document.getElementById('qty'+idposition).value = unbilled;
				document.getElementById('qty'+idposition).focus();
			}
			quantityStockChecking(blokinvoiceflag,idposition);
			itemProductRowCalculation(quantity,idposition);
		}
	}
	catch(err)
	{
		alert(err);
	}
}

//Quantity checking with stock quantity & Invlice bloking condition
function quantityStockChecking(blokinvoiceflag , idposition)
{
	try
	{
		// Block invoice true means its not checking stock but checking unbilled quantity
		if(blokinvoiceflag)
		{
			var quantity = parseInt(document.getElementById('qty'+idposition).value);
			var unbilled = parseInt(document.getElementById('unbilled'+idposition).value);
			if(unbilled < quantity)
			{
				alert("Quantity Should not greater than the unbilled quantity ");
				document.getElementById('qty'+idposition).value = unbilled;
				document.getElementById('qty'+idposition).focus();
			}
			
			if( (quantity)<1)
			{
				alert("Quantity Should not zero... ");
				document.getElementById('qty'+idposition).value = unbilled;
				document.getElementById('qty'+idposition).focus();
				
			}
		
		}
		else
		{
			// Block invoice false means its  checking stock but checking unbilled quantity
			var quantity = parseInt(document.getElementById('qty'+idposition).value);
			var stock = parseInt(document.getElementById('stock'+idposition).value);
			var unbilled = parseInt(document.getElementById('unbilled'+idposition).value);
			if(unbilled < quantity)
			{
				alert("Quantity Should not greater than the unbilled quantity ");
				document.getElementById('qty'+idposition).value = unbilled;
				document.getElementById('qty'+idposition).focus();
			}
			if(document.getElementById('billrow'+idposition ).checked == true)
			{
				if( (quantity)<1)
				{
					alert("Quantity Should not zero... ");
					document.getElementById('qty'+idposition).focus();
				}
			}
		
			if( (quantity) >  (stock))
			{
				alert("Kindly check Stock... ");
				document.getElementById('qty'+idposition).focus();
			}
			else
			{
				alert("Quantity Should not be Zero");
				document.getElementById("qty"+idposition).focus();
			}
		}
	}
	catch(err)
	{
		alert(err);
	}
}



//Stock not checkeing
function calculateValue(ctr)
{
	try
	{	 
		//var blokinvoiceflag = document.getElementById('blockinvoice' ).checked;
		//quantityStockChecking(blokinvoiceflag,idposition);
		//itemProductRowCalculation(quantity,idposition);		
		 
		 
		  
		if(document.getElementById('blockinvoice' ).checked == false  )
			calculateValues(ctr);
		else
		{
			 
			 
				var quantity = parseInt(document.getElementById(ctr).value);
				var idposition = ctr.replace("qty",""); 
				var unbilled = parseInt(document.getElementById('unbilled'+idposition).value);
				if(unbilled < quantity)
				{
					alert("Quantity Should not greater than the unbilled quantity ");
					document.getElementById('qty'+idposition).value = unbilled;
					document.getElementById('qty'+idposition).focus();
				}
				
				if(document.getElementById('billrow'+idposition ).checked == true)
					if( (quantity)<1)
					{
						alert("Quantity Should not zero... ");
						document.getElementById('qty'+idposition).value = unbilled;
						document.getElementById('qty'+idposition).focus();
						
					}
				 
				 itemProductRowCalculation(quantity,idposition);
			  
		}
	}
	catch(err)
	{
		alert(err);
	}
}



function calculateValues(ctr)
{
	try
	{
		var quantity = parseInt(document.getElementById(ctr).value);
		var idposition = ctr.replace("qty",""); 
		var stock = parseInt(document.getElementById('stock'+idposition).value);
		var unbilled = parseInt(document.getElementById('unbilled'+idposition).value);
		
		 
		if(unbilled < quantity)
		{
			alert("Quantity Should not greater than the unbilled quantity ");
			document.getElementById('qty'+idposition).value = unbilled;
			document.getElementById('qty'+idposition).focus();
		}
		
		if(document.getElementById('billrow'+idposition ).checked == true)
		{
			if( (quantity)<1)
			{
				alert("Quantity Should not zero... ");
				document.getElementById('qty'+idposition).focus();
				
			}
			if( (quantity) >  (stock))
			{
				alert("Kindly check Stock... ");
				document.getElementById('qty'+idposition).focus();
			}
			else  if(quantity>=1)
			{
				itemProductRowCalculation(quantity,idposition);
			}
		}
		else
		{
			itemProductRowCalculation(quantity,idposition);
		}
	}
	catch(err)
	{
		alert(err);
	}
	
	
}



//Product row calculation
function itemProductRowCalculation(quantity,idposition)
{
	try
	{
	 		var uprice = parseFloat(document.getElementById("uprice"+idposition).value);
			var discount =parseFloat(document.getElementById("discount"+idposition).value);
			var udiscount = parseFloat(document.getElementById("unitdiscount"+idposition).value);
			var staxpercentage = parseFloat(document.getElementById("staxpercentage"+idposition).value);
			udiscount =(discount/100)*uprice;
			 
			document.getElementById("unitdiscount"+idposition).value = udiscount;
		
			uprice = uprice - udiscount;
			document.getElementById("staxamount"+idposition).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
			var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
			var total =  Round((quantity*uprice) +taxamount);
			document.getElementById("total"+idposition).value = Round( total );
			calculateTotal();
			assignGrandTotal(); 
	}
	catch(err)
	{
		alert(err);
	}
	
}

//Calculate Nettotal 
function calculateTotal()
{
	var l = "<%=rlength%>";
	//alert(l);
	var svalue=0.0;
	for(u=0; u<l;u++)
	{
		//alert("'total"+(u+1)+"/"+ document.getElementById('total'+(u+1)).value);
		svalue= svalue+parseFloat(document.getElementById('total'+(u+1)).value);
	}	
	document.getElementById("totals").value=Round(svalue);		
}



function assignGrandTotal()
{
	try
	{
		calculateTotal();
		var tot = parseFloat(document.getElementById("totals").value);
		var discount = parseFloat(document.getElementById("totaldiscount").value);
		var discountamount=0.0;
		if(discount>0)
			discountamount= (discount/100)*tot;
		else
			discountamount	=0.0;
			
		tot = tot-	discountamount;	
		var sstax=document.getElementById("salestax").value;
		if(sstax == "" )
			sstax=="0";
		var salestax = parseFloat(sstax);
		var salestaxamount = parseFloat((salestax/100)*tot);
		document.getElementById("salestaxamount").value = salestaxamount.toFixed(2);
		
		var grandtotal = Round((tot+salestaxamount));
		document.getElementById("nettotal").value= Round(grandtotal) ;
		
		if(document.getElementById('byback').checked == true)
		{
			var bybackamount =0;
			if(document.getElementById("bybackamount").value =="")
				var bybackamount =0;
			else
				bybackamount = parseFloat(document.getElementById("bybackamount").value);
				
			var nettotal = parseFloat(document.getElementById("nettotal").value);
			document.getElementById("nettotal").value= Round(nettotal-bybackamount) ;
		}	
	}
	catch(err)
	{
		alert(err);
	}		
}

function checkBilledRow()
{
	try
	{
		var billrowno = "<%=rlength%>";
		var flag = false;
		for(u=0; u<billrowno;u++)
		{
			if(document.getElementById('billrow'+(u+1) ).checked == true)
			 	flag =true;
		}
		if(!flag)
		{
			alert("billed atleat one product. ");
			return false;
		}
		
		return flag;
	}
	catch(err)
	{
		alert(err);
	}
}	

</script>

				   
				   </td>
                 </tr>
                 <tr>
                   <td></td>
                 </tr>
                 <tr>
                   <td valign="top" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
                       <tr>
                         <td width="165" rowspan="4" valign="top" class="boldEleven"><div align="left" class="boldEleven">Description</div></td>
                         <td width="342" rowspan="4" valign="top" class="boldEleven">
						 
						 <div align="left"> <textarea name="memo" cols="25" rows="5" class="formText135"><%=cpodata[0][14]%></textarea>
                         </div></td>
                         <td width="151" valign="top" class="boldEleven"><div align="left">Total
                            
                         </div></td>
                         <td   valign="top" class="boldEleven" id="totals1"><div align="right">
                           <input name="totals" type="text"
										class="formText135" id="totals"
										style='text-align:right' tabindex="11"
										onkeypress="numericValue('totals','12')" value="<%=cpodata[0][16]%>" size="20" readonly /> 
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven"><div align="left">Total Discount
                            
                         </div></td>
                         <td valign="top" class="boldEleven"
										id="totaldiscount1"><div align="right">
                           <input readonly
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount" onKeyPress="return numeric_only(event,'totaldiscount','7') "
										style='text-align:right' tabindex="12" onBlur="assignGrandTotal()" value="<%=cpodata[0][17]%>" size="20" maxlength="5" /> 
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven"><div align="left">Tax Group
                           
                         </div></td>
                         <td valign="top" class="boldEleven" id="tax1"><div align="right">
                           <select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" readonly="readonly" tabindex="13"  style="width:118">
                             <%=optiontaxname%>
                           </select>
						   <script language="javascript">setOptionValue('tax','<%=cpodata[0][41]%>')</script>
                         </div></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven"><div align="left">Sales Tax (%)
                            
                         </div></td>
                         <td valign="top" class="boldEleven" id="salestax1"><div align="right">
                           <input name="salestax"
										type="text" class="formText135" id="salestax" style='text-align:right' tabindex="14" value="<%=cpodata[0][19]%>" size="20"
										readonly="readonly" /> 
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven"><div align="left">Sales Tax Amount </div></td>
                         <td class="boldEleven" id="salestaxamount1"><div align="right">
                           <input name="salestaxamount"
										type="text" class="formText135" id="salestaxamount" style='text-align:right' tabindex="14" value="<%=cpodata[0][20]%>" size="20"
										readonly="readonly" />
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">Buy Back Value
                          <input name="byback" type="checkbox" <%="Y".equals(cpodata[0][47])?" checked='checked' ":""%> id="byback" value="Y" onClick="byBack()" /></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="boldEleven" id="salestaxamount1">&nbsp;</td>
                       </tr>
                       <tr>
                         <td class="boldEleven">Buy Back Description </td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][48]%>
                          <input name="bybackdescription" type="hidden" id="bybackdescription" value="<%=cpodata[0][48]%>"></td>
                         <td class="boldEleven"> By Back Amount </td>
                         <td class="boldEleven" id="salestaxamount1"><div align="right">
                           <input name="bybackamount" type="text" 
										class="formText135" id="bybackamount" style='text-align:right'   value="<%=cpodata[0][58]%>" size="20" maxlength="12"  onBlur="assignGrandTotal()"/>
                         </div></td>
                       </tr>
                       <tr>
                         <td colspan="2" class="boldEleven"><table width="98%" border="0" cellpadding="2" cellspacing="2" class="boldEleven">
                           <tr>
                             <td width="32%" align="left" valign="top" class="boldEleven">Sale Reference 1 </td>
                             <td width="37%" align="left" valign="top" class="boldEleven"><%=cpodata[0][15]%>
                               <input name="ref" type="hidden" id="ref" value="<%=cpodata[0][33]%>"></td>
                             <td width="15%" align="left" valign="top" class="boldEleven">Percentage</td>
                             <td width="16%" align="left" valign="top" class="boldEleven"><%=cpodata[0][49]+" [ % ]"%> 
							 <input name="percentage" type="hidden" id="percentage" value="<%=cpodata[0][49]%>"></td>
                           </tr>
                           <tr>
                             <td align="left" valign="top" class="boldEleven">Sale Reference 2 </td>
                             <td align="left" valign="top" class="boldEleven"><%=cpodata[0][50]%>
                               <input name="ref1" type="hidden" id="ref1" value="<%=cpodata[0][51]%>"></td>
                             <td align="left" valign="top" class="boldEleven">Percentage</td>
                             <td align="left" valign="top" class="boldEleven"><%=cpodata[0][52]+" [ % ]"%>
                               <input name="percentage1" type="hidden" id="percentage1" value="<%=cpodata[0][52]%>"></td>
                           </tr>
                           <tr>
                             <td align="left" valign="top" class="boldEleven">Sale Reference 3 </td>
                             <td align="left" valign="top" class="boldEleven"><%=cpodata[0][53]%>
                               <input name="ref2" type="hidden" id="ref2" value="<%=cpodata[0][54]%>"></td>
                             <td align="left" valign="top" class="boldEleven">Percentage</td>
                             <td align="left" valign="top" class="boldEleven"><%=cpodata[0][55]+" [ % ]"%>
                               <input name="percentage2" type="hidden" id="percentage2" value="<%=cpodata[0][55]%>"></td>
                           </tr>
                         </table></td>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="boldEleven" id="salestaxamount1">&nbsp;</td>
                       </tr>
                        
                       <tr>
                         <td class="boldEleven">&nbsp; </td>
                         <td align="left" valign="top" class="boldEleven">&nbsp; </td>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="boldEleven" id="salestaxamount1">&nbsp;</td>
                       </tr>
                       <tr>
                         <td class="boldEleven"><input name="filename" type="hidden" value="CPOBilling" />
                           <input name="actionS"  type="hidden" value="INVCPOBillingAdd" />
 
                          
                          <input name="bybackdescription" type="hidden" id="bybackdescription">
                          <input name="salesordernumber" type="hidden" id="salesordernumber" value="<%=cpodata[0][1]%>"></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="boldEleven" id="nettotal1" align="right">&nbsp;</td>
                       </tr>
                       <tr>
                         <td class="boldEleven"><div align="left"></div></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven"><div align="left">
                             <div align="left">Net Total                             </div>
                         </div></td>
                         <td class="boldEleven" align="right" >
						 <input name="nettotal" type="text" readonly
										class="formText135" id="nettotal"  
										style='text-align:right' tabindex="15" value="<%=cpodata[0][21]%> " size="20" />						  </td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="boldEleven" id="nettotal1">&nbsp;</td>
                       </tr>
                       <tr>
                         <td colspan="4" class="boldEleven"><table width="120" border="0" align="center" cellpadding="3" cellspacing="3">
                           <tr>
                             <%
				   bflag = false;
				   if("Y".equals(cpodata[0][46]))
				   {
				   		bflag = true;
				   }
				   else
				   {
				   	 
						String sflag = InventoryInvoiceFunctions.CPOReasdytoBill(cpodata[0][1]);
						if(sflag =="B")
							bflag = true;
						else if(sflag =="P" && "Y".equals(cpodata[0][45]))
							bflag = true;
						else	
							bflag = false;
				   }
				   
				   if(!"YES".equals(cpodata[0][38]))
				   {
				   	if(bflag)
				   	out.println("<td width='56'><input name='Submit' id='Submit'  type='submit' class='tMLAscreenHead' value='Submit'/></td>");
				   }
				   else
				   {
				   	out.println("<td width='56'><input name='Submit' id='Submit'  type='submit' class='tMLAscreenHead' value='Submit'/></td>");
				   }	
					 
				   %>
                             <td width="56"><input name="Submit22" type="button" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('POBilling.jsp')" /></td>
                           </tr>
                         </table></td>
                       </tr>
                       <tr>
                         <td colspan="4" class="boldEleven">
						 
						 <%
						 if(!"YES".equals(cpodata[0][38]))
				   		 {
							if(!bflag)
				   				out.println("<center><font class='bolddeepred'>Stock not available</font></center>");
						}
						 %>
						 </td>
                       </tr>
                        
                   </table></td>
                 </tr>
             </table></td>
             <td nowrap="nowrap" width="4"></td>
             <td class="BorderLine" width="1"></td>
           </tr>
           <tr>
             <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
             <td height="6"></td>
             <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
           </tr>
           <tr>
             <td class="BorderLine" height="0"></td>
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
	 
	
	 try
	{
		 
		var flag = true;
		var flag1 =  checkBilledRow() ;
		var flag2 = true;
		 
		var billrowno = "<%=rlength%>";
		
		for(u=0; u<billrowno;u++)
		{
			 
			if(document.getElementById('billrow'+(u+1) ).checked == true)
			{
					var pqty = parseInt(document.getElementById('qty'+(u+1)).value );
					if(pqty<1)
					{
						alert("Quantity should not zero");
						document.getElementById('qty'+(u+1)).focus();
						flag = false;	
					}
					
			}
		}
		
		if(document.getElementById('blockinvoice').checked == false)
		{
			for(u=0; u<billrowno;u++)
			{
				if(document.getElementById('billrow'+(u+1) ).checked == true)
				{
					var pqty = parseInt(document.getElementById('qty'+(u+1)).value );
					var sqty = parseInt(document.getElementById('stock'+(u+1)).value );
					if(sqty < pqty)
					{
						alert("Kindly check with stock");
						document.getElementById('qty'+(u+1)).focus();
						flag2 = false;	

					}
				}	
			}
			 
		}
		
		if(flag && flag1 && flag2 && ValidateBill())
		{
			if (confirm("Confirm all the informations are correct") == true) 
				return true;
			else
				return false;	
		}
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}

 			
} 	
 

function ValidateBill()
{
		var pamount = parseFloat(document.getElementById('pendingamount').value);
		var camount = parseFloat(document.getElementById('creditamount').value);
		var namount= parseFloat(document.getElementById('nettotal').value);
		 
			if(camount<(pamount+namount)) 
			{
				var tb=document.getElementById("creditdetailerror");
				tb.innerHTML= "<font color='red'><h3><b>This Bill Not Allowed due to Exceed the credit limit    The Credit Limit : "+camount +"  The Pending Amount : "+pamount +" Current Bill Amount : "+namount +"</b></h3></font>";
					return true;
			}
			else
				return true;	
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
