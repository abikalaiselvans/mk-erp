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






 
function CLoadSelectState()
 {
 	 
 	var country = document.getElementById('ccountry').value;
 	var url = "../Common?actionS=LoadSelectState&country="+country;
 	 
 	initRequest(url);
	req.onreadystatechange=CLoadSelectStateRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function CLoadSelectStateRequest() 
 {
    if(req.readyState == 4) 
    { 
	     var _targ=document.getElementsByName('cstate')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select State','0');  
	   	 if (req.status == 200) 
	     {		  	
        	CLoadSelectStateMessages();
       	}
    }
}

function CLoadSelectStateMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('cstate')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select State','0');  
    var str=""; 
     
    
    obj = findObj("cdistrict"); 
 	if(obj != null)
 	{
 		 var _targ1=document.getElementsByName('cdistrict')[0];       
	   	 _targ1.options.length=0;
	   	 _targ1.options[0]=new Option('Select District','0');  
	     	
 	} 
     
   	 
 	obj = findObj("ccity"); 
 	if(obj != null)
 	{
 		var _targ2=document.getElementsByName('ccity')[0];       
	   	 _targ2.options.length=0;
	   	 _targ2.options[0]=new Option('Select City','0');  
	     
 	}
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
	 	
}




 
function CLoadSelectDistrict()
{
	var state = document.getElementById('cstate').value;
	var url = "../Common?actionS=LoadSelectDistrict&state="+state;
	initRequest(url);
	req.onreadystatechange=CLoadSelectDistrictRequest;
   	req.open("GET", url, true);
  	req.send(null);
}


function CLoadSelectDistrictRequest() 
{
   if(req.readyState == 4) 
   { 
		
	   obj = findObj("ccity"); 
	 	if(obj != null)
	 	{
	 		var _targ2=document.getElementsByName('ccity')[0];       
		   	 _targ2.options.length=0;
		   	 _targ2.options[0]=new Option('Select City','0');  
		     
	 	}
	 	
	   var _targ=document.getElementsByName('cdistrict')[0];       
   		_targ.options.length=0;
   		_targ.options[0]=new Option('Select District','0'); 
   		if (req.status == 200) 
       	{		  	
         		CLoadSelectDistrictMessages();
       	}
   }
}


function CLoadSelectDistrictMessages() 
{	 
    
   var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
   var _targ=document.getElementsByName('cdistrict')[0];       
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





function CLoadSelectCity()
 {
 	var state = document.getElementById('cstate').value;
 	var district = document.getElementById('cdistrict').value;
 	var url = "../Common?actionS=LoadSelectCity&state="+state+"&district="+district;
 	initRequest(url);
 	req.onreadystatechange=CLoadSelectSelectCityRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function CLoadSelectSelectCityRequest() {
    if(req.readyState == 4) 
    { 
    
     var _targ=document.getElementsByName('ccity')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select City','0');  
    	 if (req.status == 200) 
        {		  	
          CLoadSelectSelectCityMessages();
        }
    }
}
function CLoadSelectSelectCityMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('ccity')[0];       
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



























  
  
 



 



 
 pincodectr="";
function CAssignPincode(ctr)
 {
 	pincodectr=ctr;
 	var city = document.getElementById('ccity').value;
 	if(city !="0")
 	{
 		var url = "../Common?actionS=AssignPincode&city="+city;
 		initRequest(url);
 		req.onreadystatechange=CAssignPincodeRequest;
    	req.open("GET", url, true);
    	req.send(null);
    }	
}
 
 function CAssignPincodeRequest() {
    if(req.readyState == 4) 
    { 
    
     document.getElementById(pincodectr).value='0';       
    	 if (req.status == 200) 
        {		  	
          AssignPincodeMessages();
        }
    }
}
function CAssignPincodeMessages() 
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




 