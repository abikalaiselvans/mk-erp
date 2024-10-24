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
 
 
function loadComboJobTitles(dval) 
 {	
    id=document.getElementById(dval).value; 
    startLetter="";       
    var url = "../SmartHRM?actionS=JobCode&id="+escape(id)+"&startLetter="+escape(startLetter) 
    initRequest(url);    
    req.onreadystatechange = jobComboTitleRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadComboJobTitleAll(dval) 
 {	
    id=dval.value;  
	startLetter="";       
    var url = "../SmartHRM?actionS=JobCode&id="+escape(id)+"&startLetter="+escape(startLetter);
    initRequest(url);    
    req.onreadystatechange = jobComboTitleRequest;
    req.open("GET", url, true);
    req.send(null);
}

function jobComboTitleRequest() 
{
    if (req.readyState == 4) 
    {
       	clearSelect('jobtitle');
       	 var _targ=document.getElementsByName('jobtitle')[0];
       	 _targ.options[0]=new Option('All','0'); 
       	 if (req.status == 200) 
       	 {
       		 jobComboTitleMessages();
       	 } 
    }
}
function jobComboTitleMessages() 
{
     var batchs = req.responseXML.getElementsByTagName("jobs")[0];    		 
     var _targ=document.getElementsByName('jobtitle')[0];
      _targ.options[0]=new Option('All','0'); 
     for (loop = 0; loop < batchs.childNodes.length; loop++) 
     {
	    var batch = batchs.childNodes[loop];
	    var batchId=batch.getElementsByTagName("id")[0];     
        var firstName = batch.getElementsByTagName("name")[0];   
        _targ.options[loop+1]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop+1;
      
}
 
 
 