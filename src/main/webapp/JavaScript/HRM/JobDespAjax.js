

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

function clearSelect() 
{
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

//----------------------------JobDespView and JobSpecificView------------------------------
 
function loadJobCodeView(startLetter) {   
    var id=document.getElementById('jobGrade').value;
    var url = "../SmartHRM?actionS=JobGrade&id="+escape(id)+"&startLetter="+escape(startLetter); 
    initRequest(url);
    req.onreadystatechange = jobRequestView;
    req.open("GET", url, true);
    req.send(null);
}
function jobRequestView() 
{
    if(req.readyState == 4) {    
        ClearTables('jobTable');
        document.getElementById('action1').disabled=true;
        if (req.status == 200) {
	          jobDetailsView();
        }
        else
        {
    	    var str="Total no of Records :: 0";
	  		 var tb=document.getElementById('totRec');
	  		tb.innerHTML=str   
        }
    }
}


function jobDetailsView() 
{
    var batchs = req.responseXML.getElementsByTagName("jobs")[0];      
	var str=""; 
	var disp = batchs.childNodes.length;
	if(batchs.childNodes.length<1)
		document.getElementById('action1').disabled=true;
	else
	{
		document.getElementById('action1').disabled=false;	
		var tb=document.getElementById('jobTable');
  	 	tb.innerHTML="Record not found...";  
	}	
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var jobId = batch.getElementsByTagName("id")[0];  
        var jobCode= batch.getElementsByTagName("code")[0];        
        var title = batch.getElementsByTagName("name")[0];    
        var grade = batch.getElementsByTagName("grade")[0]; 
           
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
			str=str+"<td width='90px' align=left class='boldEleven'><input type='checkbox' id='jobCode' name='jobCode' value='"+jobId.childNodes[0].nodeValue+"'>"+(loop+1);
			str=str+"<td width='90px' align=left class='boldEleven'>";
			str=str+"<a href=JobDespView.jsp?action1=view&jobCode="+jobId.childNodes[0].nodeValue+"><font color='blue'>"+jobCode.childNodes[0].nodeValue+"</font></a>";
			str=str+"<td width='90px' align=left class='boldEleven'>"+title.childNodes[0].nodeValue;
			str=str+"<td width='90px' align=left class='boldEleven'>"+grade.childNodes[0].nodeValue+" Management ";
			str=str+"</td></tr>";
     }
     str=str+"</table>";
  
    var tb=document.getElementById('jobTable');
  	 tb.innerHTML=str   

	var str="Total no of Records :: "+disp;
	 	 var tb=document.getElementById('totRec');
  		tb.innerHTML=str   
 } 	



//-------------------------------HRMInductionView----------------------------------------

function loadTitleValues(dval) 
{
	var titleId=dval.value;   
	var url = "../SmartHRM?actionS=JobTitle&id="+escape(titleId);
	initRequest(url);
    req.onreadystatechange = titleValueRequest;
    req.open("GET", url, true);
    req.send(null);
}

function titleValueRequest() 
{
    if (req.readyState == 4) 
    {
       	clearSelect('title');
        if (req.status == 200) 
        {
          titleValueMessages();
        } 
    }
}


function titleValueMessages() 
{
    	var batch = req.responseXML.getElementsByTagName("titles")[0];
    	var _targ=document.getElementsByName('title')[0];
        var titleName = batch.getElementsByTagName("titleName")[0];        
        var titleId = batch.getElementsByTagName("id")[0];
   		var titleGrade = batch.getElementsByTagName("titleGrade")[0];
   		var titlePurpose = batch.getElementsByTagName("titlePurpose")[0];
   		var titleDuty = batch.getElementsByTagName("titleDuty")[0];
   		var titleAuth = batch.getElementsByTagName("titleAuth")[0];
   		var titlePromotion = batch.getElementsByTagName("titlePromotion")[0];
   		var titleHaz = batch.getElementsByTagName("titleHaz")[0];
   		var titleReport = batch.getElementsByTagName("titleReport")[0];
   		var titleResponse = batch.getElementsByTagName("titleResponse")[0];
   		var titleScale = batch.getElementsByTagName("titleScale")[0];
   		var titleDA = batch.getElementsByTagName("titleDA")[0];
   		var titleHRA = batch.getElementsByTagName("titleHRA")[0];
   
   		document.getElementById('title').value=titleName.childNodes[0].nodeValue;
   		document.getElementById('grade').value=titleGrade.childNodes[0].nodeValue;
   		document.getElementById('purpose').value=titlePurpose.childNodes[0].nodeValue;
   		document.getElementById('duties').value=titleDuty.childNodes[0].nodeValue;
   		document.getElementById('authority').value=titleAuth.childNodes[0].nodeValue;
   		document.getElementById('promotion').value=titlePromotion.childNodes[0].nodeValue;
   		document.getElementById('hazards').value=titleHaz.childNodes[0].nodeValue;
   		document.getElementById('report').value=titleReport.childNodes[0].nodeValue;
   		document.getElementById('response').value=titleResponse.childNodes[0].nodeValue;
		document.getElementById('scale').value=titleScale.childNodes[0].nodeValue;
		document.getElementById('DA').value=titleDA.childNodes[0].nodeValue;
		document.getElementById('HRA').value=titleHRA.childNodes[0].nodeValue;
}

 



function loadJobCode(startLetter) 
{  
    var id=document.getElementById('jobGrade').value;
    var url = "../SmartHRM?actionS=JobGrade&id="+escape(id)+"&startLetter="+escape(startLetter); 
    initRequest(url);
    req.onreadystatechange = jobReq;
    req.open("GET", url, true);
    req.send(null);
}

function jobReq() 
{
    if(req.readyState == 4) 
    {    
        ClearTables('jobTable');
        if (req.status == 200) 
        {
	          jobDet();
        }
        else
        {
    	    var str=" Total no of Records :: 0";
	  		 var tb=document.getElementById('totRec');
	  		tb.innerHTML=str   
        }
    }
}




function jobDet() 
{
    var batchs = req.responseXML.getElementsByTagName("jobs")[0];      
	var str=""; 
	var disp = batchs.childNodes.length;
    str=str+"<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var jobId = batch.getElementsByTagName("id")[0];  
        var jobCode= batch.getElementsByTagName("code")[0];        
        var title = batch.getElementsByTagName("name")[0];    
        var grade = batch.getElementsByTagName("grade")[0]; 
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		    str=str+"<td width='90px' align=left class='boldEleven'><input type='checkbox' name='jobCode' value='"+jobId.childNodes[0].nodeValue+"'>"+(loop+1);			
			str=str+"<td width='140px' align=left class='boldEleven'>";
			str=str+"<a href=JobSpecificView.jsp?action1=view&jobCode="+jobId.childNodes[0].nodeValue+"><font color='blue'>"+jobCode.childNodes[0].nodeValue+"</font></a>";
			str=str+"<td width='40px' align=left class='boldEleven'>"+title.childNodes[0].nodeValue;
			str=str+"<td width='40px' align=left class='boldEleven'>"+grade.childNodes[0].nodeValue+" Management";
			str=str+"</td></tr>";
     }
     
     str=str+"</table>";
     var tb=document.getElementById('jobTable');
  	 tb.innerHTML=str   
     var str=" <font color='red'>Total no of Records :: "+disp+"</font>";
	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
 } 	

