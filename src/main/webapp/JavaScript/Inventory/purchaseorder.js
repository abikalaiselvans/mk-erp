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

function loadPurchase(startLetter) 
{
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var division=document.getElementById('division').value;
    var vendor=document.getElementById('vendor').value;
    var status=document.getElementById('status').value;
    var cancel=document.getElementById('cancel').value;
    var url = "../inventory?actionS=INVPurchase&type=1&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter)+"&day="+day+"&status="+status+"&cancel="+cancel;;
	url = url+"&division="+division+"&vendor="+vendor;
	//alert(url);
	initRequest(url);
	req.onreadystatechange = PurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadPurchases(ctr) 
{
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var division=document.getElementById('division').value;
    var vendor=document.getElementById('vendor').value; 
    var cancel=document.getElementById('cancel').value;
    var url = "../inventory?actionS=INVPurchase&type=2&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(ctr.value)+"&day="+day+"&cancel="+cancel;;
	url = url+"&division="+division+"&vendor="+vendor;
	initRequest(url);
	req.onreadystatechange = PurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}


function PurchaseRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('PurchaseTable');
        ClearTabler('totRec');
         
        if (req.status == 200) 
        {		  	
          PurchaseMessages();
        }
    }
}

function PurchaseMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("purchases")[0];   
   //alert(batchs);
    var str=""; 
	str=str+"<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
	str=str+"<tr class='MRow1'>";
	str=str+"<td class='boldEleven'><b>S.No</b></td>" ;
	str=str+"<td class='boldEleven'><b>Purchase.No</b></td>" ;
	str=str+"<td class='boldEleven'><b>OrderDate</b></td>" ;
	str=str+"<td class='boldEleven'><b>Vendor</b></td>" ;
	str=str+"<td class='boldEleven'><b>Division</b></td>" ;
	str=str+"<td class='boldEleven'><b>Status</b></td>" ;
	str=str+"<td class='boldEleven'><b>Payment</b></td>" ;
	str=str+"<td class='boldEleven'><b>Print</b></td>" ;
	str=str+"<td class='boldEleven'><b>Purchase Request</b></td>" ;
	str=str+"<td class='boldEleven'><b>EDD Update</b></td>" ;
	str=str+"<td class='boldEleven'><b>EDD</b></td>" ;
	str=str+"<td class='boldEleven'><b>Verified</b></td>" ;
	str=str+"</tr>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
    	//Refid,Vendor,OrderDate,onHold,Status,Payment,Received,Branch
    	var batch = batchs.childNodes[loop];
        var Refid = batch.getElementsByTagName("Refid")[0].childNodes[0].nodeValue;
        var Vendor = batch.getElementsByTagName("Vendor")[0].childNodes[0].nodeValue;
        var OrderDate = batch.getElementsByTagName("OrderDate")[0].childNodes[0].nodeValue;
        var onHold = batch.getElementsByTagName("onHold")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        var Payment = batch.getElementsByTagName("Payment")[0].childNodes[0].nodeValue;  
        var Received = batch.getElementsByTagName("Received")[0].childNodes[0].nodeValue;          
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var PR = batch.getElementsByTagName("PR")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var EDDStatus = batch.getElementsByTagName("EDDStatus")[0].childNodes[0].nodeValue;
        var EDD = batch.getElementsByTagName("EDD")[0].childNodes[0].nodeValue;
        var Verified = batch.getElementsByTagName("Verified")[0].childNodes[0].nodeValue;
        var Cancel = batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
        var Dtcheck = batch.getElementsByTagName("Dtcheck")[0].childNodes[0].nodeValue;
        var Usertype= batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
         
        if("Y" == Cancel)
        {
    		str=str+"<tr class='MRow0'>";
        }
        else
        {	
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
        } 
        
        if(EDDStatus == "N" && ("N" == Cancel))
        {	
	        if(Status  ==='0' ) 
	        	str=str+"<td class='boldEleven'>"+(loop+1)+".<input type='checkbox' name='ponumber' value='"+Refid+"'></td>" ;	
	        else
	        	str=str+"<td class='boldEleven'>"+(loop+1)+". </td>";
        }
        else 
        	str=str+"<td class='boldEleven'>"+(loop+1)+". </td>";
        
        str=str+"<td class='boldEleven'>"+Refid+"</td>" ;
        str=str+"<td class='boldEleven'>"+OrderDate+"</td>" ;	
		str=str+"<td class='boldEleven'>"+Vendor +"</td>" ;	
		str=str+"<td class='boldEleven'>"+Division+"</td>" ;	
		
		if(Status  == '0')
			str=str+"<td class='boldred' align='center'>Not Received</td>" ;	
		else
			str=str+"<td class='boldgreen' align='center'>Received</td>" ;	
			
		
		if(Payment  == 'N')
			str=str+"<td class='boldred' align='center'>Pending</td>" ;	
		else
			str=str+"<td class='boldgreen' align='center'>Paid</td>" ;
			
		if(Verified  =='Y')
			str=str+"<td class='boldgreen' align='center'><a href=javascript:Print('"+Refid +"')><font class='boldgreen'>Print</font></a> " ;
		else
			str=str+"<td class='boldgreen' align='center'>Print" ;
		
		
		if(  ("N" == Cancel) &&  ("0" == Status) )
			if (Dtcheck == "0" )
				str = str +"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=PurchaseOrder&actionS=INVPurchaseOrderCancel&purchaseno="+Refid+"')\"><font class='boldgreen'>Cancel</font></a>";
		if("Y" == Cancel)
			str = str +"&nbsp; <img src='../Image/report/cancel.gif' border='0'/>";
		str=str+"</td>";
		 	
		
		
		
		str=str+"<td class='boldEleven'><a href=javascript:openTab('PurchaseRequestPrint.jsp?Requestno="+PR+"')><font class='boldgreen'>"+PR+"</font></a></td>" ;
		str=str+"<td class='boldEleven'><a target='_blank'  href='VPO_EDDUpdate.jsp?refno="+Refid+"'><font class='boldgreen'>Update</font></a></td>" ;
		str=str+"<td class='boldEleven'>"+EDD+"</td>" ;
		
		if(Verified  =='N')
			str=str+"<td class='boldred' align='center'>Pending </td>" ;	
		else
			str=str+"<td class='boldgreen' align='center'>Verified </td>" ;	
		
			
     }
     if(batchs.childNodes.length <=0)
     {
     	str = str+"<td  class='errormessage' colspan='6' height=100><center>Data not found...</center></td>";
     	 
     }
     str=str+"</table>";
     var tb=document.getElementById('PurchaseTable');
  	 tb.innerHTML=str  ; 
  	 str="<font  class='bolddeepblue'><b>Total no of Records :: "  + loop+"</b></font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;
     
  	  
	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
    
}




function cancelInvoice(query)
{  
	
	var name=confirm("Are you Sure Confirm to Cancel")
	if (name==true)
	{
		var reason=prompt("Enter The Reason ","CANCELLED "); 
		var email=prompt("Kindly give the email id for sending informations for cancelled invoice ","test@test.com"); 
		query = query+"&reason="+reason+"&email="+email;
		location = query;
	}	
}



function  openTab(query)
{
	
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}
 
