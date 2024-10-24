<%@ page import="java.io.*,java.util.*" isErrorPage="false"	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
 
<%
try
{

 							
String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax ORDER BY CHR_TAXNAME");
String optiontaxname="<option value=''>Select Tax</option>";//<option value='0'>No Tax</option>
for(int u=0; u<taxids.length; u++)
	optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";

String warrantyinsert="";
warrantyinsert = warrantyinsert + "<option  value='1' selected='selected'>1 - Year</option>";
warrantyinsert = warrantyinsert + "<option  value='0'>No Warranty </option>";
for(int u=2;u<=10;u++)
	warrantyinsert = warrantyinsert + "<option  value='"+u+"'>"+u+" - Years</option>";

%><html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
 
$(function() {
		var dates = $( "#orderdate, #requestdate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			minDate: -4, maxDate: "+2D" ,showOn: "button",
			onSelect: function( selectedDate ) {
				var option = this.id == "orderdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});
	
	
$(function() {
		$( "#duedt" ).datepicker(
		{ 
		buttonImage: "../JavaScript/jquery/images/calendar.gif",
		buttonImageOnly: true,
		defaultDate: "+1w",
			changeMonth: true,
			minDate: -0, maxDate: "+7D" 
		});
	});
 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">





 <script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<body >
<%@ include file="indexinv.jsp"%>
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
					<%	
		   	try
			{
			  	String purchaseno=request.getParameter("ponumber");
				String field = " INT_BRANCHID,INT_PURCHASEORDERID,CHR_PURCHASEORDERNO,INT_VENDORID,	 ";
				field = field + " CHR_POREQUESTNO,DATE_FORMAT(DAT_ORDERDATE,'%d-%m-%Y'),  ";
				field = field + " DATE_FORMAT(DAT_REQUESTDATE,'%d-%m-%Y'),INT_ADDRESSID1, ";	
				field = field + " INT_ADDRESSID2,INT_ONHOLD,INT_CONDITIONID,INT_PAYMENTTERMID, ";
				field = field + " CHR_DES,CHR_REF,CHR_DISCOUNT,INT_TAXID,DOU_AMOUNT,DOU_TAXAMOUNT,	 ";
				field = field + " DOU_TOTALAMOUNT,INT_PURCHASESTATUS,	CHR_RECIVEDID,DAT_RECIVEDDATE,	 ";
				field = field + " CHR_PAYMENTSTATUS,	CHR_RECIVEDBY,	DOU_PAIDAMOUNT,	INT_DIVIID,DOU_FRIEGHT_CHARGE,CHR_USRNAME,	 ";
				field = field + " DT_UPDATEDATE,CHR_UPDATESTATUS ";
				String sql = "SELECT "+field+" FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				//out.println(sql);
				boolean flag = false;
				boolean buttonflag = false;
				flag =  CommonInfo.RecordExist("SELECT COUNT(*) FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'");
				if(flag)
				{
				String purchaseData[][]=  CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return valid()">
					<table width="750" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="755"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">VENDOR PURCHASE ORDER </div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="668" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Purchase Order No									<span class="boldred"> </span> </div>									</td>
									<td width="198" class="boldEleven">
									<div align="left"><%=purchaseno%> <input name="ponumber"
										readonly="readonly" value="<%=purchaseno%>" type="hidden"
										class="formText135" id="ponumber" maxlength="25"></div>									</td>
									<td width="102" class="boldEleven">
									<div align="left">Payment Mode									<span class="boldred">*</span> </div>									</td>
									<td width="237" class="boldEleven">
									<div align="left"><select name="payment"
										class="formText135" id="payment" tabindex="3"  style="width:200">
										<option value="0">Select payment </option>
										<%
									
								String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTCONDITIONID,CHR_PAYMENTNAME from inv_m_paymentcondition ORDER BY CHR_PAYMENTNAME ");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
						%>
									</select> 
									<script language="javascript">setOptionValue('payment','<%=purchaseData[0][10]%>')</script>
									</div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor									<span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="vendorid"
										class="formText135" id="vendorid" tabindex="1" style="width:200">
										<option value="0">Select Vendor</option>
										<%
                          		String venid = purchaseData[0][3].trim();
                          		String vendorids[][] = CommonFunctions.QueryExecute("Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation ");
								for(int u=0; u<vendorids.length; u++)
									if(venid.equals(vendorids[u][0].trim()))
										out.print("<option  selected='selected' value='"+vendorids[u][0]+"'>"+vendorids[u][1]+"</option>");
									else
										out.print("<option  value='"+vendorids[u][0]+"'>"+vendorids[u][1]+"</option>");
							%>
									</select></div>									</td>
									<td class="boldEleven">
									<div align="left">Payment Terms									<span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="paymentterm"
										class="formText135" id="paymentterm" tabindex="3" style="width:200">
										<option>Select</option>
										<%
                          	String paymentterms[][] = CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms ORDER BY CHR_PAYMENTNAME");
								for(int u=0; u<paymentterms.length; u++)
									out.print("<option value='"+paymentterms[u][0]+"'>"+paymentterms[u][1]+"</option>");
							%>
									</select><script language="javascript">setOptionValue('paymentterm','<%=purchaseData[0][10]%>')</script></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Order Date									<span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left">
									 
									<input name="orderdate" type="text"
										class="formText135" id="orderdate" tabindex="2"
										value=<%=purchaseData[0][5]%> size="15" maxlength="11"
										readonly="readonly" />
									</div>									</td>
									<td class="boldEleven">
									<div align="left">Order From									<span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left">
									<select name="order"
										class="formText135" id="order" tabindex="5" style="width:200">
										<option>Select</option>
										<%
								String orderfrom = purchaseData[0][7].trim();
                          		String branchids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND a.INT_ACTIVE=1   AND b.INT_ACTIVE=1 ");
								for(int u=0; u<branchids.length; u++)
									if(orderfrom.equals(branchids[u][0].trim()))
										out.print("<option value='"+branchids[u][0]+"' selected>"+branchids[u][2]+ "  @  " +branchids[u][1] +"</option>"); 
									else
										out.print("<option value='"+branchids[u][0]+"'>"+branchids[u][2]+ "  @  " +branchids[u][1] +"</option>"); 
							%>
									</select> </div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Request Date									<span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left">
									 <input name="requestdate" type="text"
										class="formText135" id="requestdate" tabindex="2"
										value=<%=purchaseData[0][6]%> size="15" maxlength="11"
										readonly="readonly" />  </div>									</td>
									<td class="boldEleven">
									<div align="left">Shipping To									<span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="ship" class="formText135"
										id="ship" tabindex="6"  style="width:200">
										<option>Select</option>
										<%
                          String shippingto = purchaseData[0][7].trim();
                           String shipids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND a.INT_ACTIVE=1   AND b.INT_ACTIVE=1 ");
								for(int u=0; u<shipids.length; u++)
									if(shippingto.equals(shipids[u][0].trim()))
										out.print("<option value='"+shipids[u][0]+"'  selected >"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>"); 
									else 
										out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>"); 
							%>
									</select></div>									</td>
								</tr>
								<tr>
								  <td class="boldEleven"><div align="left">On Hold</div></td>
								  <td class="boldEleven"><div align="left">
                                    <%
                    	String onhold = purchaseData[0][8].trim();
                    	String onholdstatus="";
                    	if("1".equals(onhold.trim()))
                    			onholdstatus = "checked = checked";
                    	else
                    			onholdstatus="";
                    %>
                                    <input name="hold" <%=onholdstatus %>
										type="checkbox" id="hold" value="checkbox" tabindex="4" />
								    </div>								   </td>
								  <td class="boldEleven">Division									<span class="boldred">*</span> </td>
								  <td class="boldEleven"><select name="division"
										class="formText135" id="division" tabindex="1"  style="width:200">
                                    <option value='Select'>Select</option>
                                    <%
								String division[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                  </select><script language="javascript">setOptionValue('division','<%=purchaseData[0][25]%>')</script></td>
							  </tr>
								<tr>
									<td class="boldEleven">Verified									<span class="boldred">*</span> </td>
									<td class="boldEleven"> 
									  <select name="verified" class="formText135" id="verified">
                                      <option value="0">Select Verification</option>
                                      <option value="Y">Yes</option>
                                      <option value="N">No</option>
							        </select></td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">								    </td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
 <div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto" class="boldEleven">
							<%
			  
			  	 
				sql = " SELECT  a.CHR_TYPE,a.CHR_ITEMID,  ";
				sql = sql +" if(a.CHR_TYPE='I','Item','Product'),   ";  
				sql = sql +" if(a.CHR_TYPE='I',     ";
				sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID)    "; 
				sql = sql +"  ,    ";
				sql = sql +" (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist  c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
				sql = sql +" ),    ";
				sql = sql +" if(a.CHR_TYPE='I',    "; 
				sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)   ";  
				sql = sql +"  ,    ";
				sql = sql +" (SELECT e.CHR_PRODUCTDESC  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)  ";   
				sql = sql +" ),   ";  
				sql = sql +" a.INT_QUANTITY, a.DOU_UNITPRICE,a.CHR_DISCOUNT,a.DOU_UNITDISCOUNT,  ";
				sql = sql +" a.INT_TAXID,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT,  ";
				sql = sql +" a.DOU_TOTAL, a.INT_WARRANTY    ";
				sql = sql +" From  inv_t_vendorpurchaseorderitem a ,inv_m_tax b  ";
				sql = sql +" WHERE a.INT_TAXID =b.INT_TAXID AND a.CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				//out.println(sql);
				String itemData[][]=  CommonFunctions.QueryExecute(sql);
				String param="0,";
				String args="";
				if(itemData.length>0)
				{
					out.print("<table id='myTable' width='100%' border='1' cellpadding='3' cellspacing='0'  >");
					out.print("<th  class='boldEleven'><b>Type</b></th>");
					out.print("<th  class='boldEleven'><b>Item / Product</b></th>");
					out.print("<th  class='boldEleven'><b>Description</b></th>");
					out.print("<th  class='boldEleven'><b>Warranty</b></th>");
					out.print("<th  class='boldEleven'><b>Quantity</b></th>");
					out.print("<th  class='boldEleven'><b>Unit Price</b></th>");
					out.print("<th  class='boldEleven'><b>Discount(%)</b></th>");
					out.print("<th  class='boldEleven'><b>Unit Discount</b></th>");
					out.print("<th class='boldEleven'><b>Tax</b></th>");
					out.print("<th class='boldEleven'><b>Tax (%)</b></th>");
					out.print("<th class='boldEleven'><b>Tax Amount </b></th>");
					out.print("<th  class='boldEleven'><b>Total</b></th>");
					 
	                String  i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,vf0,vf1,vf2,vf3,vf4,vf5;
					args=""; 
					i0="";
                	i1 ="qty";
                	i2 ="uprice";
                	i3 ="discount";
                	i4 ="unitdiscount";
                	i5 ="total";
                	i6="item";
					i7="desc";
					i8 = "stax";
					i9 = "staxpercentage";
					i10 = "staxamount";
                	i11 = "warranty"; 
					for(int u=0; u<itemData.length;u++)
					{
						args= args+(u+1)+",";
						param = u+",";
						i0="itype"+(u+1);
						i1 ="qty"+(u+1);
						i2 ="uprice"+(u+1);
						i3 ="discount"+(u+1);
						i4 ="unitdiscount"+(u+1);
						i5 ="total"+(u+1);
						i6 ="item"+(u+1);
						i7 ="desc"+(u+1);
						i8 = "stax"+(u+1);
						i9 = "staxpercentage"+(u+1);
						i10 = "staxamount"+(u+1);
						i11 = "warranty"+(u+1);
						
						vf1 = "onKeyPress=\" return numeric_only(event,'"+i1+"','15') \"";
						vf2 = "onKeyPress=\" return numeric_only(event,'"+i2+"','15') \"";
						vf3 = "onKeyPress=\" return numeric_only(event,'"+i3+"','15') \"";
						vf4 = "onKeyPress=\" return numeric_only(event,'"+i4+"','15') \"";
						vf5 = "onKeyPress=\" return numeric_only(event,'"+i5+"','15') \"";
					 
						out.println("<tr>");
						out.println("<td    align='left' valign='top' class='boldEleven' >"+itemData[u][2]+"</td>");
						out.println("<td   align='left' valign='top' class='boldEleven' >"+itemData[u][3]);
						out.print("<input value='"+itemData[u][0]+"' type='hidden' name='"+i0+"'  id='"+i0+"' />");
						out.print("<input value='"+itemData[u][1]+"' type='hidden' name='"+i6+"'  id='"+i6+"' />");
						out.print("<input value='"+itemData[u][4]+"' type='hidden' name='"+i7+"'  id='"+i7+"' /> ");
						out.print("");
						out.print("");
						out.print("");
						out.print("");
						
						
						out.println(" <td   align='left' valign='top'  class='boldEleven' >"+itemData[u][4]+"</td>");
					   	
						out.print("<td class='boldEleven' align='left' valign='top' ><input class='formText135' type='text' size ='10' name='"+i1+"' id='"+i1+"' value ='"+itemData[u][5]+"'  onblur='calculateValues(this)'  style='text-align:right'></td>");
						
						out.print("<td  class='boldEleven' align='left' valign='top' ><select class='formText135'   style='width:100'  name='"+i11+"' id ='"+i11+"'   >"+warrantyinsert+"</select></td>");
						%>
						<script language="javascript">setOptionValue('<%=i1%>','<%=itemData[u][9]%>')</script> 
                	    <%
						
						
						out.print("<td class='boldEleven' align='left' valign='top' ><input class='formText135' type=text size =10 name='"+i2+"' id='"+i2+"' value ='"+itemData[u][6]+"' "+vf2+" onblur=\"document.getElementById('"+i1+"').focus()\"   style='text-align:right'></td>");
					
                		out.print("<td class='boldEleven'   align='left' valign='top' ><input class='formText135' type=text size =10 name='"+i3+"' id='"+i3+"' value ='"+itemData[u][7]+"' "+vf3+" readonly='readonly' style='text-align:right'></td>");
                	
						out.print("<td class='boldEleven'  align='left' valign='top'  ><input class='formText135' type=text size =10 name='"+i4+"' id='"+i4+"' value ='"+itemData[u][8]+"' "+vf4+" readonly='readonly' style='text-align:right'></td>");
                	
						out.print("<td class='boldEleven'  align='left' valign='top'  ><select class='formText135' name='"+i8+"' id ='"+i8+"' onBlur=assignTaxValue('"+i8+"') >"+optiontaxname+"</select></td>");
						%>
						
						<script language="javascript">setOptionValue('<%=i8%>','<%=itemData[u][13]%>')</script> 
                	<%
						out.print("<td class='boldEleven'   align='left' valign='top' ><input class='formText135' type=text size =10 name='"+i9+"' id='"+i9+"' value ='"+itemData[u][10]+"'  readonly='readonly' style='text-align:right'></td>");
                	
						out.print("<td class='boldEleven'   align='left' valign='top' ><input class='formText135' type=text size =10 name='"+i10+"' id='"+i10+"' value ='"+itemData[u][11]+"' readonly='readonly' style='text-align:right'></td>");
                	
					
					
					
						out.print("<td class='boldEleven'  align='left' valign='top'  style='text-align:right'><input class='formText135'type=text size =10 name='"+i5+"' id='"+i5+"' value ='"+itemData[u][12]+"' "+vf5+" readonly='readonly'  style='text-align:right'></td>");
				
						 
				}
				out.print("</table> ");
			}	
			  
			  %>
							</div>
							</td>
						</tr>
						<tr>
							<td><script language="javascript">
			function calculateValues(qty)
			{
  					
  					var qtyposition = (qty.name.replace("qty",""));	
  					var quantity = qty.value;
					if(quantity>=1)
					{
						var uprice = document.getElementById('uprice'+qtyposition).value;
						var discount =document.getElementById('discount'+qtyposition).value;
						var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
						udiscount =(discount/100)*uprice;
						var total = ((quantity * uprice) - (udiscount*quantity));
						document.getElementById('total'+qtyposition).value = total;
						assignGrandTotal();
					}
					else
					{
						alert("Quantity Should not be zero");
						qty.focus();
					}	
  					
			}
			function assignGrandTotal()
			{
				var noofcontrols = "<%=itemData.length%>";
				var tvs =0.0;
				var svalue="";
   				for(u=1; u<=noofcontrols;u++)
					tvs= tvs+parseFloat(document.getElementById('total'+u).value);
				document.getElementById("totals").value=tvs;
							
				var tot = parseFloat(document.getElementById("totals").value);
				var discount = parseFloat(document.getElementById("totaldiscount").value);
				var discountamount=0.0;
				if(discount>0)
					discountamount= (discount/100)*tot;
				else
					discountamount	=0.0;
				var salestax = parseFloat(document.getElementById("salestax").value);
				var salestaxamount = parseFloat((salestax/100)*tot);
				document.getElementById("salestaxamount").value = salestaxamount;
				
				var frieghtcharge = parseFloat(document.getElementById("frieghtcharge").value);
		        var grandtotal = (tot+salestaxamount+frieghtcharge);
		
				document.getElementById("nettotal").value=(grandtotal-discountamount);
			 
			}
			
			<%
			String scrpttaxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
			String tvalue="";
			for(int x=0; x<scrpttaxid.length;x++)
			{	
				for(int y=0; y<3;y++)
					tvalue = tvalue+scrpttaxid[x][y]+",";
			
				tvalue = tvalue+"~";	
			}
			%>
			var taxvalue1 = "<%=tvalue%>".split("~");
			function assignTotals(taxs)
			{
				var taxid = taxs.value;
				var nettotal=0.0;
				for(i=0; i<taxvalue1.length-1; i++)
 				{
   					var rowvalue = taxvalue1[i].split(",")
   					if(rowvalue[0]=== taxid)
						document.getElementById("salestax").value = rowvalue[2];
				}
				assignGrandTotal();
   			}
			
			
			function valid()
			{
   				try
				{
				
					display();
					var descvalues = document.getElementById('param').value;
					 
					var val = descvalues.split(",");
					var svalue="";
					 
					for(u=0; u<val.length-1;u++)
						svalue =svalue+"item"+val[u]+",desc"+val[u]+",qty"+val[u]+","+"uprice"+val[u]+","+"discount"+val[u]+","+"unitdiscount"+val[u]+","+"stax"+val[u]+","+"total"+val[u]+",";
						
					var s = "ponumber,vendorid,orderdate,requestdate,hold,payment,paymentterm,order,ship,";
							s = s+svalue+"memo,ref,totals,totaldiscount,tax,salestax,nettotal,";
					
					var v = s.split(","); 
					var flag =false;
					
					if(checkNullSelect("vendorid","Select Vendor ","Select")
						&& checkNullSelect("payment","Select Payment ","Select")
						&& checkNullSelect("paymentterm","Select Payment Term","Select")
						&& checkNullSelect("order","Select Order From ","Select")
						&& checkNullSelect("ship","Select Shipping To ","Select")
						&& checkNullSelect("division","Select Division ","Select")
						&& checkNullSelect("verified","Select Verification ","0")
						
						&& checkNull ("memo","Enter Description" )
						&& checkNullSelect("ref","Select Reference ","")
						)
					{	
					
						for( i=0; i<v.length-1; i++)
						{
							var ck = "Data not found ..."+v[i];
							
							if(checkNull(v[i],ck))
								d=1;
							else
								return false;	
						}
					}
					else
					{
						return false
					}	
					
				}
				catch(err)
				{
					alert(err)
					return false;
				}
					
			}
	 </script>
							<div align="left">
							<%
			if ("0".equals(purchaseData[0][18].trim()))
				out.println("<input type='button' class='tMLAscreenHead' onClick='insRow()' value='Add'  tabindex='8' />");
		%>
							</div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description									<span class="boldred">*</span> </div>									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left">
<textarea name="memo" cols="25"	rows="5" class="formText135" id="memo" tabindex="9"><%=purchaseData[0][12].trim()%></textarea>
</div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="left"><input tabindex="11" name="totals"
										value='<%=purchaseData[0][16].trim()%>'
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly
										style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount									<span class="boldred">*</span></div>									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input tabindex="12"
										value="<%=purchaseData[0][14].trim()%>" name="totaldiscount"
										type="text" class="formText135" id="totaldiscount"
										onblur='assignGrandTotal()' style='text-align:right' onKeyPress="return numeric_only(event,'totaldiscount','7') " maxlength="4"  />
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group									<span class="boldred">*</span></div>									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13">
										
										<%
                          	 
							for(int u=0; u<taxids.length; u++)
								out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
							%>
									</select> 
									<script language="javascript">setOptionValue('tax','<%=purchaseData[0][15]%>')</script>
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"> 							  <input name="salestax"
										value="<%=CommonFunctions.QueryExecute("Select DOU_VALUE from inv_m_tax WHERE  INT_TAXID ="+purchaseData[0][15])[0][0] %>"
										type="text" class="formText135" id="salestax"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount"
										value='<%=purchaseData[0][17].trim()%>' type="text"
										class="formText135" id="salestaxamount" readonly
										tabindex="14" style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">Freight Charge</td>
								  <td class="boldEleven" id="nettotal1">
							      <input name="frieghtcharge" type="text"
										class="formText135" id="frieghtcharge"
										style='text-align:right' tabindex="15"  onBlur="assignGrandTotal()" onKeyPress="return numeric_only(event,'frieghtcharge','7') " value="<%=purchaseData[0][26]%>" maxlength="5" /></td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference 									<span class="boldred">*</span>
<input name="filename"
										type="hidden" value="PurchaseOrder" /> <input name="actionS"
										type="hidden" value="INVPurchaseOrderUpdate" /> <input
										name="param" type="hidden" id="param" value='<%=param%>'>
									</div>									</td>
									<td class="boldEleven">
									<div align="left">
									
									<select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
										<jsp:include page="Staffload.jsp" flush="true" />
									</select>
									<script language="javascript">setOptionValue('ref','<%=purchaseData[0][13]%>')</script>
									 </div>									</td>
									<td class="boldEleven">
									<div align="left">Net Total</div>									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal" readonly tabindex="15"
										value='<%=purchaseData[0][18].trim()%>'
										style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56">
											<%
						if ("0".equals(purchaseData[0][19].trim()))
							out.println("<input name='Submit' type='submit' class='buttonbold13' value='Update' />");
						
						%>											</td>
											<td width="56"><input name="Button" type="button"
												class="buttonbold13"  value="Close"   accesskey="c" 
												onClick="redirect('Purchase Order.jsp')" /></td>
										</tr>
									</table>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>

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
<script language="javascript">

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	 

	//Intialise the Variables
	 
 	var row =1;
 	var r =parseFloat("<%=itemData.length%>");
	var v1="";
 	var v2="";
 	var v3="";
 	var v4="";
 	var v5="";
 	var v6="";
 	var v7="";
 	var v8="";
 	var v9="";
 	r=r+1;

function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s0= "itype"+r;
		var s1= "item"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "uprice"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var div ="div"+r;
		
		var vf1 = "onKeyPress=\" return numeric_only(event,'"+s3+"','15') \"";
		var vf2 = "onKeyPress=\" return numeric_priceonly(event,'"+s4+"','15') \"";
		var vf3 = "onKeyPress=\" return numeric_only(event,'"+s5+"','15') \"";
		var vf4 = "onKeyPress=\" return numeric_only(event,'"+s6+"','15') \"";
		var vf5 = "onKeyPress=\" return numeric_only(event,'"+s7+"','15') \"";
		
		var s10 = "stax"+r;
		var s11 = "staxpercentage"+r;
		var s12 = "staxamount"+r;
		
		
		<%
	 		String sa="";
			for(int u=0; u<itemData.length; u++)
				sa = sa +"<option value='"+itemData[u][4]+"'>"+itemData[u][5]+"</option>";
	 	%>
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(1).innerHTML="&nbsp;<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10    onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+"  style='text-align:right'/>";
		x.insertCell(4).innerHTML="<input type='text' size=10    onblur='calculatePrice(this)' title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"   style='text-align:right'   maxlength='12'/>";
		x.insertCell(5).innerHTML="<input type='text' size=10    onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"   style='text-align:right'/>";
		x.insertCell(6).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly'  style='text-align:right'/>";
		
		x.insertCell(7).innerHTML="<select class='formText135' name='"+s10+"' id ='"+s10+"' onBlur=assignTaxValue('"+s10+"') ><%=optiontaxname%></select>";
		x.insertCell(8).innerHTML="<input type='text' size=10 class='formText135'  name='"+s11+"' id ='"+s11+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(9).innerHTML="<input type='text' size=10 class='formText135'  name='"+s12+"' id ='"+s12+"'  readonly='readonly' style='text-align:right'/>";
		
		
		x.insertCell(10).innerHTML="<input type='text' size=10    title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly'  style='text-align:right'/>";
		x.insertCell(11).innerHTML="&nbsp;<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
	}
 
 
 //If any changes in Combobox then the corresponding values are assign to corresponding controls
	function assignValue(itm)
	{
  		var idname = itm.name;
		//var idposition = (idname.substring(4,(idname.length-4)));
  		var idposition = idname.replace("item","");
 		var  itemid = itm.value;
 		for(i=0; i<cvalue1.length-1; i++)
 		{
   			var rowvalue = cvalue1[i].split(",")
   			if(rowvalue[2]=== itemid)
   			{
   				document.getElementById('desc'+idposition).value = rowvalue[4];
   				document.getElementById('uprice'+idposition).value = rowvalue[7];
 				document.getElementById('total'+idposition).value = rowvalue[7];
				totals1.style.visibility="visible";
				totaldiscount1.style.visibility="visible";
				tax1.style.visibility="visible";
				salestax1.style.visibility="visible";
				salestaxamount1.style.visibility="visible";
				nettotal1.style.visibility="visible";
				calculateTotal();
   				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		calculateTotal();
  		assignGrandTotal();
		display()
 	}
	
	
	
 //Delete Row
	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		calculateTotal();
		assignGrandTotal();
	}
	
	//Calculate Nettotal 
	function calculateTotal()
	{
		var tvs =0.0;
		display();
   		var svalue="";
   		for(u=0; u<checkArray.length-1;u++)
   			tvs= tvs+parseFloat(document.getElementById('total'+checkArray[u]).value);
		document.getElementById("totals").value=tvs;
		
	}
	
	
	function assignGrandTotal()
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
		var frieghtcharge = parseFloat(document.getElementById("frieghtcharge").value);
		
		var grandtotal = (tot+salestaxamount+frieghtcharge);
		document.getElementById("nettotal").value=(grandtotal).toFixed(2);	
		
	}

function display()
	{
		var hs="";
		var hs1="";
		var hs2="";
		for(u=0; u<itemArray.length; u++)
			hs = hs+itemArray[u]+",";
		for(u=0; u<deleteArray.length; u++)
			hs1 = hs1+deleteArray[u]+",";
		var Array1 = hs.split(",");
		var Array2 = hs1.split(",");
		for(u=0; u<Array2.length; u++)
		{
			var a1value = Array2[u];
			for(v=0; v<Array1.length; v++)
			{
				if(Array2[u] == Array1[v])
					Array1[v]="";
			}
		}
		hs2="";
		for(v=0; v<Array1.length; v++)
			if(Array1[v]!="")
				hs2 = hs2 +	Array1[v]+",";
		hs2 = hs2+"<%=args%>";
		
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		 
			//alert("Added :: \n"+hs+"\n\n\n Deleted :: \n"+hs1+"\n\nChecked \n"+hs2);
	}
	
	//Calculate Nettotal in Discount Changes
	function calculateDiscount(desc)
	{
 		var descposition = (desc.name.replace("discount",""));
  		var discount = desc.value;
  		var quantity = document.getElementById('qty'+descposition).value;
  		var price = document.getElementById('uprice'+descposition).value;
  		var udiscount =(discount/100)*price;
  		document.getElementById('unitdiscount'+descposition).value = udiscount;
  		udiscount = document.getElementById('unitdiscount'+descposition).value;
  		var total = ((quantity * price) - (udiscount*quantity));
  		document.getElementById('total'+descposition).value = total;
  		calculateTotal();
  		assignGrandTotal();
	}


//Calculate Nettotal in Price Changes
	function calculatePrice(pre)
	{
  		var priceposition = (pre.name.replace("uprice",""));
  		var price = pre.value;
  		var quantity = document.getElementById('qty'+priceposition).value;
  		var discount =document.getElementById('discount'+priceposition).value;
  		document.getElementById('unitdiscount'+priceposition).value = (discount/100)*price;
  		var udiscount =(discount/100)*price;
  		var total = ((quantity * price) - (udiscount*quantity));
  		document.getElementById('total'+priceposition).value =total;
  		calculateTotal();
  		assignGrandTotal();
	}
	
	
		//Calculate Nettotal in Quantity Changes
	 function calculateValue(qty)
	{
  		var qtyposition = (qty.name.replace("qty",""));	
  		var quantity = qty.value;
		if(quantity>=1)
		{
			var uprice = document.getElementById('uprice'+qtyposition).value;
			var discount =document.getElementById('discount'+qtyposition).value;
			var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
			var staxpercentage = parseFloat(document.getElementById("staxpercentage"+qtyposition).value);
			udiscount =(discount/100)*uprice;
			document.getElementById("unitdiscount"+qtyposition).value = udiscount;
			uprice = uprice - udiscount;
			document.getElementById("staxamount"+qtyposition).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
			var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
			var total =  Round((quantity*uprice) +taxamount);
			document.getElementById('total'+qtyposition).value = total;
			calculateTotal();
			assignGrandTotal();
			
			 
		}
		else
		{
			alert("Quantity Should not be Zero...");
			qty.focus();
		}
	}





function assignTaxValue(ctr)
	{
		var taxid = document.getElementById(ctr).value;
		if(taxid == "")
		{
			alert("Please Select Tax");
			document.getElementById(ctr).focus();
		}
		else
		{	
		 
			var idposition = ctr.replace("stax","");
			var qty = parseFloat(document.getElementById("qty"+idposition).value);
			var uprice = parseFloat(document.getElementById("uprice"+idposition).value);
			var discount =parseFloat(document.getElementById("discount"+idposition).value);
			var udiscount = parseFloat(document.getElementById("unitdiscount"+idposition).value);
			var total = parseFloat(document.getElementById("total"+idposition).value);
			uprice = uprice - udiscount;
			
			for(i=0; i<taxvalue1.length-1; i++)
			{
				var rowvalue = taxvalue1[i].split(",")
				if(rowvalue[0]=== taxid)
				{
					document.getElementById("staxpercentage"+idposition).value = rowvalue[2];
					document.getElementById("staxamount"+idposition).value = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					
					var taxamount = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					var total =  Round((qty*uprice) +taxamount);
					document.getElementById("total"+idposition).value = Round( total );
				}	
			}
			calculateTotal();
			assignGrandTotal();
		}
	}
	
				
				
</script>


<script type="text/javascript">
var divi="";
function Loaditemproduct(ctr,div) 
{
	var url = "../inventory?actionS=INVItemProduct&id="+escape(ctr.value) ;
	divi = div;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
}

function itemproductRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductMessages();
        }
    }
}

function itemproductMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("items")[0];   
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Idname= batch.getElementsByTagName("Idname")[0];
 			str = str+"<option value='"+Id.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";
       }
       str=str+"</select>";
	   var tb=document.getElementById(divi);
  	   tb.innerHTML=str  ; 
 }

 
function assignValues(ctr,pos) 
{
	
	var type = document.getElementById("itype"+pos).value;
	var typeid = ctr.value;
	var url = "../inventory?actionS=INVItemProductAssign&type="+escape(type)+"&typeid="+typeid ;
	initRequest(url);
	req.onreadystatechange = itemproductpriceRequest;
    req.open("GET", url, true);
    req.send(null);

}

function itemproductpriceRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductpriceMessages();
        }
    }
}

function itemproductpriceMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Assigns")[0];   
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	Desc= batch.getElementsByTagName("Desc")[0];
	    	Price= batch.getElementsByTagName("Price")[0];
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).value = "";
			document.getElementById("uprice"+idposition).value = Price.childNodes[0].nodeValue;
			document.getElementById("discount"+idposition).value ="0";
			document.getElementById("unitdiscount"+idposition).value = "0";
			totals1.style.visibility="visible";
			totaldiscount1.style.visibility="visible";
			tax1.style.visibility="visible";
			salestax1.style.visibility="visible";
			salestaxamount1.style.visibility="visible";
			nettotal1.style.visibility="visible";
			calculateTotal();
   }
   calculateTotal();
   assignGrandTotal();
    
 }
</script>
<%
		  	}
			else
			{
				response.sendRedirect("Purchase Order.jsp");
				out.print("<center><font color='red'> Record not found</font></center>");
			}
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
		
		
		  %>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
 }
 catch(Exception e)
 {
 System.out.println(e.getMessage());
 }
%>
