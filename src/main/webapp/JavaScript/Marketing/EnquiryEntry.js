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

 function LoadEnquiryEntry(startLetter)
 {
 	//var day = document.getElementById('day').value;
 	//var month =document.getElementById('month').value;
 	//var year =document.getElementById('year').value;
	//var customer =document.getElementById('customer').value;
	//var url = "../marketing?actionS=LoadScheduleEntrystaff&startLetter="+escape(startLetter)+"&day="+day+"&month="+month+"&year="+year+"&customer="+customer;
	var url = "../marketing?actionS=LoadEnquiryEntry&startLetter="+escape(startLetter);
   	initRequest(url);
	req.onreadystatechange=LoadEnquiryEntryRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadEnquiryEntryRequest() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totalrec');
	    ClearTable('GroupTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('GroupTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
			LoadEnquiryEntryMessages();
        }
    }
}

function LoadEnquiryEntryMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("CustomerRows")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	var call="";
	var statusclose="",statusclose1="";
	var callN="";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("EnquiryId")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("CustomerName")[0].childNodes[0].nodeValue;
		var subjec = batch.getElementsByTagName("Subject")[0].childNodes[0].nodeValue;
		var callreceived = batch.getElementsByTagName("Callreceived")[0].childNodes[0].nodeValue;
	    var callassig = batch.getElementsByTagName("CallAssig")[0].childNodes[0].nodeValue;
		//var Customerid = batch.getElementsByTagName("Customerid")[0].childNodes[0].nodeValue;
		//var Customertype = batch.getElementsByTagName("Customertype")[0].childNodes[0].nodeValue;
		//alert(Name+"Name..."+subjec+"subjec..."+callassig+"callassig...");
	   
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";

			str=str+"<td  class='boldEleven' width='8%'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
			str=str+"<td  class='boldEleven' width='23%'>&nbsp; "+Name +"</td>";
			str=str+"<td  class='boldEleven' width='23%'>&nbsp;"+subjec+"</td>";
			str=str+"<td  class='boldEleven' width='23%'>&nbsp;"+callreceived+"</td>";
			str=str+"<td  class='boldEleven' width='23%'>&nbsp;"+callassig+"</td>";
		str=str+"</tr>";	
    }
   	 if(batchs.childNodes.length <1)
 		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
  	 
	 str=str+"</table>";
	 var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
}