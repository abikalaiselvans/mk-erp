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
 


function loadOverTime(startLetter) 
{		
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
    var Office=document.getElementById('Office').value;  
    var url = "../attendance?actionS=ATTovertime&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter)+"&Office="+Office+"&day="+day;
	initRequest(url);
	req.onreadystatechange=OverTimeRequest;
    req.open("GET", url, true);
    req.send(null);
}
function OverTimeRequest() 
{
    if(req.readyState == 4) 
    {    	
        
        ClearTable('overtimeTable'); 
        ClearTabler('totRec');
		 document.getElementById('Edit').disabled=true;  		
        if (req.status == 200) 
        {
          OverTimeMessages();
        }
    }
}
function OverTimeMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("overtimes")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var Companyname = batch.getElementsByTagName("Companyname")[0].childNodes[0].nodeValue;
        var Branchname = batch.getElementsByTagName("Branchname")[0].childNodes[0].nodeValue;     
        var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue; 
        var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue; 
        var time = batch.getElementsByTagName("time")[0].childNodes[0].nodeValue;
        var Odate = batch.getElementsByTagName("Odate")[0].childNodes[0].nodeValue;
		var smonth=document.getElementById('month').value;
    	var syear=document.getElementById('year').value;        
    	
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		 str=str+"<tr  class='MRow2'>";				   
		str=str+"<td width='140' class='boldEleven'>";
		str=str+"<input name='overtime' id='overtime' type='checkbox' value='"+Empid+"'/>&nbsp;"+Empid;
		str=str+"<td width='160' class='boldEleven'>&nbsp;<font color='blue'>"
		str=str+"<a href=OverTimeEdit.jsp?month="+smonth+"&year="+syear+"&overtime="+Empid+">&nbsp;"+Staffname+"</a></font>";
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Companyname+"</td>";
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Branchname+"</td>";
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Odate+"</td>";
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Depart+"</td>";
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Desig+"</td>";
		str=str+"<td width='110' class='boldEleven' align='center'>"+time+"</td>";			
	}
	
  	if(batchs.childNodes.length >0)
  	{  	 	
     	document.getElementById('Edit').disabled=false;
    }
    else
    {
     	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
     	document.getElementById('Edit').disabled=true;    
    }	
	 str=str+"</table>";
     var tb=document.getElementById('overtimeTable');
  	 tb.innerHTML=str  
 	tb=document.getElementById('totRec');
 	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 	
}


  