

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

function loadServiceBillingPO(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var url = "../inventory?actionS=INVServiceBillingPO&type=1&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&day="+day;
    initRequest(url);
   	req.onreadystatechange = ServiceBillingRequest;
   	req.open("GET", url, true);
    req.send(null);
}




function loadServiceBillingPOs(ctr) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var day=document.getElementById('day').value;
	var url = "../inventory?actionS=INVServiceBillingPO&type=2&Branch="+escape(Branch)+"&id="+escape(ctr.value)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&day="+day;
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
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 
	var sumtotal=0;
	str=str+"<table width='100%'  class='table table-bordered'id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow3'>";
	str=str+"<td  class='boldEleven' align='center'><b>S.No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Invoice No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Date</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Division</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Customer </b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Reference</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Amount</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Billed</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Balance</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Cancel</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Status</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>&nbsp;</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Upload/Download</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Bills </b></td>";
	str=str+"</tr>";
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Rowid= batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Invoiceno = batch.getElementsByTagName("Invoiceno")[0].childNodes[0].nodeValue;
        var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
        var Ref = batch.getElementsByTagName("Ref")[0].childNodes[0].nodeValue;
		var Amount= batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
		var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var Cancel= batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
		var Division= batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
		var Usertype= batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
		var Billed= batch.getElementsByTagName("Billed")[0].childNodes[0].nodeValue;
		var Balance= batch.getElementsByTagName("Balance")[0].childNodes[0].nodeValue;
		var Download= batch.getElementsByTagName("Download")[0].childNodes[0].nodeValue;
		
		var b = parseFloat(Balance);
		if("Y" == Cancel)
			str=str+"<tr class='MRow0'>";
		else
		{
				if(loop%2==0)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";	
		}
		
		if("Y" == Cancel || Status != "N")
			str=str+"<td  class='boldEleven'>"+(loop+1)+".</td>";
		else
			str=str+"<td  class='boldEleven'>"+(loop+1)+".<input name='salesid' type='checkbox' value='"+Rowid+"' /></td>";
		
		str=str+"<td  class='boldEleven'>"+Invoiceno+"</td>";
		str=str+"<td  class='boldEleven'>"+Date+"</td>";
		str=str+"<td  class='boldEleven'>"+Division+"</td>";
		str=str+"<td  class='boldEleven'>"+Customer+"</td>";
		str=str+"<td  class='boldEleven' >"+Ref+"</td>";
		str=str +"<td  class='boldEleven' align='right'>"+Amount+"</td>";
		str=str +"<td  class='boldEleven' align='right'>"+Billed+"</td>";
		str=str +"<td  class='boldEleven' align='right'>"+Balance+"</td>";
		str=str+"<td  class='boldEleven' align='center'>";
		
		if( (Usertype == "F") &&  ("N" == Cancel) && Status =="N"  &&  b >=1)
			str = str +" <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=ServiceBillingPO&actionS=INVServiceBillingCancel&salesid="+Invoiceno+"')\"><font class='boldgreen'>Cancel</font></a>";
		var strStat="";
		 
		if(Status=="N")
			 strStat="<font class='boldred'>Pending</font>"
		 else if(Status=="P")
			 strStat="<font class='boldgreen'>Partially </font>"
		 else if(Status=="Y")
			 strStat="<font class='boldgreen'>Completed</font>"
		str = str +"<td  class='boldEleven' align='right'>"+strStat+"</td>";
		
		if("Y" == Cancel)
			str = str +"<td  class='boldEleven'><img src='../Image/report/cancel.gif' title='Cancelled Invoice'></td>";
		else
			str = str +"<td  class='boldEleven'>&nbsp;</td>";
		
		
		//Upload/Download
		str=str+"<td class='boldEleven'>";
		str=str+"<a href=\"javascript:Upload('"+Invoiceno +"')\"><font class=boldgreen>Upload </font></a>";
		var p = Invoiceno ;
		p = replaceAll("/","_",p);
		if(Download =="Y")
			str=str+" / <a target='_blank' href='../uploadfiles/SERVICEPO/"+p+".pdf' download='"+Invoiceno +".pdf' ><font class='boldgreen'>download</font></a>";
		str = str +"</td>";
		
		
		//Invoice Raise
		if("N" == Cancel && Status !="Y" &&  b >=1)
			str=str+"<td  class='boldEleven' align='center'><a href='ServiceBillingAddfromPO.jsp?mode=P&ponumber="+Invoiceno+"&balance="+b+"'><span class='badge'>Invoice Raise</span></a></td>";
		else
			str = str +"<td  class='boldEleven'>&nbsp;</td>";
		str = str +"</tr>";
		
     }
     str=str+"</table>";

     var tb=document.getElementById('ServiceBilling');
  	 tb.innerHTML=str  ; 
  	 str=" <font class='bolddeepred'><b>Total no of Records :: "  + loop+"</b></font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	
} 


function  Upload(pono)
{
	var f ="ServicePOUpload.jsp?pono="+pono;
	newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
	newWindow.focus( );
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


