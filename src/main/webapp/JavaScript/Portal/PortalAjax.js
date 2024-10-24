var isIE;
var req;
var names;
var target1;
var ctrl;

function getElementY(element)
{
	var target1Top = 0;
	if (element.offsetParent) 
	{
		while (element.offsetParent) 
		{
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} 
	else if (element.y) 
	{
		target1Top += element.y;
    }
	return target1Top;
}

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

function clearSelect() {
    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];
        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];
        if (element && element.options) {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}

function ClearTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	
	 tb.innerHTML=str     
}

//-------------------------------  Start of UNIQUE CHECK ------------------------------------

function Clear(ctr1)
{
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str;
}

function LoadUniqueCheck(control,div,tablename,fieldname,button) 
{
	var value =document.getElementById(control).value;
	if(!(value==""))
	{
		divname=div;
		buttonname= button;
		var url = "../SmartPortal?actionS=UniqueId&tablename="+escape(tablename);
		url = url +"&fieldname="+fieldname+"&value="+value;

		initRequest(url);
		req.onreadystatechange = UniqueCheckRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }   
}

function UniqueCheckRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear(divname);
		if (req.status == 200) 
    	{		  	
         	UniqueCheckMessages();
        }
    }
}

function UniqueCheckMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById(buttonname).disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById(buttonname).disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
 }


//------------------------------  UNIQUE CHECK END --------------------------------------------




//--------------------------- Raj [15-06-07] ---------- Work Instruction View --------------------------------

function loadWork(startLetter) { 
    var sval=sval;
    var id=document.getElementById('processId').value;   
    var url = "../SmartPortal?actionS=WORK&id="+escape(id)+"&startLetter="+escape(startLetter); 
    initRequest(url);
    req.onreadystatechange = workRequest;
    req.open("GET", url, true);
    req.send(null);
}
function workRequest() 
{
    if(req.readyState == 4) {    
        ClearTables('workTable');
		 document.frmWorkView.bEdit.disabled=true;
		 document.frmWorkView.bDelete.disabled=true;
        if (req.status == 200) {
          workDetails();
        }
    }
}
function workDetails() {
    var batchs = req.responseXML.getElementsByTagName("works")[0];      
    var id=document.getElementById('processId').value;  
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var workId = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;        
        var workName= batch.getElementsByTagName("workName")[0].childNodes[0].nodeValue;        
       if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
		str=str+"<td width='25'><input type='checkbox' name='workId' value='"+workId+"'>"+workId;
		str=str+"<td width='100'>&nbsp;<a href=WorkInstructionEdit.jsp?workId="+workId+"&processId="+id+"><font color='blue'>"+workName+"</font></a>";

		
     }
     str=str+"</table>";
     var tb=document.getElementById('workTable');
  	 tb.innerHTML=str   
  	 str="<font color='red'>Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
	
	if (loop=="0") {
		document.frmWorkView.bEdit.disabled=true;
		document.frmWorkView.bDelete.disabled=true;	
	}else {
		document.frmWorkView.bEdit.disabled=false;
		document.frmWorkView.bDelete.disabled=false;	
	}
 } 	
 
 //---------------------------------------------------------------------------------

function loadProcess(ctr) { 
    var id=document.getElementById('checkId').value;   
    var url = "../SmartPortal?actionS=PROCESS&id="+escape(id); 
    initRequest(url);
    req.onreadystatechange = checkRequest;
    req.open("GET", url, true);
    req.send(null);
}
function checkRequest() 
{
    if(req.readyState == 4) {    
        ClearTables('processTable');
        if (req.status == 200) {
          processDetails();
        }
    }
}
function processDetails() {
    var batchs = req.responseXML.getElementsByTagName("process")[0];      
    var id=document.getElementById('checkId').value;  
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var processId = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;        
        var processName= batch.getElementsByTagName("processName")[0].childNodes[0].nodeValue;        
     
     str=str+processName;
      /* if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
		str=str+"<td width='25'><input type='checkbox' name='processId' value='"+processId+"'>"+processId;
		str=str+"<td width='100'>&nbsp;<a href=WorkInstructionEdit.jsp?workId="+processId+"&processId="+id+"><font color='blue'>"+processName+"</font></a>";
	*/
		
     }
     str=str+"</table>";
     var tb=document.getElementById('processTable');
  	 tb.innerHTML=str   
  	// str="<font color='red'>Total no of Records :: "  + loop+"</font>";
  	 //var tb=document.getElementById('totRec');
  	 //tb.innerHTML=str   
	
	
 } 	
 
//-------------------- Arul :  Process View [15-06-2007] -------------------------------------------
function processview(ctr)
   {

     var url="../SmartPortal?actionS=ProcessView&strartletter="+ctr;
     initRequest(url);
     req.onreadystatechange=process;
     req.open("GET",url,true);
     req.send(null);
   }
   function process()
   {
     if(req.readyState==4)
     {
		ClearTables("pvie");
		
       if(req.status==200)
       {
       
       	var str="<table with='100%' align='center'>";
        var batchs = req.responseXML.getElementsByTagName("pview")[0]; 
        for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
	    var pid=batch.getElementsByTagName("pid")[0].childNodes[0].nodeValue;
	    var pname=batch.getElementsByTagName("pname")[0].childNodes[0].nodeValue;
	    if(loop%2==1)
					str=str+"<tr class='MRow3'>";
				else
		    str=str+"<tr class='MRow2'>";
		    str=str+"<td width='50'><input type='checkbox' name='check' id='check' value='"+pid+"'>"+(loop+1);
		    str=str+"<td width='600'><a href='ProcessEdit.jsp?check="+pid+"'><font color='blue'>"+pname;
	    }
	    str=str+"</table>";
	    var tb=document.getElementById("pvie");
	    tb.innerHTML=str
	    if(loop==0)
	    {
	    document.getElementById('bted').disabled=true;
		document.getElementById('btdel').disabled=true;
	    }
	    else{
	         document.getElementById('bted').disabled=false;
			 document.getElementById('btdel').disabled=false;}
       }
       var tb1=document.getElementById("tnor");
       var str1="<font color='Red'> Total No Of Records :: "+(loop);
       tb1.innerHTML=str1
     }
   }

 