var isIE;
var req;
var names;

 
function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    }
    else  
    {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  
    }
}


  
function ClearTable(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="<font color='red'>Total no of Records :: 0</font>"    
  	 
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

function UniqueId(tablename,fieldname,value) 
{
	var search =document.getElementById(value).value;
	var url = "../inventory?actionS=INVUniqueId&tablename="+escape(tablename);
	url = url +"&fieldname="+fieldname+"&value="+search;
	//alert(url);
	initRequest(url);
	req.onreadystatechange = UniqueIdRequest;
    req.open("GET", url, true);
    req.send(null);
}
function UniqueIdRequest() 
{
    if(req.readyState == 4) 
    {  
    	//Clear('UniqueId');
		document.getElementById('Submit').disabled=true;
    	if (req.status == 200) 
    	{		  	
         	UniqueIdMessages();
        }
    }
}
function UniqueIdMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById('Submit').disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById('Submit').disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById('UniqueId');
  	 	tb.innerHTML=str  ; 
 }

//-------------------Product-------------------------------
function loadProduct() {	
    var url = "../inventory?actionS=INVProduct";
    initRequest(url);
    req.onreadystatechange =productRequest;
    req.open("GET", url, true);
    req.send(null);
}
function productRequest() {
    if (req.readyState == 4) {
        if (req.status == 200) {
         productMessages();
        }
    }
}
function productMessages() {
   	clearSelect('product');
    var batchs = req.responseXML.getElementsByTagName("states")[0];
    var _targ=document.getElementsByName('product')[0];       
    _targ.options.length=0;	
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("productName")[0];        
        var batchId = batch.getElementsByTagName("id")[0];
        _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
        }		
		_targ.options.length=loop;
		_targ.selectedIndex=0;
		_targ.onchange();    
}
//-------------------Item Select-------------------------------
function loadSelectItem() {	
  
    var id=document.getElementById('selProduct').value;
    var txtSer1="";//document.getElementById('txtSer').value;        
    var url = "../inventory?actionS=INVItem&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = itemSelectRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadSelectProItem() 
{	
	var search=document.getElementById('search').value;
	var url = "../inventory?actionS=INVItem&search="+escape(search);
	initRequest(url);
    req.onreadystatechange = itemSelectRequest;
    req.open("GET", url, true);
    req.send(null);
}
function itemSelectRequest() {
    if (req.readyState == 4) {
        if (req.status == 200) {
         itemSelectMessages();
        }
    }
}
function itemSelectMessages() {
   	clearSelect('itemId');
    var batchs = req.responseXML.getElementsByTagName("items")[0];
    var _targ=document.getElementsByName('itemId')[0];       
    _targ.options.length=0;	
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("itemName")[0];        
        var batchId = batch.getElementsByTagName("id")[0];
		 disName =firstName.childNodes[0].nodeValue+" / "+batchId.childNodes[0].nodeValue;
        _targ.options[loop]=new Option(disName,batchId.childNodes[0].nodeValue);
        }		
		_targ.options.length=loop;
		_targ.selectedIndex=0;
		//_targ.onchange();    
}

