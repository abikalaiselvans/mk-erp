var isIE;
var req;
var names;

function getElementY(element)
{
	var target1Top = 0;
	if (element.offsetParent) 
	{
		while (element.offsetParent) 
		{
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} 
	else if (element.y) 
	{
		target1Top += element.y;
    }
	return target1Top;
}

function initRequest(url) 
{
    if (window.XMLHttpRequest) 
        req = new XMLHttpRequest();
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

 
 
function Clear(ctr1)
{
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str;
}
 
var divname="";
var buttonname="";
var serialname ="";

function setSerialno(s,serials,divname)
{
	try
	{
	 	var idposition = serials.replace("serial","");
		var v = s.value.split("/");
		document.getElementById(serials).value = v[0];
		var tb=document.getElementById(divname);
	  	tb.innerHTML=""  ;
	 
	  	document.getElementById(divname).value=v[1];
	  	document.getElementById(serials).focus();
	  	if("H"==v[2])
	  		alert("Material in DC mode");
	  	else if("N"==v[2])
	  		alert("Fault Material...");
	  	else if("A"==v[2])
	  		alert("Given to Asset");
	  		
	  	 
	  	setOptionValue("Warrantys"+idposition, v[1]);
	}
	catch(err)
	{
		alert(err);
	}
	 
	 	 
	  		
}

 

 
//Start -Kalaiselvan--------------------------LoadUniqueCheck Purchase Sale--------------------
function LoadUniqueCheckSales(control,div,tablename,fieldname,button,itype,itemname) 
{
	var value =document.getElementById(control).value;
	//if(!(value==""))
	{
		divname=div;
		buttonname= button;
		serialname = control;
		var url = "../Common?actionS=UniqueIdSales&tablename="+escape(tablename);
		url = url +"&itype="+itype+"&itemname="+itemname;
		url = url +"&fieldname="+fieldname+"&search="+value;
		initRequest(url);
		req.onreadystatechange = UniqueCheckSalesRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }
	
}



function UniqueCheckSalesRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	UniqueCheckSalesMessages();
        }
    }
}

function UniqueCheckSalesMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Ids")[0]; 
		if(batchs.childNodes.length<1)
	 	{
	 		alert("Check Stock...");
	 	}
		var str="<select name='select' id='select' size='10' class ='bolddeepgreen' ondblclick=\"setSerialno(this,'"+serialname+"','"+divname+"')\">";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Serial= batch.getElementsByTagName("Serial")[0];
	    	Warranty= batch.getElementsByTagName("Warranty")[0];
	    	Good= batch.getElementsByTagName("Good")[0];
	    	if("N" == Good.childNodes[0].nodeValue)
	    		str = str+"<option value='"+Serial.childNodes[0].nodeValue+"/"+Warranty.childNodes[0].nodeValue+"/N' style=\"background-color:#F4958A\">&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 
	    	else if("H" == Good.childNodes[0].nodeValue)
	    		str = str+"<option value='"+Serial.childNodes[0].nodeValue+"/"+Warranty.childNodes[0].nodeValue+"/H' style=\"background-color:#996600\">&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 	    	
	    	else if("A" == Good.childNodes[0].nodeValue)
	    		str = str+"<option value='"+Serial.childNodes[0].nodeValue+"/"+Warranty.childNodes[0].nodeValue+"/H' style=\"background-color:#996600\">&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 	    	
			else
	    	  	str = str+"<option value='"+Serial.childNodes[0].nodeValue+"/"+Warranty.childNodes[0].nodeValue+"/Y'>&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 
        
	 	}
	 	str= str+"</select>";
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------UniqueIdValidate Sale--------------------
 
 
 
 
 
 
 
function setSerialnoswap(s,serials,divname)
{
	try
	{
		var idposition = serials.replace("SSwapSerial","");
		var v = s.value.split("/");
		document.getElementById(serials).value = v[0];
		var tb=document.getElementById(divname);
		tb.innerHTML="<font class='boldgreen'>"+v[1]+"-Years</font>" ;
	}
	catch(err)
	{
		alert(err);
	}
  	
}
 

 
 
 

