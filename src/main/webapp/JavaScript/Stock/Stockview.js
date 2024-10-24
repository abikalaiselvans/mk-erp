var isIE;
var req;
var names;
  
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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


var divi;
function Loaditemproduct(ctr,div) 
{
	divi = div;
	var url = "../Stock?actionS=LoadItemList&itemgroup="+ctr.value+"&startletter=0" ;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
	
}

function itemproductRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{	
			var tb=document.getElementById(divi);
			tb.innerHTML=""; 
         	itemproductMessages();
        }
    }
}

function itemproductMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Items")[0];   	    
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='iteml'  id='iteml' size='1' class='formText135' onchange=LoadStock('0')>"; 
	str = str+"<option value='0'>All</option>";
   	if(batchs.childNodes.length<1)
		alert("No Item lists are available...");
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	   	var batch = batchs.childNodes[loop];
       	var Itemid = batch.getElementsByTagName("Itemid")[0];
       	var Itemlist = batch.getElementsByTagName("Itemlist")[0];
       	str = str+"<option value='"+Itemid.childNodes[0].nodeValue+"'>"+Itemlist.childNodes[0].nodeValue+"</option>";
    }
    str=str+"</select>";
	var tb=document.getElementById(divi);
	if(batchs.childNodes.length>0)
		tb.innerHTML=str; 
	else
		tb.innerHTML=""; 
 }
 
 
 function LoadStock(sta) 
{
	var branch=document.getElementById("branch").value;
	var item=document.getElementById("iteml").value;		
	var url = "../Stock?actionS=LoadStock&branch="+branch+"&item="+item+"&sta="+sta;
	initRequest(url);
	req.onreadystatechange = stockRequest;
    req.open("GET", url, true);
    req.send(null);
}

function stockRequest() 
{

    if(req.readyState == 4) 
    {  
    document.getElementById("btnEdit").disabled=true;
    document.getElementById("btnDelete").disabled=true;
    var tb=document.getElementById("divscroll");
    	tb.innerHTML="";
    	if (req.status == 200) 
    	{	 
			stockMessages();
        }
    }
}

function stockMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Stocks")[0];   	    

	var str="";
   	str=str+"<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	   	var batch = batchs.childNodes[loop];
       	var Itemid = batch.getElementsByTagName("itemname")[0];
       	var Itemlist = batch.getElementsByTagName("stockin")[0];
       	var DivisonName = batch.getElementsByTagName("stockid")[0];
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
       	str=str+"<td  class='boldEleven' width='50'><input  name='stockid'  id='stockid'  type='checkbox' value='"+DivisonName.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+Itemid.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' width='350' align='center'>"+Itemlist.childNodes[0].nodeValue;
    }
    str=str+"</table>";
	var tb=document.getElementById("divscroll");
	if(batchs.childNodes.length>0)
	{
		tb.innerHTML=str; 
	    document.getElementById("btnEdit").disabled=false;
	    document.getElementById("btnDelete").disabled=false;
		
	}
	else
		tb.innerHTML=""; 
 }