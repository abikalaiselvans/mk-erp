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

 
function loadQuotation(sval) 
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;   
    var url = "../marketing?actionS=marketingQuotation&startletter="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea)+"&division="+division+"&customer="+customer+"&day="+day;
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
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Qutotation Number</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Division</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Quotation Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Total Amount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Print</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Attached</b></td>";
    //str=str+"<td class='boldEleven' align='center'><b>Moving to CPO</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Reviced Quote</b></td>";
    
    str=str+"</tr>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var quoNo = batch.getElementsByTagName("quotationNo")[0].childNodes[0].nodeValue;
        var cusName = batch.getElementsByTagName("customerName")[0].childNodes[0].nodeValue;
        var QuotDate = batch.getElementsByTagName("QuotDate")[0].childNodes[0].nodeValue;
        var quoStatus = batch.getElementsByTagName("quotationStatus")[0].childNodes[0].nodeValue;
        var totalAmount = batch.getElementsByTagName("totalAmount")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var Attached = batch.getElementsByTagName("Attached")[0].childNodes[0].nodeValue;
        var Moved = batch.getElementsByTagName("Moved")[0].childNodes[0].nodeValue;
        var Revised = batch.getElementsByTagName("Revised")[0].childNodes[0].nodeValue;
        
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
 		 
		if("N" == Attached && Revised =="N")
			str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value='"+quoNo+"'>"+(loop+1) + " </td>";
		else
			str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		
		str=str+"<td class='boldEleven'>"+quoNo + " </td>";
		str=str+"<td class='boldEleven'>"+cusName + " </td>";
		str=str+"<td class='boldEleven'>"+Division + " </td>";
		str=str+"<td class='boldEleven'>"+QuotDate + " </td>";;
		
		
		str=str+"<td align=right class='boldEleven' align='right'>"+totalAmount+ " </td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:QuotationPrint('"+quoNo+"')\"><font class='boldgreen'>Print</font></a> ";
		str=str+"/ <a href=\"javascript:QuotationSendMail('"+quoNo+"')\"><font class='boldgreen'>Send Mail</font></a> ";
		str=str+"/ <a href=\"javascript:Printquery('../SmartLoginAuth?filename=Rept_JQuotation&actionS=MKTRept_JQuotation&rptfilename=Quotations&reportType=pdf&quotationno="+quoNo+"')\"><font class='boldgreen'>PDF</font> </a>";
		str=str+"</td>";
		
		//Attached
	 	if("N" == Attached)
			str=str+"<td class='bolddeepred'>Pending</td>"; 						
		else
			str=str+"<td class='boldgreen'>Attached</td>"; 	
	 
		
		
		
		//Move to cpo
		/*if("N" == Moved)
			str=str+"<td class='bolddeepred'>Pending</td>"; 						
		else
			str=str+"<td class='boldgreen'>Moved</td>"; 	
	
		*/
		
		
		//Revised Quote
		if( Revised =="N")
			str=str+"<td class='boldgreen'><a href='../SmartLoginAuth?filename=MarketingQuotation&actionS=MKTQuotationRevised&quotationnumber="+quoNo+"'><font class='boldgreen'>Want to revised</font></a></td>";
		else
			str=str+"<td class='boldgreen'>Revised</td>";
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

 
  