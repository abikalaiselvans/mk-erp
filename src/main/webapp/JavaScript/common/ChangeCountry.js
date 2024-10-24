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
 
 
var value=""; 
function LoadSelectState(cvalue)
{
	value = cvalue;
	var country = document.getElementById('country').value;
 	var url = "../Common?actionS=LoadSelectState&country="+country;
 	initRequest(url);
	req.onreadystatechange=LoadSelectStateRequest;
    req.open("GET", url, true);
    req.send(null);
}


 function LoadSelectStateRequest() 
 {
	 
    if(req.readyState == 4) 
    { 
	     var _targ=document.getElementsByName('state')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option(value,'0');  
	     
	    
	    obj = findObj("district"); 
	 	if(obj != null)
	 	{
	 		 var _targ1=document.getElementsByName('district')[0];       
		   	 _targ1.options.length=0;
		   	 _targ1.options[0]=new Option(value,'0');  
		     	
	 	} 
	     
	   	 
	 	obj = findObj("city"); 
	 	if(obj != null)
	 	{
	 		var _targ2=document.getElementsByName('city')[0];       
		   	 _targ2.options.length=0;
		   	 _targ2.options[0]=new Option(value,'0');  
		     
	 	}
	 	
	   	 
	   	 if (req.status == 200) 
	     {		  	
        	LoadSelectStateMessages();
       	}
    }
    	
}
 
 

function LoadSelectStateMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('state')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option(value,'0');  
    var str=""; 
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
	
}


