<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

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
			numberOfMonths: 1,
			buttonImageOnly: true,
			showOn: "button",
		defaultDate: "+1w",
			changeMonth: true,
			minDate: -0, maxDate: "+7D" 
		});
	});
 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">















<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDetails.js"></script>



<script type="text/javascript">
var divi="";
function Loaditemproduct(ctr,div) 
{
	var vendorid = document.getElementById('vendorid').value;
	var purchaserequest = document.getElementById('purchaserequest').value;
	var url = "../inventory?actionS=INVItemProductdependsPurchaseRequest&id="+escape(ctr.value)+"&purchaserequest="+purchaserequest+"&vendorid="+vendorid ;
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
	var str="<select name='"+s1+"'   style='width:160' id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
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



var sposition="";
function assignValues(ctr,pos) 
{
	sposition=pos;
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
   	var idposition = sposition; //divi.replace("div","");
	s1 ='item'+idposition;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	Desc= batch.getElementsByTagName("Desc")[0];
	    	Price= batch.getElementsByTagName("PPrice")[0];
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).value = "1";
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
			document.getElementById("qty"+idposition).focus();
   }
   calculateTotal();
   assignGrandTotal();
    
 }
</script>

<script type="text/javascript">

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	var globaltype="1";
	
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
	
	//load  Item or Product values
	function assignTypes(ctr)
	{
		
		var type =ctr.value;
		alert(type);
		Loaditemproduct(type);
		//Loaditemproduct(type);
		 
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
	
	function insRows()
	{
		if(  checkNullSelect("purchaserequest","Select Purchase Request Number",'0')   ) 
		{
			insRow();
		}
	}
	
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
		
		var s10 = "stax"+r;
		var s11 = "staxpercentage"+r;
		var s12 = "staxamount"+r;
		var s13 = "warranty"+r;
		
		var s7 = "total"+r;
		var div ="div"+r;
		 
	  
		var vf1 = "onKeyPress=\" return numeric_only(event,'"+s3+"','15') \"";
		var vf2 = "onKeyPress=\" return numeric_priceonly(event,'"+s4+"','15') \"";
		var vf3 = "onKeyPress=\" return numeric_only(event,'"+s5+"','15') \"";
		var vf4 = "onKeyPress=\" return numeric_only(event,'"+s6+"','15') \"";
		var vf5 = "onKeyPress=\" return numeric_only(event,'"+s7+"','15') \"";
		
		 
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1' title='Item'>Item</option><option  value='2' title='Product'>Product</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10    onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" style='text-align:right'  maxlength='4'/>";
		
		x.insertCell(4).innerHTML="<select class='formText135'   style='width:100'  name='"+s13+"' id ='"+s13+"'   ><%=warrantyinsert%></select>";
		
		
		x.insertCell(5).innerHTML="<input type='text' size=10    onblur='calculatePrice(this)' title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right'  maxlength='12'/>";
		x.insertCell(6).innerHTML="<input type='text' size=10    onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'  maxlength='3'/>";
		x.insertCell(7).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly' style='text-align:right'/>";
		
		x.insertCell(8).innerHTML="<select class='formText135' name='"+s10+"' id ='"+s10+"' onBlur=assignTaxValue('"+s10+"') ><%=optiontaxname%></select>";
		x.insertCell(9).innerHTML="<input type='text' size=10 class='formText135'  name='"+s11+"' id ='"+s11+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(10).innerHTML="<input type='text' size=10 class='formText135'  name='"+s12+"' id ='"+s12+"'  readonly='readonly' style='text-align:right'/>";
		
		
		x.insertCell(11).innerHTML="<input type='text' size=10    title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly' style='text-align:right'/>";
		
		x.insertCell(12).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
	}
 
	 	
	//If any changes in Combobox then the corresponding values are assign to corresponding controls
	function assignValue(itm)
	{
  		alert(itm.name);
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
	}
	//**********************************


	function paramAssign(svalue)
	{
		document.getElementById(param).value=svalue;
	}

	 
		 
		/*if( 
			
			checkNullSelect("vendorid","Select Vendor ","Select")
			&& checkNullSelect("payment","Select Payment ","Select")
			&& checkNullSelect("paymentterm","Select Payment Term","Select")
			&& checkNullSelect("order","Select Order From ","Select")
			&& checkNullSelect("ship","Select Shipping To ","Select")
			
		 )	*/
		 
			 
