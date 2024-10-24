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
 
 function validQtyno(sval){
   try
   {
	
	var consumableproduct = document.getElementById('consumableproduct').value;
    var url = "../inventoryCustomer?actionS=Loadvalidqtyno&qtyno="+escape(sval)+"&consumable="+consumableproduct;
    initRequest(url);
    req.onreadystatechange = SpareQtycheckRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function SpareQtycheckRequest() 
{
    if(req.readyState == 4) 
    {
        document.getElementById('submit_btn').disabled=false;
		if (req.status == 200) 
        {
        	SpareQtycheckMessages();
        }
    }
}


function SpareQtycheckMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("qtyno")[0];   
    	var str="<table width='100%' >"; 
    	 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        	 
        	if(Status == 'Valid')
        	{
	    		document.getElementById('submit_btn').disabled=false;
	    		str = str+"<tr><td><font class='changePos' >Stock Available..</font></td></tr>";
	    	}
			else if(Status=='0')
			{
				str = str+"<tr><td  class='bolddeepred'>Stock Not Available...</td></tr>" ;
			}
	    	else
	    	{
	    		document.getElementById('submit_btn').disabled=true;
	    		str = str+"<tr><td  class='bolddeepred'>Stock Not Available...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	 
	 	var tb=document.getElementById('divqtyname');
  	 	tb.innerHTML=str  ; 
 }
 