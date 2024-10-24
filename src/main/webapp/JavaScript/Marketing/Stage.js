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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 
function LoadStage(startLetter)
 {
 	var url = "../marketing?actionS=LoadStage&startLetter="+escape(startLetter);
   	initRequest(url);
	req.onreadystatechange=LoadStageRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadStageRequest() 
 {
	 ClearTabler('totalrec');
	 ClearTable('GroupTable');
	 if(req.readyState == 4) 
	 {    	
     	if (req.status == 200) 
        {		  	
          var tb=document.getElementById('GroupTable');
		  tb.innerHTML="<font class='bolddeepred'> Loading Data</font>"; 
		  LoadStageMessages();
        }
    }
}
 

function LoadStageMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow1'>";
	str=str+"<td  class='boldEleven' align='center'><b>S.No</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Stage</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>%</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b>Color</b></td>";
	str=str+"<td  class='boldEleven' align='center'><b></b></td>";
	str=str+"</tr>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Percentage = batch.getElementsByTagName("Percentage")[0].childNodes[0].nodeValue;
	    var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue;
	    var Color = batch.getElementsByTagName("Color")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'> <a href='StageAction.jsp?id="+Id+"' >"+Name +" </a> " ;
		str=str+"<td  class='boldEleven' align='right'>"+Percentage+"</td>";
		str=str+"<td  class='boldEleven' bgcolor='"+Color+"'>&nbsp;</td>";
		
		 if(Active=="Y")
			str=str+"<td  class='boldEleven'><font color='blue'>Active</font>";
		else
			str=str+"<td  class='boldEleven'><font color='red'>Inactive</font>";	 
    }
    
	     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>";
	 
	 if(batchs.childNodes.length >0)
  	{  	 	
     	 
    }
    else
    {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	 
     
    }	
	 str=str+"</table>";

     	
}