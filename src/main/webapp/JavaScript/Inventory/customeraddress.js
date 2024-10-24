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
 
var assignvalue=""
function loadAddress(fieldname,shipid)
{
	assignvalue =shipid;
	var id = document.getElementById(fieldname).value;
	var url = "../inventoryCustomer?actionS=CustomerAddress&id="+id;
   	initRequest(url);
    req.onreadystatechange = AddressRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function AddressRequest() 
{
    if(req.readyState == 4) 
    {    	
        document.getElementById(assignvalue).value="";
        if (req.status == 200) 
        {		  	
          AddressMessages();
        }
    }
}


function AddressMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Addresss")[0];   	    
	var str=""; 
	var GstStateId=""; 
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var A = batch.getElementsByTagName("A")[0];
        GstStateId=batch.getElementsByTagName("GstStateId")[0];
        GstStateId=GstStateId.childNodes[0].nodeValue;
    	str=str+A.childNodes[0].nodeValue;
	 }
	document.getElementById(assignvalue).value=str; 
	document.getElementById('gststateid').value=GstStateId; 
	
}
  