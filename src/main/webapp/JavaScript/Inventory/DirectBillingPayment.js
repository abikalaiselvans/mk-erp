
var isIE;
var req;
var names;

 
function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
 

function ClearTable(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadDirectBillingPayment(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var Payment=document.getElementById('Payment').value;
	var day=document.getElementById('day').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	
	//"&day="+day+"&month="+month+"&year="+year
	var url = "../inventory?actionS=loadDirectBillingPayment&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&Payment="+Payment+"&customer="+customer+"&day="+day+"&month="+month+"&year="+year;
	var tb=document.getElementById('DirectBilling');
  	tb.innerHTML=""  ; 
   	initRequest(url);
   	req.onreadystatechange = DirectBillingPaymentRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function DirectBillingPaymentRequest() 
{	
	if(req.readyState == 4) 
    {    	
		ClearTable('DirectBilling');  
        ClearTabler('totRec');  
		if (req.status == 200)
        {
        	DirectBillingPaymentMessages();
        }
    }
}


function DirectBillingPaymentMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Directs")[0];   
	//Invoiceno,Date,Customer,Ref,Amount,Status,
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	
	var dt="";
	var ch="";
	if(batchs.childNodes.length<1)
	{
		str=str+"<tr><td colspan=7>Data not found...</td></tr>";
	}
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Invoiceno = batch.getElementsByTagName("Invoiceno")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Customer = batch.getElementsByTagName("Customer")[0];
        var Ref = batch.getElementsByTagName("Ref")[0];
		var Amount= batch.getElementsByTagName("Amount")[0];
		var Status= batch.getElementsByTagName("Status")[0];
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		
		str=str+"<td  class='boldEleven'>";
		str=str+"<input name='salesid' type='checkbox' value='"+Invoiceno.childNodes[0].nodeValue+"' />"+(loop+1)	;
		str=str+"<td  class='boldEleven'>";
		str=str+Invoiceno.childNodes[0].nodeValue;

		str=str+"<td  class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Customer.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Ref.childNodes[0].nodeValue;
		str = str +"<td  class='boldEleven' align='right'>&nbsp;"+Amount.childNodes[0].nodeValue;
		str = str +"<td  class='boldEleven' align='right'>&nbsp;";
		var s = Status.childNodes[0].nodeValue;
		
		if("N"===s)
	 		str=str+"<font color=red>Pending</font>";
	 	else if("P"===s)
	 		str=str+"<font color=green>Partial Paid</font>";
	 	else if("Y"===s)
	 		str=str+"<font color=blue>Completed</font>";
	 	
     }
    if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	
     str=str+"</table>";
     var tb=document.getElementById('DirectBilling');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	
  	
}
 
