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
  	 tb.innerHTML=str     ;
}


function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str   ;  
}


 
function loadTargetAssign(startletter) 
{
	var yea=document.getElementById('year').value;   
	var office=document.getElementById('office').value;   
	var dept=document.getElementById('dept').value;   
	var url = "../inventory?actionS=INVTargetAssign&year="+escape(yea)+"&office="+office+"&dept="+dept+"&startletter="+startletter;     
   	initRequest(url);
    req.onreadystatechange = TargetAssignRequest;
    req.open("GET", url, true);
    req.send(null);
}
function TargetAssignRequest() {
    if(req.readyState == 4) {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec');
        if (req.status == 200) {		  	
          TargetAssignMessages();
        }
    }
}
function TargetAssignMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr class='MRow1'><td><strong></strong></td>";
         str=str+"<td class='boldEleven'><strong >Empid</strong></td>";
         str=str+"<td class='boldEleven'><strong>APR </strong></td>";
         str=str+"<td class='boldEleven'><strong>MAY</strong></td>";
         str=str+"<td class='boldEleven'><strong>JUN</strong></td>";
         str=str+"<td class='boldEleven'><strong>JUL</strong></td>";
         str=str+"<td class='boldEleven'><strong>AUG</strong></td>";
         str=str+"<td class='boldEleven'><strong>SEP</strong></td>";
         str=str+"<td class='boldEleven'><strong>OCT</strong></td>";
         str=str+"<td class='boldEleven'><strong>NOV</strong></td>";
         str=str+"<td class='boldEleven'><strong>DEC</strong></td>";
         str=str+"<td class='boldEleven'><strong>JAN</strong></td>";
         str=str+"<td class='boldEleven'><strong>FEB</strong></td>";
         str=str+"<td class='boldEleven'><strong>MAR</strong></td>";
         str=str+"<td class='boldEleven'><strong>Total Target(In lakhs)</strong></td>";
 	}
 	else
 	{
 		str = str+"<tr class='MRow1'><td ><span class='bolddeepred'>Data not found...</span></td></tr>"
 	}
 	
 	var sum=0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
    	sum=0;
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0];
        var Staffname = batch.getElementsByTagName("Staffname")[0];
        var APR = batch.getElementsByTagName("APR")[0];
        var MAY = batch.getElementsByTagName("MAY")[0];
        var JUN = batch.getElementsByTagName("JUN")[0];
        var JUL = batch.getElementsByTagName("JUL")[0];
        var AUG = batch.getElementsByTagName("AUG")[0];
        var SEP = batch.getElementsByTagName("SEP")[0];
        var OCT = batch.getElementsByTagName("OCT")[0];
        var NOV = batch.getElementsByTagName("NOV")[0];
        var DEC = batch.getElementsByTagName("DEC")[0];
        var JAN = batch.getElementsByTagName("JAN")[0];
        var FEB = batch.getElementsByTagName("FEB")[0];
        var MAR = batch.getElementsByTagName("MAR")[0];
        var ROW = batch.getElementsByTagName("ROW")[0];
    	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		    
		str=str+"<td><strong><input type='checkbox' id='target' name='target' value='"+ROW.childNodes[0].nodeValue+"'></strong></td>";
		str=str+"<td class='boldEleven'>"+Staffid.childNodes[0].nodeValue +" / "+Staffname.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' align='right'>"+APR.childNodes[0].nodeValue+"</td>";
		sum=sum+parseInt(APR.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+MAY.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(MAY.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+JUN.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(JUN.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+JUL.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(JUL.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+AUG.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(AUG.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+SEP.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(SEP.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+OCT.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(OCT.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+NOV.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(NOV.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+DEC.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(DEC.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+JAN.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(JAN.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+FEB.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(FEB.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+MAR.childNodes[0].nodeValue+"</td>";
        sum=sum+parseInt(MAR.childNodes[0].nodeValue);
        str=str+"<td class='boldEleven' align='right'>"+sum+"</td></tr>";

     }
     str=str+"</table>";
     
     var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 str="<font class='bolddeepred'>Total no of Records :: "  + loop+"</font>";
 	 tb=document.getElementById('totRec');
 	 tb.innerHTML=str 
  	 
}		









var quarter="";
function loadTargetAssignAll() 
{
	var yea=document.getElementById('year').value;   
	var office=document.getElementById('office').value;   
	var dept=document.getElementById('dept').value;  
	var period=document.getElementById('period').value;  
	quarter=period;
	var url = "../inventory?actionS=INVTargetAssignAll&year="+escape(yea)+"&office="+office+"&dept="+dept+"&period="+period;     
   	initRequest(url);
    req.onreadystatechange = TargetAssignAllRequest;
    req.open("GET", url, true);
    req.send(null);
}

function TargetAssignAllRequest() {
    if(req.readyState == 4) {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec');
        if (req.status == 200) {		  	
          TargetAssignAllMessages();
        }
    }
}

function TargetAssignAllMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    var str1=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	if(batchs.childNodes.length>0)
  	{
  		if("5" == quarter)
  		{
  			str=str+"<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No";
  			str=str+"<td class='boldEleven'><b>Emp Id";
  			str=str+"<td class='boldEleven'><b>APR";
  			str=str+"<td class='boldEleven'><b>MAY";
  			str=str+"<td class='boldEleven'><b>JUN";
  			str=str+"<td class='boldEleven'><b>JUL";
  			str=str+"<td class='boldEleven'><b>AUG";
  			str=str+"<td class='boldEleven'><b>SEP";
   			str=str+"<td class='boldEleven'><b>OCT";
  			str=str+"<td class='boldEleven'><b>NOV";
  			str=str+"<td class='boldEleven'><b>DEC";
  			str=str+"<td class='boldEleven'><b>JAN";
  			str=str+"<td class='boldEleven'><b>FEB";
  			str=str+"<td class='boldEleven'><b>MAR";
  			str=str+"<td class='boldEleven'><b>Target(In lak)";
	  		str=str+"<td class='boldEleven'><b>Sales";
	  		str=str+"<td class='boldEleven'><b>Achieve(In lak)";
	  		str=str+"<td class='boldEleven'><b>% of Ach.";
  		}
  		else
  		{
  			str=str+"<tr bgcolor='#ffffff'><td class='boldEleven'><b>S.No";
  			str=str+"<td class='boldEleven'><b>Emp Id";
  			str1="";
  			if("1" == quarter)
  			{
  				str1="";
  				str1=str1+"<td class='boldEleven'><b>APR";
  				str1=str1+"<td class='boldEleven'><b>MAY";
  				str1=str1+"<td class='boldEleven'><b>JUN";
  			}
	  		else if("2" == quarter)
	  		{
	  			str1="";
	  			str1=str1+"<td class='boldEleven'><b>JUL";
	  			str1=str1+"<td class='boldEleven'><b>AUG";
	  			str1=str1+"<td class='boldEleven'><b>SEP";
	  		}
	  		else if("3" == quarter)
	  		{
	  			str1="";
	  			str1=str1+"<td class='boldEleven'><b>OCT";
	  			str1=str1+"<td class='boldEleven'><b>NOV";
	  			str1=str1+"<td class='boldEleven'><b>DEC";
	  		}
	  		else if("4" == quarter)
	  		{
	  			str1="";
	  			str1=str1+"<td class='boldEleven'><b>JAN";
	  			str1=str1+"<td class='boldEleven'><b>FEB";
	  			str1=str1+"<td class='boldEleven'><b>MAR";
	  		}
	  		str=str+str1;
	  		str=str+"<td class='boldEleven'><b>Target(In lak)";
	  		str=str+"<td class='boldEleven'><b>Sales";
	  		str=str+"<td class='boldEleven'><b>Achieve(In lak)";
	  		str=str+"<td class='boldEleven'><b>% of Ach.";
	  	}	
	  		
  	}
  	else
  	{
  		str=str+"<tr bgcolor='#ffffff'><td colspan=9 class='bolddeepred'><center><b>Data not found...</b></center>";
  	}
  	
  	var sum=0;
  	if("5" === quarter)
  	{
  		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	  	    var batch = batchs.childNodes[loop];
	       	var Staffid = batch.getElementsByTagName("Staffid")[0];
	        var Staffname = batch.getElementsByTagName("Staffname")[0];
	        var Month1 = batch.getElementsByTagName("Month1")[0];
	        var Month2 = batch.getElementsByTagName("Month2")[0];
	        var Month3 = batch.getElementsByTagName("Month3")[0];
	        var Month4 = batch.getElementsByTagName("Month4")[0];
	        var Month5 = batch.getElementsByTagName("Month5")[0];
	        var Month6 = batch.getElementsByTagName("Month6")[0];
	        var Month7 = batch.getElementsByTagName("Month7")[0];
	        var Month8 = batch.getElementsByTagName("Month8")[0];
	        var Month9 = batch.getElementsByTagName("Month9")[0];
	        var Month10 = batch.getElementsByTagName("Month10")[0];
	        var Month11 = batch.getElementsByTagName("Month11")[0];
	        var Month12 = batch.getElementsByTagName("Month12")[0];
	        var Target = batch.getElementsByTagName("Target")[0];
	        var Sales = batch.getElementsByTagName("Sales")[0];
	        var achieve = batch.getElementsByTagName("achieve")[0];
	        var percent = batch.getElementsByTagName("percent")[0];
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
			str=str+"<td><strong>"+(loop+1)+"</strong></td>";
			str=str+"<td class='boldEleven'>"+Staffid.childNodes[0].nodeValue +" / "+Staffname.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month1.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+Month2.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month3.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month4.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month5.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month6.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month7.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month8.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month9.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month10.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month11.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month12.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Target.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Sales.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+achieve.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+percent.childNodes[0].nodeValue+"</td>";
    	}
  	}
  	else
  	{
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
    	    var batch = batchs.childNodes[loop];
	        var Staffid = batch.getElementsByTagName("Staffid")[0];
	        var Staffname = batch.getElementsByTagName("Staffname")[0];
	        var Month1 = batch.getElementsByTagName("Month1")[0];
	        var Month2 = batch.getElementsByTagName("Month2")[0];
	        var Month3 = batch.getElementsByTagName("Month3")[0];
	        var Target = batch.getElementsByTagName("Target")[0];
	        var Sales = batch.getElementsByTagName("Sales")[0];
	        var achieve = batch.getElementsByTagName("achieve")[0];
	        var percent = batch.getElementsByTagName("percent")[0];
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
			str=str+"<td><strong>"+(loop+1)+"</strong></td>";
			str=str+"<td class='boldEleven'>"+Staffid.childNodes[0].nodeValue +" / "+Staffname.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month1.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+Month2.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Month3.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Target.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+Sales.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+achieve.childNodes[0].nodeValue+"</td>";
	        str=str+"<td class='boldEleven' align='right'>"+percent.childNodes[0].nodeValue+"</td>";
	     }
	 }    
     str=str+"</table>";
     var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 
  	str="<font class='bolddeepred'>Total no of Records :: "  + loop+"</font>";
	 tb=document.getElementById('totRec');
	 tb.innerHTML=str 
}		
 








function loadTargetAssignMonth() 
{
	var yea=document.getElementById('year').value;   
	var office=document.getElementById('office').value;   
	var dept=document.getElementById('dept').value;   
	var month=document.getElementById('month').value;   
	var url = "../inventory?actionS=INVTargetAssignMonth&year="+escape(yea)+"&office="+office+"&dept="+dept+"&month="+month;     
   	initRequest(url);
    req.onreadystatechange = TargetAssignMonthRequest;
    req.open("GET", url, true);
    req.send(null);
}
function TargetAssignMonthRequest() 
{
    if(req.readyState == 4) 
    {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec');
        if (req.status == 200) 
        {		  	
          TargetAssignMonthMessages();
        }
    }
}

function TargetAssignMonthMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr bgcolor='#ffffff'><td colspan=6 class='boldEleven'><b><center>"+getMonthCharacter(document.getElementById('month').value)+" - Report </center></b></td>";
    	 str=str+"<tr class='MRow1'><td><strong></strong></td>";
         str=str+"<td class='boldEleven'><strong >Empid</strong></td>";
         str=str+"<td class='boldEleven'><strong>Target (In Lak)</strong></td>";
         str=str+"<td class='boldEleven'><strong>Sales</strong></td>";
         str=str+"<td class='boldEleven'><strong>Achieve (In Lak)</strong></td>";
         str=str+"<td class='boldEleven'><strong>% of Ach.</strong></td>";
 	}
 	else
 	{
 		str = str+"<tr bgcolor=#ffffff><td ><span class='bolddeepred'><center>Data not found...</center></span></td></tr>"
 	}
 	
 	var sum=0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0];
        var Staffname = batch.getElementsByTagName("Staffname")[0];
        var Target = batch.getElementsByTagName("Target")[0];
        var Sales = batch.getElementsByTagName("Sales")[0];
        var achieve = batch.getElementsByTagName("achieve")[0];
        var percent = batch.getElementsByTagName("percent")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td><strong>"+(loop+1)+"</strong></td>";
		str=str+"<td class='boldEleven'>"+Staffid.childNodes[0].nodeValue +" / "+Staffname.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven' align='right'>"+Target.childNodes[0].nodeValue+"</td>";
        str=str+"<td class='boldEleven' align='right'>"+Sales.childNodes[0].nodeValue+"</td>";
        str=str+"<td class='boldEleven' align='right'>"+achieve.childNodes[0].nodeValue+"</td>";
        str=str+"<td class='boldEleven' align='right'>"+percent.childNodes[0].nodeValue+"</td>";
     }
     str=str+"</table>";
     var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 str="<font class='bolddeepred'>Total no of Records :: "  + loop+"</font>";
	 tb=document.getElementById('totRec');
	 tb.innerHTML=str 
}		


 


var pperiod="";
function loadTargetAssignCGroup() 
{
	var yea=document.getElementById('year').value;   
	var Branch=document.getElementById('Branch').value;   
	var period=document.getElementById('period').value;  
	var division=document.getElementById('division').value;  
	 
	pperiod= period;
	var url = "../inventory?actionS=INVTargetAssignCGroup&year="+escape(yea)+"&Branch="+Branch+"&period="+period+"&division="+division;     
	initRequest(url);
    req.onreadystatechange = TargetAssignCGroupRequest;
    req.open("GET", url, true);
    req.send(null);
}
function TargetAssignCGroupRequest() 
{
    if(req.readyState == 4) {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec');
       
        if (req.status == 200) {		  	
          TargetAssignCGroupMessages();
        }
    }
}
function TargetAssignCGroupMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("TargetAssigns")[0];   	    
    var xloop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    var str1="";
    if("1" === pperiod)
    {
     	str1=str1+"<td class='boldEleven'><strong>APR</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>MAY</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>JUN</strong></td>";
    }
    else if("2" === pperiod)
    {
     	str1=str1+"<td class='boldEleven'><strong>JUL</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>AUG</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>SEP</strong></td>";
    }
    else if("3" === pperiod)
    {
     	str1=str1+"<td class='boldEleven'><strong>OCT</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>NOV</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>DEC</strong></td>";
    }
    else if("4" === pperiod)
    {
     	str1=str1+"<td class='boldEleven'><strong>JAN</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>FEB</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>MAR</strong></td>";
    }
    else if("5" === pperiod)
    {
     	str1=str1+"<td class='boldEleven'><strong>APR</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>MAY</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>JUN</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>JUL</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>AUG</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>SEP</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>OCT</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>NOV</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>DEC</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>JAN</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>FEB</strong></td>";
        str1=str1+"<td class='boldEleven'><strong>MAR</strong></td>";
    }
    
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr class='MRow1'><td><strong></strong></td>";
         str=str+"<td class='boldEleven'><strong >Group Name</strong></td>";
         str=str+str1;
         str=str+"<td class='boldEleven'><strong>Total Sales </strong></td>";
 	}
 	else
 	{
 		str = str+"<tr bgcolor=#ffffff><td ><span class='bolddeepred'><center>Data not found...</center></span></td></tr>"
 	}
 	
 	if("5" != pperiod)
 	{
 		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Cgroup = batch.getElementsByTagName("Cgroup")[0];
        	var Cgroupname = batch.getElementsByTagName("Cgroupname")[0];
        	var Month1 = batch.getElementsByTagName("Month1")[0];
        	var Month2 = batch.getElementsByTagName("Month2")[0];
        	var Month3 = batch.getElementsByTagName("Month3")[0];
        	var Target = batch.getElementsByTagName("Target")[0];
        	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
		    	str=str+"<tr  class='MRow2'>";		
			str=str+"<td><strong>"+(loop+1)+"</strong></td>";
		
			str=str+"<td class='boldEleven'>"+Cgroupname.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month1.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month2.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month3.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Target.childNodes[0].nodeValue+"</td>";
     	}
     }
     else
     {
     	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Cgroup = batch.getElementsByTagName("Cgroup")[0];
        	var Cgroupname = batch.getElementsByTagName("Cgroupname")[0];
        	var Month1 = batch.getElementsByTagName("Month1")[0];
        	var Month2 = batch.getElementsByTagName("Month2")[0];
        	var Month3 = batch.getElementsByTagName("Month3")[0];
        	var Month4 = batch.getElementsByTagName("Month4")[0];
        	var Month5 = batch.getElementsByTagName("Month5")[0];
        	var Month6 = batch.getElementsByTagName("Month6")[0];
        	var Month7 = batch.getElementsByTagName("Month7")[0];
        	var Month8 = batch.getElementsByTagName("Month8")[0];
        	var Month9 = batch.getElementsByTagName("Month9")[0];
        	var Month10 = batch.getElementsByTagName("Month10")[0];
        	var Month11 = batch.getElementsByTagName("Month11")[0];
        	var Month12 = batch.getElementsByTagName("Month12")[0];
        	var Target = batch.getElementsByTagName("Target")[0];
        	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
		    	str=str+"<tr  class='MRow2'>";		
			str=str+"<td><strong>"+(loop+1)+"</strong></td>";
		
			str=str+"<td class='boldEleven'>"+Cgroupname.childNodes[0].nodeValue;
					str=str+"<td class='boldEleven' align='right'>"+Month4.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month5.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month6.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month7.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month8.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month9.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month10.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month11.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month12.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month1.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month2.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month3.childNodes[0].nodeValue;
	
			str=str+"<td class='boldEleven' align='right'>"+Target.childNodes[0].nodeValue+"</td>";
     	}
     }	
     
     str=str+"</table>";
     var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 
  	str="<font class='bolddeepred'>Total no of Records :: "  + loop+"</font>";
	 tb=document.getElementById('totRec');
	 tb.innerHTML=str 
}		


