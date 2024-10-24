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



function callloaditem()
{
	var sr=document.getElementById('search').value; 
	loadItem(sr);
	 
} 


function callloaditems(start)
{
	loadItem(start);
} 


function loadItem(sval) 
{
   try
   {
           
    var group=document.getElementById('itemgroup').value;
    var url = "../inventory?actionS=INVItems&search="+escape(sval)+"&group="+group;
    initRequest(url);
    req.onreadystatechange = itemRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function itemRequest() 
{
    if(req.readyState == 4) 
    {
    	ClearTable('ItemTable');
    	ClearTabler('totRec');
        if (req.status == 200) 
        {
          itemMessages();
        }
    }
}

function itemMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("items")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
        var group = batch.getElementsByTagName("group")[0];
        var itemId = batch.getElementsByTagName("id")[0];
        var itemName = batch.getElementsByTagName("itemName")[0];
        var itemDes = batch.getElementsByTagName("itemDes")[0];
        var itemPurPrice = batch.getElementsByTagName("itemPurPrice")[0];
        var itemSalesPrice = batch.getElementsByTagName("itemSalesPrice")[0];
        var itemActive = batch.getElementsByTagName("itemActive")[0];  
        var itemWarranty = batch.getElementsByTagName("itemWarranty")[0];  
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    
		if(loop%2==1)
			str=str+"<tr class='MRow1' >";
		else
		    str=str+"<tr  class='MRow2'  >";	
		
		str=str+"<td width='100' align='left' class='boldEleven'  > <input type='checkbox' id='rowid' name='rowid' value='"+Rowid +"'>&nbsp;";;
		var c="";
		if(itemActive.childNodes[0].nodeValue == "1")
			c= "class='boldgreen'";
		else
		  	c= "class='boldred'";
		str=str+group.childNodes[0].nodeValue
		str=str+"<td  width='250'   class='boldEleven' align='left'   >"+itemName.childNodes[0].nodeValue+"</td>";
		str=str+"<td  width='250'   class='boldEleven' align='left'  >"+itemDes.childNodes[0].nodeValue+"</td>";
		str=str+"<td  width='150'   class='boldEleven' align='left'  >"+itemWarranty.childNodes[0].nodeValue+"</td>";
		str=str+"<td  width='150'   class='boldEleven' align='right'  >"+itemPurPrice.childNodes[0].nodeValue+"</td>";
		str=str+"<td  width='150'   class='boldEleven' align='right' >"+itemSalesPrice.childNodes[0].nodeValue+"</td>";
		
		if(itemActive.childNodes[0].nodeValue == "1")
			str=str+"<td  width='150' align=center class='boldEleven'>Active </td>";						
		else
			str=str+"<td  width='150' align=center class='boldEleven'>Inactive </td>";	
	 }		
     str=str+"</table>";
     var tb=document.getElementById('ItemTable');
  	 tb.innerHTML=str   
  	 str="<font color='ff0000'>Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  
  	  
}

 