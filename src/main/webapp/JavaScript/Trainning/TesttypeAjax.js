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


function loadTestType(startLetter)
 {
 	var url = "../SmartTrainning?actionS=loadTestType&startLetter="+escape(startLetter);
 	initRequest(url);
	req.onreadystatechange=loadTestTypeRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadTestTypeRequest() 
 {
    ClearTabler('totalRec');
    ClearTable('TestTypeTable');
	if(req.readyState == 4) 
    {    	
        // ClearTable('TestTypeTable');  
        //ClearTable('totalRec');  
		if (req.status == 200) 
        {		  	
         	var tb=document.getElementById('TestTypeTable');
  	 		tb.innerHTML="<center>Loading Data</center>" ;
		  	loadTestTypeMessages();
        }
    }
}

function loadTestTypeMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    
    var str=""; 
    var query="";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
	str=str+"<tr class='MRow2'><td class='boldEleven'><b>S.No</td>";
	str=str+"<td class='boldEleven'><b>Name</td>";
	str=str+"<td class='boldEleven'><b>Description</td>";
	str=str+"<td class='boldEleven'><b>Noofquestion</td>";	 
	str=str+"<td class='boldEleven'><b>Duration</td>";
	str=str+"<td class='boldEleven'><b>Percentage</td>";
	str=str+"</tr>";
	 
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var ID = batch.getElementsByTagName("ID")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Desc = batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    var Noofquestion = batch.getElementsByTagName("Noofquestion")[0].childNodes[0].nodeValue;
	    var Duration = batch.getElementsByTagName("Duration")[0].childNodes[0].nodeValue;
	    var Percentage = batch.getElementsByTagName("Percentage")[0].childNodes[0].nodeValue;
	    
	     
	    if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'>"+(loop+1)+"<input type='checkbox' id='id' name='id' value='"+ID+"'></td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Desc+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Noofquestion+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Duration+" - (minutes)</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Percentage+" - (%)</td>";
		str=str+"</tr>";
    }
	 var tb=document.getElementById('TestTypeTable');
  	 tb.innerHTML=str  
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