function LoadUniqueSwapSales(control,div,tablename,fieldname,button,itype,itemname) 
{
	
	var value =document.getElementById(control).value;
	var itm =document.getElementById(itemname).value;
	divname=div;
	buttonname= button;
	serialname = control;
	document.getElementById(control).value="";
	var url = "../Common?actionS=UniqueIdSales&tablename="+escape(tablename);
	url = url +"&itype="+itype+"&itemname="+itm;
	url = url +"&fieldname="+fieldname+"&search="+value;
	req.onreadystatechange = UniqueSwapSalesRequest;
    req.open("GET", url, true);
    req.send(null);
	   
}


function UniqueSwapSalesRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	UniqueSwapSalesMessages();
        }
    }
}

function UniqueSwapSalesMessages() 
{
		try
		{
			var batchs = req.responseXML.getElementsByTagName("Ids")[0]; 
			var str="<select name='select' id='select' size='5' class ='bolddeepgreen'  ondblclick=\"setSerialnoswap(this,'"+serialname+"','"+divname+"')\">";
	    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    	{
		    	var batch = batchs.childNodes[loop];
		    	Serial= batch.getElementsByTagName("Serial")[0];
		    	Warranty= batch.getElementsByTagName("Warranty")[0];
		    	str = str+"<option value='"+Serial.childNodes[0].nodeValue+" / "+Warranty.childNodes[0].nodeValue+"'>"+Serial.childNodes[0].nodeValue+"</option>"; 
	        }
		 	str= str+"</select>";
		 	var tb=document.getElementById(divname);
	  	 	tb.innerHTML=str  ;
		}
		catch(err)
		{
			alert(err);
		}
 }



 
 
 
 
 

//LoadUniqueCheckSale
//Start -Kalaiselvan--------------------------LoadUniqueCheck Purchase Sale--------------------
function LoadUniqueCheckSale(control,div,tablename,fieldname,button) 
{
	var value =document.getElementById(control).value;
	if(!(value==""))
	{
		divname=div;
		buttonname= button;
		var url = "../Common?actionS=UniqueIdSale&tablename="+escape(tablename);
		url = url +"&fieldname="+fieldname+"&value="+value;
		initRequest(url);
		req.onreadystatechange = UniqueCheckSaleRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }   
}
function UniqueCheckSaleRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	UniqueCheckSaleMessages();
        }
    }
}

function UniqueCheckSaleMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='changePos'>Valid Serialno </font>";
	    		document.getElementById(buttonname).disabled=false;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='bolddeepred'>Invalid Serialno</font>";	
	    		document.getElementById(buttonname).disabled=true;
	    	}	
        
	 	}
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------UniqueIdValidate Sale--------------------
 
 

 
 
 
 
//Start -Kalaiselvan--------------------------LoadUniqueCheck Purchase--------------------
function LoadUniqueCheck(control,div,tablename,fieldname,button) 
{
	var value =document.getElementById(control).value;
	document.getElementById(button).disabled=false;
	if(!(value==""))
	{
		divname=div;
		buttonname= button;
		var url = "../Common?actionS=UniqueId&tablename="+escape(tablename);
		url = url +"&fieldname="+fieldname+"&value="+value;
		//alert(url);
		initRequest(url);

		req.onreadystatechange = UniqueCheckRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }   
}

function UniqueCheckRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	UniqueCheckMessages();
        }
    }
}

function UniqueCheckMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById(buttonname).disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById(buttonname).disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------UniqueIdValidate purchase--------------------
 
 

 //Start -Kalaiselvan--------------------------LoadUniqueCheckwithdata  --------------------
function LoadUniqueCheckWithData(control,div,tablename,fieldname,button,data) 
{
	var value =document.getElementById(control).value;
	if(!(value==""))
	{
		divname=div;
		buttonname= button;
		var url = "../Common?actionS=UniqueIdWithData&tablename="+escape(tablename);
		url = url +"&fieldname="+fieldname+"&value="+value;
		url = url+"&data="+data;
		initRequest(url);
		req.onreadystatechange = UniqueCheckWithDataRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }   
}

function UniqueCheckWithDataRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	UniqueCheckWithDataMessages();
        }
    }
}

function UniqueCheckWithDataMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById(buttonname).disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById(buttonname).disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------LoadUniqueCheckwithdata  --------------------
 
 
 
 
 