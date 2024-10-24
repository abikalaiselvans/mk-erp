var isIE;
var req;
var names;
  
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
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
   try
   {
        var office=document.getElementById('office').value;
		var url = "../inventory?actionS=LoadBranchess&office="+escape(office);
		initRequest(url);
	    req.onreadystatechange = branchRequest;
	    req.open("GET", url, true);
	    req.send(null);
	    
	  
	  }
	catch(err)	
	{
		alert(err.description)
	}  
}

function LoadBranchess() 
{
    office=document.getElementById('office').value;
	var url = "inventory?actionS=LoadBranchess&office="+escape(office);
	initRequest(url);
    req.onreadystatechange = branchRequest;
    req.open("GET", url, true);
    req.send(null);
} 

function branchRequest() {
    if(req.readyState == 4) {
        Clear('branchTable');
        document.getElementById('Submit').disabled=true;
        if (req.status == 200) {
          branchMessages();
        }
    }
}
function branchMessages() {
    var batchs = req.responseXML.getElementsByTagName("branches")[0];   	    
	var str="";
	 var selectid="";
	var chk=""; 
	str=str+"<table   width='600' border='0' class='boldEleven' cellspacing=1 cellpadding=2>";
    str=str+"<tr  class='MRow1'><td width='450' class='bold1' align='center'><div align='center'>Company Name</div>";
	str=str+"<td width='150' class='bold1' align='center'><div align='center'>Branch Name</div>";
	
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Companyid = batch.getElementsByTagName("Companyid")[0];
        var CompanyName = batch.getElementsByTagName("CompanyName")[0];
        var Branchid = batch.getElementsByTagName("Branchid")[0];
        var BranchName = batch.getElementsByTagName("BranchName")[0];
        var Selection = batch.getElementsByTagName("Selection")[0];
		selectid = Selection.childNodes[0].nodeValue;                                   
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		    
		selectid = Selection.childNodes[0].nodeValue; 
		if(selectid == Companyid.childNodes[0].nodeValue)
			chk=" checked	 ";
		else
			chk="";
		 
		str=str+"<td width='450' class='boldEleven'><input   name='branchid'  id='branchid' "+chk+" type='radio' value='"+Branchid.childNodes[0].nodeValue+"' /> "+CompanyName.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+BranchName.childNodes[0].nodeValue;
		var Selection = batch.getElementsByTagName("Selection")[0];
		
		 
		
	 }
     str=str+"</table>";
      
     var tb=document.getElementById('branchTable');
  	 tb.innerHTML=str  ; 
  	 if(batchs.childNodes.length >0)
  	 	document.getElementById('Submit').disabled=false;
  	 else
  	 	document.getElementById('Submit').disabled=true;	
  	setOptionValue('branchid',selectid);   
}

 