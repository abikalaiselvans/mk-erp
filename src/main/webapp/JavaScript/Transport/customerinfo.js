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

 
function LoadCustomerInfo(startLetter)
{
 	var country=document.getElementById('country').value;	 
 	var state=document.getElementById('state').value;	
 	var district=document.getElementById('district').value;	
 	var city=document.getElementById('city').value;	
 	var type=document.getElementById('type').value;	
 	var url = "../Transaction?actionS=LoadCustomerInfo&startLetter="+escape(startLetter)+"&country="+country+"&state="+state+"&district="+district+"&city="+city+"&type="+type;
 	initRequest(url);
	req.onreadystatechange=CustomerInfoRequest;
    req.open("GET", url, true);
    req.send(null);
}
 

function CustomerInfoRequest() 
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
          CustomerInfoMessages();
        }
    }
}


function CustomerInfoMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var Country = batch.getElementsByTagName("Country")[0].childNodes[0].nodeValue;
	    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
	    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
	    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
	    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+Name ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Branch ;
		str=str+"<td  class='boldEleven'>&nbsp;"+State ;
		str=str+"<td  class='boldEleven'>&nbsp;"+District ;
		str=str+"<td  class='boldEleven'>&nbsp;"+City ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Phone  ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile  ;
		str=str+"<td  class='boldEleven'>&nbsp;"+Email  ;
  }
	 
	if(batchs.childNodes.length >0)
  	{  	 	
     	 
    }
    else
    {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	 
    }	
	str=str+"</table>";
    var tb=document.getElementById('GroupTable');
  	tb.innerHTML=str   ;
  	tb=document.getElementById('totalrec');
  	tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
}