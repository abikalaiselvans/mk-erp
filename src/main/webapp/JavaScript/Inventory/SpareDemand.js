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


function LoadSpareDemand(startLetter)
{
	try
	{
		var branch=document.getElementById('branch').value;
		var calltype=document.getElementById('calltype').value;
		var month=document.getElementById('month').value;
		var year=document.getElementById('year').value;
		var day=document.getElementById('day').value;
		var url = "../inventory?actionS=LoadSpareDemand&startLetter="+escape(startLetter)+"&branch="+branch+"&calltype="+calltype+"&month="+month+"&year="+year+"&day="+day;
	 	 
	 	initRequest(url);
		req.onreadystatechange=LoadSpareDemandRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadSpareDemandRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('SpareDemandTable');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadSpareDemandMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadSpareDemandMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'>";
	 str=str+"<td  class='boldEleven'><b>S.NO</b></td>";
	 str=str+"<td  class='boldEleven'><b>Ref</b></td>";
	 str=str+"<td  class='boldEleven'><b>Branch</b></td>";
	 str=str+"<td  class='boldEleven'><b>Customer</b></td>";
	 str=str+"<td  class='boldEleven'><b>Customer Address</b></td>";
	 str=str+"<td  class='boldEleven'><b>Call Type</b></td>";
	 str=str+"<td  class='boldEleven'><b>Product Serial</b></td>";
	 str=str+"<td  class='boldEleven'><b>Description</b></td>";
	 str=str+"<td  class='boldEleven'><b>Callnumber</b></td>";
	 str=str+"<td  class='boldEleven'><b>Demand Date</b></td>";
	 str=str+"<td  class='boldEleven'><b>Demand Entry</b></td>";
	 str=str+"<td  class='boldEleven'><b>Despatch Location</b></td>";
	 str=str+"<td  class='boldEleven'><b>Status</b></td>";
	 str=str+"</tr>";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
        var Branch  = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var Customer  = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
	    var Customeradd  = batch.getElementsByTagName("Customeradd")[0].childNodes[0].nodeValue;
	    var Calltype  = batch.getElementsByTagName("Calltype")[0].childNodes[0].nodeValue;
	    var productserial  = batch.getElementsByTagName("productserial")[0].childNodes[0].nodeValue;
	    var description  = batch.getElementsByTagName("description")[0].childNodes[0].nodeValue;
	    var Callno  = batch.getElementsByTagName("Callno")[0].childNodes[0].nodeValue;
	    var Demanddate  = batch.getElementsByTagName("Demanddate")[0].childNodes[0].nodeValue;
	    var Entry  = batch.getElementsByTagName("Entry")[0].childNodes[0].nodeValue;
	    var DespatchLocation  = batch.getElementsByTagName("DespatchLocation")[0].childNodes[0].nodeValue;
	    var Issued  = batch.getElementsByTagName("Issued")[0].childNodes[0].nodeValue;
	    
	   
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
	    
	    if(Issued =="Y")
	    	str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
	    else
	    	str=str+"<td  class='boldEleven'><input id='rowid' name='rowid' type='checkbox' value='"+Rowid+"' />"+(loop+1)+"</td>";
		
	    
	    str=str+"<td  class='boldEleven'> "+Ref+"</td>";
	    str=str+"<td  class='boldEleven'> "+Branch+"</td>";
	    str=str+"<td  class='boldEleven'> "+Customer+"</td>";
	    str=str+"<td  class='boldEleven'> "+Customeradd+"</td>";
	    str=str+"<td  class='boldEleven'> "+Calltype+"</td>";
	    str=str+"<td  class='boldEleven'> "+productserial+"</td>";
	    str=str+"<td  class='boldEleven'> "+description+"</td>";
	    
	    str=str+"<td  class='boldEleven'> "+Callno+"</td>";
	    str=str+"<td  class='boldEleven'> "+Demanddate+"</td>";
	    str=str+"<td  class='boldEleven'> "+Entry+"</td>";
	    str=str+"<td  class='boldEleven'> "+DespatchLocation+"</td>";
	    if(Issued =="Y")
	    	str=str+"<td  class='boldEleven'><font class='boldgreen'>Issued</font></td>";
	    else
	    	str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
	    
	    str=str+"</tr>";
		window.status=(loop+1);
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 str=str+"</table>";
    
	 var tb=document.getElementById('SpareDemandTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


