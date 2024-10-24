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
	 var str="<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
function ClearTabler(ctr1)
{
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadCalltype(startLetter)
 {
 	var url = "../marketing?actionS=loadCall&startLetter="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange=loadCallRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadCallRequest() 
 {
    
	ClearTable('loadCallTable');  
    ClearTabler('totalRec');  
	if(req.readyState == 4) 
    {    	
		if (req.status == 200) 
        {		  	
         	var tb=document.getElementById('loadCallTable');
  	 		tb.innerHTML="<center>Loading Data</center>" ;
		  	loadCallMessages();
        }
    }
}

function loadCallMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("CallRows")[0];   
    var str=""; 
    var query=""; 
	str = str + "<table width='100%' class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
	str = str + "<tr class='MRow2'>";
	str = str + "<td class='boldEleven'><b>S.No</b></td> ";
	str = str + "<td class='boldEleven' ><b>Call Name</b></td>";
	str = str + "<td class='boldEleven'><b>Description</b></td>";
	str = str + "</tr>"; 
	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var CallId = batch.getElementsByTagName("CallId")[0].childNodes[0].nodeValue;
	    var CallName = batch.getElementsByTagName("CallName")[0].childNodes[0].nodeValue;
	    var Desc = batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input type='checkbox' id='id' name='id' value='"+CallId+"'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'><font class=''>"+CallName+"</font></td>";
		str=str+"<td  class='boldEleven'>"+Desc+"</td>";
		str=str+"</tr>";
    }
	
	 var tb=document.getElementById('loadCallTable');
  	 tb.innerHTML=str  ;
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	var tb=document.getElementById('totalRec');
  	 	tb.innerHTML="<center> <font  class='bolddeepred'>Total No of Records : "+batchs.childNodes.length+"</font></center>" ;
     }
     else
     {
     	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
     	document.getElementById('Edit').disabled=true;
     }	
	 str=str+"</table>";
  	  
}



