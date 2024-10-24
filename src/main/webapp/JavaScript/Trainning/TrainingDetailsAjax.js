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



function loadTrainingDetails(startLetter)
 {
 	
	var type= document.getElementById('type').value
	var office= document.getElementById('office').value
	var day= document.getElementById('day').value
	var month= document.getElementById('month').value
	var year= document.getElementById('year').value
	var url = "../SmartTrainning?actionS=loadTrainingDetails"+"&type="+type+"&office="+office+"&day="+day+"&month="+month+"&year="+year+"&startLetter="+escape(startLetter); 
 	initRequest(url);
	req.onreadystatechange=loadTrainingDetailsRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadTrainingDetailsRequest() 
 {
    
	ClearTabler('totalRec');
    ClearTable('recordTable');
	if(req.readyState == 4) 
    {    	
        //ClearTable('recordTable');  
        //ClearTable('totalRec');  
		if (req.status == 200) 
        {		  	
         	var tb=document.getElementById('recordTable');
  	 		tb.innerHTML="<center>Loading Data</center>" ;
  	 		loadTrainingDetailsMessages();
        }
    }
}

function loadTrainingDetailsMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    
    var str=""; 
    var query="";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
	str=str+"<tr class='MRow2'><td class='boldEleven'><b>S.No </b></td>";
	str=str+"<td class='boldEleven'><b>Type </b></td>";
	str=str+"<td class='boldEleven'><b>Emp</b></td>";
	str=str+"<td class='boldEleven'><b>From</b></td>";
	str=str+"<td class='boldEleven'><b>To</b></td>";
	str=str+"<td class='boldEleven'><b>Conducted</b></td>";
	str=str+"<td class='boldEleven'><b>Required Test</b></td>";
	str=str+"<td class='boldEleven'><b>Creation Date</b></td>";
	str=str+"</tr>";
	
	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        //var ID = batch.getElementsByTagName("ID")[0].childNodes[0].nodeValue;
	    
        var ID = batch.getElementsByTagName("ID")[0].childNodes[0].nodeValue;
        var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
        var Emp = batch.getElementsByTagName("Emp")[0].childNodes[0].nodeValue;
        var From = batch.getElementsByTagName("From")[0].childNodes[0].nodeValue;
        var To = batch.getElementsByTagName("To")[0].childNodes[0].nodeValue;
        var Conducted = batch.getElementsByTagName("Conducted")[0].childNodes[0].nodeValue;
        var Test = batch.getElementsByTagName("Test")[0].childNodes[0].nodeValue;
        var Creation = batch.getElementsByTagName("Creation")[0].childNodes[0].nodeValue;
	    if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'>"+(loop+1)+"<input type='checkbox' id='id' name='id' value='"+ID+"'></td>";
		str=str+"<td  class='boldEleven'>"+Type+"</td>";
		str=str+"<td  class='boldEleven'>"+Emp+"</td>";
		str=str+"<td  class='boldEleven'>"+From+"</td>";
		str=str+"<td  class='boldEleven'>"+To+"</td>";
		str=str+"<td  class='boldEleven'>"+Conducted+"</td>";
		str=str+"<td  class='boldEleven'>"+Test+"</td>";
		str=str+"<td  class='boldEleven'>"+Creation+"</td>";
		
		str=str+"</tr>";
    }
	
	 var tb=document.getElementById('recordTable');
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



