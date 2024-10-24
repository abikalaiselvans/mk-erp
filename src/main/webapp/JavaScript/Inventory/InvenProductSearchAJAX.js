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
//--------------------Clear Select ---------------------
function clearSelect() {
    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];

        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];

        if (element && element.options) {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}
function ClearTable(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    
  	 
}
//-----------------------------------------------------------------------

//----------------------Product Group Search Starts -----------------------
function loadProductSearch()
 {
    var id=document.getElementById('selProduct').value;
    var txtSer1=""+document.getElementById('txtSer').value;        
    var url = "../inventory?actionS=INVSearchProd&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = searchProductRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function searchProductRequest()
 {
    if(req.readyState == 4) {
        ClearTable('ProductSearchTable');
         if (req.status == 200) {
          searchProductMessages();
        }
    }
}
function searchProductMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Searches")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
   
    for(loop = 0; loop < batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0];
        var Name = batch.getElementsByTagName("Name")[0];        
      if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='10px' align='right' class='boldEleven'>"+(loop+1);
		str=str+"<td width='125px'  class='boldEleven'>"+Id.childNodes[0].nodeValue;
		str=str+"<td width='160px'  class='boldEleven'>"+Name.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('ProductSearchTable');
  	 tb.innerHTML=str  ; 
  	 str="<font class='bolddeepblue' >Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;  	 	 
}
//-----------------------------------------Product Search Ends-------------------

//-----------------------------------------Item Search Starts-------------------
function loadItemSearch()
 {
    var id=document.getElementById('selProduct').value;
    var txtSer1=""+document.getElementById('txtSer').value;        
    var url = "../inventory?actionS=INVSearchItem&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = searchItemRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function searchItemRequest()
 {
    if(req.readyState == 4) {
        ClearTable('ItemSearchTable');
         if (req.status == 200) {
          searchItemMessages();
        }
    }
}
function searchItemMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("ISearches")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
   
    for(loop = 0; loop < batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0];
        var Name = batch.getElementsByTagName("Name")[0];
        var PurAmt = batch.getElementsByTagName("PurAmt")[0];
        var SalAmt = batch.getElementsByTagName("SalAmt")[0];
        var Stock = batch.getElementsByTagName("Stock")[0];
        
      if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='80px' align='left' class='boldEleven'>"+(loop+1);
		str=str+"<td width='125px'  class='boldEleven'>"+Id.childNodes[0].nodeValue;
		str=str+"<td width='160px'  class='boldEleven'>"+Name.childNodes[0].nodeValue;
		str=str+"<td width='160px'  class='boldEleven'>"+PurAmt.childNodes[0].nodeValue;
		str=str+"<td width='160px'  class='boldEleven'>"+SalAmt.childNodes[0].nodeValue;
		str=str+"<td width='160px'  class='boldEleven'>"+Stock.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     
  	 var tb=document.getElementById('ItemSearchTable');
  	 tb.innerHTML=str  ; 
  	 str="<font class='bolddeepblue' >Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;
  	 	 
}

//-----------------------------------------customer Search Starts-------------------
function loadCustomerSearch()
 {
    var id=document.getElementById('selProduct').value;
    
    var txtSer1=""+document.getElementById('txtSer').value;
    var url = "../inventory?actionS=INVSearchCustomer&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = searchCustomerRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function searchCustomerRequest()
 {
    if(req.readyState == 4) {
        ClearTable('CustomerSearchTable');
         if (req.status == 200) {
          searchCustomerMessages();
        }
    }
}
function searchCustomerMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("CSearches")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
   
    for(loop = 0; loop < batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var No = batch.getElementsByTagName("No")[0];
        var Name = batch.getElementsByTagName("Name")[0];
        var City = batch.getElementsByTagName("City")[0];
        var Phone = batch.getElementsByTagName("Phone")[0];
        var Fax = batch.getElementsByTagName("Fax")[0];
        
      if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='150px' align='left' class='boldEleven'>"+(loop+1);
		str=str+"<td width='200px'  class='boldEleven'>"+No.childNodes[0].nodeValue;
		str=str+"<td width='250px'  class='boldEleven'>"+Name.childNodes[0].nodeValue;
		str=str+"<td width='160px'  class='boldEleven'>"+City.childNodes[0].nodeValue;
		str=str+"<td width='150px'  class='boldEleven'>"+Phone.childNodes[0].nodeValue;
		str=str+"<td width='150px'  class='boldEleven'>"+Fax.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     
  	 var tb=document.getElementById('CustomerSearchTable');
  	 tb.innerHTML=str  ; 
  	 str="<font class='bolddeepblue' >Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;
  	 	 
}


