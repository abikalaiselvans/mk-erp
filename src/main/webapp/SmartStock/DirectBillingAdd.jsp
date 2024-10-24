<%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
<%
	try
	{
	
	String branch = ""+session.getAttribute("STKBRANCH");
	String itemsql="SELECT a.INT_GROUPID,a.CHR_GROUPNAME FROM con_inv_m_itemgroup  a , con_inv_m_itemlist b WHERE a.INT_GROUPID = b.INT_GROUPID GROUP BY a.INT_GROUPID ORDER BY a.CHR_GROUPNAME ";
	String itemdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(itemsql);
	String itemdatas=" ";
	for(int u=0; u<itemdata.length; u++)
		itemdatas= itemdatas+"<option value="+itemdata[u][0]+">"+itemdata[u][1] +"</option>";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" 	 type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Stock/Loadcustomer.js"></script>




<script type="text/javascript">

function Load()
{
	totals1.style.visibility="hidden";
	totaldiscount1.style.visibility="hidden";
	tax1.style.visibility="hidden";
	salestax1.style.visibility="hidden";
	salestaxamount1.style.visibility="hidden";
	nettotal1.style.visibility="hidden";
}
	
	
var divi="";
function Loaditemproduct(ctr,div) 
{
	divi = div;
	var idposition = divi.replace("div","");
	var url = "../Stock?actionS=LoadItemList&itemgroup="+ctr.value+"&startletter=0" ;
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
			var tb=document.getElementById(divi);
			tb.innerHTML=""; 
         	itemproductMessages();
        }
    }
}

function itemproductMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Items")[0];   	    
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
   	if(batchs.childNodes.length<1)
		alert("No Item lists are available...");
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	   	var batch = batchs.childNodes[loop];
       	var Itemid = batch.getElementsByTagName("Itemid")[0];
       	var Itemlist = batch.getElementsByTagName("Itemlist")[0];
       	str = str+"<option value='"+Itemid.childNodes[0].nodeValue+"'>"+Itemlist.childNodes[0].nodeValue+"</option>";
    }
    str=str+"</select>";
	var tb=document.getElementById(divi);
	if(batchs.childNodes.length>0)
		tb.innerHTML=str; 
	else
		tb.innerHTML=""; 
 }

 





 
function assignValues(ctr,pos) 
{
	var group = document.getElementById("itype"+pos).value;
	var listid = ctr.value;
	var url = "../Stock?actionS=INVItemProductAssign&group="+escape(group)+"&listid="+listid ;
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
	var batchs = req.responseXML.getElementsByTagName("Items")[0];   
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	Desc= batch.getElementsByTagName("ItemDesc")[0];
	    	Price= batch.getElementsByTagName("ItemPprice")[0];
			Sprice= batch.getElementsByTagName("ItemSprice")[0];
			Stock = batch.getElementsByTagName("ItemStock")[0];
			Itemunit = batch.getElementsByTagName("Itemunit")[0];
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue.replace("98650" ,"&");
			document.getElementById("stock"+idposition).value = Stock.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).value = "0";
			var tb=document.getElementById("unitdiv"+idposition);
			tb.innerHTML="<b><font color=red>"+Itemunit.childNodes[0].nodeValue+"</font></b>";
			
			document.getElementById("uprice"+idposition).value = Sprice.childNodes[0].nodeValue;
			document.getElementById("discount"+idposition).value ="0";
			document.getElementById("unitdiscount"+idposition).value = "0";
			document.getElementById("total"+idposition).value = "0";
			totals1.style.visibility="visible";
			totaldiscount1.style.visibility="visible";
			tax1.style.visibility="visible";
			salestax1.style.visibility="visible";
			salestaxamount1.style.visibility="visible";
			nettotal1.style.visibility="visible";
			document.getElementById("qty"+idposition).focus();
   }
   calculateTotal();
   assignGrandTotal();
    
 }
 
 
 
 </script>
</head>
<!--onload="loadCustomer()-->
<body  onpaste="return false;" onLoad="Load()" >
<%@ include file="indexstock.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">

