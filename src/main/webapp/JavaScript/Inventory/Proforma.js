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


function loadProforma(sval) //INVCustomerQuotation
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var status=document.getElementById('status').value;
    var url = "../inventory?actionS=loadProforma&startletter="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea)+"&division="+division+"&customer="+customer+"&day="+day+"&status="+status;
    initRequest(url);
    req.onreadystatechange = quotationRequest;
    req.open("GET", url, true);
    req.send(null);
}

function quotationRequest() 
{
    ClearTable('QuotationTable');  
    ClearTabler('totRec'); 
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {	
          quotationMessages();
        }
    }
}



function quotationMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'   class='table table-bordered'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Proforma Number</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Division</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Proforma Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Request Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Total Amount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Print</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>&nbsp;</b></td>";
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
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var onHold = batch.getElementsByTagName("onHold")[0].childNodes[0].nodeValue;
        var Cancel = batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
        var  Bar= batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
        var  Age= batch.getElementsByTagName("Age")[0].childNodes[0].nodeValue;
        if("Y" == Cancel)
			str=str+"<tr  class='MRow0'>";
		else
		{
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
		}
        
		if("N" == quoStatus && Cancel == "N")
			str=str+"<td class='boldEleven'><input type='checkbox' name='itemId' id='itemId' value='"+quoNo+"'>"+(loop+1) + " </td>";
		else
			str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		
		str=str+"<td class='boldEleven'>"+quoNo + " </td>";
		str=str+"<td class='boldEleven'>"+cusName + " </td>";
		str=str+"<td class='boldEleven'>"+Division + " </td>";
		str=str+"<td class='boldEleven'>"+reqDate + " </td>";;
		str=str+"<td class='boldEleven'>"+QuotDate + " </td>";;
		str=str+"<td align=right class='boldEleven' align='right'>"+totalAmount+ " </td>";
		
		str=str+"<td class='boldEleven'><a href=\"javascript:proformaPrint('"+quoNo+"')\"><font class='boldgreen'>Print</font></a> / <a href=\"javascript:QuotationSendMail('"+quoNo+"')\"><font class='boldgreen'>Send Mail</font></a>";
		if("N" == quoStatus && Cancel == "N" )
			str=str+"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=Proforma&actionS=INVCProformaCancel&qnumber="+quoNo+"')\"><font class='boldgreen'>Cancel</font></a>";
		str=str+"</td>";

		 
		
		str=str+"<td class='boldEleven'><span class='badge'>&nbsp;"+Age+"-days ago&nbsp;</span></td>";
		 
	    
	    str=str+" </tr>";
     }
    
     if(batchs.childNodes.length<1)
     {
     	str= str+"<td colspan='8' height=100 class='bolddeepred'><center>Data not found...</center>";
     	 
     }
      
     str=str+"</table>";
     
     
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="<table><tr><td height=10 ><center class='bolddeepred'>Total no of Records :: "  + loop+"</center></table>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
}



function cancelInvoice(query)
{  
	
	var name=confirm("Are you Sure Confirm to Cancel")
	if (name==true)
	{
		var reason=prompt("Enter The Reason ","Cancelled"); 
		var email=prompt("Kindly give the email id for sending informations for cancelled invoice ","test@test.com"); 
		query = query+"&reason="+reason+"&email="+email;
		location = query;
		
	}	
}
  
 
  