<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
	String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,UPPER(CHR_VENDORNAME) from  inv_m_vendorsinformation ");
	String vendoroption="<option value=''>Select Vendor</option>";
	for(int u=0; u<vendorids.length; u++)
		vendoroption = vendoroption +"<option value='"+vendorids[u][0]+"'>"+vendorids[u][1].replaceAll("&","AND") +"</option>" ;
		
	String warranty="<option value='0'>No Warranty</option>";
	for(int u=1; u<=10; u++)
		warranty = warranty +"<option value='"+u+"'>"+u +" - Yrs</option>" ;
String taxids[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax ORDER BY CHR_TAXNAME");
String optiontaxname="<option value=''>Select Tax</option>";//<option value='0'>No Tax</option>
for(int u=0; u<taxids.length; u++)
	optiontaxname =optiontaxname+"<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>";

%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>

<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	 
	$(function() {
		$( "#saleDate" ).datepicker({ minDate: -3, maxDate: "+0D" });
	});
	 
	 $(function() {
		$( "#purchasedate" ).datepicker({ minDate: -0, maxDate: "+60D" });
	});
	 
 


	</script>

<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">






<script language="javascript">
var assigncontrol="";
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
		var s3= "Quantity"+r;
		var s4 = "Unitprice"+r;
		var s5 = "Purchaseprice"+r;
		var s6 = "unitsalesprice"+r;
		 
		var s9 = "Salesprice"+r;
		var s10 = "vendorid"+r;
		var div ="div"+r;
		var s11 = "idayn"+r;
		var s12 = "installation"+r;
		var s13 = "delivery"+r;
		var s14 = "additionalwarranty"+r;
		var s15 = "grosssalevalue"+r;
		var s16 = "margin"+r;
		var s17 = "pwarranty"+r;
		var s18 = "swarranty"+r;
		
		var s19 = "ptax"+r;
		var s20 = "ptaxpercent"+r;
		var s21 = "ptaxamount"+r;
		var s22 = "stax"+r;
		var s23 = "staxpercent"+r;
		var s24 = "staxamount"+r;
		
		
		
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s10+"' id ='"+s10+"' style='width:100px' ><%=vendoroption%></select>";
 
		 x.insertCell(1).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')><option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(2).innerHTML="<div id='"+div+"'></div>";
		 
		x.insertCell(3).innerHTML="<input type='text' size=30 class='formText135' name='"+s2+"' id ='"+s2+"' style='text-align:left'/>";
		
		x.insertCell(4).innerHTML="<input type='text' size=10 class='formText135' onKeyPress=\"return numeric_only(event,'"+s3+"','14')\"   maxlength='10'     name='"+s3+"' value='0' onblur=\"calculateQuantityprice(this,'"+s3+"')\" id ='"+s3+"' style='text-align:right'/>";
		
		x.insertCell(5).innerHTML="<input type='text' size=10 class='formText135' onKeyPress=\"return numeric_only(event,'"+s4+"','14')\"   maxlength='10'      name='"+s4+"' value='0' onblur=\"calculateunitprice(this,'"+s4+"')\" id ='"+s4+"' style='text-align:right'/>";
		
		x.insertCell(6).innerHTML="<select  class='formText135' onBlur=assignTaxValue('"+s19+"')    name='"+s19+"' id ='"+s19+"'style='width:100px' ><%=optiontaxname%></select>";
		x.insertCell(7).innerHTML="<input type='text' size=10 class='formText135'  name='"+s20+"' id ='"+s20+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(8).innerHTML="<input type='text' size=10 class='formText135'  name='"+s21+"' id ='"+s21+"'  readonly='readonly' style='text-align:right'/>";
		
		
		
		x.insertCell(9).innerHTML="<input type='text' size=10 class='formText135'  onKeyPress=\"return numeric_only(event,'"+s5+"','10')\"    maxlength='10'    name='"+s5+"' value='0' id ='"+s5+"' onblur=\"calculatedifference(this,'"+s6+"')\"  style='text-align:right'  readonly = 'readonly'/>";
		
		
		
		x.insertCell(10).innerHTML="<select  class='formText135'  name='"+s17+"' id ='"+s17+"'style='width:100px' ><%=warranty%></select>";
		
		
		
		
		x.insertCell(11).innerHTML="<input type='text' size=10 class='formText135'    onKeyPress=\"return numeric_only(event,'"+s6+"','14')\"    maxlength='10'     name='"+s6+"' value='0' id ='"+s6+"'   onblur=\"calculatedifference(this,'"+s6+"')\" style='text-align:right'/>";
		
		
		x.insertCell(12).innerHTML="<select  class='formText135' onBlur=assignTaxValueS('"+s22+"')   name='"+s22+"' id ='"+s22+"'style='width:100px' ><%=optiontaxname%></select>";
		x.insertCell(13).innerHTML="<input type='text' size=10 class='formText135'  name='"+s23+"' id ='"+s23+"'  readonly='readonly' style='text-align:right' value='0'/>";
		x.insertCell(14).innerHTML="<input type='text' size=10 class='formText135'  name='"+s24+"' id ='"+s24+"'  readonly='readonly' style='text-align:right'/>";
		
		  
		  
		 
		 x.insertCell(15).innerHTML="<input type='text' size=10 class='formText135' readonly = 'readonly'  name='"+s9+"' value='0' id ='"+s9+"'    style='text-align:right'/>"; 
		 
		 x.insertCell(16).innerHTML="<select  class='formText135'  name='"+s18+"' id ='"+s18+"'style='width:100px' ><%=warranty%></select>";
		
		 x.insertCell(17).innerHTML=" <input type='checkbox'  class='formText135'   name='"+s11+"' value='Y' id ='"+s11+"' onclick=\"calculateadditional(this,'"+s11+"')\"  />";  
		 x.insertCell(18).innerHTML="<input type='text' size=10 class='formText135'   name='"+s12+"' value='0' id ='"+s12+"'    style='text-align:right'     maxlength='6'   onKeyPress=\"return numeric_only(event,'"+s11+"','10')\"  onblur=\"calculateadditional(this,'"+s11+"')\"/>"; 
		 x.insertCell(19).innerHTML="<input type='text' size=10 class='formText135'  name='"+s13+"' value='0' id ='"+s13+"'    style='text-align:right'    maxlength='6'    onKeyPress=\"return numeric_only(event,'"+s12+"','10')\"  onblur=\"calculateadditional(this,'"+s11+"')\"/>"; 
		 x.insertCell(20).innerHTML="<input type='text' size=10 class='formText135'  name='"+s14+"' value='0' id ='"+s14+"'    style='text-align:right'    maxlength='6'    onKeyPress=\"return numeric_only(event,'"+s13+"','10')\"  onblur=\"calculateadditional(this,'"+s11+"')\"/>"; 
		 
		 x.insertCell(21).innerHTML="<input type='text' size=10 class='formText135'  name='"+s15+"' value='0' id ='"+s15+"' readonly = 'readonly'    style='text-align:right'  />"; 
		 
		 
		x.insertCell(22).innerHTML="<input width='56' class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
	 	
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		display();
		document.getElementById('desc'+(r-1)).focus();
	}
 
 	function deleteRow(i,rx)
	{
		document.getElementById("myTable").deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		 
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
		
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		
	}
	
	
	
	 

	 
   

