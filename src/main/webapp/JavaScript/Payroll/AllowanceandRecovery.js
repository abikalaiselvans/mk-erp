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
 

function loadAllowRecvs(startLetter) 
{
    var Search =document.getElementById('Search').value;
    var Office =document.getElementById('Office').value;
    searchname=Search.toUpperCase(); 
    var url = "../Payroll?actionS=PAYAllowRecov&Search="+Search+"&startLetter="+startLetter;
    url = url+"&Office="+Office;
	initRequest(url);
    req.onreadystatechange = loadAllowanceRequest;
    req.open("GET", url, true);
    req.send(null);
}



function loadAllowRecv(startLetter) 
{
    var Office =document.getElementById('Office').value;
    var url = "../Payroll?actionS=PAYAllowRecov&Search=0&startLetter="+startLetter;
    url = url+"&Office="+Office;
	initRequest(url);
    req.onreadystatechange = loadAllowanceRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadAllowanceRequest() 
{
	ClearTable('AllowRecv');
	ClearTabler('totrec');
    if(req.readyState == 4) {    	
           
       if (req.status == 200) {		  	
          loadAllowanceMessages();
        }
    }
}

function loadAllowanceMessages() 
{  
    var loop=0;
  	var batchs = req.responseXML.getElementsByTagName("Rows")[0];
	var str="";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	var tot = batchs.childNodes.length;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
	{           		                           
	    var batch1 = batchs.childNodes[loop];
        var Staffid = batch1.getElementsByTagName("Staffid")[0]; 
    	var Staffname = batch1.getElementsByTagName("Staffname")[0];
    	var all = batch1.getElementsByTagName("Allow")[0];
    	var rec = batch1.getElementsByTagName("Recv")[0];  
    	var Basic = batch1.getElementsByTagName("Basic")[0];  
    	var Allowance = batch1.getElementsByTagName("Allowance")[0];  
    	var Gross = batch1.getElementsByTagName("Gross")[0]; 
    	var usertype = batch1.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
    	
    	if(all.childNodes[0].nodeValue == "N")  	
    	{
    		str=str+"<tr class='MRow3'>";
    	}
    	else
    	{
    		if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
		    	str=str+"<tr  class='MRow1'>";
		}
		
		var s = Staffname.childNodes[0].nodeValue;
		if(searchname !="")
		{
			s=s.replace(searchname,"9865043008");
			s = s.replace("9865043008","<font class='search' ><b>"+searchname+"</b></font>");
			
		}
		
		
		str=str+"<td width='100'  class='boldEleven'>&nbsp;<input type='checkbox' name='staffid' id='staffid' value='"+Staffid.childNodes[0].nodeValue+"'>&nbsp;"+Staffid.childNodes[0].nodeValue;
		var js ="<a href=javascript:AllowanceAdd('"+escape(Staffid.childNodes[0].nodeValue)+"') ><font class='boldgreen'>"+ s +"</font></a> "  ;
		
		if( (usertype == "B") ||  (usertype == "F") )
			str=str+"<td width='100' class='boldEleven'>&nbsp;"+js+"</td>";
		else
			str=str+"<td width='100' class='boldEleven'>&nbsp;"+Staffid.childNodes[0].nodeValue+"</td>";
			
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+all.childNodes[0].nodeValue+"</td>";
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+rec.childNodes[0].nodeValue+"</td>";
		str=str+"<td width='100' class='boldEleven' align='right'>&nbsp;"+Basic.childNodes[0].nodeValue+"</td>";
		str=str+"<td width='100' class='boldEleven' align='right'>&nbsp;"+Allowance.childNodes[0].nodeValue+"</td>";
		str=str+"<td width='100' class='boldEleven' align='right'>&nbsp;"+Gross.childNodes[0].nodeValue+"</td>";
		str=str+"</tr>";
		
	}
	str=str+"</table>";
	var tb=document.getElementById('AllowRecv');
  	tb.innerHTML=str;  
  	
   tb=document.getElementById('totrec');
 	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
 	   
  	 	
}

  