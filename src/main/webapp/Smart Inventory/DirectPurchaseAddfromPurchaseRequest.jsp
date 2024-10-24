<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
try
{

 
							
String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
String optiontaxname="";
for(int u=0; u<taxids.length; u++)
optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";


%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
 

$(function() {
		$( "#saleDate" ).datepicker({ minDate: -2, maxDate: "+2D" });
	});
 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body    onLoad="document.frm.purchaserequest.focus();">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
 

<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="95%"
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
					<table width="100%" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Direct Purchase Add 
<%
String Requestno= request.getParameter("Requestno");
String rowid= request.getParameter("rowid");
String vendorid= request.getParameter("vendorid");

String sql = "";
sql = "";
sql = "SELECT  a.INT_DIVIID,DATE_FORMAT(a.DAT_PURCHASEDATE,'%d-%m-%Y'),a.INT_PAYMENTTERMID,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ,   a.CHR_REF FROM  inv_t_purchaserequest a WHERE a.CHR_POREQUESTNO='"+Requestno+"' ";
String Data[][] =  CommonFunctions.QueryExecute(sql);
%>
 						
							</strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">

								<tr>
									<td width="128" class="boldEleven">
								  <div align="left">Vendor Invoice No.<span class="boldred"> *</span></div>									</td>
									<td width="244" class="boldEleven">
<input name="cashSaleNo" type="text" class="formText135" id="cashSaleNo"   onBlur="upperMe(this)"    tabindex="0" 												onKeyPress="" size="30" maxlength="50" /></td>
									<td width="169" class="boldEleven">Purchase Date<span class="boldred"> *</span></td>
								  <td width="353" class="boldEleven">
 
<input tabindex="2"		name="saleDate" type="text" class="formText135" id="saleDate" size="15" readonly="readonly" /> 
<script language='JavaScript'	type="text/javascript">setCurrentDate('saleDate'); </script>
 
		 
</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor<span class="boldred"> *</span></div>									</td>
									<td class="boldEleven">
									
									
<select name="vendorid" class="formText135" id="vendorid" tabindex="1" style="width:200" readonly='true'>
<option value='Select'>Select</option>
<%
	String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation ");
	for(int u=0; u<vendorids.length; u++)
		out.print("<option value='"+vendorids[u][0]+"'>"+vendorids[u][1]+" / "+vendorids[u][0] +"</option>");
%>
</select>
<script language="javascript">setOptionValue('vendorid','<%=vendorid%>')</script>
									
									</td>
									<td class="boldEleven">Payment Terms<span class="boldred"> *</span></td>
									<td class="boldEleven">
<%=CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID = "+Data[0][2])[0][1]%>
<input name="payment" type="hidden" value="<%=Data[0][2]%>">

									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Division <span class="boldred">*</span></td>
									<td class="boldEleven">
<%=CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID ="+Data[0][0])[0][1]%>
<input name="division" type="hidden" value="<%=Data[0][0]%>">

									
									</td>
									<td class="boldEleven">Purchase Requet <span class="boldred">*</span></td>
								  <td class="boldEleven"><%=Requestno%>
								 
								  <input  id="purchaserequest" name="purchaserequest" type="hidden" value="<%=Requestno%>">
								  <input name="proposedpurchasedate" type="hidden" id="proposedpurchasedate" value="">
								  
									<script language="javascript">setCurrentDate('proposedpurchasedate'); </script>									
									<br>
									If Partially Received then click<input name="partialreceived" type="checkbox" id="partialreceived" value="Y" checked> </td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
							  </tr>
								
							  
								<tr>
								  <td colspan="4" valign="top" class="boldEleven"><div id="datecheck"></div></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
						  <td height="9">
							<div id="divscroll" style="OVERFLOW:auto;width:auto;height:200px">
							 
							
			
<%

sql = " SELECT a.CHR_POREQUESTNO,a.CHR_TYPE,a.CHR_ITEMID,  ";
sql = sql+ " if(a.CHR_TYPE ='I','Item','Product'),  ";
sql = sql+ " if(  ";
sql = sql+ " a.CHR_TYPE ='I' ,  ";
sql = sql+ " (SELECT b.CHR_ITEMNAME FROM inv_m_item b where b.CHR_ITEMID = a.CHR_ITEMID),  ";
sql = sql+ " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c where c.CHR_PRODUCTID = a.CHR_ITEMID)   ";
sql = sql+ " ),  ";
sql = sql+ " a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE, a.DOU_DISCOUNT,  ";
sql = sql+ " a.DOU_UNITDISCOUNT,b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT,a.DOU_PURCHASEPRICE,a.INT_TAXID ,   ";
sql = sql+ " (a.INT_QUANTITY-a.INT_RECEIVEDQUANTITY) FROM inv_t_purchaserequestitem a,inv_m_tax b  ";
sql = sql+ " WHERE a.INT_TAXID =b.INT_TAXID AND a.CHR_POREQUESTNO='"+Requestno+"'  AND INT_ROWID="+rowid;
//out.println(sql);
String itemDatas[][] =  CommonFunctions.QueryExecute(sql);
double sum=0;
String param="";
if(itemDatas.length>0)
{
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Type</b></td>");
	out.println("<td class='boldEleven'><b>Item</b></td>");
	out.println("<td class='boldEleven'><b>Description</b></td>");
	out.println("<td class='boldEleven'><b>Quantity/Unit</b></td>");
	out.println("<td class='boldEleven'><b>Unit Price</b></td>");
	out.println("<td class='boldEleven'><b>Discount(%)</b></td>");
	out.println("<td class='boldEleven'><b>Unit Discount</b></td>");
	out.println("<td class='boldEleven'><b>Tax</b></td>");
	out.println("<td class='boldEleven'><b>Tax (%)</b></td>");
	out.println("<td class='boldEleven'><b>Tax Amount </b></td>");
	out.println("<td class='boldEleven'><b>Total</b></td>");
	 
	out.println("</tr>");
	
	for(int u=0; u<itemDatas.length;u++ )
	{
		param= param+(u+1)+",";
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
			
		out.println("<td class='boldEleven'>"+(u+1)+"</td>");
		out.println("<td class='boldEleven'>"+itemDatas[u][3]+"</td>");
		out.println("<td class='boldEleven'>"+itemDatas[u][4]+"</td>");
		out.println("<td class='boldEleven'>"+itemDatas[u][5]+"</td>");
		out.println("<td class='boldEleven' align='right'><input type='text' size='5' name='qty"+(u+1)+"'  id='qty"+(u+1)+"' value='"+itemDatas[u][6]+"' class='formText135'  onBlur=\"calculate('qty"+(u+1)+"') \" onKeyPress=\"return numeric_only(event,'qty"+(u+1)+"','7')\" ></td>");
		out.println("<td class='boldEleven' align='right'>"+itemDatas[u][7]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+itemDatas[u][8]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+itemDatas[u][9]+"</td>");
		out.println("<td class='boldEleven'>"+itemDatas[u][10]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+itemDatas[u][11]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+itemDatas[u][12]+"</td>");
		out.println("<td class='boldEleven' align='right'><input type='text' readonly = 'readonly' name='total"+(u+1)+"'  id='total"+(u+1)+"' value='"+itemDatas[u][13]+"' size='15'  class='formText135'>");
		
		
		
		sum = sum+Double.parseDouble(itemDatas[u][13]);
		if("I".equals(itemDatas[u][1]))
			out.println("<input type='hidden' name='itype"+(u+1)+"'  id='itype"+(u+1)+"' value='1'>");
		else	
			out.println("<input type='hidden' name='itype"+(u+1)+"'  id='itype"+(u+1)+"' value='2'>");
		 
		out.println("<input type='hidden' name='item"+(u+1)+"'  id='item"+(u+1)+"' value='"+itemDatas[u][2]+"'>");
		out.println("<input type='hidden' name='desc"+(u+1)+"'  id='desc"+(u+1)+"' value='"+itemDatas[u][5]+"'>");
		out.println("");
		out.println("<input type='hidden' name='uprice"+(u+1)+"'  id='uprice"+(u+1)+"' value='"+itemDatas[u][7]+"'>");
		out.println("<input type='hidden' name='discount"+(u+1)+"'  id='discount"+(u+1)+"' value='"+itemDatas[u][8]+"'>");
		out.println("<input type='hidden' name='unitdiscount"+(u+1)+"'  id='unitdiscount"+(u+1)+"' value='"+itemDatas[u][9]+"'>");
		out.println("<input type='hidden' name='stax"+(u+1)+"'  id='stax"+(u+1)+"' value='"+itemDatas[u][14]+"'>");
		out.println("<input type='hidden' name='staxpercentage"+(u+1)+"' id='staxpercentage"+(u+1)+"' value='"+itemDatas[u][11]+"'>");
		out.println("<input type='hidden' name='staxamount"+(u+1)+"'  id='staxamount"+(u+1)+"' value='"+itemDatas[u][12]+"'>");
		out.println("<input type='hidden' name='balance"+(u+1)+"'  id='balance"+(u+1)+"' value='"+itemDatas[u][15]+"'>");
		
		out.println("");
		
		
		out.println("");
		out.println("");
		out.println("");
		out.println("");
		out.println("");
		out.println("</td>");
		out.println("</tr>"); 
		
	}
	out.println("</table>");
	out.println("</center>");
 }
 
  
										
%>

							</div>
							</td>
						</tr>
						 
						 
							  
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description <span class="boldred">*</span></div>									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9"></textarea>
									</div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input name="totals" type="text"
										class="formText135" id="totals"
										style='text-align:right' tabindex="11"
										  value="<%=sum%>" readonly="readonly" />
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input tabindex="12"
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount" value="0" onBlur="assignGrandTotal()"
										style='text-align:right'
										onKeyPress="doubleValue('totaldiscount',9)"></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group<span class="boldred"> *</span></div>									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13" style="width:200">
										 <option value="">Select Tax</option>
										<%=optiontaxname%>
									</select></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><input name="salestax" value="0"
										type="text" class="formText135" id="salestax"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference<span class="boldred"> *</span> 
									  <input name="filename"
										type="hidden" value="DirectPurchase" /> <input name="actionS"
										type="hidden" value="INVDirectPurchaseRequestAdd" /> 
									 
								      <input
										name="param" type="hidden" id="param" value="<%=param%>">
									  </div>									</td>
									<td class="boldEleven"><%=Data[0][3] %>
									<input name="ref" type="hidden" value="<%=Data[0][4] %>">									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount" value="0"
										type="text" class="formText135" id="salestaxamount"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">Frieght Charge <span class="boldred"> *</span></td>
								  <td class="boldEleven" id="nettotal1"><input name="frieghtcharge" type="text"
										class="formText135" id="frieghtcharge" tabindex="15"  value="0"
										style='text-align:right' onKeyPress="return numeric_only(event,'frieghtcharge','7') " /></td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left">Net Total</div>									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal"
										style='text-align:right' tabindex="15" value="<%=sum%>" />
									</div>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center">
									
<%
if(itemDatas.length>0)
 out.println("<input name='Submit' type='submit' class='tMLAscreenHead' value='Add' onClick='return valid()' />");
%>
								
										
										
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('Direct Purchase.jsp')" /></div>
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>									</td>
								</tr>
							</table>
							</td>
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
		<td>
		
		 
		</td>
	</tr>
</table>



<script language="javascript">




<%
	String taxid[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
	String lvalue="";
	for(int x=0; x<taxid.length;x++)
	{
		for(int y=0; y<3;y++)
		{
			lvalue = lvalue+taxid[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	%>

	var taxvalue = "<%=lvalue%>";
	var taxvalue1 =taxvalue.split("~");

	function assignTotals(taxs)
	{
		
		var taxid = taxs.value;
		var nettotal=0.0;
		for(i=0; i<taxvalue1.length-1; i++)
 		{
   			var rowvalue = taxvalue1[i].split(",")
   			if(rowvalue[0]=== taxid)
			{
				document.getElementById("salestax").value = rowvalue[2];
				assignGrandTotal(taxs);
			}	
   		}
   		
	}
	
	function calculate(ctr)
	{
		try
		{
			var idposition = ctr.replace("qty","");
			var balance = parseInt(document.getElementById("balance"+idposition).value);
			var qty = parseFloat(document.getElementById("qty"+idposition).value);
			if(qty> balance)
			{
				alert("Kindly check the inward Quantity....");
			}
			else
			{
				var uprice = parseFloat(document.getElementById("uprice"+idposition).value);
				var discount =parseFloat(document.getElementById("discount"+idposition).value);
				var udiscount = parseFloat(document.getElementById("unitdiscount"+idposition).value);
				var total =   qty*uprice;
				document.getElementById("total"+idposition).value =total; 
				document.getElementById("totals").value =total;
				assignGrandTotal(); 
			}
			
		
		}
		catch(err)
		{
			alert(err);
		}
	}
	
	
	function assignGrandTotal()
	{
		 
		var tot = parseFloat(document.getElementById("totals").value);
		var discount = parseFloat(document.getElementById("totaldiscount").value);
		var discountamount=0.0;
		if(discount>0)
			discountamount= (discount/100)*tot;
		else
			discountamount	=0.0;
		var salestax = parseFloat(document.getElementById("salestax").value);
		var salestaxamount = parseFloat((salestax/100)*tot);
		document.getElementById("salestaxamount").value = Round(salestaxamount);
		
		 
		var frieghtcharge = parseFloat(document.getElementById("frieghtcharge").value);
		
		var grandtotal = Round((tot+salestaxamount+frieghtcharge));
		document.getElementById("nettotal").value=Math.round((grandtotal-discountamount));
			
		document.getElementById("nettotal").value=Math.round((grandtotal-discountamount));
		
	}


	
function valid()
{
	try
	{
		if( 
			
			checkNull("cashSaleNo","Enter Purchase Invoice Number")
			&& checkNull("saleDate","Enter saleDater")
			&&	checkNullSelect("vendorid","Select Vendor ","Select")
			&& 	checkNull("memo","Enter the Desription.....")
			&& 	checkNullSelect("tax","Select tax ","")
			&& 	checkNull("frieghtcharge","Enter the frieghtcharge.....")
			&& 	checkNull("nettotal","Enter the nettotal.....")
			
			)
		{	
			 
			return true;	
		}
		else
		{
			return false;
		}
		
	}
	catch(err)
	{
		alert(err);
	}
}
</script>
</div>
 </form>
 
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
%>
</body>
</html>
