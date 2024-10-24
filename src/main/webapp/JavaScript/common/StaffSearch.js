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
 
var controlname="";  
function loadSearchStaff(sval,con) 
{
   controlname=con
	var search=sval.value; 
	var url = "../Common?actionS=loadSearchStaff&search="+escape(search);
	 
	initRequest(url);
    req.onreadystatechange = SelectRequest;
    req.open("GET", url, true);
    req.send(null);
}
 function SelectRequest() {
    if(req.readyState == 4) 
    { 
    	var _targ=document.getElementsByName(controlname)[0];       
    	_targ.options.length=0;
    	_targ.options[0]=new Option('Select','0');  
    	if (req.status == 200) 
        {		  	
          	SelectMessages();
        }
    }
}
function SelectMessages() 
{	 
     
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0]; 
    
    var _targ=document.getElementsByName(controlname)[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
     
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Id+" / "+ Name,Id);
		
    }
	 	
}
