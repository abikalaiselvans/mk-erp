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
	if(id == "Select")
		alert("Kindly select the customer")
	else
	{
		var url = "../marketing?actionS=CustomerAddress&id="+id;
		initRequest(url);
		req.onreadystatechange = AddressRequest;
		req.open("GET", url, true);
		req.send(null);
	}
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
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var A = batch.getElementsByTagName("A")[0];
    	str=str+A.childNodes[0].nodeValue;
	 }
	document.getElementById(assignvalue).value=str; 
}
  