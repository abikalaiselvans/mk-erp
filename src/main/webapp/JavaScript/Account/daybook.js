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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 
function LoadDayBook(startLetter)
 {
 	 
 	var url = "../Account?actionS=LoadDayBook&startLetter="+escape(startLetter);
    initRequest(url);
	req.onreadystatechange=DayBookRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function DayBookRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('idTable');  
	        var tb=document.getElementById('idTable');
	  	 	tb.innerHTML="" ;
	  	 	var tb1=document.getElementById('totRec');
	  	 	tb1.innerHTML=" " ;
	  		document.getElementById('Edit').disabled=true;  
	  		if (req.status == 200) 
	        {		  	
	          DayBookMessages();
	        }
	    }
	}
	catch(err)
	{
		
	} 
}
function DayBookMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	//str=str+"<tr  class='MRow2'>";
  	//str=str+"<td  class='boldEleven'><b>S.No</b></td>";
    //str=str+"<td  class='boldEleven'><b>Name</b> </td>";
    //str=str+"<td  class='boldEleven'><b>Description</b></td>";
   // str=str+"<td  class='boldEleven'><b>Date</b></td>";
    //str=str+"<td  class='boldEleven'><b>Debit</b></td>";
    //str=str+"<td  class='boldEleven'><b>Credit</b></td>";
    str=str+"</tr> ";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Field1 = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Field2 = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Field3 = batch.getElementsByTagName("Description")[0].childNodes[0].nodeValue;
	    var Field4 = batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	    var Field5 = batch.getElementsByTagName("Credit")[0].childNodes[0].nodeValue;
	    var Field6 = batch.getElementsByTagName("Debit")[0].childNodes[0].nodeValue;
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Field1+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>"+Field2;
		str=str+"<td  class='boldEleven'>"+Field3;
		str=str+"<td  class='boldEleven'>"+Field4;
		str=str+"<td  class='boldEleven' align='right'><b>"+Field5;
		str=str+"<td  class='boldEleven' align='right'><b>"+Field6;
		
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     
     }	
	 str=str+"</table>";
     var tb=document.getElementById('idTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<center><font color='red'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
     	
}