var isIE;
var req;
var names;

 
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
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

 function loadservice(startLetter)
 {
 	var Type = document.getElementById('Type').value;
	//var customer =document.getElementById('customer').value;
	//var url = "../inventoryCustomer?actionS=loadserviceEntry&startLetter="+escape(startLetter)+"&Type="+Type+"&month="+month+"&year="+year+"&customer="+customer;
	var url = "../inventoryCustomer?actionS=INVService&startLetter="+escape(startLetter)+"&Type="+Type;
   	initRequest(url);
	req.onreadystatechange=loadserviceRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadserviceRequest() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totRec');
	    ClearTable('ServiceTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('ServiceTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
			loadserviceRequestMessages();
        }
    }
}

function loadserviceRequestMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("RowsSer")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("CustomerName")[0].childNodes[0].nodeValue;
		var serialno = batch.getElementsByTagName("Serialno")[0].childNodes[0].nodeValue;
	   	var type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
	    var SDate = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue;
	    var EDate = batch.getElementsByTagName("EDate")[0].childNodes[0].nodeValue;
		if(type=='A')
			type="Amc";
		else
			type="Warranty";
			
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";

		str=str+"<td  class='boldEleven' width='5%'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven' width='19%'>&nbsp;"+type+"</td>";
		str=str+"<td  class='boldEleven' width='19%'>&nbsp; "+Name +"</td>";
		str=str+"<td  class='boldEleven' width='19%'>&nbsp;"+serialno+"</td>";
		str=str+"<td  class='boldEleven' width='19%'>&nbsp;"+SDate+"</td>";
		str=str+"<td  class='boldEleven' width='19%'>&nbsp;"+EDate+"</td>";
		
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