//----------------------Item List-----------------------
function loadItem(sval) {
    if(!(sval == "0"))
		document.getElementById('search').value ="";
		
    var sr=document.getElementById('search').value;        
    var url = "../inventory?actionS=INVItems&search="+escape(sr)+"&startletter="+sval;
    initRequest(url);
    req.onreadystatechange = itemRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function itemRequest() {
    if(req.readyState == 4) {
        ClearTableTrible('ItemTable');
        if (req.status == 200) {
          itemMessages();
        }
    }
}
function itemMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("items")[0];   	    
	var str=""; 
	str=str+"<table width='800' border='0' class='boldEleven'>";
	 
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
        var itemId = batch.getElementsByTagName("id")[0];
        var itemName = batch.getElementsByTagName("itemName")[0];
        var itemDes = batch.getElementsByTagName("itemDes")[0];
        var itemPurPrice = batch.getElementsByTagName("itemPurPrice")[0];
        var itemSalesPrice = batch.getElementsByTagName("itemSalesPrice")[0];
        var itemActive = batch.getElementsByTagName("itemActive")[0];  
        var itemWarranty = batch.getElementsByTagName("itemWarranty")[0];  
    	
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		
		str=str+"<td width='100' align='left' class='boldEleven' onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'> <input type='checkbox' name='itemId' value='"+itemId.childNodes[0].nodeValue +"'>&nbsp;";;
		var c="";
		if(itemActive.childNodes[0].nodeValue == "1")
			c= "class='boldgreen'";
		else
		  	c= "class='boldred'";
		str=str+itemName.childNodes[0].nodeValue
		str=str+"<td  width='250'   class='boldEleven'>"+itemDes.childNodes[0].nodeValue;
		str=str+"<td  width='150'   class='boldEleven'>"+itemWarranty.childNodes[0].nodeValue;
		str=str+"<td  width='150'   class='boldEleven'>"+itemPurPrice.childNodes[0].nodeValue;
		str=str+"<td  width='150'   class='boldEleven'>"+itemSalesPrice.childNodes[0].nodeValue;
		
		if(itemActive.childNodes[0].nodeValue == "1")
			str=str+"<td  width='150' align=center class='boldEleven'>Active";						
		else
			str=str+"<td  width='150' align=center class='boldEleven'>Inactive";						
		
     }
     str=str+"</table>";
     
     var tb=document.getElementById('ItemTable');
  	 tb.innerHTML=str   
  	 str="<font color='ff0000'>Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  
  	 
  	  
}
function ClearTableTrible(ctr1)
{
	 var str="<p class='boldEleven' align='center'><font color='ff0000'>Nothing found</font>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     ;
	 tb=document.getElementById('totRec');	 
  	 tb.innerHTML="<font color='ff0000'>Total no of Records :: 0</font>"    
  	 
}

//----------------------Demo-----------------------

//----------------------Sales Payment-----------------------
function loadSalesPayment() {
	 //alert("Asd");
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVSalesPayment&month="+escape(mon)+"&year="+escape(yea);
	//alert(url);    
    initRequest(url);
    req.onreadystatechange = salesPaymentRequest;
    req.open("GET", url, true);
    req.send(null);
}
function salesPaymentRequest() {
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
        if (req.status == 200) {		  	
          salesPaymentMessages();
        }
    }
}
function salesPaymentMessages() {   
    var batchs = req.responseXML.getElementsByTagName("payments")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";  		                        
    for(loop = 0; loop < batchs.childNodes.length; loop++) {           		                           
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0]; 
        var payDate = batch.getElementsByTagName("paymentDate")[0];
        var cusName = batch.getElementsByTagName("customerName")[0];
        var paymentMName = batch.getElementsByTagName("paymentMName")[0];
        var openDebit = batch.getElementsByTagName("openDebit")[0];
        var paidAmount = batch.getElementsByTagName("paidAmount")[0];
        var totalAmount = batch.getElementsByTagName("totalAmount")[0];             

		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
//		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);		
		temId=Id.childNodes[0].nodeValue;

		str=str+"<td width='50px'><input type='checkbox' name='itemId' value='"+temId+"'>";
		str=str+"<a href='ItemAction.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+temId;
		str=str+"</font></a>";
		str=str+"<td width='70px' align=center class='boldEleven'>"+payDate.childNodes[0].nodeValue;
		str=str+"<td width='170px' align=left class='boldEleven'>"+cusName.childNodes[0].nodeValue;

		str=str+"<td width='70px' align=center class='boldEleven'>"+paymentMName.childNodes[0].nodeValue;
		str=str+"<td width='60px' align=center class='boldEleven'>"+openDebit.childNodes[0].nodeValue;
		str=str+"<td width='70px' align=center class='boldEleven'>"+paidAmount.childNodes[0].nodeValue;						
		str=str+"<td width='100px' align=center class='boldEleven'>"+totalAmount.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	  str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('btnDelete').disabled=false
     document.getElementById('btnEdit').disabled=false  	 
}

