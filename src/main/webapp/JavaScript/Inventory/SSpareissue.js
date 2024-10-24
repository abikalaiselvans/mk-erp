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


function loadspareissue(startLetter)
{
	try
	{
		var sparetype=document.getElementById('sparetype').value;
		var type=document.getElementById('type').value;
		var month=document.getElementById('month').value;
		var year=document.getElementById('year').value;
		var tb=document.getElementById('SpareTable');
		var branch=document.getElementById('Branch').value;
		
	  	tb.innerHTML=""  ; 
		var url = "../inventoryCustomer?actionS=INVloadspareissue&type="+type+"&sparetype="+sparetype+"&month="+month+"&year="+year+"&startLetter="+escape(startLetter)+"&branch="+branch; 
	    initRequest(url);
		req.onreadystatechange=loadspareissueviewrequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function loadspareissueviewrequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	        ClearTable('SpareTable');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
				var tb=document.getElementById('SpareTable');
				tb.innerHTML="<font class='bolddeepred'> Loading Data</font>"; 
				LoadspareissueViewMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadspareissueViewMessages() 
{	 
 try
 {
	 var batchs = req.responseXML.getElementsByTagName("Rowsspareissue")[0];   
	 var str=""; 
	 str=str+"<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var demandissueid = batch.getElementsByTagName("DemandIssueId")[0].childNodes[0].nodeValue;
		var demandissueno = batch.getElementsByTagName("DemandIssueNo")[0].childNodes[0].nodeValue;
	    var demandnum = batch.getElementsByTagName("DemandNO")[0].childNodes[0].nodeValue;
		var stype = batch.getElementsByTagName("Sparetype")[0].childNodes[0].nodeValue;
		var sitype = batch.getElementsByTagName("type")[0].childNodes[0].nodeValue;
		var Qty = batch.getElementsByTagName("qty")[0].childNodes[0].nodeValue;
	    var serialnoissue = batch.getElementsByTagName("DemandissueSerialno")[0].childNodes[0].nodeValue;
		var productname = batch.getElementsByTagName("productname")[0].childNodes[0].nodeValue;
		var customername = batch.getElementsByTagName("customername")[0].childNodes[0].nodeValue;
		var productid = batch.getElementsByTagName("productid")[0].childNodes[0].nodeValue;

		if(Qty==0)
			Qty="-";
		
		if(stype=="C")
			stype="Consumable";
		else
			stype="Serial";

		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
	    
		str=str+"<td  class='boldEleven' width='5%'><input name='id' id='id' type='checkbox' value='"+demandissueid+"'/>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven' width='14%'>"+demandissueno+"</td>";
		str=str+"<td  class='boldEleven' width='14%'>"+demandnum+"<input id='demandId' name='demandId' type='hidden' value='"+demandnum+"'/></td>";
		str=str+"<td  class='boldEleven' width='14%'>"+customername+"</td>";
		str=str+"<td  class='boldEleven' width='14%'>"+stype+"</td>";
		str=str+"<td  class='boldEleven' width='14%'>"+sitype+"</td>";
		str=str+"<td  class='boldEleven' width='14%'>"+productname+"<input id='productid' name='productid' type='hidden' value='"+productid+"'/></td>";
		str=str+"<td  class='boldEleven' width='8%'>"+serialnoissue +"<input id='demandserialno' name='demandserialno' type='hidden' value='"+serialnoissue+"'/></td>";
		str=str+"<td  class='boldEleven' width='6%' align='center'> "+Qty+"</td>";
		str=str+"</tr>";
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<tr class='MRow1'><td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
	 	
	str=str+"</table>";
    var tb=document.getElementById('SpareTable');
  	tb.innerHTML=str   ;
  	
  	tb=document.getElementById('totRec');
  	tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  }
  catch(err)
  {
	  alert(err.description);
  }    	
}