function calculateQuantityprice(ctr,ctr1) 
{
	 
	 var postion = ctr1.replace("Quantity","");
	 var quantity = parseFloat(document.getElementById("Quantity"+postion).value);
	 var Unitprice = parseFloat(document.getElementById("Unitprice"+postion).value);
	 var ptaxpercent  = parseFloat(document.getElementById("ptaxpercent"+postion).value);
	 var ptaxamount = (quantity * Unitprice)* ptaxpercent/100;
	 document.getElementById("ptaxamount"+postion).value = Math.round(ptaxamount);
	 document.getElementById("Purchaseprice"+postion).value = Math.round((quantity * Unitprice) +ptaxamount);
	 calculatetotal(postion) ;

}
	
	
function calculateunitprice(ctr,ctr1) 
{
	 var postion = ctr1.replace("Unitprice","");
	 var quantity = parseFloat(document.getElementById("Quantity"+postion).value);
	 var Unitprice = parseFloat(document.getElementById("Unitprice"+postion).value);
	 var ptaxpercent  = parseFloat(document.getElementById("ptaxpercent"+postion).value);
	 var ptaxamount = (quantity * Unitprice)* ptaxpercent/100;
	 document.getElementById("ptaxamount"+postion).value = Math.round(ptaxamount);
	 document.getElementById("Purchaseprice"+postion).value = Math.round((quantity * Unitprice) +ptaxamount);
	 calculatetotal(postion) ;
}


 
function calculatedifference(ctr,ctr1) 
{
	 var postion = ctr1.replace("unitsalesprice","");
	 var quantity = parseFloat(document.getElementById("Quantity"+postion).value);
	 var unitsalesprice  = parseFloat(document.getElementById("unitsalesprice"+postion).value);
	 var staxpercent  = parseFloat(document.getElementById("staxpercent"+postion).value);
	 var staxamount = (quantity * unitsalesprice)* staxpercent/100;
	 document.getElementById("staxamount"+postion).value = Math.round(staxamount);
	 document.getElementById("Salesprice"+postion).value = Math.round((quantity * unitsalesprice)+staxamount);
	 calculatetotal(postion) ;
	  
	 
}
 
 
 
