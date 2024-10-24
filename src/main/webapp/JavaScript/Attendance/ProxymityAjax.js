 var isIE;
var req;
var names;
  
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
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



function loadProxy(startLetter) 
{
    var Office=document.getElementById('Office').value;
    var issued=document.getElementById('issued').value;
    var status=document.getElementById('status').value;
    var url = "../attendance?actionS=AttProxy&type=1&Office="+Office+"&startLetter="+startLetter+"&issued="+issued+"&status="+status ;
	initRequest(url);
    req.onreadystatechange = ProxyRequest;
    req.open("GET", url, true);
    req.send(null);
}


function loadProxys(ctr) 
{
    var Office=document.getElementById('Office').value;
    var issued=document.getElementById('issued').value;
    var status=document.getElementById('status').value;
    var url = "../attendance?actionS=AttProxy&type=2&Office="+Office+"&startLetter="+ctr.value+"&issued="+issued+"&status="+status ;
	initRequest(url);
    req.onreadystatechange = ProxyRequest;
    req.open("GET", url, true);
    req.send(null);
}


function ProxyRequest() 
{
    if(req.readyState == 4) 
    {
    	ClearTable('Proxytable');
        ClearTabler('totalrecord');
         if (req.status == 200) 
        {
          ProxyMessages();
        }
    }
}
 
function ProxyMessages() 
{
    try
    {
	    var batchs = req.responseXML.getElementsByTagName("Proxyss")[0];   
	    var str=""; 
		str=str+"<table width='100%'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {
		    
		    var batch = batchs.childNodes[loop];
		    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
		    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
		    var Companyname = batch.getElementsByTagName("Companyname")[0].childNodes[0].nodeValue;
	        var Branchname = batch.getElementsByTagName("Branchname")[0].childNodes[0].nodeValue;     
	        var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue; 
	        var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue; 
	        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;  
	        var Card = batch.getElementsByTagName("Card")[0].childNodes[0].nodeValue;
	        var Cardno = batch.getElementsByTagName("Cardno")[0].childNodes[0].nodeValue;
	        var Return = batch.getElementsByTagName("Return")[0].childNodes[0].nodeValue;
	        
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
			   			 
			if("1"==Status)
				str=str+"<td class='boldEleven'><input name='staffid' id='staffid' type='checkbox' value='"+Empid+"' />"+Empid;
			else
				str=str+"<td class='boldEleven'>"+Empid+"</td>";	
			str=str+"<td class='boldEleven'>"+Staffname+"</td>";
			str=str+"<td class='boldEleven'>"+Companyname+"</td>";
			str=str+"<td class='boldEleven'>"+Branchname+"</td>";
			str=str+"<td class='boldEleven'>"+Depart+"</td>";
			str=str+"<td class='boldEleven'>"+Desig+"</td>";
			
			
			if("1"==Status && "Y" == Return  )
				str=str+"<td class='boldEleven'>"+Cardno+" /Card Issued</td>";
			else if ("1"==Status && "N" == Return  )	
				str=str+"<td class='boldEleven'>"+Card+" /Card Issued</td>";
			else
				str=str+"<td class='boldEleven'><font color='red'>Card Not-Issued</font></td>";	
			
			if("1"==Status)
			{
				if("Y" == Return )
					str=str+"<td class='boldEleven'>Return</td>";
				else
					str=str+"<td class='boldEleven'>Not Return / <a href='../SmartLoginAuth?filename=ProxymityCard&actionS=ATTProxymityCardReturn&Empid="+Empid+"'><font class='bolddeepred'>Return</font></a></td>";
			}
			else
				str=str+"<td class='boldEleven'>-</td>";
	    }
	     str=str+"</table>";
	    
	     var tb=document.getElementById('Proxytable');
	  	 tb.innerHTML=str  ; 
	  	 
	  	 
	  	 tb=document.getElementById('totalrecord');
	  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
	}
	catch(err)	
	{
		alert(err.description)
	}  	
}

 

 