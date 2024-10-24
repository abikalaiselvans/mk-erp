<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<%
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

<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	
$(function() {
		$( "#reqDate" ).datepicker({ 
		minDate: -0, maxDate: "+30D" ,
			defaultDate: "+1w",
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true 
			
		});
	});
 

</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">






<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>

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
	    	Price= batch.getElementsByTagName("Price")[0];
			Ptype= batch.getElementsByTagName("Ptype")[0];
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).value = "1";
			document.getElementById("uprice"+idposition).value = Price.childNodes[0].nodeValue;
			document.getElementById("discount"+idposition).value ="0";
			document.getElementById("unitdiscount"+idposition).value = "0";
			document.getElementById("consumables"+idposition).value =  Ptype.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).focus();
			totals1.style.visibility="visible";
			totaldiscount1.style.visibility="visible";
			tax1.style.visibility="visible";
			salestax1.style.visibility="visible";
			salestaxamount1.style.visibility="visible";
			nettotal1.style.visibility="visible";
			 
   }
   calculateTotal();
   assignGrandTotal();
    
 }
</script>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>




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
		
		totals1.style.visibility="hidden";
		totaldiscount1.style.visibility="hidden";
		tax1.style.visibility="hidden";
		salestax1.style.visibility="hidden";
		salestaxamount1.style.visibility="hidden";
		nettotal1.style.visibility="hidden";
		//loadCustomer();
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
		
		
		var s10 = "stax"+r;
		var s11 = "staxpercentage"+r;
		var s12 = "staxamount"+r;
		var s13 = "warranty"+r;
		
		
		var div ="div"+r;
		
		var vf1 = "onKeyPress=\" return numeric_only(event,'"+s3+"','15') \"";
		var vf2 = "onKeyPress=\" return numeric_only(event,'"+s4+"','15') \"";
		var vf3 = "onKeyPress=\" return numeric_only(event,'"+s5+"','15') \"";
		var vf4 = "onKeyPress=\" return numeric_only(event,'"+s6+"','15') \"";
		var vf5 = "onKeyPress=\" return numeric_only(event,'"+s7+"','15') \"";
		
		 
		
		//onKeyPress="return numeric_only(event,'ppincode','8'),fill()"
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10 maxlength='100'  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10 value='1'    onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" style='text-align:right' maxlength='4' />";
		x.insertCell(4).innerHTML="<input type='text' size=10  value='0'   onblur='calculatePrice(this)' title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  style='text-align:right' maxlength='10' />";
		x.insertCell(5).innerHTML="<input type='text' size=10    onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  style='text-align:right'  maxlength='3' />";
		x.insertCell(6).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly' style='text-align:right'  maxlength='3' />";
		
		x.insertCell(7).innerHTML="<select class='formText135'   style='width:100'  name='"+s13+"' id ='"+s13+"'   ><%=warrantyinsert%></select>";
		
		
		x.insertCell(8).innerHTML="<select class='formText135'   style='width:100'  name='"+s10+"' id ='"+s10+"' onBlur=assignTaxValue('"+s10+"') ><%=optiontaxname%></select>";
		x.insertCell(9).innerHTML="<input type='text' size=10 class='formText135'  name='"+s11+"' id ='"+s11+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(10).innerHTML="<input type='text' size=10 class='formText135'  name='"+s12+"' id ='"+s12+"'  readonly='readonly' style='text-align:right' value='0'/>";
		
		
		
		
		x.insertCell(11).innerHTML="<input type='text' size=10    title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly' style='text-align:right'/>";
		x.insertCell(12).innerHTML="<input type='hidden' name='"+s8+"' id ='"+s8+"' /><input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
		
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
  		assignTaxValue("stax"+qtyposition);
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
  		assignTaxValue("stax"+priceposition);
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
  		assignTaxValue("stax"+descposition);
		calculateTotal();
  		assignGrandTotal();
		
	}





