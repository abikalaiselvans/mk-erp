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

 
function LoadScheduleEntry(startLetter)
 {
 	
 	var day = document.getElementById('day').value;
 	var month =document.getElementById('month').value;
 	var year =document.getElementById('year').value;
 	var url = "../marketing?actionS=LoadScheduleEntry&startLetter="+escape(startLetter)+"&day="+day+"&month="+month+"&year="+year;
   	initRequest(url);
	req.onreadystatechange=LoadScheduleEntryRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadScheduleEntryRequest() 
 {
    
	ClearTabler('totalrec');
    ClearTable('GroupTable');
	if(req.readyState == 4) 
    {    	
		  if (req.status == 200) 
        {		  	
          
			LoadScheduleEntryMessages();
        }
    }
}

function LoadScheduleEntryMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	str=str+"<tr class='MRow1'>";
  	str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
  	str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
  	str=str+"<td class='boldEleven' align='center'><b>Title</b></td>";
  	str=str+"<td class='boldEleven' align='center'><b>Starting Date</b></td>";
  	str=str+"<td class='boldEleven' align='center'><b>Ending Date</b></td>";
  	//str=str+"<td class='boldEleven' align='center'><b>Difference(HH :MM)</b></td>";
  	str=str+"<td class='boldEleven' align='center'><b>All Day</b></td>";
  	str=str+"</tr>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Title = batch.getElementsByTagName("Title")[0].childNodes[0].nodeValue;
	    var SDate = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue;
	    var EDate = batch.getElementsByTagName("EDate")[0].childNodes[0].nodeValue;
	    var Diff = batch.getElementsByTagName("Diff")[0].childNodes[0].nodeValue;
	    var Allday = batch.getElementsByTagName("Allday")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'> <a href='ScheduleEntryAction.jsp?id="+Id+"' >"+Name +" </a> </td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Title+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+SDate+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+EDate+"</td>";
		//str=str+"<td  class='boldEleven'>&nbsp;"+Diff+"</td>";
		if(Allday == "N")
			str=str+"<td  class='boldEleven'><font color='blue'></font></td>"; 
		else
			str=str+"<td  class='boldEleven'><font color='red'>All Day</font></td>";	
    }
     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
	 
	 str=str+"</table>";
     	
}