<script type="text/javascript"><!--

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	 
	 
	 
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
 
 	//Dynamically insert a row in a table  -- ITEM
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
		var s8 = "stock"+r;
		 
		var div ="div"+r;
		var unitdiv ="unitdiv"+r;
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','5')\"";
		var vf2 = "onKeyPress=\"doubleValue('"+s4+"','11')\"";
		var vf3 = "onKeyPress=\"doubleValue('"+s5+"','5')\"";
		var vf4 = "onKeyPress=\"doubleValue('"+s6+"','5')\"";
		var vf5 = "onKeyPress=\"doubleValue('"+s7+"','10')\"";
	 	 
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')><%=itemdatas%></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		 x.insertCell(3).innerHTML="<input type='text' class='formText135' readonly='readonly' size=4  name='"+s8+"' id ='"+s8+"' value='0'/>";
		 
		x.insertCell(4).innerHTML="<input type='text' size=10    onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1 +" style='text-align:right'/><div id='"+unitdiv+"'></div>"; 
		
		 
		
		x.insertCell(5).innerHTML="<input type='text' size=10    onblur='calculatePrice(this)' title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right'/>";
		x.insertCell(6).innerHTML="<input type='text' size=10    onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'/>";
		x.insertCell(7).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly' style='text-align:right'/>";
		x.insertCell(8).innerHTML="<input type='text' size=10    title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly' style='text-align:right'/>";
		x.insertCell(9).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
	}
 
 
 
	
	//Calculate Nettotal 
	function calculateTotal()
	{
		var tvs =0.0;
		display();
   		var svalue="";
   		for(u=0; u<checkArray.length-1;u++)
   			tvs= tvs+parseFloat(document.getElementById('total'+checkArray[u]).value);
		document.getElementById("totals").value=Round(tvs);		
	}

	
	
	//Calculate Nettotal in Quantity Changes
	function calculateValue(qty)
	{
  		var qtyposition = (qty.name.replace("qty",""));	
		var stock =document.getElementById('stock'+qtyposition).value;
		var quantity = qty.value;
		if(parseInt(quantity)<1)
		{
			alert("Quantity Not Zero... ");
			document.getElementById('Submit').disabled=true;
			document.getElementById('stock'+qtyposition).focus();
			
		}
		else if(parseInt(quantity) > parseInt(stock))
		{
			alert("Stock Over flow... ");
			document.getElementById('Submit').disabled=true;
			document.getElementById('stock'+qtyposition).focus();
		}
		else 
		{
			document.getElementById('Submit').disabled=false;
			var uprice = document.getElementById('uprice'+qtyposition).value;
			var discount =document.getElementById('discount'+qtyposition).value;
			var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
			udiscount =(discount/100)*uprice;
			var total = ((quantity * uprice) - (udiscount*quantity));
			document.getElementById('total'+qtyposition).value = Round(total);
			calculateTotal();
			assignGrandTotal();
			var stname = document.getElementById('item'+qtyposition).value;
			var stqty = document.getElementById('qty'+qtyposition).value;
		}
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
  		document.getElementById('total'+priceposition).value =Round(total);
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
  		document.getElementById('unitdiscount'+descposition).value = Round(udiscount);
  		udiscount = document.getElementById('unitdiscount'+descposition).value;
  		var total = ((quantity * price) - (udiscount*quantity));
  		document.getElementById('total'+descposition).value = Round(total);
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
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		
		//alert("Added :: \n"+hs+"\n\n\n Deleted :: \n"+hs1+"\n\nChecked \n"+hs2);
	}
	//**********************************



	function paramAssign(svalue)
	{
		document.getElementById('param').value=svalue;
	}



	function valid()
	{
   		 
		display();
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add atleast one item...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}
		var svalue="";
		for(u=0; u<checkArray.length-1;u++)
			if(parseInt(document.getElementById("stock"+checkArray[u]).value)<1)
				document.getElementById('Submit').disabled=true;
			
			
   		svalue="";
   		for(u=0; u<checkArray.length-1;u++)
   			svalue =svalue+"item"+checkArray[u]+","+"itype"+checkArray[u]+"qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"total"+checkArray[u]+",";
		var s = "Salesnumber,saleDate,customerId,payment,division,";
   		s = s+svalue+"ref,totals,totaldiscount,tax,salestax,salestaxamount,nettotal,";
		var v = s.split(",");
		var flag =false;
		
		
		 
		if(
			checkNull("Salesnumber","Enter Invoice Number")
			&&checkNullSelect("customerId","Select Customer","Select")
			&&checkNullSelect("payment","Select Payment","Select")
			&&checkNullSelect("division","Select Division","Select")
			&& checkNull("oref","Enter Other Reference")
			&& checkNull("dnote","Enter Delivery Note")
			&& checkNull("dthru","Enter Deapatch Through")
			&& checkNull("destination","Enter Destination")
			&& checkNull("tdelivery","Enter Terms of Delivery")
			&& checkNull("cdetails","Enter Contact Person")
			&& checkNull("cnumber","Enter Contact Number")
			&&checkNullSelect("ref","Select Sales Reference","")
			&&checkNullSelect("tax","Select Tax","")
			)
		{	
			for( i=0; i<v.length-1; i++)
			{
				var chk =document.getElementById(v[i]).value;
				var ck = "Enter Data..."+v[i];
				if(checkNull(v[i],ck))
				{
					d=1;
				}
				else
				{
					return false;				
				}	
			}
		}
		else
		{
			return false;
		}	
	}
