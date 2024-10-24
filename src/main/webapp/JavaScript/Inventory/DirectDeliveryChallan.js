

function ClearTable(ctr1) 
{
	var str = "<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	var tb = document.getElementById(ctr1);
	tb.innerHTML = str
}

function ClearTabler(ctr1) 
{
	var str = "<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	var tb = document.getElementById(ctr1);
	tb.innerHTML = str
}


function loadDirectDeliveryChallan(startLetter) 
{
	
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var dcstatus=document.getElementById('dcstatus').value;
	
	var url = "../inventory?actionS=INVDirectDC&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&dcstatus="+dcstatus;
	var tb=document.getElementById('DC');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = loadDirectDeliveryChallanRequest;
   	req.open("GET", url, true);
    req.send(null);
    
}

function loadDirectDeliveryChallanRequest() 
{	
	if(req.readyState == 4) 
    {    	
		ClearTable('DC');
		ClearTabler('totRec');
       if (req.status == 200)
        {
        	var tb=document.getElementById('DC');
  	 		tb.innerHTML=" lOADING DATA" ; 
        	loadDirectDeliveryChallanMessages();
        }
    }
}


function loadDirectDeliveryChallanMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Services")[0];   
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	var dt="";
	var ch="";
	if(batchs.childNodes.length<1)
	{
		str=str+"<tr><td colspan=7>Data not found...</td></tr>";
	}
	var sum=0.0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var DCno = batch.getElementsByTagName("Invoiceno")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
        var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
		var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Dcamount= batch.getElementsByTagName("Dcamount")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		
		str=str+"<td  class='boldEleven'>";
		str=str+"<input name='salesid' type='checkbox' value='"+DCno+"' />"+(loop+1)	+"</td>";
		str=str+"<td  class='boldEleven'>"+DCno+"</td>";
		str=str+"<td  class='boldEleven'>"+Date+"</td>";
		str=str+"<td  class='boldEleven'>"+Customer+"</td>";
		str=str+"<td  class='boldEleven' >"+Ref+"</td>";
		str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DirectDeliveryChallanPrint('"+DCno+"')\"><font class='boldEleven'>Print</font></a> </td>";
		if("0"==Status)
		{
			str = str +"<td  class='boldEleven' align='left'>Opened</a>";
			str = str +"<td  class='boldEleven' align='right'><a href=\"javascript:DCclose('"+DCno+"')\"><font class='boldgreen'>Want to Close</font></a> </td>";
		}
		else if("1"==Status)
		{
			str = str +"<td  class='boldEleven' align='left'>Closed</a>";
			str = str +"<td  class='boldEleven' >Close</td>";
		}	
		str=str+"<td  class='boldEleven' align='right'>"+Dcamount+"</td>";
		sum = sum+parseFloat(Dcamount);
     }
     str=str+"<tr  class='MRow2'>";	
     str = str +"<td  class='boldEleven' align='right' colspan='8'>Total</td>" ;
     str = str +"<td  class='boldEleven' align='right'  >"+ (sum)+"</td>" ;
     str=str+"</tr>";
     str=str+"</table>";
     var tb=document.getElementById('DC');
  	 tb.innerHTML=str  ; 
  	 
  	 tb = document.getElementById('totRec');
	 tb.innerHTML = "<font  class='bolddeepred'>Total no of Records : "+ batchs.childNodes.length + "</font>";
} 

 


function  DirectDeliveryChallanUpdate(salno)
{
		
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="DirectDeliveryChallanUpdate.jsp?dcno="+salno ;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
}

function  DirectDeliveryChallanPrint(salno)
	{
		
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="DirectDeliveryChallanPrint.jsp?dcno="+salno ;
		//ServiceBillingPrint.jsp
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
}


	function DCclose(query)
	{  
		
		var name=confirm("Are you Sure Confirm to close the DC")
		
		if (name==true)
		{	
			var reason = prompt("Please enter your reason","Dc materials are billed");
			location = "../SmartLoginAuth?filename=DirectDeliveryChallan&actionS=INVDirectDeliveryChallanClosed&dcno="+query+"&reason="+reason;
		}
			
	}