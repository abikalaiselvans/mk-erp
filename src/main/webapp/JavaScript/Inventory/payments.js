

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
 



function SalesPayment(startLetter) 
{
	var pType=document.getElementById('payType').value;
	var division=document.getElementById('divis').value;
	var Payment=document.getElementById('Payment').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var Branch=document.getElementById('Branch').value;
	var tb=document.getElementById('SalesPaymentTables');
  	tb.innerHTML=""  ; 
	var url = "../inventory?actionS=INVLoadSalesPayment&type=1&payType="+escape(pType)+"&id="+escape(startLetter)+"&division="+division+"&Payment="+Payment+"&customer="+customer+"&year="+year+"&month="+month+"&day="+day+"&Branch="+Branch;
	console.log(url);
	var tb=document.getElementById('SalesPaymentTables');
  	tb.innerHTML=""  ; 
   	initRequest(url);
   	req.onreadystatechange = SalesRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function SalesPayments(ctr) 
{
	var pType=document.getElementById('payType').value;
	var division=document.getElementById('divis').value;
	var Payment=document.getElementById('Payment').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var tb=document.getElementById('SalesPaymentTables');
	var Branch=document.getElementById('Branch').value;
  	tb.innerHTML=""  ; 
	var url = "../inventory?actionS=INVLoadSalesPayment&type=2&payType="+escape(pType)+"&id="+escape(ctr.value)+"&division="+division+"&Payment="+Payment+"&customer="+customer+"&year="+year+"&month="+month+"&day="+day+"&Branch="+Branch;
	console.log(url);
	var tb=document.getElementById('SalesPaymentTables');
  	tb.innerHTML=""  ; 
   	initRequest(url);
   	req.onreadystatechange = SalesRequest;
   	req.open("GET", url, true);
    req.send(null);
}


function SalesRequest() 
{	
	if(req.readyState == 4) 
    {    	
		ClearTable("SalesPaymentTables");
		ClearTabler("totRec");
		if (req.status == 200)
        {
        	SalesMessages();
        }
    }
}


function SalesMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Payments")[0]; 
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	var dt="";
	var ch="";
	 
	var sumtotal=0;
	var paidamount=0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Customerid = batch.getElementsByTagName("Customerid")[0].childNodes[0].nodeValue;
        var Customername = batch.getElementsByTagName("Customername")[0].childNodes[0].nodeValue;
        var Totalamount = batch.getElementsByTagName("Totalamount")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var OrderDate= batch.getElementsByTagName("OrderDate")[0].childNodes[0].nodeValue;
		var Paidamount= batch.getElementsByTagName("Paidamount")[0].childNodes[0].nodeValue;
		var Balance= batch.getElementsByTagName("Balance")[0].childNodes[0].nodeValue;
		var Commitment= batch.getElementsByTagName("Commitment")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		
		if(Paidamount  != "0.0")
		{
			str=str+"<td width='150' class='boldEleven'>";
			str=str+"<input name='salesid' type='checkbox' value='"+Customerid +"' />"	;
			str=str+"<a href='SalesPaymentActionEdit.jsp?salesid="+Customerid +"&payType=Direct'><font class='boldgreen'>"+Customerid +"</font></a>";
			str=str+"</td>"; 
		}	
		else
		{
			str=str+"<a href='SalesPaymentActionEdit.jsp?salesid="+Customerid +"&payType=Direct'><font class='boldgreen'>"+Customerid +"</font></a>";
		}
		
			
		str=str+"<td width='150' class='boldEleven'>"+OrderDate+"</td>" ;
		str=str+"<td width='150' class='boldEleven'>"+Customername +"</td>" ;
		str=str+"<td width='150' class='boldEleven' align='right'>"+Totalamount +"</td>" ;
		str=str+"<td width='150' class='boldEleven' align='right'>&nbsp;"+Paidamount+"</td>" ;
		str=str+"<td width='150' class='boldEleven' align='right'>&nbsp;"+Balance +"</td>" ;
		
		sumtotal=sumtotal+parseFloat(Totalamount );
		if("-" != Paidamount )
			paidamount=paidamount+parseFloat(Paidamount );
		
		strStat="";
		stat=Status ;
		if( parseFloat(Balance ) <1){
			strStat="<font color='blue'>Completed</font>";
		}
		else {
			if(stat=="N")
				 strStat="<font class='boldred'>Pending</font>"
			 else if(stat=="P")
				 strStat="<font class='boldgreen'>Partially Paid</font>"
			// else if(stat=="Y")
			//	 strStat="<font class='boldgreen'>Completed</font>"
		}
		
		str = str +"<td width='150' class='boldEleven' align='right'>"+strStat+"</td>";
		window.status=(loop+1);
     }
     
       
     str=str+"<tr height='25' class='MRow1'><td  colspan='3' align=right class='boldEleven'><b><font Color='red'>Total Amount</font></b></td>";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+  sumtotal.toFixed(2)+"</font></b></td>";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+  paidamount.toFixed(2)+"</font></b></td>  ";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+  (sumtotal.toFixed(2)-paidamount.toFixed(2))+"</font></b></td><td>&nbsp;</td>"; 
    
     str=str+"</table>";
     
     var tb=document.getElementById('SalesPaymentTables');
  	 tb.innerHTML=str  ; 
  	
  	 str=" <font class='bolddeepred'><b>Total no of Records :: "  + loop+"</b></font>";
 	 var tb=document.getElementById('totRec');
 	 tb.innerHTML=str
}

 
