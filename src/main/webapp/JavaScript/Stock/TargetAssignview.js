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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function loadTargetAssign(startletter) 
{	
	var year=document.getElementById('Financialyear').value;   
	var office=document.getElementById('office').value;   
	var dept=document.getElementById('dept').value;   
	var url = "../Stock?actionS=LoadTargetAssign&year="+escape(year)+"&office="+office+"&dept="+dept+"&startletter="+startletter;     
   	initRequest(url);
    req.onreadystatechange = TargetAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function TargetAssignRequest() {
    if(req.readyState == 4) {
        Clear('divscroll');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML= "";
        if (req.status == 200) 
        {
          TargetAssignMessages();
        }
    }
}
function TargetAssignMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%' border='0'bgcolor='#CCCCC0' class='boldEleven' cellpadding=3 cellspacing=1>";
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr class='MRow1'><td><strong></strong></td>";
         str=str+"<td class='boldEleven'><strong >Empid</strong></td>";
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
 		str = str+"<tr><td ><span class='boldred'>Data not found...</span></td></tr>"
 	}
 	
 	var sum=0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
    	sum=0;
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0];
        var Staffname = batch.getElementsByTagName("Staffname")[0];
        var APR = batch.getElementsByTagName("APR")[0];
        var MAY = batch.getElementsByTagName("MAY")[0];
        var JUN = batch.getElementsByTagName("JUN")[0];
        var JUL = batch.getElementsByTagName("JUL")[0];
        var AUG = batch.getElementsByTagName("AUG")[0];
        var SEP = batch.getElementsByTagName("SEP")[0];
        var OCT = batch.getElementsByTagName("OCT")[0];
        var NOV = batch.getElementsByTagName("NOV")[0];
        var DEC = batch.getElementsByTagName("DEC")[0];
        var JAN = batch.getElementsByTagName("JAN")[0];
        var FEB = batch.getElementsByTagName("FEB")[0];
        var MAR = batch.getElementsByTagName("MAR")[0];
        var ROW = batch.getElementsByTagName("ROW")[0];
    	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		    
		str=str+"<td><strong><input type='checkbox' id='TargetAssignid' name='TargetAssignid' value='"+ROW.childNodes[0].nodeValue+"'></strong></td>";
		str=str+"<td class='boldEleven'>"+Staffid.childNodes[0].nodeValue +" / "+Staffname.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' align='right'>"+APR.childNodes[0].nodeValue+"</td>";
		sum=sum+parseInt(APR.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+MAY.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(MAY.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+JUN.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(JUN.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+JUL.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(JUL.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+AUG.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(AUG.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+SEP.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(SEP.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+OCT.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(OCT.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+NOV.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(NOV.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+DEC.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(DEC.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+JAN.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(JAN.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+FEB.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(FEB.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+MAR.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(MAR.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+sum+"</td></tr>";

     }
     str=str+"</table>";

     
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 