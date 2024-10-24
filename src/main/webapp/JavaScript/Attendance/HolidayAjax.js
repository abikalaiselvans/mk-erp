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

 
 function loadHolidays(startLetter) 
{		
	 
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var office = document.getElementById('Office').value;  
     var day = document.getElementById('day').value; 
     var staffid = document.getElementById('staffid').value;  
     
     
    var url = "../attendance?actionS=ATTholiday&month="+escape(mon)+"&year="+escape(yea)+"&startLetter="+escape(startLetter)+"&Office="+office+"&day="+day+"&staffid="+staffid;
	 
	initRequest(url);
	req.onreadystatechange=HolidayRequest;
    req.open("GET", url, true);
    req.send(null);
}

function HolidayRequest() 
{
    if(req.readyState == 4) 
    {    	
    	ClearTable('holidayTable');  
    	ClearTabler('totRec');  
        var tb=document.getElementById('holidayTable');
  	 	tb.innerHTML="Loading Data" ;
		 		
        if (req.status == 200) 
        {		  	
          HolidayMessages();
        }
    }
}
function HolidayMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	
	 
	str=str+"<tr class='MRow1'> ";
	str=str+"<td class='boldEleven' align='center'><b>S.No</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Staff Id</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Staff Name</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Office</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Date</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>&nbsp;</b></td> ";
	str=str+"</tr> ";
	 
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var Office = batch.getElementsByTagName("Office")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue; 
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue; 
            
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		if(Status=="1")
			str=str+"<td class='boldEleven'><input name='holiday' id='holiday' type='checkbox' value='"+Rowid+"'/>&nbsp;"+(loop+1)+"</td>";
		else
			str=str+"<td class='boldEleven'>&nbsp;"+(loop+1)+"</td>";	
		str=str+"<td class='boldEleven'>&nbsp;"+Empid+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Staffname+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Office+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Date+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;Holiday</td>";
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	 
     }
     else
     {
     	str=str+"<tr  class='MRow1'><td colspan='8' class='bolddeepred'><br><center>Data not found..<br> </center></td></tr>";
     }	
	 str=str+"</table>";
     var tb=document.getElementById('holidayTable');
  	 tb.innerHTML=str ;
  	tb=document.getElementById('totRec');
 	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 	
     	
}
 