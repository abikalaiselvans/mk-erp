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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTableR(ctr1)
{
	 var str="<table width='100%' align=centet><tr><td class='errormessage'>Data not found</td></tr></table>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	
  	 
}

function LoadIndentPayment(startLetter) 
{
	var vendorid=document.getElementById('vendorid').value;
    var Status=document.getElementById('Status').value;  
    var url = "../inventory?actionS=LoadIndentPayment&Status="+Status+"&id="+escape(startLetter)+"&vendorid="+vendorid;
    LoadingTables('PaymentTable');
   	initRequest(url);
   	req.onreadystatechange = IndentPaymentRequest;
    req.open("GET", url, true);
    req.send(null);
}

function IndentPaymentRequest() 
{	
	if(req.readyState == 4) 
    {    	
        ClearTableR('PaymentTable');
        document.getElementById('Edit').disabled=true ;
       	if (req.status == 200)
        {
        	IndentPaymentMessages();
        }
    }
}

function IndentPaymentMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Payments")[0];   
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
	var dt="";
	var ch="";
	
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Purchaseid = batch.getElementsByTagName("Purchaseid")[0];
        var Vendorname = batch.getElementsByTagName("Vendorname")[0];
        var Totalamount = batch.getElementsByTagName("Totalamount")[0];
        var Paidamount = batch.getElementsByTagName("Paidamount")[0];
        var Blanace = batch.getElementsByTagName("Blanace")[0];
        var Status = batch.getElementsByTagName("Status")[0];
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='130' class='boldEleven'>"
		if(Paidamount.childNodes[0].nodeValue !="0.00")
		{
			ch="<input name='pid' type='checkbox' value='"+Purchaseid.childNodes[0].nodeValue+"' />"	;
			str=str+ch+Purchaseid.childNodes[0].nodeValue
			
		}
		else
		{
		str = str+Purchaseid.childNodes[0].nodeValue;
		}	
		
		str=str+"<td width='130' class='boldEleven'>"+Vendorname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven' align='right'>"+Totalamount.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven' align='right'>"+Paidamount.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven' align='right'>"+Blanace.childNodes[0].nodeValue;
		str = str +"<td width='60' class='boldEleven' align='right'>";
		
		if(Status.childNodes[0].nodeValue =="P")
			str = str +"<font color='Magenta'>Par.Pay</font>";
		else if(Status.childNodes[0].nodeValue =="N")
			str = str +"<font color='red'>Pending....</font>";
		else if(Status.childNodes[0].nodeValue =="Y")
			str = str +"<font color='blue'>Completed</font>";
		
     }
      
     if(batchs.childNodes.length >0)
     	document.getElementById('Edit').disabled=false ;
     else
     	document.getElementById('Edit').disabled=true ;
    
     str=str+"</table>";
     var tb=document.getElementById('PaymentTable');
  	 tb.innerHTML=str  ; 
}
 

 