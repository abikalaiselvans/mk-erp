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
 


function LoadItemList(startletter) 
{	
	var itemgroup=document.getElementById('itemgroup').value;
    var url = "../Stock?actionS=LoadItemList&startletter="+escape(startletter)+"&itemgroup="+itemgroup;
   	initRequest(url);
    req.onreadystatechange = ItemListRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function ItemListRequest() {
    if(req.readyState == 4) {
        Clear('divscroll');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML= "";
        if (req.status == 200) 
        {
          ItemListMessages();
        }
    }
}
function ItemListMessages() {
    var batchs = req.responseXML.getElementsByTagName("Items")[0];   	    
	var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Itemid = batch.getElementsByTagName("Itemid")[0];
        var Itemlist = batch.getElementsByTagName("Itemlist")[0];
        var Itemgroup = batch.getElementsByTagName("Itemgroup")[0];
        var Description = batch.getElementsByTagName("Description")[0];
        var Pprice = batch.getElementsByTagName("Pprice")[0];
        var Sprice = batch.getElementsByTagName("Sprice")[0];
           
                                     
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		  
		str=str+"<td  class='boldEleven'><input  name='itemlistid'  id='itemlistid'  type='checkbox' value='"+Itemid.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+Itemlist.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Itemgroup.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Description.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Pprice.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Sprice.childNodes[0].nodeValue;
		
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 