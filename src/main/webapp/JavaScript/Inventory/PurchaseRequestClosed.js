
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
  	 tb.innerHTML=str     
  	 
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

function  loadPurchaseRequestClosed(startLetter) 
{
	var Branch=document.getElementById('Branch').value;
	var division=document.getElementById('divis').value;
	var customer=document.getElementById('customer').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var status=document.getElementById('status').value;
	var day=document.getElementById('day').value;
	var url = "../inventory?actionS=loadPurchaseRequestClosed&Branch="+escape(Branch)+"&id="+escape(startLetter)+"&division="+division+"&month="+month+"&customer="+customer+"&year="+year+"&status="+status+"&day="+day;
	 
	initRequest(url);
   	req.onreadystatechange =loadPurchaseRequestClosedRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function loadPurchaseRequestClosedRequest() 
{	
	if(req.readyState == 4) 
    {    	
       ClearTable('PurchaseRequest');
       ClearTabler('totRec');  
       if (req.status == 200)
        {
        	 
        	loadPurchaseRequestClosedMessages();
        }
    }
}


function loadPurchaseRequestClosedMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	var sumtotal=0;
	str=str+"<table width='100%' class='table table-bordered' id='myTable'    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	
	str=str+"<tr class='MRow1'> ";
	str=str+"<td class='boldEleven' align='center'><b>S.No</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Request No</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Branch</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Division</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Date</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Customer</b></td> ";
	//str=str+"<td class='boldEleven'><b>PurchaseAmount</b></td> ";
	//str=str+"<td class='boldEleven'><b>Vendor Commitment</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Pdate</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Cdate</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Status</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Received</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Age</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Buy  Back</b></td> ";
	str=str+"<td class='boldEleven' align='center'><b>Mode</b></td> ";
	str=str+"<td class='boldEleven'><b>Waiting For</b></td> ";
	str=str+"<td class='boldEleven'><b>Progress</b></td> ";
	str=str+"</tr> ";


	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var  batch = batchs.childNodes[loop] ;
        var  RowID = batch.getElementsByTagName("RowID")[0].childNodes[0].nodeValue;
        var  Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var  Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var  Requestno = batch.getElementsByTagName("Requestno")[0].childNodes[0].nodeValue;
		var  Date= batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
		var  Customer= batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
		var  Vendorpayment= batch.getElementsByTagName("Vendorpayment")[0].childNodes[0].nodeValue;
		var  Pdate= batch.getElementsByTagName("Pdate")[0].childNodes[0].nodeValue;
		var  Cdate= batch.getElementsByTagName("Cdate")[0].childNodes[0].nodeValue;
		var  Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
		var  PurchaseAmount= batch.getElementsByTagName("PurchaseAmount")[0].childNodes[0].nodeValue;
		var  Received= batch.getElementsByTagName("Received")[0].childNodes[0].nodeValue;
		var  Age= batch.getElementsByTagName("Age")[0].childNodes[0].nodeValue;
		var  Byback= batch.getElementsByTagName("Byback")[0].childNodes[0].nodeValue;
		var  InvoiceNumber= batch.getElementsByTagName("InvoiceNumber")[0].childNodes[0].nodeValue;
		var  Mode= batch.getElementsByTagName("Mode")[0].childNodes[0].nodeValue;
		var  CPONumber= batch.getElementsByTagName("CPONumber")[0].childNodes[0].nodeValue;
		var  Admin= batch.getElementsByTagName("Admin")[0].childNodes[0].nodeValue;
		var  Bh= batch.getElementsByTagName("Bh")[0].childNodes[0].nodeValue;
		var  Stock= batch.getElementsByTagName("Stock")[0].childNodes[0].nodeValue;
		var  Finance= batch.getElementsByTagName("Finance")[0].childNodes[0].nodeValue;
		var  Bar= batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
		 
		 
		{	
			if(loop%2==0)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
		}	
		if(Status == "N" )
			str=str+"<td  class='boldEleven'><input id='Requestno' name='Requestno' type='checkbox' value='"+Requestno+"' />"+(loop+1)+"</td>";
		else
			str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";	
		str=str+"<td  class='boldEleven'> "+Requestno+"</td>";
		str=str+"<td  class='boldEleven'> "+Branch+"</td>";
		str=str+"<td  class='boldEleven'> "+Division+"</td>";
		str=str+"<td  class='boldEleven'> "+Date+"</td>";
		str=str+"<td  class='boldEleven'> "+Customer+"</td>";
		//str=str+"<td  class='boldEleven' align='right'> "+PurchaseAmount+"</td>";
		//str=str+"<td  class='boldEleven'> "+Vendorpayment+"</td>";
		str=str+"<td  class='boldEleven'> "+Pdate+"</td>";
		str=str+"<td  class='boldEleven'> "+Cdate+"</td>";
		 
		if("Y" == Status)
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Closed&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;<a href=\"javascript:PRReset('"+Requestno+"')\"  ><font class='bolddeepred'>Reset</font></a>  / <a href=\"javascript:Printquery('PurchaseRequestPrint.jsp?Requestno="+Requestno+"')\" ><font class='boldgreen'>Print</font></a></td>";
		else
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		
		
		if("N" == Received)
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		else if("Y" == Received) 
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Received /<a href=\"javascript:RReset('"+Requestno+"')\"  ><font class='bolddeepred'>Open Mode</font></a> </font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Partially Received</font></td>";
 
		if(Age =="Y")
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Expired</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='boldgreen'>&nbsp;</font>  </td>";
		
		if(Byback =="Y")
			str=str+"<td  class='boldEleven'><a target='_blank' href='SwapSaleSerialView.jsp?salno="+InvoiceNumber+"'><font class='boldgreen'>"+InvoiceNumber+"</font></a></td>";
		else
			str=str+"<td  class='boldEleven'> &nbsp; </td>";

		if(Mode =="S")
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Mythra STOCK </font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='boldgreen'>CPO STOCK </font>/  <a target='_blank' href='POVerificationViewin_PR_side.jsp?cporefnumber="+CPONumber+"'><font class='bolddeepred'>"+CPONumber+"</font></a></td>";
		 
		
		if(Bh == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/B_H_Appr.png' >&nbsp;</td>";
		else if(Admin == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/Admin_Appr.png' >&nbsp;</td>";
		else if(Stock == "N")
    		str=str+"<td class='boldEleven'><img src='../images/inventory/StockAppr.png' >&nbsp;</td>";
		else if(Finance == "N")
    		str=str+"<td class='boldEleven'><a href='PurchaseRequestClosedAdd.jsp?Requestno="+Requestno+"'><img src='../images/inventory/finance_appr.png' ></a>&nbsp;</td>";
		else	
			str=str+"<td class='boldEleven'>&nbsp;</td>";
		
		str=str+"<td class='boldEleven'> ";
	    str=str+"<div class='progress'> ";
	    str=str+"<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+Bar+"' aria-valuemin='0' aria-valuemax='100' style='width:100'> ";
	    str=str+Bar+" %"; 
	    str=str+"</div> ";
	    str=str+"</div> ";
	    
	    str=str+"</tr>";
		
		
     }
     str=str+"</table>";

     var tb=document.getElementById('PurchaseRequest');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 

} 



function PRReset(Requestno)
{
	var r=confirm("ARE YOU SURE YOU WANT TO RESET PURCHASE REQUEST :"+Requestno);
		if (r==true)
	  		location="../SmartLoginAuth?filename=PurchaseRequest&actionS=INVPurchaseRequestClosedReset&reqno="+Requestno
}
 


function RReset(Requestno)
{
	var r=confirm("ARE YOU SURE YOU WANT TO RESET PURCHASE REQUEST :"+Requestno);
		if (r==true)
	  		location="../SmartLoginAuth?filename=PurchaseRequest&actionS=INVPurchaseRequestReceivedReset&reqno="+Requestno
}
 