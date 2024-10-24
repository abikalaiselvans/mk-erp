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

 
function LoadServiceCenter(startLetter)
 {
 	var url = "../inventory?actionS=LoadServiceCenter&startLetter="+escape(startLetter);
    initRequest(url);
	req.onreadystatechange=ServiceCenterRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function ServiceCenterRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	ClearTable('divscroll');  
	        var tb=document.getElementById('divscroll');
	  	 	tb.innerHTML="" ;
	  	 	var tb1=document.getElementById('totRec');
	  	 	tb1.innerHTML=" " ;
	  		document.getElementById('Edit').disabled=true;  
	  		if (req.status == 200) 
	        {		  	
	          ServiceCenterMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
function ServiceCenterMessages() 
{	 
 try
 {
 	var batchs = req.responseXML.getElementsByTagName("Groups")[0];   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	
  	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
      
        var batch = batchs.childNodes[loop];
        var Field1 = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Field2 = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Field3 = batch.getElementsByTagName("SName")[0].childNodes[0].nodeValue;
	    var Field4 = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Field5 = batch.getElementsByTagName("EMail")[0].childNodes[0].nodeValue;
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'  onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'><input name='id' id='id' type='checkbox' value='"+Field1+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'  onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>&nbsp;"+Field2;
		str=str+"<td  class='boldEleven'  onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>&nbsp;"+Field3;
		str=str+"<td  class='boldEleven'  onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>&nbsp;"+Field4;
		str=str+"<td  class='boldEleven'  onmouseover='this.bgColor=color1' onmouseout='this.bgColor=color2'>&nbsp;"+Field5;
		
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
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::</font>"+batchs.childNodes.length; 
  }
  catch(err)
  {
	alert(err.description);
  }    	
}