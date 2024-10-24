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
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
 
 




	


function loadRecoverys(ctr)
{
   try
   {
	 	var url = "../Payroll?actionS=loadRecoverys&startLetter="+escape(ctr);
		initRequest(url);
		req.onreadystatechange =loadRecoverysRequest;
		req.open("GET", url, true);
		req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}


function loadRecoverysRequest()
 {
	ClearTable('payTable');
	ClearTabler('totalrecord');
    if(req.readyState == 4) 
    {
         if (req.status == 200) 
         {
        	 loadRecoverysMessage();
        }
    }
}

function loadRecoverysMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];
      	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven'><b>S.NO</b></td>";
    str=str+"<td class='boldEleven'><b>NAME</b></td>";
    str=str+"<td class='boldEleven'><b>CHANGES </b></td>";
    str=str+"</tr>";
     for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue ;
        var Code = batch.getElementsByTagName("Code")[0].childNodes[0].nodeValue;  
        var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue; 
        var Monthflag = batch.getElementsByTagName("Monthflag")[0].childNodes[0].nodeValue; 
         
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		
       	str=str+"<td class='boldEleven' align='left'><input id='rowid' type='checkbox' value='"+Id+"' name='rowid'>"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven' align='left'> "+Name +"</td>";
		if(Monthflag == "M")
			str=str+"<td class='boldEleven' align='left'><font class='bolddeepred'>Monthly</font></td>";
		else
			str=str+"<td class='boldEleven' align='left'><font class='boldgreen'> Yearly</font></td>";
		str=str+" </tr>";
		
		 
     }
     str=str+"</table>";
     
     if(batchs.childNodes.length >=8)
    	 document.getElementById('action1').disabled=true;
     
  	 var tb=document.getElementById('payTable');
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
  	  
     
}

 

 