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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 
 function loadConveyance() 
{		
	 
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var Status = document.getElementById('Status').value;  
    var day = document.getElementById('day').value; 
    var staffid = document.getElementById('staffid').value;  
    var url = "../Conveyance?actionS=ConveyanceReport&month="+escape(mon)+"&year="+escape(yea)+"&Status="+Status+"&day="+day+"&staffid="+staffid;
	initRequest(url);
	req.onreadystatechange=ConveyanceReportRequest;
    req.open("GET", url, true);
    req.send(null);
}

function ConveyanceReportRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTabes('ConveyanceReportTable');  
        var tb=document.getElementById('ConveyanceReportTable');
  	 	tb.innerHTML="Loading Data" ;
		 		
        if (req.status == 200) 
        {		  	
          ConveyanceReportMessages();
        }
    }
}
function ConveyanceReportMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	 str=str+"<tr  class='MRow2'>";		
		   
	str=str+"<td class='boldEleven'><b>S.No</b></td>";	
	str=str+"<td class='boldEleven'><b> EmpId </b></td>";
	str=str+"<td class='boldEleven'><b> EmpName </b></td>";
	str=str+"<td class='boldEleven'><b> Date</b></td>";
	str=str+"<td class='boldEleven'><b> From</b></td>";
	str=str+"<td class='boldEleven'><b> To</b></td>";	
	str=str+"<td class='boldEleven'><b> Callid</b></td>";
	str=str+"<td class='boldEleven'><b> KM</b></td>";
	str=str+"<td class='boldEleven'><b> Travel</b></td>";
	str=str+"<td class='boldEleven'><b> Train</b></td>";
	str=str+"<td class='boldEleven'><b> Auto</b></td>";	
	str=str+"<td class='boldEleven'><b> Lunch</b></td>";
	str=str+"<td class='boldEleven'><b> Telephone</b></td>";
	str=str+"<td class='boldEleven'><b> Otherdesc</b></td>";
	str=str+"<td class='boldEleven'><b> Otheramount</b></td>";
	str=str+"<td class='boldEleven'><b> Total</b></td>";
	str=str+"<td class='boldEleven'><b> Status</b></td>";
	str=str+"</tr>"; 
  	var sum1=0.0;
  	var sum2=0.0;
  	var sum3=0.0;
  	var sum4=0.0;
  	var sum5=0.0;
  	var sum6=0.0;
  	var sum7=0.0;
  	var sum8=0.0;
  	
  	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var EmpId = batch.getElementsByTagName("EmpId")[0].childNodes[0].nodeValue;
	    var EmpName = batch.getElementsByTagName("EmpName")[0].childNodes[0].nodeValue;
	    var Date = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
        var From = batch.getElementsByTagName("From")[0].childNodes[0].nodeValue; 
        var To = batch.getElementsByTagName("To")[0].childNodes[0].nodeValue; 
        var Callid = batch.getElementsByTagName("Callid")[0].childNodes[0].nodeValue;
	    var KM = batch.getElementsByTagName("KM")[0].childNodes[0].nodeValue;
        var Travel= batch.getElementsByTagName("Travel")[0].childNodes[0].nodeValue; 
        var Train= batch.getElementsByTagName("Train")[0].childNodes[0].nodeValue; 
        var Auto= batch.getElementsByTagName("Auto")[0].childNodes[0].nodeValue;
	    var Lunch= batch.getElementsByTagName("Lunch")[0].childNodes[0].nodeValue;
        var Telephone= batch.getElementsByTagName("Telephone")[0].childNodes[0].nodeValue; 
        var Otherdesc= batch.getElementsByTagName("Otherdesc")[0].childNodes[0].nodeValue; 
        var Otheramount= batch.getElementsByTagName("Otheramount")[0].childNodes[0].nodeValue;
        var Total= batch.getElementsByTagName("Total")[0].childNodes[0].nodeValue; 
        var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue; 
                    
        sum1 =sum1+parseFloat(KM);
        sum2 =sum2+parseFloat(Travel); 
        sum3 =sum3+parseFloat(Train); 
        sum4 =sum4+parseFloat(Auto); 
        sum5 =sum5+parseFloat(Lunch); 
        sum6 =sum6+parseFloat(Telephone); 
        sum7 =sum7+parseFloat(Otheramount); 
        sum8 =sum8+parseFloat(Total); 
         
           
          // Rowid,EmpId,EmpName,Date,From,To,Callid,KM,Travel,Train,Auto,Lunch,Telephone,Otherdesc,Otheramount,Total,Status
   				
   				
   				
   				
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td class='boldEleven'>&nbsp;"+(loop+1)+"</td>";	
		str=str+"<td class='boldEleven'>&nbsp;"+EmpId+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+EmpName+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Date+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+From+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+To+"</td>";	
		str=str+"<td class='boldEleven'>&nbsp;"+Callid+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+KM+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Travel+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Train+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Auto+"</td>";	
		str=str+"<td class='boldEleven'>&nbsp;"+Lunch+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Telephone+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Otherdesc+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Otheramount+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Total+"</td>";
		if(Status=="Y")
			str=str+"<td class='boldEleven'><font class='bold1'>Accepted</font></td>";
		else if(Status=="R")
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Rejected</font></td>";
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		str=str+"</tr>";  
   				
    }
    
    
    
   		str=str+"<tr  class='MRow2'>";		
		str=str+"<td class='boldEleven'>&nbsp;</td>";	
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"<td class='boldEleven'>&nbsp;</td>";	
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum1+"</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum2+"</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum3+"</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum4+"</td>";	
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum5+"</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum6+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum7+"</td>";
		str=str+"<td class='boldEleven' align='right'>&nbsp;"+sum8+"</td>";
		str=str+"<td class='boldEleven'>&nbsp;</td>";
		str=str+"</tr>";    
    
    
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	 
     }
     else
     {
     	str=str+"<tr  class='MRow1'><td colspan='30' class='bolddeepred'><br><center>Data not found..<br> </center></td></tr>";
     	 
     
     }	
	 str=str+"</table>";
     var tb=document.getElementById('ConveyanceReportTable');
  	 tb.innerHTML=str   
     	
}


function ClearTabes(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 