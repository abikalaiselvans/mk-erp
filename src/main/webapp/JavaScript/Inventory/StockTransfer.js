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


function loadStockTransfer(sval) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var status=document.getElementById('status').value;
    var day=document.getElementById('day').value;
    var url = "../inventory?actionS=INVStockTransfer&type=1&id="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea)+"&status="+status+"&day="+day;
    initRequest(url);
    req.onreadystatechange = StockTransferRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadStockTransfers(ctr) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var status=document.getElementById('status').value;
    var day=document.getElementById('day').value;
    var url = "../inventory?actionS=INVStockTransfer&id="+escape(ctr.value)+"&month="+escape(mon)+"&year="+escape(yea)+"&status="+status+"&day="+day;
    initRequest(url);
    req.onreadystatechange = StockTransferRequest;
    req.open("GET", url, true);
    req.send(null);
}

function StockTransferRequest() 
{
    if(req.readyState == 4) 
    {    	
       ClearTable('stockTrans');
       ClearTabler('totRec')
       if (req.status == 200) 
       {		  	
          StockTransferMessages();
        }
    }
}


function StockTransferMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("StockTransfer")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
        var transNo = batch.getElementsByTagName("TransId")[0].childNodes[0].nodeValue;
        var transDate = batch.getElementsByTagName("TransDate")[0].childNodes[0].nodeValue;
        var transFrom = batch.getElementsByTagName("FromBranch")[0].childNodes[0].nodeValue;
        var transTo = batch.getElementsByTagName("ToBranch")[0].childNodes[0].nodeValue;
        var status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        var tstatus = batch.getElementsByTagName("TStatus")[0];
        var ReceivedLink = batch.getElementsByTagName("ReceivedLink")[0].childNodes[0].nodeValue;
        var TransferLink = batch.getElementsByTagName("TransferLink")[0].childNodes[0].nodeValue;
        var FromBranchid = batch.getElementsByTagName("FromBranchid")[0].childNodes[0].nodeValue;
        var ToBranchid = batch.getElementsByTagName("ToBranchid")[0].childNodes[0].nodeValue;
        var invbranchid = batch.getElementsByTagName("invbranchid")[0].childNodes[0].nodeValue;
        var Delivery = batch.getElementsByTagName("Delivery")[0].childNodes[0].nodeValue;
        
        var bch=invbranchid ;
        var bch2=FromBranchid ;
      	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
 		temId=Id ;
 		stat=status ;
 		tstat=tstatus ;
		var Rl=ReceivedLink;
		var Tl=TransferLink ;
		str=str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		str=str+"<td >";
		if((Rl == "true") && (stat=="0") &&   (tstat=="0"))
			str=str+"<font class='boldred'><input name='transferId' id='transferId' type='checkbox' value='"+transNo +"' />"+transNo +"</font>";
		else
			str=str+"<font class='boldgreen'> "+transNo +"</font>";	
		
		str=str+"<td class='boldEleven'>"+transDate;
		str=str+"<td class='boldEleven'>"+transFrom ;
		str=str+"<td class='boldEleven'>"+transTo ;
 	    
 	    if(stat=="1"    )
 			str=str+"<td class='boldEleven'>Received  ";
 		else
 		{
 			if(bch2===bch)
 				str=str+"<td class='boldEleven'> Not Receive / <a href=\"javascript:redirects('../SmartLoginAuth?actionS=INVStockTransCancel&filename=StockTransfer&transferno="+transNo +"','Are you sure, you want to cancel this')\"><font color='red'>Cancel</font> </a>";	
 			else
 				str=str+"<td class='boldEleven'>Not Receive / <a href=\"javascript:redirects('../SmartLoginAuth?actionS=INVStockTransCancel&filename=StockTransfer&transferno="+transNo +"','Are you sure, you want to reject this')\"><font color='red'>Reject</font> </a>";		
 		}	
 	    
 	   str=str+" /  <a   href=\"javascript:printProforma('StockTransferPrint.jsp?transNo="+transNo +"')\"><font class='boldgreen'> Print</font> </a> </td> ";
 	    
 		if(Tl == "true" )	
 		{
 			if(stat=="0")
 				str=str+"<td ><a href='StockTransReceive.jsp?itemId="+temId+"'><font  class='boldgreen'>Receive</font></a>";
 			else
 				str=str+"<td class='boldEleven'>Received / <a href='StockTransSerialPirnt.jsp?transNo="+transNo +"'><font class='boldgreen'> View</font> ";
 		}
 		else
 		 	str=str+"<td class='boldEleven'>Transfered / <a href='StockTransSerialPirnt.jsp?transNo="+transNo +"'><font class='boldgreen'> View</font>";
 		 
 		
 		if(stat=="0")
 		{	
 			if(Delivery =="N")
 				str=str+"<td class='boldEleven'><a href='StockTransferDespatchInfo.jsp?transNo="+transNo+"'><font class='bolddeepred'>Despatch Info</font><a></td>";
 			else
 				str=str+"<td class='boldEleven'><font class='boldgreen'>Despatch info updated</font></td>";
 		}	
 		else
 			str=str+"<td class='boldEleven'>&nbsp;</td>";
 		
 		str=str+"</td></tr>";
		
		
   }
     if(batchs.childNodes.length<1)
     {
     	str= str+"<td colspan='8' height=100 class='bolddeepred'><center>Data not found...</center>";
     	
     }
     
     str=str+"</table>";     
     var tb=document.getElementById('stockTrans');
  	 tb.innerHTML=str   
  	 str="<table><tr><td height=10 ><center><font class='bolddeepred'>Total no of Records :: "  + loop+"</font></center></table>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str 
  	 
}
 


function printProforma(query)
{  
	var reason=prompt("Enter The Title ","STOCK TRANSFER "); 
	query = query+"&title="+reason;
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}

