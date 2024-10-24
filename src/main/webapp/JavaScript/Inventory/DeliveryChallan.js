

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
	var day=document.getElementById('day').value;
	var dcstatus=document.getElementById('dcstatus').value;
	var url = "../inventory?actionS=INVDeliveryChallan&type=2&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&dcstatus="+dcstatus+"&day="+day;
	var tb=document.getElementById('DC');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = loadDirectDeliveryChallanRequest;
   	req.open("GET", url, true);
    req.send(null);
}
 
function loadDirectDeliveryChallans(ctr) 
{ 
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var dcstatus=document.getElementById('dcstatus').value;
	var url = "../inventory?actionS=INVDeliveryChallan&type=2&Branch="+escape(Branch)+"&id="+escape(ctr.value)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&dcstatus="+dcstatus+"&day="+day;
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
        	loadDirectDeliveryChallanMessages();
       }
    }
}



function loadDirectDeliveryChallanMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Services")[0];   
	str = str + "<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	var dt="";
	var ch="";
	var sum=0.0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var DCno = batch.getElementsByTagName("Invoiceno")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
        var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
		var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Return= batch.getElementsByTagName("Return")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str = str + "<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		if("Y"!=Status)
			str=str+"<td  class='boldEleven'><input name='salesid' type='checkbox' value='"+DCno +"' />"+(loop+1)	+"</td>";
		else
			str=str+"<td  class='boldEleven'>"+(loop+1)	+"</td>";
		
		str=str+"<td  class='boldEleven'>"+DCno +"</td>";
		str=str+"<td  class='boldEleven'>"+Date +"</td>";
		str=str+"<td  class='boldEleven'>"+Customer +"</td>";
		str=str+"<td  class='boldEleven' >"+Ref +"</td>";
		str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DirectDeliveryChallanPrint('"+DCno +"')\"><font class='boldEleven'>Print</font></a> ";
		str=str+"&nbsp;&nbsp;/&nbsp;&nbsp;<a href=\"javascript:Printquery('../SmartLoginAuth?actionS=INVRept_JDeliveryChallan&filename=Rept_JDeliveryChallan&rptfilename=Rept_JDeliveryChallan&subrptfilename1=Rept_JDeliveryChallan_sub&reportType=pdf&branch="+document.getElementById('Branch').value+"&dcno="+DCno+"')\"><font class='boldEleven'>PDF</font></a>";
		str=str+"&nbsp;&nbsp;/&nbsp;&nbsp;<a href=\"javascript:Printquery('../SmartLoginAuth?actionS=INVRept_JDeliveryChallan&filename=Rept_JDeliveryChallan&rptfilename=Rept_JDeliveryChallan&subrptfilename1=Rept_JDeliveryChallan_sub&reportType=rtf&branch="+document.getElementById('Branch').value+"&dcno="+DCno+"')\"><font class='boldEleven'>Word</font></a> ";
		str=str+"</td>";
		
	/*	
		if(Status =="Y")
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>Transction Closed</font></td>";
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>TransctionPending</font></td>";
		*/
		if(Status =="Y" )
		{
			if(Return =="N" )
				str=str+"<td  class='boldEleven'  align='center'>Pending</td>";
			else if(Return =="P" )
				str=str+"<td  class='boldEleven'  align='center'>Partially closed</td>";
			else
				str=str+"<td  class='boldEleven'  align='center'>DC Returned</td>";
			
		}
		else
			str=str+"<td  class='boldEleven'  align='center'>&nbsp;</td>";
		
		
		if(Status =="Y" )
		{	
			if(Return =="N" )
				str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DeliveryChallanReturn('"+DCno +"')\"> <font class='bolddeepred'>Full close</font></a>&nbsp;/&nbsp;<a href=\"DeliverychallanPartiallyClosed.jsp?dcno="+DCno +"\"> <font class='bolddeepred'>Partially close</font></a> </td>";
			else  if(Return =="P" )
				str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DeliveryChallanReturn('"+DCno +"')\"> <font class='bolddeepred'>Full close</font></a>&nbsp;/&nbsp;<a href=\"DeliverychallanPartiallyClosed.jsp?dcno="+DCno +"\"> <font class='bolddeepred'>Partially close</font></a> </td>";
			else	
				str=str+"<td  class='boldEleven'  align='center'><font class='boldgreen'>DC Returned</font></td>";
		}
		else
			str=str+"<td  class='boldEleven'  align='center'>&nbsp;</td>";
		
		str=str+"</tr>";
    }
		 
     str=str+"</table>";
     var tb=document.getElementById('DC');
  	 tb.innerHTML=str  ; 
  	 
  	 tb = document.getElementById('totRec');
	 tb.innerHTML = "<font  class='bolddeepred'>Total no of Records : "+ batchs.childNodes.length + "</font>";
}


function   DeliveryChallanReturn(DCno)
{
	var f ="../SmartLoginAuth?filename=DeliveryChallan&actionS=INVDeliveryChallanClosed&dcno="+DCno  ;
	var rs=confirm("Are you sure DC materials are billed / returned ");
	if (rs==true)
	{
		var reason=prompt("Description for the DC Closed :: ","For e.g - the materials are billed "); 
		location = f+"&reason="+reason;
	}
	
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
		var title = prompt("Enter The Title ","DELIVERY CHALLAN  "); 
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="DeliveryChallanPrint.jsp?dcno="+salno +"&title="+title;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
}