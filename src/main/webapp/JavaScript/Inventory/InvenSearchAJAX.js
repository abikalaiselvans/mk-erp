var isIE;
var req;
var names;

function getElementY(element){
	var target1Top = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} else if (element.y) {
		target1Top += element.y;
    }
	return target1Top;
}
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
function ClearTable(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    
  	 
}
//-----------------------------------------------------------------------
//-----------------------------------------VendorGroup Search -------------------
function loadVendorSearch()
 {
    var id=document.getElementById('OptVendor').value;
    
    var txtSer1=""+document.getElementById('txtSer').value;        
    var url = "../inventory?actionS=INVSearchVendor&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = searchVendorRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function searchVendorRequest()
 {
    if(req.readyState == 4) {
        ClearTable('VendorSearchTable');
         if (req.status == 200) {
          searchVendorMessages();
        }
    }
}
function searchVendorMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("vendors")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
   
    for(loop = 0; loop < batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var vendorId = batch.getElementsByTagName("Id")[0];
        var vendorName = batch.getElementsByTagName("Name")[0];
        var city = batch.getElementsByTagName("City")[0];
       	var phone = batch.getElementsByTagName("Phone")[0];
        var fax = batch.getElementsByTagName("Fax")[0];
      if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='50px' class='boldEleven'>"+(loop+1);
		str=str+"<td width='190px'  class='boldEleven'>"+vendorId.childNodes[0].nodeValue;
		str=str+"<td width='210px'  class='boldEleven'>"+vendorName.childNodes[0].nodeValue;
		str=str+"<td width='190px'  class='boldEleven'>"+city.childNodes[0].nodeValue;
		str=str+"<td width='190px'  class='boldEleven'>"+phone.childNodes[0].nodeValue;
		str=str+"<td width='190px'  class='boldEleven'>"+fax.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     
  	 var tb=document.getElementById('VendorSearchTable');
  	 tb.innerHTML=str  ; 
  	 str="<font class='bolddeepblue' >Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;
  	 	 
}
//----------------------Purchase Order-----------------------
function loadPurchaseOrder()
{	
	var vendorId=document.getElementById('vendorId').value;	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVPurchaseOrder&month="+escape(mon)+"&year="+escape(yea)+"&vendorId="+escape(vendorId);
    initRequest(url);
    req.onreadystatechange = purchaseOrderRequest;
    req.open("GET", url, true);
    req.send(null);
}
function purchaseOrderRequest() {
    if(req.readyState == 4) {    	
        ClearTable('purchaseOrderTable');       
        if (req.status == 200) {		  	
         purchaseOrderMessages();
        }
    }
}
function purchaseOrderMessages() {
    var batchs = req.responseXML.getElementsByTagName("purchases")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];       
        var purchaseNo = batch.getElementsByTagName("purchaseNo")[0];
        var vendorName = batch.getElementsByTagName("vendorName")[0];
        var orderDate = batch.getElementsByTagName("orderDate")[0];
        var receivedDate = batch.getElementsByTagName("receivedDate")[0];                            
        var totalAmount = batch.getElementsByTagName("totalAmount")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='100px'  class='boldEleven'>"+purchaseNo.childNodes[0].nodeValue;
		str=str+"<td width='120px'  class='boldEleven'>"+vendorName.childNodes[0].nodeValue;
		str=str+"<td width='120px' class='boldEleven'>"+orderDate.childNodes[0].nodeValue;
		str=str+"<td width='120px'  class='boldEleven'>"+receivedDate.childNodes[0].nodeValue;
		str=str+"<td width='100px'  class='boldEleven'>"+totalAmount.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('purchaseOrderTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;	 
}

//----------------------Purchase Payment Load-----------------------
function loadPaymentOrder() 
{
	var vendor=document.getElementById('vendor').value;		
	var mon=document.getElementById('month').value;	
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVpaymentSearch&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(vendor);
   	initRequest(url);
   	req.onreadystatechange =paymentSearchRequest;
    req.open("GET", url, true);
    req.send(null);
}

function paymentSearchRequest() 
{	
	if(req.readyState == 4) 
    {    	
        ClearTable('paymentOrderTable');
       	if (req.status == 200)
        {
        	paymentSearchMessages();
        }
    }
}

function paymentSearchMessages() 
{
	
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Pays")[0];   
	var Payment=""; 
	var Purchaseid="";	
	var Totalamount=""; 
	var Paidamount=""; 
	var Blanace=""; 
	var Status=""; 
	
	str=str+"<table width='100%' border='0' class='boldEleven' cellpadding='1' cellspacing='1'>";
	var dt="";
	var ch="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Purchaseid = batch.getElementsByTagName("Purchaseid")[0];
        // alert(Purchaseid);
        var vendorName= batch.getElementsByTagName("vendorName")[0];        
        var Totalamount = batch.getElementsByTagName("Totalamount")[0];
       // alert(Totalamount);
        var Paidamount = batch.getElementsByTagName("Paidamount")[0];
        // alert(Paidamount);
        var Blanace = batch.getElementsByTagName("Blanace")[0];      
        //	alert(Blanace);	 
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			
			
		str=str+"<td width='50px' class='boldEleven'>"+Purchaseid.childNodes[0].nodeValue;		
		str=str+"<td width='60px' class='boldEleven'>"+vendorName.childNodes[0].nodeValue;
		str=str+"<td width='60px' class='boldEleven'>"+Totalamount.childNodes[0].nodeValue;
		str=str+"<td width='40px' class='boldEleven'>"+Paidamount.childNodes[0].nodeValue;
		str=str+"<td width='40px' class='boldEleven'>"+Blanace.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('paymentOrderTable');
  	 tb.innerHTML=str  ; 
}
//End - Author :: Kalaiselvan----------------------Purchase Payment-----------------------
//----------------------Purchase Payment Load-----------------------
function loadCustomerOrder()
{
	var customerid=document.getElementById('customerid').value;	
	
	var mon=document.getElementById('month').value;	
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVcustomerSearch&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(customerid);
   
   	initRequest(url);
   	req.onreadystatechange =purchaseCustomerRequest;
    req.open("GET", url, true);
    req.send(null);
}

function purchaseCustomerRequest() 
{	
	if(req.readyState == 4) 
    {    	
        ClearTable('purchaseCustomerTable');
       	if (req.status == 200)
        {
        	purchaseCustomerMessages();
        }
    }
}

function purchaseCustomerMessages() 
{
	
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("custPay")[0];   
	var Payment=""; 
	var Purchaseid="";	
	var Totalamount=""; 
	var Paidamount=""; 
	var Blanace=""; 
	var Status=""; 
	
	str=str+"<table width='900' border='0' class='boldEleven' cellpadding='1' cellspacing='1'>";
	var dt="";
	var ch="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Purchaseno = batch.getElementsByTagName("purchaseNo")[0];
        // alert(Purchaseid);
        var orderDate = batch.getElementsByTagName("orderDate")[0];
       // alert(Totalamount);      
        var totalAmount = batch.getElementsByTagName("totalAmount")[0];      
        //	alert(Blanace);	 
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			
		str=str+"<tr>"		
		str=str+"<td  class='boldEleven'>"+Purchaseno.childNodes[0].nodeValue;		
		str=str+"<td  class='boldEleven'>"+orderDate.childNodes[0].nodeValue;	
		str=str+"<td   class='boldEleven'>"+totalAmount.childNodes[0].nodeValue;		
     }
     str=str+"</table>";
     var tb=document.getElementById('purchaseCustomerTable');
  	 tb.innerHTML=str  ; 
}
//End - Author :: Kalaiselvan----------------------Purchase Payment-----------------------

