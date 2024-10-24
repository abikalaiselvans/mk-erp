var isIE;
var req;
var names;

 
 
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

 function loadssparedemand(startLetter)
 {
 	var Issue = document.getElementById('Issue').value;
 	var day=document.getElementById('day').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var branch=document.getElementById('Branch').value;
	
	var url = "../inventoryCustomer?actionS=LoadSSparedemand&stype=1&startLetter="+escape(startLetter)+"&Issue="+Issue+"&month="+month+"&year="+year+"&day="+day+"&branch="+branch ;
   	initRequest(url);
	req.onreadystatechange=loadsparedemandRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadssparedemands(ctr)
 {
 	var Issue = document.getElementById('Issue').value;
 	var day=document.getElementById('day').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../inventoryCustomer?actionS=LoadSSparedemand&stype=2&startLetter="+escape(ctr.value)+"&Issue="+Issue+"&month="+month+"&year="+year+"&day="+day ;
	initRequest(url);
	req.onreadystatechange=loadsparedemandRequest;
    req.open("GET", url, true);
    req.send(null);
}

 
 function loadsparedemandRequest() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totRec');
	    ClearTable('SpareTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('SpareTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
			loadsparedemandRequestMessages();
        }
    }
}

function loadsparedemandRequestMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("RowsSpare")[0];   
    
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow1'>";
	str=str+"<td  class='boldEleven' align='center' ><b>S.No</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Demand Number</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Branch</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Customer</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Customer Address</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Serial Number</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Type</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Call Number</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Description</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>Entry By</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>&nbsp;</b></td>";
	str=str+"<td  class='boldEleven' align='center' ><b>&nbsp;</b></td>";
	str=str+"</tr>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("DId")[0].childNodes[0].nodeValue;
		var Dnumber = batch.getElementsByTagName("Dnumber")[0].childNodes[0].nodeValue;
		
	    var Callnum = batch.getElementsByTagName("Callnumber")[0].childNodes[0].nodeValue;
		var DSerial = batch.getElementsByTagName("DSerialno")[0].childNodes[0].nodeValue;
	   	var descrip = batch.getElementsByTagName("descrip")[0].childNodes[0].nodeValue;
	    var Issue = batch.getElementsByTagName("Issue")[0].childNodes[0].nodeValue;
	    
	    var demanddate = batch.getElementsByTagName("demanddate")[0].childNodes[0].nodeValue;
	    var branch = batch.getElementsByTagName("branch")[0].childNodes[0].nodeValue;
	    var customer = batch.getElementsByTagName("customer")[0].childNodes[0].nodeValue;
	    var type = batch.getElementsByTagName("type")[0].childNodes[0].nodeValue;
	    var customeraddress = batch.getElementsByTagName("customeraddress")[0].childNodes[0].nodeValue;
	    var Entry = batch.getElementsByTagName("Entry")[0].childNodes[0].nodeValue;
	    
	    var Usertype = batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";

	    if(Issue == "N")
	    	str=str+"<td  class='boldEleven' ><input name='id' id='id' type='checkbox' value='"+Id+"'/>"+(loop+1)+"</td>";
	    else
	    	str=str+"<td  class='boldEleven' >"+(loop+1)+"</td>";
	    
		str=str+"<td  class='boldEleven' >"+Dnumber +"</td>";
		str=str+"<td  class='boldEleven' >"+branch +"</td>";
		str=str+"<td  class='boldEleven' >"+customer +"</td>";
		str=str+"<td  class='boldEleven' >"+customeraddress +"</td>";
		str=str+"<td  class='boldEleven' >"+DSerial +"</td>";
		str=str+"<td  class='boldEleven' >"+type +"</td>";
		str=str+"<td  class='boldEleven' >"+Callnum+"</td>";
		str=str+"<td  class='boldEleven' >"+descrip+"</td>";
		str=str+"<td  class='boldEleven' >"+Entry+"</td>";
		
		if(Issue == "Y")
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>Issued</font</td>";
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>Not issue</font</td>";
		
		
		if( (Usertype =="F" || Usertype =="B") && (Issue == "Y") )
			str=str+"<td  class='boldEleven' ><a href=\"javascript:reopenSpareDemands('../SmartLoginAuth?filename=SSpareDemand&actionS=INVSpareDemandReopen&id="+Id+"')\"  style='text-decoration:none'><font class='boldgreen'>Reopen</font</a></td>";
		else
			str=str+"<td  class='boldEleven' >&nbsp;</td>";
		
		str=str+"</tr>";	
    }
   	 if(batchs.childNodes.length <1)
 		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
  	 
	 str=str+"</table>";
	 var tb=document.getElementById('SpareTable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
}



function   reopenSpareDemands(query)
{
	var rs=confirm("Are you sure reopen a Spare Demand ");
	if (rs==true)
		location = query;
		 	 
	
}
 

