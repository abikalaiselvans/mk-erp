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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadDesign(startLetter) 
{
	
	var url = "../marketing?actionS=loadDesign&startLetter="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = DesignRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function DesignRequest() 
{
	ClearTable('DesignationTable');  
    ClearTabler('totrec'); 
	if(req.readyState == 4) 
    {    	
        if (req.status== 200) 
        {		  	
        	DesignMessages();
        }
    }
}

function DesignMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("RowsD")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("DesignId")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("DesignName")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td   class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1);
		str=str+"<td   class='boldEleven'>&nbsp;"+Name;
    }
    
	if(batchs.childNodes.length <1)
	 		str=str+"<td colspan='5' class='MRow1' align='center'><br><br><br><font   class='bolddeepred'><center>Data not found..</center></font></td>";

  	str=str+"</table>";
	var tb=document.getElementById('DesignationTable');
  	tb.innerHTML=str;
	tb=document.getElementById('totrec');
  	tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
}

  