function calculatetotal(postion) 
{
	try
	{
		 var quantity = parseFloat(document.getElementById("Quantity"+postion).value);
		 var Unitprice = parseFloat(document.getElementById("Unitprice"+postion).value);
		 var ptaxpercent  = parseFloat(document.getElementById("ptaxpercent"+postion).value);
		 var ptaxamount = Math.round((quantity * Unitprice)* ptaxpercent/100);
		 var Purchaseprice = Math.round((quantity * Unitprice) +ptaxamount);
		 document.getElementById("ptaxamount"+postion).value =  ptaxamount ;
		 document.getElementById("Purchaseprice"+postion).value = Purchaseprice;
		 
		 var unitsalesprice  = parseFloat(document.getElementById("unitsalesprice"+postion).value);
		 var staxpercent  = parseFloat(document.getElementById("staxpercent"+postion).value);
		 var staxamount = Math.round((quantity * unitsalesprice)* staxpercent/100);
		 var Salesprice = Math.round((quantity * unitsalesprice)+staxamount);
		 document.getElementById("staxamount"+postion).value = staxamount;
		 document.getElementById("Salesprice"+postion).value = Salesprice;
		 
	  
		 var f = document.getElementById("idayn"+postion).checked;
		 if(f == true)
		 {
			if(
			
				checkNull('installation'+postion, 'Installation charges should\'nt empty....')
				&& checkNull('delivery'+postion, 'delivery charges should\'nt empty....')
				&& checkNull('additionalwarranty'+postion, 'Additionalwarranty charges should\'nt empty....')
			 )
			{
				var d1 = parseFloat(document.getElementById("installation"+postion).value);
				var d2 = parseFloat(document.getElementById("delivery"+postion).value);
				var d3 = parseFloat(document.getElementById("additionalwarranty"+postion).value);
				var d4 = parseFloat(document.getElementById("Purchaseprice"+postion).value);
				var d5 = parseFloat(document.getElementById("Salesprice"+postion).value);
				var d6 = parseFloat(document.getElementById("ptaxamount"+postion).value);
				var d7 = parseFloat(document.getElementById("staxamount"+postion).value);
				d5= d5-d7;
				d4 = d4-d6;
				document.getElementById("grosssalevalue"+postion).value = Math.round(d5-d4-d2-d3 );
				
			}
		}
		else
		{
			document.getElementById("installation"+postion).value =0;
			document.getElementById("delivery"+postion).value =0;
			document.getElementById("additionalwarranty"+postion).value =0;
			document.getElementById("grosssalevalue"+postion).value =0;
			var d4 = parseFloat(document.getElementById("Purchaseprice"+postion).value);
			var d5 = parseFloat(document.getElementById("Salesprice"+postion).value);
			var d6 = parseFloat(document.getElementById("ptaxamount"+postion).value);
			var d7 = parseFloat(document.getElementById("staxamount"+postion).value);
			d5= d5-d7;
			d4 = d4-d6;
			document.getElementById("grosssalevalue"+postion).value = Math.round(d5 - d4);
			 
			
		}
	}	 
	catch(err)
	 {
	 	alert(err);
	 }
} 
 

 	
function calculateadditional(ctr,ctr1) 
{
	
	try
	{
		 var postion = ctr1.replace("idayn","");
		 var f = document.getElementById("idayn"+postion).checked;
		 if(f == true)
		 {
			if(
			
				checkNull('installation'+postion, 'Installation charges should\'nt empty....')
				&& checkNull('delivery'+postion, 'delivery charges should\'nt empty....')
				&& checkNull('additionalwarranty'+postion, 'Additionalwarranty charges should\'nt empty....')
			 )
			{
				var d1 = parseFloat(document.getElementById("installation"+postion).value);
				var d2 = parseFloat(document.getElementById("delivery"+postion).value);
				var d3 = parseFloat(document.getElementById("additionalwarranty"+postion).value);
				var d4 = parseFloat(document.getElementById("Purchaseprice"+postion).value);
				var d5 = parseFloat(document.getElementById("Salesprice"+postion).value);
				var d6 = parseFloat(document.getElementById("ptaxamount"+postion).value);
				var d7 = parseFloat(document.getElementById("staxamount"+postion).value);
				d5= d5-d7;
				d4 = d4-d6;
				document.getElementById("grosssalevalue"+postion).value = Math.round(d5-d4-d2-d3 );
				
			}
		}
		else
		{
			document.getElementById("installation"+postion).value =0;
			document.getElementById("delivery"+postion).value =0;
			document.getElementById("additionalwarranty"+postion).value =0;
			document.getElementById("grosssalevalue"+postion).value =0;
			var d4 = parseFloat(document.getElementById("Purchaseprice"+postion).value);
			var d5 = parseFloat(document.getElementById("Salesprice"+postion).value);
			var d6 = parseFloat(document.getElementById("ptaxamount"+postion).value);
			var d7 = parseFloat(document.getElementById("staxamount"+postion).value);
			d5= d5-d7;
			d4 = d4-d6;
			document.getElementById("grosssalevalue"+postion).value = Math.round(d5 - d4);
			 
			
		}
	 }
	 catch(err)
	 {
	 	alert(err);
	 }
	 
	 
	 
	 
}
 
 

