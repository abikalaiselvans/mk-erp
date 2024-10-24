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



function loadlocation(startLetter) 
{
	var officeid = document.getElementById('officeid').value;
	var url = "../SmartCommonAjax?actionS=loadlocation&startLetter="+escape(startLetter)+"&officeid="+officeid;
	initRequest(url);
	req.onreadystatechange = locationRequest;
    req.open("GET", url, true);
    req.send(null);
}

function locationRequest() 
{
    if(req.readyState == 4) 
    {    	
		ClearTable('locationtable');  
	    ClearTabler('totrec');
        if (req.status== 200) 
        {		  	
        	var tb=document.getElementById('locationtable');
			tb.innerHTML="<font class='bolddeepred'> Loading Data</font>"; 
			locationMessages();
        }
    }
}

function locationMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var locationname = batch.getElementsByTagName("locationname")[0].childNodes[0].nodeValue;
	    var Office = batch.getElementsByTagName("Office")[0].childNodes[0].nodeValue;
	    var active = batch.getElementsByTagName("active")[0].childNodes[0].nodeValue;
	   
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td   width='10%' class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1)+".</td>";
		str=str+"<td   width='30%' class='boldEleven'>&nbsp;"+locationname+" </td>";
		str=str+"<td   width='30%' class='boldEleven'>&nbsp;"+Office+" </td>";
		if(active == "Y")
			str=str+"<td   width='40%' class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td   width='40%' class='boldEleven'><font class='bolddeepred'>InActive</font></td>";
    }
   
    if(batchs.childNodes.length <1)
		str=str+"<tr class='MRow1'><td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
	 	str=str+"</table>";
    
	 var tb=document.getElementById('locationtable');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totrec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	
  	 
  	
}




