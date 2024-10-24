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



function loadReceive(startLetter) 
{
	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;   
    var day=document.getElementById('day').value;
	var division=document.getElementById('division').value;
    var vendor=document.getElementById('vendor').value; 
    
    var url = "../inventory?actionS=INVReceive&month="+escape(mon)+"&year="+escape(yea)+"&startLetter="+escape(startLetter)+"&vendor="+vendor+"&division="+division+"&day="+day;
	initRequest(url);
	req.onreadystatechange = ReceiveRequest;
    req.open("GET", url, true);
    req.send(null);
}

function ReceiveRequest() {
    if(req.readyState == 4) {    	
        ClearTable('ReceiveTable');
        ClearTabler('totRec');
        if (req.status == 200) {		  	
         
          ReceiveMessages();
        }
    }
}

function ReceiveMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Receives")[0];   
     
	var str=""; 
	var flag ="";
	str=str+"<table bgcolor='#CCCCC0' width='100%' border='0' class='boldEleven' cellpadding='3' cellspacing='1'>";
	str=str+"<tr class='MRow1'>";
	str=str+"<td  class='boldEleven'><center><b>S.NO</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Purchase.Ref.No</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>OrderDate</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Vendor</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Division</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>OrderFrom</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>ShippingTo</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Recd.Status</b></center></td>";
	str=str+"<td  class='boldEleven'><center><b>Action</b></center></td>";
	str=str+"</tr>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Refid = batch.getElementsByTagName("Refid")[0].childNodes[0].nodeValue;
        var Receiveid = batch.getElementsByTagName("Receiveid")[0].childNodes[0].nodeValue;
        var OrderDate = batch.getElementsByTagName("OrderDate")[0].childNodes[0].nodeValue;
        var Vendor = batch.getElementsByTagName("Vendor")[0].childNodes[0].nodeValue;
        var OrderFrom = batch.getElementsByTagName("OrderFrom")[0].childNodes[0].nodeValue;
        var ShippingTo = batch.getElementsByTagName("ShippingTo")[0].childNodes[0].nodeValue;
        var onHold = batch.getElementsByTagName("onHold")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        var Payment = batch.getElementsByTagName("Payment")[0].childNodes[0].nodeValue;  
        var ReceiveDate = batch.getElementsByTagName("ReceiveDate")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue; 
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
        
        str=str+"<td width='3%' class='boldEleven'>"+(loop+1) ;
		tid = "<a href='GoodsReceivedList.jsp?ponumber="+Refid +"'><font  class='boldEleven' >"+Refid +"</font></a>";
		
		if(Status =='1')
		{
			str=str+"<td width='15%' class='boldEleven'>";
			flag = flag+"false,";
		}	
		else
		{
			str=str+"<td width='15%' class='boldEleven'><input type='checkbox' id='ponumber'  name='ponumber' value='"+Refid +"'>";
			flag = flag+"true,";
		}
		
		//str=str+tid;
		str=str+Refid;
		str=str+"<td width='15%' class='boldEleven'>"+OrderDate ;
		str=str+"<td width='15%' class='boldEleven'>"+Vendor ;
		str=str+"<td width='15%' class='boldEleven'>"+Division ;
		str=str+"<td width='15%' class='boldEleven'>"+OrderFrom ;
		str=str+"<td width='15%' class='boldEleven'>"+ShippingTo ;
		if(Status  =='1')
			str=str+"<td width='15%' class='boldEleven' align='center'><font color='Indigo'>Received</font>";
		else if(Status  =='-1')
			str=str+"<td width='15%' class='boldEleven' align='center'><font color='magenta'>Part.Received</font>";
		else		
			str=str+"<td width='15%' class='boldEleven' align='center'><font color='red'>Not Rec</font>";
		tid = "<a href='GoodsReceivedList.jsp?ponumber="+Refid +"'><font class='boldgreen' >View</font></a>";
		str=str+"<td width='15%' class='boldEleven'>"+tid;
     }
     
     var ch = flag.split(",");
     var f = "false";
     for(x=0;x<ch.length-1;x++)
     	if(ch[x] == "true")
     		f = "true";
     		
      
     if(batchs.childNodes.length < 1)
     {
     	str = str+"<tr class='MRow1'><td  class='bolddeepred' colspan='6' height=100><center>Data not found...</center></td></tr>";
     	 
     }
     str=str+"</table>";
     
      
     var tb=document.getElementById('ReceiveTable');
  	 tb.innerHTML=str  ; 
  	 str="<font class='bolddeepred' >Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;
  	  
}




















 