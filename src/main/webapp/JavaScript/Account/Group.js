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

 
function Group(startLetter)
 {
 	var group=document.getElementById('group').value;
    var url = "../Account?actionS=Group&group="+escape(group)+"&startLetter="+escape(startLetter);
    initRequest(url);
	req.onreadystatechange=GroupRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function GroupRequest() {
    if(req.readyState == 4) {    	
        ClearTable('GroupTable');  
        var tb=document.getElementById('GroupTable');
  	 	tb.innerHTML="" ;
  	 	
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	 	
  	 	
		 document.getElementById('Edit').disabled=true;  		
        if (req.status == 200) 
        {		  	
          GroupMessages();
        }
    }
}
function GroupMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    
	str=str+"<table width=100%  border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='groupid' id='groupid' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+Name;
		str=str+"<td  class='boldEleven'>&nbsp;"+Group;
		
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
     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
     	
}