var isIE;
var req;
var names;
var target1;
var ctrl;
 


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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 
var searchname="";
function LoadSearchMobile(ctr)
{
	var search=document.getElementById(ctr).value; 
 	var f = true;
 	if(search=="")
 	{
 		var rs=confirm("Load all Mobile");
		if (rs==true)
			f = true;
		else
			f=false;
	}
	else
		f=true;		
			
 	if(f)
 	{
 		searchname =  search.toUpperCase(); 
 		var url = "../SMS?actionS=loadMobileSearch&search="+escape(search);
 		initRequest(url);
   		req.onreadystatechange = LoadMobileRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
}
	
function LoadMobileRequest()
 {

	ClearTabler('totalrec');
    ClearTable('GroupTable');

    if(req.readyState == 4) 
    {
         
        document.getElementById('Edit').disabled=true; 
		document.getElementById('Delete').disabled=true;  
         if (req.status == 200) 
         {
          	// tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
			 var tb=document.getElementById('GroupTable');
		 	tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
			MobileMessage();
        }
    }
}

function MobileMessage() 
{	
   var batchs = req.responseXML.getElementsByTagName("Rowm")[0];   
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=3 cellspacing=1 bgcolor='#9900CC' >";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
        var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Age = batch.getElementsByTagName("Age")[0].childNodes[0].nodeValue;
	    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
	    var Staff = batch.getElementsByTagName("Staff")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow1'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Group+"</td>";
		str=str+"<td  class='boldEleven'> <a href='MobileContactsAction.jsp?id="+Id+"' >"+Name +" </a> " +"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Email+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Age+"-yrs</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+City+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Staff+"</td>";
		str=str+"</tr>";
		 
    }
    
	     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>";
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

    	// document.getElementById('action1').focus();
     
}

 