<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.InventoryInvoiceFunctions"%>
<%
try
{

String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax ORDER BY CHR_TAXNAME");
String optiontaxname="<option value=''>Select Tax</option>";//<option value='0'>No Tax</option>
for(int u=0; u<taxids.length; u++)
	optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";


String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,UPPER(CHR_VENDORNAME) from  inv_m_vendorsinformation ");
String vendoroption="<option value=''>Select Vendor</option>";
for(int u=0; u<vendorids.length; u++)
	vendoroption = vendoroption +"<option value='"+vendorids[u][0]+"'>"+vendorids[u][1].replaceAll("&","AND") +"</option>" ;

String warrantyinsert="";
warrantyinsert = warrantyinsert + "<option  value='1' selected='selected'>1 - Year</option>";
warrantyinsert = warrantyinsert + "<option  value='0'>No Warranty </option>";
for(int u=2;u<=10;u++)
	warrantyinsert = warrantyinsert + "<option  value='"+u+"'>"+u+" - Years</option>";

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



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>


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
sql = sql+ " DATE_FORMAT(a.CHR_PURCHASEORDER_DATE,'%d-%m-%Y'),		";
sql = sql+ " DATE_FORMAT(a.CHR_DELIVERY_DATE,'%d-%m-%Y'),		";
sql = sql+ " a.CHR_BILLINGADDRESS,a.CHR_SHIPINGADDRESS,a.CHR_ONHOLD,a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO,		";
sql = sql+ " c.CHR_PAYMENTNAME,a.CHR_DES,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_AMOUNT,		";
sql = sql+ " a.DOU_DISCOUNT,b.CHR_TAXNAME,b.DOU_VALUE,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT, 	";
sql = sql+ " a.INT_PAYMENT_COMMITMENT_DAYS, 		";
sql = sql+ " a.CHR_OTHERREF,a.CHR_DELIVERYNOTE,a.CHR_DESPATCHTHRU,a.CHR_DESTINATION,a.CHR_TERMSOFDELIVERY,"; 
sql = sql+ " IF(a.CHR_TAXTYPE='S','SINGLE','MULTIPLE'),d.CHR_PROJECTNAME,";
sql = sql+ " IF(a.CHR_INSTALLATION='Y','YES','NO'),IF(a.CHR_MULTIPLE_LOCATION='Y','YES','NO') ,";
sql = sql+ " a.INT_DIVIID, a.CHR_REF,a.INT_PAYMENTTERMID,a.INT_CUSTOMERID  ,";
sql = sql+ " IF(a.CHR_ADDRESSFLAG='Y','S','D'), ";
sql = sql+ "  a.CHR_MULTIPLE_BILL , ";
sql = sql+ "  a.CHR_PARTIAL_BILL , ";
sql = sql+ "  a.CHR_BG , ";
sql = sql+ "  a.CHR_DELIVERY , ";
sql = sql+ "  a.CHR_INVOICEBLOCK ,  ";
sql = sql+ " a.INT_REF_PERCENTAGE1,  ";
sql = sql+ " IF(a.CHR_REF1='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1)),INT_REF_PERCENTAGE2,  ";
sql = sql+ " IF(a.CHR_REF2='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2)),INT_REF_PERCENTAGE3 ,  ";
sql = sql+ " IF(a.CHR_BYBACK='Y','YES','NO') , a.CHR_BYBACKDESC,a.DOU_BYBACKAMOUNT, ";
sql = sql+ " IF(a.CHR_STOCKTYPE='G','General','B2B'), ";
sql = sql+ " a.CHR_PARTIAL_BILL, a.CHR_DEMURRAGE,a.DOU_DEMARRAGE_PERCENTAGE,a.INT_DEMARRAGE_DAYS ,"; 
sql = sql+ "a.CHR_RFC, a.CHR_RFC_DESC, a.CHR_PR_MOFICIATION_DESC,a.INT_VENDORCOMMITMENTDAYS,a.INT_VENDORPAYMENTID ,a.CHR_ORCDESC, a.INT_CPO_STATUS ";
sql = sql+ " FROM inv_t_customersalesorder a , inv_m_tax b , inv_m_paymentterms c  , inv_m_project d WHERE a.INT_TAXID =b.INT_TAXID	  AND a.INT_PROJECTID =d.INT_PROJECTID ";
sql = sql+ " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID AND a.INT_ROWID = "+rowid;
//out.println(sql);
String cpodata[][] =  CommonFunctions.QueryExecute(sql);	


%>
				   
				   </strong></div></td>
                 </tr>
                 <tr>
                   <td><table width="100%" border="0" align="center" cellpadding="2"
								cellspacing="2">
                        
                       <tr>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       <tr>
                         <td width="253" align="left" valign="top" class="boldEleven"><div align="left">Customer <span class="boldEleven"> </span></div></td>
                         <td width="167" align="left" valign="top" class="boldEleven"><%=cpodata[0][4]%>
                           <input name="customer" type="hidden" id="customer" value="<%=cpodata[0][35]%>">
                           <br>
                           <%=cpodata[0][8]%></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven"><div align="left">Shipping To
                           <input name="Shipping" type="hidden" id="Shipping" value="<%=cpodata[0][36]%>">
                         </div></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][9]%> <input name="shippingaddress" type="hidden" id="shippingaddress" value="<%=cpodata[0][9]%>"></td>
                       </tr>
                       <tr>
                         <td class="boldEleven"><div align="left">Quotaion Ref No</div></td>
                         <td class="boldEleven"><%=cpodata[0][2]%></td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven"><div align="left">Order Reference</div></td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][23]%></td>
                       </tr>
                       <tr>
                         <td class="m0l0oout"> P.O Ref No</td>
                         <td class="m0l0oout"><%=cpodata[0][1]%>
                          <input name="cporefno" type="hidden" id="cporefno" value="<%=cpodata[0][1]%>">						  </td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven"><div align="left">Delivery Note</div></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][24]%></td>
                       </tr>
                       <tr>
                         <td class="m0l0oout"> P.O Number </td>
                         <td class="m0l0oout"> 
						 
						  <input name="custponumber" type="text"
												class="formText135"
												onKeyUp="upperMe(this),CheckUniqueNO(this,'poValid',' inv_t_customersalesorder  ','CHR_CUSTPURCHASENO')"
												id="custponumber" size="30" value="<%=cpodata[0][3]%>" maxlength="50">
												<div id="poValid"></div>						 </td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven"><div align="left">Despatch Through</div></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][25]%></td>
                       </tr>
                       <tr>
                         <td valign="top" class="m0l0oout"> P.O date </td>
                         <td class="m0l0oout">
						 <input name="podate" type="text" value="<%=cpodata[0][6]%>"
										class="formText135" id="podate" size="15" readonly />						 </td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven"><div align="left">Destiantion</div></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][26]%></td>
                       </tr>
                       <tr>
                         <td valign="top" class="m0l0oout">Payment Terms</td>
                         <td class="m0l0oout"><%=cpodata[0][13]%>
                         
                          <input name="payment" type="hidden" id="payment" value="<%=cpodata[0][34]%>"></td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven"><div align="left">Terms of Delivery</div></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][27]%></td>
                       </tr>
                       <tr>
                         <td valign="top" class="m0l0oout">Possible Date of Delivery</td>
                         <td class="m0l0oout">
						 <input name="deliverydate" type="text" value="<%=cpodata[0][7]%>"
										class="formText135" id="deliverydate" size="15" readonly />						 </td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven">Contact Person<span class="ui-state-error-text"> </span></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][11]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="m0l0oout">Payment Commitment Days <span class="ui-state-error-text"> </span></td>
                         <td class="m0l0oout"> 
                          <select name="noofpaymentcommitment" class="formText135" id="noofpaymentcommitment" style="width:100">
                          <%
							  for(int u=1;u<=30;u++)
							  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
						  %>
                          </select>  
						  <script language="javascript">setOptionValue('noofpaymentcommitment','<%=cpodata[0][22].trim()%>')</script>						  </td>
						  
						  
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven">Contact No.<span class="ui-state-error-text"> </span></td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][12]%></td>
                       </tr>
                       <tr>
                         <td valign="top" class="m0l0oout">Installation / Implementation Required</td>
                         <td class="m0l0oout"> 
						 <select name="installation" class="formText135" id="installation" style="width:100">
                                     
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select>
<script language="javascript">setOptionValue('installation','<%=cpodata[0][30].trim()%>')</script>						 </td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td width="111" align="left" valign="top" class="boldEleven">Division</td>
                         <td width="225" align="left" valign="top" class="boldEleven"><%=cpodata[0][5]%>
                          <input name="division" type="hidden" id="division" value="<%=cpodata[0][32]%>">
                          <input name="ref" type="hidden" id="ref" value="<%=cpodata[0][33]%>"></td>
                       </tr>
                       <tr>
                         <td valign="top" class="m0l0oout">Billed in Multiple Location</td>
                         <td class="m0l0oout"> 
						 <select name="multipleloaction" class="formText135" id="multipleloaction" style="width:100">
                                    
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select>
<script language="javascript">setOptionValue('multipleloaction','<%=cpodata[0][31].trim()%>')</script>						 </td>
                         <td class="boldEleven">&nbsp;</td>
                         <td class="boldEleven">Tax Type</td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][28]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="m0l0oout">Multiple Bill <span class="ui-state-error-text">  </span></td>
                         <td class="m0l0oout"> <span class="boldEleven">
                           <select name="multiplebill" class="formText135" id="multiplebill" style="width:100">
                             <option value="Y">Yes</option>
                             <option value="N" selected="selected">No</option>
                           </select>
						   <script language="javascript">setOptionValue('multiplebill','<%=cpodata[0][37].trim()%>')</script>	
                         </span></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">Project</td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][29]%></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="m0l0oout">Block Invoice </td>
                         <td class="m0l0oout"><span class="boldEleven">
						 <input name="blockinvoice" <%="Y".equals(cpodata[0][41])?" checked = 'checked' ":""%> type="checkbox" id="blockinvoice" value="Y" >
						  
						 </span></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">Delivery <span class="ui-state-error-text">  </span></td>
                         <td align="left" valign="top" class="boldEleven"> 
                           <select name="delivery" class="formText135" id="delivery" style="width:100">
                             <option value="Y">Yes</option>
                             <option value="N" selected="selected">No</option>
                           </select>
						  <script language="javascript">setOptionValue('delivery','<%=cpodata[0][40].trim()%>')</script>						   </td>
                       </tr>
                       <tr>
                         <td valign="top" class="m0l0oout">Bank Guarantee<span class="ui-state-error-text"> </span></td>
                         <td class="m0l0oout"><span class="boldEleven">
                           <select name="bankguarantee" class="formText135" id="bankguarantee" style="width:100">
                             <option value="Y">Yes</option>
                             <option value="N" selected="selected">No</option>
                           </select>
						   <script language="javascript">setOptionValue('bankguarantee','<%=cpodata[0][39].trim()%>')</script>
                         </span></td>
                         <td valign="top" class="boldEleven">&nbsp;</td>
                         <td valign="top" class="boldEleven">Stock Type</td>
                         <td align="left" valign="top" class="boldEleven">
                           <select name="stocktype" class="formText135" id="stocktype" style="width:100">
                             <option value="G"  selected="selected">General</option>
                             <option value="B">B2B</option>
                           </select>
						   <%
						   String sttype="";
						   if("General".equals(cpodata[0][50]))
						   	sttype="G";
						   else
						   	sttype="B";
						   %>
						   <script language="javascript">setOptionValue('stocktype','<%=sttype%>')</script>						   </td>
                       </tr>
                       
                        
                       <tr>
                         <td valign="top" class="boldEleven">Liquidated Damage </td>
                         <td class="boldEleven">
                           <select name="demurrage" class="formText135" id="demurrage" style="width:100" onChange="checkDemurrage()">
                             <option value="Y">Yes</option>
                             <option value="N" selected="selected">No</option>
                           </select>
						   <script language="javascript">setOptionValue('demurrage','<%=cpodata[0][52].trim()%>')</script>						   </td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">Damage % </td>
                         <td align="left" valign="top" class="boldEleven">
						 <select name="demurragepercentage" class="formText135" id="demurragepercentage" style="width:100" >
                                
                                <%
								for(int u=1;u<100;u++)
									out.println("<option value='"+u+"'>"+(u)+" - %</option>");
								%>
                                  </select>
						<script language="javascript">setOptionValue('demurragepercentage','<%=cpodata[0][53].trim()%>')</script>						 </td>
                       </tr>
                       <tr>
                         <td valign="top" class="copyright">&nbsp;</td>
                         <td class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">Damage Days </td>
                         <td align="left" valign="top" class="boldEleven">
						 <select name="demurragedays" class="formText135" id="demurragedays" style="width:100">
                                    
                                    <%
								  for(int u=0;u<=30;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                                  </select>
						<script language="javascript">setOptionValue('demurragedays','<%=cpodata[0][54].trim()%>')</script>						 </td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">Partial Bill <span class="ui-state-error-text"></span></td>
                         <td class="boldEleven"><select name="partialbill" class="formText135" id="partialbill" style="width:100">
                           <option value="Y">Yes</option>
                           <option value="N" selected="selected">No</option>
                         </select><script language="javascript">setOptionValue('partialbill','<%=cpodata[0][51]%>')</script></td>
                         <td width="8" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">
                         </td>
                        </tr>
                       <tr>
                         <td valign="top" class="boldEleven">Vendor Payment <span class="boldElevenlink">*</span></td>
                         <td class="boldEleven"><select name="vendotpayment" class="formText135" id="vendotpayment" >
                           <%
								String paymentids[][] = CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms ORDER BY CHR_PAYMENTNAME");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
                         </select>
                         <script language="javascript">setOptionValue('vendotpayment','<%=cpodata[0][59]%>')</script>
                         </td>
                         <td valign="top" class="boldEleven">&nbsp;</td>
                         <td valign="top" class="boldEleven">Vendor payment Commitment days <span class="boldElevenlink">* </span></td>
                         <td align="left" valign="top" class="boldEleven"><select name="vendorpaymentcommitment" class="formText135" id="vendorpaymentcommitment">
                           <option value="0">Select</option>
                           <%
								  	for(int k=1;k<=100;k++)
										out.println("<option value='"+k+"'>"+k+" - Days</option>");
								  %>
                         </select><script language="javascript">setOptionValue('vendorpaymentcommitment','<%=cpodata[0][58]%>')</script></td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">RFC Description </td>
                         <td class="boldEleven"><%=cpodata[0][56]%> </td>
                         <td valign="top" class="boldEleven">&nbsp;</td>
                         <td valign="top" class="boldEleven">ORC Description </td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][60]%></td>
                       </tr>
                       
                       <tr>
                         <td valign="top" class="boldEleven">PR Description</td>
                         <td ><span class="boldEleven"><%=cpodata[0][57]%>
                           <input type="hidden" name="PRDescription" id="PRDescription" value="<%=cpodata[0][57]%>">
                         </span></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">CPO Status <span class="boldElevenlink">*</span></td>
                         <td align="left" valign="top" class="boldEleven"><select name="cpostatus" id="cpostatus"  class="formText135">
                           <option value="0">Select CPO Status</option>
                           <option value="1">Not Action</option>
                           <option value="2">Price Clearance</option>
                           <option value="3">Payment Block</option>
                           <option value="4">Awaiting for customer confirmation</option>
                           <option value="5">Hold</option>
                           <option value="6">Reject</option>
                           <option value="7">Advance from Customer</option>
                           <option value="8">Vendor confirmation</option>
                           <option value="9">Execute</option>
                           <option value="10">Others</option>
                         </select>
                         <script language="javascript">setOptionValue('cpostatus','<%=cpodata[0][61]%>')</script>
                         </td>
                       </tr>
                       <tr>
                         <td valign="top" class="boldEleven">OVERALL STOCK AVAILABILITY </td>
                         <td >
						 <%
						 	String sflag = InventoryInvoiceFunctions.CPOReasdytoBill(cpodata[0][1]);
							if(sflag =="B")
								out.println("<font class='bolddeepred'><h1>Stock Available</h1></font>");
							else if(sflag =="P")
								out.println(" <font class='boldgreen'><h1>Stock Partially Available</h1></font> ");
							else	
								out.println(" <font class='boldgreen'><h1>Stock not Available</h1></font> ");
								
							if(sflag =="B")
								out.println("<input name='saleorderapproval' id='saleorderapproval' type='hidden' value='Y'>");
							else if(sflag =="P")
								out.println("<input name='saleorderapproval' id='saleorderapproval' type='hidden' value='N'>");
							else	
								out.println("<input name='saleorderapproval' id='saleorderapproval' type='hidden' value='N'>");
								
								
								
							
						 %>						 </td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                       </tr>
                       
                        
                   </table></td>
                 </tr>
                 <tr>
                   <td><%=cpodata[0][56]%></td>
                 </tr>
                 <tr>
                   <td>
				   
				   <%
					 	
				sql = " SELECT   a.CHR_TYPE ,a.CHR_ITEMID,a.CHR_DESC,";
				sql = sql +"  if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT' ), ";
				sql = sql +"  FUN_INV_PRODUCTCODE(a.CHR_TYPE,a.CHR_ITEMID)   productcode, ";
				sql = sql +"  FUN_INV_PRODUCTDESCRIPTION(a.CHR_TYPE,a.CHR_ITEMID)   productdescription, ";
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
				sql = sql +" a.INT_WARRANTY,  ";
				sql = sql +" a.CHR_PR_FLAG,a.INT_PR_QTY,a.INT_PR_WARRANTY,a.INT_PR_VENDOR_ID,a.DOU_PR_PRICE,a.INT_PR_TAXID,a.CHR_PR_DESC,  ";
				sql = sql +"  a.INT_TAXID,a.INT_ID ";
				sql = sql +"  from inv_t_customersalesorderitem a ,inv_m_tax b  where a.INT_TAXID=b.INT_TAXID ";
				sql = sql +"  AND CHR_SALESORDERNO='"+cpodata[0][1]+"'";
				
				 //out.println(sql);
				
				 
				String itemDatas[][]=  CommonFunctions.QueryExecute(sql);
				int rlength=0;
				if(itemDatas.length>0)
					rlength=itemDatas.length;
				out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.print("<tr  class='MRow1'>");
				out.print("<th  class='boldEleven'  rowspan='2'><b>S.NO</b></th>");
				//out.print("<th  class='boldEleven' rowspan='2'><b>Type</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>ITEM / PRODUCT</b></th>");
          		out.print("<th  class='boldEleven' rowspan='2'><b>DESCRIPTION</b></th>");
                out.print("<th  class='boldEleven' rowspan='2'><b>QUANTITY</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>WARRANTY</b></th>");
				
				out.print("<th  class='boldEleven' colspan='3'><b>STOCK AVAILABILITY</b></th>");
				
                out.print("<th  class='boldEleven' rowspan='2'><b>UNIT PRICE</b></th>");
                //out.print("<th  class='boldEleven' rowspan='2'><b>Discount(%)</b></th>");
               // out.print("<th  class='boldEleven rowspan='2'><b>Unit Discount</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>TAX</b></th>");
				//out.print("<th  class='boldEleven' rowspan='2'><b>Tax Value</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>TAX AMOUNT</b></th>");
                out.print("<th  class='boldEleven' rowspan='2'><b>TOTAL</b></th>");
				
				//out.print("<th  class='boldEleven' rowspan='2'><b>STOCK BLOCKING</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>PURCHASE REQUEST</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>PURCHASE QUANTITY</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>PURCHASE WARRANTY</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>VENDOR</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>PURCHASE UNIT PRICE</b></th>");
				out.print("<th  class='boldEleven' rowspan='2'><b>PURCHASE TAX</b></th>");
				
				out.print("<th  class='boldEleven' rowspan='2'><b>DESCRIPTION</b></th> ");
				out.print("</tr> ");
				out.print("<tr  class='MRow1'> ");
				out.print("<th class='boldEleven' ><b>ORDERED</th> ");
				out.print("<th class='boldEleven' ><b>ORDERED IN HAND</th> ");
				out.print("<th class='boldEleven' ><b>BRANCH&nbsp;/&nbsp;OVER ALL</th> ");
				out.print("</tr> ");
				int stock=0;
				int branchstock=0;
				int qty=0;
				String  cc =" checked = 'checked' ";
				 
				
				for(int u=0; u<itemDatas.length;u++)
				{
					
					stock=0;
					qty=0; 
					qty=Integer.parseInt(itemDatas[u][6]);
					stock=Integer.parseInt(itemDatas[u][15]);
					branchstock=Integer.parseInt(itemDatas[u][17]);
					
					 
					cc=" checked = 'checked' ";
					
					if(qty >=branchstock)
				  		cc=" checked = 'checked' ";
					else
						cc="";	
					
					//5cb85c-Success    5bc0de-Info   f0ad4e-Warning 	 d9534f-Danger
					if(qty >stock)
					{
						out.println("<tr class='MRow4'>");
					}
					else
					{	
						if(u%2==1)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr  class='MRow2'>");	 
					}	
					out.println(" <td   class='boldEleven' >"+(u+1)+".</td>");
					//out.println(" <td   class='boldEleven' >"+itemDatas[u][3]+"</td>");
					out.println("<td  class='boldEleven' >"+itemDatas[u][4] +"</td>");
					out.println("<td  class='boldEleven' >"+itemDatas[u][5] +"</td>");
					
					if(qty >stock)
						out.println("<td  class='boldEleven' >"+itemDatas[u][6] +"<img src='../images/alert.gif'> ");
					else
						out.println("<td  class='boldEleven' >"+itemDatas[u][6]  );
					
					out.println("<input name='cpoqty"+(u+1)+"'  id='cpoqty"+(u+1)+"' type='hidden' value='"+itemDatas[u][6]+"'></td>");
					
					//Warranty
					out.println("<td  class='boldEleven' >"+itemDatas[u][18]+" -yrs</td>"  );
					out.println("<input name='swarranty"+(u+1)+"'  id='swarranty"+(u+1)+"' type='hidden' value='"+itemDatas[u][18]+"'></td>");
					
					//Ordered
					sql = " SELECT SUM(b.INT_QUANTITY) FROM inv_t_purchaserequest a, inv_t_purchaserequestitem b ";
					sql = sql + " WHERE a.CHR_POREQUESTNO =b.CHR_POREQUESTNO ";
					sql = sql + " AND b.CHR_ITEMID = '"+itemDatas[u][1]+"' ";
					sql = sql + " AND b.CHR_TYPE= '"+itemDatas[u][0]+"' ";
					sql = sql + " AND a.CHR_PR_PARTIALLY_RECEIVED = 'N' ";
					sql = sql + " GROUP BY b.CHR_ITEMID ";
					String orderdata[][] = CommonFunctions.QueryExecute(sql);
					int orderquantity=0;
					if(orderdata.length>0)
						orderquantity = Integer.parseInt(orderdata[0][0]);
					
					if(orderquantity>0)
					 	out.println("<td  class='boldEleven' >"+orderquantity+" /  <a target='_blank' href='Rept_OrderedQuantityforPR.jsp?itype="+itemDatas[u][0]+"&item="+itemDatas[u][1]+"'>Details</a></td>");
					else
						out.println("<td  class='boldEleven' >"+orderquantity+"</td>");
					
					
					//ORDERED IN HAND
					out.println("<td  class='boldEleven' ><font class='boldgreen'>&nbsp;</font></td>" );
					
					//Branch Stock / Overall Stock
					out.println("<td  class='boldEleven' ><font class='boldgreen'>"+itemDatas[u][17]+"&nbsp;/&nbsp;"+itemDatas[u][15]+"</font> / " );//Stock
					
					if("S".equals(itemDatas[u][14]))
					{
						out.println(" CONSUMABLES / <a target='_blank' href='Rept_ConsumablesStocksPrint.jsp?Branch=0&division=0&product="+itemDatas[u][1] +"'>  Details</a> ");
					}
					else
					{
					//"Rept_ConsumablesStocksPrint.jsp?Branch=0&division=0product="+itemDatas[u][1]
					  out.println(" SERIALS / <a target='_blank' href='Rept_StockSerialPrint.jsp?Branch=0&itype="+itemDatas[u][0]+"&item="+itemDatas[u][1]+"&division=0&pgroup=0&buyback=0'> Details</a> ");
					}
					out.println("</td>");
					
					out.println("<td  class='boldEleven' >"+itemDatas[u][7] +"</td>");
					//out.println("<td  class='boldEleven' >"+itemDatas[u][8] +"</td>");
					//out.println("<td  class='boldEleven' >"+itemDatas[u][9] +"</td>");
					
					//tax id
					out.println("<td  class='boldEleven' >"+itemDatas[u][10]);
					out.println(" <input name='CPORowid"+(u+1)+"' type='hidden' id='CPORowid"+(u+1)+"' value="+itemDatas[u][16] +">");
					out.println(" <input name='stax"+(u+1)+"' type='hidden' id='stax"+(u+1)+"' value="+itemDatas[u][26] +">");
					out.println(" <input name='staxpercentage"+(u+1)+"' type='hidden' id='staxpercentage"+(u+1)+"' value="+itemDatas[u][11] +">");
					out.println(" <input name='staxamount"+(u+1)+"' type='hidden' id='staxamount"+(u+1)+"' value="+itemDatas[u][12] +">");
					out.println("</td>");
					
					//out.println("<td  class='boldEleven' >"+itemDatas[u][11] +"</td>");
					
					//Tax amount
					out.println("<td  class='boldEleven' >"+itemDatas[u][12] +"</td>");
					
					//Total
					out.println("<td  class='boldEleven' >"+itemDatas[u][13] +"</td>");
					
					
					//Stock Blocking say yes / no  if("S".equals(itemDatas[u][14]))
					/*if(  (qty <=stock)  && (!"S".equals(itemDatas[u][14]))  )
					 out.println("<td  class='boldEleven' bgcolor='#8FBC8F'><input class='formText135'  name='stockblockingflag"+(u+1)+"'  id='stockblockingflag"+(u+1)+"' type='checkbox' value='Y'></td>");
					else
					 out.println("<td  class='boldEleven' bgcolor='#8FBC8F'><input name='stockblockingflag"+(u+1)+"'  id='stockblockingflag"+(u+1)+"' type='hidden' value='N'></td>");
					 */
					
					//Purchase Request Flag
					out.println("<td  class='boldEleven' > <input  class='formText135' "+cc+" name='purchaserequestflag"+(u+1)+"'  id='purchaserequestflag"+(u+1)+"' type='checkbox' value='Y' onclick=\"checkPurchaseQuantity('purchaserequestflag"+(u+1)+"')\"  "+("Y".equals(itemDatas[u][19])?" checked = 'checked' " :" ")+"> ");
					out.println(" <input  class='formText135'  name='rowid"+(u+1)+"'  id='rowid"+(u+1)+"' type='hidden' value='"+itemDatas[u][16]+"'  ></td>");
					
					
					
					//Purchase Quantity
					if(qty >stock)
						out.println("<td  class='boldEleven' > <input class='formText135' name='pqty"+(u+1)+"'  id='pqty"+(u+1)+"' type='text' value='"+itemDatas[u][20] +"' size='8' maxlength='4'   style='text-align:right'  onKeyPress=\" return numeric_only(event,'pqty"+(u+1)+"','15') \"></td>");
					else
						out.println("<td  class='boldEleven' > <input class='formText135' name='pqty"+(u+1)+"'  id='pqty"+(u+1)+"' type='text' value='"+itemDatas[u][20] +"'  size='8' maxlength='4'   style='text-align:right'  onKeyPress=\" return numeric_only(event,'pqty"+(u+1)+"','15') \"></td>");
						
					//Warranty
					out.print("<td class='boldEleven'><select class='formText135'   style='width:100'  name='warranty"+(u+1)+"' id ='warranty"+(u+1)+"'   >"+warrantyinsert+" </select> ");
					out.print("<script language='javascript'>");
					out.print("setOptionValue('warranty"+(u+1)+"','"+itemDatas[u][21]+"')");
					out.print("</script>");
					out.print("</td>"); 
							
					//Vendor Name
					out.println("<td  class='boldEleven' ><select  class='formText135'  name='Vendor"+(u+1)+"' id='Vendor"+(u+1)+"'  style='width:100'>"+vendoroption+"</select>");
					out.print("<script language='javascript'>");
					out.print("setOptionValue('Vendor"+(u+1)+"','"+itemDatas[u][22]+"')");
					out.print("</script>");
					out.print("</td>"); 
					
					
					//unit purchase Price
					double pp= Double.parseDouble(itemDatas[u][7]);
					if(pp>0)
						pp = pp - (pp*10/100);
						
					out.println("<td  class='boldEleven' > <input class='formText135' name='unitpurchaseprice"+(u+1)+"'  id='unitpurchaseprice"+(u+1)+"' type='text'    style='text-align:right'  size='8' maxlength='10'  onKeyPress=\" return numeric_only(event,'unitpurchaseprice"+(u+1)+"','15') \" value='"+itemDatas[u][23]+"' ></td>");
					
					
					//Purchase Tax
					out.print("<td class='boldEleven'><select class='formText135'   style='width:100'  name='ptax"+(u+1)+"' id ='ptax"+(u+1)+"'   >"+optiontaxname+" </select>");
					out.print("<script language='javascript'>");
					out.print("setOptionValue('ptax"+(u+1)+"','"+itemDatas[u][24]+"')");
					out.print("</script>");
					out.print("</td>"); 
					
					//description
					out.println("<td  class='boldEleven' > <textarea name='descriptions"+(u+1)+"' id='descriptions"+(u+1)+"' cols='10' rows='5' onBlur=\"textArea('descriptions"+(u+1)+"','200')\">"+itemDatas[u][25]+"</textarea>   </td>"); 
				}
				out.print("</table> ");
					
					
				   %>
				   <input name="rlength" type="hidden" id="rlength" value="<%=rlength%>"></td>
                 </tr>
                 <tr>
                   <td></td>
                 </tr>
                 <tr>
                   <td valign="top" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
                       <tr>
                         <td width="164" valign="top" class="boldEleven"><div align="left" class="boldEleven">Description</div></td>
                         <td colspan="3" rowspan="2" valign="top" class="boldEleven"><div align="left"><%=cpodata[0][14]%>
                            
                         </div></td>
                         <td width="170" valign="top" class="m0l0oout"><div align="left">Total</div></td>
                         <td width="194"   valign="top" class="m0l0oout" id="totals1"><div align="right"><%=cpodata[0][16]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td width="164" valign="top" class="boldEleven">&nbsp;</td>
                         <td valign="top" class="m0l0oout"><div align="left">Total Discount</div></td>
                         <td valign="top" class="m0l0oout"
										id="totaldiscount1"><div align="right"><%=cpodata[0][17]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td width="164" valign="top" class="boldEleven"><div align="left" class="boldEleven">Sale Reference 1
                           <input name="filename" type="hidden" value="CPOVerification" />
                               <input name="actionS"  type="hidden" value="INVCPOVerificationUpdate" />
                         </div></td>
                         <td valign="top" class="boldEleven"><div align="left"><%=cpodata[0][15]%> </div></td>
                         <td width="61" valign="top" class="boldEleven"><div align="right"><%=cpodata[0][42] +"%" %></div></td>
                         <td width="46" valign="top" class="boldEleven">&nbsp;</td>
                         <td valign="top" class="m0l0oout"><div align="left">Tax Group</div></td>
                         <td valign="top" class="m0l0oout" id="tax1"><div align="right"><%=cpodata[0][18]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td width="164" valign="top" class="boldEleven"><div align="left">Sale Reference 2 </div></td>
                         <td valign="top" class="boldEleven"><%=cpodata[0][43] %></td>
                         <td valign="top" class="boldEleven"><div align="right"><%=cpodata[0][44] +"%" %></div></td>
                         <td valign="top" class="boldEleven">&nbsp;</td>
                         <td valign="top" class="m0l0oout"><div align="left">Sales Tax (%)</div></td>
                         <td valign="top" class="m0l0oout" id="salestax1"><div align="right"><%=cpodata[0][19]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">Sale Reference 1 </td>
                         <td width="142" align="left" valign="top" class="boldEleven"><%=cpodata[0][45] %> </td>
                         <td align="left" valign="top" class="boldEleven"><div align="right"><%=cpodata[0][46] +"%" %></div></td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="m0l0oout"><div align="left">Sales Tax Amount</div></td>
                         <td class="m0l0oout" id="salestaxamount1"><div align="right"><%=cpodata[0][20]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">By Back Value
                            
                           <script language="javascript">
								  function byBack()
								  {
								  		 
										if(document.getElementById('byback').checked == true)
										{
											document.getElementById("bybackrow").style.visibility="visible";
										}
										else
										{
											document.getElementById("bybackrow").style.visibility="hidden";
										}
										assignGrandTotal();
								
								  }
								  
								      </script></td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][47] %></td>
                         <td colspan="2" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="m0l0oout">By Back Amount </td>
                         <td align="left" valign="top" class="m0l0oout" id="nettotal1"><div align="right"><%=cpodata[0][49] %>
                            
                         </div></td>
                       </tr>
                       <tr>
                         <td align="left" valign="top" class="boldEleven">By Back Description </td>
                         <td align="left" valign="top" class="boldEleven"><%=cpodata[0][48] %> </td>
                         <td colspan="2" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="m0l0oout">&nbsp;</td>
                         <td class="m0l0oout" id="nettotal1">&nbsp;</td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td colspan="2" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="m0l0oout"><div align="left">
                             <div align="left">Net Total</div>
                         </div></td>
                         <td class="m0l0oout" id="nettotal1"><div align="right"><%=cpodata[0][21]%>
                              
                         </div></td>
                       </tr>
                       <tr>
                         <td class="boldEleven">&nbsp;</td>
                         <td align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td colspan="2" align="left" valign="top" class="boldEleven">&nbsp;</td>
                         <td class="m0l0oout">&nbsp;</td>
                         <td class="m0l0oout" id="nettotal1">&nbsp;</td>
                       </tr>
                       <tr>
                         <td colspan="6" class="boldEleven"><table width="230" border="0" align="center" cellpadding="3"
										cellspacing="3">
                             <tr>
                               <td width="114"> 
                                   
   <input name='Submit' id='Submit'  type='submit' class='tMLAscreenHead' value='Submit'  /> 
                               </td>
                               <td width="95"><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="javascript:history.back(1)" /></td>
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
function checkPurchaseQuantity(ctr)
{
	try
	{
		var itm=document.getElementById(ctr);
  		var idname = itm.name;
  		var idposition = idname.replace("purchaserequestflag","");
		if(document.getElementById(ctr).checked)
			document.getElementById("pqty"+idposition).value= document.getElementById("cpoqty"+idposition).value;
		else
			document.getElementById("pqty"+idposition).value= 0;
		 
		
	}
	catch(err)
	{
		alert(err);
	}
}


