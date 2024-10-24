
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
  
 

function loadPurchaseRequestDate() 
{
	var purchaserequest=document.getElementById('purchaserequest').value;
	var url = "../inventory?actionS=loadPurchaseRequestDate&purchaserequest="+escape(purchaserequest);
	//INVServiceBilling
   	initRequest(url);
   	req.onreadystatechange = loadPurchaseRequestDateRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function loadPurchaseRequestDateRequest() 
{	
	if(req.readyState == 4) 
    {    	
        
       if (req.status == 200)
        {
        	loadPurchaseRequestDateMessages();
        }
    }
}


function loadPurchaseRequestDateMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop] ;
        var Date= batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
		document.getElementById('proposedpurchasedate').value= Date;
		 
		
     }
     
     
  	
} 

  
  