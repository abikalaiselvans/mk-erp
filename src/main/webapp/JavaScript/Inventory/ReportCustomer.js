var isIE;
var req;
var names;


function getElementY(element){
	var target1Top = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} else if (element.y) {
		target1Top += element.y;
    }
	return target1Top;
}
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function ClearTable(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
function Clear(ctr1)
{
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 

function ClearTableR(ctr1)
{
	 var str="<table width='100%' align=centet><tr><td class='errormessage'>Data not found</td></tr></table>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	
  	 
}
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
	
function loadQuotation(sval) {
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;   
    var url = "../../ReportCustomer?actionS=INVSerQuo&id="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea);
    initRequest(url);
    req.onreadystatechange = quotationRequest;
    req.open("GET", url, true);
    req.send(null);
}
function quotationRequest() {
    LoadingTables('QuotationTable');
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable');
         if (req.status == 200) {	
          quotationMessages();
        }
    }
}
function quotationMessages() {
    var batchs = req.responseXML.getElementsByTagName("quotations")[0];   	    
	var str=""; 
	str=str+"<table   cellspacing='2' cellpadding='2' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0];
        var quoNo = batch.getElementsByTagName("quotationNo")[0];
        var quoDate = batch.getElementsByTagName("quotationDate")[0];
        var cusName = batch.getElementsByTagName("customerName")[0];
        var reqDate = batch.getElementsByTagName("reqDate")[0];
        var quoStatus = batch.getElementsByTagName("quotationStatus")[0];
        var credit = batch.getElementsByTagName("credit")[0];                                    
        var totalAmount = batch.getElementsByTagName("totalAmount")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
 		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='100' align='center'>";
		str=str+"<a href='QuotationOrderEdit.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+quoNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='150'  align='center' class='boldEleven'>"+cusName.childNodes[0].nodeValue;
		str=str+"<td width='100' align='center'  class='boldEleven'>"+quoDate.childNodes[0].nodeValue;
		str=str+"<td width='100'  align='center' class='boldEleven'>"+reqDate.childNodes[0].nodeValue;
		str=str+"<td width='150' align='center' class='boldEleven' >"+totalAmount.childNodes[0].nodeValue;						
		str=str+"<td width='150'>";
		if("0" == quoStatus.childNodes[0].nodeValue)
			str=str+"<td width='100'  class='boldgreen'>NotExecuted";						
		else
		str=str+"<td width='100' align='center' class='boldgreen'><a href=\"javascript:SalesOrderPrint('"+temId+"')\"><font color='#ff0000' >Print</font></a>";						
		str=str+"</td></tr>";
     }
 
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="<table><tr><td height=10 ><center class='boldgreen'>Total no of Records :: "  + loop+"</center></table>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
}


function loadSalesOrder(sval) 
{
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportCustomer?actionS=INVSalesOrder&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+escape(sval);
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
    var batchs = req.responseXML.getElementsByTagName("SalesOrders")[0];   	    
	var str=""; 
	str=str+"<table width='100%' cellspacing='2' cellpadding='2' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("quoId")[0];
        var quoNo = batch.getElementsByTagName("quoNo")[0];
        var quoDate = batch.getElementsByTagName("quoDate")[0];
        var quoStatus = batch.getElementsByTagName("quoStatus")[0];
        var cusName = batch.getElementsByTagName("quoCust")[0];
        var salNo = batch.getElementsByTagName("salNo")[0];
        var salDate = batch.getElementsByTagName("salDate")[0];     
        var salStatus = batch.getElementsByTagName("salStatus")[0];        
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
 		temId=Id.childNodes[0].nodeValue;
 		var st=quoStatus.childNodes[0].nodeValue;
 		var salesNo=salNo.childNodes[0].nodeValue;
 		var salSt=salStatus.childNodes[0].nodeValue;
 		str=str+"<td width='100' align=center>";
		if(st==0)
			str=str+"<a href='QuotationOrderEdit.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+quoNo.childNodes[0].nodeValue;
		else
			str=str+"<font class='boldEleven'>"+quoNo.childNodes[0].nodeValue+"</font>";
			
		
		str=str+"<td width='100' align=center class='boldEleven'>"+quoDate.childNodes[0].nodeValue;
		str=str+"<td width='150' align=center class='boldEleven'>"+salNo.childNodes[0].nodeValue;
		str=str+"<td width='100' align=left class='boldEleven'>"+salDate.childNodes[0].nodeValue;
		str=str+"<td width='150' align=left class='boldEleven'>"+cusName.childNodes[0].nodeValue;
		if(st=="0")
		{
			str=str+"<td width='150' align=left class='boldgreen'>Not Executed";
		}
		else
		{
			str=str+"<td width='100' align=left class='boldEleven'> <a  href=\"javascript:SalesOrderPrint('"+temId+"')\"><font color='#ff0000' >Print </font> </a>"
		}
		str=str+"</td></tr>";
		
     }
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str    	 
}

	