//----------------------Goods Received-----------------------
function loadGoods() {
//	alert("Asd");
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVgoodsReceiveData&month="+escape(mon)+"&year="+escape(yea);
    initRequest(url);
    req.onreadystatechange = goodsRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadGoodsC(sval) {
	//document.getElementById('txtSer').value=sval;
    //var id=document.getElementById('selProduct').value;    
    //var txtSer1=document.getElementById('txtSer').value;
    var url = "../inventory?actionS=INVSergood&id="+escape(sval);
    initRequest(url);
    req.onreadystatechange = goodsRequest;
    req.open("GET", url, true);
    req.send(null);
}
function goodsRequest() {
    if(req.readyState == 4) {    	
        ClearTable('GoodsTable');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
        if (req.status == 200) {		  	
          goodsMessages();
        }
    }
}
function goodsMessages()
 {
    var batchs = req.responseXML.getElementsByTagName("goods")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {	
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0];
        var orderDate = batch.getElementsByTagName("orderDate")[0];
        var receiveDate = batch.getElementsByTagName("receiveDate")[0];
        var vendorName = batch.getElementsByTagName("vendorName")[0];
        var totalAmount= batch.getElementsByTagName("totalAmount")[0];  		
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
//		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);

		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='130px' align='left'><input type='checkbox' name='itemId' value='"+temId+"'>";
		str=str+"<a href='GoodsAction.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+temId;
		str=str+"</font></a>";
		str=str+"<td width='110px' align=align='left' class='boldEleven'>"+orderDate.childNodes[0].nodeValue;
		str=str+"<td width='110px' align=left class='boldEleven'>"+receiveDate.childNodes[0].nodeValue;
		str=str+"<td width='120px' align=left class='boldEleven'>"+vendorName.childNodes[0].nodeValue;
		str=str+"<td width='90px' align=center class='boldEleven'>"+totalAmount.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('GoodsTable');    
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('btnDelete').disabled=false
     document.getElementById('btnEdit').disabled=false  	 
}

//----------------------Goods Return-----------------------

function goodsReturn() 
{
	//alert("Goods Return");
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVgoodsReturnData&month="+escape(mon)+"&year="+escape(yea);
	//alert(url);    
    initRequest(url);
    req.onreadystatechange = goodsReturnRequest;
    req.open("GET", url, true);
    req.send(null);
}

function goodsReturnC(sval) {
     //alert(sval); 
	//document.getElementById('txtSer').value=sval;
    //var id=document.getElementById('selProduct').value;    
    //var txtSer1=document.getElementById('txtSer').value;
    var url = "../inventory?actionS=INVSerGoodsReturn&id="+escape(sval);
    initRequest(url);
    req.onreadystatechange = goodsReturnRequest;
    req.open("GET", url, true);
    req.send(null);
}

function goodsReturnRequest() {
    if(req.readyState == 4) {    	
        ClearTable('GoodsReturnTable');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
        if (req.status == 200) {		  	
          goodsReturnMessages();
        }
    }
}
function goodsReturnMessages() {
    var batchs = req.responseXML.getElementsByTagName("goodsReturn")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0];
        var orderDate = batch.getElementsByTagName("orderDate")[0];
        var receiveDate = batch.getElementsByTagName("receiveDate")[0];
        var vendorName = batch.getElementsByTagName("vendorName")[0];
        var totalAmount= batch.getElementsByTagName("totalAmount")[0];           
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
//		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='75px'><input type='checkbox' name='itemId' value='"+temId+"'>";
		str=str+"<a href='ItemAction.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+temId;
		str=str+"</font></a>";
		str=str+"<td width='75px' align=center class='boldEleven'>"+orderDate.childNodes[0].nodeValue;
		str=str+"<td width='110px' align=center class='boldEleven'>"+receiveDate.childNodes[0].nodeValue;
		str=str+"<td width='150px' align=center class='boldEleven'>"+vendorName.childNodes[0].nodeValue;
		str=str+"<td width='90px' align=center class='boldEleven'>"+totalAmount.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('GoodsReturnTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('btnDelete').disabled=false
     document.getElementById('btnEdit').disabled=false  	 
}

//----------------------------------Goods Return Ends----------------------------------------------

//----------------------Purchase Payment Starts-----------------------

function purchasePayment() 
{
	alert("Goods Return");
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVPurchasePaymentData&month="+escape(mon)+"&year="+escape(yea);
	//alert(url);    
    initRequest(url);
    req.onreadystatechange = purchasePaymentRequest;
    req.open("GET", url, true);
    req.send(null);
}

function goodsReturnC(sval) {
     //alert(sval); 
	//document.getElementById('txtSer').value=sval;
    //var id=document.getElementById('selProduct').value;    
    //var txtSer1=document.getElementById('txtSer').value;
    var url = "../inventory?actionS=INVSerPurchasePayment&id="+escape(sval);
    initRequest(url);
    req.onreadystatechange = goodsReturnRequest;
    req.open("GET", url, true);
    req.send(null);
}

function purchasePaymentRequest() {
    if(req.readyState == 4) {    	
        ClearTable('purchasePayment');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;  
        if (req.status == 200) {		  	
          purchasePaymentMessages();
        }
    }
}
function purchasePaymentMessages() {
    var batchs = req.responseXML.getElementsByTagName("purchasePayment")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("purchaseOrderId")[0];
        var paymentId = batch.getElementsByTagName("paymentId")[0];
        var vendorName = batch.getElementsByTagName("vendorName")[0];
        var paymentMode = batch.getElementsByTagName("paymentMode")[0];
        var paymentDate= batch.getElementsByTagName("paymentDate")[0];           
        var openDebit= batch.getElementsByTagName("openDebit")[0];           
        var paidAmt= batch.getElementsByTagName("paidAmt")[0];           
        var balAmt= batch.getElementsByTagName("balAmt")[0];           
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
//		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='75px'><input type='checkbox' name='itemId' value='"+temId+"'>";
		str=str+"<a href='ItemAction.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+temId;
		str=str+"</font></a>";
		str=str+"<td width='75px' align=center class='boldEleven'>"+paymentId.childNodes[0].nodeValue;
		str=str+"<td width='110px' align=center class='boldEleven'>"+vendorName.childNodes[0].nodeValue;
		str=str+"<td width='150px' align=center class='boldEleven'>"+paymentMode.childNodes[0].nodeValue;
		str=str+"<td width='90px' align=center class='boldEleven'>"+paymentDate.childNodes[0].nodeValue;						
		str=str+"<td width='90px' align=center class='boldEleven'>"+openDebit.childNodes[0].nodeValue;						
		str=str+"<td width='90px' align=center class='boldEleven'>"+paidAmt.childNodes[0].nodeValue;						
		str=str+"<td width='90px' align=center class='boldEleven'>"+balAmt.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('purchasePayment');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('btnDelete').disabled=false
     document.getElementById('btnEdit').disabled=false  	 
}

//----------------------------------Purchase Payment Ends----------------------------------------------

//Start - Author :: Kalaiselvan----------------------Purchase-----------------------

function loadPurchase() 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../inventory?actionS=INVPurchase&month="+escape(mon)+"&year="+escape(yea);
	initRequest(url);
    req.onreadystatechange = PurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}

