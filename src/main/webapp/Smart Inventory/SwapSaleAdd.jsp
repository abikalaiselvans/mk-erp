<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
	try
	{
 	 
String dateCheckData[][] = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y'), DAT_LOCK,MONTHNAME(NOW()),MONTH(NOW()), YEAR(NOW())  FROM m_institution  WHERE INT_ID=1");
String inventorysettingData[][] =  CommonFunctions.QueryExecute("SELECT CHR_SALES_INVOICE_CREATED,DATE_FORMAT(now(),'%Y%m%d%H%i%s')  FROM m_inventorysetting  WHERE INT_ROWID=1");		
String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax ORDER BY CHR_TAXNAME");
String optiontaxname="<option value=''>Select Tax</option>";//<option value='0'>No Tax</option>
for(int u=0; u<taxids.length; u++)
optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";

String warrantyinsert="";
warrantyinsert = warrantyinsert + "<option  value='1' selected='selected'>1 - Year</option>";
warrantyinsert = warrantyinsert + "<option  value='0'>No Warranty </option>";
warrantyinsert = warrantyinsert + "<option  value='0.3'>0.3 - Months </option>";
warrantyinsert = warrantyinsert + "<option  value='0.6'>0.6 - Months </option>";
warrantyinsert = warrantyinsert + "<option  value='0.9'>0.9 - Months </option>";
warrantyinsert = warrantyinsert + "<option  value='1'>1 - Year</option>";
warrantyinsert = warrantyinsert + "<option  value='0'>No Warranty </option>";
 
 
for(int u=2;u<=10;u++)
	warrantyinsert = warrantyinsert + "<option  value='"+u+"'>"+u+" - Years</option>";

%>
<%
//System.out.println("11111");
//System.out.println(optiontaxname);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" 	 type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/CustomerSalesCreditlimit.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	
$(function() {
		$( "#saleDate" ).datepicker({ minDate: -400, maxDate: "+7D" });
	});
 
 


 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">





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
	
	
	function unLoad()
	{
		totals1.style.visibility="visible";
		totaldiscount1.style.visibility="visible";
		tax1.style.visibility="visible";
		salestax1.style.visibility="visible";
		salestaxamount1.style.visibility="visible";
		nettotal1.style.visibility="v";
	}
	




function resoffval()
{
	
	if(document.frm.Shipping[0].checked==true)
	{
		
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
		AssignShippingAddress();
	}         
	else 
	{
		
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of resoffval




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
	var str="<select name='"+s1+"'   style='width:160'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
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
	   document.getElementById(s1).focus();
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
	    	Desc= batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    	Price= batch.getElementsByTagName("Price")[0].childNodes[0].nodeValue;
			Stock= batch.getElementsByTagName("Stock")[0].childNodes[0].nodeValue;
			Ptype= batch.getElementsByTagName("Ptype")[0].childNodes[0].nodeValue;
			Plist= batch.getElementsByTagName("Plist")[0].childNodes[0].nodeValue;
			Ptax= batch.getElementsByTagName("Ptax")[0].childNodes[0].nodeValue;
			
			//alert(Desc.childNodes[0].nodeValue;);
			document.getElementById("desc"+idposition).value = Desc.replace("98650" ,"&");
			document.getElementById("stock"+idposition).value = Stock;
			document.getElementById("qty"+idposition).value = "";
			document.getElementById("uprice"+idposition).value = Price;
			document.getElementById("discount"+idposition).value ="0";
			document.getElementById("unitdiscount"+idposition).value = "0";
			document.getElementById("stax"+idposition).value = Ptax;
			document.getElementById("consumables"+idposition).value =  Ptype;
			assignTaxValue("stax"+idposition);
			//setOptionValue("stax"+idposition , Ptax);
			 
	    
		
		
			if(Ptype== "C" )
			{
				document.getElementById("pitemlist"+idposition).value=Plist;
				var tb=document.getElementById("swap"+idposition);
  				
				var tb1=document.getElementById("SwapCheck"+idposition);
				var n ="SwapCheckbox"+idposition;
				tb1.innerHTML="<input  id="+n+" name="+n+" type='checkbox'  checked='checked'  />";
			}
			else
			{
				var tb=document.getElementById("swap"+idposition);
  				tb.innerHTML=""  ;
				var tb1=document.getElementById("SwapCheck"+idposition);
  				tb1.innerHTML=""  ;
			}
			
			
			calculateTotal();
   }
   calculateTotal();
   assignGrandTotal();
    
 }
 
 
 
 
 function assignSwap(ctr,pitemlist)
 {
 	var p= "pitemlist"+pitemlist;
	p=document.getElementById(p).value;
	var sw="<center><table width='100%' class='MRow1'  cellspacing=2 cellpadding=2 border=0 ><tr><td class='bold1'>S.No<td class='bold1'>Items";
	var itemname =p.split("~");
	for(x=0;x<itemname.length-1;x++)
	{
		var xitem = itemname[x].split("/");
		sw = sw +"<tr><td class='boldEleven'>"+(x+1)+"<td class='boldEleven'>"+xitem[0]+"<br>";
		
	}
	sw = sw +"</table><center>";	
	
	var tb2=document.getElementById("productlist" );
  	tb2.innerHTML=  sw;
 }
 
 function disableByBackValue()
 {
 	document.getElementById("bybackrow").style.visibility="hidden";
 }
</script>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<!--onload="loadCustomer()-->
<%@ include file="indexinv.jsp"%>
<body    onLoad="disableByBackValue()">

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return valid()">

<script type="text/javascript"><!--

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	
	//insert swap div
	function insSwapRow(row)
	{
		var x=document.getElementById('swapTable').insertRow(row);
		x.insertCell(9).innerHTML="<div id='SwapCheck'"+row+"></div>";
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
		var s8 = "stock"+r;
		var s9 = "consumables"+r;
		
		
		var s10 = "stax"+r;
		var s11 = "staxpercentage"+r;
		var s12 = "staxamount"+r;
		var s13 = "warranty"+r;
		
		
		var div ="div"+r;
		var swap ="swap"+r;
		var SwapCheck ="SwapCheck"+r;
		var pitemlist ="pitemlist"+r; 
		
 
	 	var vf1 = "onKeyPress=\" return numeric_only(event,'"+s3+"','15') \"";
		var vf2 = "onKeyPress=\" return numeric_priceonly(event,'"+s4+"','15') \"";
		var vf3 = "onKeyPress=\" return numeric_only(event,'"+s5+"','15') \"";
		var vf4 = "onKeyPress=\" return numeric_only(event,'"+s6+"','15') \"";
		var vf5 = "onKeyPress=\" return numeric_only(event,'"+s7+"','15') \"";
		var vf6 = "onblur=\"  calculate_GST_Exclusive('"+s7+"') \"";
		 
		x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>Item</option><option  value='2'>Product</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		 x.insertCell(3).innerHTML="<input type='text' class='formText135' readonly='readonly' size=4  name='"+s8+"' id ='"+s8+"' value='0'/>";
		 
		x.insertCell(4).innerHTML="<input type='text' size=10    onblur=\"calculateValue('"+s3+"')\" title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1 +" style='text-align:right'  maxlength='5' />";
		
		x.insertCell(5).innerHTML="<select class='formText135'   style='width:100'  name='"+s13+"' id ='"+s13+"'   ><%=warrantyinsert%></select>";
		
		x.insertCell(6).innerHTML="<input type='text' size=10    onblur=\"calculateValue('"+s3+"')\"  title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right' maxlength='12' />";
		
		
		
		x.insertCell(7).innerHTML="<input type='text' size=10  onblur=\"calculateDiscount('"+s3+"')\"  title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right' maxlength='3' />";
		
		x.insertCell(8).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  onblur=\"calculateDiscountAmount('"+s3+"')\" name='"+s6+"' id ='"+s6+"' " +vf4+"   style='text-align:right' maxlength='3' />";
		
		x.insertCell(9).innerHTML="<select class='formText135' name='"+s10+"' id ='"+s10+"' onBlur=assignTaxValue('"+s10+"') ><%=optiontaxname%></select>";
		x.insertCell(10).innerHTML="<input type='text' size=10 class='formText135'  name='"+s11+"' id ='"+s11+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(11).innerHTML="<input type='text' size=10 class='formText135'  name='"+s12+"' id ='"+s12+"'  readonly='readonly' style='text-align:right'/>";
		
		
		
		x.insertCell(12).innerHTML="&nbsp;<input type='text' size=10    title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+" "+vf6+"   style='text-align:right'/>";
		x.insertCell(13).innerHTML="&nbsp;<div id='"+SwapCheck+"'></div>";
		x.insertCell(14).innerHTML="&nbsp;<div id='"+swap+"'></div>";
		x.insertCell(15).innerHTML="&nbsp;<input type=hidden name='"+pitemlist+"' id='"+pitemlist+"' value='0'>";
		x.insertCell(16).innerHTML="&nbsp;<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' ><input type='hidden' name='"+s9+"' id ='"+s9+"'  style='width:60'/>";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		document.getElementById(s0).focus();
	}
 
 
 	function calculate_GST_Exclusive(ctr)
	{
		try
		{
			var idposition = ctr.replace("total","");
			var quantity = document.getElementById('qty'+idposition).value;
			
			if(quantity > 0 || quantity != '') {
				
				var netamount = document.getElementById('total'+idposition).value;
				var taxpercentage = document.getElementById('staxpercentage'+idposition).value;
				var originalprice = netamount /((taxpercentage/100)+1);
				var unitprice = originalprice/quantity;
				document.getElementById('uprice'+idposition).value = unitprice.toFixed(2); ;
				document.getElementById('uprice'+idposition).focus(); 
			}
			else
			{
				alert("Kindly enter the quantity...");
			}
			
		}
		catch(err)
		{
			alert(err);
		}
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
		var tvs =0.0;
		display();
   		var svalue="";
   		for(u=0; u<checkArray.length-1;u++)
   			tvs= tvs+parseFloat(document.getElementById('total'+checkArray[u]).value);
		document.getElementById("totals").value=Round(tvs);		
	}

	//Calculate Nettotal in Quantity Changes
	
	function calculateValue(ctr)
	{
		 
		if(document.getElementById('blockinvoice' ).checked == false)
			calculateValues(ctr);
		//else
			//document.getElementById('Submit').disabled=false; 
		 
			
	}
	
	
	
	function calculateValues(ctr)
	{
  		
		try
		{
			var quantity = document.getElementById(ctr).value;
			var idposition = ctr.replace("qty","");
			var stock =document.getElementById('stock'+idposition).value;
			
			if(parseInt(quantity)<1)
			{
				alert("Quantity Should not zero... ");
				//document.getElementById('Submit').disabled=true;
				document.getElementById('stock'+idposition).focus();
				
			}
			else if(parseInt(quantity) > parseInt(stock))
			{
				alert("Kindly check Stock... ");
				//document.getElementById('Submit').disabled=true;
				document.getElementById('stock'+idposition).focus();
			}
			else  if(quantity>=1)
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
			else
			{
				alert("Quantity Should not be Zero");
				document.getElementById("item"+idposition).focus();
			}
			
		}
		catch(err)
		{
			alert(err);
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
	function calculateDiscount(ctr)
	{
 		try
		{
   			
			var position = ctr.replace("qty","");	
			var discount = document.getElementById('discount'+position).value;
			var uprice = document.getElementById('uprice'+position).value;
			var udiscount =(discount/100)*uprice;
			document.getElementById('unitdiscount'+position).value=udiscount;

			var quantity = document.getElementById('qty'+position).value;
			if(quantity>=1)
			{ 
				uprice = uprice - udiscount;
				var staxpercentage = parseFloat(document.getElementById("staxpercentage"+position).value);
				document.getElementById("staxamount"+position).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
				var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
				var total =  Round((quantity*uprice) +taxamount);
				document.getElementById("total"+position).value = Round( total );
				calculateTotal();
				assignGrandTotal();
			}
			else
			{
				alert("Quantity Should not be Zero");
				ctr.focus();
			}
		}
		catch(err)
		{
			alert(err);
		}
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




function assignTaxValue(ctr)
	{
		var taxid = document.getElementById(ctr).value;
		if(taxid == "")
		{
			alert("Please Select Tax");
			setOptionValue(ctr,'0');
			//document.getElementById(ctr).focus();
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
	
				
				
				
				

function ValidateBill()
{
		var pamount = parseFloat(document.getElementById('pendingamount').value);
		var camount = parseFloat(document.getElementById('creditamount').value);
		var namount= parseFloat(document.getElementById('nettotal').value);
		 
			if(camount<(pamount+namount)) 
			{
				var tb=document.getElementById("creditdetailerror");
				tb.innerHTML= "<font color='red'><h3><b>This Bill Not Allowed due to Exceed the credit limit    The Credit Limit : "+camount +"  The Pending Amount : "+pamount +" Current Bill Amount : "+namount +"</b></h3></font>";
					return false;
			}
			else
				return true;	
		 
		
}


 

function valid()
{
	try
	{
	
		 if(
			checkNullSelect("customerId","Select Customer","Select")
			&&checkNullSelect("payment","Select Payment","Select")
			&&checkNullSelect("division","Select Division","Select")
			//&& checkNull("oref","Enter Other Reference")
			//&& checkNull("dnote","Enter Delivery Note")
			//&& checkNull("dthru","Enter Despatch Through")
			//&& checkNull("destination","Enter Destination")
			//&& checkNull("tdelivery","Enter Terms of Delivery")
			//&& checkNull("cdetails","Enter Contact Person")
			//&& checkNull("cnumber","Enter Contact Number")
			&& checkNullSelect("installation","Select installation required","0")
			&& checkNullSelect("commitmentdays","Select Payment Commitment days","")
			&& checkNullSelect("project","Select Project","0")
			 
		  )
		  {
		  }
		  else
		  	return false; 
			 
	
	
		display();
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add atleast one item...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}
		var svalue="";
		
		if(document.getElementById('blockinvoice' ).checked == false)
		{
			for(u=0; u<checkArray.length-1;u++)
				if(parseInt(document.getElementById("stock"+checkArray[u]).value)<1)
				{
					alert("Kindly check the stock...");
					document.getElementById("stock"+checkArray[u]).focus();
					//document.getElementById('Submit').disabled=true;
				}
		}
		//else
			//document.getElementById('Submit').disabled=false;	
			
		svalue="";
		for(u=0; u<checkArray.length-1;u++)
			svalue =svalue+"item"+checkArray[u]+","+"qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"stax"+checkArray[u]+","+"total"+checkArray[u]+",";
		var s = "manualsalesinvoicenumber,saleDate,customerId,payment,division,";//
		s = s+svalue+"memo,ref,totals,totaldiscount,tax,salestax,salestaxamount,frieghtcharge,nettotal,";
		var v = s.split(",");
		var flag =false;
		if(
			checkServerDateLock('serverdate','saleDate','serverdatelock')
			&& checkNullSelect("customerId","Select Customer","Select")
			&&checkNullSelect("payment","Select Payment","Select")
			&&checkNullSelect("division","Select Division","Select")
			//&& checkNull("oref","Enter Other Reference")
			//&& checkNull("dnote","Enter Delivery Note")
			//&& checkNull("dthru","Enter Deapatch Through")
			//&& checkNull("destination","Enter Destination")
			//&& checkNull("tdelivery","Enter Terms of Delivery")
			&& checkNull("cdetails","Enter Contact Person")
			&& checkNull("cnumber","Enter Contact Number")
			&& checkNullSelect("installation","Select installation required","0")
			&& checkNullSelect("commitmentdays","Select Payment Commitment days","")
			&& checkNullSelect("project","Select Project","0")
			&& checkNullSelect("ref","Select Sales Reference","")
			&& checkNullSelect("tax","Select Tax","")
			&& checkPercentage()
			&& ValidateBill()
			 
			 
			  
			)
		{	
			for( i=0; i<v.length-1; i++)
			{
				//if(checkfindObject(v[i],v[i]+" not found..."))
				{
					
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
			return false;
		}	
	}
	catch(err)
	{
		//alert(err.description)
		//return false;
	}	
}

	
<%
	String taxid[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax ORDER BY CHR_TAXNAME ");
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
			}	
   		}
   		
	}
	
	
	
	
	function assignGrandTotal()
	{
		try
		{
			calculateTotal();
			var tot = parseFloat(document.getElementById("totals").value);
			var tcsamount = parseFloat(document.getElementById("tcsamount").value);
			 
			
			
			var discount = parseFloat(document.getElementById("totaldiscount").value);
			var discountamount=0.0;
			if(discount>0)
				discountamount= (discount/100)*tot;
			else
				discountamount	=0.0;
				
			tot = tot + tcsamount-	discountamount;	
			//alert(tot);
			var sstax=document.getElementById("salestax").value;
			if(sstax == "" )
				sstax=="0";
			var salestax = parseFloat(sstax);
			var salestaxamount = parseFloat((salestax/100)*tot);
			document.getElementById("salestaxamount").value = salestaxamount.toFixed(2);
			var frieghtcharge = parseFloat(document.getElementById("frieghtcharge").value);
			
			tot = tot+salestaxamount;
			
			document.getElementById("roundedoption").value= (Math.round(tot) - tot).toFixed(2);
			var roundedoption = parseFloat(document.getElementById("roundedoption").value);
			//console.log(roundedoption);
			var grandtotal = Round((tot+roundedoption));
			
			//var grandtotal = Round((tot+salestaxamount+frieghtcharge));
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
				
			if(document.getElementById('roundoffcheck').checked == false)
			{
				var nettotal = parseFloat(document.getElementById("nettotal").value);
				document.getElementById("nettotal").value =  (nettotal-roundedoption) ;
			}
		}
		catch(err) {
			console.log(err);
		}
	}
	
	
	
	
	function checkcreditlimt()
	{
		var customerid = document.getElementById('customerId').value;
		var nettotal = document.getElementById('nettotal').value;
 		var url = "../inventory?actionS=INVCustomerCreditLimit&customerid="+escape(customerid)+"&nettotal="+escape(nettotal);
    	initRequest(url);
		req.onreadystatechange=creditlimtRequest;
    	req.open("GET", url, true);
    	req.send(null);
		var ch = document.getElementById('Creditlimt').value;
		if(ch == "true")
		{
			return true;
		}	
		else
		{
			return false;
		}	
		
	}
	
	function creditlimtRequest() 
 	{
 			if(req.readyState == 4) 
			{    	
				if (req.status == 200) 
				{		  	
				  creditlimtMessages();
				}
			}
	}
	
	
function creditlimtMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Detailss")[0];   
    		var str=""; 
    
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Field1 = batch.getElementsByTagName("Valid")[0].childNodes[0].nodeValue;
			var Field2 = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
			var Field3 = batch.getElementsByTagName("Amount1")[0].childNodes[0].nodeValue;
			if(Field1 == "False")
			{
			alert("Not Allowed Billing, Please collect the outstanding amount  (Outstanding :: "+Field2+"  / Bill : "+Field3+")");	
			document.getElementById('Creditlimt').value = "false";
			}
			else
				document.getElementById('Creditlimt').value = "true";
			
		}
	 	
	
}


function AssignShippingAddress()
{
	try
	{
		var customerId = document.getElementById('customerId').value;
		setOptionValue('shippingCustomerId',customerId);
	}
	catch(err) {
		console.log(err);
	}
}

function calculateDiscountAmount(ctr)
{
	var position = ctr.replace("qty","");	
	
	var uprice = document.getElementById('uprice'+position).value;
	var unitdiscount = document.getElementById('unitdiscount'+position).value;
	//Discount %= (Discount/MRP)*100
	discount = (unitdiscount/uprice)*100
	document.getElementById('discount'+position).value=discount;
	
	
	var quantity = document.getElementById('qty'+position).value;
	if(quantity>=1)
	{ 
		uprice = uprice - udiscount;
		var staxpercentage = parseFloat(document.getElementById("staxpercentage"+position).value);
		document.getElementById("staxamount"+position).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
		var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
		var total =  Round((quantity*uprice) +taxamount);
		document.getElementById("total"+position).value = Round( total );
		calculateTotal();
		assignGrandTotal();
	}
	else
	{
		alert("Quantity Should not be Zero");
		ctr.focus();
	}
}


--></script>
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
							<div align="center"><strong> Sale Add 
							</strong></div>							</td>
						</tr>
						<tr>
							<td>
							
							
							
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
								  <td width="318" class="boldEleven"><div align="left">CustomerName <span class="ui-state-error-text">* </span></div>									  </td>
									<td width="415" class="boldEleven">
                                      
                                      <div align="left">
                                          
                                        <%
			String ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) ,a.CHR_DEPARTYMENT,a.CHR_ADDRESS1, a.CHR_ALIASNAME ALIASNAME FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y'  ORDER BY f.CHR_NAME";
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
			
			String CreditLimitData =  CommonFunctions.QueryExecute("SELECT CHR_CUSTOMERCREDITLIMIT FROM  m_inventorysetting WHERE INT_ROWID=1")[0][0];
			String climit="";
			if("Y".equals(CreditLimitData))
				climit=" onblur=\"LoadCreditLimt('customerId','creditdetail','C')\" ";
			else
				climit="   ";	
			%>
<select name="customerId" id="customerId" class="formText135"   onchange="loadAddress('customerId','shippingaddress') " onBlur="LoadCreditAmount('customerId'),AssignShippingAddress()"  <%=climit%>  style="width:170">
  <option value="Select">Select</option>
  <%
for(int y=0;y<custData.length;y++)
	out.println("<option  style='height:20'  value='"+custData[y][0]+"'>"+custData[y][1]+ "  / "+custData[y][12]+ "  / "+custData[y][3]+ "  / "+custData[y][4]+ "</option>");	
	//+/"  "+custData[y][10]+"/"+custData[y][11]+"/" 
%>
</select>
                                      <input name="pendingamount" type="hidden" id="pendingamount" value="0" />
                                      <input name="creditamount" type="hidden" id="creditamount" value="0" />
									  <input name="gststateid" type="hidden" id="gststateid">
                                  </div></td>
									<td width="289" class="boldEleven">
									<%
									if(inventorysettingData[0][0].equals("M"))
									{
										out.println("Sales Invoice No  : <b class='boldred'>Manual</b>");
									}
									else
									{
									out.println("Sales Invoice No  : <b class='boldred'>Automatic</b>");
									}
									%>
									</td>
									<td width="420" class="boldEleven">
									<%
									if(inventorysettingData[0][0].equals("M"))
									{
									%>
									<input name="manualsalesinvoicenumber" type="text" value=""
										class="formText135" id="manualsalesinvoicenumber"
										    onBlur="upperMe(this)"  size="31" maxlength="50"  onKeyUp=CheckUnique(this,'divsalesinvoicenumber','inv_t_directsales','CHR_SALESNO')><div id='divsalesinvoicenumber'></div>
											
									<%
									}
									else
									{
									 out.println("<input name='manualsalesinvoicenumber' type='hidden'  id='manualsalesinvoicenumber' value='"+inventorysettingData[0][1]+"'/>");
									}
									
									%>
									</td>
								</tr>
								<tr>
								  <td class="boldEleven"><div align="left">Shipping Address</div></td>
								  <td class="boldEleven">
								    <div align="left">
								      <table width="141" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td ><input name="Shipping" type="radio"
												value="S" onClick="return resoffval()" /></td>
                                          <td class="boldEleven">Same</td>
                                          <td class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D" checked="checked" /></td>
                                          <td class="boldEleven">Different
                                          <input name="shipadd" type="hidden" id="shipadd"></td>
                                        </tr>
                                      </table>
						          </div></td>
									<td class="boldEleven"><div align="left">Sale Date</div></td>
									<td class="boldEleven"><div align="left">
                                      <input tabindex="2" name="saleDate" value="<%=dateCheckData[0][0]%>" type="text" class="formText135" id="saleDate" size="15" readonly>
                                    </div></td>
								</tr>
								<tr>
								  <td rowspan="6" valign="top" class="boldEleven">&nbsp; </td>
								  <td rowspan="6" valign="top" class="boldEleven">								      
								    <div align="left">
								      <table>
								        <tr>
								          <td>
								            <select name="shippingCustomerId" id="shippingCustomerId" class="formText135"   onchange="loadAddress('shippingCustomerId','shippingaddress') "  style="width:170">
								              <option value="Select">Select</option>
								              <%
												for(int y=0;y<custData.length;y++)
													out.println("<option  style='height:20'  value='"+custData[y][0]+"'>"+custData[y][1]+ "  / "+custData[y][3]+ "  / "+custData[y][4]+ "</option>");	
													 
											%>
							                </select>								            </td>
									    </tr>
								        <tr>	
								          <td><textarea name="shippingaddress" style="text-transform:uppercase;width:170;"
										cols="40" rows="7" class="formText135" id="shippingaddress"  ></textarea></td>
									    </tr>
							          </table>
							        </div></td>
								  <td class="boldEleven"><div align="left">Payment Terms<span class="ui-state-error-text"> * </span></div></td>
								  <td class="boldEleven"><div align="left">
                                    <select name="payment"
										class="formText135" id="payment" tabindex="3"  style="width:170">
                                      <option value="Select">Select</option>
                                      <%
								String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
                                    </select>
                                  </div></td>
							  </tr>
								<tr>
								  <td class="boldEleven">
								    <div align="left">Order Reference</div></td>
									<td class="boldEleven"><div align="left">
									  <input name="oref" type="text"
										class="formText135" id="oref"     onBlur="upperMe(this)"      value="ORAL" size="31" maxlength="100"
										 />
									  
									   								
							      </div></td>
								</tr>
								<tr>
									<td class="boldEleven">
									  <div align="left">Delivery Note</div></td>
									<td class="boldEleven"><div align="left">
									  <input name="dnote" type="text"
										class="formText135" id="dnote"
										    onBlur="upperMe(this)"     value="NIL" size="31" maxlength="100" />
							      </div></td>
								</tr>
								<tr>
									<td class="boldEleven">
									  <div align="left">Despatch Through</div></td>
									<td class="boldEleven"><div align="left">
									  <input name="dthru" type="text"
										class="formText135" id="dthru"
										    onBlur="upperMe(this)"     value="INTERNAL COURIER" size="31" maxlength="100" />
							      </div></td>
								</tr>
								<tr>
									<td class="boldEleven">
									  <div align="left">Destiantion</div></td>
									<td class="boldEleven"><div align="left">
									  <input name="destination"
										type="text" class="formText135" id="destination"     onBlur="upperMe(this)"    value="CHENNAI"   size="31"
										maxlength="100" />
							      </div></td>
								</tr>
								<tr>
									<td class="boldEleven">
									  <div align="left">Terms of Delivery</div></td>
									<td class="boldEleven"><div align="left">
									  <input name="tdelivery" type="text"
										class="formText135" id="tdelivery"
										    onBlur="upperMe(this)"     value="IMMEDIATE" size="31" maxlength="100" />
							      </div></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><div align="left">Division <span class="ui-state-error-text">* </span></div></td>
								  <td valign="top" class="boldEleven"><div align="left">
                                    <select
										name="division" class="formText135" id="division" tabindex="1" style="width:170">
                                      <option value='Select'>Select</option>
                                      <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE,CHR_DEFAULT"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                    </select>
									<strong><script>setOptionValue('division',"<%=division[0][0]%>");</script></strong>
                                    <input name="noofpaymentcommitment" type="hidden" id="noofpaymentcommitment" value="1">
                                  </div>						            </td>
									<td class="boldEleven">
									  <div align="left">Contact Person <span class="ui-state-error-text">* </span></div></td>
									<td class="boldEleven"><div align="left">
									  <input name="cdetails" type="text"
										class="formText135" id="cdetails"
										    onBlur="upperMe(this)"  size="31" maxlength="100" />
							      </div></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">Payment Commitment Days <span class="ui-state-error-text">* </span></td>
									<td valign="top" class="boldEleven"><select name="commitmentdays" class="formText135" id="commitmentdays" style="width:170">
                                      <option value="">Select Payment commitment Days</option>
                                      <option value="0">Advance Amount</option>
                                      <%
								  for(int u=1;u<=60;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                                    </select>
									<script language="javascript">setOptionValue('commitmentdays','30')</script>									</td>
									<td class="boldEleven">
									  <div align="left">Contact No. <span class="ui-state-error-text">* </span></div></td>
									<td class="boldEleven"><div align="left">
									  <input name="cnumber" type="text"
										class="formText135" id="cnumber" onKeyPress="return numeric_only(event,'cnumber','15')" size="31" maxlength="14"/>
							      </div></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">Installation / Implementation Required  <span class="ui-state-error-text">* </span></td>
								  <td valign="top" class="boldEleven">
								  
								  <select name="installation" class="formText135" id="installation" style="width:170">
                                      <option value="0">Select Installation / Implementation Required </option>
                                      <option value="Y">Yes</option>
									  <option value="N" selected="selected">No</option>
                                    </select>								  </td>
								  <td class="boldEleven">Project <span class="boldred">*</span></td>
								  <td class="boldEleven"><select name="project"
							class="formText135" id="project"   style="width:170"
							 >
                                    <option value='0'>Select</option>
                                    <%
								String project[][] =  CommonFunctions.QueryExecute("SELECT INT_PROJECTID,CHR_PROJECTNAME FROM inv_m_project WHERE CHR_STATUS='Y' ORDER BY CHR_PROJECTNAME,CHR_DEFAULT "); 
								for(int u=0; u<project.length; u++)
									out.print("<option value='"+project[u][0]+"'>"+project[u][1]  +"</option>");
							%>
                                  </select><script>setOptionValue('project',"<%=project[0][0]%>");</script></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Block Invoice</td>
								  <td valign="top" class="boldEleven"><input name="blockinvoice" type="checkbox" id="blockinvoice" value="Y">
								    <span class="boldred">( if it is tick then the stocks not checked ) </span></td>
								  <td valign="top" class="boldEleven">D.C. Reference </td>
								  <td valign="top" class="boldEleven"><input name="dcref" type="text"
										class="formText135" id="dcref"     onBlur="upperMe(this)"      value="ORAL" size="31" maxlength="100"
										 /></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Tax Type </td>
								  <td valign="top" class="boldEleven"><input name="taxtype" id="taxtype" type="hidden" value="S">
								  <!--<select name="taxtype" class="formText135" id="" style="width:170" >
								  	<option value="">Single Tax</option>
								  	<option value="M" selected="selected">Multi Tax</option>
								  </select>	 onChange="taxTypeSelect()" readonly ="readonly"-->								  </td>
								  <td valign="top" class="boldEleven">Dicount Bill </td>
								  <td valign="top" class="boldEleven"><input name="discountbill" type="checkbox" id="discountbill" value="Y"></td>
							  </tr>
							</table>							</td >
						</tr>
						<tr>
							<td height="9">
							<div id="creditdetail"> </div>
							<div id="creditdetailerror"> </div>
							
							<div id="divscroll" style="OVERFLOW:auto;width:auto;height:300px">
							  <table width='100%' border="0"     cellpadding=2 cellspacing=1 bgcolor="#f0f0f0"  class='boldEleven'  id='myTable' >
                                <tr class="MRow1">
                                  <th class="boldEleven"> <div align="left"><strong>Type</strong></div></th>
                                  <th class="boldEleven"><b>Item</b></th>
                                  <th class="boldEleven"><b>Description</b></th>
                                  <th class="boldEleven"><strong>Stock </strong></th>
                                  <th class="boldEleven"><b>Quantity/Units</b></th>
                                  <th class="boldEleven"><b>Warranty</b></th>
                                  <th class="boldEleven"><b>Unit Price</b></th>
                                  <th class="boldEleven"><b>Discount(%)</b></th>
                                  <th class="boldEleven"><b>Unit Discount</b></th>
                                  <th class="boldEleven"><b>Tax</b></th>
                                  <th class="boldEleven"><b>Tax (%)</b></th>
                                  <th class="boldEleven"><b>Tax Amount </b></th>
                                  <th class="boldEleven"><b>Total</b></th>
                                  <th class="boldEleven"><b>Swap</b></th>
                                  <th class="boldEleven">&nbsp;</th>
                                  <th class="boldEleven">&nbsp;</th>
                                  <th class="boldEleven" style="width:60">&nbsp;</th>
                                </tr>
                              </table>
							</div>							</td>
						</tr>
						<tr>
							<td>
							<div align="left"><input id="buttonitemadd" type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8" /></div>							</td>
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
							</table>							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<div id="productlist"></div>							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="310" rowspan="5" valign="top" class="boldEleven">
								  <div align="left">Memo <span class="ui-state-error-text">* </span></div>									</td>
									<td width="432" rowspan="5" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="30"    onBlur="upperMe(this)"   
										rows="5" onKeyUp="textArea('memo','200')"  class="formText135" id="memo" tabindex="9"></textarea>
								  </div>									</td>

									<td width="324" valign="top" class="boldEleven">
								  <div align="left">Total</div>									</td>
									<td width="376" valign="top" class="boldEleven" id="totals1">

								  <div align="left"><input name="totals" type="text"
										class="formText135" id="totals"
										style='text-align:right' tabindex="11"
										onkeypress="numericValue('totals','12')" size="34" readonly />
								  </div>									</td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><input type="checkbox" name="tcs" id="tcs" value="Y" onClick="byTCS()">&nbsp;&nbsp;TCS @ 0.1% 
								 
								  <script language="javascript">
								  function byTCS()
								  {
								  		var tcsamount =0; 
										if(document.getElementById('tcs').checked == true)
										{
										 	tcsamount = document.getElementById("totals").value * (0.1/100);
										}
										else
										{
											tcsamount =0; 
										}
										
										document.getElementById("tcsamount").value = parseFloat( tcsamount).toFixed(2);
										// onBlur="assignGrandTotal()"
										assignGrandTotal();
								
								  }
								  
								  </script><input type="hidden" name="tcspercentage" id="tcspercentage" value="0.01" />
								  
							      </td>
								  <td valign="top" class="boldEleven" ><input name="tcsamount"
										type="text" class="formText135" id="tcsamount" style='text-align:right' tabindex="14" value="0" size="34"
										readonly="readonly" /></td>
							  </tr>
								<tr>
									<td valign="top" class="boldEleven">
									<%--<div align="left">Total Discount (%)</div>		--%>							</td>
									<td width="376" valign="top" class="boldEleven"
										id="totaldiscount1">
								  <%--<div align="left"><input
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount"  
										style='text-align:right' tabindex="12" onBlur="assignGrandTotal()" value="0" size="34" maxlength="5" />
								  </div>--%>									<input type="hidden" name="totaldiscount" id="totaldiscount" value="0" /></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<%--<div align="left">Tax Group <span class="ui-state-error-text">* </span></div>--%>									</td>
									<td width="376" valign="top" class="boldEleven" id="tax1">
								  <%--<div align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13"  style="width:170">
										 
										<%=optiontaxname%>
								  </select></div>	--%>								<input type="hidden" name="tax" id="tax" value="1" /></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">TDS (%)</div>									</td>
									<td width="376" valign="top" class="boldEleven" id="salestax1">
								  <div align="left"><input name="salestax"
										type="text" class="formText135" id="salestax" style='text-align:right' tabindex="14" value="0" size="34" onBlur="assignGrandTotal()"/>
								  </div>									<!--<input type="hidden" name="salestax" id="salestax" value="0" />--></td>
								</tr>
								<tr>
									<td align="left" valign="top" class="boldEleven">Added ME Name 
								    <input name="addmetarget" type="checkbox" id="addmetarget" value="Y"  /></td>
									<td align="left" valign="top" class="boldEleven">&nbsp;</td>
									<td valign="top" class="boldEleven">
									<div align="left">TDS Amount</div>									</td>
									<td valign="top" class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount"
										type="text" class="formText135" id="salestaxamount" style='text-align:right' tabindex="14" value="0" size="34"
										readonly="readonly" />
									</div>									<!--<input type="hidden" name="salestaxamount" id="salestaxamount" value="0" />--></td>
								</tr>
								<tr>
								  <td align="left" valign="top" class="boldEleven">Buy Back Value 
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
								  
								  </script></td>
								  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								<tr id="bybackrow">
								  <td align="left" valign="top" class="boldEleven">Buy Back Description </td>
								  <td align="left" valign="top" class="boldEleven"><textarea name="bybackdescription" cols="30"
										rows="5" class="formText135" id="bybackdescription" tabindex="9"></textarea></td>
								  <td align="left" valign="top" class="boldEleven">Buy Back Amount </td>
								  <td align="left" valign="top" class="boldEleven" id="nettotal1"><input name="bybackamount" type="text" 
										class="formText135" id="bybackamount" style='text-align:right' onBlur="assignGrandTotal()" onKeyPress="numericValue('bybackamount','12')" value="0" size="34" maxlength="12"/></td>
							  </tr>
								<tr id="bybackrow">
								  <td colspan="4" align="left" valign="top" class="boldEleven"><table width="100%" border="0" cellspacing="3" cellpadding="3">
                                    <tr>
                                      <td width="21%" align="left" valign="top" class="boldEleven">Sale Reference 1 </td>
                                      <td width="30%" align="left" valign="top" class="boldEleven"><select name="ref" id="ref" class="formText135" size="5" style="width:250">
                                          <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select></td>
                                      <td width="23%" align="left" valign="top" class="boldEleven">Percentage</td>
                                      <td width="26%" align="left" valign="top" class="boldEleven"><select name="percentage" id="percentage" class="formText135" style="width:50">
                                         
										  <jsp:include page="Slaereppercentage.jsp" flush="true" />                                  
                                      </select><script language="javascript">setOptionValue('percentage','100')</script>                                      </td>
                                    </tr>
                                    <tr>
                                      <td align="left" valign="top" class="boldEleven">Sale Reference 2 </td>
                                      <td align="left" valign="top" class="boldEleven">
									  <select name="ref1" id="ref1" class="formText135" size="5" style="width:250">
									  <option value="0" selected="selected">No Reference</option>
                                          <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select></td>
                                      <td align="left" valign="top" class="boldEleven">Percentage</td>
                                      <td align="left" valign="top" class="boldEleven">
									  <select name="percentage1" id="percentage1" class="formText135"   style="width:50">
									  
                                          <jsp:include page="Slaereppercentage.jsp" flush="true" />                                  
                                      </select><script language="javascript">setOptionValue('percentage1','0')</script></td>
                                    </tr>
                                    <tr>
                                      <td align="left" valign="top" class="boldEleven">Sale Reference 3 </td>
                                      <td align="left" valign="top" class="boldEleven"><select name="ref2" id="ref2" class="formText135" size="5"   style="width:250">
                                          <option value="0" selected="selected">No Reference</option>
										  <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select></td>
                                      <td align="left" valign="top" class="boldEleven">Percentage</td>
                                      <td align="left" valign="top" class="boldEleven"><select name="percentage2" id="percentage2" class="formText135"   style="width:50">
                                          <jsp:include page="Slaereppercentage.jsp" flush="true" />                                  
                                      </select><script language="javascript">setOptionValue('percentage2','0')</script></td>
                                    </tr>
                                  </table>								    <p>&nbsp;</p></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven"><!--Freight Charge <span class="boldred"> *</span>-->
							      Rounded <span class="boldred"> *
							      <input name="frieghtcharge" type="hidden"
										class="formText135" id="frieghtcharge"
										style='text-align:right' tabindex="15"  onBlur="assignGrandTotal()" onKeyPress="return numeric_only(event,'frieghtcharge','7') " value="0" maxlength="5" />
							      <input name="roundoffcheck" type="checkbox" id="roundoffcheck" onClick="Roundoffcheck()" value="Y" checked>
								  <script language="javascript">
								  function Roundoffcheck()
								  {
								  		 
									 
										assignGrandTotal();
								
								  }
								  
								  </script>
							      </span></td>
								  <td class="boldEleven" id="nettotal1"><input name="roundedoption" type="text"
										class="formText135" id="roundedoption"
										style='text-align:right' tabindex="15"  onBlur="assignGrandTotal()" onKeyPress="return numeric_priceonly(event,'roundedoption','12') " value="0" size="34" maxlength="5" /></td>
							  </tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">
									  <input name="filename"
										type="hidden" value="SwapSale" /> <input name="actionS"
										type="hidden" value="INVSwapSaleAdd" /> <input name="param"
										type="hidden" id="param" value='0,' />
									  <input name="Creditlimt" type="hidden" id="Creditlimt" value="false" />
									   
									  <input name="serverdate" type="hidden" id="serverdate" value="<%=dateCheckData[0][0]%>" />
									  <input name="serverdatelock" type="hidden" id="serverdatelock" value="<%=dateCheckData[0][1]%>" />
									</div>									</td>
									<td class="boldEleven">
									<div align="left"></div>									</td>
								    <td class="boldEleven"><div align="left" class="bold1">Net Total</div></td>
								    <td class="boldEleven" id="nettotal1"><div align="left">
								      <input name="nettotal" type="text"
										class="formText135" id="nettotal" readonly
										style='text-align:right' tabindex="15" value="0" size="34" />
                                    </div></td>
								</tr>
								<tr>
								  <td colspan="2" valign="top" class="boldEleven">&nbsp;</td>
							      <td class="boldEleven">&nbsp;</td>
							      <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven"></td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal1">&nbsp;</td>
							  </tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit"  id="Submit"  type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"      />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onclick="redirect('SwapSale.jsp')" /></div>
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>									</td>
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
 
 <script language="javascript">
 

function taxTypeSelect()
{
	var type = document.getElementById('taxtype').value;
	
	
	if(type =="S")
	{
		display();
   		for(u=0; u<checkArray.length-1;u++)
   		{	 
			document.getElementById("stax"+checkArray[u]).disabled =  true;
			document.getElementById("tax").disabled =  false;		
			setOptionValue("stax"+checkArray[u],'1');
			setOptionValue("tax" ,'1');
	 	}
	}
	else
	{
		display();
   		for(u=0; u<checkArray.length-1;u++)
   		{	 
			document.getElementById("stax"+checkArray[u]).disabled =  false;
			document.getElementById("tax").disabled =  true;	
			setOptionValue("tax" ,'1');	
		}
	}
	
	calculateTotal();
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



 
 </script>
 
 
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 System.out.println(e.getMessage());
 }
%>
</body>
</html>
