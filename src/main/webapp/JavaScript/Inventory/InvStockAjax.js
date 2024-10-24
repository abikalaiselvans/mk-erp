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
	 var str="<center><font class='boldred'>Nothing  found</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	      	 
}


function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 
 
function loadItem(sval) 
{
	if(!(sval == "0"))
		document.getElementById('search').value ="";
	var type=document.getElementById('type').value;
    var search=document.getElementById('search').value;  
    var Branch=document.getElementById('Branch').value; 
    var division=document.getElementById('division').value; 
    var url = "../inventory?actionS=INVStock&search="+escape(search)+"&type="+escape(type)+"&sval="+escape(sval)+"&division="+division;
    url = url +"&branch="+Branch;
    initRequest(url);
    req.onreadystatechange = itemRequest;
    req.open("GET", url, true);
    req.send(null);
}

function itemRequest() 
{
    if(req.readyState == 4) 
    {
        ClearTable('ItemTable');
        ClearTabler('totRec')
        document.getElementById('btnEdit').disabled=true;
        if (req.status == 200) 
        {
          itemMessages();
        }
    }
}


function itemMessages() 
{
	var t =document.getElementById('type').value;
    var batchs = req.responseXML.getElementsByTagName("stocks")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var itemId = batch.getElementsByTagName("id")[0];
        var itemName = batch.getElementsByTagName("itemName")[0];       
        var itemStockIn = batch.getElementsByTagName("itemStockIn")[0];
        var Branch = batch.getElementsByTagName("Branch")[0];
        var itemAveragePrice = batch.getElementsByTagName("itemAveragePrice")[0];
        var itemLastSale = batch.getElementsByTagName("itemLastSale")[0];
        var ptype = batch.getElementsByTagName("ptype")[0];
      	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		tempId=itemId.childNodes[0].nodeValue;
		str=str+"<td width='200' ><input type='checkbox' name='itemId' value='"+tempId+"'>&nbsp;";
		if(itemStockIn.childNodes[0].nodeValue =="0")
		{
			str=str+"<a href=\"javascript:Message('No Stock ')\"><font class='boldgreen'>"+itemName.childNodes[0].nodeValue+"</font></a>";
		}
		else
		{
			if(ptype.childNodes[0].nodeValue =="S")
			{
				str=str+"<a href=\"javascript:Message('Consumable Product Total Quantity is "+itemStockIn.childNodes[0].nodeValue+"')\"><font class='boldgreen'>"+itemName.childNodes[0].nodeValue+"</font></a>";
			
			}
			else
			{
				str=str+"<a href='StockEdit.jsp?branch="+Branch.childNodes[0].nodeValue+"&type="+t+"&action1=Edit&itemId="+tempId+"'><font class='boldgreen'>"+itemName.childNodes[0].nodeValue;
				str=str+"</font></a>";
			}	
		
		}


		str=str+"<td  width='200' class='boldEleven'>"+itemAveragePrice.childNodes[0].nodeValue;
		str=str+"<td  width='200' class='boldEleven'>"+itemLastSale.childNodes[0].nodeValue;
		str=str+"<td  width='200' class='boldEleven' align='right'>"+itemStockIn.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('ItemTable');
  	 tb.innerHTML=str   
  	 str="<center><font class='bolddeepred'>Total no of Records :: "  + loop +"</font></center>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
     document.getElementById('btnEdit').disabled=false  	 
}


 










 
function loadallStock(sval) 
{
	if(!(sval == "0"))
		document.getElementById('search').value ="";
	var search=document.getElementById('search').value;        
    var url = "../inventory?actionS=INVStockAll&search="+escape(search)+"&sval="+escape(sval);
    initRequest(url);
    req.onreadystatechange = itemStock;
    req.open("GET", url, true);
    req.send(null);
}
function itemStock() {
    if(req.readyState == 4) {
        ClearTable('ItemTable');
        ClearTabler('totRec')
        if (req.status == 200) {
          StockMessages();
        }
    }
}
function StockMessages() {
	var t =document.getElementById('type').value;
    var batchs = req.responseXML.getElementsByTagName("stocks")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var itemId = batch.getElementsByTagName("id")[0];
        var itemName = batch.getElementsByTagName("itemName")[0];       
        var itemStockIn = batch.getElementsByTagName("itemStockIn")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		tempId=itemId.childNodes[0].nodeValue;
		str=str+"<td width='200' ><input type='checkbox' name='itemId' value='"+tempId+"'>&nbsp;";
		str=str+"<a href='StockEdit.jsp?type="+t+"&action1=Edit&itemId="+tempId+"'><font class='boldgreen'>"+tempId;
		str=str+"</font></a>";
		str=str+"<td  width='200' class='boldEleven'>"+itemName.childNodes[0].nodeValue;
		str=str+"<td  width='200' class='boldEleven' align='right'>"+itemStockIn.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('ItemTable');
  	 tb.innerHTML=str   
  	 str="<center><font class='boldred'>Total no of Records :: "  + loop +"</font></center>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
}












//-----------------------------  Stock Transfer  ---------------------------
