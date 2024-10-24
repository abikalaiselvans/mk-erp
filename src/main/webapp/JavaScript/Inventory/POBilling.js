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


function loadPOBilling(sval) 
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var status=document.getElementById('status').value;
	var cancel=document.getElementById('cancel').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;       
    var url = "../inventory?actionS=loadPOBilling&type=1&startletter="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea)+"&division="+division+"&customer="+customer+"&day="+day+"&status="+status+"&cancel="+cancel;
    initRequest(url);
    req.onreadystatechange = loadPOBillingRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadPOBillings(ctr) 
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var status=document.getElementById('status').value;
	var cancel=document.getElementById('cancel').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;       
    var url = "../inventory?actionS=loadPOBilling&type=2&startletter=0&month="+escape(mon)+"&year="+escape(yea)+"&division="+division+"&customer="+customer+"&day="+day+"&status="+status+"&cancel="+cancel+"&txtSer="+ctr.value;
    initRequest(url);
    req.onreadystatechange = loadPOBillingRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadPOBillingRequest() 
{
    ClearTable('loadPOVerificationTable');  
    ClearTabler('totRec'); 
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {	
        	loadPOBillingMessages();
        }
    }
}



function loadPOBillingMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%' class='table table-bordered' id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    //str=str+"<td class='boldEleven' align='center'><b>Branch</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO Reference</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Quotation</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    //str=str+"<td class='boldEleven' align='center'><b>Division</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Amount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Sale Order Approval</b></td>";
    
    //str=str+"<td class='boldEleven' align='center'><b>Verified</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Billing</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Alert</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Print</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PR</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PR Status</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PR Inward</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>No Of Billing</b></td>";
    str=str+"<td class='boldEleven'><b>Progress</b></td> ";
    
    str=str+"</tr>";
    var sum =0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var CPOref = batch.getElementsByTagName("CPOref")[0].childNodes[0].nodeValue;
        var Quotation = batch.getElementsByTagName("Quotation")[0].childNodes[0].nodeValue;
        var customerName = batch.getElementsByTagName("customerName")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var Verified = batch.getElementsByTagName("Verified")[0].childNodes[0].nodeValue;
        var CPODate = batch.getElementsByTagName("CPODate")[0].childNodes[0].nodeValue;
        var PR = batch.getElementsByTagName("PR")[0].childNodes[0].nodeValue;
        var PRStatus = batch.getElementsByTagName("PRStatus")[0].childNodes[0].nodeValue;
        var Inward = batch.getElementsByTagName("Inward")[0].childNodes[0].nodeValue;
        var Amount = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
        var Billing = batch.getElementsByTagName("Billing")[0].childNodes[0].nodeValue;
        var SaleOrder = batch.getElementsByTagName("SaleOrder")[0].childNodes[0].nodeValue;
        var CPOFlag = batch.getElementsByTagName("CPOFlag")[0].childNodes[0].nodeValue;
        var NoofBilling = batch.getElementsByTagName("NoofBilling")[0].childNodes[0].nodeValue;
        var Usertype = batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
        var Cancel= batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
        var Billed= batch.getElementsByTagName("Billed")[0].childNodes[0].nodeValue;
        var  Bar= batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
        sum = sum+parseFloat(Amount);
        
         
        if("Y" == Cancel)
			str=str+"<tr  class='MRow0'>";
		else
		{
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
		}
        
		if("Y" == Billing && "Y" == SaleOrder)
			str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		else if("Y" == SaleOrder && "Y" != Billing)
		{
			if("N" == Cancel)
				str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value='"+Id+"'>"+(loop+1) + " </td>";
			else
				str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		}
		else
			str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		
		
		
		//str=str+"<td class='boldEleven'>"+Branch + " </td>";
		str=str+"<td class='boldEleven'>"+CPOref + " </td>";
		str=str+"<td class='boldEleven'>"+Quotation + " </td>";
		
		
		str=str+"<td class='boldEleven'>"+customerName + " </td>"; 
		//str=str+"<td class='boldEleven'>"+Division + " </td>"; 
		str=str+"<td class='boldEleven' align='right'>"+Amount + " </td>"; 
		
		if(SaleOrder =="Y")
			str=str+"<td class='boldEleven'><font class='boldgreen'>Approved</font></td>";
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		
		
		if(Billing =="N")
			str=str+"<td class='boldEleven' ><font class='bolddeepred'>Pending</font></td>";
		else if(Billing =="Y")
			str=str+"<td class='boldEleven' ><font class='boldgreen'>Billed</font></td>";
		else 
			str=str+"<td class='boldEleven' ><font class='boldgreen'>Partially Billed</font></td>";
		
		if("N" == Cancel)
		{
			if(CPOFlag == "P")
				str=str+"<td class='boldEleven'><img src='../images/ready_to_partial_bill.png'></td>";
			else if(CPOFlag == "B")
				 str=str+"<td class='boldEleven'><img src='../images/ready_to_bill.png'></td>";
			else  if(CPOFlag == "W") 
				 str=str+"<td class='boldEleven'><img src='../images/wait_to_bill.png'></td>";
			else
				 str=str+"<td class='boldEleven'>&nbsp;</td>";
		}
		else
			str=str+"<td class='bolddeepred'><img src=\"../Image/report/cancel.gif\" border='0'></td>";
			 
		/*
		if(Verified=="N")
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		else
			str=str+"<td class='boldEleven'><font class='boldgreen'>Verified</font></td>";			
		*/
		
		str=str+"<td class='boldEleven'><a  target='_blank' href='POVerificationView.jsp?rowid="+Id+"'><font class='boldgreen'>Print</font></p></td>";;
		str=str+"<td class='boldEleven'>"+CPODate + " </td>";
		
		if(PR =="-")
			str=str+"<td class='boldEleven'>-</td>";
		else	
			str=str+"<td class='boldEleven'><a target='_blank' href='PurchaseRequestPrint.jsp?Requestno="+PR+"'  ><font class='boldgreen'>"+PR+"</font></a></td>";
		
		if(PRStatus == "Closed")
			str=str+"<td class='boldEleven'><font class='boldgreen'>"+PRStatus + "</font> </td>";
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'>"+PRStatus + "</font> </td>"; 
		
		if(PRStatus == "Closed")
			str=str+"<td class='boldEleven'><font class='boldgreen'>"+Inward + "</font> </td>";
		else
			str=str+"<td class='boldEleven'><font class='boldgreen'>&nbsp;</font> </td>";
		
		str=str+"<td class='boldEleven' align='center'><a target='_blank' href='Rept_Invoicedetails_against_CPO.jsp?cponumber="+CPOref+"'><font class='boldgreen'>"+NoofBilling+"</font> </a></td>";
		
		str=str+"<td class='boldEleven'> ";
	    str=str+"<div class='progress'> ";
	    str=str+"<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+Bar+"' aria-valuemin='0' aria-valuemax='100' style='width:100'> ";
	    str=str+Bar+" %"; 
	    str=str+"</div> ";
	    str=str+"</div> ";
	    str=str+" </td>";
	     
	    
		str=str+" </tr>";
     }
     str=str+"<tr class='MRow1'>";
     str=str+"<td class='boldEleven' colspan='6' align='right' ><b>Total&nbsp;&nbsp;</b></td>";
     str=str+"<td class='boldEleven' align='right' ><b>"+sum+"</b></td>";
     str=str+"<td class='boldEleven' colspan='8'>&nbsp;</td>";
     str=str+" </tr>";
     
     if(batchs.childNodes.length<1)
     {
     	str= str+"<td colspan='9' height=100 class='bolddeepred'><center>Data not found...</center>";
     	 
     }
      
     str=str+"</table>";
     
     
     var tb=document.getElementById('loadPOVerificationTable');
  	 tb.innerHTML=str   
  	 str="<table><tr><td height=10 ><center class='bolddeepred'>Total no of Records :: "  + loop+"</center></table>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
}

 
  