function assignTaxValue(ctr)
	{
 		var taxid = document.getElementById(ctr).value;
		if(taxid == "")
		{
			//alert("Please Select Tax");
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
			if(Array1[v]!= "")
				hs2 = hs2 +	Array1[v]+",";
				
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		
		//alert("Added :: \n"+hs+"\n\n\n Deleted :: \n"+hs1+"\n\nChecked \n"+hs2);
	}
	//**********************************


	function paramAssign(svalue)
	{
		document.getElementById(param).value=svalue;
	}

	function valid()
	{
		 
		
		if(
			 checkNullSelect("customerId","Select Customer","Select")
			&& checkNull("quoDate","Enter Proforma date")
			&& checkNull("reqDate","Enter Request date")
			&& checkNull("order","Enter Order from")
			&& checkNull("ship","Enter Shipping to")
			&& checkNullSelect("payment","Select Payment","Select")
			&& checkNullSelect("division","Select Division","Select")
			&& checkNull("cdetails","Enter Contact Person")
			&& checkNull("cnumber","Enter Contact Number")
			&& checkNull("oref","Enter Order reference")
			
		)
		{
		}
		else
			return false;
			
		display();
   		var svalue="";
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Add atleast one item...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}	
   		for(u=0; u<checkArray.length-1;u++)
   			svalue =svalue+"item"+checkArray[u]+","+"qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+"," +"stax"+checkArray[u]+","   +"total"+checkArray[u]+",";
   		var s = "customerId,quoDate,reqDate,order,ship,payment,division,cdetails,cnumber,memo,ref,";
   		s = s+svalue+"totals,totaldiscount,tax,salestax,nettotal,";
		 
		 
		//paramAssign(s);
		var v = s.split(",");
   		var flag =false;
		
		//if(checkDate('quoDate','reqDate'))
		
			for( i=0; i<v.length-1; i++)
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
	}
<%
	String taxid[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
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
		
		var grandtotal = (tot+salestaxamount);
		document.getElementById("nettotal").value=(grandtotal).toFixed(2);	
	}
	
	
	function assignAddress()
	{
		if(document.getElementById('copyaddress').checked)
			document.getElementById('ship').value= document.getElementById('order').value;
		else
			document.getElementById('ship').value="";
	}
--></script>
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
		<table width="900" border="0"
			align="center" cellpadding="0" cellspacing="0" class="BackGround1">
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
							<td height="38" align="center" valign="top"><div align="center" class="bold1">
							  <div align="center">PROFORMA </div>
						  </div></td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="151" height="14" valign="top" class="boldEleven">Customer
									<span class="ui-state-error-text"> * </span></td>
									<td width="201" class="boldEleven">
									
									
                                      <div align="left">
                                          
                                        <%
			String ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y'  ORDER BY f.CHR_NAME";
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
 			%> 
<select name="customerId" id="customerId" class="formText135"   onchange="loadAddress('customerId','order') "  style="width:170">
  <option value="Select">Select</option>
  <%
for(int y=0;y<custData.length;y++)
	out.println("<option  style='height:20'  value='"+custData[y][0]+"'>"+custData[y][1]+" / "+custData[y][3]+ "  / "+custData[y][4]+ "</option>");	