function PurchaseRequest() {
    if(req.readyState == 4) {    	
        ClearTable('PurchaseTable');
        document.getElementById('Edit').disabled=true;
        document.getElementById('Delete').disabled=true;  
        if (req.status == 200) {		  	
          PurchaseMessages();
        }
    }
}
function PurchaseMessages() {
    var batchs = req.responseXML.getElementsByTagName("quotations")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    //Ref.No ,Date,Branch,Name,Order dt. ,Status,Payment
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0];
        var quoDate = batch.getElementsByTagName("quotationDate")[0];
        var cusName = batch.getElementsByTagName("customerName")[0];
        var reqDate = batch.getElementsByTagName("reqDate")[0];
        var onHold = batch.getElementsByTagName("onHold")[0];
        var quoStatus = batch.getElementsByTagName("quotationStatus")[0];
        var credit = batch.getElementsByTagName("credit")[0];                                    
        var totalAmount = batch.getElementsByTagName("totalAmount")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='50px'><input type='checkbox' name='itemId' value='"+temId+"'>";
		str=str+"<a href='ItemAction.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+temId;
		str=str+"</font></a>";
		str=str+"<td width='70px' align=center class='boldEleven'>"+quoDate.childNodes[0].nodeValue;
		str=str+"<td width='170px' align=left class='boldEleven'>"+cusName.childNodes[0].nodeValue;
		str=str+"<td width='70px' align=center class='boldEleven'>"+reqDate.childNodes[0].nodeValue;
		str=str+"<td width='60px' align=center class='boldEleven'>"+onHold.childNodes[0].nodeValue;
		str=str+"<td width='70px' align=center class='boldEleven'>"+quoStatus.childNodes[0].nodeValue;						
		str=str+"<td width='100px' align=center class='boldEleven'>"+credit.childNodes[0].nodeValue;						
		str=str+"<td width='100px' align=center class='boldEleven'>"+totalAmount.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('btnDelete').disabled=false
     document.getElementById('btnEdit').disabled=false  	 
}
//Start - Author :: Kalaiselvan--------------------------------------------------------------------------------



