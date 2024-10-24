var isIE;
var req;
var names;
 
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


function  loadEmployeeCategory(str) 
{
	var url = "../SmartCommonAjax?actionS=loadEmployeeCategory&str="+str;
	initRequest(url);
	req.onreadystatechange = EmployeeCategoryRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function EmployeeCategoryRequest() 
{
    if(req.readyState == 4) 
    {    	
        
        ClearTable('EmployeeCategoryTable');
        ClearTabler('totrec');
        if (req.status== 200) 
        {		  	
        	EmployeeCategoryMessages();
        }
    }
}

function EmployeeCategoryMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
   
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td   class='boldEleven' align='center'><b>S.NO</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>CATEGORY NAME </b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>ACTIVE</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>ATTENDANCE CYCLE </b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>PF CALCULATION</b></td>";
    str=str+"</tr>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    var Cycle = batch.getElementsByTagName("Cycle")[0].childNodes[0].nodeValue;
	    var Calculation = batch.getElementsByTagName("Calculation")[0].childNodes[0].nodeValue;
	    
	    
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td   class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1);
		str=str+"<td   class='boldEleven'>&nbsp;"+Name+"</td>";
		if(Status == "Y")
			str=str+"<td   class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td   class='boldEleven'><font class='bolddeepred'>Inactive</font></td>";
		str=str+"<td   class='boldEleven'>&nbsp;"+Cycle+"</td>";
		 str=str+"<td   class='boldEleven'>Type-"+Calculation+"</td>";
		 
    }
   
    if(batchs.childNodes.length<1)
     	str=str+"<tr class='MRow1'><td class='bolddeepred'><center>Data not found...</center></td></tr>";
     
    	
    str=str+"</table>";
     var tb=document.getElementById('EmployeeCategoryTable');
  	 tb.innerHTML=str  ; 
 	tb=document.getElementById('totrec');
	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
	 
 	 
  	
}

  