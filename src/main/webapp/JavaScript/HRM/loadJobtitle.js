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


 

 
function LoadDemandJobTitle()
 {
 	var jobgrade = document.getElementById('jobgrade').value;
 	var url = "../SmartHRM?actionS=LoadDemandJobTitle&jobgrade="+jobgrade;
 	initRequest(url);
	req.onreadystatechange=LoadDemandJobTitleRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadDemandJobTitleRequest() 
 {
    if(req.readyState == 4) 
    { 
	     var _targ=document.getElementsByName('jobTitle')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select jobTitle','0');  
	   	 if (req.status == 200) 
	     {		  	
        	LoadDemandJobTitleMessages();
       	}
    }
}

function LoadDemandJobTitleMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('jobTitle')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select jobTitle','0');  
    var str=""; 
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
	    var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue;
	    var title = batch.getElementsByTagName("title")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(code+"/"+title,Id);
		
    }
	 	
}

