
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
 


function loadPaymentCommitment(startletter) 
{
	 
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
    var customer=document.getElementById('customer').value; 
    var division=document.getElementById('division').value; 
    var salestype=document.getElementById('salestype').value; 
    var Branch=document.getElementById('Branch').value; 
    var day=document.getElementById('day').value;
    
    var url = "../inventoryCustomer?actionS=INVPaymentCommitment&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&customer="+customer+"&division="+division+"&salestype="+salestype+"&Branch="+Branch+"&day="+day;
    
    initRequest(url);   
    req.onreadystatechange = PaymentCommitmentRequest;
    req.open("GET", url, true);
    req.send(null);
}



function PaymentCommitmentRequest() 
{
	ClearTable('PaymentCommitmentTable');
    ClearTabler('totRec')
    if(req.readyState == 4) 
    {    	
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
        if (req.status == 200) 
        {		  	
          PaymentCommitmentMessages();
        }
    }
}

function PaymentCommitmentMessages() {
    
    var batchs = req.responseXML.getElementsByTagName("directSales")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var InvoiceNumber = batch.getElementsByTagName("InvoiceNumber")[0];
        var InvoiceDate = batch.getElementsByTagName("InvoiceDate")[0];
        var Customer = batch.getElementsByTagName("Customer")[0];
        var NoofDue = batch.getElementsByTagName("NoofDue")[0];
        var InvoiceAmount = batch.getElementsByTagName("InvoiceAmount")[0];    
        var Cdate = batch.getElementsByTagName("Cdate")[0];    
        var CAmount = batch.getElementsByTagName("CAmount")[0];    
        var Status = batch.getElementsByTagName("Status")[0];     
         
                 
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		
		str=str+"<td class='boldEleven' width='200'><input type='checkbox' name='salno' id='salno' value ='"+InvoiceNumber.childNodes[0].nodeValue+"'>"+InvoiceNumber.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' width='100'>"+InvoiceDate.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' width='350'>"+Customer.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' width='25'>"+NoofDue.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' width='50'>"+InvoiceAmount.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' width='100'>"+Cdate.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' width='100'>"+CAmount.childNodes[0].nodeValue;
		if(Status.childNodes[0].nodeValue=="Y")
			str=str+"<td class='boldEleven' width='50'><a href='PaymentCommitmentUpdate.jsp?salno="+InvoiceNumber.childNodes[0].nodeValue+"'><font color='blue'>Modify</font></a> / Completed";
		else	
			str=str+"<td class='boldEleven' width='50'><font color='red'><b>Pending</b></font>";
		
		
		if(Status.childNodes[0].nodeValue=="Y")
			str=str+"<td class='boldEleven' width='50'><font class='boldgreen'><b>Closed </b></font>";
		else
			str=str+"<td class='boldEleven' width='50'><font class='bolddeepred'><b>Pending</b></font>";
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true;
     	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
     	document.getElementById('btnEdit').disabled=false;
     	 
     }
     var tb=document.getElementById('PaymentCommitmentTable');
  	 tb.innerHTML=str   
  	 str=" <font class='bolddeepred'><b>Total no of Records :: "  + loop+"</b></font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	 
}




