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


function LoadSpareReturn(startLetter)
{
	try
	{
		var branch=document.getElementById('branch').value;
		var calltype=document.getElementById('calltype').value;
		var month=document.getElementById('month').value;
		var year=document.getElementById('year').value;
		var returnstatus=document.getElementById('returnstatus').value;
		var day=document.getElementById('day').value;
		var url = "../inventory?actionS=LoadSpareReturn&startLetter="+escape(startLetter)+"&branch="+branch+"&calltype="+calltype+"&month="+month+"&year="+year+"&returnstatus="+returnstatus+"&day="+day;;
	 	 
	 	initRequest(url);
		req.onreadystatechange=LoadSpareReturnRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadSpareReturnRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('SpareDemandTable');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
	    		LoadSpareReturnMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadSpareReturnMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'>";
	 str=str+"<td><div align='center' class='boldEleven'><b>S.No</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Branch</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Customer</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Customer Address</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Call type</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Product Serial</b></td>";
	 str=str+"<td  class='boldEleven'><b>Description</b></td>"; 
	 str=str+"<td><div align='center' class='boldEleven'><b>Callnumber</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Demand Date</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Despatch Location</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Serial Number</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Issue BY</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Issue Date</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Issue</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Issue Age</b></td>";
	 
	 str=str+"<td><div align='center' class='boldEleven'><b>Through</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Through desc</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Return Age</b></td>";
	 str=str+"<td><div align='center' class='boldEleven'><b>Return</b></td>";
	 str=str+"</tr>";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Branch  = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var Customer  = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
	    var Customeradd  = batch.getElementsByTagName("Customeradd")[0].childNodes[0].nodeValue;
	    var Calltype  = batch.getElementsByTagName("Calltype")[0].childNodes[0].nodeValue;
	    var description  = batch.getElementsByTagName("description")[0].childNodes[0].nodeValue;
	   var productserial  = batch.getElementsByTagName("productserial")[0].childNodes[0].nodeValue;
		
	    var Callno  = batch.getElementsByTagName("Callno")[0].childNodes[0].nodeValue;
	    var Demanddate  = batch.getElementsByTagName("Demanddate")[0].childNodes[0].nodeValue;
	    var Entry  = batch.getElementsByTagName("Entry")[0].childNodes[0].nodeValue;
	    var DespatchLocation  = batch.getElementsByTagName("DespatchLocation")[0].childNodes[0].nodeValue;
	    var Issued  = batch.getElementsByTagName("Issued")[0].childNodes[0].nodeValue;
	    var Serial  = batch.getElementsByTagName("Serial")[0].childNodes[0].nodeValue;
	    var IssuedBy  = batch.getElementsByTagName("IssuedBy")[0].childNodes[0].nodeValue;
	    var IssuedDate  = batch.getElementsByTagName("IssuedDate")[0].childNodes[0].nodeValue;
	    var Return  = batch.getElementsByTagName("Return")[0].childNodes[0].nodeValue; 
	    var diff  = batch.getElementsByTagName("diff")[0].childNodes[0].nodeValue;
	    var Through  = batch.getElementsByTagName("Through")[0].childNodes[0].nodeValue;
	    var Throughdesc  = batch.getElementsByTagName("Throughdesc")[0].childNodes[0].nodeValue;
	    var Returnage  = batch.getElementsByTagName("Returnage")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
	    
	    if(Return =="Y")
	    	str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven'><input id='rowid' name='rowid' type='checkbox' value='"+Rowid+"' />"+(loop+1)+"</td>";
	    	
	    
	    
	    str=str+"<td  class='boldEleven'> "+Branch+"</td>";
	    str=str+"<td  class='boldEleven'> "+Customer+"</td>";
	    str=str+"<td  class='boldEleven'> "+Customeradd+"</td>";
	    str=str+"<td  class='boldEleven'> "+Calltype+"</td>";
	    str=str+"<td  class='boldEleven'> "+productserial+"</td>";
	    str=str+"<td  class='boldEleven'> "+description+"</td>";
	    str=str+"<td  class='boldEleven'> "+Callno+"</td>";
	    str=str+"<td  class='boldEleven'> "+Demanddate+"</td>";
	    str=str+"<td  class='boldEleven'> "+DespatchLocation+"</td>";
	    
	    str=str+"<td  class='boldEleven'> "+Serial+"</td>";
	    str=str+"<td  class='boldEleven'> "+IssuedBy+"</td>";
	    str=str+"<td  class='boldEleven'> "+IssuedDate+"</td>";
	    
	    if(Issued =="Y")
	    	str=str+"<td  class='boldEleven'><font class='boldgreen'>Issued</font></td>";
	    else
	    	str=str+"<td  class='boldEleven'><font class='bolddeepred'>Not Issue</font></td>";
	    
	    str=str+"<td  class='boldEleven'> "+diff+" -days</td>";
	    str=str+"<td  class='boldEleven'> "+Through+"</td>";
	    str=str+"<td  class='boldEleven'> "+Throughdesc+"</td>";
	    str=str+"<td  class='boldEleven'> "+Returnage+" -days</td>";
	    
	    if(Return =="Y")
	    	str=str+"<td  class='boldEleven'><font class='boldgreen'>Return Good</font></td>";
	    else if(Return =="B")
	    	str=str+"<td  class='boldEleven'><font class='bolddeepred'>Return Bad</font></td>";
	    else
	    	str=str+"<td  class='boldEleven'><font class='bolddeepred'>Return pending</font></td>";
	    
	    str=str+"</tr>";
		window.status=(loop+1);
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 str=str+"</table>";
    
	 var tb=document.getElementById('SpareDemandTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


