

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

function loadServiceBilling(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var url = "../inventory?actionS=INVServiceBilling&type=1&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&day="+day;
    initRequest(url);
   	req.onreadystatechange = ServiceBillingRequest;
   	req.open("GET", url, true);
    req.send(null);
}




function loadServiceBillings(ctr) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var url = "../inventory?actionS=INVServiceBilling&type=2&Branch="+escape(Branch)+"&id="+escape(ctr.value)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&day="+day;
    initRequest(url);
   	req.onreadystatechange = ServiceBillingRequest;
   	req.open("GET", url, true);
    req.send(null);
}



function ServiceBillingRequest() 
{	
	if(req.readyState == 4) 
    {    	
		ClearTable('ServiceBilling');
	    ClearTabler('totRec')
		if (req.status == 200)
        {
    	   ServiceBillingMessages();
        }
    }
}


function ServiceBillingMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Services")[0];   
	 
	var sumtotal=0;
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow3'>";
	str=str+"<td  class='boldEleven' align='center'><b>S.No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Invoice No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Date</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Division</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Customer </b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Sales Reference</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Amount</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>&nbsp;</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Payment Status</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Payment Commitment</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Entry By</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Cancel</b></td>";
	
	str=str+"</tr>";
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Invoiceno = batch.getElementsByTagName("Invoiceno")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
        var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
		var Amount= batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
		var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Commitment= batch.getElementsByTagName("Commitment")[0].childNodes[0].nodeValue;
		var Userids= batch.getElementsByTagName("Userid")[0].childNodes[0].nodeValue;
		var Cancel= batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
		var Usertype= batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
		var Division= batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
		var Dtcheck= batch.getElementsByTagName("Dtcheck")[0].childNodes[0].nodeValue;
		
		if("Y" == Cancel)
			str=str+"<tr class='MRow0'>";
		else
		{
				if(loop%2==0)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";	
		}
		
		if("Y" == Cancel || Dtcheck == "1")
			str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven'><input name='salesid' type='checkbox' value='"+Invoiceno+"' />"+(loop+1)+"</td>";
		
		str=str+"<td  class='boldEleven'>"+Invoiceno+"</td>";
		str=str+"<td  class='boldEleven'>"+Date+"</td>";
		str=str+"<td  class='boldEleven'>"+Division+"</td>";
		
		str=str+"<td  class='boldEleven'>"+Customer+"</td>";
		str=str+"<td  class='boldEleven' >"+Ref+"</td>";
		str=str +"<td  class='boldEleven' align='right'>&nbsp;"+Amount+"</td>";
		str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:ServiceBillingPrint('"+Invoiceno+"')\"><font class='boldEleven'>Print</font></a>"
		
		if( (Usertype == "F") &&  ("N" == Cancel)  )
			if (Dtcheck == "0" )
				str = str +"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=ServiceBilling&actionS=INVServiceBillingCancel&salesid="+Invoiceno+"')\"><font class='boldgreen'>Cancel</font></a>";
		
		 	
		
		var strStat="";
		stat=Status;
		if(stat=="N")
			 strStat="<font class='boldred'>Pending</font>"
		 else if(stat=="P")
			 strStat="<font class='boldgreen'>Partially Paid</font>"
		 else if(stat=="Y")
			 strStat="<font class='boldgreen'>Completed</font>"
		
		
		str = str +"<td  class='boldEleven' align='right'>"+strStat+"</td>";
		
		if("Y" == Commitment)
			str=str+"<td width='100' align=right class='boldEleven'><font  class='boldgreen'>Commitement given</font>" ;	
		else						
			str=str+"<td width='100' align=right class='boldEleven'><a href='PaymentCommitmentEdit.jsp?salno="+Invoiceno+"&Billinttype=S'><font  class='bolddeepred'>Commitement not given</font></a>";		
		
		str = str +"<td  class='boldEleven' align='right'>&nbsp;"+Userids+"</td>";
		
		if("Y" == Cancel)
			str = str +"<td  class='boldEleven'><img src='../Image/report/cancel.gif' title='Cancelled Invoice'></td>";
		else
			str = str +"<td  class='boldEleven'>&nbsp;</td>";
		
		sumtotal= sumtotal+parseFloat(Amount);
     }
     
      str=str+"<tr height='25' class='MRow1'><td  colspan='6' align=right class='boldEleven'><b><font Color='red'>Total Amount</font></b></td>";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+  sumtotal.toFixed(2)+"</font></b></td><td>&nbsp;</td><td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td><td>&nbsp;</td>";
    
     str=str+"</table>";

     var tb=document.getElementById('ServiceBilling');
  	 tb.innerHTML=str  ; 
  	 str=" <font class='bolddeepred'><b>Total no of Records :: "  + loop+"</b></font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	
} 

function  ServiceBillingPrint(salno)
{
	
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	var f ="ServiceBillingPrint.jsp?salno="+salno ;
	newWindow = window.open(f,"subWind",styleStr);
	newWindow.focus( );
}



function cancelInvoice(query)
{  
	
	alert("Are you cancel the invoice");
	alert("Are you cancel the invoice");
	var name=confirm("Are you sure confirm to cancel the invoice")
	if (name==true)
	{
		var reason=prompt("Enter The Reason ","CANCELLED "); 
		var email=prompt("Kindly give the email id for sending informations for cancelled invoice ","test@test.com"); 
		query = query+"&reason="+reason+"&email="+email;
		location = query;
	}	
}


