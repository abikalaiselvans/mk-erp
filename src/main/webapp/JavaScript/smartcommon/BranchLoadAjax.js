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
 
function clearSelect() 
{
    for (var i = 0; i < arguments.length; i++) 
    {
        var element = arguments[i];
        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];
        if (element && element.options) {
            element.options.length = 0;
            element.selectedIndex = 0;
        }
    }
}

function loadBranch() 
{
    var id=document.getElementById('company').value;   
    var url = "../SmartCommonAjax?actionS=loadBranchInSelect&id="+escape(id);   
    
    initRequest(url);
    req.onreadystatechange = branchSRequest;
    req.open("GET", url, true);
    req.send(null);
}

function branchSRequest() 
{
    if(req.readyState == 4) 
    {    
       clearSelect('branch');
       var _targ=document.getElementsByName('branch')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('Select Branch','0');       
        if (req.status == 200) 
        {
          branchSDetails();
        }
    }
}

function branchSDetails() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];      
	var _targ=document.getElementsByName('branch')[0];       
     _targ.options.length=0;
     _targ.options[0]=new Option('Select Branch','0');
     for (loop = 0; loop < batchs.childNodes.length; loop++) 
     {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("branchName")[0].childNodes[0].nodeValue;
        var batchId = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue;
         
        if(Active =="0")
        	_targ.options[loop+1]=new Option(firstName+"  [ Inactive ] ",batchId  );
        else	
        	_targ.options[loop+1]=new Option(firstName,batchId  );
      }
	_targ.options.length=loop+1;
	_targ.selectedIndex=0;
}