<%
	String taxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM con_inv_m_tax  ORDER BY CHR_TAXNAME");
	
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
				document.getElementById("salestax").value = Round(rowvalue[2]);
				assignGrandTotal(taxs);
				//nettotal = (parseFloat(rowvalue[2])/100 )*document.getElementById("totals").value;
				//document.getElementById("nettotal").value = parseFloat(document.getElementById("totals").value)+nettotal;
			}	
   		}
   		
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
		var salestax = parseFloat(document.getElementById("salestax").value);
		var salestaxamount = parseFloat((salestax/100)*tot);
		document.getElementById("salestaxamount").value = Round(salestaxamount);
		
		var grandtotal = Round((tot+salestaxamount));
		document.getElementById("nettotal").value=Round((grandtotal-discountamount));
		
	}
	
	
	 
--></script>
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
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="850" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong> SALE  
							</strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Ref. Sale /Invoice No.</div>									</td>
									<td width="229" class="boldEleven">
									<div align="left">
									<table>
										<tr>
											<td>
<input tabindex="0" name="Salesnumber" type="text"  class="formText135" id="Salesnumber"	onkeyup="upperMe(this)"
 style="border-left-width:thin"> </td>
											<td>
											<div id="soValid"></div>											</td>
										</tr>
									</table>
									</div>									</td>
									<td width="107" class="boldEleven">
									<div align="left">Sale Date</div>									</td>
									<td width="201" class="boldEleven"><input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly="readonly"><a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('saleDate'); 
		//-->
                          </script></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">CustomerName</div>									</td>
									<td class="boldEleven">
									<div align="left"> <input title="Search by Customer Name " name="txtSer" id="txtSer" type="text" class="formText135" size="7" onKeyUp="loadCustomer()" /> 

									<%
			String ssql="SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM con_inv_m_customerinfo WHERE INT_BRANCHID="+session.getAttribute("STKBRANCH")+" ORDER BY CHR_CUSTOMERNAME";
			String custData[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(ssql);
			%>

<select name="customerId" id="customerId" class="formText135" style="width: 150px" 	onchange="loadAddress('con_inv_m_customerinfo','CHR_CUSTOMERNAME,CHR_STREET,CHR_CITY,CHR_POSTAL,CHR_PHONE,CHR_MOBILE ','INT_CUSTOMERID','1','customerId','shippingaddress','3,4,5,','PIN,Phone,Mobile,')">

										<option value="Select">Select</option>
										<%
							for(int z=0;z<custData.length;z++)
							{
								out.print("<option value='"+custData[z][0]+"'>"+custData[z][1]+"</option>");
							}	
							%>
									</select></div>									</td>
									<td class="boldEleven">
									<div align="left">Payment Terms</div>									</td>
									<td class="boldEleven"><select name="payment"
										class="formText135" id="payment" tabindex="3">
										<option value="Select">Select</option>
										<%
								String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_PAYMENTMODEID,CHR_PAYMENTNAME FROM con_inv_m_paymentmode ORDER BY CHR_PAYMENTNAME");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
									</select></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Shipping Address</div>									</td>
									<td class="boldEleven">
									<table width="38%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="9%"><input name="Shipping" type="radio"
												value="S" onClick="return resoffval()" /></td>
											<td width="15%" class="boldEleven">Same</td>
											<td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D" checked="checked"></td>
											<td width="24%" class="boldEleven">Different</td>
										</tr>
									</table>
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left">Order Reference</div>									</td>
									<td class="boldEleven"><input name="oref" type="text"
										class="formText135" id="oref" maxlength="100" onKeyUp="upperMe(this)"
										 />										</td>
								</tr>
								<tr>
									<td rowspan="4" valign="top" class="boldEleven">&nbsp;</td>
									<td rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="shippingaddress"
										cols="25" rows="5" class="formText135" id="shippingaddress"></textarea>
									</div>									</td>
									<td class="boldEleven">
									<div align="left">Delivery Note</div>									</td>
									<td class="boldEleven"><input name="dnote" type="text"
										class="formText135" id="dnote" maxlength="100"
										onkeyup="upperMe(this)" /></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Despatch Thru</div>									</td>
									<td class="boldEleven"><input name="dthru" type="text"
										class="formText135" id="dthru" maxlength="100"
										onkeyup="upperMe(this)" /></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Destinaion</div>									</td>
									<td class="boldEleven"><input name="destination"
										type="text" class="formText135" id="destination"
										maxlength="100" onKeyUp="upperMe(this)" /></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Terms of Delivery</div>									</td>
									<td class="boldEleven"><input name="tdelivery" type="text"
										class="formText135" id="tdelivery" maxlength="100"
										onkeyup="upperMe(this)" /></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">Financial Year</td>
								  <td valign="top" class="boldEleven">
								  <select name="Financialyear" id="Financialyear">
	<%
		String CurrentFinancialYear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
		String ydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_FINANCIALYEARID,CHR_FINANCIALYEAR FROM  com_m_financialyear ORDER BY INT_FINANCIALYEARID");
		for(int u=0;u<ydata.length;u++)
			if(CurrentFinancialYear.equals(ydata[u][1]))
				out.println("<option selected='selected' value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");
			else
				out.println("<option   value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");	
			
	%>
    </select>
								  </td>
									<td class="boldEleven">
									<div align="left">Contact Person</div>									</td>
									<td class="boldEleven"><input name="cdetails" type="text"
										class="formText135" id="cdetails" maxlength="100"
										onkeyup="upperMe(this)" /></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Division</div>									</td>
									<td valign="top" class="boldEleven"><select
										name="division" class="formText135" id="division" tabindex="1" onChange="">
										<option value='Select'>Select</option>
										<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DIVIID,CHR_DIVISION FROM con_inv_m_division ORDER BY CHR_DIVISION ");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
									</select></td>
									<td class="boldEleven">
									<div align="left">Contact No.</div>									</td>
									<td class="boldEleven"><input name="cnumber" type="text"
										class="formText135" id="cnumber" maxlength="100"
										onkeyup="upperMe(this)" onKeyPress="numericValue('cnumber','15')"/></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="9">
							<div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px">
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								id="myTable">
								<tr>
									<th class="boldEleven">
										<div align="left"><strong>ItemGroup</strong></div>
									</th>
									<th class="boldEleven"><b>ItemList</b></th>
									<th class="boldEleven"><b>Description</b></th>
									<th class="boldEleven"><strong>Stock </strong></th>
									<th class="boldEleven"><b>Quantity/Units</b></th>
									<th class="boldEleven"><b>Unit Price</b></th>
									<th class="boldEleven"><b>Discount(%)</b></th>
									<th class="boldEleven"><b>Unit Discount</b></th>
									<th class="boldEleven"><b>Total</b></th>
									<th class="boldEleven">&nbsp;</th>
									 
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left"><input id="buttonitemadd" type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8" /></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								id="swapTable">
								<tr>
									<td></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<div id="productlist"></div>
							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="850" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Memo</div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9"></textarea>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input tabindex="11" name="totals"
										onkeypress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly="readonly"
										style='text-align:right' />
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input tabindex="12"
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount" value="0" onBlur="assignGrandTotal()"
										style='text-align:right' /></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left">
									
									<select name="tax" class="formText135" 			id="tax1" onChange="assignTotals(this)" tabindex="13">
										<option value="">Select</option>
										<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TAXID,CHR_TAXNAME FROM con_inv_m_tax  ORDER BY CHR_TAXNAME");
								for(int u=0; u<taxids.length; u++)
									out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
							%>
									</select></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><input name="salestax" value="0"
										type="text" class="formText135" id="salestax"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td valign="top" class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount" value="0"
										type="text" class="formText135" id="salestaxamount"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sale Reference <input name="filename"
										type="hidden" value="DirectSale" /> 
									<input name="actionS"
										type="hidden" value="STKDirectSaleAdd" /> 
									<input name="param"
										type="hidden" id="param" value='0,' /></div>
									</td>
									<td class="boldEleven">
									<div align="left"><select name="ref" id="ref"
										class="formText135" size="5">
										<jsp:include page="Staffload.jsp" flush="true" />
									</select> <!--<a href="file:SwapSaleAdd.jsp" >ghj</a>
				  <a target="_blank" href="#" onclick="javascript:save() ">ghj</a>-->
									</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">Net Total</div>
								  </td>
									<td valign="top" class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal" tabindex="15" value="0"
										style='text-align:right' /></div>
								  </td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"    onClick="return valid()" />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onclick="redirect('Directsales.jsp')" /></div>
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>
									</td>
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
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
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
<%
  	//sql = "select * from inv_m_stock where CHR_ITEMID=";
  //checkstock(stname,stqty);
  %>
</form>
<script language="javascript">

 function resoffval()
{
	if(document.frm.Shipping[0].checked==true)
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
	}         
	else 
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of resoffval



</script>
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 }
%>
</body>
</html>
