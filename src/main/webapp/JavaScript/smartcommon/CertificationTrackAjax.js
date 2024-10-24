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


function  loadCertificationTrack(str) 
{
	var cid= document.getElementById('Certification').value
	var url = "../SmartCommonAjax?actionS=loadCertificationTrack&cid="+cid+"&str="+str;
	initRequest(url);
	req.onreadystatechange = CertificationTrackRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function CertificationTrackRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('CertificationTable');
        ClearTabler('totalrecord');
        if (req.status== 200) 
        {		  	
        	CertificationTrackMessages();
        }
    }
}

function CertificationTrackMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td   class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Emp Id</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Emp Name</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Mailid</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Mobile</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Certification</b></td>";
    str=str+"</tr>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var RId = batch.getElementsByTagName("RId")[0].childNodes[0].nodeValue;
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Cid = batch.getElementsByTagName("Cid")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    
		  
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td   class='boldEleven'><input name='id' id='id' type='checkbox' value='"+RId+"' />"+(loop+1);
		str=str+"<td   class='boldEleven'>&nbsp;"+Id;
		str=str+"<td   class='boldEleven'>&nbsp;"+Name;
		str=str+"<td   class='boldEleven'>&nbsp;"+Email;
		str=str+"<td   class='boldEleven'>&nbsp;"+Mobile;
		str=str+"<td   class='boldEleven'>&nbsp;"+Cid;
		
    }
   
    if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	
    str=str+"</table>";
     var tb=document.getElementById('CertificationTable');
  	 tb.innerHTML=str  ; 
  	 
	 
   	tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
	
}

  