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

function  loadUploadCategory(startLetter)
{
	var url = "../UploadAjax?actionS=loadUploadCategory&startLetter="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = loadUploadCategoryRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function loadUploadCategoryRequest() 
{
    
	ClearTabler('totrec');
    ClearTable('loadUploadCategoryTable');
	if(req.readyState == 4) 
    {    	
       // ClearTable('loadUploadCategoryTable');
        if (req.status== 200) 
        {		  	
        	loadUploadCategoryMessages();
        }
    }
}


function loadUploadCategoryMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			   			 
		str=str+"<td   width='10%' class='boldEleven'><input name='ids' id='ids' type='checkbox' value='"+Id+"' />"+(loop+1)+".</td>";
		str=str+"<td   width='90%' class='boldEleven'>&nbsp;"+Name+" </td>";		 
    }
    
   var tb=document.getElementById('loadUploadCategoryTable');
  	tb.innerHTML=str  ; 
  	tb=document.getElementById('totrec');
  	tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
    if(batchs.childNodes.length<1)
    {
    	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	document.getElementById('Edit').disabled=true;
    }
    else
    	document.getElementById('Edit').disabled=false;	
    	
    str=str+"</table>";
    
  	 
  	
}

  