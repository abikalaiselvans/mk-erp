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
 


function LoadVendorGroup(startletter) 
{	
	var url = "../Stock?actionS=LoadVendorGroup&startletter="+startletter;     
   	initRequest(url);
    req.onreadystatechange = VendorGroupRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function VendorGroupRequest() {
    if(req.readyState == 4) {
        Clear('divscroll');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML= "";
        if (req.status == 200) 
        {
          VendorGroupMessages();
        }
    }
}
function VendorGroupMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("VendorGroups")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var VendorGroupid = batch.getElementsByTagName("VendorGroupid")[0];
        var VendorGroupName = batch.getElementsByTagName("VendorGroupName")[0];
       
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		   
		
		str=str+"<td  class='boldEleven'><input id='VendorGroupid'  name='VendorGroupid' "+VendorGroupid.childNodes[0].nodeValue+" type='checkbox' value='"+VendorGroupid.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+VendorGroupName.childNodes[0].nodeValue;
		 	
		
	 }
     str=str+"</table>";

     
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 