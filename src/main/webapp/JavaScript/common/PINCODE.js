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
 
function LoadPINCODE(ctr)
 {
 	var c =ctr.value;
 	var f=document.getElementById('searchvalue').value
 	if(c.length >=4)
 	{
 		var tb=document.getElementById('er');
     	tb.innerHTML="";
 		var url = "../Common?actionS=LoadPINCODE&startLetter="+escape(ctr.value)+"&f="+f;
 		initRequest(url);
		req.onreadystatechange=PINCODERequest;
    	req.open("GET", url, true);
    	req.send(null);
    }
    else
    {
    	var tb=document.getElementById('er');
     	tb.innerHTML="<center><font class='bolddeepred'>Required Minimum 3 character</font></center>"   ;
     	ctr.focus();
    	 
    }	
}
 
 function PINCODERequest() {
    if(req.readyState == 4) {    	
        ClearTable('GroupTable');  
        var tb=document.getElementById('GroupTable');
  	 	tb.innerHTML="" ;
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	 	if (req.status == 200) 
        {		  	
          PINCODEMessages();
        }
    }
}
function PINCODEMessages() 
{	
	try
	{ 
    
    		var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    		var str=""; 
    		str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  		  	str=str+"<tr bgcolor='#FF0080'>";
		    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
		    str=str+"<td class='boldEleven' align='center'><b>COUNTRY</b></td>";
		    str=str+"<td class='boldEleven' align='center'><b>STATE</b></td>";
		    str=str+"<td class='boldEleven' align='center'><b>DISTRICT</b></td>";
		    str=str+"<td class='boldEleven' align='center'><b>CITY</b></td>";
		    str=str+"<td class='boldEleven' align='center'><b>PIN CODE</b></td>";
		  	str=str+"</tr>";
		  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		    {	     
		        var batch = batchs.childNodes[loop];
		        var Country = batch.getElementsByTagName("Country")[0].childNodes[0].nodeValue;
			    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
			    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
			    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
			    var Code = batch.getElementsByTagName("Code")[0].childNodes[0].nodeValue;
			    if(loop%2==1)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";		
				str=str+"<td  class='boldEleven'>&nbsp;"+(loop+1)+".";
				str=str+"<td  class='boldEleven'>&nbsp;"+Country ;
				str=str+"<td  class='boldEleven'>&nbsp;"+State;
				str=str+"<td  class='boldEleven'>&nbsp;"+District ;
				str=str+"<td  class='boldEleven'>&nbsp;"+City;
				str=str+"<td  class='boldEleven'>&nbsp;"+Code ;
				
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
	catch(err)	
	{
		alert(err.description)
	} 	
}