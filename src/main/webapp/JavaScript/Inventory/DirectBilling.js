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
 


function loadDirectBilling(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../inventory?actionS=INVDirectBilling&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year;
	var tb=document.getElementById('DirectBilling');
  	tb.innerHTML=""  ; 
   	initRequest(url);
   	req.onreadystatechange = DirectBillingRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function DirectBillingRequest() 
{	
	ClearTable('DirectBilling');
    ClearTabler('totRec');
	if(req.readyState == 4) 
    {    	
    	
       if (req.status == 200)
        {
        	
        	DirectBillingMessages();
        }
    }
}


function DirectBillingMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Directs")[0];   
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	var sumtotal=0;
	var dt="";
	var ch="";
	if(batchs.childNodes.length<1)
	{
		str=str+"<tr><td colspan=7>Data not found...</td></tr>";
	}
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Invoiceno = batch.getElementsByTagName("Invoiceno")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Customer = batch.getElementsByTagName("Customer")[0];
        var Ref = batch.getElementsByTagName("Ref")[0];
		var Amount= batch.getElementsByTagName("Amount")[0];
		var Status= batch.getElementsByTagName("Status")[0];
		var Commitment= batch.getElementsByTagName("Commitment")[0];
		var Userids= batch.getElementsByTagName("Userid")[0];
		var Rowid= batch.getElementsByTagName("Rowid")[0];
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		
		str=str+"<td  class='boldEleven'>";
		str=str+"<input name='salesid' id='salesid' type='checkbox' value='"+Rowid.childNodes[0].nodeValue+"' />"+(loop+1)	;
		str=str+"<td  class='boldEleven'>";
		str=str+Invoiceno.childNodes[0].nodeValue;

		str=str+"<td  class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Customer.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Ref.childNodes[0].nodeValue;
		str = str +"<td  class='boldEleven' align='right'>&nbsp;"+Amount.childNodes[0].nodeValue;
		var strStat="";
		stat=Status.childNodes[0].nodeValue;
		if(stat=="N")
			 strStat="<font class='boldred'>Pending</font>"
		 else if(stat=="P")
			 strStat="<font class='boldgreen'>Partially Paid</font>"
		 else if(stat=="Y")
			 strStat="<font class='boldgreen'>Completed</font>"
		str = str +"<td  class='boldEleven' align='right'>"+strStat;
		
		
		
		
		if("-" == Commitment.childNodes[0].nodeValue)
			str=str+"<td width='100' align=right class='boldEleven'><font  class='boldgreen'>Committement  </font>" ;	
		else						
			str=str+"<td width='100' align=right class='boldEleven'><a href='PaymentCommitmentEdit.jsp?salno="+Invoiceno.childNodes[0].nodeValue+"'><font  class='bolddeepred'>Not Committement</font></a>";		
		
		
		
		str = str +"<td  class='boldEleven' align='right'>&nbsp;"+Userids.childNodes[0].nodeValue;
		sumtotal= sumtotal+parseFloat(Amount.childNodes[0].nodeValue);	
     }
     
     
     str=str+"<tr height='25' class='MRow1'><td  colspan='5' align=right class='boldEleven'><b><font Color='red'>Total Amount</font></b></td>";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+sumtotal.toFixed(2)+"</font></b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td> ";
    
     str=str+"</table>";
     var tb=document.getElementById('DirectBilling');
  	 tb.innerHTML=str  ; 
  	 
  	 str="<br><center><font class='bolddeepred'>Total no of Records : "  + loop+"</font></center><br>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str 
  	
}