//----------------------Customer Info------------------------

function loadCustomerData(sval) {

    var id=document.getElementById('branchId').value;     

    var url = "../inventory?actionS=INVCustomerData&id="+escape(id)+"&startLetter="+escape(sval);
    initRequest(url);
    req.onreadystatechange = customerRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadCustomerDataC(sval) {
//    var id=document.getElementById('branchId').value;   
      
//	  alert(id);
//    if (!(id=="0")){
//	    var url = "../inventory?actionS=INVCustomerData&id="+escape(id)+"&startLetter="+escape(sval);
	    var url = "../inventory?actionS=INVCustomerData&startLetter="+escape(sval);
//		alert(url);
    	initRequest(url);
	    req.onreadystatechange = customerRequest;
    	req.open("GET", url, true);
	    req.send(null);
//	}else {
		
//		var idv = document.getElementById('branchId');
//		idv.length=0;
//		idv.options[0]=new Option("Select","0");
//	}
	
}
function customerRequest() 
{
    if(req.readyState == 4) {    
        ClearTable('CustomerTable');
        document.getElementById('Submit3').disabled=true;
        document.getElementById('action12').disabled=true;
        if (req.status == 200) {
         customerDetails();
        }
    }
}
function customerDetails() {

    var batchs = req.responseXML.getElementsByTagName("Customers")[0]; 
   	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	
	    var batch = batchs.childNodes[loop];
        var CustomerId = batch.getElementsByTagName("Id")[0];        
        var CustomerName = batch.getElementsByTagName("Name")[0];         
        var City = batch.getElementsByTagName("City")[0];         
        var Phone = batch.getElementsByTagName("Phone")[0];       
        var state = batch.getElementsByTagName("State")[0];               	 
        var Email=batch.getElementsByTagName("Email")[0]; 
        var Active=batch.getElementsByTagName("Active")[0];                             
		
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		
		str=str+"<td width='20px'><input type='checkbox' name='custid' value='"+CustomerId.childNodes[0].nodeValue+"'>";				
		str=str+"<td width='150px'  class='boldEleven'>"+"<a href='CustomerInfoEdit.jsp?&custid="+CustomerId.childNodes[0].nodeValue+"'><font color='blue'>"+CustomerName.childNodes[0].nodeValue;		
		str=str+"<td width='150px' align=left class='boldEleven'>"+City.childNodes[0].nodeValue;
		str=str+"<td width='120px' align=left class='boldEleven'>"+state.childNodes[0].nodeValue;
		str=str+"<td width='120px' align=left class='boldEleven'>"+Phone.childNodes[0].nodeValue;	
		str=str+"<td width='120px' align=left class='boldEleven'>"+Email.childNodes[0].nodeValue;		
		if("1" === Active.childNodes[0].nodeValue)
			str=str+"<td width='120px' align=left class='boldEleven'>Y";
		else
			str=str+"<td width='120px' align=left class='boldEleven'>N";
		str=str+"</td></tr>";
		
     }
     str=str+"</table>";
     var tb=document.getElementById('CustomerTable');
  	 tb.innerHTML=str   
  	 str="<font color='red'>Total no of Records :: "  + loop+"</font>";  	
  	 if(loop!=0)
  	 {
  	 document.getElementById('Submit3').disabled=false;
     document.getElementById('action12').disabled=false;
  	 }  	
  	 var tb=document.getElementById('totRec');  	 
  	 tb.innerHTML=str   
  	 //document.getElementById('Submit3').disabled=false;
     //document.getElementById('action12').disabled=false;
  	
}
//----------------------Sales Order-----------------------
function loadSalesOrder() {
	//alert("Asd");
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;
    var url = "../inventory?actionS=INVQuoData&month="+escape(mon)+"&year="+escape(yea);
	//alert(url);    
    initRequest(url);
    req.onreadystatechange = salesRequest;
    req.open("GET", url, true);
    req.send(null);
}
function salesRequest() {
    if(req.readyState == 4) {    	
        ClearTable('QuotationTable'); 
        if (req.status == 200) {		  	
          salesMessages();
        }
    }
}
function salesMessages() {
    var batchs = req.responseXML.getElementsByTagName("quotations")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0];
        var quoNo = batch.getElementsByTagName("quotationNo")[0];
        var quoDate = batch.getElementsByTagName("quotationDate")[0];
        var cusName = batch.getElementsByTagName("customerName")[0];
        var reqDate = batch.getElementsByTagName("reqDate")[0];
        var onHold = batch.getElementsByTagName("onHold")[0];
        var quoStatus = batch.getElementsByTagName("quotationStatus")[0];
        var credit = batch.getElementsByTagName("credit")[0];                                    
        var totalAmount = batch.getElementsByTagName("totalAmount")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