//----------------------Purchase Payment Load-----------------------
function loadCustomerPayment() 
{
	var customer=document.getElementById('customer').value;	
	var mon=document.getElementById('month').value;	
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVcustomerPayment&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(customer);
   	initRequest(url);
   	req.onreadystatechange =customerPaymentRequest;
    req.open("GET", url, true);
    req.send(null);
}

function customerPaymentRequest() 
{	
	if(req.readyState == 4) 
    {    	
        ClearTable('CustomerPaymentTable');
       	if (req.status == 200)
        {
        	paymentCustomerMessages();
        }
    }
}

function paymentCustomerMessages() 
{
	
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("custPayment")[0];   
	var Payment=""; 
	var Purchaseid="";	
	var Totalamount=""; 
	var Paidamount=""; 
	var Blanace=""; 
	var Status=""; 
	
	str=str+"<table width='900' border='0' class='boldEleven' cellpadding='1' cellspacing='1'>";
	var dt="";
	var ch="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Purchaseid = batch.getElementsByTagName("Purchaseid")[0];
        // alert(Purchaseid);
        var Totalamount = batch.getElementsByTagName("Totalamount")[0];
       // alert(Totalamount);
        var Paidamount = batch.getElementsByTagName("Paidamount")[0];
        // alert(Paidamount);
        var Balanace = batch.getElementsByTagName("Balanace")[0];      
        //	alert(Blanace);	 
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			
		str=str+"<tr>"
		
		str=str+"<td width='50' class='boldEleven'>"+Purchaseid.childNodes[0].nodeValue;		
		str=str+"<td width='40' class='boldEleven'>"+Totalamount.childNodes[0].nodeValue;
		str=str+"<td width='40' class='boldEleven'>"+Paidamount.childNodes[0].nodeValue;
		str=str+"<td width='60' class='boldEleven'>"+Balanace.childNodes[0].nodeValue;
		
     }
     str=str+"</table>";
     var tb=document.getElementById('CustomerPaymentTable');
  	 tb.innerHTML=str  ; 
}



