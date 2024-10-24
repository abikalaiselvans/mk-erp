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


function LoadCustomerAddress()
{
	try
	{
	 	var customername = document.getElementById('customername').value;
	 	var url = "../marketing?actionS=LoadCustomerNameAddress&customername="+customername ;
	 	var tob=document.getElementById('divscroll');
		req.onreadystatechange=LoadCustomerAddressRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function LoadCustomerAddressRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	var _targ=document.getElementsByName('customer')[0];       
		     _targ.options.length=0;
		     _targ.options[0]=new Option('Select customer','0');  
		    
	    	if (req.status == 200) 
	        {		  	
	    		LoadCustomerAddressMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoadCustomerAddressMessages() 
{	 
 try
 {
	  
	  
		 var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
	    var _targ=document.getElementsByName('customer')[0];       
	    _targ.options.length=0;
	    _targ.options[0]=new Option('Select customer','0');  
	    var str=""; 
	    
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {	     
	        var batch = batchs.childNodes[loop];
	        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
		    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		    var Address1 = batch.getElementsByTagName("Address1")[0].childNodes[0].nodeValue;
		    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
		    var Pincode = batch.getElementsByTagName("Pincode")[0].childNodes[0].nodeValue;
		    
		    _targ.options[loop+1]=new Option(Name+"  /  "+Address1+"  /  "+City+"  /  "+Pincode,Rowid);
			
	    }
	 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}


