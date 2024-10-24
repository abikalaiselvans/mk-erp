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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 function LoadFunnel(startLetter)
 {
	var calltype = document.getElementById('calltype').value;
	var customer =document.getElementById('customer').value;
	var stage =document.getElementById('stage').value;
	var me =document.getElementById('me').value;
	var url = "../marketing?actionS=LoadFunnel&me="+me+"&startLetter="+escape(startLetter)+"&customer="+customer+"&calltype="+calltype+"&stage="+stage;
   	 
	initRequest(url);
	req.onreadystatechange=LoadFunnelstaff;
    req.open("GET", url, true);
    req.send(null);
    
}
 
 function LoadFunnelstaff() 
 {
	if(req.readyState == 4) 
    {    	
		ClearTabler('totalrec');
	    ClearTable('GroupTable');
		if (req.status == 200) 
        {		  	
          	var tb=document.getElementById('GroupTable');
		  	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
		  	LoadFunnelMessagesstaff();
        }
    }
}

 
function LoadFunnelMessagesstaff() 
{	 
    var batchs = req.responseXML.getElementsByTagName("RowsSStaff")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr  class='MRow1'>";
	str=str+"<td align='center'><b>S.No</b></td>";
	str=str+"<td align='center'><b>M.E</b></td>";
	str=str+"<td align='center'><b>Client Name</b></td>";
	str=str+"<td align='center'><b>Product</b></td>";
	str=str+"<td align='center'><b>Stage</b></td>";
	str=str+"<td align='center'><b>Fdate</b></td>";
	str=str+"<td align='center'><b>Qty</b></td>";
	str=str+"<td align='center'><b>Value</b></td>";
	str=str+"<td align='center'><b>Total</b></td>";
	str=str+"<td align='center'><b>Owner</b></td>";
	 
	str=str+"</tr>";
	
	var call="";
	var statusclose="",statusclose1="";
	var callN="";
	var sum =0;
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var ME = batch.getElementsByTagName("ME")[0].childNodes[0].nodeValue;
	    var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
		var Product = batch.getElementsByTagName("Product")[0].childNodes[0].nodeValue;
	    var Stage = batch.getElementsByTagName("Stage")[0].childNodes[0].nodeValue;
	    var FDate = batch.getElementsByTagName("FDate")[0].childNodes[0].nodeValue;
	    var Qty = batch.getElementsByTagName("Qty")[0].childNodes[0].nodeValue;
		var Value = batch.getElementsByTagName("Value")[0].childNodes[0].nodeValue;
		var Total = batch.getElementsByTagName("Total")[0].childNodes[0].nodeValue;
		var Owner = batch.getElementsByTagName("Owner")[0].childNodes[0].nodeValue;
		var Color = batch.getElementsByTagName("Color")[0].childNodes[0].nodeValue;
		
		
		
		sum = sum+parseFloat(Value);
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
 
		str=str+"<td  class='boldEleven' >"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven' > "+ME+"</td>";
		str=str+"<td  class='boldEleven' >"+Customer+"</td>";
		str=str+"<td  class='boldEleven' >"+Product+"</td>";
		str=str+"<td  class='boldEleven' align='right' >"+Stage+"</td>";
		str=str+"<td  class='boldEleven' >"+FDate+"</td>";
		str=str+"<td  class='boldEleven' align='right'  >"+Qty+"</td>";
		str=str+"<td  class='boldEleven' align='right'  >"+Value+"</td>";
		str=str+"<td  class='boldEleven' align='right'  bgcolor='"+Color+"' >"+Total+"</td>";
		str=str+"<td  class='boldEleven' >"+Owner+"</td>";
		str=str+"</tr>";	
    }
   	
  	if(batchs.childNodes.length <1)
 		str=str+"<td colspan='10' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
  	else
  	{
  		str=str+"<tr class='MRow1'>";
  		str=str+"<td  class='bolddeepred' colspan='8' ><center>TOTAL [in lakhs ] </center></td>";
  		str=str+"<td  class='boldEleven' align='right'>"+(sum/100000).toFixed(2)+"</td>";
  		
  		str=str+"<td>&nbsp;</td>";
  		str=str+"</tr>";
  	}
	str=str+"</table>";
	var tb=document.getElementById('GroupTable');
  	tb.innerHTML=str   ;
  	tb=document.getElementById('totalrec');
  	tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
}