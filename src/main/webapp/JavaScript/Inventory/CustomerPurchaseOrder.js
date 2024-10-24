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





function loadSalesOrder(sval) 
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	 var status=document.getElementById('status').value;
	var poattach=document.getElementById('poattach').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventoryCustomer?actionS=INVCustomerPurchaseOrder&month="+escape(mon)+"&year="+escape(yea)+"&startletter="+escape(sval)+"&division="+division+"&customer="+customer+"&day="+day+"&poattach="+poattach+"&status="+status;
    initRequest(url);
    req.onreadystatechange = salesRequest;
    req.open("GET", url, true);
    req.send(null);
}

function salesRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('QuotationTable'); 
        if (req.status == 200) 
        {		  	
          salesMessages();       	  
        }
    }
}




function salesMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'    class='table table-bordered'   id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Qutotation Number</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Division</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Quotation Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Request Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Total Amount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Status</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>P.O</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO Upload</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO Download</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Waiting for</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td class='boldEleven'><b>Progress</b></td> ";
    str=str+"</tr>";
     
   
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var quoNo = batch.getElementsByTagName("quotationNo")[0].childNodes[0].nodeValue;
        var cusName = batch.getElementsByTagName("customerName")[0].childNodes[0].nodeValue;
        var QuotDate = batch.getElementsByTagName("QuotDate")[0].childNodes[0].nodeValue;
        var reqDate = batch.getElementsByTagName("reqDate")[0].childNodes[0].nodeValue;
        var quoStatus = batch.getElementsByTagName("quotationStatus")[0].childNodes[0].nodeValue;
        var totalAmount = batch.getElementsByTagName("totalAmount")[0].childNodes[0].nodeValue;
        var Purchaseorder = batch.getElementsByTagName("Purchaseorder")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var Download = batch.getElementsByTagName("Download")[0].childNodes[0].nodeValue;
        var  Bar= batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
        var  Age= batch.getElementsByTagName("Age")[0].childNodes[0].nodeValue;
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
 		 
		/*if("N" == quoStatus)
			str=str+"<td class='boldEleven'><input type='checkbox' name='itemId' id='itemId' value='"+quoNo+"'>"+(loop+1) + " </td>";
		else
		*/	
		str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		str=str+"<td class='boldEleven'>"+quoNo + " </td>";
		
		str=str+"<td class='boldEleven'>"+cusName + " </td>";
		str=str+"<td class='boldEleven'>"+Division + " </td>";
		str=str+"<td class='boldEleven'>"+reqDate + " </td>"; 
		str=str+"<td class='boldEleven'>"+QuotDate + " </td>"; 
		str=str+"<td align=right class='boldEleven' align='right'>"+totalAmount+ " </td>";
		//str=str+"<td class='boldEleven'><a href=\"javascript:QuotationPrint('"+quoNo+"')\"><font class='boldgreen'>Print</font></a> </td>";
		if("N" == quoStatus)
		{
			str=str+"<td class='bolddeepred'>NotExecuted &nbsp;&nbsp; ";
			str=str+" /&nbsp;&nbsp;<a  href='SalesOrderAdd.jsp?action1=Edit&quotationnumber="+quoNo+"'><font  class='boldgreen'> CPO Attached </font> </a>"
			str=str+"</td>";
		}
		else
		{
			str=str+"<td class='boldgreen'>Executed</td>";
		}	
		
		 
		if(Purchaseorder =="1")
			str=str+"<td class='boldgreen'>CPO Received</td>"; 						
		else
			str=str+"<td class='bolddeepred'>Incomplete CPO</td>"; 					
		
		str=str+"<td class='boldEleven'><a href=\"javascript:CPOUpload('"+quoNo+"')\"><font class='boldgreen'>Upload</font></a></td>";
		
		 
		if(Download == "Y")
			str=str+"<td class='boldEleven'><a target='_blank' href='../uploadfiles/CPO_Order/"+replaceAll("/","_",quoNo)+".pdf'><font class='boldgreen'>download</font></a></td>";
		else
			str=str+"<td class='boldEleven'>&nbsp;</td>";
		
		if("N" == quoStatus)
			str=str+"<td class='boldEleven'><a  href='SalesOrderAdd.jsp?action1=Edit&quotationnumber="+quoNo+"'><img border='0' src='../images/inventory/CPO_ATTACH.png' ></a>&nbsp;&nbsp; </td>";
		else
			str=str+"<td class='boldEleven'>&nbsp;</td>";
				
		
		str=str+"<td class='boldEleven'><span class='badge'>&nbsp;"+Age+"-days ago&nbsp;</span></td>";
		str=str+"<td class='boldEleven'> ";
	    str=str+"<div class='progress'> ";
	    str=str+"<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+Bar+"' aria-valuemin='0' aria-valuemax='100' style='width:100'> ";
	    str=str+Bar+" %"; 
	    str=str+"</div> ";
	    str=str+"</div> ";
	    str=str+" </td>";
	       
		str=str+" </tr>";
     }
    
     if(batchs.childNodes.length<1)
     {
     	str= str+"<tr><td colspan='8' height=100 class='bolddeepred'><center>Data not found...</center></tr>";
     	 
     }
      
     str=str+"</table>";
     
     
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="<table><tr><td height=10 ><center class='bolddeepred'>Total no of Records :: "  + loop+"</center></table>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
		 
}

 