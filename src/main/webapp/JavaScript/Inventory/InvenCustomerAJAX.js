var isIE;
var req;
var names;
 
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
//--------------------Clear Select ---------------------
function clearSelect() {
    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];
        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];

        if (element && element.options) {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}
//------------Clear Table---------------------------------------
function ClearTable(ctr1)
{
	 var str="<center><font class='errormessage'>Nothing  found ...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    
  	 
}

function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



function LoadingImages(ctr1)
{
	 var str="<br><br><br><center><img src=\"../images/load/4.gif\" width=\"128\" height=\"15\"></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 




//Start  Author	:: kalaselvan------------------Delivary Challan----------------
function loadDelivary(startletter) 
{
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventoryCustomer?actionS=INVDelivary&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+escape(startletter);
    initRequest(url);
    req.onreadystatechange = delivaryRequest;
    req.open("GET", url, true);
    req.send(null);
}
function delivaryRequest() 
{
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable'); 
        if (req.status == 200) {		  	
          delivaryMessages();
        }
    }
}
function delivaryMessages() 
{
   	var batchs = req.responseXML.getElementsByTagName("Deliverys")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
   	for(loop = 0; loop < batchs.childNodes.length; loop++) {   
	    var batch = batchs.childNodes[loop]; 
       
       	var Qno= batch.getElementsByTagName("Qno")[0];
		var Custpurchaseno= batch.getElementsByTagName("Custpurchaseno")[0];
		var Saleno= batch.getElementsByTagName("Saleno")[0];
		var Saleby= batch.getElementsByTagName("Saleby")[0];
	    var Saledate= batch.getElementsByTagName("Saledate")[0];
	    var Custname= batch.getElementsByTagName("Custname")[0];
		var Status= batch.getElementsByTagName("Status")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='95px' 	align=left class='boldEleven'>"+Qno.childNodes[0].nodeValue;
		str=str+"<td width='100px' 	align=left class='boldEleven'>"+Custpurchaseno.childNodes[0].nodeValue;
		str=str+"<td width='92px' 	align=left class='boldEleven'>"+Saleno.childNodes[0].nodeValue;
		str=str+"<td width='133px' 	align=left class='boldEleven'>"+Custname.childNodes[0].nodeValue;
		if("N" == Status.childNodes[0].nodeValue )
			str=str+"<td width='150px' align=left class='boldgreen'><a  href='DeliveryOrder.jsp?Saleno="+Saleno.childNodes[0].nodeValue+"'><font class='boldred'>Delivery</font></a>";
		
		if("Y" == Status.childNodes[0].nodeValue )
			str=str+"<td width='150px' align=left class='boldgreen'>Fully Delivered / <a href='DCView.jsp?Saleno="+Saleno.childNodes[0].nodeValue+"'><font class='boldgreen'>View</font></a>";
		if("P" == Status.childNodes[0].nodeValue )
			str=str+"<td width='150px' align=left class='boldgreen'><a  href='DeliveryOrder.jsp?Saleno="+Saleno.childNodes[0].nodeValue+"'><font class='boldgreen'>Partially Delivered</font></a> / <a href='DCView.jsp?Saleno="+Saleno.childNodes[0].nodeValue+"'><font color='000000'>View</font></a>";
		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
}
//End  Author	:: kalaiselvan------------------Delivary Challan----------------





//----------------------InVoice-----------------------
function loadInvoice(startletter) {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventoryCustomer?actionS=INVInvoice&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+escape(startletter);
	initRequest(url);
    req.onreadystatechange = invoiceRequest;
    req.open("GET", url, true);
    req.send(null);
}
function invoiceRequest() {
   if(req.readyState == 4) {    	
        ClearTable('QuotationTable'); 
        if (req.status == 200) {		  	
          invoiceMessages();
        }
   }
}

function invoiceMessages() {
   var batchs = req.responseXML.getElementsByTagName("invoices")[0];   	    
   var str="";   
   str=str+"<table width='100%' border='0' class='boldEleven'>";
   var loop=0;	
   for(loop = 0; loop < batchs.childNodes.length; loop++) {
  	   var batch = batchs.childNodes[loop];
      	var Quotationid = batch.getElementsByTagName("Quotationid")[0];
      	var Invnumber = batch.getElementsByTagName("Invnumber")[0];
		var Invdate = batch.getElementsByTagName("Invdate")[0];
		var SalesOrder = batch.getElementsByTagName("SalesOrderNo")[0];
		var Customername = batch.getElementsByTagName("Customername")[0];
		var Invstatus = batch.getElementsByTagName("Invstatus")[0];
      	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		str=str+"<td  align=left class='boldEleven'>"+Quotationid.childNodes[0].nodeValue;		    
		str=str+"<td  align=left class='boldEleven'>"+Invnumber.childNodes[0].nodeValue;		
		str=str+"<td  align=left class='boldEleven'>"+Invdate.childNodes[0].nodeValue;		

		str=str+"<td  align=left class='boldEleven'>"+SalesOrder.childNodes[0].nodeValue;
		str=str+"<td  align=left class='boldEleven'>"+Customername.childNodes[0].nodeValue;		
		var p=SalesOrder.childNodes[0].nodeValue;
		var st=Invstatus.childNodes[0].nodeValue;
		if(st=="Y")
			str=str+"<td align=left class='boldEleven'><font  class='boldgreen' >Y </font>/ <a href=\"javascript:InvoicePrint('"+p+"')\"><font class='boldgreen' >Print</font></a>";
		else
			str=str+"<td  align=left class='boldEleven'><font  class='boldred' >N</font> / <a href='InvoiceEdit.jsp?Saleno="+SalesOrder.childNodes[0].nodeValue+"'><font class='boldgreen'>Invoice</font></a>";
		str=str+"</td></tr>";
     }    
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str; 
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
}

//----------------------CASH SALE-----------------------
function loadCashSale(startletter) {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventoryCustomer?actionS=INVCashSale&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter;
    initRequest(url);
    req.onreadystatechange = cashSaleRequest;
    req.open("GET", url, true);
    req.send(null);
}
function cashSaleRequest() {
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
        document.getElementById('Submit').disabled=true;  
        if (req.status == 200) {		  	
          cashSaleMessages();
        }
    }
}
function cashSaleMessages() {
    var batchs = req.responseXML.getElementsByTagName("cashSales")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("salId")[0];
        var salNo = batch.getElementsByTagName("salNo")[0];
        var salDate = batch.getElementsByTagName("salDate")[0];
        var salTotal = batch.getElementsByTagName("salTotal")[0];
        var quoCust = batch.getElementsByTagName("quoCust")[0];             
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='118px' class='boldEleven'><input type='checkbox' name='itemId' value='"+salNo.childNodes[0].nodeValue+"'>";
		str=str+salNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='106px' align=center class='boldEleven'>"+salDate.childNodes[0].nodeValue;
		str=str+"<td width='249px' align=left class='boldEleven'>"+quoCust.childNodes[0].nodeValue;
		str=str+"<td width='190px' align=center class='boldEleven'><a href='CashSaleSerial.jsp?salno="+salNo.childNodes[0].nodeValue+"' ><font color='#ff0000'>View </font></a>" ;
		str=str+"<td width='101px' align=right class='boldEleven'>"+salTotal.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true;
     	document.getElementById('Submit').disabled=true;
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
     	document.getElementById('btnEdit').disabled=false;
     	document.getElementById('Submit').disabled=false;
     }
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str
  	 
}
//---------------------------------------------------------------

