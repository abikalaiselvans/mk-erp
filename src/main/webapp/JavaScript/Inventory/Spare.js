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


function callloadSpares()
{
	var sr=document.getElementById('search').value; 
	loadSpare(sr);
	 
} 

 
 
function callloadSpare(start)
{
	loadSpare(start);
} 


function loadSpare(sval) 
{
   try
   {
           
    var group=document.getElementById('sparegroup').value;
    var url = "../Spare?actionS=LoadSpare&search="+escape(sval)+"&group="+group;
    initRequest(url);
    req.onreadystatechange = SpareRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function SpareRequest() 
{
    if(req.readyState == 4) 
    {
        ClearTableTrible('divscroll');
        if (req.status == 200) 
        {
        	SpareMessages();
        }
    }
}

function SpareMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
 	    var group = batch.getElementsByTagName("group")[0].childNodes[0].nodeValue;
 	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
 	    var Des = batch.getElementsByTagName("Des")[0].childNodes[0].nodeValue;
 	    var PurPrice = batch.getElementsByTagName("PurPrice")[0].childNodes[0].nodeValue;
 	    var SalesPrice = batch.getElementsByTagName("SalesPrice")[0].childNodes[0].nodeValue;
 	    var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue;
 	    var Warranty = batch.getElementsByTagName("Warranty")[0].childNodes[0].nodeValue;
 	    
		if(loop%2==1)
			str=str+"<tr class='MRow1' >";
		else
		    str=str+"<tr  class='MRow2'  >";	
		
		str=str+"<td width='100' align='left' class='boldEleven'  > <input type='checkbox' id='rowid' name='rowid' value='"+Id+"'>"+group+"</td>"
		str=str+"<td  width='250'   class='boldEleven'  >"+Name+"</td>";
		str=str+"<td  width='250'   class='boldEleven'  >"+Des+"</td>";
		str=str+"<td  width='150'   class='boldEleven'  >"+Warranty+" - Yrs</td>";
		str=str+"<td  width='150'   class='boldEleven'  align='right'  >"+PurPrice+"</td>";
		str=str+"<td  width='150'   class='boldEleven' align='right'  >"+SalesPrice+"</td>";
		
		if(Active == "1")
			str=str+"<td  width='150' align='center' class='boldEleven'>Active </td>";						
		else
			str=str+"<td  width='150' align ='center' class='bolddeepred'>Inactive </td>";	
	 }		
     str=str+"</table>";
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   
  	 str="<font color='ff0000'>Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  
  	  
}
function ClearTableTrible(ctr1)
{
	 var str="<p class='boldEleven' align='center'><font color='ff0000'>Nothing found</font>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     ;
	 tb=document.getElementById('totRec');	 
  	 tb.innerHTML="<font color='ff0000'>Total no of Records :: 0</font>"    
  	 
}