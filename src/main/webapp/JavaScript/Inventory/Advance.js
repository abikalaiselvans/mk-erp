
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
 


function loadAdvanceAmount(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var advanceto=document.getElementById('advanceto').value;
	
	var url = "../inventory?actionS=loadAdvanceAmount&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&day="+day+"&advanceto="+advanceto;
	initRequest(url);
   	req.onreadystatechange = loadAdvanceAmountRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function loadAdvanceAmountRequest() 
{	
	try
	{
		if(req.readyState == 4) 
	    {    	
			ClearTable('AdvanceAmount');
			ClearTabler('totalrecord');
			if (req.status == 200)
	        {
	        	  
	  	 		loadAdvanceAmountMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err);
	}
}


function loadAdvanceAmountMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Advancesss")[0];   
	 
	var sumtotal=0;
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow1'>";
	str=str+"<td  class='boldEleven'><center><b>S.NO</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Advance No</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Customer Name</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Division</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Amount</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Transfer Amount</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Balance Amount</b></center></td>";
	
	str=str+"<td  class='boldEleven'><center><b>Payment Date</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Received Date</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Collected By</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Entry By</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Transfer Status</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Type</b></center></td>";
	str=str+"</tr>";
	var tablename="";
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Advanceid = batch.getElementsByTagName("Advanceid")[0].childNodes[0].nodeValue;
	    var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
	    var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
	    var Amount = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
	    var PaymentDate = batch.getElementsByTagName("PaymentDate")[0].childNodes[0].nodeValue;
	    var CollectedBY = batch.getElementsByTagName("CollectedBY")[0].childNodes[0].nodeValue;
	    var EntryBY = batch.getElementsByTagName("EntryBY")[0].childNodes[0].nodeValue;
	    var Transfer = batch.getElementsByTagName("Transfer")[0].childNodes[0].nodeValue;
	    var ReceivedDate = batch.getElementsByTagName("ReceivedDate")[0].childNodes[0].nodeValue;
	    var Advanceno = batch.getElementsByTagName("Advanceno")[0].childNodes[0].nodeValue;
	    var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
	    var Transferamount = batch.getElementsByTagName("Transferamount")[0].childNodes[0].nodeValue;
	    var Balance = batch.getElementsByTagName("Balance")[0].childNodes[0].nodeValue;
	    var Groupid = batch.getElementsByTagName("Groupid")[0].childNodes[0].nodeValue;
	    
	   if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
	   var f = parseFloat(Balance);
	   
		if(Balance >1)
			str=str+"<td  class='boldEleven'><input name='advanceid'  id='advanceid' type='checkbox' value='"+Advanceid+"' />"+(loop+1)+". </td>"	;
		else
			str=str+"<td  class='boldEleven'>"+(loop+1)+". </td>"	;
		
		str=str+"<td  class='boldEleven'>"+Advanceno+"</td>";
		str=str+"<td  class='boldEleven'>"+Customer+"</td>";
		str=str+"<td  class='boldEleven'>"+Division+"</td>";
		str=str+"<td  class='boldEleven' align='right'>"+Amount+"</td>";
		str=str+"<td  class='boldEleven' align='right'>"+Transferamount+"</td>";
		str=str+"<td  class='boldEleven' align='right'>"+Balance+"</td>";
		str=str+"<td  class='boldEleven'>"+PaymentDate+"</td>";
		str=str+"<td  class='boldEleven'>"+ReceivedDate+"</td>";
		str=str+"<td  class='boldEleven'>"+CollectedBY+"</td>";
		str=str+"<td  class='boldEleven'>"+EntryBY+"</td>";
		
		
		if(Type == "D" )
			tablename = " inv_t_directsales ";
		else
			tablename = " inv_t_servicebilling ";
		
		
		//if(Transfer =="Y")
		if(Balance >1)
			str=str+"<td  class='boldEleven'><a href='AdvanceSingleEntryMultipleInvoiceActionBefore.jsp?Rowid="+Groupid+"&type="+Type+"&Advanceid="+Advanceid+"'><font class='bolddeepred'>Want to Adjust</font></a></td>";
		else
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Closed</font></td>";
		
			
		if(Type =="D")
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Sales</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Service</font></td>";
		
		sumtotal= sumtotal+parseFloat(Amount);
     }
     
     str=str+"<tr height='25' class='MRow1'><td  colspan='4' align=right class='boldEleven'><b><font Color='red'>Total Amount</font></b></td>";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+  sumtotal.toFixed(2)+"</font></b></td><td   colspan='8' >&nbsp;</td>";
    
     str=str+"</table>";

     var tb=document.getElementById('AdvanceAmount');
  	 tb.innerHTML=str  ; 
  	
  	 tb=document.getElementById('totalrecord');
 	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 

} 




function  loadAdvanceAmountPrint(salno)
		{
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="ServiceBillingPrint.jsp?salno="+salno ;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