function roundNumber(num, dec) {
	var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	return result;
}







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
   	var idposition =  divi.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='"+s1+"'  style='width:160px'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
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
			PPrice= batch.getElementsByTagName("PPrice")[0];
			Ptype= batch.getElementsByTagName("Ptype")[0];
			
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			 
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


 
function assignTaxValue(ctr)
{
	
	var taxid = document.getElementById(ctr).value;
	if(taxid == "")
	{
		alert("Please Purchase Select Tax");
		document.getElementById(ctr).focus();
	}
	else
	{		
		var idposition = ctr.replace("ptax","");
		
		{
			var qty = parseFloat(document.getElementById("Quantity"+idposition).value);
			var uprice = parseFloat(document.getElementById("Unitprice"+idposition).value);
			for(i=0; i<taxvalue1.length-1; i++)
			{
				var rowvalue = taxvalue1[i].split(",")
				if(rowvalue[0]=== taxid)
				{
					document.getElementById("ptaxpercent"+idposition).value = rowvalue[2];
					document.getElementById("ptaxamount"+idposition).value = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					
					var taxamount = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					var total =  Round((qty*uprice) +taxamount);
					document.getElementById("Purchaseprice"+idposition).value = Round( total );
					calculatetotal(idposition) ;
				}	
			}
		}
	}
	
}

