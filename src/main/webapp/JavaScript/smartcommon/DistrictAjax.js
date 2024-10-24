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

function  loadDistrict(str) 
{
	var state = document.getElementById('state').value;
	var url = "../SmartCommonAjax?actionS=loadDistrict&state="+state+"&str="+str;
	initRequest(url);
	req.onreadystatechange = loadDistrictRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function loadDistrictRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('DistrictTable');
        ClearTabler('totrec');
        
        if (req.status== 200) 
        {		  	
        	loadDistrictMessages();
        }
    }
}

function loadDistrictMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
           
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Country = batch.getElementsByTagName("Country")[0].childNodes[0].nodeValue;
	    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
	    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
	     
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td    width='10%' class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1)+"</td>";
		str=str+"<td    width='20%' class='boldEleven'>&nbsp;"+Country+"</td>";
		str=str+"<td    width='30%' class='boldEleven'>&nbsp;"+State+"</td>";
		str=str+"<td    width='40%' class='boldEleven'>&nbsp;"+District+"</td>";
		
    }
   
    if(batchs.childNodes.length<1)
    	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
     	
    str=str+"</table>";
     var tb=document.getElementById('DistrictTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totrec');
  	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	   
  	 
  	
}

  