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


function loadDemo(startLetter)
{
	try
	{
		var month=document.getElementById('month').value; 
		var year=document.getElementById('year').value;    
		var status=document.getElementById('status').value;
		var Branch=document.getElementById('Branch').value;
		
		var url = "../inventory?actionS=INVDemo&startLetter="+escape(startLetter)+"&month="+month+"&year="+year+"&status="+status+"&Branch="+Branch;
	 	 
		initRequest(url);
		req.onreadystatechange=loadDemoRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function loadDemoRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscroll');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
	    		loadDemoMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function loadDemoMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'>";
	 str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>Branch</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>Date</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>Authorised</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>Handle</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>Status</b></td>";
	 str=str+"<td class='boldEleven' align='center'><b>&nbsp;</b></td>";
	 
	 str=str+"</tr>";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
        var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
        var BName = batch.getElementsByTagName("BName")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        var Authorised = batch.getElementsByTagName("Authorised")[0].childNodes[0].nodeValue;
        var Handle = batch.getElementsByTagName("Handle")[0].childNodes[0].nodeValue;
        var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
        usertype
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		if(Status =="N")
			str=str+"<td  class='boldEleven'><input id='rowid' name='rowid' type='checkbox' value='"+Id+"' />"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'> "+BName+"</td>";
		str=str+"<td  class='boldEleven'> "+Name+"</td>";
		str=str+"<td  class='boldEleven'> "+Date+"</td>";
		str=str+"<td  class='boldEleven'> "+Authorised+"</td>";
		str=str+"<td  class='boldEleven'> "+Handle+"</td>";
		if(Status =="Y")
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Return</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Not Return</font></td>";
		
		 
		if(Status =="N" )
		{
			str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:demoReturn('"+Id +"')\"> <font class='bolddeepred'>DC Want to Return</font></a> </td>";
			 
		}	
		else
		{
			str=str+"<td  class='boldEleven'  align='center'><font class='boldgreen'> Returned</font> ";
			if(usertype =="F" || usertype =="B")
				str=str+" / <a href=\"javascript:demoReset('"+Id +"')\"> <font class='bolddeepred'>Reset</font></a>  ";
			else
				str=str+" &nbsp; ";
			str=str+"</td>";
		}
		
		str=str+"</tr>";
		
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 str=str+"</table>";
    
	 var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}



function   demoReturn(rowid)
{
	var f ="../SmartLoginAuth?filename=Demo&actionS=INVdemoClosed&rowid="+rowid  ;
	var rs=confirm("Are you sure Demo materials are returned ");
	if (rs==true)
	{
		var reason=prompt("Description for the Demo :: ","For e.g - the materials are returned "); 
		location = f+"&reason="+reason;
	}
}

function   demoReset(rowid)
{
	var f ="../SmartLoginAuth?filename=Demo&actionS=INVdemoReset&rowid="+rowid  ;
	var rs=confirm("Are you sure Demo reset");
	if (rs==true)
		location = f;
	
}




 