//		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);
		temId=Id.childNodes[0].nodeValue;
		str=str+"<td width='100px'><input type='checkbox' name='itemId' value='"+temId+"'>";
		str=str+"<a href='QuotationOrderEdit.jsp?action1=Edit&itemId="+temId+"'><font class='boldEleven'>"+quoNo.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='70px' align=center class='boldEleven'>"+quoDate.childNodes[0].nodeValue;
		str=str+"<td width='100px' align=center class='boldEleven'>"
		str=str+"<td width='70px' align=center class='boldEleven'>"
		str=str+"<td width='170px' align=left class='boldEleven'>"+cusName.childNodes[0].nodeValue;
		str=str+"<td width='70px' align=center class='boldEleven'>"+quoStatus.childNodes[0].nodeValue;						
		var st=quoStatus.childNodes[0].nodeValue;
		if(st=="false")
			str=str+"<td width='100px' align=center class='boldEleven'> <a href='SalesOrderAdd.jsp?action1=Edit&itemId="+temId+"'><font color='#0000FF'> Sales Order </font> </a>"
		else
			str=str+"<td width='100px' align=center class='boldEleven'> <a href='SalesOrderView.jsp?action1=Edit&itemId="+temId+"'><font color='#0000FF'> View </font> </a>"
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('QuotationTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str    	 
}

