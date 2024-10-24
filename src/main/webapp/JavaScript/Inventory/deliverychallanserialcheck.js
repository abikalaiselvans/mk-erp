var divname="";
var buttonname="";
var serialname ="";

function setSerialno(s,serials,divname)
{
	 
	var idposition = serials.replace("serial","");
	var v = s.value.split("/");
	document.getElementById(serials).value = v[0];
	var tb=document.getElementById(divname);
  	tb.innerHTML=""  ;
  	tb=document.getElementById("Warranty"+idposition);
  	tb.innerHTML="<font class='boldEleven'><b>"+v[1]+"-Years</b></font>"  ;
  	document.getElementById(divname).value=v[1];
  	document.getElementById("Warrantys"+idposition).value=v[1];
  	document.getElementById(serials).focus();
  	if("H"==v[2])
  		alert("Material in DC mode");
  	else if("N"==v[2])
  		alert("Fault Material...");
}

function Clear(ctr1)
{
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str;
} 

function LoadDCUniqueCheckSales(control,div,tablename,fieldname,button,itype,itemname) 
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
		req.onreadystatechange = DCUniqueCheckSalesRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }
	
}



function DCUniqueCheckSalesRequest() 
{
	if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	DCUniqueCheckSalesMessages();
        }
    }
}

function DCUniqueCheckSalesMessages() 
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
	    		str = str+"<option value='"+Serial.childNodes[0].nodeValue+" / "+Warranty.childNodes[0].nodeValue+"/N' style=\"background-color:#F4958A\">&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 
	    	else if("H" == Good.childNodes[0].nodeValue)
	    	{
				//alert("Material in DC Mode");
				str = str+"<option value='"+Serial.childNodes[0].nodeValue+" / "+Warranty.childNodes[0].nodeValue+"/H' style=\"background-color:#996600\">&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 	    	
			}	
	    	else
	    	  	str = str+"<option value='"+Serial.childNodes[0].nodeValue+" / "+Warranty.childNodes[0].nodeValue+"/Y'>&nbsp;"+Serial.childNodes[0].nodeValue+"&nbsp;</option>"; 
        
	 	}
	 	str= str+"</select>";
	 	
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------UniqueIdValidate Sale--------------------
 
 
 