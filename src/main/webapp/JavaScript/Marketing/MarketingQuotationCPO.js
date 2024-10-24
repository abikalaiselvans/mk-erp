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

 
function loadQuotationCPO(sval) 
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;   
    var url = "../marketing?actionS=marketingQuotationCPO&startletter="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea)+"&division="+division+"&customer="+customer+"&day="+day;
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
    str=str+"<td class='boldEleven' align='center'><b>ME</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Quotation Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Moving to CPO</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Total Amount</b></td>";
    str=str+"</tr>";
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var quoNo = batch.getElementsByTagName("quotationNo")[0].childNodes[0].nodeValue;
        var ME = batch.getElementsByTagName("ME")[0].childNodes[0].nodeValue;
        var cusName = batch.getElementsByTagName("customerName")[0].childNodes[0].nodeValue;
        var QuotDate = batch.getElementsByTagName("QuotDate")[0].childNodes[0].nodeValue;
        var CPO = batch.getElementsByTagName("CPO")[0].childNodes[0].nodeValue;
        var totalAmount = batch.getElementsByTagName("totalAmount")[0].childNodes[0].nodeValue;
        var CPOQuotenumber = batch.getElementsByTagName("CPOQuotenumber")[0].childNodes[0].nodeValue;
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
 		 
		str=str+"<td class='boldEleven'>"+(loop+1) + " </td>";
		str=str+"<td class='boldEleven'>"+quoNo + " </td>";
		str=str+"<td class='boldEleven'>"+ME + " </td>";
		str=str+"<td class='boldEleven'>"+cusName + " </td>";
		str=str+"<td class='boldEleven'>"+QuotDate + " </td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:QuotationPrint('"+quoNo+"')\"><font class='boldgreen'>Print</font></a></td> ";
		
		//Move to cpo
		if("N" == CPO)
			str=str+"<td class='bolddeepred'><a href='QuotationMovetoCPO.jsp?quotationnumber="+quoNo+"'><font class='boldgreen'>Move to CPO</font></a></td>"; 						
		else
			str=str+"<td class='boldgreen'>Moved / "+CPOQuotenumber+"</td>"; 	
		str=str+"<td align=right class='boldEleven' align='right'>"+totalAmount+ " </td>";
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

 
  