var req;
var isIE;
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

function initSerial()
{
	try
	{
		var itemvalue=document.getElementById("Asset").value; 
		var url = "../inventory?actionS=serialNum&itemvalue="+escape(itemvalue);
		initRequest(url);
		req.onreadystatechange=processResponseSerial;
		req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 

function processResponseSerial() 
{ 
	try
 	{ 
		if(req.readyState == 4)
		{        
			if (req.status == 200) 
			{		  	
				LoadSerialMessages();
			}
    	
		}
	}
	catch(err)
	{
		alert(err);
	} 
}

function LoadSerialMessages() 
{	 
	try
	{
		clearSelect('serialId');
	var batchs = req.responseXML.getElementsByTagName("Rowserial")[0];
    var _targ=document.getElementsByName('serialId')[0];       
    _targ.options.length=0;	
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("serialNo")[0];      
        var batchId = batch.getElementsByTagName("id")[0];
		var disName =firstName.childNodes[0].nodeValue;
		 _targ.options[loop]=new Option(disName,disName);
        }		
		_targ.options.length=loop;
		_targ.selectedIndex=0;
	
  
  	}
 	catch(err)
 	{
 		alert(err);
 	}	
}


 