function loadDelivary(startletter) 
{
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportCustomer?actionS=INVDel&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+escape(startletter);
   
    initRequest(url);
    req.onreadystatechange = delivaryRequest;
    req.open("GET", url, true);
    req.send(null);
}
function delivaryRequest() 
{
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable'); 
        if (req.status == 200) {		  	
          delivaryMessages();
        }
    }
}
function delivaryMessages() 
{
   	var batchs = req.responseXML.getElementsByTagName("Deliverys")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0'cellspacing='5' cellpadding='5' class='boldEleven'>";
   	for(loop = 0; loop < batchs.childNodes.length; loop++) {   
	    var batch = batchs.childNodes[loop]; 
       
       	var Qno= batch.getElementsByTagName("Qno")[0];
		var Custpurchaseno= batch.getElementsByTagName("Custpurchaseno")[0];
		var Saleno= batch.getElementsByTagName("Saleno")[0];
		var Saleby= batch.getElementsByTagName("Saleby")[0];
	    var Saledate= batch.getElementsByTagName("Saledate")[0];
	    var Custname= batch.getElementsByTagName("Custname")[0];
		var Status= batch.getElementsByTagName("Status")[0];
		var Did= batch.getElementsByTagName("Did")[0];
		var Sno = Saleno.childNodes[0].nodeValue;
		var Dno = Did.childNodes[0].nodeValue;
		
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='95px' 	align=center class='boldEleven'>"+Qno.childNodes[0].nodeValue;
		str=str+"<td width='100px' 	align=center class='boldEleven'>"+Custpurchaseno.childNodes[0].nodeValue;
		str=str+"<td width='92px' 	align=center class='boldEleven'>"+Saleno.childNodes[0].nodeValue;
		str=str+"<td width='133px' 	align=center class='boldEleven'>"+Custname.childNodes[0].nodeValue;
		if("N" == Status.childNodes[0].nodeValue )
			str=str+"<td width='150px' align=left class='boldgreen'><font class='boldred'>Delivery</font></a>";
		
		if("Y" == Status.childNodes[0].nodeValue )
			str=str+"<td width='150px' align=center class='boldgreen'><a href=\"javascript:DCPrint('"+Sno+"','"+Dno+"')\"><font color='#ff0000' >Print</font></a>";
		
		if("P" == Status.childNodes[0].nodeValue )
			str=str+"<td width='150px' align=left class='boldgreen'><font class='boldgreen'>Partially Delivered</font></a>";
		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
}

 
	
function loadInvoice(startletter) {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportCustomer?actionS=INVInvoice&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+escape(startletter);
	initRequest(url);
    req.onreadystatechange = invoiceRequest;
    req.open("GET", url, true);
    req.send(null);
}
function invoiceRequest() {
   if(req.readyState == 4) {    	
        ClearTable('QuotationTable'); 
        if (req.status == 200) {		  	
          invoiceMessages();
        }
   }
}

function invoiceMessages() {
   var batchs = req.responseXML.getElementsByTagName("invoices")[0];   	    
   var str="";   
   str=str+"<table width='100%' border='0' class='boldEleven'>";
   var loop=0;	
   for(loop = 0; loop < batchs.childNodes.length; loop++) {
  	   var batch = batchs.childNodes[loop];
      	var Quotationid = batch.getElementsByTagName("Quotationid")[0];
      	var Invnumber = batch.getElementsByTagName("Invnumber")[0];
		var Invdate = batch.getElementsByTagName("Invdate")[0];
		var SalesOrder = batch.getElementsByTagName("SalesOrderNo")[0];
		var Customername = batch.getElementsByTagName("Customername")[0];
		var Invstatus = batch.getElementsByTagName("Invstatus")[0];
      	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		str=str+"<td  align=left class='boldEleven'>"+Quotationid.childNodes[0].nodeValue;		    
		str=str+"<td  align=left class='boldEleven'>"+Invnumber.childNodes[0].nodeValue;		
		str=str+"<td  align=left class='boldEleven'>"+Invdate.childNodes[0].nodeValue;		
		var p=SalesOrder.childNodes[0].nodeValue;
		str=str+"<td  align=left class='boldEleven'><input type='hidden' name='pur' id='pur' value='"+p+"'>"+SalesOrder.childNodes[0].nodeValue;
		str=str+"<td  align=left class='boldEleven'>"+Customername.childNodes[0].nodeValue;		
		//var p=SalesOrder.childNodes[0].nodeValue;
		var st=Invstatus.childNodes[0].nodeValue;
		
		if(st=="Y")
		str=str+"<td align=left class='boldEleven'> <a href=\"javascript:InvoicePrint('"+p+"')\"><font color='#ff0000' >Print</font></a>";
			
		else
			str=str+"<td  align=left class='boldEleven'><font  class='boldgreen' >Not Excecuted</font> </a>";
		str=str+"</td></tr>";
     }    
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str; 
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
}
 
 
 

function loadCashSale(startletter) {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportCustomer?actionS=INVCashSale&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter;
    initRequest(url);
    req.onreadystatechange = cashSaleRequest;
    req.open("GET", url, true);
    req.send(null);
}
function cashSaleRequest() {
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable');
          if (req.status == 200) {		  	
          cashSaleMessages();
        }
    }
}
function cashSaleMessages() {
    var batchs = req.responseXML.getElementsByTagName("cashSales")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("salId")[0];
        var salNo = batch.getElementsByTagName("salNo")[0];
        var salDate = batch.getElementsByTagName("salDate")[0];
        var salTotal = batch.getElementsByTagName("salTotal")[0];
        var quoCust = batch.getElementsByTagName("quoCust")[0];             
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='118px' class='boldEleven'>";
		str=str+salNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='210px' align=center class='boldEleven'>"+salDate.childNodes[0].nodeValue;
		str=str+"<td width='240px' align=left class='boldEleven'>"+quoCust.childNodes[0].nodeValue;
		//str=str+"<td width='190px' align=center class='boldEleven'><a href='CashSaleSerial.jsp?salno="+salNo.childNodes[0].nodeValue+"' ><font color='#ff0000'>View </font></a>" ;
		var file="SalesOrderPrint(\""+salNo.childNodes[0].nodeValue+"\")"
		str=str+"<td width='101px' align=right class='boldEleven'>"+salTotal.childNodes[0].nodeValue;						
		str=str+"<td width='190px' align=center class='boldEleven'><a href='"+"javascript:"+file+""+"'><font color='#ff0000'> Print </font></a>" ;
	
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     }
     else
     {
     }
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str
  	 
}
 

