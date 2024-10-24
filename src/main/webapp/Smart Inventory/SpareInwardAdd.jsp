<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
 		
<%
try
{
String taxids[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax ORDER BY CHR_TAXNAME");
String optiontaxname="<option value=''>Select Tax</option>";
for(int u=0; u<taxids.length; u++)
	optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";

String spareids[][] = CommonFunctions.QueryExecute("Select INT_SPAREID,CHR_SPARENAME from inv_m_spare ORDER BY CHR_SPARENAME");
String optionsparename="<option value=''>Select Spare</option>";
for(int u=0; u<spareids.length; u++)
	optionsparename =optionsparename+"<option value='"+spareids[u][0]+"'>"+spareids[u][1]+"</option>";

%>

<head>

<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>





<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDetails.js"></script>
<script>
 

$(function() {
		$( "#saleDate" ).datepicker({ minDate: -7, maxDate: "+7D" });
	});
 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">








<script type="text/javascript">
var divi="";
function assignValues(ctr,pos) 
{
	var spareid = ctr.value;
	divi =pos;
	var url = "../Spare?actionS=LoadSpareAssign&spareid="+spareid ;
	initRequest(url);
	req.onreadystatechange = SpareAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SpareAssignRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	SpareAssignMessages();
        }
    }
}

function SpareAssignMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Assigns")[0];   
   	var idposition = divi;
	s1 ='spare'+idposition;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	Desc= batch.getElementsByTagName("Desc")[0];
	    	Price= batch.getElementsByTagName("Price")[0];
			PPrice= batch.getElementsByTagName("PPrice")[0];
			Ptype= batch.getElementsByTagName("Ptype")[0];
			
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			document.getElementById("qty"+idposition).value = "1";
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





<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body    onLoad="document.frm.purchaserequest.focus();">
<%@ include file="indexinv.jsp"%>
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
		var s1= "spare"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "uprice"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "stax"+r;
		var s8 = "staxpercentage"+r;
		var s9 = "staxamount"+r;
		var s10 = "total"+r;
		
		
		
		
		var div ="div"+r;
		var vf3 = " onKeyPress=\" return numeric_only(event,'"+s3+"','7')\" ";
		var vf4 = " onKeyPress=\" return numeric_only(event,'"+s4+"','7')\" ";
		var vf5 = " onKeyPress=\" return numeric_only(event,'"+s5+"','7')\" ";
		
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s1+"' id ='"+s1+"'  onblur=\"assignValues(this,'"+r+"')\"  ><%=optionsparename%></select>";
		
		 x.insertCell(1).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(2).innerHTML="<input type='text' size=10    onblur=\"calculateValue('"+s3+"')\" title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf3+" style='text-align:right' value='1'/>";
		
		x.insertCell(3).innerHTML="<input type='text' size=10    onblur=\"calculateValue('"+s3+"')\" title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf4+"  style='text-align:right' value='0'/>";
		x.insertCell(4).innerHTML="<input type='text' size=10    onblur=\"calculateDiscount('"+s3+"')\" title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf5+"  style='text-align:right'/>";
		x.insertCell(5).innerHTML="<input type='text' size=10    title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly' style='text-align:right'/>";
		
		x.insertCell(6).innerHTML="<select class='formText135'  name='"+s7+"' id ='"+s7+"' onBlur=assignTaxValue('"+s7+"') ><%=optiontaxname%></select>";
		x.insertCell(7).innerHTML="<input type='text' size=10 class='formText135'  name='"+s8+"' id ='"+s8+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(8).innerHTML="<input type='text' size=10 class='formText135'  name='"+s9+"' id ='"+s9+"'  readonly='readonly' style='text-align:right'/>";
		
		x.insertCell(9).innerHTML="<input type='text' size=10    title='Total' class='formText135'  name='"+s10+"' id ='"+s10+"' " +vf5+"   readonly='readonly' style='text-align:right'/>  ";
	
		x.insertCell(10).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
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
		alert(err);
	}
}

	
//Calculate Nettotal in Quantity Changes
function calculateValue(ctr)
{
	try
	{
		var quantity = document.getElementById(ctr).value;
		var idposition = ctr.replace("qty","");
		if(quantity>=1)
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
			qty.focus();
		}
		
	}
	catch(err)
	{
		alert(err);
	}	
		
}

	 

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
	try
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
	catch(err)
	{
		alert(err);
	}	
}




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
	}
	catch(err)
	{
		alert(err);
	}
}


