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

 
function LoadCity(startLetter)
{
 	
	var country = document.getElementById('country').value;
 	var state = document.getElementById('state').value;
 	var district = document.getElementById('district').value;
 	var url = "../Common?actionS=LoadCity&startLetter="+startLetter+"&country="+country+"&state="+state+"&district="+district;
 	initRequest(url);
	req.onreadystatechange=LoadCityRequest;
   	req.open("GET", url, true);
   req.send(null);
     
}
 

function LoadCityRequest() 
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
          LoadCityMessages();
        }
    }
}

function LoadCityMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Pincode = batch.getElementsByTagName("Pincode")[0].childNodes[0].nodeValue;
	    var country = batch.getElementsByTagName("country")[0].childNodes[0].nodeValue;
	    var state = batch.getElementsByTagName("state")[0].childNodes[0].nodeValue;
	    var district = batch.getElementsByTagName("district")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+country ;
		str=str+"<td  class='boldEleven'>&nbsp;"+state ;
		str=str+"<td  class='boldEleven'>&nbsp;"+district ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Name ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Pincode ;
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