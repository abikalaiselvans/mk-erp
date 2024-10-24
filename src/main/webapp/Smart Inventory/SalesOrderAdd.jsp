<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
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

%>

	 
 



<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	 
$(function() {
		var dates = $( "#podate, #deliverydate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,changeYear: true,
			minDate: -40,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "podate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	 

  

$(function() {
		$( "#demurragedate" ).datepicker({ 
		minDate: -3, 
			defaultDate: "+1w",
			changeMonth: true,changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true  
			 
			
		});
	});
	
	
	$(function() {
		$( "#poreceiveddate" ).datepicker({ 
		minDate: -10, 
			defaultDate: "+1w",
			changeMonth: true,changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true  
			 
			
		});
	});
		
 


</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">






<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<script type="text/javascript">
<!--

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	//totals,tax,salestax,nettotal, these controls are hidden
	function Load()
	{
		totals1.style.visibility="visible";
		totaldiscount1.style.visibility="visible";
		tax1.style.visibility="visible";
		salestax1.style.visibility="visible";
		salestaxamount1.style.visibility="visible";
		nettotal1.style.visibility="visible";
	}
	
	//Loading item into Array using JSP
	 
	//Intialise the Variables
	 
 	var row =1;
 	var r =1;
	var v1="";
 	var v2="";
 	var v3="";
 	var v4="";
 	var v5="";
 	var v6="";
 	var v7="";
 	var v8="";
 	var v9="";
 
 	//Dynamically insert a row in a table
	function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s1= "item"+r;
		var s11= "ditem"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "uprice"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var s8 = "quoQty"+r;
		var s9 = "quprice"+r;
	
		
		var vf1 = "onKeyPress=\" return numeric_only(event,'"+s3+"','15') \"";
		var vf2 = "onKeyPress=\" return numeric_only(event,'"+s4+"','15') \"";
		var vf3 = "onKeyPress=\" return numeric_only(event,'"+s5+"','15') \"";
		var vf4 = "onKeyPress=\" return numeric_only(event,'"+s6+"','15') \"";
		var vf5 = "onKeyPress=\" return numeric_only(event,'"+s7+"','15') \"";
		
		 
		 

		x.insertCell(0).innerHTML="<input type='hidden' name='"+s1+"' id ='"+s1+"'/><div class='formText135' name='"+s11+"' id ='"+s11+"'> </div>";
		x.insertCell(1).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(2).innerHTML="<input type='text' readonly size=10  value='0'   class='formText135'  name='"+s8+"' id ='"+s8+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10  value='0'  onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+"   />";
		x.insertCell(4).innerHTML="<input type='text' size=10  value='0'  onblur='calculatePrice(this)' title='QuoPrice' class='formText135'  name='"+s9+"' id ='"+s9+"' readonly  />";
		x.insertCell(5).innerHTML="<input type='text' size=10  value='0'  onblur='calculatePrice(this)' title='SalesPri' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  />";
		x.insertCell(6).innerHTML="<input type='text' size=10  value='0'  onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  />";
		x.insertCell(7).innerHTML="<input type='text' size=10  value='0'  title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly'/>";
		x.insertCell(8).innerHTML="<input type='text' size=10  value='0'  title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly'/>";
		x.insertCell(9).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
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
   				document.getElementById('uprice'+idposition).value = rowvalue[9];
 				document.getElementById('total'+idposition).value = rowvalue[9];
				calculateTotal();
   				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		calculateTotal();
  		assignGrandTotal();
 	}

 	function assignValue1(itm1)
	{
		var itm=document.getElementById(itm1);
  		var idname = itm.name;
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
				calculateTotal();
   				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		calculateTotal();
  		assignGrandTotal();
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
		 
			var idposition = ctr.replace("tax","");
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
					document.getElementById("taxpercentage"+idposition).value = rowvalue[2];
					document.getElementById("taxamount"+idposition).value = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					
					var taxamount = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					var total =  Round((qty*uprice) +taxamount);
					document.getElementById("total"+idposition).value = Round( total );
				}	
			}
			
			calculateTotal();
			assignGrandTotal();
		}
	}
	
	
	//Calculate Nettotal 
	function calculateTotal()
	{
		var tvs =0.0;
		var svalue="";
		var p =document.getElementById('params').value;
		for(u=0; u<p;u++)
   			tvs= tvs+parseFloat(document.getElementById('total'+(u+1)).value);
		document.getElementById("totals").value=tvs;
		
		
	}
	
	
	//Calculate Nettotal in Quantity Changes
	function calculateValue(qty)
	{
  		var qtyposition = (qty.name.replace("qty",""));	
  		var quantity = qty.value;
  		var uprice = document.getElementById('uprice'+qtyposition).value;
  		var discount =document.getElementById('discount'+qtyposition).value;
  		var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
  		udiscount =(discount/100)*uprice;
  		var total = ((quantity * uprice) - (udiscount*quantity));
  		document.getElementById('total'+qtyposition).value = total;
  		assignTaxValue("tax"+qtyposition);
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
  		assignTaxValue("tax"+priceposition);
		calculateTotal();
  		assignGrandTotal();
		
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
  		assignTaxValue("tax"+descposition);
		calculateTotal();
  		assignGrandTotal();
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
	//******************************
	function display()
	{
		/*var hs="";
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
		checkArray = hs2.split(",");
		document.getElementById('param').value=hs2;
		//alert("Added :: \n"+hs+"\n\n\n Deleted :: \n"+hs1+"\n\nChecked \n"+hs2);*/
	}
	//**********************************
	function paramAssign(svalue)
	{
		document.getElementById('param').value=svalue;
	}
	
	


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
				//nettotal = (parseFloat(rowvalue[2])/100 )*document.getElementById("totals").value;
				//document.getElementById("nettotal").value = parseFloat(document.getElementById("totals").value)+nettotal;
			}	
   		}   		
	}
	
	/*function assignGrandTotal()
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
		 
		var sstax=document.getElementById("tax").value;
		if(sstax == "" )
			sstax=="0";
		var salestax = parseFloat(sstax);
		var salestaxamount = parseFloat((salestax/100)*tot);
		document.getElementById("taxamount").value = salestaxamount.toFixed(2);
		
		var grandtotal = (tot+salestaxamount);
		document.getElementById("nettotal").value=Round(grandtotal) ;	
		
		
		
		
	}
	*/
	
	 function assignAddress()
	{
		if(document.getElementById('copyaddress').checked)
			document.getElementById('shipingto').value= document.getElementById('billingto').value;
		else
			document.getElementById('shipingto').value="";
	}
	
	
	
	
