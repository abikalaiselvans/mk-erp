

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


function loadStockAdjustment(startLetter) 
{ 
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var dcstatus=document.getElementById('status').value;
	var url = "../inventory?actionS=loadStockAdjustment&type=1&id="+escape(startLetter)+"&month="+month+"&year="+year+"&dcstatus="+dcstatus+"&day="+day;
	var tb=document.getElementById('stockAdjustment');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = loadStockAdjustmentRequest;
   	req.open("GET", url, true);
    req.send(null);
}
 
function loadStockAdjustments(ctr) 
{ 
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var dcstatus=document.getElementById('status').value;
	var url = "../inventory?actionS=loadStockAdjustment&type=2&id="+escape(startLetter)+"&month="+month+"&year="+year+"&dcstatus="+dcstatus+"&day="+day;
	var tb=document.getElementById('stockAdjustment');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = loadStockAdjustmentRequest;
   	req.open("GET", url, true);
    req.send(null);
}


function loadStockAdjustmentRequest() 
{	
	if(req.readyState == 4) 
    {    	
		ClearTable('stockAdjustment');
		ClearTabler('totRec');
       if (req.status == 200)
       {
    	   loadStockAdjustmentMessages();
       }
    }
}



function loadStockAdjustmentMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	str = str + "<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	str = str + "<tr class='MRow1'>";
	str=str+"<td  class='boldEleven' align='center'><b>S.No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Ref. No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Date</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Branch</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Ref</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b></b></td>";
	str=str+"<td  class='boldEleven' align='center'><b></b></td>";
	str=str+"<td  class='boldEleven' align='center'><b></b></td>";
	str=str+"<td  class='boldEleven' align='center'><b></b></td>";
	str = str + "</tr>";
	var dt="";
	var ch="";
	var sum=0.0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Refno = batch.getElementsByTagName("Refno")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
		var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Return= batch.getElementsByTagName("Return")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str = str + "<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		if("Y"!=Status)
			str=str+"<td  class='boldEleven'><input name='salesid' type='checkbox' value='"+Refno +"' />"+(loop+1)	+"</td>";
		else
			str=str+"<td  class='boldEleven'>"+(loop+1)	+"</td>";
		
		str=str+"<td  class='boldEleven'>"+Refno +"</td>";
		str=str+"<td  class='boldEleven'>"+Date +"</td>";
		str=str+"<td  class='boldEleven'>"+Branch +"</td>";
		str=str+"<td  class='boldEleven' >"+Ref +"</td>";
		str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DirectDeliveryChallanPrint('"+Refno +"')\"><font class='boldEleven'>Print</font></a> ";
		str=str+"</td>";
		
		
		if(Status =="Y")
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>Closed</font></td>";
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>Pending</font></td>";
		
		if(Status =="Y" )
		{
			if(Return =="N" )
				str=str+"<td  class='boldEleven'  align='center'>Not close</td>";
			else if(Return =="P" )
				str=str+"<td  class='boldEleven'  align='center'>Partially closed</td>";
			else
				str=str+"<td  class='boldEleven'  align='center'> Returned</td>";
			
		}
		else
			str=str+"<td  class='boldEleven'  align='center'>&nbsp;</td>";
		
		
		if(Status =="Y" )
		{	
			if(Return =="N" )
				str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DeliveryChallanReturn('"+Refno +"')\"> <font class='bolddeepred'>Full close</font></a>&nbsp;/&nbsp;<a href=\"StockAdjustmentPartiallyClosed.jsp?dcno="+Refno +"\"> <font class='bolddeepred'>Partially close</font></a> </td>";
			else  if(Return =="P" )
				str=str+"<td  class='boldEleven' align='center'><a href=\"javascript:DeliveryChallanReturn('"+Refno +"')\"> <font class='bolddeepred'>Full close</font></a>&nbsp;/&nbsp;<a href=\"StockAdjustmentPartiallyClosed.jsp?dcno="+Refno +"\"> <font class='bolddeepred'>Partially close</font></a> </td>";
			else	
				str=str+"<td  class='boldEleven'  align='center'><font class='boldgreen'>Stock Adjustment Returned</font></td>";
		}
		else
			str=str+"<td  class='boldEleven'  align='center'>&nbsp;</td>";
		
		str=str+"</tr>";
    }
		 
     str=str+"</table>";
     var tb=document.getElementById('stockAdjustment');
  	 tb.innerHTML=str  ; 
  	 
  	 tb = document.getElementById('totRec');
	 tb.innerHTML = "<font  class='bolddeepred'>Total no of Records : "+ batchs.childNodes.length + "</font>";
}


function   DeliveryChallanReturn(Refno)
{
	var f ="../SmartLoginAuth?filename=StockAdjustment&actionS=INVStockAdjustmentClosed&dcno="+Refno  ;
	var rs=confirm("Are you sure Stock Adjustment materials are billed / returned ");
	if (rs==true)
	{
		var reason=prompt("Description for the Stock Adjustment Closed :: ","For e.g - the materials are Adjusted "); 
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
		
		var width="800", height="400";
		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="StockAdjustmentPrint.jsp?dcno="+salno ;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
}