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

 
function loadLeaveEntry(startLetter)
 {
 	var Office=document.getElementById('Office').value;
    var yea=document.getElementById('year').value;  
    var month=document.getElementById('month').value;   
    var day=document.getElementById('day').value;   
    var leavetype=document.getElementById('leavetype').value;   
    var staffid = document.getElementById('staffid').value;  
    var url = "../attendance?actionS=loadLeaveEntry&month="+escape(month)+"&year="+escape(yea)+"&startLetter="+escape(startLetter)+"&day="+day+"&Office="+Office+"&leavetype="+leavetype+"&staffid="+staffid;
     
    initRequest(url);
	req.onreadystatechange=loadLeaveEntryRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadLeaveEntryRequest() 
 {
	 
    if(req.readyState == 4) 
    {    	
        ClearTable('LeaveEntryTable'); 
        ClearTabler('totRec');  
         
		 	
        if (req.status == 200) 
        {		  	
          loadLeaveEntryMessages();
        }
    }
}


function loadLeaveEntryMessages() 
{	 
     
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
	    var LName = batch.getElementsByTagName("LName")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    var Month = batch.getElementsByTagName("Month")[0].childNodes[0].nodeValue;
	    var Year = batch.getElementsByTagName("Year")[0].childNodes[0].nodeValue;
	    

        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		if(Status =="1"  )
			str=str+"<td  class='boldEleven'><input name='leaveid' id='leaveid' type='checkbox' value='"+Rowid+"'/>&nbsp;"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven'>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Empid+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Date+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Type+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+LName+"</td>";
		 
		str=str+"</tr>";
		
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	 
     }
     else
     {
     	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
     	 
     
     }	
	 str=str+"</table>";
	  
     var tb=document.getElementById('LeaveEntryTable');
  	 tb.innerHTML=str ;
  	 
 	tb=document.getElementById('totRec');
	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
	
     	
}