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
 
function loadCommonHoliday(startLetter)
 {
 	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../attendance?actionS=CommonHoliday&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange=CommonHolidayRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function CommonHolidayRequest() {
    if(req.readyState == 4) {    	
        ClearTable('holidayTable');  
        ClearTabler('totRec');  
        var tb=document.getElementById('holidayTable');
  	 	tb.innerHTML="Loading Data" ;
		 document.getElementById('Edit').disabled=true;  		
        if (req.status == 200) 
        {		  	
          CommonHolidayMessages();
        }
    }
}
function CommonHolidayMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("holidays")[0];   
    var str=""; 
    
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    var Desc = batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
        if(Status = "N")
        	str=str+"<td  class='boldEleven'><input name='holiday' id='holiday' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
        else
        	str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
        
		str=str+"<td  class='boldEleven'>&nbsp;"+Date+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Desc+"</td>";
		if(Status = "N")
			str=str+"<td  class='boldEleven'>No</td>";
		else
			str=str+"<td  class='boldEleven'>Yes</td>";
		str=str+"</tr>";
		
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
     var tb=document.getElementById('holidayTable');
  	 tb.innerHTML=str   
  	tb=document.getElementById('totRec');
 	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 		
}