function assignTaxValueS(ctr)
{
	
	var taxid = document.getElementById(ctr).value;
	if(taxid == "")
	{
		alert("Please Sales Select Tax");
		document.getElementById(ctr).focus();
	}
	else
	{		
		var idposition = ctr.replace("stax","");
		
		{
			var qty = parseFloat(document.getElementById("Quantity"+idposition).value);
			var uprice = parseFloat(document.getElementById("unitsalesprice"+idposition).value);
			for(i=0; i<taxvalue1.length-1; i++)
			{
				var rowvalue = taxvalue1[i].split(",")
				if(rowvalue[0]=== taxid)
				{
					document.getElementById("staxpercent"+idposition).value = rowvalue[2];
					document.getElementById("staxamount"+idposition).value = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					
					var taxamount = Round((qty*uprice) *parseFloat(rowvalue[2]) /100);
					var total =  Round((qty*uprice) +taxamount);
					document.getElementById("Salesprice"+idposition).value = Round( total );
					calculatetotal(idposition) ;
				}	
			}
		}
	}
	 
}

 </script>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
<table width="120%" border="0" cellspacing="1" cellpadding="1">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="90%"
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
					<table cellspacing="2" cellpadding="2" width="99%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">PURCHASE REQUEST 
									<%
		
String Requestno = request.getParameter("Requestno");							
String sql = " SELECT INT_POREQUESTID,INT_BRANCHID ,INT_DIVIID ,CHR_POREQUESTNO, ";
sql = sql +" DATE_FORMAT(DAT_REQUESTDATE,'%d-%m-%Y') ,INT_CUSTOMERID ,CHR_SHIPPING ,CHR_SHIPPINGADDRESS,  ";
sql = sql +" INT_CUSTOMERID ,INT_PAYMENTTERMID ,INT_CUSTOMERCOMMITMENTDAYS ,CHR_REF ,CHR_DES , DATE_FORMAT(DAT_PURCHASEDATE,'%d-%m-%Y') ";
sql = sql +" FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+Requestno+"'";
String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
out.println("[ "+Requestno+" ]");

									%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Division <span class="boldred">* </span> </td>
								<td width="199" align="left" valign="top">
								<select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                    <option value='0'>Select</option>
                    <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select>
				  <script language="javascript">setOptionValue('divis','<%=data[0][2]%>')</script>				  								</td>
							    <td width="105" class="boldEleven">Proposed Purchase Date <span class="boldred">* </span> </td>
						        <td width="148" class="boldEleven">
								
							  
							  
							   
							  <input tabindex="2" value="<%=data[0][13]%>"
										name="purchasedate" type="text" class="formText135" id="purchasedate"
										size="15"   readonly="readonly">
							  <span class="boldred">( dd-mm-yyyy) </span>							    <a
										href="javascript:cal3.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal3 = new calendar1(document.forms['frm'].elements['purchasedate']);
				cal3.year_scroll = true;
				cal3.time_comp = false;
				setCurrentDate('purchasedate'); 
		//-->
                                </script>								</td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Request date  <span class="boldred">* </span> </td>
							  <td align="left"><span class="boldEleven">
							    <input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly value="<%=data[0][4]%>">
							    <span class="boldred">( dd-mm-yyyy)</span>							    <a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				 
		//-->
                                </script>
							  </span></td>
						      <td class="boldEleven">Vendor Payment  <span class="boldred">* </span> </td>
						      <td class="boldEleven"><select name="payment"
										class="formText135" id="payment" tabindex="3">
                                <option value='0'>Select</option>
                                <%
								String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
								for(int u=0; u<paymentids.length; u++)
									out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
							%>
                              </select>
							  
							  <script language="javascript">setOptionValue('payment','<%=data[0][9]%>')</script>
							  </td>
							</tr>
							<tr>
							  <td class="boldEleven"><div align="left">CustomerName <span class="boldred">* </span> </div></td>
							  <td class="boldEleven"><div align="left">
							    
                                  <%
			String ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1  ORDER BY f.CHR_NAME";
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
			%>
                                  <select name="customer" id="customer" class="formText135"  
										style="width: 150px"
										 onchange="loadAddress('customer','shippingaddress')" >
                                    <option value="0">Select</option>
                                    <%
