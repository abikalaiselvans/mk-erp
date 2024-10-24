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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	  
  	 
}

function loadShiftMaster(startLetter) 
{
	
	document.getElementById('Edit').disabled=true;
	var url = "../attendance?actionS=AttShiftMaster&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = ShiftMasterRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function ShiftMasterRequest() 
{
    if(req.readyState == 4) 
    {    	
        var tb=document.getElementById('ShiftMasterTable');	 
  	 	tb.innerHTML=" ";
        if (req.status== 200) 
        {		  	
        	ShiftMasterMessages();
        }
    }
}
function ShiftMasterMessages() 
{	
	var batchs = req.responseXML.getElementsByTagName("ONHOLDS")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Shiftid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Shiftname")[0].childNodes[0].nodeValue;
	    var Fromtime = batch.getElementsByTagName("Fromtime")[0].childNodes[0].nodeValue;
        var Totime = batch.getElementsByTagName("Totime")[0].childNodes[0].nodeValue;     
       
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<td   class='boldEleven'><input name='OptShiftName' id='OptShiftName' type='checkbox' value='"+Shiftid+"' />"+(loop+1);
		str=str+"<td   class='boldEleven'><font color='blue'><a href=ShiftMasterAction.jsp?OptShiftName="+Shiftid+">"+Staffname+"</a></font>";
		str=str+"<td   class='boldEleven'>&nbsp;"+Fromtime;
		str=str+"<td   class='boldEleven'>&nbsp;"+Totime;
	
		 
    }
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	document.getElementById('Edit').disabled=true;
    }
    else
    document.getElementById('Edit').disabled=false;	
    	
    str=str+"</table>";
     var tb=document.getElementById('ShiftMasterTable');
  	 tb.innerHTML=str  ; 
  	 
  	
}

  