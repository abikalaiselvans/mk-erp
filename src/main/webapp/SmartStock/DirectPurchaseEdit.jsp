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

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script type="text/javascript">

 
var divi="";
function Loaditemproduct(ctr,div) 
{
	divi = div;
	var idposition = divi.replace("div","");
	document.getElementById("desc"+idposition).value = "";
	document.getElementById("qty"+idposition).value = "0";
	document.getElementById("uprice"+idposition).value = "";
	document.getElementById("discount"+idposition).value ="0";
	document.getElementById("unitdiscount"+idposition).value = "0";
	document.getElementById("total"+idposition).value = "0";
	calculateTotal();
    assignGrandTotal();
	var url = "../Stock?actionS=LoadItemList&itemgroup="+ctr.value+"&startletter=0" ;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
	
}



function Loaditemproducts(idposition) 
{
	 
	divi = "div"+idposition;
	ctr= document.getElementById("itype"+idposition).value;
	var url = "../Stock?actionS=LoadItemList&itemgroup="+ctr+"&startletter=0" ;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
	
}


function itemproductRequest() 
{
	try
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
	catch(err)	
	{
		alert(err.description)
	}	
}


function itemproductMessages() 
{
	 
	var batchs = req.responseXML.getElementsByTagName("Items")[0];   	 
	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	//alert("after response  : "+s1 +"  /  "+ divi +"  /" +idposition)
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
	//alert(str);
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

function assignValues1(pos) 
{
	divi = "div"+pos;
	var group = document.getElementById("itype"+pos).value;
	var listid = document.getElementById("item"+pos).value;
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
			PPrice= batch.getElementsByTagName("ItemSprice")[0];
			 
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).value = "0";
			document.getElementById("uprice"+idposition).value = PPrice.childNodes[0].nodeValue;
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




</head>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return valid()">

<script type="text/javascript"><!--

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	//totals,tax,salestax,nettotal, these controls are hidden
	function Load()
	{
		totals1.style.visibility="hidden";
		totaldiscount1.style.visibility="hidden";
		tax1.style.visibility="hidden";
		salestax1.style.visibility="hidden";
		salestaxamount1.style.visibility="hidden";
		nettotal1.style.visibility="hidden";
	}
	
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
		var s8 = "consumables"+r;
		var div ="div"+r;
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','7')\"";
		var vf2 = "onKeyPress=\"doubleValue('"+s4+"','11')\"";
		var vf3 = "onKeyPress=\"doubleValue('"+s5+"','9')\"";
		var vf4 = "onKeyPress=\"doubleValue('"+s6+"','9')\"";
		var vf5 = "onKeyPress=\"doubleValue('"+s7+"','10')\"";
	 	 
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')><%=itemdatas%></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10    onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" style='text-align:right'/>";
		x.insertCell(4).innerHTML="<input type='text' size=10    onblur='calculatePrice(this)' title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right'/>";
		x.insertCell(5).innerHTML="<input type='text' size=10    onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'/>";
		x.insertCell(6).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly' style='text-align:right'/>";
		x.insertCell(7).innerHTML="<input type='text' size=10    title='Total' value=0 class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly' style='text-align:right'/> <input type='hidden' name='"+s8+"' id ='"+s8+"' />";
		x.insertCell(8).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		//document.getElementById(s0).focus();
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
 	}

	
	//Calculate Nettotal 
	function calculateTotal()
	{
		try
		{
			var tvs =0.0;
			display();
			var svalue="";
			for(u=0; u<checkArray.length-1;u++)
				tvs= tvs+parseFloat(document.getElementById('total'+checkArray[u]).value);
			document.getElementById("totals").value=Round(tvs);		
		}
		catch(err)	
		{
			alert(err.description)
		}	
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
			udiscount =(discount/100)*uprice;
			var total = ((quantity * uprice) - (udiscount*quantity));
			document.getElementById('total'+qtyposition).value = Round(total);
			calculateTotal();
			assignGrandTotal();
			var stname = document.getElementById('item'+qtyposition).value;
			var stqty = document.getElementById('qty'+qtyposition).value;
		}
		else
		{
			alert("Quantity Should not be Zero");
			qty.focus();
		}
	}

	//Calculate Nettotal in Price Changes
	function calculatePrice(pre)
	{
  		var priceposition = (pre.name.replace("uprice",""));
  		var price = pre.value;
  		var quantity = document.getElementById('qty'+priceposition).value;
  		var discount =document.getElementById('discount'+priceposition).value;
  		document.getElementById('unitdiscount'+priceposition).value = Round((discount/100)*price);
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
		try
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
		catch(err)	
		{
			alert(err.description)
		}	
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
			alert("Please Add atleast one Item / Product");
			document.getElementById('buttonitemadd').focus();
			return false;
		}
		
   		var svalue="";
   		for(u=0; u<checkArray.length-1;u++)
		
   			svalue =svalue+"itype"+checkArray[u]+","+"qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"total"+checkArray[u]+",";
			
		var s = "cashpurchaseno,purchasedate,vendorid,payment,division,";
   		s = s+svalue+"totals,totaldiscount,tax,salestax,salestaxamount,nettotal,";
		var v = s.split(",");
   		var flag =false;
		
		if( checkNull("cashpurchaseno","Enter Purchase Invoice Number")
			&&	checkNullSelect("vendorid","Select Vendor ","Select")
			&& 	checkNullSelect("payment","Select Payment ","Select")
			&& 	checkNullSelect("division","Select Division ","Select")
			
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
	String taxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
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
	
	function assignGrandTotal()
	{
			alert("3-1");
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
		document.getElementById("nettotal").value=Math.round((grandtotal-discountamount));
		
	}

--></script>
<%@ include file="indexstock.jsp"%>


<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr> 
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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
					<table  border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Direct Purchase Edit </strong></div>
							
							<%
								String Purchaseid=request.getParameter("Purchaseid");
								String sql =" SELECT INT_BRANCHID,CHR_PURCHASEREFNUMBER,CHR_VENDORINVOICENUMBER,INT_VENDORID,";
								sql = sql +" INT_DIVIID,INT_PAYMENTMODEID,DATE_FORMAT(DAT_PURCHSEDATE,'%d-%m-%Y'),CHR_DES,";
								sql = sql + " CHR_REF,DOU_AMOUNT, DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT ";
								sql = sql + " FROM con_inv_t_purchase WHERE INT_PURCHASEID="+Purchaseid;
								String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							%>
							
							
							</td>
						</tr>
						<tr>
							<td>
							<table width="788" border="0" align="center" cellpadding="1"
								cellspacing="1">

								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Vendor Invoice No.</div>									</td>
									<td width="229" class="boldEleven">
									<div align="left">
									<table>
										<tr>
											<td><input name="cashpurchaseno" type="text"
												class="formText135" id="cashpurchaseno" tabindex="0"
												    onBlur="upperMe(this)"    
												onKeyPress=""
												onkeyup="upperMe(this)" value="<%=data[0][2]%>" size="30" maxlength="50" /></td>
											<td>
																						</td>
									</table>
									</div>									</td>
									<td width="107" class="boldEleven">Purchase Date</td>
									<td width="201" class="boldEleven"><input
										name="purchasedate" type="text" class="formText135" id="purchasedate" tabindex="2" value="<%=data[0][6]%>"
										size="15" readonly="readonly" /> 
									<a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['purchasedate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('purchasedate'); 
		//-->
                          </script></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor</div>									</td>
									<td class="boldEleven"><select name="vendorid"
										class="formText135" id="vendorid" tabindex="1">
										<option value='Select'>Select</option>
										<%
								String vendorids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_VENDORID,CHR_VENDORNAME FROM con_inv_m_vendorsinfo WHERE INT_BRANCHID="+branch+"  ORDER BY CHR_VENDORNAME ");
								for(int u=0; u<vendorids.length; u++)
									out.print("<option value='"+vendorids[u][0]+"'>"+vendorids[u][1]+" / "+vendorids[u][0] +"</option>");
							%>
									</select></td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven"><select name="payment"
										class="formText135" id="payment" tabindex="3">
										<option value='Select'>Select</option>
										<%
								String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_PAYMENTMODEID,CHR_PAYMENTNAME FROM con_inv_m_paymentmode ORDER BY CHR_PAYMENTNAME");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
									</select></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Division</td>
									<td class="boldEleven"><select name="division"
										class="formText135" id="division" tabindex="1">
										<option value='Select'>Select</option>
										<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DIVIID,CHR_DIVISION FROM con_inv_m_division ORDER BY CHR_DIVISION ");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
									</select></td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="9">
							<div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px">
							<table id="myTable" width="100%" border="0" cellpadding="1"
								cellspacing="1">

								<th class="boldEleven">
								<div align="left"><strong>Item Group </strong></div>
			</th>
								<th class="boldEleven"><b>Item</b></th>
								<th class="boldEleven"><b>Description</b></th>
								<th class="boldEleven"><b>Quantity/Unit</b></th>
								<th class="boldEleven"><b>Unit Price</b></th>
								<th class="boldEleven"><b>Discount(%)</b></th>
								<th class="boldEleven"><b>Unit Discount</b></th>
								<th class="boldEleven"><b>Total</b></th>

							</table>
							</div>							</td>
						</tr>
						<tr>
						  <td><table border="0">
							<tr><td width="56">
							<div align="left"><input type="button" width="56"
								class="buttonbold13" onClick="insRow()" value="Add"
								id="buttonitemadd" tabindex="8"></div>
								</td>
							</tr>
								</table>							
							  </td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="802" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Memo
<%

	sql = "	SELECT INT_GROUPID,INT_ITEMID,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM ";
	sql = sql +" con_inv_t_purchsedetail  WHERE CHR_PURCHASEREFNUMBER='"+data[0][1]+"' ";
	String subdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

%>







									</div>									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9" ><%=data[0][7]%></textarea>
									</div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input name="totals" type="text"
										class="formText135" id="totals"
										style='text-align:right' tabindex="11"
										onKeyPress="numericValue('totals','12')" value="<%=data[0][9]%>" readonly="readonly" />
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input tabindex="12"
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount" value="<%=data[0][10]%>" onBlur="assignGrandTotal()"
										style='text-align:right'
										onKeyPress="doubleValue('totaldiscount',9)">
									</div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax1" onChange="assignTotals(this)" tabindex="13">
										<option>Select</option>
										<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_TAXID,CHR_TAXNAME FROM con_inv_m_tax  ORDER BY CHR_TAXNAME");
								for(int u=0; u<taxids.length; u++)
									out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
							%>
									</select></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"> Tax (%)</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><input name="salestax" value="0"
										type="text" class="formText135" id="salestax"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="DirectPurchase" /> <input name="actionS"
										type="hidden" value="STKDirectPurchaseAdd" /> 
									<input
										name="param" type="hidden" id="param" value='0,'></div>									</td>
									<td class="boldEleven">
									<div align="left"><input name="ref" type="text"
										class="formText135" id="ref"
										tabindex="10" value="<%=data[0][8]%>" size="25" maxlength="20" />
									</div>									</td>
									<td class="boldEleven">
									<div align="left">Tax Amount</div>									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount" value="<%=data[0][12]%>"
										type="text" class="formText135" id="salestaxamount"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>									</td>
								  <td class="boldEleven">
				
	<script language="javascript">
		setOptionValue('vendorid','<%=data[0][3]%>');
		setOptionValue('division','<%=data[0][4]%>');
		setOptionValue('payment','<%=data[0][5]%>');
		setOptionValue('tax','<%=data[0][11]%>');
		assignTotals('tax');
	</script>
	<%
		String param="";
		for(int u=0; u<subdata.length;u++)
		{
			param= param+(u+1)+",";
	%>
	<script language="javascript">
			
			insRow();
			
			
			var div ="div<%=(u+1)%>" ;
			
			var s0= "itype<%=(u+1)%>" ;
			setOptionValue(s0,"<%=subdata[u][0]%>");
			
			/*
			Loaditemproducts(s0,div);
			var s1= "item<%=(u+1)%>" ;
			setOptionValue(s1,"<%=subdata[u][1]%>");
			
			 
			
			
			*/
			
			
	</script>				
	<%
	
	}
	%>			
	
	<script language="javascript">
		document.getElementById('param').value="<%=param%>";
	</script>	
	
	<%
		for(int u=0; u<subdata.length;u++)
		{
	%>
	<script language="javascript">
			Loaditemproducts("<%=(u+1)%>");
			setOptionValue("item<%=(u+1)%>","<%=subdata[u][1]%>");
			 
	</script>
	<%	
		}
	%>			
	
	<%
		for(int u=0; u<subdata.length;u++)
		{
	%>
	<script language="javascript">
			//assignValues1("<%=(u+1)%>") ;
	</script>
	<%	
		}
	%>		
	
	
	<%
		for(int u=0; u<subdata.length;u++)
		{
	%>
	<script language="javascript">
			
			var s3 ="qty<%=(u+1)%>" ;
			setOptionValue(s3,"<%=subdata[u][2]%>");
			
			var s4 = "uprice<%=(u+1)%>" ;
			setOptionValue(s4,"<%=subdata[u][3]%>");
			
			
			var s5 = "discount<%=(u+1)%>" ;
			setOptionValue(s5,"<%=subdata[u][4]%>");
			
			var s6 = "unitdiscount<%=(u+1)%>" ;
			setOptionValue(s6,"<%=subdata[u][5]%>");
			
			var s7 = "total<%=(u+1)%>" ;
			setOptionValue(s7,"<%=subdata[u][6]%>");
	</script>
	<%	
		}
	%>		
				
								</td>
									<td class="boldEleven">
									<div align="left">Net Total</div>									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal" tabindex="15" value="<%=data[0][13]%>"
										style='text-align:right' />
									</div>									</td>
								</tr>
								<tr>
								  <td height="34" colspan="4" class="boldEleven"><table width="133" border="0" align="center" cellpadding="2" cellspacing="2">
                                    <tr>
                                      <td><input name="Submit" type="submit"
										class="buttonbold13"  value="Add"   accesskey="s"    /></td>
                                      <td><input name="Submit2" type="button"
										class="buttonbold13" value="  Close  "
										onClick="redirect('Directpurchase.jsp')" /></td>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center">&nbsp;&nbsp;</div>
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>									</td>
								</tr>
							</table>							</td>
						</tr>
					</table>					</td>
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
		</table>		</td>
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
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 }
%>
</body>
</html>