for(int y=0;y<custData.length;y++)
	out.println("<option  value='"+custData[y][0]+"'>"+custData[y][1]+ " ,"+custData[y][2]+ "  ,"+custData[y][3]+ "  ,"+custData[y][4]+ "  ,"+custData[y][5]+ "  ,"+custData[y][6]+ "</option>");	

%>

                                  </select>
							      
<script language="javascript">setOptionValue('customer','<%=data[0][5]%>')</script></div></td>
							  <td class="boldEleven">Customer Commitment days  <span class="boldred">* </span> </td>
							  <td class="boldEleven">
							    	<select name="noofpaymentcommitment" class="formText135" id="noofpaymentcommitment">
                                  <option value="0">Select</option>
                                  <%
								  	for(int k=1;k<=100;k++)
										out.println("<option value='"+k+"'>"+k+" - Days</option>");
								  %>
                                </select>
								<script language="javascript">setOptionValue('noofpaymentcommitment','<%=data[0][10]%>')</script>
								
								
							  </td>
							</tr>
							<tr>
							  <td valign="top" class="boldEleven"><div align="left">Shipping Address</div></td>
							  <td valign="top" class="boldEleven"><table width="38%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S" checked /></td>
                                    <td width="15%" class="boldEleven">Same</td>
                                    <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"></td>
                                    <td width="24%" class="boldEleven">Different</td>
                                  </tr>
                                </table>
							      <div align="left"></div></td>
							  <td rowspan="2" valign="top" class="boldEleven">M.E  <span class="boldred">* </span> </td>
							  <td rowspan="2" valign="top" class="boldEleven"><script language="javascript">setOptionValue('noofpaymentcommitment','<%=data[0][10]%>')</script>							  <select name="ref" id="ref"
										class="formText135" size="5">
                                <jsp:include page="Staffload.jsp" flush="true" />                        
                              </select>
                                <script language="javascript">setOptionValue('ref','<%=data[0][11]%>')</script></td>
							</tr>
							<tr>
							  <td valign="top" class="boldEleven">&nbsp;</td>
							  <td valign="top" class="boldEleven"><div align="left">
							    <textarea name="shippingaddress"
										cols="30" rows="4" class="formText135" id="shippingaddress"><%=data[0][7]%></textarea>
                              </div></td>
						    </tr>
							<tr>
							  <td valign="top" class="boldEleven">&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							 
							
							
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Description <span class="boldred">* </span> </td>
							  <td colspan="3" align="left"><textarea name="memo" cols="30"
										rows="5" class="formText135" id="memo" tabindex="9"><%=data[0][12]%></textarea>
										<script language="javascript">setOptionValue('memo','<%=data[0][4]%>')</script>
							    <div align="left"></div></td>
					      </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
								<td align="left"><span class="boldEleven">
								   
								</span></td>
							    <td valign="top" class="boldEleven"><div align="left"></div></td>
							    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px">
							 
							 
							<table width="100%" border="1" cellpadding="3" cellspacing="2" bordercolor="#CC0000"	id="myTable">
								<tr>
									<td class="boldEleven"><b>Vendor</b></td>
									<td class="boldEleven"><b>Type</b></td>
									<td class="boldEleven"><b>Item / Product</b></td>
									<td class="boldEleven"><b>Desc</b></td>
									<td class="boldEleven"><b>Qty</b></td>
									<td class="boldEleven"><strong><b>Unit P.Price</strong></td>
									<td class="boldEleven"><b>P.Tax</strong></td>
									<td class="boldEleven"><b>P.Tax % </strong></td>
									<td class="boldEleven"><b>Tax Amount</strong></td>
									<td class="boldEleven"><strong><b>P.Price</strong></td>
									<td class="boldEleven"><strong>P.Warrnty</strong></td>
									<td class="boldEleven"><strong><b>Unit S.Price</strong></td>
									<td class="boldEleven"><b>S.Tax</strong></td>
									<td class="boldEleven"><b>S.Tax % </strong></td>
									<td class="boldEleven"><b>Tax Amount</strong></td>
									<td class="boldEleven"><strong><b>SalePrice</strong></td>
									<td class="boldEleven"><strong>S.Warranty</strong></td>
									<td class="boldEleven"><strong><b>If Installation /Delivery/Additional Warranty Required:  Yes/No</strong></td>
									<td class="boldEleven"><strong><b>Installation</strong></td>
									<td class="boldEleven"><strong><b>Delivery</strong></td>
									<td class="boldEleven"><strong><b>Additional Warranty</strong></td>
									<td class="boldEleven"><strong><b>Gross Margin</strong></td>
									<td class="boldEleven"><strong><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
									 
								</tr>
							</table>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  <div align="left"><input id="buttonitemadd" type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8" /></div>							  </td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><input name="filename" type="hidden" value="PurchaseRequest" />
							    <input name="actionS"
									type="hidden" value="INVPurchaseRequestEdit" />
							    <input name="param" type="hidden" id="param" value="0,">
							    <input name="Requestno" type="hidden" id="Requestno" value="<%=Requestno%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('PurchaseRequest.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<script language="javascript">