function disableByBackValue()
{
 	document.getElementById("bybackrow").style.visibility="hidden";
}
 
 
--></script>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<%
	String quotationnumber=request.getParameter("quotationnumber");
	String sql="SELECT INT_QUOTATIONID,CHR_QUOTATIONNO,INT_CUSTOMERID,"+
				" DATE_FORMAT(DAT_QUOTATIONDATE,'%d-%b-%Y')"+
				" ,DATE_FORMAT(DAT_REQUESTDATE,'%d-%b-%Y'),CHR_ONHOLD,INT_CONDITIONID,"+
				" CHR_DES,CHR_REF,INT_TAXID,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
				" DOU_TOTALAMOUNT,CHR_STATUS,CHR_ADDRESSID1,CHR_ADDRESSID2 ,FUN_INV_DIVISION(INT_DIVIID),CHR_CONTACTDETAILS,CHR_CONTACTNO,FIND_A_CUSTOMER_ADDRESS(INT_CUSTOMERID),INT_DIVIID ,CHR_ADDRESSFLAG "+
				" ,DOU_AMOUNT from  inv_t_customerquotation  where CHR_QUOTATIONNO='"+quotationnumber+"'";
 	//out.println(sql);			
	String purchaseInfo[][] =  CommonFunctions.QueryExecute(sql);	
	 
	sql="SELECT CHR_ITEMID,CHR_DESC,INT_QUANTITY,"+
	" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL "+
	" from  inv_t_customerquotationitem  where where CHR_QUOTATIONNO='"+quotationnumber+"'";
	
%>
<body    onLoad="Load(), disableByBackValue() ">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
							<div align="center"><strong>CUSTOMER PURCHASE ORDER </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
								  <td width="192" class="boldEleven"><div align="left">Quotaion Ref No</div></td>
									<td width="226" class="boldEleven"><div align="left"><%=purchaseInfo[0][1] %>
                                             
                                  </div></td>
									<td width="162" align="left" valign="top" class="boldEleven"><div align="left">Order Reference <span class="ui-state-error-text">* </span></div></td>
									<td width="203" align="left" valign="top" class="boldEleven"><input name="oref" type="text"
										class="formText135" id="oref"     onBlur="upperMe(this)"      value="ORAL" size="31" maxlength="100"
										 /></td>
								</tr>
								<tr>
								  <td class="boldEleven">Quotation Date<span class="ui-state-error-text"> </span></td>
								  <td class="boldEleven"><%=purchaseInfo[0][3]%></td>
								  <td width="162" align="left" valign="top" class="boldEleven"><div align="left">Delivery Note <span class="ui-state-error-text">* </span></div></td>
						          <td width="203" align="left" valign="top" class="boldEleven"><div align="left">
                                    <input name="dnote" type="text"
										class="formText135" id="dnote"
										    onBlur="upperMe(this)"     value="NIL" size="31" maxlength="100" />
                                  </div></td>
							  </tr>
								<tr>
								  <td align="left" valign="top" class="boldEleven"><div align="left">Customer <span class="boldEleven">
                                    <input type="hidden" name="customerid" id="customerid"  value="<%=purchaseInfo[0][2] %>">
                                  </span></div></td>
								  <td align="left" valign="top" class="boldEleven"><textarea name="billingto"
										id="billingto" rows="5" cols="25" class="formText135"><%=purchaseInfo[0][14]%></textarea></td>
								  <td align="left" valign="top" class="boldEleven"><div align="left">Shipping To
								    <%
								  sql ="";
								  if("Y".equals(purchaseInfo[0][21]))
								  	sql = " checked ='checked' ";
								  %>
                                    <input
										name="copyaddress" type="checkbox" id="copyaddress"
										value="Y" onClick="assignAddress() " <%=sql%>>
