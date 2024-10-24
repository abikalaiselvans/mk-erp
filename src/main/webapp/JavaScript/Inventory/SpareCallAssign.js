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

function loadSpareCallAssign(startLetter)
{
 	var customer = document.getElementById('customer').value;
 	var day = document.getElementById('day').value;
 	var month = document.getElementById('month').value;
 	var year = document.getElementById('year').value;
 	//"&customer="+customer+"&day="+day+"&month="+month+"&year="+year
 	var url = "../inventory?actionS=loadSpareCallAssign&type=1&startLetter="+escape(startLetter)+"&customer="+customer+"&day="+day+"&month="+month+"&year="+year;
    initRequest(url);
	req.onreadystatechange=loadSpareCallAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function loadSpareCallAssigns(ctr)
{
	var customer = document.getElementById('customer').value;
 	var day = document.getElementById('day').value;
 	var month = document.getElementById('month').value;
 	var year = document.getElementById('year').value;
 	var url = "../inventory?actionS=loadSpareCallAssign&type=2&startLetter="+ctr.value+"&customer="+customer+"&day="+day+"&month="+month+"&year="+year;
   	initRequest(url);
	req.onreadystatechange=loadSpareCallAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadSpareCallAssignRequest() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totRec');
	    ClearTable('ServiceTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('ServiceTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
		  	loadSpareCallAssignMessages();
        }
    }
}

function loadSpareCallAssignMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow1'>";
	str=str+"<tr  class='MRow1'> ";
	str=str+"<td align='center'><b>S.No</b></td> ";
	str=str+"<td align='center'><b>Refrence No</b></td> ";
	str=str+"<td align='center'><b>Call No</b></td> ";
	str=str+"<td align='center'><b>Serial Number</b></td> ";
	str=str+"<td align='center'><b>Date</b></td> ";
	str=str+"<td align='center'><b>Customer</b></td> ";
	str=str+"<td align='center'><b>Contact Person</b></td> ";
	str=str+"<td align='center'><b>Mobile</b></td> ";
	str=str+"<td align='center'><b>Assigned Engineer</b></td> ";
	str=str+"</tr> ";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
	    var Callno = batch.getElementsByTagName("Callno")[0].childNodes[0].nodeValue;
	    var Serialno = batch.getElementsByTagName("Serialno")[0].childNodes[0].nodeValue;
	    var SDate = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue;
	    var CustomerName = batch.getElementsByTagName("CustomerName")[0].childNodes[0].nodeValue;
	    var Cperson = batch.getElementsByTagName("Cperson")[0].childNodes[0].nodeValue;
	   	var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Engineer = batch.getElementsByTagName("Engineer")[0].childNodes[0].nodeValue;
	     
	    
	    
 
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";

		str=str+"<td  class='boldEleven' ><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven' >"+Ref +"</td>";
		str=str+"<td  class='boldEleven' >"+Callno +"</td>";
		str=str+"<td  class='MRow4' ><b>"+Serialno+"</b></td>";
		str=str+"<td  class='boldEleven' >"+SDate+"</td>";
		str=str+"<td  class='boldEleven' >"+CustomerName+"</td>";
		str=str+"<td  class='MRow4' ><b>"+Cperson+"</b></td>";
		str=str+"<td  class='boldEleven' >"+Mobile+"</td>";
		str=str+"<td  class='boldEleven' >"+Engineer+"</td>";
		str=str+"</tr>";
		
    }
   	 if(batchs.childNodes.length <1)
 		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
  	 
	 str=str+"</table>";
	 var tb=document.getElementById('ServiceTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
}