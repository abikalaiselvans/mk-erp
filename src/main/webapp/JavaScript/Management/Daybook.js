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
 
 
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 

function loadDayBook(startLetter)
{
	var branch = document.getElementById('branch').value;
	var day = document.getElementById('day').value;
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var url = "../management?actionS=loadDayBook&startLetter="+escape(startLetter)+"&branch="+branch+"&day="+day+"&month="+month+"&year="+year; 
	initRequest(url);
   	req.onreadystatechange = loadDayBookRequest;
    req.open("GET", url, true);
    req.send(null);    
}	
 

function loadDayBookRequest()
 {
     
    if(req.readyState == 4) 
    {
        ClearTable('divTable');
		ClearTabler('totRec');  
        if (req.status == 200) 
        {
        	loadDayBookMessage();
        }
    }
}

function loadDayBookMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+" <tr class='MRow1'> ";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Category</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Type</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Description</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Credit</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Debit</b></td>";
    
    
    str=str+" </tr>"; 
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue; 
        var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
        var EDate = batch.getElementsByTagName("EDate")[0].childNodes[0].nodeValue;
        var Credit = batch.getElementsByTagName("Credit")[0].childNodes[0].nodeValue;
        var Debit = batch.getElementsByTagName("Debit")[0].childNodes[0].nodeValue; 
        var Description = batch.getElementsByTagName("Description")[0].childNodes[0].nodeValue;
        
        
        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
        	
       	str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value="+Rowid+">"+(loop+1)+"</td>";
       	
        str=str+"<td class='boldEleven'>"+Name+"</td>";
        str=str+"<td class='boldEleven'>"+Type+"</td>";
        str=str+"<td class='boldEleven'>"+EDate+"</td>";
        str=str+"<td class='boldEleven'>"+Description+"</td>";
        str=str+"<td class='boldEleven' align='right'>"+Credit+"</td>";
        str=str+"<td class='boldEleven'  align='right'>"+Debit+"</td>";
        
        
		str=str+"</tr>";
     }
      	 
 	 str=str+"</table>";     
  	 var tb=document.getElementById('divTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML="<center><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font></center>"; 
 
     
}  

