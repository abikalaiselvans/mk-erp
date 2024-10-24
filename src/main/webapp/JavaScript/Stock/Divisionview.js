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
 


function LoadDivision(startletter) 
{	
	
	var url = "../Stock?actionS=LoadDivision&startletter="+escape(startletter);
	initRequest(url);
    req.onreadystatechange = DivisionRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function DivisionRequest() {
    if(req.readyState == 4) {
        Clear('divscroll');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML= "";
        if (req.status == 200) 
        {
          DivisionMessages();
        }
    }
}
function DivisionMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Divisons")[0];   	    
	var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Divisonid = batch.getElementsByTagName("Divisonid")[0];
        var Shortname = batch.getElementsByTagName("ShortName")[0];
        var DivisonName = batch.getElementsByTagName("DivisonName")[0];
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		  
		str=str+"<td  class='boldEleven'><input  name='Divisionid'  id='Divisionid'  type='checkbox' value='"+Divisonid.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+DivisonName.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Shortname.childNodes[0].nodeValue;
		  
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 