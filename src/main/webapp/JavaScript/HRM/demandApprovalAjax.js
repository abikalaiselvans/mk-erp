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
 
function loadDemand(startLetter) 
{    
	var year=document.getElementById('year').value;  
	var month=document.getElementById('month').value;
	var jobgrade=document.getElementById('jobgrade').value;
	var status=document.getElementById('status').value;
	var url = "../SmartHRM?actionS=JobDemand&year="+escape(year)+"&startLetter="+escape(startLetter)+"&month="+month+"&jobgrade="+jobgrade+"&status="+status; 
  	initRequest(url);
    req.onreadystatechange = demandRequest;
    req.open("GET", url, true);
    req.send(null);
}

function demandRequest() 
{
    if(req.readyState == 4) 
    {    
    	ClearTable('demandTable');
    	ClearTabler('totRec');
		  
        if (req.status == 200) 
        {
          demandDetails();
        }
    }
}


function demandDetails() 
{
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];      
	      
	var str=""; 
	var loop;
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	
	str=str+"<tr class='MRow1'>";
	str=str+"<td class='bold1'><div align='center'>S.No</div></td> ";
  	str=str+"<td class='bold1'><div align='center'>Job Grade</div></td> ";
  	str=str+"<td class='bold1'><div align='center'>Job Code</div></td>  ";              
    str=str+"<td class='bold1'><div align='center'>Job Title</div></td> ";
	str=str+"<td class='bold1'><div align='center'>Office</div></td> ";
	str=str+"<td class='bold1'><div align='center'>Posting Date</div></td> ";
	str=str+"<td class='bold1'><div align='center'>Month</div></td> ";
	str=str+"<td class='bold1'><div align='center'>Year</div></td> ";
    str=str+"<td class='bold1'><div align='center'>Demand</div></td> ";                
    str=str+"<td class='bold1'><div align='center'>Entry By</div></td> ";   
    str=str+"<td class='bold1'><div align='center'>Approved</div></td> ";   
      
    str=str+"</tr> ";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var id= batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;  
        var grade= batch.getElementsByTagName("grade")[0].childNodes[0].nodeValue; 
        var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue; 
        var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue; 
        var office= batch.getElementsByTagName("office")[0].childNodes[0].nodeValue; 
        var date = batch.getElementsByTagName("date")[0].childNodes[0].nodeValue; 
        var month= batch.getElementsByTagName("month")[0].childNodes[0].nodeValue; 
        var year= batch.getElementsByTagName("year")[0].childNodes[0].nodeValue; 
        var demand= batch.getElementsByTagName("demand")[0].childNodes[0].nodeValue; 
        var Entry= batch.getElementsByTagName("Entry")[0].childNodes[0].nodeValue;
        var Entryname= batch.getElementsByTagName("Entryname")[0].childNodes[0].nodeValue; 
        var status= batch.getElementsByTagName("status")[0].childNodes[0].nodeValue; 
        var usertype= batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue; 
             
              
       if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
       
       if("N" == status)
   		   str=str+"<td  class='boldEleven'>"+(loop+1)+"<input type='checkbox' name='rowid'  id='rowid'  value='"+id+"'></td>";
       else
    	   str=str+"<td  class='boldEleven'>"+(loop+1)+"</td>";
       str=str+"<td  class='boldEleven'>"+grade+"</td>";
	   
       str=str+"<td   class='boldEleven'>"+code+"</td>";		
	   str=str+"<td class='boldEleven'>"+title+"</td>";		       
	   str=str+"<td   class='boldEleven'>"+office+"</td>";
	   str=str+"<td class='boldEleven'>"+date+"</td>";		
	    str=str+"<td  class='boldEleven'>"+month+"</td>";		       
		str=str+"<td  class='boldEleven'>"+year+"</td>";
		str=str+"<td  class='boldEleven'>"+demand+"</td>";
		str=str+"<td  class='boldEleven'>"+Entry+"/"+Entryname+"</td>";
		if("N" == status)
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		else if("R" == status)
			str=str+"<td  class='boldEleven'><font class='bolddeepred'>Rejected</font></td>";
		else
			str=str+"<td  class='boldEleven'><font class='boldgreen'>Approved</font></td>";
	
	
		
		/*if("N" == status)
			str=str+"<td class='bold1'><a href='DemandAccept.jsp?rowid="+id+"'><font class='boldgreen'>Accept</font></a></td> ";
		else
			str=str+"<td class='bold1'><div align='center'>&nbsp;</div></td> ";
		*/		 
		 
		
     }
     str=str+"</table>";

	 

	document.getElementById('totRec').innerHTML="<font class='bolddeepred'>Total no of Records :: "+loop+"</font>";
     var tb=document.getElementById('demandTable');
  	 tb.innerHTML=str   

 } 
 