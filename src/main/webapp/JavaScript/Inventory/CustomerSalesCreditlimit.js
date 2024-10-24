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
	 var str="<center class='boldEleven'><font color='red'>Previuos Data not found for the Customer...</font><center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str  
  	    
  	 tb=document.getElementById("creditdetailerror");	 
  	 tb.innerHTML="";
	 
}
  
var divname="";
var sum=0;
var creditsum=0;

function LoadCreditLimt(ctr,ctr1,type) 
{
	
	divname=ctr1	 ;
	var customerId=document.getElementById(ctr).value;
	 
	var url = "../inventory?actionS=INVCustomerSalesCreditlimt&customerId="+escape(customerId)+"&type="+type ;
	
	initRequest(url);
    req.onreadystatechange = LoadCreditLimtRequest;
    req.open("GET", url, true);
    req.send(null);
    
}

function LoadCreditLimtRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable(divname);
        
         
        if (req.status == 200) 
        {		  	
          LoadCreditLimtMessages();
        }
    }
}


function LoadCreditLimtMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	sum=0;
	creditsum=0;
	var str=""; 
	var loop;
	str=str+"<table width='100%'  class='boldEleven'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow1'>" ;
	str=str+"<td width='140' class='boldEleven'><b>S.No</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Sale No</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Date</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Days Left</b></td>" ;
	str=str+"<td width='140' class='boldEleven'><b>Amount</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Payment Status</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Customer</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Staff Name</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Division</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Company</b></td>" ;
	str=str+"<td width='150' class='boldEleven'><b>Branch</b></td>" ;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    link="";
    	link1="";
	    var batch = batchs.childNodes[loop];
        var Saleno = batch.getElementsByTagName("Saleno")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Daysleft = batch.getElementsByTagName("Daysleft")[0];
        var Amount = batch.getElementsByTagName("Amount")[0];
        var PaymentStatus = batch.getElementsByTagName("PaymentStatus")[0];
        var Customer = batch.getElementsByTagName("Customer")[0];
        var Stafff = batch.getElementsByTagName("Stafff")[0];
        var Division = batch.getElementsByTagName("Division")[0];
        var Company = batch.getElementsByTagName("Company")[0];
        var Branch = batch.getElementsByTagName("Branch")[0];
        var cc = batch.getElementsByTagName("creditsum")[0];
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<td width='10' class='boldEleven'>"+(loop+1);
		str=str+"<td width='140' class='boldEleven'>"+Saleno.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Date.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Daysleft.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven' align='right'>"+ Amount.childNodes[0].nodeValue;
		str=str+"<td width='140' class='boldEleven'>"+ PaymentStatus.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Customer.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Stafff.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Division.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Company.childNodes[0].nodeValue;
		str=str+"<td width='150' class='boldEleven'>"+ Branch.childNodes[0].nodeValue;
		sum = sum +parseFloat(Amount.childNodes[0].nodeValue);
		creditsum=cc.childNodes[0].nodeValue;
	 }creditsum
	  str=str+"<tr  class='MRow2'>";	
	  str=str+"<td width='100%' class='boldEleven' colspan='12'><table align='center' border='0'><tr><td class='boldEleven'><b><font color='red'>Credit Amount </font></td> <td class='boldEleven'><b><font color='red'>"+creditsum+"</font></td> <td class='boldEleven'><b><font color='red'>Balance Pending Amount</font></td><td class='boldEleven'align='right'><b>"+sum+"</td></tr></table>"; 	 
	  str=str+"</tr>";
	  str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
        var tb=document.getElementById(divname);
  	 	tb.innerHTML="<center class='boldEleven'>Data not found<center>"; 
  	 }
  	 else
  	 {
  	    var tb=document.getElementById(divname);
  	 	tb.innerHTML=str ;  
  	 	document.getElementById('pendingamount').value=sum;
  	 	document.getElementById('creditamount').value=creditsum;
  	 	
  	 	
  	 }
}		

  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
function LoadCreditAmount(ctr) 
{
	var customerId=document.getElementById(ctr).value;
	var url = "../inventory?actionS=INVCustomerSalesCreditAmount&customerId="+escape(customerId);
	 
	initRequest(url);
    req.onreadystatechange = LoadCreditAmountRequest;
    req.open("GET", url, true);
    req.send(null);
    
}

function LoadCreditAmountRequest() 
{
    if(req.readyState == 4) 
    {    	
       if (req.status == 200) 
        {		  	
          LoadCreditAmountsMessages();
        }
    }
}


function LoadCreditAmountsMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	
	creditsum=0;
	var loop;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var cc = batch.getElementsByTagName("creditsum")[0];
    	creditsum=cc.childNodes[0].nodeValue;
    	 
	 }
	 
	 document.getElementById('creditamount').value=creditsum;
  	 
}		

  
  