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
  

 
 function loadStaffName() 
{		
	 
	     
    var office = document.getElementById('Office').value;  
    var url = "../attendance?actionS=loadStaffName&Office="+office ;
	 
	initRequest(url);
	req.onreadystatechange=loadStaffNameRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 
 function loadStaffNameRequest() 
 {
    if(req.readyState == 4) 
    { 
	     var _targ=document.getElementsByName('staffid')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('All','0');  
	   	 if (req.status == 200) 
	     {		  	
        	loadStaffNameMessages();
       	}
    }
}

function loadStaffNameMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0]; 
    var _targ=document.getElementsByName('staffid')[0];       
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

 