
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
	 var str="<font class='bolddeepred'><br><br><br><center>Data not found...</center></font>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str ;   
  	 
}

function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function LoadingTable(ctr1)
{
	 var str="<br><br><br><center><img src=\"../images/load/6.gif\" width='128' height='15'></center> ";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

function loadPurchaseRequestTaken(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var day=document.getElementById('day').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var itype=document.getElementById('itype').value;
	var item=document.getElementById('item').value;
	var vendor=document.getElementById('vendor').value;
	var url = "../inventory?actionS=loadPurchaseRequestTaken&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&day="+day+"&itype="+itype+"&item="+item+"&vendor="+vendor;
 
   	initRequest(url);
   	req.onreadystatechange =loadPurchaseRequestTakenRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function loadPurchaseRequestTakenRequest() 
{	
	if(req.readyState == 4) 
    {    	
       ClearTable('PurchaseRequest');
       ClearTabler('totRec');  
       if (req.status == 200)
        {
        	 
    	   loadPurchaseRequestTakenMessages();
        }
    }
}


function loadPurchaseRequestTakenMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	var sumtotal=0;
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	
	str=str+"<tr class='MRow1'> <td class='boldEleven'><b>S.No</b></td> ";
	str=str+"<td class='boldEleven'><b>Branch</b></td> ";
	str=str+"<td class='boldEleven'><b>Division</b></td> ";
	str=str+"<td class='boldEleven'><b>Type</b></td> ";
	str=str+"<td class='boldEleven'><b>Product Code</b></td> ";
	str=str+"<td class='boldEleven'><b>Quantity</b></td> ";
	str=str+"<td class='boldEleven'><b>Requestno</b></td> ";
	str=str+"<td class='boldEleven'><b>Date</b></td> ";
	str=str+"<td class='boldEleven'><b>Vendor</b></td> ";
	str=str+"<td class='boldEleven'><b>Customer</b></td> ";
	str=str+"<td class='boldEleven'><b>Waiting For</b></td> ";
	
	str=str+"</tr> ";

	//Branch,Division,Requestno,Date,Customer,Vendor,Type,Product
	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    
	  
		
	     
	    var batch = batchs.childNodes[loop] ;
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var Requestno = batch.getElementsByTagName("Requestno")[0].childNodes[0].nodeValue;
		var Date= batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
		var Customer= batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
		var Vendor= batch.getElementsByTagName("Vendor")[0].childNodes[0].nodeValue;
		var Type= batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
		var Product= batch.getElementsByTagName("Product")[0].childNodes[0].nodeValue;
		var Quantity= batch.getElementsByTagName("Quantity")[0].childNodes[0].nodeValue;
		var  Admin= batch.getElementsByTagName("Admin")[0].childNodes[0].nodeValue;
		var  Bh= batch.getElementsByTagName("Bh")[0].childNodes[0].nodeValue;
		var  Stock= batch.getElementsByTagName("Stock")[0].childNodes[0].nodeValue;
		var  Finance= batch.getElementsByTagName("Finance")[0].childNodes[0].nodeValue;
		
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		
		str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'> "+Branch+"</td>";
		str=str+"<td  class='boldEleven'> "+Division+"</td>";
		str=str+"<td  class='boldEleven'> "+Type+"</td>";
		str=str+"<td  class='boldEleven'> "+Product +"</td>";
		str=str+"<td  class='boldEleven'> "+Quantity +"</td>";
		str=str+"<td  class='boldEleven'> "+Requestno+"</td>";
		str=str+"<td  class='boldEleven'> "+Date+"</td>";
		str=str+"<td  class='boldEleven'> "+Vendor+"</td>";
		str=str+"<td  class='boldEleven'> "+Customer+"</td>";
		if(Bh == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/B_H_Appr.png' ></td>";
		else if(Admin == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/Admin_Appr.png' ></td>";
		else if(Stock == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/StockAppr.png' ></td>";
		else if(Finance == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/finance_appr.png' ></td>";
		else	
			str=str+"<td class='boldEleven'>&nbsp;</td>";
     }
     str=str+"</table>";
     var tb=document.getElementById('PurchaseRequest');
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 

} 

 