function valid()
{
   	try
	{	
		display();
		//alert(document.getElementById('param').value);
		var svalue="";
		
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add atleast one Item or Product...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}	
   		for(u=0; u<checkArray.length-1;u++)
   			svalue =svalue+"itype"+checkArray[u]+","+"item"+checkArray[u]+","+ "qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"stax"+checkArray[u]+","+"total"+checkArray[u]+",";
   		var s = "vendorid,orderdate,requestdate,payment,paymentterm,order,ship,duedt,division,purchaserequest,";
   		s = s+svalue+"totals,totaldiscount,tax,salestax,frieghtcharge,nettotal,";
		
		
		
   		var v = s.split(",");
		var flag =false;
		
		if(checkNullSelect("vendorid","Select Vendor ","Select")
			&& checkNullSelect("payment","Select Payment ","Select")
			&& checkNullSelect("paymentterm","Select Payment Term","Select")
			&& checkNullSelect("order","Select Order From ","Select")
			&& checkNullSelect("ship","Select Shipping To ","Select")
			&& checkNullSelect("division","Select Division ","Select")
			&& checkNullSelect("purchaserequest","Select Purchase Request Number",'0')  
			&& checkNull ("memo","Enter Description" )
			&& checkNullSelect("ref","Select Reference ","")
			 
			)
		{	
			for( i=0; i<v.length-1; i++)
			{
				//if(checkfindObject(v[i],v[i]+" not found..."))
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
				//else
					//return false;	
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
		
		document.getElementById("nettotal").value= ((grandtotal).toFixed(2));	
				
	}

</script>
</head>
<body   > 
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return valid()">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="900"
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
					<table width="900" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">VENDOR PURCHASE ORDER </div>							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>

									<td class="boldEleven">
									<div align="left">Vendor <span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left">
<select name="vendorid"	class="formText135" id="vendorid" tabindex="1" style="width:200"  onChange="LoadPurchaseRequest()">
										<option value='Select'>Select</option>
										<%
								String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation ");
								for(int u=0; u<vendorids.length; u++)
									out.print("<option value='"+vendorids[u][0]+"'>"+vendorids[u][1]  +"</option>");
							%>
									</select></div>									</td>

									<td width="102" class="boldEleven">
									<div align="left">Payment Mode<span class="boldred"> *</span> </div>									</td>
									<td width="237" class="boldEleven">
									<div align="left"><select name="payment"
										class="formText135" id="payment" tabindex="3"  style="width:200">
										<option value='Select'>Select</option>
										<%
										
								String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTCONDITIONID,CHR_PAYMENTNAME from inv_m_paymentcondition ORDER BY CHR_PAYMENTNAME ");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
									</select></div>									</td>
								</tr>
								<tr>

									<td width="123" class="boldEleven">Order Date									<span class="boldred">*</span> </td>
									<td width="198" class="boldEleven"><div align="left">
									  <input tabindex="2" name="orderdate"
										type="text" class="formText135" id="orderdate" size="15"
										readonly="readonly" />
                                      <script language='JavaScript'
										type="text/javascript">
		<!--			
				
				
				setCurrentDate('orderdate'); 
		//-->
                                    </script>
									  </div></td>
									<td class="boldEleven">
									<div align="left">Payment Terms<span class="boldred"> *</span> </div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="paymentterm"
										class="formText135" id="paymentterm" tabindex="3"  style="width:200">
										<option value="Select">Select</option>
										<%
								String paymentterms[][] = CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms ORDER BY CHR_PAYMENTNAME");
								for(int u=0; u<paymentterms.length; u++)
									out.print("<option value='"+paymentterms[u][0]+"'>"+paymentterms[u][1]+"</option>");
							%>
									</select></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Request Date <span class="boldred">*</span> </div>									</td>
									<td class="boldEleven"><div align="left">
									  <input tabindex="2" name="requestdate"
										type="text" class="formText135" id="requestdate" size="15"
										readonly="readonly" />
                                      <script language='JavaScript'
										type="text/javascript">
		<!--			
				 
				setCurrentDate('requestdate'); 
		//-->
                                    </script>
								    </div></td>
									<td class="boldEleven">
									<div align="left">Order From <span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="order"
										class="formText135" id="order" tabindex="5"  style="width:200">
										<option value="Select">Select</option>
										<%
										
								 
								String branchids[][] =CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND a.INT_ACTIVE=1   AND b.INT_ACTIVE=1");
								for(int u=0; u<branchids.length; u++)
									out.print("<option value='"+branchids[u][0]+"'>"+branchids[u][2]+ "  @  " +branchids[u][1] +"</option>"); 
							%>
									</select></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Due date</div>									</td>
									<td class="boldEleven"><input name="duedt" type="text"
										class="formText135" id="duedt" size="15" readonly
										tabindex="7" /><script language='JavaScript'
										type="text/javascript">
		<!--			
				 
				setCurrentDate('duedt'); 
		//-->
                          </script></td>
									<td class="boldEleven">
									<div align="left">Shipping To <span class="boldred">*</span> </div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="ship" class="formText135"
										id="ship" tabindex="6"  style="width:200">
										<option value="Select">Select</option>
										<%
								 for(int u=0; u<branchids.length; u++)
									out.print("<option value='"+branchids[u][0]+"'>"+branchids[u][2]+ "  @  " +branchids[u][1] +"</option>"); 
							%>
									</select></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">On Hold</div>									</td>
									<td class="boldEleven">
									<div align="left"><input name="hold" type="checkbox"
										id="hold" value="1" tabindex="4" /></div>									</td>
									<td class="boldEleven">Division<span class="boldred"> *</span> </td>
									<td class="boldEleven">
                            <select name="division"
										class="formText135" id="division" tabindex="1"  style="width:200">
                              <option value='Select'>Select</option>
                              <%
								String division[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                            </select></td>
								</tr>
								<tr>
									<td colspan="2" class="copyright">P = Product I = Item</td>
									<td class="boldEleven">Purchase Request <span class="boldred">*</span></td>
									<td class="boldEleven">
<select name="purchaserequest" class="formText135" id="purchaserequest" onChange="loadPurchaseRequestDetails()" style="width:200" >
<option value="0">Select Purchase Request </option>
								    </select>
									
									<input name="proposedpurchasedate" type="hidden" id="proposedpurchasedate" value="">
									<script language="javascript">setCurrentDate('proposedpurchasedate'); </script>									
									
									<br>If Partially Received then click<input name="partialreceived" type="checkbox" id="partialreceived" value="Y" checked> </td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td>

							<div id="divscroll" style="OVERFLOW:auto;width:100%;height:100px"
								class="boldEleven">
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								id="myTable">
								<tr>
									<th class="boldEleven">
									<div align="left"><strong>Type</strong></div>									</th>
									<th class="boldEleven"><b>Item</b></th>
									<th class="boldEleven"><b>Description</b></th>
									<th class="boldEleven"><b>Quantity</b></th>
									<th class="boldEleven"><b>Warranty</b></th>
									<th class="boldEleven"><b>Unit Price</b></th>
									<th class="boldEleven"><b>Discount(%)</b></th>
									<th class="boldEleven"><b>Unit Discount</b></th>
									<th class="boldEleven"><b>Tax</b></th>
									<th class="boldEleven"><b>Tax (%)</b></th>
									<th class="boldEleven"><b>Tax Amount </b></th>
								
									<th class="boldEleven"><b>Total</b></th>
							</table>
							</div>
							<input name="buttonitemadd" type="button" class="tMLAscreenHead"
								id="buttonitemadd" tabindex="8" onClick="insRows()" value="Add">							</td>
						</tr>
						<tr>
						  <td> </td>
					  </tr>
						<tr>
								  <td  valign="top" class="boldEleven"><div id="prdetails" style="OVERFLOW:auto;width:100%;height:300px"  ></div></td>
							  </tr>
							  
						<tr>
						  <td>&nbsp;</td>
					  </tr>
						<tr>
						  <td>&nbsp;</td>
					  </tr>
						<tr>
							<td></td>
						</tr>
						 
						<tr>
							<td></td>
						</tr>
						<tr>

							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description <span class="boldred">*</span> </div>									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="35"
										rows="5" class="formText135"  onKeyUp="textArea('memo','500')" id="memo" tabindex="9"></textarea>
									</div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input tabindex="11" name="totals"
										 type="text"
										class="formText135" id="totals" readonly
										style='text-align:right' /></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount</div>									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">

									<div align="left"><input name="totaldiscount" type="text"
										class="formText135" id="totaldiscount"
										style='text-align:right' tabindex="12"
										onblur="assignGrandTotal()" value="0" maxlength="3"
										onKeyPress="return numeric_only(event,'totaldiscount','7') " /></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group <span class="boldred">*</span> </div>									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">

									<div align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" style="width:120" tabindex="13">
										<option value="">Select</option>
										<%
								 for(int u=0; u<taxids.length; u++)
									out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
							%>
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
									<div align="left"></div>									</td>
									<td class="boldEleven">
									<div align="left"></div>									</td>
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
								  <td class="boldEleven">Freight Charge <span class="boldred"> *</span></td>
								  <td class="boldEleven" id="nettotal1"><input name="frieghtcharge" type="text"
										class="formText135" id="frieghtcharge"
										style='text-align:right' tabindex="15"  onBlur="assignGrandTotal()" onKeyPress="return numeric_only(event,'frieghtcharge','7') " value="0" maxlength="5" /></td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <span class="boldred">*</span>
                                      <input name="filename"
										type="hidden" value="PurchaseOrder" /> <input name="actionS"
										type="hidden" value="INVPurchaseOrderAdd" /> <input
										name="param" type="hidden" id="param" value='0,'></div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
										<jsp:include page="Staffload.jsp" flush="true" />
									</select></div>									</td>
									<td class="boldEleven">
									<div align="left">Net Total</div>									</td>
									<td class="boldEleven" id="nettotal1">

									<div align="left"><input name="nettotal" type="text"
										class="formText135" readonly="readonly" id="nettotal" tabindex="15" value="0"
										style='text-align:right' /></div>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit"  id="Submit" type="submit"
												class="tMLAscreenHead" value="Submit"   accesskey="s"   
												 /></td>
											<td width="56"><input type="button"
												class="tMLAscreenHead"  value="Close"   accesskey="c" 
												onClick="redirect('Purchase Order.jsp')" /></td>
										</tr>
									</table>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>									</td>
								</tr>
							</table>							</td>
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
		<td>&nbsp;</td>
	</tr>
</table>
</div>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.print(e.getMessage());
	System.out.print(e.getMessage());
}

%>

<script language="javascript">
 
function LoadPurchaseRequest()
{
	try
	{
		var vendorid = document.getElementById('vendorid').value;
		var url = "../inventory?actionS=LoadPurchaseRequest&vendorid="+vendorid;
		initRequest(url);
		req.onreadystatechange=LoadPurchaseRequestRequest;
   		req.open("GET", url, true);
  		req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}


function LoadPurchaseRequestRequest() 
{
	try
	{
	   if(req.readyState == 4) 
	   { 
			var _targ=document.getElementsByName('purchaserequest')[0];       
			_targ.options.length=0;
			_targ.options[0]=new Option('Select purchase request','0'); 
			if (req.status == 200) 
			{		  	
					LoadPurchaseRequestMessages();
			}
	   }
	}
	catch(err)
	{
		alert(err);
	}
}


function LoadPurchaseRequestMessages() 
{	 
 
 	try
	{   
		var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
		var _targ=document.getElementsByName('purchaserequest')[0];       
		_targ.options.length=0;
		_targ.options[0]=new Option('Select purchase request','0');  
		var str=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(  (Id+" For "+Name) ,Id);
		}
	}
	catch(err)
	{
		alert(err);
	}
}


</script>
