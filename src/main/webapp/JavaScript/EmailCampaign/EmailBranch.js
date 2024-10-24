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

 
function LoadEmailBranch(startLetter)
 {
 	var group= document.getElementById('group').value;
 	var company= document.getElementById('company').value;
 	
 	var url = "../EmailCampaignAJAX?actionS=LoadEmailBranch&startLetter="+escape(startLetter)+"&group="+group+"&company="+company;
    initRequest(url);
	req.onreadystatechange=EmailBranchRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function EmailBranchRequest() {
    if(req.readyState == 4) {    	
        ClearTable('GroupTable');  
        var tb=document.getElementById('GroupTable');
  	 	tb.innerHTML="" ;
  	 	
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	 	
  	 	
		document.getElementById('Edit').disabled=true; 
		document.getElementById('Delete').disabled=true;   		
        if (req.status == 200) 
        {		  	
          EmailBranchMessages();
        }
    }
}
function EmailBranchMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	str=str+"<tr class='MRow1'>";
    str=str+"<td  class='bold1'>S.No</td>";
    str=str+"<td  class='bold1'><div align='left'> Group Name</div></td>";
	str=str+"<td  class='bold1'><div align='left'> Company Name</div></td>";
	str=str+"<td  class='bold1'><div align='left'> Branch Name</div></td>";
	str=str+"<td  class='bold1'><div align='left'> Address</div></td>";
	str=str+"<td  class='bold1'><div align='left'> City</div></td>";
    str=str+"<td  class='bold1'><div align='left'> Email</div></td>";
    str=str+"</tr>";
                
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;
	    var CName = batch.getElementsByTagName("CName")[0].childNodes[0].nodeValue;
	    var BName = batch.getElementsByTagName("BName")[0].childNodes[0].nodeValue;
	    var Address = batch.getElementsByTagName("Address")[0].childNodes[0].nodeValue;
	    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+Group;
		str=str+"<td  class='boldEleven'>&nbsp;"+CName;
		str=str+"<td  class='boldEleven'>&nbsp;"+BName;
		str=str+"<td  class='boldEleven'>&nbsp;"+Address;
		str=str+"<td  class='boldEleven'>&nbsp;"+City;
		str=str+"<td  class='boldEleven'>&nbsp;"+Email;
		 
		
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     	document.getElementById('Delete').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     	document.getElementById('Delete').disabled=true;
     
     }	
	 str=str+"</table>";
     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
     	
}