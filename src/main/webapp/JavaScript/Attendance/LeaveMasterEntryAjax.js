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


function loadLeaveEntrys(startLetter) 
{
	document.getElementById('Delete').disabled=true;
    document.getElementById('Edit').disabled=true;
    var Office=document.getElementById('Office').value;
    var dept=document.getElementById('dept').value;
    var year=document.getElementById('year').value;
    var search=document.getElementById('search').value;
    var Category=document.getElementById('Category').value;
    
    var url = "../attendance?actionS=AttLeaves&Office="+Office+"&startLetter="+escape(startLetter)+"&dept="+dept+"&year="+year+"&search="+search+"&Category="+Category;
	initRequest(url);
	req.onreadystatechange = LeaveRequests;
    req.open("GET", url, true);
    req.send(null);
}

function LeaveRequests() {
    if(req.readyState == 4) {  
    	ClearTable('LeaveTable');
    	 ClearTabler('totRec');  
        if (req.status == 200) {		  	
         	LeaveMessagess();
        }
    }
}

function LeaveMessagess() 
{
	var batchs = req.responseXML.getElementsByTagName("Leaves")[0];   
    var str=""; 
	str=str+"<table width='100%' border='0' bgcolor='#D2691E' class='boldEleven' cellpadding='4' cellspacing='1'>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
        var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var leavelength =document.getElementById('leavelength').value
	    if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";		
		str=str+"<td   width='220' class='boldEleven'>"+(loop+1)+".&nbsp;"+Empid.childNodes[0].nodeValue+"</td>";
		str=str+"<td   width='230' class='boldEleven'>"+Staffname.childNodes[0].nodeValue+"</td>";
		
		 
					
		for(u=0;u<leavelength;u++)
		{
			var e = batch.getElementsByTagName("Eligible"+(u+1))[0];
			str=str+"<td   width='50' class='boldEleven' bgcolor='#FFE4C4'>"+e.childNodes[0].nodeValue+"</td>";
			var a = batch.getElementsByTagName("Available"+(u+1))[0];
			var urlink = "A="+a.childNodes[0].nodeValue+"&E="+e.childNodes[0].nodeValue+"&staffid="+Empid.childNodes[0].nodeValue+"&column=INT_NOD"+(u+1)+"&leave="+u;
			str=str+"<td   width='50'class='boldEleven' bgcolor='#D2E7E8'><a href=\"javascript:void(0);\" onClick=window.open('LeaveAssign.jsp?"+urlink+"','','width=600,height=450,left=150,top=200,toolbar=1,status=1')><font class='bolddeepred'>"+a.childNodes[0].nodeValue+"</font></a></td>";
		}
     }
     if(batchs.childNodes.length >0)
  	 {
  		document.getElementById('Delete').disabled=false;
     	document.getElementById('Edit').disabled=false ; 	 	 
     }
     else
     {
    	document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true; 	 	 
    
     }
     if(batchs.childNodes.length<1)
    	str=str+"<tr><td class='bolddeepred'><center>Data not found...</center></td></tr>";
    
     str=str+"</table>";
     var tb=document.getElementById('LeaveTable');
  	 tb.innerHTML=str  ; 
  	tb=document.getElementById('totRec');
 	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 	
 }