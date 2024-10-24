


 function LoadAssetTrack(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var customer=document.getElementById('customer').value;
	var url = "../Asset?actionS=LoadAssetTrack&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&year="+year+"&customer="+customer;
	var tb=document.getElementById('AssetEntry');
  	tb.innerHTML=" "  ; 
   	initRequest(url);
   	req.onreadystatechange =LoadAssetTrackRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function LoadAssetTrackRequest() 
{	
	if(req.readyState == 4) 
    {    	
       if (req.status == 200)
        {
        	var tb=document.getElementById('AssetEntry');
  	 		tb.innerHTML="  " ; 
        	LoadAssetTrackMessages();
        }
    }
}


function LoadAssetTrackMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Company = batch.getElementsByTagName("Company")[0].childNodes[0].nodeValue;
	    var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
	    var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
		var Empname = batch.getElementsByTagName("Empname")[0].childNodes[0].nodeValue;
		var SDate = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue;
		var Invoice = batch.getElementsByTagName("Invoice")[0].childNodes[0].nodeValue;
		var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td  class='boldEleven'>";
		if(Status == "Y")
			str=str+"<input name='assetid' name='assetid' type='checkbox' value='"+Id+"' />"+(loop+1)	;
		else
			str=str+" "+(loop+1)	;	
			
		str=str+"<td  class='boldEleven'>"+Company;
		str=str+"<td  class='boldEleven'>"+Branch;
		str=str+"<td  class='boldEleven'>"+Division;
		str=str+"<td  class='boldEleven'>"+Customer;
		str=str+"<td  class='boldEleven'>"+Empid;
		str=str+"<td  class='boldEleven'>"+Empname;
		str=str+"<td  class='boldEleven'>"+SDate;
		str=str+"<td  class='boldEleven'>"+Invoice;
		str=str+"<td  class='boldEleven'><a href='javascript:Printquery(\"AssetTrackPrint.jsp?assetid="+Id+"\")'><font class='boldgreen'>Print</font></a>";
		str=str+"<td  class='boldEleven'>"  ;
		if(Status == "N")
			str=str+"<font class='boldred'>Not Completed / <a href='AssetTrackSerial.jsp?assetid="+Id+"'><font class='boldgreen'>Update</font></a></font>"
		else 
			str=str+"<font class='boldgreen'>Completed</font>"
		 
     }
     str=str+"</table>";

     var tb=document.getElementById('AssetEntry');
  	 tb.innerHTML=str  ; 
  	
} 
 
 