function Loaditemproductss(ctr,div) 
{
	
	var url = "../inventory?actionS=INVItemProduct&id="+escape(document.getElementById(ctr).value) ;
	divi = div;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
}
		
	 
		 
		</script>


<%
		sql = " SELECT CHR_TYPE,CHR_ITEMID,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,(DOU_PURCHASEPRICE),DOU_UNITSALEPRICE,(DOU_SALESPRICE) , CHR_ADDITIONALWARRANTY, DOU_INSTALLATION, DOU_DELIVERY,DOU_ADDITIONALWARRANTY,DOU_GROSSVALUE,DOU_CONTRIBUTION,DOU_CONTRIBUTION_PERCENTAGE,INT_VENDORID,CHR_PURCHASEWARRANTY , CHR_SALESWARRANTY,INT_P_TAXID,DOU_P_TAX_PERCENTAGE,DOU_P_TAX_AMOUNT,INT_S_TAXID,DOU_S_TAX_PERCENTAGE,DOU_S_TAX_AMOUNT FROM inv_t_purchaserequestitem WHERE CHR_POREQUESTNO='"+Requestno+"'";
		 
        String itemDatas[][] =  CommonFunctions.QueryExecute(sql);
		String param="";
		for(int u=0; u<itemDatas.length;u++)
		{
			param= param+(u+1)+",";
		%>
		
		<script language="javascript" >
			insRow();
			var s0= "itype<%=(u+1)%>";
			var s1= "item<%=(u+1)%>";
			var s2 = "desc<%=(u+1)%>";
			var s3= "Quantity<%=(u+1)%>";
			var s4 = "Unitprice<%=(u+1)%>";
			var s5 = "Purchaseprice<%=(u+1)%>";
			var s6 = "Salesprice<%=(u+1)%>";
			var s9 = "unitsalesprice<%=(u+1)%>";
			var s10 = "vendorid<%=(u+1)%>";
			var div ="div<%=(u+1)%>";
		
			var s11 = "idayn<%=(u+1)%>" ;
			var s12 = "installation<%=(u+1)%>" ;
			var s13 = "delivery<%=(u+1)%>" ;
			var s14 = "additionalwarranty<%=(u+1)%>" ;
			var s15 = "grosssalevalue<%=(u+1)%>" ;
			
			 
			var s16 = "margin<%=(u+1)%>" ;
			var s17 = "pwarranty<%=(u+1)%>" ;
			var s18 = "swarranty<%=(u+1)%>" ;
		
			var s19 = "ptax<%=(u+1)%>" ;
			var s20 = "ptaxpercent<%=(u+1)%>";
			var s21 = "ptaxamount<%=(u+1)%>" 
			var s22 = "stax<%=(u+1)%>";
			var s23 = "staxpercent<%=(u+1)%>";
			var s24 = "staxamount<%=(u+1)%>";
			
		
		
		
			if("I" == "<%=itemDatas[u][0]%>")
				setOptionValue(s0,"1");
			else
				setOptionValue(s0,"2");
			
			Loaditemproductss(s0,div);
			alert("load the product...");
	
			
			setOptionValue(s1,"<%=itemDatas[u][1]%>");
			 
			document.getElementById(s2).value="<%=itemDatas[u][2].replaceAll("\""," ")%>";
			document.getElementById(s3).value="<%=itemDatas[u][3]%>";
			document.getElementById(s4).value="<%=itemDatas[u][4]%>";
			document.getElementById(s5).value="<%=itemDatas[u][5]%>";
			document.getElementById(s9).value="<%=itemDatas[u][6]%>";
			document.getElementById(s6).value="<%=itemDatas[u][7]%>";
			
			if("Y" == "<%=itemDatas[u][8]%>")
				document.getElementById(s11).checked = true;
			else
				document.getElementById(s11).checked = false;
				
			document.getElementById(s12).value="<%=itemDatas[u][9]%>";
			document.getElementById(s13).value="<%=itemDatas[u][10]%>";
			document.getElementById(s14).value="<%=itemDatas[u][11]%>";
			document.getElementById(s15).value="<%=itemDatas[u][12]%>";
			
			 
			setOptionValue(s10,"<%=itemDatas[u][15]%>"); 
			setOptionValue(s17,"<%=itemDatas[u][16]%>"); 
			setOptionValue(s18,"<%=itemDatas[u][17]%>"); 
			
			setOptionValue(s19,"<%=itemDatas[u][18]%>");  //P.Tax
			document.getElementById(s20).value="<%=itemDatas[u][19]%>"; //P.TAX Percentage
			document.getElementById(s21).value="<%=itemDatas[u][20]%>"; //P.TAX Percentage
			
			setOptionValue(s22,"<%=itemDatas[u][21]%>");  //P.Tax
			document.getElementById(s23).value="<%=itemDatas[u][22]%>"; //P.TAX Percentage
			document.getElementById(s24).value="<%=itemDatas[u][23]%>"; //P.TAX Percentage
			
			
		</script>
		<%
		 	}	
		
		%>
		
		<script language="javascript">