function SalesPayment(startLetter) 
{
	var pType=document.getElementById('payType').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportCustomer?actionS=INVLoadSalesPayment&payType="+escape(pType)+"&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
  	initRequest(url);
   	req.onreadystatechange = SalesRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SalesRequest() 
{	
	if(req.readyState == 4) 
    {    	
        ClearTableR('SalesPaymentTable');
       	if (req.status == 200)
        {
        	SalesMessages();
        }
    }
}
var salid;
function SalesMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Payments")[0];   
	
	str=str+"<table width='800' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='0' cellspacing='0'>";
	var dt="";
	var ch="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Customerid = batch.getElementsByTagName("Customerid")[0];
        var Customername = batch.getElementsByTagName("Customername")[0];
        var Totalamount = batch.getElementsByTagName("Totalamount")[0];
        var Status = batch.getElementsByTagName("Status")[0];
		var OrderDate= batch.getElementsByTagName("OrderDate")[0];
		var Paidamount= batch.getElementsByTagName("Paidamount")[0];
		var Balance= batch.getElementsByTagName("Balance")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<tr>"
		str=str+"<td width='105' class='boldEleven'>";
		 salid=Customerid.childNodes[0].nodeValue;
		var ch="";
		if(Paidamount.childNodes[0].nodeValue != "0.0")
		{
			ch="<input name='salesid' type='checkbox' value='"+Customerid.childNodes[0].nodeValue+"' />"	;
			str=str+ch+Customerid.childNodes[0].nodeValue;
		}
		else
		{
			str=str+Customerid.childNodes[0].nodeValue;
		}		
		str=str+"<td width='109' class='boldEleven'>"+OrderDate.childNodes[0].nodeValue;
		str=str+"<td width='152' class='boldEleven'>"+Customername.childNodes[0].nodeValue;
		str=str+"<td width='118' class='boldEleven'>"+Totalamount.childNodes[0].nodeValue;
		str = str +"<td width='89' class='boldEleven'>&nbsp;"+Paidamount.childNodes[0].nodeValue;
		str = str +"<td width='133' class='boldEleven'>&nbsp;"+Balance.childNodes[0].nodeValue;
		strStat="";
		stat=Status.childNodes[0].nodeValue;
		//str = str +"<td width='48' class='boldEleven'> <a href=\"javascript:SalePay('"+salid+"')\"><font color='#ff0000'> Print </font></a>" ;
		if(stat=="N")
			 strStat="<font color='blue'>Pending</font>"
		 else if(stat=="P")
			 strStat="<font class='boldgreen'>Partially Paid</font>"
		 else if(stat=="Y")
			 strStat="<font class='boldgreen'><a href=\"javascript:SalePay('"+salid+"')\"><font color='#ff0000'> Print </font></a>"
		str = str +"<td width='48' class='boldEleven'>"+strStat;
     }
     str=str+"</table>";
     var tb=document.getElementById('SalesPaymentTable');
  	 tb.innerHTML=str  ; 
}
