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
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadTestType(startletter)
 {
 	var url = "../SmartHRM?actionS=loadTestType&search="+startletter ;
	initRequest(url);
	req.onreadystatechange=loadTestTypeRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadTestTypeRequest() 
 {
    if(req.readyState == 4) 
    {    	
        ClearTable('TestTypeTable');  
        ClearTabler('totalRec');  
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
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
	str=str+"<tr class='MRow2'><td class='boldEleven'><b>S.No ";
	str=str+"<td class='boldEleven'><b>Name ";
	str=str+"<td class='boldEleven'><b>Description  ";
	 
	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var ID = batch.getElementsByTagName("ID")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Desc = batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'>"+(loop+1)+"<input type='checkbox' id='id' name='id' value='"+ID+"'></td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Desc+"</td>";
		str=str+"</tr>";
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	var tb=document.getElementById('totalRec');
  	 	tb.innerHTML="<center> <font  class='bolddeepred'>Total No of Records : "+batchs.childNodes.length+"</font></center>" ;
		
		
     }
     else
     {
     	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
     	 
     }	
	 str=str+"</table>";
     var tb=document.getElementById('TestTypeTable');
  	 tb.innerHTML=str  
  	 
  	 
  	  
}