</div></td>
								  <td align="left" valign="top" class="boldEleven"><textarea name="shipingto" cols="28"
										rows="5" class="formText135" id="shipingto"><%=purchaseInfo[0][15]%></textarea></td>
							  </tr>
								<tr>
								  <td class="boldEleven">Request Date<span class="ui-state-error-text"> </span></td>
									<td class="boldEleven"><%=purchaseInfo[0][4]%> </td>
								  <td width="162" align="left" valign="top" class="boldEleven"><div align="left">Despatch Through <span class="ui-state-error-text">* </span></div></td>
						            <td width="203" align="left" valign="top" class="boldEleven"><div align="left">
                                      <input name="dthru" type="text"
										class="formText135" id="dthru"
										    onBlur="upperMe(this)"     value="INTERNAL COURIER" size="31" maxlength="100" />
                                    </div></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><span class="boldEleven">P.O Number </span></td>
								  <td class="boldEleven"><input name="custponumber" type="text"
												class="formText135"
												onKeyUp="upperMe(this),CheckUniqueNO(this,'poValid',' inv_t_customersalesorder  ','CHR_CUSTPURCHASENO')"
												id="custponumber" size="25" value="" maxlength="75">
												<div id="poValid"></div>												</td>
							      <td width="162" align="left" valign="top" class="boldEleven"><div align="left">Destiantion <span class="ui-state-error-text"> * </span></div></td>
						          <td width="203" align="left" valign="top" class="boldEleven"><div align="left">
                                    <input name="destination"
										type="text" class="formText135" id="destination"     onBlur="upperMe(this)"    value="CHENNAI"   size="31"
										maxlength="100" />
                                  </div></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven"><span class="boldEleven">P.O date </span></td>
								  <td class="boldEleven"><input name="podate" type="text"
										class="formText135" id="podate" size="15" readonly />
								  <script language='JavaScript' type="text/javascript"> 
									 setCurrentDate('podate')</script>	</td>
							      <td width="162" align="left" valign="top" class="boldEleven"><div align="left">Terms of Delivery<span class="ui-state-error-text"> * </span></div></td>
						          <td width="203" align="left" valign="top" class="boldEleven"><div align="left">
                                    <input name="tdelivery" type="text"
										class="formText135" id="tdelivery"
										    onBlur="upperMe(this)"     value="IMMEDIATE" size="31" maxlength="100" />
                                  </div></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">P.O. Received Date <span class="ui-state-error-text">* </span></td>
								  <td class="boldEleven"><input name="poreceiveddate" type="text" value=""
										class="formText135" id="poreceiveddate" size="15" readonly />
                                        <script language='JavaScript'
										type="text/javascript">setCurrentDate('poreceiveddate')
		                  </script>		
                                        </td>
							      <td width="162" align="left" valign="top" class="boldEleven">Payment Terms<span class="ui-state-error-text"> </span></td>
						          <td width="203" align="left" valign="top" class="boldEleven"><%
	String paymentids[][] = CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
	String pid="";
			for(int u=0; u<paymentids.length; u++){
				if(paymentids[u][0].equals(purchaseInfo[0][6]))
				{
				 out.print(paymentids[u][1]);
				 pid = paymentids[u][0];
				} 
				
			}	
		%>
                                  <input name="payment" type="hidden" id="payment" value="<%=pid%>"></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Possible Date of Delivery</td>
								  <td class="boldEleven"><input name="deliverydate" type="text"
										class="formText135" id="deliverydate" size="15" readonly />
										<script language='JavaScript'
										type="text/javascript">setCurrentDate('deliverydate')
		                  </script>										</td>
						          <td width="162" align="left" valign="top" class="boldEleven">Contact Person<span class="ui-state-error-text"> * </span></td>
						          <td width="203" align="left" valign="top" class="boldEleven"><input name="cdetails" type="text" value="<%=purchaseInfo[0][17]%>"
										class="formText135" id="cdetails"
										    onBlur="upperMe(this)" size="31" maxlength="50"     /></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven"><div align="left" class="boldEleven">On Hold</div></td>
								  <td class="boldEleven"><%
                        	if(purchaseInfo[0][1].equals("1"))
                        		out.println("<input name='hold' type='checkbox' checked='checked' id='hold' value='Y'  />");
                        	else
                        		out.println("<input name='hold' type='checkbox' id='hold' value='checkbox'  />");
                        %></td>
						          <td width="162" align="left" valign="top" class="boldEleven">Contact No.<span class="ui-state-error-text"> * </span></td>
					              <td width="203" align="left" valign="top" class="boldEleven"><input name="cnumber" type="text" value="<%=purchaseInfo[0][18]%>"
										class="formText135" id="cnumber"
										    onBlur="upperMe(this)"     onKeyPress="return numeric_only(event,'cnumber','15') " size="31" maxlength="12"/></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven"><div align="left" class="boldEleven">Payment Commitment Days <span class="ui-state-error-text">* </span></div></td>
								  <td class="boldEleven"><select name="commitmentdays" class="formText135" id="commitmentdays" style="width:100">
                                    <option value="">Select Payment commitment Days</option>
                                    <option value="0">Advance Amount</option>
                                    <%
								  for(int u=1;u<=50;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                                  </select></td>
							      <td width="162" align="left" valign="top" class="boldEleven">Division</td>
						          <td width="203" align="left" valign="top" class="boldEleven"><%=purchaseInfo[0][16]%>
					              <input name="division" type="hidden" id="division" value="<%=purchaseInfo[0][20]%>"></td>
							  </tr>
								 
								 
								<tr>
								  <td height="22" align="left" valign="top" class="boldEleven">Installation / Implementation  <span class="ui-state-error-text">* </span></td>
								  <td align="left" valign="top" class="boldEleven"><select name="installation" class="formText135" id="installation" style="width:100">
                                     
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
								  <td class="boldEleven">Tax Type  <span class="ui-state-error-text">* </span></td>
								  <td class="boldEleven"><select name="taxtype" class="formText135" id="taxtype" style="width:170" >
                                      <option value="S">Single Tax</option>
                                      <option value="M" selected="selected">Multi Tax</option>
                                    </select>
                                      <!--onChange="taxTypeSelect()" readonly ="readonly"-->                                  </td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Billed in Multiple Location  <span class="ui-state-error-text">* </span></td>
								  <td valign="top" class="boldEleven"><select name="multipleloaction" class="formText135" id="multipleloaction" style="width:100">
                                    
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
								  <td valign="top" class="boldEleven">Project <span class="boldred">*</span></td>
								  <td valign="top" class="boldEleven"><select name="project"
							class="formText135" id="project"   style="width:170"
							 >
                                      <option value='0'>Select</option>
                                      <%
								String project[][] =  CommonFunctions.QueryExecute("SELECT INT_PROJECTID,CHR_PROJECTNAME FROM inv_m_project WHERE CHR_STATUS='Y' ORDER BY CHR_PROJECTNAME "); 
								for(int u=0; u<project.length; u++)
									out.print("<option value='"+project[u][0]+"'>"+project[u][1]  +"</option>");
							%>
                                  </select></td>
							  </tr>
								<tr>
								  <td height="22" align="left" valign="top" class="boldEleven">Multiple Bill <span class="ui-state-error-text">* </span></td>
								  <td align="left" valign="top" class="boldEleven"><select name="multiplebill" class="formText135" id="multiplebill" style="width:100">
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
								  <td align="left" valign="top" class="boldEleven">Bank Guarantee<span class="ui-state-error-text"> * </span></td>
								  <td align="left" valign="top" class="boldEleven"><select name="bankguarantee" class="formText135" id="bankguarantee" style="width:100">
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
							  </tr>
								<tr>
								  <td height="22" align="left" valign="top" class="boldEleven">Partial Bill <span class="ui-state-error-text">* </span></td>
								  <td align="left" valign="top" class="boldEleven"><select name="partialbill" class="formText135" id="partialbill" style="width:100">
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
								  <td align="left" valign="top" class="boldEleven">Delivery <span class="ui-state-error-text">* </span></td>
								  <td align="left" valign="top" class="boldEleven"><select name="delivery" class="formText135" id="delivery" style="width:100">
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
							  </tr>
								<tr>
								  <td height="22" align="left" valign="top" class="boldEleven"><span class="boldEleven">Block Invoice</span></td>
								  <td align="left" valign="top" class="boldEleven"><input name="blockinvoice" type="checkbox" id="blockinvoice" value="Y" >
                                    <span class="boldred">(  In billing, stocks not checked ) </span></td>
								  <td align="left" valign="top" class="boldEleven">Stock Type</td>
								  <td align="left" valign="top" class="boldEleven"><select name="stocktype" class="formText135" id="stocktype" style="width:100">
                                    <option value="G"  selected="selected">General</option>
                                    <option value="B">B2B</option>
                                  </select></td>
							  </tr>
								<tr>
								  <td height="22" align="left" valign="top" class="boldEleven">Liquidated Damage </td>
								  <td align="left" valign="top" class="boldEleven"><select name="demurrage" class="formText135" id="demurrage" style="width:100" onChange="checkDemurrage()">
                                    <option value="Y">Yes</option>
                                    <option value="N" selected="selected">No</option>
                                  </select></td>
								  <td id="demurrage1" align="left" valign="top" class="boldEleven">Damage % </td>
								  <td  id="demurrage2" align="left" valign="top" class="boldEleven">
							  <select name="demurragepercentage" class="formText135" id="demurragepercentage" style="width:100" >
                                
                                <%
								for(int u=1;u<100;u++)
									out.println("<option value='"+u+"'>"+(u)+" - %</option>");
								%>
                                  </select></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">CPO Status <span class="boldElevenlink">*</span></td>
								  <td ><select name="cpostatus" id="cpostatus"  class="formText135">
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
								    </select></td>
								  <td  id="demurrage3" align="left" valign="top" class="boldEleven">Damage Days </td>
								  <td  id="demurrage4" align="left" valign="top" class="boldEleven">
								   		<select name="demurragedays" class="formText135" id="demurragedays" style="width:100">
                                    
                                    <%
								  for(int u=0;u<=30;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                                  </select>
								  
								 
								<script language="javascript">
								function checkDemurrage()
								{
									try
									{
										var demurrage= document.getElementById('demurrage').value;
										if(demurrage == "Y")
										{
											demurrage1.style.visibility="visible";
											demurrage2.style.visibility="visible";
											demurrage3.style.visibility="visible";
											demurrage4.style.visibility="visible";
										}
										else
										{
											demurrage1.style.visibility="hidden";
											demurrage2.style.visibility="hidden";
											demurrage3.style.visibility="hidden";
											demurrage4.style.visibility="hidden";
										}
									}
									catch(err)
									{
										alert(err);
									}
								}
								
								checkDemurrage();
								 
								</script>	
								  </td>
							  </tr>
							</table>
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
				
				sql = sql +"  a.INT_QUANTITY, a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT, ";
				sql = sql +"  a.INT_TAXID,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT, ";
				sql = sql +"  a.DOU_TOTAL,  ";
				sql = sql +"  if( a.CHR_TYPE ='I' , 'F' , ";
				sql = sql +"  (SELECT sa3.CHR_PTYPE  FROM inv_m_produtlist sa3 WHERE sa3.CHR_PRODUCTID =a.CHR_ITEMID)  ";
				sql = sql +"  ) ptype";
				sql = sql +"  ,  a.INT_WARRANTY ";
				sql = sql +"  from inv_t_customerquotationitem a  where CHR_QUOTATIONNO='"+quotationnumber+"'";
				//out.println(sql);
				String itemDatas[][]=  CommonFunctions.QueryExecute(sql);
				out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.print("<tr  class='MRow1'>");
				out.print("<th  class='boldEleven'><b>S.No</b></th>");
				out.print("<th  class='boldEleven'><b>Type</b></th>");
				out.print("<th  class='boldEleven'><b>Item / Product</b></th>");
          		out.print("<th  class='boldEleven'><b>Description</b></th>");
                out.print("<th  class='boldEleven'><b>Quantity</b></th>");
				out.print("<th  class='boldEleven'><b>Warranty</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Price</b></th>");
                out.print("<th  class='boldEleven'><b>Discount(%)</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Discount</b></th>");
				out.print("<th  class='boldEleven'><b>Tax</b></th>");
				out.print("<th  class='boldEleven'><b>Tax Value</b></th>");
				out.print("<th  class='boldEleven'><b>Tax Amount</b></th>");
                out.print("<th  class='boldEleven'><b>Total</b></th>");
				String i0,i1,i2,i3,i4,i5,i6,i7, i8,i9,i10,i11,i12,vf1,vf2,vf3,vf4,vf5;
				i0="";
                i1 ="qty";
                i2 ="uprice";
                i3 ="discount";
                i4 ="unitdiscount";
                i5 ="total";
                i6="item";
				i7="desc";
				i8="tax";
				i9="taxpercentage";
				i10="taxamount";
				i11 ="pptype";
				i12 ="warranty";
                String args="";
				String iname="";
				String itemname="";
				String param ="";
				for(int u=0; u<itemDatas.length;u++)
				{
					args= args+(u+1)+",";
					param = param+(u+1)+",";
					i0="itype"+(u+1);
					i1 ="qty"+(u+1);
	                i2 ="uprice"+(u+1);
	                i3 ="discount"+(u+1);
	                i4 ="unitdiscount"+(u+1);
	                i5 ="total"+(u+1);
					i6 ="item"+(u+1);
					i7 ="desc"+(u+1);
					i8="tax"+(u+1);
					i9="taxpercentage"+(u+1);
					i10="taxamount"+(u+1);
					i11 ="pptype"+(u+1);
					i12 ="warranty"+(u+1);
					
					vf1 = "onKeyPress=\" return numeric_only(event,'"+i1+"','5')\"";
	        		vf2 = "onKeyPress=\" return numeric_only(event,'"+i2+"','13')\"";
	        		vf3 = "onKeyPress=\" return numeric_only(event,'"+i3+"','5')\"";
	        		vf4 = "onKeyPress=\" return numeric_only(event,'"+i4+"','3')\"";
	        		vf5 = "onKeyPress=\" return numeric_only(event,'"+i5+"','10')\"";
	        		
				  
					if(u%2==1)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr  class='MRow2'>");	 
						
					out.println(" <td   class='boldEleven' >"+(u+1)+".</td>");
					out.println(" <td   class='boldEleven' >"+itemDatas[u][3]+"</td>");
					out.println("<td  class='boldEleven' >"+itemDatas[u][4] );
					out.print("<input value='"+itemDatas[u][0]+"' type='hidden' name='"+i0+"'  id='"+i0+"' />");
					out.print("<input value='"+itemDatas[u][1]+"' type='hidden' name='"+i6+"'  id='"+i6+"' />");
					out.print("<input value='"+itemDatas[u][14]+"' type='hidden' name='"+i11+"'  id='"+i11+"' />");
					
					out.print("</td>");
					
					out.print("<td class='boldEleven'>&nbsp;<input value='"+itemDatas[u][5]+"' type='hidden' name='"+i7+"'  id='"+i7+"' />"+itemDatas[u][5]+"</td>");
					
                	//Qty
					out.print("<td class='boldEleven'><input class='formText135' type='text' size ='10' name='"+i1+"' id='"+i1+"' value ='"+itemDatas[u][6]+"' "+vf1+" onblur='calculateValues(this)'  style='text-align:right'></td>");
                	
					//Warranty
					out.print("<td class='boldEleven'><select class='formText135'   style='width:100'  name='"+i12+"' id ='"+i12+"'   >"+warrantyinsert+" </select></td>");
					%>
					<script language="javascript">setOptionValue('<%=i12%>','<%=itemDatas[u][15]%>')</script>
					<%
					
					//unit price
					out.print("<td class='boldEleven'><input class='formText135' type=text size =10 name='"+i2+"' id='"+i2+"' value ='"+itemDatas[u][7]+"' "+vf2+"   style='text-align:right' maxlength='8' onBlur=\"document,getElementById('"+i1+"').focus()\" ></td>");
                	//discount
					out.print("<td class='boldEleven'  ><input class='formText135' type=text size =10 name='"+i3+"' id='"+i3+"' value ='"+itemDatas[u][8]+"' "+vf3+" readonly='readonly' style='text-align:right'></td>");
					
					//Unit discount
                	out.print("<td class='boldEleven'  ><input class='formText135' type=text size =10 name='"+i4+"' id='"+i4+"' value ='"+itemDatas[u][9]+"' "+vf4+" readonly='readonly' style='text-align:right'></td>");
                	
					//Tax
                	out.print("<td class='boldEleven'  ><select class='formText135'   style='width:100'  name='"+i8+"' id ='"+i8+"' onBlur=assignTaxValue('"+i8+"') >"+optiontaxname+"</select></td>");
					%>
					<script language="javascript">setOptionValue('<%=i8%>','<%=itemDatas[u][10]%>')</script>
					<%
                	
					//Tax Percentage
                	out.print("<td class='boldEleven'  ><input class='formText135' type=text size =10 name='"+i9+"' id='"+i9+"' value ='"+itemDatas[u][11]+"'  readonly='readonly' style='text-align:right'></td>");
                	
					//Tax Amount
                	out.print("<td class='boldEleven'  ><input class='formText135' type=text size =10 name='"+i10+"' id='"+i10+"' value ='"+itemDatas[u][12]+"'   readonly='readonly' style='text-align:right'></td>");
                	
					
					//Total
					out.print("<td class='boldEleven'  style='text-align:right'><input class='formText135'type=text size =10 name='"+i5+"' id='"+i5+"' value ='"+itemDatas[u][13]+"' "+vf5+" readonly='readonly'  style='text-align:right'></td>");
				
				}
				out.print("</table> ");
					
					
				   %>
							 </td>
						</tr>
						 
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="118" rowspan="4" valign="top" class="boldEleven">
								  <div align="left" class="boldEleven">Description</div>								  </td>
									<td width="389" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="descriptions" cols="34"
										rows="5" class="formText135" id="descriptions"><%=purchaseInfo[0][7] %></textarea>
									</div>								  </td>
									<td width="151" valign="top" class="boldEleven">
								  <div align="left">Total</div>								  </td>
									<td width="125"   valign="top" class="boldEleven" id="totals1">
									  <div align="right">
									    <input name="totals"
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly
										value="<%=purchaseInfo[0][22] %>"  style="text-align:right"/>
							      </div></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
								  <div align="left">Total Discount</div>									</td>
									<td valign="top" class="boldEleven"
										id="totaldiscount1">
									  <div align="right">
									    <input name="totaldiscount" type="text"
										class="formText135" id="totaldiscount"
										onblur="assignGrandTotal()" onKeyPress="priceOnly(this)"
										value="<%=purchaseInfo[0][10]%>" maxlength="5"
										readonly="readonly"  style="text-align:right"/>
							      </div></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
								  <div align="left">Tax Group</div>									</td>
									<td valign="top" class="boldEleven" id="tax1">
									  <div align="right">
									    <select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" style="width:115">
									      <option value="Select">Select</option>
										  <%
								String taxdata[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
                              	String taxVal="";
								for(int u=0; u<taxdata.length; u++){
									if(taxdata[u][0].equals(purchaseInfo[0][9])){
										out.print("<option value='"+taxdata[u][0]+"' selected>"+taxdata[u][1]+"</option>");	
										taxVal=taxdata[u][2];
									}
									else
										out.print("<option value='"+taxdata[u][0]+"'>"+taxdata[u][1]+"</option>");							
								}									
							 %> </select>  
							      </div></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
								  <div align="left">Sales Tax (%)</div>									</td>
									<td valign="top" class="boldEleven" id="salestax1">
									  <div align="right">
									    <input name="salestax" type="text"
										class="formText135" id="salestax" readonly
										value="<%=taxVal %>"  style="text-align:right"/>
							      </div></td>
								</tr>
								<tr>
									<td class="boldEleven">By Back Value
                                      <input name="byback" type="checkbox" id="byback" value="Y" onClick="byBack()" />
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
								  
								      </script>									</td>
									<td align="left" valign="top" class="boldEleven">&nbsp;</td>
									<td class="boldEleven">
								  <div align="left">Sales Tax Amount</div>									</td>
									<td class="boldEleven" id="salestaxamount1">
									  <div align="right">
									    <input name="salestaxamount"
										value="<%=purchaseInfo[0][11] %>" type="text"
										class="formText135" id="salestaxamount" readonly  style="text-align:right"/>
							        </div></td>
								</tr>
								 
								<tr  id="bybackrow">
								  <td align="left" valign="top" class="boldEleven">By Back Description </td>
								  <td align="left" valign="top" class="boldEleven"><textarea name="bybackdescription" cols="34"
										rows="5" class="formText135" id="bybackdescription" tabindex="9"></textarea></td>
								  <td align="left" valign="top" class="boldEleven">By Back Amount </td>
								  <td align="left" valign="top" class="boldEleven" id="nettotal1">
								  <div align="right"><input name="bybackamount" type="text" 
										class="formText135" id="bybackamount" style='text-align:right' onBlur="assignGrandTotal()"  onKeyPress="return numeric_only(event,'bybackamount','15')" value="0" size="20" maxlength="12"/></div></td>
							  </tr>
								 
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td align="left" valign="top" class="boldEleven"><input name="filename" type="hidden" value="SalesOrder" />
                                    <input name="actionS"  type="hidden" value="INVSalesOrderAdd" />
                                    <input name="param"  type="hidden" id="leng" value='<%=param%>'>
                                    <input name="quotationid" type="hidden" value="<%=purchaseInfo[0][1] %>" />
                                    <input name="params" type="hidden" id="params" value="<%=itemDatas.length%>"></td>
								  <td class="boldEleven"><div align="left">
                                    <div align="left">Net Total</div>
							      </div></td>
								  <td class="boldEleven" id="nettotal1"><div align="right">
                                    <input name="nettotal" type="text"
										class="formText135" id="nettotal"
										value="<%=purchaseInfo[0][12] %>" readonly  style="text-align:right"/>
                                  </div></td>
							  </tr>
								<tr>
								  <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="3" cellpadding="3">
                                    <tr>
                                      <td width="23%" align="left" valign="top" class="boldEleven">Sale Reference 1 </td>
                                      <td width="50%" align="left" valign="top" class="boldEleven"><select name="ref" id="ref" class="formText135" size="5" style="width:200">
                                          <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select>
									 <script language="javascript">setOptionValue('ref','<%=purchaseInfo[0][8] %>')</script>									 </td>
                                      <td width="13%" align="left" valign="top" class="boldEleven">Percentage</td>
                                      <td width="14%" align="left" valign="top" class="boldEleven"><select name="percentage" id="percentage" class="formText135" style="width:50">
                                          <jsp:include page="Slaereppercentage.jsp" flush="true" />                                  
                                      </select>
                                          <script language="javascript">setOptionValue('percentage','100')</script>                                      </td>
                                    </tr>
                                    <tr>
                                      <td align="left" valign="top" class="boldEleven">Sale Reference 2 </td>
                                      <td align="left" valign="top" class="boldEleven"><select name="ref1" id="ref1" class="formText135" size="5" style="width:200">
                                          <option value="0" selected="selected">No Reference</option>
                                          <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select></td>
                                      <td align="left" valign="top" class="boldEleven">Percentage</td>
                                      <td align="left" valign="top" class="boldEleven"><select name="percentage1" id="percentage1" class="formText135"   style="width:50">
                                          <jsp:include page="Slaereppercentage.jsp" flush="true" />                                  
                                      </select>
                                          <script language="javascript">setOptionValue('percentage1','0')</script></td>
                                    </tr>
                                    <tr>
                                      <td align="left" valign="top" class="boldEleven">Sale Reference 3 </td>
                                      <td align="left" valign="top" class="boldEleven"><select name="ref2" id="ref2" class="formText135" size="5"   style="width:200">
                                          <option value="0" selected="selected">No Reference</option>
                                          <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select></td>
                                      <td align="left" valign="top" class="boldEleven">Percentage</td>
                                      <td align="left" valign="top" class="boldEleven"><select name="percentage2" id="percentage2" class="formText135"   style="width:50">
                                          <jsp:include page="Slaereppercentage.jsp" flush="true" />                                  
                                      </select>
                                          <script language="javascript">setOptionValue('percentage2','0')</script></td>
                                    </tr>
                                  </table></td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="212" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td width="128">
										  <%

		sql ="SELECT count(*) FROM  inv_t_customerquotation  WHERE CHR_QUOTATIONNO='"+quotationnumber+"' AND CHR_STATUS='Y'";
		String msgerr="";
		if(!com.my.org.erp.common.CommonFunction.RecordExist(sql))
		{	
	%> <input name="Submit" id="Submit"  type="submit" class="tMLAscreenHead"
												value="Submit"  /> <%		
		}
		else
			msgerr="Quotation already executed...";
	%>										  </td>
										  <td width="63"><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="javascript:history.back(1)" /></td>
										</tr>
									</table>									</td>
								</tr>
								<tr>
									<td colspan="4" align="center" valign="bottom">
									<table width='600'>
										<tr>
											<td class="errormessage">
											<div align="center"><%=msgerr%></div>											</td>
										</tr>
									</table>									</td>
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
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
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
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>

<script language='JavaScript' type="text/javascript">



	
function Validate()
{
	try
	{
 		
		 checkMultipleBill() ;
		
		if(
 			   
			  checkNull("custponumber","Enter customer po number")
			
			&& checkNull("oref","Enter Other Reference")
			&& checkNull("dnote","Enter Delivery Note")
			&& checkNull("dthru","Enter Despatch Through")
			&& checkNull("destination","Enter Destination")
			&& checkNull("tdelivery","Enter Terms of Delivery")
			&& checkNull("cdetails","Enter Contact Person")
			&& checkNull("cnumber","Enter Contact Number")
			&& checkNullSelect("commitmentdays","Select Payment Commitment days","")
			&& checkNullSelect("project","Select Project","0")
			&& checkNullSelect("taxtype","Select taxt ype","0")
			&& checkNullSelect("installation","Select installation required","0")
			&& checkNullSelect("multipleloaction","Select multipleloaction  ","0")
			&& checkNullSelect('cpostatus','Select CPO Status','0')
			&& checkPercentage()
  		  ) 
		  {
		  	 
		  }
		  else
		  	return false; 
		
		 
		 
		 
		 var v =document.getElementById('params').value;
   		var svalue="";
   		for(u=0; u<v;u++)
   			svalue =svalue+ "qty"+(u+1)+","+"uprice"+(u+1)+","+"discount"+(u+1)+","+"unitdiscount"+(u+1)+","+"tax"+(u+1)+","+"taxpercentage"+(u+1)+","+"taxamount"+(u+1)+","+"total"+(u+1)+",";
			
			
   		var s = "custponumber,podate,deliverydate,cdetails,cnumber,billingto,shipingto,commitmentdays,oref,dnote,dthru,destination,tdelivery,taxtype,project,multipleloaction,installation,";
   		s = s+svalue+"descriptions,ref,totals,totaldiscount,tax,salestax,nettotal,";
		 
   		var v = s.split(",");
   		//for( i=0; i<v.length-1; i++)
		//	alert(v[i]);
		
		
		var flag =false;
		for( i=0; i<v.length-1; i++)
		{
			var chk =document.getElementById(v[i]).value;
			if(checkNull(v[i],"Enter Data..."+v[i]))
			{
				d = 1;
				  
			}
			else
			{
				 return false;
			}	
		} 
		
	 
	}
	catch(err)
	{
		alert(err.description)
		return false;
	}			 
}




function checkPercentage()
{
	try
	{
		
		var ref  =  document.getElementById('ref').value ;
		var percentage  = parseInt(document.getElementById('percentage').value);
		if(ref == "")
		{
			alert("Kindly Select Sales Reference -1");
			document.getElementById('ref').focus();
		}	
		
		var ref1  =  document.getElementById('ref1').value ;
		var percentage1  = parseInt(document.getElementById('percentage1').value);
		if(ref1 != "0"  )
			if(percentage1 == 0)
			{
				alert("Kindly Select Sales Reference -2 Percentage ");
				document.getElementById('percentage1').focus();
			}
			
		
		if(ref1 == "0"  )
			setOptionValue('percentage1','0');

		 
		var ref2  =  document.getElementById('ref2').value ;
		var percentage2  = parseInt(document.getElementById('percentage2').value);
		if(ref2 != "0"  )
			if(percentage2 == 0)
			{
				alert("Kindly Select Sales Reference -3 Percentage ");
				document.getElementById('percentage2').focus();
			}
			
		
		if(ref2 == "0"  )
			setOptionValue('percentage2','0');

		
		var totalpercentage = percentage+percentage1+percentage2;
				
		if( totalpercentage != 100) 
		{
			alert("Kindly confirm the Percentage...");
			return false;
		}
		else
		{
			return true;;;
		}
	}
	catch(err)
	{
		alert(err);
	}
}	





function checkMultipleBill()
{
	try
	{
		if("Y" == document.getElementById('multiplebill').value)
		{
			var len  = parseInt(document.getElementById('params').value)
			var v="";
			for( i=0;i<len;i++)
				v= v+ document.getElementById('qty'+(i+1)).value+","
			v = v.substr(0, v.length-1);
			 
			var q = v.split(",");
			 identical(q) ;
			 
				
				
			return true;;	
		}
		else
		{
			return true;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}


function identical(array) {
    for(var i = 0; i < array.length - 1; i++) {
        if(array[i] != array[i+1]) 
		{
			alert("Check quantity");
            return false;
        }
    }
    return true;
}


function calculateValues(qty)
{
		
		var qtyposition = (qty.name.replace("qty",""));	
		var quantity = qty.value;
		var uprice = document.getElementById('uprice'+qtyposition).value;
		var discount =document.getElementById('discount'+qtyposition).value;
		var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
		udiscount =(discount/100)*uprice;
		var total = ((quantity * uprice) - (udiscount*quantity));
		document.getElementById('total'+qtyposition).value = total;
		assignTaxValue("tax"+qtyposition);
		assignGrandTotal();
		
}

function assignGrandTotal()
{
	var noofcontrols = "<%=itemDatas.length%>";
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
	var grandtotal = (tot+salestaxamount);
	document.getElementById("nettotal").value=Round(grandtotal-discountamount);
 
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


			<%
			String scrpttaxid[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
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
			
 </script>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
