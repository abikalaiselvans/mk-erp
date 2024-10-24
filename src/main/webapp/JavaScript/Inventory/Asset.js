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


function loadStaffAsset(startLetter)
{
	try
	{
	 	var status=document.getElementById('status').value;
	 	var office=document.getElementById('office').value;
		var dept=document.getElementById('dept').value;
		var month=document.getElementById('month').value;
		var year=document.getElementById('year').value;
		var tb=document.getElementById('AssetTable');
  		tb.innerHTML=""  ; 
		var url = "../inventory?actionS=INVLoadStaffAsset&startLetter="+escape(startLetter)+"&office="+office+"&dept="+dept+"&year="+year+"&month="+month+"&status="+status;
	 	initRequest(url);
		req.onreadystatechange=LoadStaffAssetViewRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadStaffAssetViewRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('AssetTable');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
				var tb=document.getElementById('AssetTable');
				tb.innerHTML="<font class='bolddeepred'> Loading Data</font>"; 
				LoadStaffAssetViewMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadStaffAssetViewMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var str=""; 
	 str=str+"<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Empname = batch.getElementsByTagName("Empname")[0].childNodes[0].nodeValue;
	    var Itemtype = batch.getElementsByTagName("Itemtype")[0].childNodes[0].nodeValue;
	    var Itemname = batch.getElementsByTagName("Itemname")[0].childNodes[0].nodeValue;
		var AssetId = batch.getElementsByTagName("AssetId")[0].childNodes[0].nodeValue;
		var Serialno = batch.getElementsByTagName("Serialno")[0].childNodes[0].nodeValue;
		var CreatedDate = batch.getElementsByTagName("CreatedDate")[0].childNodes[0].nodeValue;
		var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
	    if(Status=="N")
	    	str=str+"<td  class='boldEleven'>"+(loop+1)+".<input id='Rowid' name='Rowid' type='checkbox' value='"+AssetId+"' /> </td>";
	    else
	    	str=str+"<td  class='boldEleven'>"+(loop+1)+".</td>";
	    
		str=str+"<td  class='boldEleven'> "+Empid+"</td>";
		str=str+"<td  class='boldEleven'> "+Empname+"</td>";
		str=str+"<td  class='boldEleven'> "+Itemtype+"</td>";
		str=str+"<td  class='boldEleven'> "+Itemname+"</td>";
		str=str+"<input id='AssetId' name='AssetId' type='hidden' value='"+AssetId+"' />";
		str=str+"<td  class='boldEleven'> "+Serialno+"</td>";
		str=str+"<td  class='boldEleven'> "+CreatedDate+"</td>";
		if(Status=="N")
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Issued</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Received</font></td>";
		
		
		if(Status=="N")
		{
			str=str+"<td class='boldEleven'><a href='AssetReceived.jsp?serial="+Serialno+"&Rowid="+AssetId+"'><font class='bolddeepred'>Want to receive</font></a> </td>";
		}
		else
		{
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Return</font></td>";
		}
	 
		
		str=str+"</tr>";
		window.status=(loop+1);
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 	str=str+"</table>";
    
	 var tb=document.getElementById('AssetTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


