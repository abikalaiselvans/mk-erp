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
 

function validserialno(sval) 
{
   try
   {
    var url = "../inventoryCustomer?actionS=Loadvalidserialno&serialno="+escape(sval);
    initRequest(url);
    req.onreadystatechange = SpareserialcheckRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function SpareserialcheckRequest() 
{
    if(req.readyState == 4) 
    {
        if (req.status == 200) 
        {
        	SpareserialcheckMessages();
        }
    }
}


function SpareserialcheckMessages() 
{
		
		var batchs = req.responseXML.getElementsByTagName("serialno")[0];   
    	var str="<table width='50' >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        	if(Status == 'true')
        	{
	    		document.getElementById('submit_btn').disabled=false;
	    		str = str+"<tr><td><font class='changePos' >Valid..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('submit_btn').disabled=true;
	    		str = str+"<tr><td  class='bolddeepred'>InValid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById('divunitname');
  	 	tb.innerHTML=str  ; 
 }
 