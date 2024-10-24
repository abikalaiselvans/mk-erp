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

        if (element && element.options) 
        {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}



function ClearTable(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

//-----------------------------------------Staff-------------------
function loadStaff(startLetter)
 {
 	var companyId=document.getElementById('company').value;   	
 	var branchId= document.getElementById('branch').value;   	
    var departId=document.getElementById('depart').value;     
    var desigId=document.getElementById('designation').value;       
    var url = "../attendance?actionS=ATTstaff&departId="+escape(departId)+"&desigId="+escape(desigId)+"&branchId="+escape(branchId)+"&companyId="+escape(companyId)+"&startLetter="+escape(startLetter);  
    initRequest(url);
    req.onreadystatechange = searchStaffRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function searchStaffRequest()
 {
    if(req.readyState == 4) {
        ClearTables('staffTable');
         if (req.status == 200) {
          searchStaff();
        }
    }
}
function searchStaff() 
{	
    var batchs = req.responseXML.getElementsByTagName("Staffs")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";  
    str=str+"<tr bgcolor='#DCE4F9' >"
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var StaffId = batch.getElementsByTagName("StaffId")[0];
        var StaffName = batch.getElementsByTagName("StaffName")[0];  
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('staffTable');
  	 tb.innerHTML=str  ;      
}






function loadBranch() 
{
     
    var companyid=document.getElementById('company').value;   
    var url = "../SmartCommonAjax?actionS=loadBranchSelect&companyid="+escape(companyid);
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
       _targ.options[0]=new Option('Select Branch','Select');
       _targ.options[0]=new Option('All','0');
        if (req.status == 200) 
        {
          branchSDetails();
        }
    }
}

function branchSDetails() 
{
	try
	{
	    var batchs = req.responseXML.getElementsByTagName("Rows")[0];      
		var _targ=document.getElementsByName('branch')[0];       
	    _targ.options.length=0;
	    _targ.options[0]=new Option('Select Branch','Select');
	    _targ.options[0]=new Option('All','0');
	
	    for (loop = 0; loop < batchs.childNodes.length; loop++) 
	    {
		    var batch = batchs.childNodes[loop];
	        var firstName = batch.getElementsByTagName("branchName")[0].childNodes[0].nodeValue;
	        var batchId = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
	        _targ.options[loop+1]=new Option(firstName,batchId);
	    }
		_targ.options.length=loop+1;
		_targ.selectedIndex=0;
	}
	catch(err)
	{
		alert(err);
	}
}
