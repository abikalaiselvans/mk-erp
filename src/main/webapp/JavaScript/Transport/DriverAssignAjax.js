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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 
function LoadDriverAssign(startLetter)
 {
 	 
    
    var typeid= document.getElementById('vehicletype').value;
 	var makeid= document.getElementById('vehiclemake').value;
 	var modelid= document.getElementById('vehiclemodel').value;
 	var varriant= document.getElementById('varriant').value;
 	var url = "../Transport?actionS=LoadDriverAssign&startLetter="+escape(startLetter)+"&typeid="+typeid+"&makeid="+makeid+"&modelid="+modelid+"&varriant="+varriant
 	initRequest(url);
 	
	req.onreadystatechange=LoadDriverAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadDriverAssignRequest() 
 {
 	 if(req.readyState == 4) 
    {    	
        ClearTable('GroupTable');  
        var tb=document.getElementById('GroupTable');
  	 	tb.innerHTML="" ;
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	 	document.getElementById('Edit').disabled=true; 
		document.getElementById('Delete').disabled=true;   		
        if (req.status == 200) 
        {		  	
          LoadDriverAssignMessages();
        }
    }
}
function LoadDriverAssignMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Regno = batch.getElementsByTagName("Regno")[0].childNodes[0].nodeValue;
	    var Vehicletype = batch.getElementsByTagName("Vehicletype")[0].childNodes[0].nodeValue;
	    var Make = batch.getElementsByTagName("Make")[0].childNodes[0].nodeValue;
	    var Model = batch.getElementsByTagName("Model")[0].childNodes[0].nodeValue;
	    var Varriant = batch.getElementsByTagName("Varriant")[0].childNodes[0].nodeValue;
	    var Fuel = batch.getElementsByTagName("Fuel")[0].childNodes[0].nodeValue;
	    var Color = batch.getElementsByTagName("Color")[0].childNodes[0].nodeValue;
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staff = batch.getElementsByTagName("Staff")[0].childNodes[0].nodeValue;
	    var Flag = batch.getElementsByTagName("Flag")[0].childNodes[0].nodeValue;
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+Regno ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Vehicletype ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Make ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Model ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Varriant ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Fuel ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Color ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Empid ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Staff ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Flag ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Date ;
		 
  	}
	if(batchs.childNodes.length >0)
  	{  	 	
    	document.getElementById('Edit').disabled=false;
     	document.getElementById('Delete').disabled=false;
    }
    else
    {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     	document.getElementById('Delete').disabled=true;
    }	
	str=str+"</table>";
    var tb=document.getElementById('GroupTable');
  	tb.innerHTML=str   ;
  	tb=document.getElementById('totalrec');
  	tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
}