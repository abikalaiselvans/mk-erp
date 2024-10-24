function loadServiceBilling(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var url = "../inventory?actionS=INVServiceBilling&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year;
	var tb=document.getElementById('ServiceBilling');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = ServiceBillingRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function ServiceBillingRequest() 
{	
	if(req.readyState == 4) 
    {    	
       if (req.status == 200)
        {
        	var tb=document.getElementById('ServiceBilling');
  	 		tb.innerHTML=" lOADING DATA" ; 
        	ServiceBillingMessages();
        }
    }
}


function ServiceBillingMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Services")[0];   
	//Invoiceno,Date,Customer,Ref,Amount,Status,
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Invoiceno = batch.getElementsByTagName("Invoiceno")[0];
        var Date = batch.getElementsByTagName("Date")[0];
        var Customer = batch.getElementsByTagName("Customer")[0];
        var Ref = batch.getElementsByTagName("Ref")[0];
		var Amount= batch.getElementsByTagName("Amount")[0];
		var Status= batch.getElementsByTagName("Status")[0];
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		//Invoiceno,Date,Customer,Ref,Amount,Status 
		
		str=str+"<td  class='boldEleven'>";
		str=str+"<input name='salesid' type='checkbox' value='"+Invoiceno.childNodes[0].nodeValue+"' />"+(loop+1)	;
		str=str+"<td  class='boldEleven'>";
		str=str+Invoiceno.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Customer.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Ref.childNodes[0].nodeValue;
		str = str +"<td  class='boldEleven' align='right'>&nbsp;"+Amount.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:ServiceBillingPrint('"+Invoiceno.childNodes[0].nodeValue+"')\"><font class='boldEleven'>Print</font></a>"
		var strStat="";
		stat=Status.childNodes[0].nodeValue;
		if(stat=="N")
			 strStat="<font class='boldred'>Pending</font>"
		 else if(stat=="P")
			 strStat="<font class='boldgreen'>Partially Paid</font>"
		 else if(stat=="Y")
			 strStat="<font class='boldgreen'>Completed</font>"
		str = str +"<td  class='boldEleven' align='right'>"+strStat;
     }
     str=str+"</table>";

     var tb=document.getElementById('ServiceBilling');
  	 tb.innerHTML=str  ; 
  	
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
