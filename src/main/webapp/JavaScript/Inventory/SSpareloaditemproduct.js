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

/**********************************  product type   *************************/ 
function Loaditemproductdetail()
{
	try
	{
		var serialproducttype = document.getElementById('serialproducttype').value;
		var sparetype = document.getElementsByName('sparetype');
		var demandnumber = document.getElementById('demandnumber').value;
		var sparetypevalue;
		for (i = 0; i < sparetype.length; i++){
		 	 if (sparetype[i].checked){
				sparetypevalue=sparetype[i].value
			}
	   }
		var url = "../inventoryCustomer?actionS=INVloadspareitemproduct&itemproducttype="+serialproducttype+"&sparetype="+sparetypevalue+"&demandno="+demandnumber;
	 	initRequest(url);
		req.onreadystatechange=loadspareissueitemproductrequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert("error"+err);
	}
}
 
 function loadspareissueitemproductrequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    
			var tb=document.getElementById('divcodename');
  	 		tb.innerHTML="" ;
			var tb=document.getElementById('divqtyname');
  	 		tb.innerHTML="" ;
			document.getElementById('submit_btn').disabled=false;
	    	if (req.status == 200) 
	        {		  	
				LoaditemproductMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function LoaditemproductMessages() 
{	 
 	try
 		{
			 var spareitemproductId;
			 var spareitemproductname;
			 var batchs = req.responseXML.getElementsByTagName("itemspareissue")[0];
			 var _targ=document.getElementsByName('consumableproduct')[0];       
    		 _targ.options.length=0;
    		 _targ.options[0]=new Option('Select','0'); 
			 var _targ1=document.getElementsByName('qty')[0];       
    		 _targ1.options.length=0;
    		 _targ1.options[0]=new Option('Select','0'); 
   			 var str=""; 
	 			for(loop = 0; loop < batchs.childNodes.length; loop++) 
    				{
	    			var batch = batchs.childNodes[loop];
	    			spareitemproductId= batch.getElementsByTagName("SpareitemproductId")[0].childNodes[0].nodeValue;
	    			spareitemproductname= batch.getElementsByTagName("Spareitemproductname")[0].childNodes[0].nodeValue;
					_targ.options[loop+1]=new Option(spareitemproductname,spareitemproductId);
       				}
  		}
 		catch(err)
 		{
 			alert(err.description);
 		}    	
}


