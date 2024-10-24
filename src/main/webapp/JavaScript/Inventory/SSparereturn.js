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


function loadsparereturn(startLetter)
{
	try
	{
	var sparetype=document.getElementById('sparetype').value;
	var type=document.getElementById('type').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var tb=document.getElementById('SparereturnTable');
  	tb.innerHTML=""  ; 
	var url = "../inventoryCustomer?actionS=INVloadsparereturn&type="+type+"&sparetype="+sparetype+"&month="+month+"&year="+year+"&startLetter="+escape(startLetter); 
	    initRequest(url);
		req.onreadystatechange=loadsparereturnviewrequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function loadsparereturnviewrequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	        ClearTable('SparereturnTable');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
				var tb=document.getElementById('SparereturnTable');
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
	 var batchs = req.responseXML.getElementsByTagName("Rowssparereturn")[0];   
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
		var status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var returnqty = batch.getElementsByTagName("returnqty")[0].childNodes[0].nodeValue;
		var usedqty = batch.getElementsByTagName("usedqty")[0].childNodes[0].nodeValue;
		var ss = status;

		if(Qty==0){
			Qty="-";
		}
		if(stype=="C"){
			stype="Consumable";
		}
		else{
			stype="Serial";
			returnqty="-";
			usedqty="-";
			}
			
		if(status=="N"){
			status="Not Returned";
		}
		else
			status="Returned";
			
		if(sitype=="P"){
			sitype="Product";
		}
		else
			sitype="Item";
			
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
	    
		
	    if(ss =="Y")
	    	str=str+"<td  class='boldEleven' width='4%'>&nbsp;"+(loop+1)+"</td>";
	    else
	    	str=str+"<td  class='boldEleven' width='4%'><input name='id' id='id' type='checkbox' value='"+demandissueid+"'/>&nbsp;"+(loop+1)+"</td>";
	   
		str=str+"<td  class='boldEleven'  width='10%'> "+demandissueno+"</td>";
		str=str+"<td  class='boldEleven'  width='10%'> "+demandnum+"</td>";
		//str=str+"<input id='demandId' name='demandId' type='hidden' value='"+demandnum+"'/>";
		str=str+"<td  class='boldEleven'  width='10%'> "+customername+"</td>";
		str=str+"<td  class='boldEleven'  width='10%'> "+stype+"</td>";
		str=str+"<td  class='boldEleven'  width='10%'> "+sitype+"</td>";
		str=str+"<td  class='boldEleven'  width='10%'> "+productname+"</td>";
		str=str+"<td  class='boldEleven'  width='7%'> "+serialnoissue+"</td>";
		str=str+"<td  class='boldEleven'  width='3%' > "+Qty+"</td>";
		str=str+"<td  width='3%'  class='boldEleven'> "+returnqty+"</td>";
		str=str+"<td  width='3%'  class='boldEleven'> "+usedqty+"</td>";
		str=str+"<td  width='5%' align='center' class='bolddeepred'> "+status+"</td>";
		str=str+"</tr>";
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 	str=str+"</table>";
    
	 var tb=document.getElementById('SparereturnTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


