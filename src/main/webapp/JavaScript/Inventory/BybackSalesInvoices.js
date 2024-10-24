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
 
 

function loadBybackSalesnumber()
{
	try
	{
		if(document.getElementById('byback').checked)
		{
			var url = "../inventory?actionS=loadBybackSalesnumber";
		 	var tob=document.getElementById('divscroll');
			req.onreadystatechange=loadBybackSalesnumberRequest;
		    req.open("GET", url, true);
		    req.send(null);
		}
		else
		{
			 var _targ=document.getElementsByName('salesnumber')[0];       
			 _targ.options.length=0;
			 _targ.options[0]=new Option('Select salesnumber','0'); 
		}
	}
	catch(err)
	{
		alert(err);
	}
}
 


 

function loadBybackSalesnumberRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	    	 var _targ=document.getElementsByName('salesnumber')[0];       
		     _targ.options.length=0;
		     _targ.options[0]=new Option('Select salesnumber','0');  
		     
	    	if (req.status == 200) 
	        {		  	
	    		loadBybackSalesnumberMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function loadBybackSalesnumberMessages() 
{	 
	 try
	 {
		 	var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
		    var _targ=document.getElementsByName('salesnumber')[0];       
		    _targ.options.length=0;
		    _targ.options[0]=new Option('Select salesnumber','0');  
		    var str=""; 
		    for(loop = 0; loop < batchs.childNodes.length; loop++) 
		    {	     
		        var batch = batchs.childNodes[loop];
		        var Invoice = batch.getElementsByTagName("Invoice")[0].childNodes[0].nodeValue;
			     _targ.options[loop+1]=new Option(Invoice,Invoice);
				
		    }
	 }
 	 catch(err)
 	 {
 		alert(err.description);
 	 }    	
}