function Validate()
{
 	try
	{
		 
		if(!checkNullSelect('cpostatus','Select CPO Status','0'))
			return false;
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
	}
	catch(err)
	{
		alert(err.description);	
		return false;
	}	  
}
		  	
/*			var name=confirm("Confirm, All the informations are correct");
			if (name==true) 
			 	return true; 
			else
				return false;	
*/			 
		  
 
  
function CheckRows(u)
{
	  try
	  {
		if(document.getElementById('purchaserequestflag'+(u+1)).checked)
		{		
				if(
					 checkNull('pqty'+(u+1),'Enter the purchase Quantity') 
					&& checkNullSelect('Vendor'+(u+1),'Select Vendor','') 
					&& checkNullSelect('ptax'+(u+1),'Select Tax','') 
					&& checkNull('unitpurchaseprice'+(u+1),'Enter the Unitprice') 
					&& checkNull('descriptions'+(u+1),'Enter the descriptions ') 
				 )
				{
					var pqty = parseInt(document.getElementById('pqty'+(u+1)).value );
					if(pqty>0)
						return true;
					else
					{
						alert("Quantity should not zero");
						document.getElementById('pqty'+(u+1)).focus();
						return false;	
					}
				}	
				else
					return false;		   
		}
		else
		{
			return true;			
		}
	}
	catch(err)
	{
		alert(err.description);	
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
