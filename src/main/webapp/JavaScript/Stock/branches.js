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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
}
 

function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function LoadBranches() 
{
    company=document.getElementById('company').value;
	var url = "../Stock?actionS=LoadBranchess&company="+escape(company);
   	initRequest(url);
    req.onreadystatechange = branchRequest;
    req.open("GET", url, true);
    req.send(null);
}

 
function branchRequest() 
{
    if(req.readyState == 4) 
    {
        Clear('branchTable');
        document.getElementById('Submit').disabled=true;
        if (req.status == 200) 
        {
          branchMessages();
        }
    }
}


function branchMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("branches")[0];   	    
	var str=""; 
	str=str+"<table   width='600' border='0' class='boldEleven' cellspacing=1 cellpadding=2>";
    str=str+"<tr  class='MRow1'><td width='450' class='bold1' align='center'><div align='center'>Company Name</div>";
	str=str+"<td width='150' class='bold1' align='center'><div align='center'>Branch Name</div>";
	var c="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var CompanyName = batch.getElementsByTagName("CompanyName")[0];
        var Branchid = batch.getElementsByTagName("Branchid")[0];
        var BranchName = batch.getElementsByTagName("BranchName")[0];
    	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		 if(loop==(batchs.childNodes.length-1))   	
		    c=  " checked='checked' ";
		str=str+"<td width='450' class='boldEleven'><input  name='branchid' "+c+" type='radio' value='"+Branchid.childNodes[0].nodeValue+"' /> "+CompanyName.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+BranchName.childNodes[0].nodeValue;
	 }
     str=str+"</table>";
     var tb=document.getElementById('branchTable');
  	 tb.innerHTML=str  ; 
  	 if(batchs.childNodes.length >0)
  	 	document.getElementById('Submit').disabled=false;
  	 else
  	 	document.getElementById('Submit').disabled=true;	
}


 