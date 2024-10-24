
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
 



function loadCustomer() 
{	
    var txtSer1=document.getElementById('txtSer').value; 	
    var url = "../Stock?actionS=StockCustomer&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange =customerRequest;
    req.open("GET", url, true);
    req.send(null);
    
}

function customerRequest() 
{
   	if (req.readyState == 4) 
   	{
        if (req.status == 200) 
        {       	 
         customerMessages();
        }
    }
}


function customerMessages() 
{
   var batchs = req.responseXML.getElementsByTagName("customers")[0];
   var _targ=document.getElementsByName('customerId')[0];       
   _targ.options.length=0;	
    for (loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	   	var batch = batchs.childNodes[loop];
       	var firstName = batch.getElementsByTagName("customerName")[0];        
       	var batchId = batch.getElementsByTagName("id")[0];
	 	disName =firstName.childNodes[0].nodeValue+" / "+batchId.childNodes[0].nodeValue;
  		_targ.options[loop]=new Option(disName,batchId.childNodes[0].nodeValue);
    }		
	_targ.options.length=loop;
	_targ.selectedIndex=0;
	
}







//Load Customer Address
var assignvalue=""
function loadAddress(tablename,fieldname,condition,type,shipid,aid,addedstring,added)
{
	var table =tablename;
	var field = fieldname;
	var cdn = condition;
	assignvalue = aid;
	var ty = type;
	id = document.getElementById(shipid).value;
	
    var url = "../Stock?actionS=CustomerAddress&table="+escape(table)+"&field="+escape(field)+"&id="+id+"&condition="+cdn+"&type="+ty+"&addedstring="+addedstring+"&added="+added;
    
    initRequest(url);
    req.onreadystatechange = AddressRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function AddressRequest() {
    if(req.readyState == 4) {    	
        document.getElementById(assignvalue).value="";
        if (req.status == 200) {		  	
          AddressMessages();
        }
    }
}

function AddressMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Addresss")[0];   	    
	var str=""; 
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var A = batch.getElementsByTagName("A")[0];
    	str=str+A.childNodes[0].nodeValue;
	 }
	document.getElementById(assignvalue).value=str; 
}
  


