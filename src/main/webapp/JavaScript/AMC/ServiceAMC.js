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

 

function LoadServiceAMCsearch()
{
	var sr=document.getElementById('search').value; 
	LoadServiceAMC(sr);
	 
} 
 

function LoadServiceAMC(startLetter)
 {
 	var servicecenter=document.getElementById('servicecenter').value;
 	var customerid=document.getElementById('customerid').value;
 	var peripheralid=document.getElementById('peripheralid').value;
 	var branch=document.getElementById('branch').value;	 
 	var url = "../AMC?actionS=LoadServiceAMC&startLetter="+escape(startLetter)+"&customerid="+customerid+"&peripheralid="+peripheralid+"&servicecenter="+servicecenter+"&branch="+branch;
  
 	initRequest(url);
	req.onreadystatechange=ServiceAMCRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function ServiceAMCRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscroll');  
	        ClearTabler('totRec');  
	  		if (req.status == 200) 
	        {		  	
	          	 ServiceAMCMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
function ServiceAMCMessages() 
{	 
 try
 {
 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
 	
 	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	
    
	 
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
      
        var batch = batchs.childNodes[loop];
        var Field1 = batch.getElementsByTagName("Customerid")[0].childNodes[0].nodeValue;
	    var Field2 = batch.getElementsByTagName("Serviceitemid")[0].childNodes[0].nodeValue;
	    var Field3 = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Field4 = batch.getElementsByTagName("Item")[0].childNodes[0].nodeValue;
	    var Field5 = batch.getElementsByTagName("Noofmachine")[0].childNodes[0].nodeValue;
	    var Field6 = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Field8 = batch.getElementsByTagName("SCenter")[0].childNodes[0].nodeValue;
	    var Field7 = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven' >"+(loop+1);
		str=str+"<td  class='boldEleven' >&nbsp;"+Field7;
		str=str+"<td  class='boldEleven' >&nbsp;"+Field8;
		str=str+"<td  class='boldEleven' ><a href='ListAmcserialno.jsp?customerid="+Field1+"&Serviceitemid="+Field2+"'><font class='boldgreen'>"+Field3+"</font>";
		str=str+"<td  class='boldEleven' >&nbsp;"+Field4;
		str=str+"<td  class='boldEleven' >&nbsp;"+Field5 ;
		str=str+"<td  class='boldEleven' >&nbsp;"+Field6;
		
	 
		
	 }
      
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	tb=document.getElementById('totRec');
  	 	tb.innerHTML= "<font class='bolddeepred'>Total no of Records :: "+loop+"</font>"; 
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	
     }	
   
	 str=str+"</table>";
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	  
  	 
  }
  catch(err)
  {
	alert(err.description);
  }    	
}