%>
</select>
							      </div>									</td>
								    <td width="107" rowspan="3" valign="top" class="boldEleven">Order From<span class="ui-state-error-text"> * </span></td>
								    <td width="201" rowspan="3" align="left" valign="top" class="boldEleven"><textarea name="order" cols="25" rows="5" class="formText135" id="order" onKeyPress="textArea('order','450')"></textarea></td>
								</tr>
								<tr>
								   
							  </tr>
								<tr>
									<td height="14" valign="top" class="boldEleven">Proforma Date<span class="ui-state-error-text"> * </span></td>
									<td class="boldEleven"><input name="quoDate" type="text"
										class="formText135" id="quoDate" size="15" readonly />
								    <script language='JavaScript'
										type="text/javascript">
		<!--			
				 
				setCurrentDate('quoDate'); 
		//-->
                          </script></td>
							    </tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Request Date<span class="ui-state-error-text"> * </span></div>									</td>
									<td class="boldEleven">
									<div align="left"><input name="reqDate" type="text"
										class="formText135" id="reqDate" size="15" readonly />
								    <script language='JavaScript'
										type="text/javascript">
						  <!--			
				 
				setCurrentDate('reqDate'); 
		//-->
		                  </script></div>									</td>
									<td valign="top" class="boldEleven">Shipping To <span class="ui-state-error-text"> * </span>
								    <input
										name="copyaddress" type="checkbox" id="copyaddress"
										value="Y" onClick="assignAddress()"></td>
									<td rowspan="3" class="boldEleven">
									<div align="left"><textarea name="ship" cols="25"
										rows="5" class="formText135" id="ship"  onKeyPress="textArea('ship','450')"></textarea></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Payment Terms<span class="ui-state-error-text"> * </span></td>
									<td class="boldEleven"><select name="payment"
										class="formText135" id="payment"  style="width:170">
										<%
								String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
									</select></td>
									<td valign="top" class="boldEleven">&nbsp;</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">On Hold<span class="ui-state-error-text"> * </span></td>
									<td class="boldEleven"><input name="hold" type="checkbox"
										id="hold" value="Y" /></td>
									<td valign="top" class="boldEleven">&nbsp;</td>
								</tr>
								<tr>
								  <td class="boldEleven"><div align="left">Contact Person<span class="ui-state-error-text"> * </span></div></td>
								  <td class="boldEleven"><div align="left">
                                      <input name="cdetails" type="text"
										class="formText135" id="cdetails"
										    onBlur="upperMe(this)" size="35" maxlength="50"     />
                                  </div></td>
								  <td valign="top" class="boldEleven"><div align="left">Division<span class="ui-state-error-text"> * </span></div></td>
								  <td valign="top" class="boldEleven"><div align="left">
                                      <select
										name="division" class="formText135" id="division"   style="width:170">
                                        <option value='Select'>Select</option>
                                        <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                      </select>
                                       
                                  </div></td>
							  </tr>
								<tr>
								  <td class="boldEleven"><div align="left">Contact No.<span class="ui-state-error-text"> * </span></div></td>
								  <td class="boldEleven"><div align="left">
                                      <input name="cnumber" type="text"
										class="formText135" id="cnumber"
										    onBlur="upperMe(this)"     onKeyPress="return numeric_only(event,'cnumber','15') " size="35" maxlength="12"/>
                                  </div></td>
							      <td class="boldEleven">Order
								  Reference <span class="ui-state-error-text"> * </span></td>
							      <td class="boldEleven"><input name="oref" type="text"
										class="formText135" id="oref"     onBlur="upperMe(this)"      value="ORAL" size="31" maxlength="100"
										 /></td>
							  </tr>
								<tr>
								  <td colspan="2" class="boldEleven">&nbsp;</td>
							      <td class="boldEleven">&nbsp;</td>
							      <td class="boldEleven">&nbsp;</td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="1" cellpadding="2" cellspacing="2"	id="myTable">
								<tr>
									<th class="boldEleven">
									<div align="left"><strong>Type</strong></div>
									</th>
									<th class="boldEleven"><b>Item</b></th>
									<th class="boldEleven"><b>Description</b></th>
									<th class="boldEleven"><b>Quantity</b></th>
									<th class="boldEleven"><b>Unit Price</b></th>
									<th class="boldEleven"><b>Discount(%)</b></th>
									<th class="boldEleven"><b>Unit Discount</b></th>
									<th class="boldEleven"><b>Warranty</b></th>
									
									<th class="boldEleven"><b>Tax</b></th>
									<th class="boldEleven"><b>Tax (%)</b></th>
									<th class="boldEleven"><b>Tax Amount </b></th>
								
								
									<th class="boldEleven"><b>Total</b></th>
									<th class="boldEleven"><b>&nbsp;</b></th>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div id="divscroll"
								style="OVERFLOW:auto;width:100%;height:100px">
							<table width="770" border="0" bordercolor="#EFEFEF"
								cellpadding="1" cellspacing="1" id="myTable">
								<td width="200px"></td>
								<td width="150px"></td>
								<td width="75px"></td>
								<td width="75px"></td>
								<td width="100px"></td>
								<td width="100px"></td>
								<td width="54px"></td>
								<td width="54px"></td>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left"><input type="button" id="buttonitemadd"
								class="tMLAscreenHead" onClick="insRow()" value="Add">
							</div>
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
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description<span class="ui-state-error-text"> * </span></div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo"></textarea></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input name="totals" style="text-align:right"
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly /></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input name="totaldiscount" type="text"
										class="formText135" id="totaldiscount"  style="text-align:right" onKeyPress="return numeric_only(event,'totaldiscount','15')"
										onblur="assignGrandTotal()" value="0" maxlength="6"></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group<span class="ui-state-error-text"> * </span></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left">
<select name="tax" class="formText135" id="tax" onChange="assignTotals(this)"  style="width:120">
										<option value="">Select</option>
										<%
								String taxidss[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
								for(int u=0; u<taxidss.length; u++)
									out.print("<option value='"+taxidss[u][0]+"'>"+taxidss[u][1]+"</option>");
							%>
									</select></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><input name="salestax"  style="text-align:right" value="0"
										type="text" class="formText135" id="salestax"
										readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Reference <span class="ui-state-error-text"> * </span>
									  <input name="filename"
										type="hidden" value="Proforma" /> <input name="actionS"
										type="hidden" value="INVProformaAdd" /> <input name="param"
										type="hidden" id="param" value='0,'></div>
								  </td>
									<td class="boldEleven">
									<div align="left">
										<select name="ref" id="ref" class="formText135" size="5" style="width:150">
												<jsp:include page="Staffload.jsp" flush="true" />
										</select>
									</div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount"  style="text-align:right" value="0"
										type="text" class="formText135" id="salestaxamount"
										readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left">Net Total</div>
									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal"  style="text-align:right" type="text" readonly
										class="formText135" id="nettotal" value="0" /></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"      />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onclick="redirect('Proforma.jsp')"  />
									 </div>
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