//----------------------Direct Sales-----------------------
function loadDirectSales(startletter) {
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventoryCustomer?actionS=INVDirectSale&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter;
	initRequest(url);
    req.onreadystatechange = DirectSalesRequest;
    req.open("GET", url, true);
    req.send(null);
}
function DirectSalesRequest() {
    if(req.readyState == 4) {    	
        ClearTable('DirectSalesTable');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
         
        if (req.status == 200) {		  	
          DirectSalesMessages();
        }
    }
}
function DirectSalesMessages() {
    var batchs = req.responseXML.getElementsByTagName("directSales")[0];   	    
	var str=""; 
    str=str+"<table width='800' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("salId")[0];
        var salNo = batch.getElementsByTagName("salNo")[0];
        var salDate = batch.getElementsByTagName("salDate")[0];
        var salTotal = batch.getElementsByTagName("salTotal")[0];
        var quoCust = batch.getElementsByTagName("quoCust")[0];    
        var Status = batch.getElementsByTagName("Status")[0];  
        var PStatus = batch.getElementsByTagName("PStatus")[0];  
                 
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'><input type='checkbox' name='itemId' value='"+salNo.childNodes[0].nodeValue+"'>";
		str=str+salNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='100' align=center class='boldEleven'>"+salDate.childNodes[0].nodeValue;
		str=str+"<td width='200' align=left class='boldEleven'>"+quoCust.childNodes[0].nodeValue;
		if(Status.childNodes[0].nodeValue=="1")
			str=str+"<td width='150' align=center class='boldEleven'>Executed"
		else
			str=str+"<td width='150' align=center class='boldEleven'>Not Executed"
		
		str=str+"<td width='100' align=center class='boldEleven'><a href='DirectSaleSerialView.jsp?salno="+salNo.childNodes[0].nodeValue+"' ><font color='#ff0000'>View </font></a>" ;
		
		if(PStatus.childNodes[0].nodeValue=="Y")
			str=str+"<td width='100' align=center class='boldEleven'>Paid"
		else
			str=str+"<td width='100' align=center class='boldEleven'>Pending"
		
		//str=str+"<td width='100' align=right class='boldEleven'>"+salTotal.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true;
     	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
     	document.getElementById('btnEdit').disabled=false;
     	 
     }
     var tb=document.getElementById('DirectSalesTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	 
}





