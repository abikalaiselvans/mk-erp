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


//Load Make
function LoadSelectHomeMake()
 {
 	var vehicletype = document.getElementById('vehicletype').value;
 	var url = "../Transport?actionS=LoadSelectHomeMake&vehicletype="+vehicletype;
 	initRequest(url);
	req.onreadystatechange=LoadSelectHomeMakeRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function LoadSelectHomeMakeRequest() 
{
    if(req.readyState == 4) 
    { 
     var _targ=document.getElementsByName('vehiclemake')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
    	 if (req.status == 200) 
        {		  	
         LoadSelectHomeMakeMessages();
        }
    }
}

function LoadSelectHomeMakeMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('vehiclemake')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
    var str=""; 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
}






//Load Model
function LoadSelectHomeModel()
 {
 	var vehicletype = document.getElementById('vehicletype').value;
 	var vehiclemake = document.getElementById('vehiclemake').value;
 	var url = "../Transport?actionS=LoadSelectHomeModel&vehicletype="+vehicletype+"&vehiclemake="+vehiclemake;
   	initRequest(url);
	req.onreadystatechange=LoadSelectHomeModelRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function LoadSelectHomeModelRequest() 
{
    if(req.readyState == 4) 
    { 
     var _targ=document.getElementsByName('vehiclemodel')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
    	 if (req.status == 200) 
        {		  	
          LoadSelectHomeModelMessages();
        }
    }
}



function LoadSelectHomeModelMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('vehiclemodel')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
    var str=""; 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
    }
}


//Load Varriant
function LoadSelectHomeVarriant()
{
		var vehicletype = document.getElementById('vehicletype').value;
 		var vehiclemake = document.getElementById('vehiclemake').value;
 		var vehiclemodel = document.getElementById('vehiclemodel').value;
 		var url = "../Transport?actionS=LoadSelectHomeVarriant&vehicletype="+vehicletype+"&vehiclemake="+vehiclemake+"&vehiclemodel="+vehiclemodel;
   		initRequest(url);
		req.onreadystatechange=LoadSelectHomeVarriantRequest;
    	req.open("GET", url, true);
    	req.send(null);
}
 
 
function LoadSelectHomeVarriantRequest() 
{
    	if(req.readyState == 4) 
    	{ 
     			var _targ=document.getElementsByName('varriant')[0];       
    			_targ.options.length=0;
    			_targ.options[0]=new Option('Select','0');  
    	 		if (req.status == 200) 
        		{		  	
         			LoadSelectHomeVarriantMessages();
        		}
    	}
}



function LoadSelectHomeVarriantMessages() 
{	 
    	var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    	var _targ=document.getElementsByName('varriant')[0];       
    	_targ.options.length=0;
    	_targ.options[0]=new Option('Select','0');  
    	var str=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{	     
        	var batch = batchs.childNodes[loop];
        	var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    	var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(Name,Id);
    	}
}




function LoadSelectVarriant()
{
		var vehicletype = document.getElementById('vehicletype').value;
 		var vehiclemake = document.getElementById('vehiclemake').value;
 		var vehiclemodel = document.getElementById('vehiclemodel').value;
 		var url = "../Transport?actionS=LoadSelectHomeVarriant&vehicletype="+vehicletype+"&vehiclemake="+vehiclemake+"&vehiclemodel="+vehiclemodel;
   		initRequest(url);
		req.onreadystatechange=LoadSelectVarriantRequest;
    	req.open("GET", url, true);
    	req.send(null);
}
 
 
function LoadSelectVarriantRequest() 
{
    	if(req.readyState == 4) 
    	{ 
     			var _targ=document.getElementsByName('varriant')[0];       
    			_targ.options.length=0;
    			_targ.options[0]=new Option('All','0');  
    	 		if (req.status == 200) 
        		{		  	
         			LoadSelectVarriantMessages();
        		}
    	}
}



function LoadSelectVarriantMessages() 
{	 
    	var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    	var _targ=document.getElementsByName('varriant')[0];       
    	_targ.options.length=0;
    	_targ.options[0]=new Option('All','0');  
    	var str=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{	     
        	var batch = batchs.childNodes[loop];
        	var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    	var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(Name,Id);
    	}
}








function LoadSelectVehicleinfo()
{
		var typeid= document.getElementById('vehicletype').value;
 		var makeid= document.getElementById('vehiclemake').value;
 		var modelid= document.getElementById('vehiclemodel').value;
 		var varriant= document.getElementById('varriant').value;
 		var url = "../Transport?actionS=LoadVechicleInfo&startLetter=0&typeid="+typeid+"&makeid="+makeid+"&modelid="+modelid+"&varriant="+varriant
 	 	initRequest(url);
		req.onreadystatechange=LoadSelectVehicleinfoRequest;
    	req.open("GET", url, true);
    	req.send(null);
}
 
 
function LoadSelectVehicleinfoRequest() 
{
    	if(req.readyState == 4) 
    	{ 
     			var _targ=document.getElementsByName('vehicle')[0];       
    			_targ.options.length=0;
    			_targ.options[0]=new Option('Select','0');  
    	 		if (req.status == 200) 
        		{		  	
         			LoadSelectVehicleinfoMessages();
        		}
    	}
}



function LoadSelectVehicleinfoMessages() 
{	 
    	var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    	var _targ=document.getElementsByName('vehicle')[0];       
    	_targ.options.length=0;
    	_targ.options[0]=new Option('Select','0');  
    	var str=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{	     
        	var batch = batchs.childNodes[loop];
        	var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    	var Regno = batch.getElementsByTagName("Regno")[0].childNodes[0].nodeValue;
	    	_targ.options[loop+1]=new Option(Regno,Id);
    	}
}









 