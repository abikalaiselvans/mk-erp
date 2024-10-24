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
 

function loadTargetAssignAvgCollection(groupid) 
{
	var Branch=document.getElementById('Branch').value;   
	var division=document.getElementById('division').value;   
	var month=document.getElementById('month').value;   
	var yea=document.getElementById('year').value; 
	var url = "../inventory?actionS=INVTargetAssignAvgCollection&year="+escape(yea)+"&Branch="+Branch+"&division="+division+"&month="+month+"&groupid="+groupid;     
   	initRequest(url);
    req.onreadystatechange = TargetAssignAvgCollectionRequest;
    req.open("GET", url, true);
    req.send(null);
    var tb=document.getElementById('TargetTable');
 	tb.innerHTML="" ;
 	 
}

function TargetAssignAvgCollectionRequest() 
{
    if(req.readyState == 4) {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec')
        if (req.status == 200) {		  	
          TargetAssignAvgCollectionMessages();
        }
    }
}

function TargetAssignAvgCollectionMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr bgcolor='#ffffff'><td colspan=7 class='boldEleven'><b><center>"+getMonthCharacter(document.getElementById('month').value)+" - Report </center></b></td>";
    	 str=str+"<tr class='MRow1'><td><strong></strong></td>";
         str=str+"<td class='boldEleven'><strong >Customer Group</strong></td>";
         str=str+"<td class='boldEleven'><strong>No of Invoice</strong></td>";
         str=str+"<td class='boldEleven'><strong>Collection Amount</strong></td>";
         str=str+"<td class='boldEleven'><strong>Collection Days</strong></td>";
         str=str+"<td class='boldEleven'><strong>Average</strong></td>";
         str=str+"<td class='boldEleven'><strong>Detailed View</strong></td>";
 	}
 	else
 	{
 		str = str+"<tr bgcolor=#ffffff><td ><span class='boldred'><center>Data not found...</center></span></td></tr>"
 	}
 	
 	
 	
        var Branch=document.getElementById('Branch').value;   
		var division=document.getElementById('division').value;   
		var month=document.getElementById('month').value;   
		var yea=document.getElementById('year').value; 
		
		
 	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    
	    var batch = batchs.childNodes[loop];
        var Groupname = batch.getElementsByTagName("Groupname")[0].childNodes[0].nodeValue;
        var NoofINV = batch.getElementsByTagName("NoofINV")[0].childNodes[0].nodeValue;
        var Collectionamt = batch.getElementsByTagName("Collectionamt")[0].childNodes[0].nodeValue;
        var Collectionday = batch.getElementsByTagName("Collectionday")[0].childNodes[0].nodeValue;
        var Avg = batch.getElementsByTagName("Avg")[0].childNodes[0].nodeValue;
        var Detailed = batch.getElementsByTagName("Detailed")[0].childNodes[0].nodeValue;
        var CustomerGroupid = batch.getElementsByTagName("CustomerGroupid")[0].childNodes[0].nodeValue;
        
        
        if(loop%2==1)
			str=str+"<tr class='MRow1' height='20'>";
		else
		    str=str+"<tr  class='MRow2' height='20'>";		
		    
		var link ="<a  target='_blank' href='TargetAchieveAvgCollectionDetailedView.jsp?id="+Detailed;
        link =link+"&Branch="+Branch;
        link =link+"&division="+division;
        link =link+"&month="+month;
        link =link+"&year="+yea+"'>";
        
        
		str=str+"<td>"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven'>"+link+Groupname  +"</a>";
		str=str+"<td class='boldEleven' align='right'>"+NoofINV +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+Collectionamt +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+Collectionday +"</td>";
        str=str+"<td class='boldEleven' align='right'>"+Avg +"</td>";
        
        //99403 05345
        
        link ="<a target='_blank' href='TargetAchieveAvgCollectionDetailedView.jsp?id="+CustomerGroupid ;
        link =link+"&Branch="+Branch;
        link =link+"&division="+division;
        link =link+"&month="+month;
        link =link+"&year="+yea+"'><font class='boldEleven'>Click</font></a>";
         
        if(Detailed  =="0")
        	str=str+"<td class='boldEleven' align='right'>";
        else
        	str=str+"<td class='boldEleven' align='right'>"+link;	
     }
     str=str+"</table>";
      var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	
}		




