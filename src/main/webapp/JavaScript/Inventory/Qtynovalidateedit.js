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
 
 function validQtynoedit(sval){
   try
   {
	var consumableproduct = document.getElementById('prodid').value;
	var spoldqty = document.getElementById('spoldqty').value;
	var url = "../inventoryCustomer?actionS=Loadvalidqtynoedit&qtyno="+escape(sval)+"&consumable="+consumableproduct+"&oldqty="+spoldqty;
    initRequest(url);
    req.onreadystatechange = SpareQtycheckconsumableRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function SpareQtycheckconsumableRequest() 
{
    if(req.readyState == 4) 
    {
        if (req.status == 200) 
        {
        	SpareQtycheckconsumablesMessages();
        }
    }
}


function SpareQtycheckconsumablesMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("qtyconsumno")[0];   
    	var str="<table width='100' >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        	if(Status == 'Valid')
        	{
	    		document.getElementById('submit_btn').disabled=false;
	    		str = str+"<tr><td><font class='changePos' >Stock Available..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('submit_btn').disabled=true;
	    		str = str+"<tr><td  class='bolddeepred'>Stock NotAvailable...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById('divqtyeditname');
  	 	tb.innerHTML=str  ; 
 }
 