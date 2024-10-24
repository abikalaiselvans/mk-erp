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

function  loadCompany(str) 
{
	var url = "../SmartCommonAjax?actionS=loadCompany&str="+str;
	initRequest(url);
	req.onreadystatechange = loadCompanyRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function loadCompanyRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('companyTable');
        if (req.status== 200) 
        {		  	
        	loadCompanyMessages();
        }
    }
}

function loadCompanyMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Name</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Legal Name</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>City</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>District</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>State</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Email</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Pfnumber</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Status</b></td>";
    str=str+"</tr>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Legal = batch.getElementsByTagName("Legal")[0].childNodes[0].nodeValue;
	    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
	    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
	    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    var Pfnumber = batch.getElementsByTagName("Pfnumber")[0].childNodes[0].nodeValue;
	    var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue;
	      
	    
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td  width='15%' class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1)+".</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+Legal+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+City+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+District+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+State+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+Email+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+Pfnumber+"</td>";
		
		if(Active =="1")
			str=str+"<td  width='15%' class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td  width='15%' class='boldEleven'><font class='bolddeepred'>Inactive</font></td>";
    }
   
    if(batchs.childNodes.length<1)
     	str=str+"<tr class='MRow1'><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    	
    str=str+"</table>";
     var tb=document.getElementById('companyTable');
  	 tb.innerHTML=str  ; 
  	  tb=document.getElementById('totrec');
  	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
  	 
  	
}

  