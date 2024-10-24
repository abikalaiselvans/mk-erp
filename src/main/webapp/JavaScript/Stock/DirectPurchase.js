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

function ClearTable(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function loadDirectPurchase(startletter) 
{	
	var division=document.getElementById('division').value;
	var vendor=document.getElementById('vendor').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../Stock?actionS=LoadDirectPurchase&startletter="+startletter+"&division="+division+"&vendor="+vendor+"&month="+month+"&year="+year;
   	initRequest(url);
    req.onreadystatechange = DirectPurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function DirectPurchaseRequest() {
    if(req.readyState == 4) {
        Clear('DirectPurchaseTable');
        if (req.status == 200) 
        {
          DirectPurchaseMessages();
        }
    }
}
function DirectPurchaseMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Purchases")[0];   	    
	var str=""; 
	str=str+"<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    var r=0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    r = loop;
	    var batch = batchs.childNodes[loop];
        var Purchaseid = batch.getElementsByTagName("Purchaseid")[0];
        var PurchaseNumber = batch.getElementsByTagName("PurchaseNumber")[0];
        var Vendorname = batch.getElementsByTagName("Vendorname")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Amount = batch.getElementsByTagName("Amount")[0];
        var PaymentStatus = batch.getElementsByTagName("PaymentStatus")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		str=str+"<td  class='boldEleven'><input  name='Purchaseid'  id='Purchaseid'  type='checkbox' value='"+Purchaseid.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+PurchaseNumber.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Vendorname.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Amount.childNodes[0].nodeValue;
		if("Y" == PaymentStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven'>Completed";
		else if("N" == PaymentStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven'>Pending ";	
		else if("P" == PaymentStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven'>Partially Paid";	
			
		str=str+"<td  class='boldEleven'><a href='#'>Print</a>";	
		
		
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('DirectPurchaseTable');
  	 tb.innerHTML=str  ; 
  	 r=batchs.childNodes.length;
     str = "<font class='deepboldred'>Total no of Records ::"+r +"</font>"; 
  	 document.getElementById("totRec").innerHTML= str;
  	 
}

 