function Loaditemproductss(ctr,div) 
{
	var url = "../inventory?actionS=INVItemProduct&id="+escape(document.getElementById(ctr).value) ;
	alert(url);
	divi = div;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
}
		
		document.getElementById('param').value="<%=param%>";
		 
		</script>


<script language="JavaScript">




function Validate()
  {

	 
	 display();
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add atleast one Item / Product...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}
		var svalue="";
		for(u=0; u<checkArray.length-1;u++)
			svalue =svalue+"vendorid"+checkArray[u]+","+"item"+checkArray[u]+","+"Quantity"+checkArray[u]+","+"Unitprice"+checkArray[u]+","+"unitsalesprice"+checkArray[u]+",";
			 
		var s = "";
		s = s+svalue+"ref,memo,";
		var v = s.split(",");
		 	 
		if(	checkNullSelect("divis","Select Division","0")
			&& checkNull( "saleDate","Enter Invoice Date" )
			&& checkNull( "purchasedate","Enter Proposed Purchase Date" )
			&& checkNullSelect("customer","Select Customer","0")
			&& checkNullSelect("payment","Select vendor payment","0")
			&& checkNullSelect("noofpaymentcommitment","Select No of Commitment Days","0")
			&& checkNull( "ref","Select reference" )
			&& checkNull( "memo","Enter Description" )
		 )
		{
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
		else
			return false;				
		
 } 	
 
  
</script> 
<%@ include file="../footer.jsp"%></form>
</body>
</html>