//Start :: Author kalaiselvan--------------Branch-------- -----------------------
function loadBranchValues(startletter) {
	
    var id=document.getElementById('company').value; 
	var idv = document.getElementById('branchId');
	idv.length=0;
    if (!(id=="0")) 
    {
	    var url = "../inventory?actionS=INVbranchData&id="+escape(id)+"&startLetter="+escape(startletter);
	    //PROCESSWEAVER.IN
	    //processweaver.in
	    
        initRequest(url);
    	req.onreadystatechange = branchValueRequest;
	    req.open("GET", url, true);
    	req.send(null);
    }
    else 
    {
	    loadAllCustomers();
		var idv = document.getElementById('branchId');
		idv.length=0;
		idv.options[0]=new Option("Select","0");
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
//	  var _targ=document.getElementsByName('branchId')[0];     
	  var _targ=document.getElementById('branchId'); 
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var branchId = batch.getElementsByTagName("id")[0];        
        var branchName=batch.getElementsByTagName("branchName")[0];          
         _targ.options[loop]=new Option(branchName.childNodes[0].nodeValue,branchId.childNodes[0].nodeValue);
 }        

/*	
	var str="<select name='branchId' id='branchId' onChange='loadCustomerDataC('')'>";
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var branchId = batch.getElementsByTagName("id")[0];        
        var branchName=batch.getElementsByTagName("branchName")[0];          
         str = str+ "<option value='branchId.childNodes[0].nodeValue'>"+branchName.childNodes[0].nodeValue+"</option>"
     }        
	str=str+"</select>"
	alert(str);
	var tb = document.getElementById('div_branch');
	tb.innerHTML=str;
*/

}

//Start - NPR--------------------------LoadCustomerPurchaseNo--------------------
var dId;
function CheckUniqueNO(sval,divId,tableName,filedName) 
{
	var quoNumber = sval.value;
	var url = "../inventory?actionS=INVCheckUnique";
	url=url+"&quoNumber="+escape(quoNumber);
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);	
	initRequest(url);	
	dId=divId;	
	req.onreadystatechange = CheckCustPONORequest;
    req.open("GET", url, true);
    req.send(null);
}
function CheckCustPONORequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
			//alert("ASDqwe");
         	CheckCustPONOMessages();
        }
    }
}
function CheckCustPONOMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table width=50 >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
        	{
	    		document.getElementById('Submit').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('Submit').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 //	alert("As RAMESH d")
	 	var tb=document.getElementById(dId);
  	 	tb.innerHTML=str  ; 
 }
 
//-------------For Product List---------------------------------
 
function loadProductItem(sval) {
    var id=document.getElementById('selProduct').value;
    var txtSer1=sval.value;
    txtSer1=txtSer1.toUpperCase();   
    var url = "../inventory?actionS=INVItem&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = itemProductRequest;
    req.open("GET", url, true);
    req.send(null);
}
function itemProductRequest() {
    if(req.readyState == 4) {
        ClearTableTrible('ItemTable');        
        if (req.status == 200) {
          itemProductMessages();
        }
    }
}
function itemProductMessages() {

	clearSelect('productList');
    var batchs = req.responseXML.getElementsByTagName("items")[0];
    var _targ=document.getElementsByName('productList')[0];       
    _targ.options.length=0;	   
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var batchId = batch.getElementsByTagName("id")[0];
        var firstName = batch.getElementsByTagName("itemName")[0];        
        
		itemId=batchId.childNodes[0].nodeValue;
     }

}
 
//End -NPR--------------------------LoadCustomerPurchaseNo---------------------

