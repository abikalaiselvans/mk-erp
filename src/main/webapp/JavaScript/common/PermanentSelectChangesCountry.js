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

 




 
function PLoadSelectState()
 {
 	 
 	var country = document.getElementById('pcountry').value;
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
	     var _targ=document.getElementsByName('pstate')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select State','0'); 
	     
	     
	     obj = findObj("pdistrict"); 
		 	if(obj != null)
		 	{
		 		 var _targ1=document.getElementsByName('pdistrict')[0];       
			   	 _targ1.options.length=0;
			   	 _targ1.options[0]=new Option('Select District','0');  
			     	
		 	} 
		     
		   	 
		 	obj = findObj("pcity"); 
		 	if(obj != null)
		 	{
		 		var _targ2=document.getElementsByName('pcity')[0];       
			   	 _targ2.options.length=0;
			   	 _targ2.options[0]=new Option('Select City','0');  
			     
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
    var _targ=document.getElementsByName('pstate')[0];       
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


 
function PLoadSelectDistrict()
{
	var state = document.getElementById('pstate').value;
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
		
	   obj = findObj("pcity"); 
	 	if(obj != null)
	 	{
	 		var _targ2=document.getElementsByName('pcity')[0];       
		   	 _targ2.options.length=0;
		   	 _targ2.options[0]=new Option('Select City','0');  
		     
	 	}
	 	
	   var _targ=document.getElementsByName('pdistrict')[0];       
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
   var _targ=document.getElementsByName('pdistrict')[0];       
   _targ.options.length=0;
   _targ.options[0]=new Option('SelectDistrict','0');  
   var str=""; 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
   {	     
       var batch = batchs.childNodes[loop];
        
       var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
   }
}





function PLoadSelectCity()
 {
 	var state = document.getElementById('pstate').value;
 	var district = document.getElementById('pdistrict').value;
 	var url = "../Common?actionS=LoadSelectCity&state="+state+"&district="+district;
 	initRequest(url);
 	req.onreadystatechange=LoadSelectSelectCityRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadSelectSelectCityRequest() {
    if(req.readyState == 4) 
    { 
    
     var _targ=document.getElementsByName('pcity')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select City','0');  
    	 if (req.status == 200) 
        {		  	
          LoadSelectSelectCityMessages();
        }
    }
}
function LoadSelectSelectCityMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('pcity')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select City','0');  
    var str=""; 
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
	 	
}



























  
  
 



 



 
var pincodectr="";
function PAssignPincode(ctr)
 {
 	pincodectr=ctr;
 	var city = document.getElementById('pcity').value;
 	if(city !="0")
 	{
 		var url = "../Common?actionS=AssignPincode&city="+city;
 		initRequest(url);
 		req.onreadystatechange=AssignPincodeRequest;
    	req.open("GET", url, true);
    	req.send(null);
    }	
}
 
 function AssignPincodeRequest() {
    if(req.readyState == 4) 
    { 
    
     document.getElementById(pincodectr).value='0';       
    	 if (req.status == 200) 
        {		  	
          AssignPincodeMessages();
        }
    }
}
function AssignPincodeMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var str=""; 
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var pincode = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    document.getElementById(pincodectr).value=pincode;
    }
	 	
}




 