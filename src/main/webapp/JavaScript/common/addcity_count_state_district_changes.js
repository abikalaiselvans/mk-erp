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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}






 
function LoadSelectState()
 {
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
	     _targ.options[0]=new Option('Select State','0');  
	     
	    
	    obj = findObj("district"); 
	 	if(obj != null)
	 	{
	 		 var _targ1=document.getElementsByName('district')[0];       
		   	 _targ1.options.length=0;
		   	 _targ1.options[0]=new Option('Select District','0');  
		     	
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
    _targ.options[0]=new Option('Select State','0');  
    var str=""; 
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
	
}





 
function LoadSelectDistrict()
{
	var state = document.getElementById('state').value;
	var url = "../Common?actionS=LoadSelectDistrict&state="+state;
	initRequest(url);
	req.onreadystatechange=LoadSelectDistrictRequest;
   	req.open("GET", url, true);
  	req.send(null);
}


function LoadSelectDistrictRequest() 
{
   if(req.readyState == 4) 
   { 
		var _targ=document.getElementsByName('district')[0];       
   		_targ.options.length=0;
   		_targ.options[0]=new Option('Select District','0');
   		
   		 
   		if (req.status == 200) 
       	{		  	
         		LoadSelectDistrictMessages();
       	}
   }
}


function LoadSelectDistrictMessages() 
{	 
    
   var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
   var _targ=document.getElementsByName('district')[0];       
   _targ.options.length=0;
   _targ.options[0]=new Option('Select District','0');  
   var str=""; 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
   {	     
       var batch = batchs.childNodes[loop];
        
       var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
   }
}



  