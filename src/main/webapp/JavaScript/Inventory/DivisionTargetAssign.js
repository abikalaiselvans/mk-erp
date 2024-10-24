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
  	 tb.innerHTML=str     ;
}


function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str   ;  
}


 
function loadDivisionTargetAssign(startletter) 
{
	var yea=document.getElementById('year').value;   
	var division=document.getElementById('division').value;   
	 
	var url = "../inventory?actionS=loadDivisionTargetAssign&year="+escape(yea)+"&division="+division +"&startletter="+startletter;     
   	initRequest(url);
    req.onreadystatechange = loadDivisionTargetAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadDivisionTargetAssignRequest() {
    if(req.readyState == 4) {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec');
        if (req.status == 200) {		  	
        	loadDivisionTargetAssignMessages();
        }
    }
}
function loadDivisionTargetAssignMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr class='MRow1'><td><strong>S.N0</strong></td>";
         str=str+"<td class='boldEleven'><strong >Division</strong></td>";
         str=str+"<td class='boldEleven'><strong>APR </strong></td>";
         str=str+"<td class='boldEleven'><strong>MAY</strong></td>";
         str=str+"<td class='boldEleven'><strong>JUN</strong></td>";
         str=str+"<td class='boldEleven'><strong>JUL</strong></td>";
         str=str+"<td class='boldEleven'><strong>AUG</strong></td>";
         str=str+"<td class='boldEleven'><strong>SEP</strong></td>";
         str=str+"<td class='boldEleven'><strong>OCT</strong></td>";
         str=str+"<td class='boldEleven'><strong>NOV</strong></td>";
         str=str+"<td class='boldEleven'><strong>DEC</strong></td>";
         str=str+"<td class='boldEleven'><strong>JAN</strong></td>";
         str=str+"<td class='boldEleven'><strong>FEB</strong></td>";
         str=str+"<td class='boldEleven'><strong>MAR</strong></td>";
         str=str+"<td class='boldEleven'><strong>Total Target(In lakhs)</strong></td>";
 	}
 	else
 	{
 		str = str+"<tr class='MRow1'><td ><span class='bolddeepred'>Data not found...</span></td></tr>"
 	}
 	
 	 
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
    	 
	    var batch = batchs.childNodes[loop];
	    var ROW = batch.getElementsByTagName("ROW")[0].childNodes[0].nodeValue;
	    var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var APR = batch.getElementsByTagName("APR")[0].childNodes[0].nodeValue;
        var MAY = batch.getElementsByTagName("MAY")[0].childNodes[0].nodeValue;
        var JUN = batch.getElementsByTagName("JUN")[0].childNodes[0].nodeValue;
        var JUL = batch.getElementsByTagName("JUL")[0].childNodes[0].nodeValue;
        var AUG = batch.getElementsByTagName("AUG")[0].childNodes[0].nodeValue;
        var SEP = batch.getElementsByTagName("SEP")[0].childNodes[0].nodeValue;
        var OCT = batch.getElementsByTagName("OCT")[0].childNodes[0].nodeValue;
        var NOV = batch.getElementsByTagName("NOV")[0].childNodes[0].nodeValue;
        var DEC = batch.getElementsByTagName("DEC")[0].childNodes[0].nodeValue;
        var JAN = batch.getElementsByTagName("JAN")[0].childNodes[0].nodeValue;
        var FEB = batch.getElementsByTagName("FEB")[0].childNodes[0].nodeValue;
        var MAR = batch.getElementsByTagName("MAR")[0].childNodes[0].nodeValue;
        var sum = batch.getElementsByTagName("SUM")[0].childNodes[0].nodeValue;
    	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		    
		str=str+"<td><strong><input type='checkbox' id='target' name='target' value='"+ROW +"'>"+(loop+1)+"</strong></td>";
		str=str+"<td class='boldEleven'>"+Division  +"</td>";   
		str=str+"<td class='boldEleven' align='right'>"+APR +"</td>";
		str=str+"<td class='boldEleven' align='right'>"+MAY +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+JUN +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+JUL +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+AUG +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+SEP +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+OCT +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+NOV +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+DEC +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+JAN +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+FEB +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+MAR +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+sum+"</td></tr>";

     }
     str=str+"</table>";
     
     var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 str="<font class='bolddeepred'>Total no of Records :: "  + loop+"</font>";
 	 tb=document.getElementById('totRec');
 	 tb.innerHTML=str 
  	 
}		



 