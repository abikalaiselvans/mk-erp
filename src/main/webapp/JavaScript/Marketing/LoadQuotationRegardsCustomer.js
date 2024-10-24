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
 
 
 

function LoadQuotationRegardsCustomer()
{
	try
	{
	 	var customer = document.getElementById('customer').value;
	 	var url = "../marketing?actionS=LoadQuotationRegardsCustomer&customer="+customer ;
	 	req.onreadystatechange=LoadQuotationRegardsCustomerRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadQuotationRegardsCustomerRequest() 
 {
 	try
 	{
 		if(req.readyState == 4) 
	    {
 			var _targ=document.getElementsByName('quotation')[0];       
		    _targ.options.length=0;
		    _targ.options[0]=new Option('Select Quotation','0');  
		    if (req.status == 200) 
	        {		  	
	    		LoadQuotationRegardsCustomerMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
 
function LoadQuotationRegardsCustomerMessages() 
{	 
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
		var _targ=document.getElementsByName('quotation')[0];       
		_targ.options.length=0;
		_targ.options[0]=new Option('Select Quotation','0');  
		 var str=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {	     
	        var batch = batchs.childNodes[loop];
	        var Quote = batch.getElementsByTagName("Quote")[0].childNodes[0].nodeValue;
		    var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
		    var Amount = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
		    
		    _targ.options[loop+1]=new Option(Quote+" [ Rs."+Amount+" ]",Rowid);
		}
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


