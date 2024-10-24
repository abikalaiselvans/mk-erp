 function LoadAssetEntry(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../Asset?actionS=LoadAssetEntry&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&year="+year;
	var tb=document.getElementById('AssetEntry');
  	tb.innerHTML=" "  ; 
   	initRequest(url);
   	req.onreadystatechange =LoadAssetEntryRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function LoadAssetEntryRequest() 
{	
	if(req.readyState == 4) 
    {    	
       if (req.status == 200)
        {
        	var tb=document.getElementById('AssetEntry');
  	 		tb.innerHTML="  " ; 
        	LoadAssetEntryMessages();
        }
    }
}


function LoadAssetEntryMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;
	    var Item = batch.getElementsByTagName("Item")[0].childNodes[0].nodeValue;
	    var Company = batch.getElementsByTagName("Company")[0].childNodes[0].nodeValue;
	    var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
	    var PDate = batch.getElementsByTagName("PDate")[0].childNodes[0].nodeValue;
	    var PO = batch.getElementsByTagName("PO")[0].childNodes[0].nodeValue;
		var Serial = batch.getElementsByTagName("Serial")[0].childNodes[0].nodeValue;
		var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Stock = batch.getElementsByTagName("Stock")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td  class='boldEleven'>";
		str=str+"<input name='assetid' id='assetid' type='checkbox' value='"+Id+"' />"+(loop+1)	;
		str=str+"<td  class='boldEleven'>"+Group;
		str=str+"<td  class='boldEleven'>"+Item;
		str=str+"<td  class='boldEleven'>"+Company;
		str=str+"<td  class='boldEleven'>"+Branch;
		str=str+"<td  class='boldEleven'>"+Division;
		str=str+"<td  class='boldEleven'>"+PDate;
		str=str+"<td  class='boldEleven'>"+PO;
		str=str+"<td  class='boldEleven'>"+Serial;
		str=str+"<td  class='boldEleven'>"   ;
		if(Status == "N")
			str=str+"<font class='boldred'>Fault</font>"
		else 
			str=str+"<font class='boldgreen'>Good</font>"
		
		str=str+"<td  class='boldEleven'>"  ;
		if(Stock == "Y")
			str=str+"<font class='boldred'>Not in stock</font>"
		else 
			str=str+"<font class='boldgreen'>In Stock</font>"
     }
     str=str+"</table>";

     var tb=document.getElementById('AssetEntry');
  	 tb.innerHTML=str  ; 
  	
} 
 
 