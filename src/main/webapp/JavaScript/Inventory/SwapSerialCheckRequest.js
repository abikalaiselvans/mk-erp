
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
  

function LoadSwapcheckSerial(Serial,Item,Type) 
{
	var url = "../inventoryCustomer?actionS=LoadSwapcheckSerial&Serial="+escape(Serial)+"&Item="+escape(Item)+"&Type="+Type;
	var tb=document.getElementById('mythra');
	tb.innerHTML=" Checking "+Serial;
	initRequest(url);
   	req.onreadystatechange = LoadSwapcheckSerialRequest;
   	req.open("GET", url, true);
    req.send(null);
}
 
  
 
function LoadSwapcheckSerialRequest() 
{
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {		  	
          LoadSwapcheckSerialMessages();
        }
    }
}

function LoadSwapcheckSerialMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Serials")[0];   	    
	var str="";
	var tb=document.getElementById('mkmythra');
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Exsist = batch.getElementsByTagName("Exsist")[0].childNodes[0].nodeValue;
        var Nos = batch.getElementsByTagName("Nos")[0].childNodes[0].nodeValue;
        if(Exsist == "FALSE")
        {
        		tb.innerHTML="Kindly checkup, Serial Number is ::" +Nos;
        		alert("Kindly checkup, Serial Number is ::" +Nos);
        }
	   
        
    }
    
  	
	  
}