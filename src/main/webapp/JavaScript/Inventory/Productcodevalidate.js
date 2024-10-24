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
 
function validproductcode(sval) 
{
   try
   {
	var demandnumber=document.getElementById('demandnumber').value;  
    var url = "../inventoryCustomer?actionS=Loadvalidproductcode&productcode="+escape(sval)+"&demandno="+demandnumber;
    initRequest(url);
    req.onreadystatechange = SpareproductcheckRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function SpareproductcheckRequest() 
{
    if(req.readyState == 4) 
    {
		var _targ=document.getElementsByName('qty')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select qty','0');
		 _targ.options[1]=new Option('1','1');
		 _targ.options[2]=new Option('2','2');
		 _targ.options[3]=new Option('3','3');
		 _targ.options[4]=new Option('4','4');
		 _targ.options[5]=new Option('5','5');
		 _targ.options[6]=new Option('6','6');
		 _targ.options[7]=new Option('7','7');
		 _targ.options[8]=new Option('8','8');
		 _targ.options[9]=new Option('9','9');
		 _targ.options[10]=new Option('10','10');
		 var tb=document.getElementById('divqtyname');
  	 	tb.innerHTML="" ;
		document.getElementById('submit_btn').disabled=false;
		if (req.status == 200) 
        {
        	SpareproductcheckMessages();
        }
    }
}

function SpareproductcheckMessages() 
{
		
		var batchs = req.responseXML.getElementsByTagName("Productcode")[0];   
    	var str="<table width='50' >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var PStatus = batch.getElementsByTagName("PStatus")[0].childNodes[0].nodeValue;
        	if(PStatus == 'true')
        	{
	    		alert("alert");
				var _targ=document.getElementsByName('qty')[0];       
	     		_targ.options.length=0;
	     		_targ.options[0]=new Option('Select qty','0');
				document.getElementById('submit_btn').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred'>InValid..</font></td></tr>";
	    	}
			else if(PStatus=='0'){
				 var tb=document.getElementById('divcodename');
  	 	tb.innerHTML="" ;
			}
	    	else
	    	{
	    		document.getElementById('submit_btn').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById('divcodename');
  	 	tb.innerHTML=str  ; 
 }
 