//----------------------SwapSales-----------------------


//----------------------Direct Purchase-----------------------


//Account Direct Purchase








 

//load customer Address
var divtag="";
function checkSerial(serial ,divtagname)
{
    console.log("Serial Number checking tagname:"+divtagname);
	divtag=divtagname;
    document.getElementById(divtag).disabled=true;
    var url = "../inventoryCustomer?actionS=checkSerial&serial="+escape(serial);
    var tb=document.getElementById('mythra');
  	tb.innerHTML="<h3><center><font color=red  >Please Wait, Serial numbers are checking...</font></center></h3>" ;
	initRequest(url);
    req.onreadystatechange = SerialRequest;
    req.open("GET", url, true);
    req.send(null);
}

function removedItemSerial(serial ,divtagname)
{
    divtag=divtagname;
    document.getElementById(divtag).disabled=true;
    var url = "../inventoryCustomer?actionS=removedItemSerial&serial="+escape(serial);
    initRequest(url);
    req.onreadystatechange = SerialRequest;
    req.open("GET", url, true);
    req.send(null);
}

 
function SerialRequest() {
    if(req.readyState == 4) {    	
        if (req.status == 200) {		  	
          SerialMessages();
        }
    }
}

function SerialMessages() 
{
	try{
		var batchs = req.responseXML.getElementsByTagName("Serials")[0];   	    
		var str=""; 
		var str1=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0];
			var Flag = batch.getElementsByTagName("Flag")[0];
			if(Flag.childNodes[0].nodeValue == "FALSE")
					str = "Kindly checkup, Serial Number is ::" +Id.childNodes[0].nodeValue;
			str1 = Flag.childNodes[0].nodeValue;
		 }
		 
		 var tb=document.getElementById('mythra');
		 tb.innerHTML="";
		 console.log("SerialMessages::"+str1);
		 
		 if(str1 == "FALSE")
		 {
			var tb=document.getElementById('mythra');
			tb.innerHTML="<h3><center><font color=red  >"+str+"</font></center></h3>" ;
			document.getElementById('checkserialflag').value= "false";
			document.getElementById(divtag).disabled=true;
		}	
		 else
		{ 
			document.getElementById(divtag).disabled=false;
			document.getElementById('checkserialflag').value= "true";
		}
		console.log("Flag :: "+document.getElementById('checkserialflag').value);
	}
	catch(err)
	{
		alert("error..."+err);
	 
	}
}