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
	 var str="<center class='bolddeepred'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'><font color='red'><b>Data not found</b></font><center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function LoadDirectSale(startletter) 
{	
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../Stock?actionS=LoadDirectSale&startletter="+startletter+"&division="+division+"&customer="+customer+"&month="+month+"&year="+year;
   	initRequest(url);
    req.onreadystatechange = DirectPurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function DirectPurchaseRequest() {
    if(req.readyState == 4) {
        Clear('DirectSaleTable');
        
        if (req.status == 200) 
        {
          DirectPurchaseMessages();
        }
    }
}
function DirectPurchaseMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Saless")[0];   	    
	var str=""; 
	str=str+" <table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Salesid = batch.getElementsByTagName("Salesid")[0];
        var SalesNumber = batch.getElementsByTagName("SalesNumber")[0];
        var Cutomername = batch.getElementsByTagName("Cutomername")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Amount = batch.getElementsByTagName("Amount")[0];
        var PaymentStatus = batch.getElementsByTagName("PaymentStatus")[0];
        
         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		str=str+"<td  class='boldEleven'><input  name='Salesid'  id='Salesid'  type='checkbox' value='"+Salesid.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+SalesNumber.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Cutomername.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Amount.childNodes[0].nodeValue;
		if("Y" == PaymentStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven'>Completed";
		else if("N" == PaymentStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven'>Pending ";	
		else if("P" == PaymentStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven'>Partially Paid";	
		Print	
		str=str+"<td  class='boldEleven'><a href=''>View</a> /  <a href=\"javascript:Print('"+SalesNumber.childNodes[0].nodeValue+"')\">Print</a>";	
		
		
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('DirectSaleTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 