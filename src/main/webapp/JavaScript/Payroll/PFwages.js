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

 
function LoadPFwages(startLetter) 
{         
    var url = "../Payroll?actionS=LoadPFwages&startLetter="+startLetter ;
	initRequest(url);
    req.onreadystatechange = LoadPFwagesRequest;
    req.open("GET", url, true);
    req.send(null);
}
  
 


function LoadPFwagesRequest() 
{
	 
    if(req.readyState == 4) 
    {
        ClearTable('RecordTable');
        ClearTabler('totRec'); 
        if (req.status == 200) 
        {		  	
        	LoadPFwagesMessages();
        }
    }
}

function LoadPFwagesMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {           		                           
	    var batch = batchs.childNodes[loop];
	    var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var PFMini = batch.getElementsByTagName("PFMini")[0].childNodes[0].nodeValue; 
    	var PFMaxi = batch.getElementsByTagName("PFMaxi")[0].childNodes[0].nodeValue;
    	var ESILimit = batch.getElementsByTagName("ESILimit")[0].childNodes[0].nodeValue;
    	var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
    	 
    	 
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
    	if(Status =="Inactive")
    	 	str= str+"<td   class='boldEleven'>"+(loop+1)+". </td>";
    	else
    	 	str= str+"<td width='50' class='boldEleven'><input type='checkbox' id='Rowid'   name='Rowid' value='"+Rowid+"'>"+(loop+1)+". </td>";
    	   		
		str=str+"<td width='175' class='boldEleven'>Rs."+PFMini+"</td>";
		str=str+"<td width='150' class='boldEleven'>Rs."+PFMaxi+"</td>";
		str=str+"<td width='75' class='boldEleven'>Rs."+ESILimit+"</td>";
		str=str+"<td width='100' class='boldEleven'>"+Status+"</td>";
		str=str+"</tr>";
     }     
  	if(batchs.childNodes.length<1)
    	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('RecordTable');
  	tb.innerHTML=str; 
 	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 

}

  