function paramAssign(svalue)
{
	document.getElementById('param').value=svalue;
}





	function valid()
	{
   		try
		{
		 
			display();
			if(parseInt(checkArray.length-1)<1)
			{
				alert("Please Add atleast one Spare");
				document.getElementById('buttonitemadd').focus();
				return false;
			}
			
			var svalue="";
			for(u=0; u<checkArray.length-1;u++)
				svalue =svalue+"spare"+checkArray[u]+","+"qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"total"+checkArray[u]+",";
			var s = "cashSaleNo,saleDate,vendorid,payment,division,";
			s = s+svalue+"totals,totaldiscount,tax,salestax,salestaxamount,nettotal,memo,ref,";
			var v = s.split(",");
			var flag =false;
			
			if( 
				checkNull("cashSaleNo","Enter Purchase Invoice Number")
				&& checkServerDateLock('serverdate','saleDate','serverdatelock')
				&&	checkNullSelect("vendorid","Select Vendor ","Select")
				&& 	checkNullSelect("payment","Select Payment ","Select")
				&& 	checkNullSelect("division","Select Division ","Select")
				&& 	checkNull("memo","Enter the Desription.....")
				
				)
			{	
				for( i=0; i<v.length-1; i++)
				{
					var chk =document.getElementById(v[i]).value;
					var ck = "Enter Data..."+v[i];
					if(checkNull(v[i],ck))
						d=1;
					else
						return false;
						
				}
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
<%
	String taxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax ORDER BY CHR_TAXNAME");
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



function assignTaxValue(ctr)
{
	try
	{
		
		var taxid = document.getElementById(ctr).value;
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
	catch(err)
	{	
		alert(err);
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
		document.getElementById("nettotal").value=Math.round((grandtotal-discountamount));
		
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
							<div align="center"><strong>Spare Purchase  
							
							
							</strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">

								<tr>
									<td width="160" class="boldEleven">
								  <div align="left">Vendor Invoice No.<span class="boldred"> *</span></div>									</td>
								  <td width="243" class="boldEleven">
								  <input tabindex="0" name="cashSaleNo" type="text" class="formText135" id="cashSaleNo"     onBlur="upperMe(this)"          onBlur="upperMe(this)"     onKeyPress="" size="30" maxlength="50" /></td>
									<td width="103" class="boldEleven">Purchase Date<span class="boldred"> *</span></td>
								  <td width="388" class="boldEleven"><input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly="readonly" /> 
<script language='JavaScript'  type="text/javascript">setCurrentDate('saleDate'); </script></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor<span class="boldred"> *</span></div>									</td>
									<td class="boldEleven"><select name="vendorid"
										class="formText135" id="vendorid" tabindex="1" style="width:200">
										<option value='Select'>Select Vendor</option>
										<%
								String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation  ORDER BY CHR_VENDORNAME");
								for(int u=0; u<vendorids.length; u++)
									out.print("<option value='"+vendorids[u][0]+"'>"+vendorids[u][1]+" / "+vendorids[u][0] +"</option>");
							%>
									</select></td>
									<td class="boldEleven">Payment Terms<span class="boldred"> *</span></td>
									<td class="boldEleven"><select name="payment"
										class="formText135" id="payment" tabindex="3" style="width:200">
										<option value='Select'>Select Payment</option>
										<%
								String paymentids[][] = CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms ORDER BY CHR_PAYMENTNAME");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
									</select></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Division <span class="boldred">*</span></td>
									<td class="boldEleven">
									
									<select name="division"
										class="formText135" id="division" tabindex="1" style="width:200">
										<option value='Select'>Select Division</option>
										<%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division ORDER BY CHR_DIVICODE");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
									</select></td>
									<td class="boldEleven"></td>
								  <td class="boldEleven">
									</td>
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
							<div id="divscroll"
								style="OVERFLOW:auto;width:auto;height:300px">
							<table id="myTable" width="100%" border="1" cellpadding="1" cellspacing="1">

								 
								<th class="boldEleven"><b>Spare</b></th>
								<th class="boldEleven"><b>Description</b></th>
								<th class="boldEleven"><b>Quantity/Unit</b></th>
								<th class="boldEleven"><b>Unit Price</b></th>
								<th class="boldEleven"><b>Discount(%)</b></th>
								<th class="boldEleven"><b>Unit Discount</b></th>
								
								<th class="boldEleven"><b>Tax</b></th>
								<th class="boldEleven"><b>Tax (%)</b></th>
								<th class="boldEleven"><b>Tax Amount </b></th>
								<th class="boldEleven"><b>Total</b></th>
								<th class="boldEleven">&nbsp;</th>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left" ><input type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								id="buttonitemadd" tabindex="8"></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr> 
						
						<tr>
								  <td colspan="4" valign="top" class="boldEleven"><div id="prdetails" style="OVERFLOW:auto;width:100%;height:300px"  ></div></td>
							  </tr>
							  
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description <span class="boldred">*</span></div>
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
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly="readonly"
										style='text-align:right' /></div>
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
										style='text-align:right'
										onKeyPress="doubleValue('totaldiscount',9)"></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group<span class="boldred"> *</span></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13" style="width:200">
										 
										<%=optiontaxname%>
									</select></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><input name="salestax" value="0"
										type="text" class="formText135" id="salestax"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference<span class="boldred"> *</span> 
									  <input name="filename"
										type="hidden" value="SparePurchase" /> 
									  <input name="actionS"
										type="hidden" value="INVSparePurchaseAdd" /> 
									  <input
										name="param" type="hidden" id="param" value='0,'>
										
									  <%
									  	String dateCheckData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y'),DAT_LOCK,MONTHNAME(NOW()),MONTH(NOW()),YEAR(NOW()) FROM m_institution  WHERE INT_ID=1");
									  %>
									  <input name="serverdate" type="hidden" id="serverdate" value="<%=dateCheckData[0][0]%>" />
									  <input name="serverdatelock" type="hidden" id="serverdatelock" value="<%=dateCheckData[0][1]%>" />
									
									  </div>
									</td>
									<td class="boldEleven">
									<div align="left"> 
										
										<select name="ref" id="ref"
										class="formText135" size="5">
										<jsp:include page="Staffload.jsp" flush="true" />
									</select>
									
									  </div>
									</td>
									<td class="boldEleven">
									<div align="left">Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount" value="0"
										type="text" class="formText135" id="salestaxamount"
										readonly="readonly" tabindex="14" style='text-align:right' />
									</div>
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
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal" tabindex="15" value="0"
										style='text-align:right' /></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead"  value="Add"   accesskey="s"   onClick="return valid()" />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('SpareInwardView.jsp')" /></div>
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

<script language="javascript">

function proposedpurchasedatecheck()
{
	try
	{
		 
		if(  checkNullSelect("purchaserequest","Select Purchase Request Number",'0')   ) 
			return DateComparision ("proposedpurchasedate","saleDate", "Kindly check your purchase and proposed purchase date....")
		else
			return false;
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
 }
%>
</body>
</html>
