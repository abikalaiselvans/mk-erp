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

function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
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
 

//----------------------Direct Purchase-----------------------
function loadDirectPurchase(startletter) {
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportDirect?actionS=INVDirectPurchase&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter;
   	initRequest(url);
    req.onreadystatechange = DirectPurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}
function DirectPurchaseRequest() {
    if(req.readyState == 4) {    	
        ClearTable('DirectPurchaseTable');
        if (req.status == 200) {		  	
          DirectPurchaseMessages();
        }
    }
}
function DirectPurchaseMessages() {
    var batchs = req.responseXML.getElementsByTagName("directPurchases")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("salId")[0];
        var salNo = batch.getElementsByTagName("salNo")[0];
        var salDate = batch.getElementsByTagName("salDate")[0];
        var salTotal = batch.getElementsByTagName("salTotal")[0];
        var quoCust = batch.getElementsByTagName("quoCust")[0];      
        one=salNo.childNodes[0].nodeValue;
               
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='118px' class='boldEleven'><input type='checkbox' name='itemId' id='itemId' value='"+salNo.childNodes[0].nodeValue+"'>";
		str=str+salNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		
		str=str+"<td width='106px' align=center class='boldEleven'>"+salDate.childNodes[0].nodeValue;
		str=str+"<td width='249px' align=left class='boldEleven'>"+quoCust.childNodes[0].nodeValue;
		str=str+"<td width='190px' align=right class='boldEleven'>"+salTotal.childNodes[0].nodeValue;
		var file="SalesOrderPrint(\""+salNo.childNodes[0].nodeValue+"\")";
		str=str+"<td width='101px' align=center class='boldEleven'><a href='"+"javascript:"+file+""+"'><font color='#ff0000'>Print </font></a>" ;
			
		str=str+"</td></tr>";
     }
     str=str+"</table>";
    
     if(batchs.childNodes.length<1)
     {
     }
     else
     {
     }
     var tb=document.getElementById('DirectPurchaseTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str
  	 
}		

	
function loadDirectSales(startletter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../ReportDirect?actionS=INVDirectSale&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter;
    initRequest(url);
    req.onreadystatechange = DirectSalesRequest;
    req.open("GET", url, true);
    req.send(null);
}
function DirectSalesRequest() {
    if(req.readyState == 4) {    	
        ClearTable('DirectSalesTable');
        if (req.status == 200) {		  	
          DirectSalesMessages();
        }
    }
}
function DirectSalesMessages() {
    var batchs = req.responseXML.getElementsByTagName("directSales")[0];   	    
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
		str=str+"<td width='118px' class='boldEleven'><input type='checkbox' name='itemId' id='itemId' value='"+salNo.childNodes[0].nodeValue+"'>";
		str=str+salNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='106px' align=center class='boldEleven'>"+salDate.childNodes[0].nodeValue;
		str=str+"<td width='249px' align=Left class='boldEleven'>"+quoCust.childNodes[0].nodeValue;
		str=str+"<td width='101px' align=right class='boldEleven'>"+salTotal.childNodes[0].nodeValue;						
		var file="SalesOrderPrint(\""+salNo.childNodes[0].nodeValue+"\")";
		str=str+"<td width='190px' align=center class='boldEleven'><a href='"+"javascript:"+file+""+"'><font color='#ff0000'>Print </font></a>" ;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     }
     else
     {
     }
     var tb=document.getElementById('DirectSalesTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	 
}

 
function loadBranchValues(startletter) 
{
    var id=document.getElementById('company').value; 
	var idv = document.getElementById('branchId');
	idv.length=0;
    if (!(id=="0")) 
    {
	    var url = "../../ReportDirect?actionS=INVbranchData&id="+escape(id)+"&startLetter="+escape(startletter);
	    initRequest(url);
    	req.onreadystatechange = branchValueRequest;
	    req.open("GET", url, true);
    	req.send(null);
    }else
     {
		var idv = document.getElementById('branchId');
		idv.length=0;
		idv.options[0]=new Option("All","0");
    }		
}

function branchValueRequest() 
{
    if(req.readyState == 4) {    
   	var idv = document.getElementById('branchId');
	idv.length=0;
   	  if (req.status == 200) {
          branchValueDetails();
        }
    }
}

function branchValueDetails() {

      var batchs = req.responseXML.getElementsByTagName("branches")[0];
	  var _targ=document.getElementById('branchId'); 
      for (loop = 0; loop < batchs.childNodes.length; loop++) 
      {
	  var batch = batchs.childNodes[loop];
      var branchId = batch.getElementsByTagName("id")[0];        
      var branchName=batch.getElementsByTagName("branchName")[0];          
      _targ.options[loop]=new Option(branchName.childNodes[0].nodeValue,branchId.childNodes[0].nodeValue);
 	  }       

}	   

//----------------------Demo-----------------------
function loadDemo(sval) {
	 
    var company=document.getElementById('company').value;
    var branchId=document.getElementById('branchId').value; 
    var month=document.getElementById('month').value; 
    var year=document.getElementById('year').value;           
    var url = "../../ReportDirect?actionS=INVDemo&comp="+escape(company)+"&branch="+escape(branchId)+"&txtSer="+escape(sval)+"&month="+month+"&year="+year;
	   
    initRequest(url);
    req.onreadystatechange = DemoRequest;
    req.open("GET", url, true);
    req.send(null);
}
function DemoRequest() {
    if(req.readyState == 4) {    	
        ClearTable('DemoTable');
        if (req.status == 200) {		  	
          DemoMessages();
        }
    }
}
function DemoMessages() {   
    var batchs = req.responseXML.getElementsByTagName("demos")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";  		                        
    for(loop = 0; loop < batchs.childNodes.length; loop++) {           		                           
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0];         
        var cusName = batch.getElementsByTagName("customerName")[0];       
        var customerDate= batch.getElementsByTagName("customerDate")[0];       
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='55px'><input type='checkbox' class='boldEleven' name='demoId' value='"+temId+"'>"+temId;
		str=str+"<td width='120px' align=left class='boldEleven'><a href='DemoEdit.jsp?demoId="+temId+"'><font class='boldEleven'>"+cusName.childNodes[0].nodeValue;
		str=str+"</font></a>";	
		str=str+"<td width='70px' align=left class='boldEleven'>"+customerDate.childNodes[0].nodeValue;		
		var file="SalesOrderPrint(\""+temId+"\")";
		str=str+"<td width='30px' align=center class='boldEleven'><a href='"+"javascript:"+file+""+"'><font class='boldEleven'><font color='#ff0000'>Print </font></a>" ;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('DemoTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
}
 