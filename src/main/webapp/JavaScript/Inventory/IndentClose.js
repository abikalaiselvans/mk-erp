


function loadIndentClose(startLetter) 
{
	var dept=document.getElementById('dept').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var status=document.getElementById('status').value;
	var payment=document.getElementById('payment').value;
	
	var url = "../inventory?actionS=loadIndentClose&dept="+escape(dept)+"&id="+escape(startLetter)+"&month="+month+"&year="+year+"&status="+status+"&payment="+payment;
	var tb=document.getElementById('PurchaseIndent');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = IndentCloseRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function IndentCloseRequest() 
{	
	if(req.readyState == 4) 
    {    	
       if (req.status == 200)
        {
        	var tb=document.getElementById('PurchaseIndent');
  	 		tb.innerHTML=" lOADING DATA" ; 
        	IndentCloseMessages();
        }
    }
}


function IndentCloseMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Products")[0];   
	 
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	str=str+"<tr  class='MRow2'>";
	str=str+"<td class='boldEleven'><b>Indent no </b></td> ";
	str=str+"<td class='boldEleven'><b>Indent date</b></td> ";
	str=str+"<td class='boldEleven'><b>Expect date </b></td> ";
	str=str+"<td class='boldEleven'><b>Department</b></td> ";
	str=str+"<td class='boldEleven'><b>From</b></td> ";
	str=str+"<td class='boldEleven'><strong>Amount</strong></td> ";
	str=str+"<td class='boldEleven'><strong>Approval</strong></td> ";
	str=str+"<td class='boldEleven'><strong>Approval date / View </strong></td> ";
	str=str+"<td class='boldEleven'><strong>P.O. Number</strong></td> ";
	str=str+"<td class='boldEleven'><strong>P.O. Date</strong></td> ";
	str=str+"<td class='boldEleven'><strong>Payment</strong></td> ";
	str=str+"</tr> ";

	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0];
        var Po = batch.getElementsByTagName("Po")[0];
        var Indentdate = batch.getElementsByTagName("Indentdate")[0];
        var Expectdate = batch.getElementsByTagName("Expectdate")[0];
		var Depart= batch.getElementsByTagName("Depart")[0];
		var Amount= batch.getElementsByTagName("Amount")[0];
		var Empid= batch.getElementsByTagName("Empid")[0];
		var Name= batch.getElementsByTagName("Name")[0];
		var Approval= batch.getElementsByTagName("Approval")[0];
		var Approvaldate= batch.getElementsByTagName("Approvaldate")[0];
		var Ponumber= batch.getElementsByTagName("Ponumber")[0];
		var Podate= batch.getElementsByTagName("Podate")[0];
		var Payment= batch.getElementsByTagName("Payment")[0];
		var usertype= batch.getElementsByTagName("usertype")[0];
		
		
		  			
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<td  class='boldEleven'>";
		if("Y" !=Approval.childNodes[0].nodeValue)
			str=str+"<input name='indentid'   id='indentid' type='checkbox' value='"+Po.childNodes[0].nodeValue+"' />"+Po.childNodes[0].nodeValue	;
		else
			str=str+Po.childNodes[0].nodeValue;	
			
		str=str+"<td  class='boldEleven'>"+Indentdate.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Expectdate.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Empid.childNodes[0].nodeValue +" / "+Name.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'  align='right'>"+Amount.childNodes[0].nodeValue;
		
		if("Y" ==Approval.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>Approved</font> / <font class='boldgreen'> <a href=\"../SmartLoginAuth?filename=PurchaseIndent&actionS=INVPurchaseIndentCloseRestore&indentid="+Po.childNodes[0].nodeValue+"\"><font class='boldgreen'>Restore</font> </a></font>";
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>Pending</font>";	
		
		str=str+"<td  class='boldEleven'  align='right'>"+Approvaldate.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'  align='right'>"+Ponumber.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'  align='right'>"+Podate.childNodes[0].nodeValue;
		
		if("Y" ==Payment.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>Paid</font>";
		else if("P" ==Payment.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>Partially Paid</font>";	
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>Not Paid</font>";	
		
		 
		 
		
	
     }
     str=str+"</table>";

     var tb=document.getElementById('PurchaseIndent');
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
