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
	 var str="<font class='boldEleven'><font color='Red'><center><b> Data not found...</b></font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

function ClearTable(ctr1)
{
	 var str="<font class='boldEleven'><font color='Red'><center><b> Data not found...</b></font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}
//---------------------------Elamparithi------------------------------------------------
function loadJobCode(startLetter) { 
    var sval=sval;
    var id=document.getElementById('jobId').value;   
    var url = "../SmartHRM?actionS=JobCode&id="+escape(id)+"&startLetter="+escape(startLetter); 

    initRequest(url);
    req.onreadystatechange = jobRequest;
    req.open("GET", url, true);
    req.send(null);
}
function jobRequest() 
{
    if(req.readyState == 4) {    
        ClearTables('jobTable');
        if (req.status == 200) {
          jobDetails();
        }
    }
}
function jobDetails() {
    var batchs = req.responseXML.getElementsByTagName("jobs")[0];      
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var jobId = batch.getElementsByTagName("id")[0];        
       if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
		str=str+"<td width='10px'><input type='checkbox' name='jobId' value='"+jobId.childNodes[0].nodeValue+"'>"+jobId.childNodes[0].nodeValue;
		
     }
     str=str+"</table>";
     var tb=document.getElementById('jobTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
 } 	
 
 //---------------------------------------------------------------------------------
 
/*
 function loadComboJobValues(dval) {	
    id=dval.value;  
	startLetter="";       
    var url = "../SmartHRM?actionS=JobCode&id="+escape(id)+"&startLetter="+escape(startLetter); 
    initRequest(url);    
    req.onreadystatechange = jobComboValueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function jobComboValueRequest() {
    if (req.readyState == 4) {
       	clearSelect('jobTitle');
        if (req.status == 200) {
          jobComboValueMessages();
        } 
    }
}
function jobComboValueMessages() {

     var batchs = req.responseXML.getElementsByTagName("jobs")[0];    		 
     var _targ=document.getElementsByName('jobTitle')[0];
     if (batchs.childNodes.length==0)
     {
     	alert("All the Job Requirements for this Grade Already Added"); 
     	document.getElementsByName('jobTitle')[0].disabled=true;
     	document.getElementsByName('jobid')[0].focus();
     }
	 else
	      	document.getElementsByName('jobTitle')[0].disabled=false;	     

     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
	     var batchId=batch.getElementsByTagName("id")[0];     
        var firstName = batch.getElementsByTagName("name")[0];   
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
     //_targ.onchange();	
}

*/
function loadComboJobValues(dval) {	
    id=dval.value;  
	var url = "../SmartHRM?actionS=JobCodes&id="+escape(id); 
    initRequest(url);    
    req.onreadystatechange = jobComboValueRequest;
    req.open("GET", url, true);
    req.send(null);
}

function jobComboValueRequest() 
{
    if (req.readyState == 4) 
    {
       	 
       	 var _targ=document.getElementsByName('jobTitle')[0];       
	    _targ.options.length=0;
	    _targ.options[0]=new Option('Select','0');  
        
        if (req.status == 200) 
        {
          jobComboValueMessages();
        } 
    }
}
var loop;
function jobComboValueMessages() 
{
	
     var batchs = req.responseXML.getElementsByTagName("jobs")[0];    		 
     var _targ=document.getElementsByName('jobTitle')[0];
     if (batchs.childNodes.length==0)
     {
     	alert("All the Job Requirements for this Grade Already Added"); 
     	document.getElementsByName('jobTitle')[0].disabled=true;
     	document.getElementsByName('jobid')[0].focus();
     }
	 else
	      	document.getElementsByName('jobTitle')[0].disabled=false;	
	      	
	      	     

     for (loop = 0; loop < batchs.childNodes.length; loop++) 
     {
	    var batch = batchs.childNodes[loop];
	    var batchId=batch.getElementsByTagName("id")[0];     
        var firstName = batch.getElementsByTagName("name")[0];   
        _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     
     
     //_targ.options.length=loop;
     
}

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
//---------------------------- For HRM_Demand Add --------- loadDemandJobGrade()-----------------
//------------------------------------------------------------------------------------------
//-------------------------- P. Rajan [24-05-2007] ------------------------------------------- 
 
 function loadDemandJobGrade(dval) {	
    id=dval.value;  
    startLetter="";       
    var url = "../SmartHRM?actionS=DemandJobGrade&id="+escape(id)+"&startLetter="+escape(startLetter); 

    initRequest(url);    
    req.onreadystatechange = comboDemandGrade;
    req.open("GET", url, true);
    req.send(null);
}
function comboDemandGrade() {
    if (req.readyState == 4) {
       	clearSelect('jobTitle');
        if (req.status == 200) {
          demandGradeMsg();
        } 
    }
}
function demandGradeMsg(){

     var batchs = req.responseXML.getElementsByTagName("jobs")[0];    		 
     var _targ=document.getElementsByName('jobTitle')[0];
     if (batchs.childNodes.length==0)
     {
     	alert("All Job titles for this Job Grade Already Added."); 
     	document.getElementsByName('jobTitle')[0].disabled=true;
     	document.getElementsByName('jobid')[0].focus();
     	document.getElementById('submit').disabled=true;
     	
     }
	 else
	 {
	   	document.getElementsByName('jobTitle')[0].disabled=false;	     
     	document.getElementById('submit').disabled=false;	   	
	 }
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
	     var batchId=batch.getElementsByTagName("id")[0];     
        var firstName = batch.getElementsByTagName("name")[0];   
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
     //_targ.onchange();	
}
 
//---------------------------Elamparithi------------------------------------------------

/*
function loadDemand(startLetter) {    
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;        
    var url = "../SmartHRM?actionS=JobDemand&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter); 
  	initRequest(url);
    req.onreadystatechange = demandRequest;
    req.open("GET", url, true);
    req.send(null);
}
function demandRequest() 
{
    if(req.readyState == 4) {    
        ClearTables('demandTable');
        if (req.status == 200) {
          demandDetails();
        }
    }
}
function demandDetails() {
    var batchs = req.responseXML.getElementsByTagName("Demands")[0];      
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var id= batch.getElementsByTagName("id")[0];  
          var grade= batch.getElementsByTagName("grade")[0]; 
            var code = batch.getElementsByTagName("code")[0]; 
              var title= batch.getElementsByTagName("title")[0]; 
                  var demand= batch.getElementsByTagName("ndemand")[0]; 
              
       if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		    str=str+"<td width='50' class='boldEleven'><input type='checkbox' name='jobId' value='"+id.childNodes[0].nodeValue+"'>"+grade.childNodes[0].nodeValue;	
		    //str=str+"<td width='50' class='boldEleven'><input type='checkbox' name='jobId' value='"+id.childNodes[0].nodeValue+"'>";	
		    //str=str+"<a href=DemandAction.jsp?action=Edit&jobId="+id.childNodes[0].nodeValue+">"+grade.childNodes[0].nodeValue+"</a>";
		    
		    str=str+"<td width='100' class='boldEleven'>"+code.childNodes[0].nodeValue;		
		    str=str+"<td width='100' class='boldEleven'>"+title.childNodes[0].nodeValue;		       
		str=str+"<td width='100px'>"+demand.childNodes[0].nodeValue;
		
     }
     str=str+"</table>";
     var tb=document.getElementById('demandTable');
  	 tb.innerHTML=str   

 } 
*/

//------------------------------
function loadApplication(startLetter) {    
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;        
    var url = "../SmartHRM?actionS=JobApplication&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter); 
   	initRequest(url);
    req.onreadystatechange = applicationRequest;
    req.open("GET", url, true);
    req.send(null);
}
function applicationRequest() 
{
    if(req.readyState == 4) {    
        ClearTable('applicationTable');

        if (req.status == 200) {

			var ebutton = document.getElementById('Edit');
			var dbutton = document.getElementById('Delete');
			ebutton.disabled=false;
			dbutton.disabled=false;

            applicationDetails();
        }
		else
		{
			var ebutton = document.getElementById('Edit');
			var dbutton = document.getElementById('Delete');
			ebutton.disabled=true;
			dbutton.disabled=true;
		}
		
    }
}
function applicationDetails() {
    var batchs = req.responseXML.getElementsByTagName("Applications")[0];      
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";

	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var id= batch.getElementsByTagName("id")[0];  
          var grade= batch.getElementsByTagName("grade")[0]; 
            var code = batch.getElementsByTagName("code")[0]; 
              var title= batch.getElementsByTagName("title")[0]; 
                  var name= batch.getElementsByTagName("name")[0]; 
                   var dt= batch.getElementsByTagName("dt")[0];               
                   var appcode = batch.getElementsByTagName("appcode")[0];

       if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr  class='MRow2'>";	

	    str=str+"<td align='left' width='90' class='boldEleven'>";
	    str=str+"<input type='checkbox' name='OptAppId' value='"+id.childNodes[0].nodeValue+"'>&nbsp;";
		str=str+"<a href=ApplicationEdit.jsp?OptAppId="+id.childNodes[0].nodeValue+">"+appcode.childNodes[0].nodeValue+"</a>";  
		str=str+"<td align='left' width='120px'>&nbsp;"+name.childNodes[0].nodeValue;
		str=str+"<td align='left' width='100'>&nbsp;"+code.childNodes[0].nodeValue;
		str=str+"<td align='left' width='100' class='boldEleven'>&nbsp;"+grade.childNodes[0].nodeValue;		
	    str=str+"<td align='left' width='100' class='boldEleven'>&nbsp;"+title.childNodes[0].nodeValue;		       
     }

     str=str+"</table>";
     var tb=document.getElementById('applicationTable');
  	 tb.innerHTML=str   
	
	
 
 } 	
 
 
//-------------------- Unique------------
 
function chkUnique(ctr) {

	var pass=ctr.value;
    var url = "../SmartHRM?actionS=Unique&ID="+pass;

    initRequest(url);
    req.onreadystatechange = uniqueRequest;
    req.open("GET", url);
    req.send(null);
}

function uniqueRequest() 
{
    if(req.readyState == 4) {    

        if (req.status == 200) {
			var result = req.responseText;
			var tb = document.getElementById('DivAppCode');
			var sbutton = document.getElementById('submit_btn');
			var pbutton = document.getElementById('Pho_Button');
			if (result=="Valid Name")
			{
				tb.style.color="Green";
				sbutton.disabled=false;
				pbutton.disabled=false;				
			}				
			else
			{
				tb.style.color="Red";
				sbutton.disabled=true;
				pbutton.disabled=true;
			}
			tb.innerHTML = result;
        }
    }
}
 
//------------------------ For Performance View  (loadPerformance) --------------

/*
function loadPerformance(startLetter) {    	
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;        
    var url = "../SmartHRM?actionS=JobPerformance&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter); 
   
   	initRequest(url);
    req.onreadystatechange = performViewRequest;
    req.open("GET", url, true);
    req.send(null);
}
function performViewRequest() 
{
    if(req.readyState == 4) {  
		ClearTables('performanceTable');
        
        if (req.status == 200) {

	         performanceDetails();

        }
    }
}
function performanceDetails() {
    var batchs = req.responseXML.getElementsByTagName("Performances")[0];      


	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";

	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var appid= batch.getElementsByTagName("appid")[0].childNodes[0].nodeValue;  
        var status= batch.getElementsByTagName("status")[0].childNodes[0].nodeValue; 
        var appcode = batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue; 
        var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue; 
        var grade= batch.getElementsByTagName("grade")[0].childNodes[0].nodeValue; 
        var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue; 
        var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue; 
  		
  		if (status=="Q")
  			status="Qualified";
  		else
			status="Not Qualified";
			
       if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr class='MRow2'>";	

	    str=str+"<td width='50' class='boldEleven'><input type='checkbox' name='appId' value='"+appid+"'>&nbsp;"
	    str = str + "<a href=PerformanceEdit.jsp?appId="+appid+">"+grade+"</a>";	
		str=str+"<td width='100px' class='boldEleven'>&nbsp;"+appcode;
		str=str+"<td width='130px' class='boldEleven'>&nbsp;"+name;
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+title;		       
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+code;		
  		str=str+"<td width='100' class='boldEleven'>&nbsp;"+status;		

     }
     str=str+"</table>";
//  	alert(str);
     var tb=document.getElementById('performanceTable');
  	 tb.innerHTML=str   
    
  		 
 } 	
*/

function loadPerformance(startLetter) {    	
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;        
    var url = "../SmartHRM?actionS=JobPerformance&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter); 
   
   	initRequest(url);
    req.onreadystatechange = performViewRequest;
    req.open("GET", url, true);
    req.send(null);
}
function performViewRequest() 
{
    if(req.readyState == 4) {  
		ClearTables('performanceTable');
		document.getElementById('edit').disabled=true;
		document.getElementById('delete').disabled=true;
		
		document.getElementById('noId').innerHTML="<font color='red' >Total no of Records :: 0</font>";

		
        if (req.status == 200) {

	         performanceDetails();

        }
    }
}
function performanceDetails() {
    var batchs = req.responseXML.getElementsByTagName("Performances")[0];      


	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";

	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var appid= batch.getElementsByTagName("appid")[0].childNodes[0].nodeValue;  
        var status= batch.getElementsByTagName("status")[0].childNodes[0].nodeValue; 
        var appcode = batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue; 
        var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue; 
        var grade= batch.getElementsByTagName("grade")[0].childNodes[0].nodeValue; 
        var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue; 
        var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue; 
        var Appionment= batch.getElementsByTagName("Appionment")[0].childNodes[0].nodeValue; 
        
  		var st="";
  		st=status;
  		if (status=="Q")
  			status="Qualified";
  		else
			status="Not Qualified";
			
       if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr class='MRow2'>";	

	    str=str+"<td width='160' class='boldEleven'>";
	    if((Appionment	!= "Y") )
	    {
	    	str=str+"<input type='checkbox' name='appId' value='"+appid+"'>&nbsp;"
	    	str = str + "<a href=PerformanceEdit.jsp?appId="+appid+"><font class='boldEleven'><font color='blue'>"+grade+" Management</font>";	
	    }
	    else
	    {
	    	str = str + "<font class='boldEleven'><font color='blue'>"+grade+" Management</font>";
	    }	
		str=str+"<td width='100px' class='boldEleven'>&nbsp;"+appcode;
		str=str+"<td width='130px' class='boldEleven'>&nbsp;"+name;
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+title;		       
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+code;		
  		str=str+"<td width='100' class='boldEleven'>&nbsp;"+status;	
  		if((Appionment== "Y") )
  			str=str+"<td width='100' class='boldEleven'><font class='bold1'>Issued</font>" ;	
  		else
  			str=str+"<td width='100' class='boldEleven'><font class='bolddeepred'>Not Issued</font>" ;	

     }
     str=str+"</table>";
//  	alert(str);
     var tb=document.getElementById('performanceTable');
  	 tb.innerHTML=str   
	
	if (loop>0)    
	{
		document.getElementById('edit').disabled=false;
		document.getElementById('delete').disabled=false;
	}

	document.getElementById('noId').innerHTML="<font color='red'>Total no of Records :: "+loop+"</font>";		
  		 
 } 	
 
//--------------------------------------------
 
function loadPerformanceView(startLetter) {    	
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;        
    var url = "../SmartHRM?actionS=JobPerformance&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter); 
   
   	initRequest(url);
    req.onreadystatechange = performView1Request;
    req.open("GET", url, true);
    req.send(null);
}
function performView1Request() 
{
    if(req.readyState == 4) {  
		ClearTables('performanceTable');
		document.getElementById('edit').disabled=true;
		document.getElementById('noId').innerHTML="<font color='red' >Total no of Records :: 0</font>";

		
        if (req.status == 200) {

	         performance1Details();

        }
    }
}
function performance1Details() {
    var batchs = req.responseXML.getElementsByTagName("Performances")[0];      


	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";

	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var appid= batch.getElementsByTagName("appid")[0].childNodes[0].nodeValue;  
        var status= batch.getElementsByTagName("status")[0].childNodes[0].nodeValue; 
        var appcode = batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue; 
        var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue; 
        var grade= batch.getElementsByTagName("grade")[0].childNodes[0].nodeValue; 
        var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue; 
        var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue; 
  		
  		if (status=="Q")
  			status="Qualified";
  		else
			status="Not Qualified";
			
       if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr class='MRow2'>";	

	    str=str+"<td width='160' class='boldEleven'><input type='checkbox' name='appId' value='"+appid+"'>&nbsp;"
	    str = str + "<a href=PerofrmanceDetails.jsp?appId="+appid+"><font class='boldEleven'><font color='blue'>"+grade+" Management</font>";	
		str=str+"<td width='100px' class='boldEleven'>&nbsp;"+appcode;
		str=str+"<td width='130px' class='boldEleven'>&nbsp;"+name;
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+title;		       
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+code;		
  		str=str+"<td width='100' class='boldEleven'>&nbsp;"+status;		

     }
     str=str+"</table>";
//  	alert(str);
     var tb=document.getElementById('performanceTable');
  	 tb.innerHTML=str   
	
	if (loop>0)    
	{
		document.getElementById('edit').disabled=false;
		
	}

	document.getElementById('noId').innerHTML="<font color='red'>Total no of Records :: "+loop+"</font>";		
  		 
 } 	
 


//------------------------ For Performance Add  (loadComboPerformance) --------------
/*

function loadComboPerformance(ctr) {

	var pass=ctr.value;
//	alert(pass);
	
	if (pass=="0")
	{
		msg = "";
		tb = document.getElementById('ErrMsgId');
		tb.innerHTML=msg;
				
		document.getElementById('TxtAppName').value="";			
		document.getElementById('TxtJobTitle').value="";			
		document.getElementById('TxtAppId').value="";	
							
	}
	else
	{
	    var url = "../SmartHRM?actionS=ComboPerformance&ID= '"+pass+"'";
//		alert(url);
    	initRequest(url);    
	    req.onreadystatechange = performanceRequest;
    	req.open("GET", url, true);
	    req.send(null);
	}
}

function performanceRequest() 
{
    if(req.readyState == 4) {    
		
        if (req.status == 200) {
		
			var group = req.responseText;
//			alert(group+"   test");			
			if (group=="true")
			{
				msg = "<font color='red'>Add Marks for this Job Title</font>";
				tb = document.getElementById('ErrMsgId');
				document.getElementById('TxtAppName').value="";			
				document.getElementById('TxtJobTitle').value="";			
				document.getElementById('TxtAppId').value="";													
				document.getElementById('Submit').disabled=true;
				tb.innerHTML=msg;
			}
			else
			{
			    var batchs = req.responseXML.getElementsByTagName("Perform")[0];      
			    var batch = batchs.childNodes[0];
	    	    var appid= batch.getElementsByTagName("appId")[0].childNodes[0].nodeValue; 
	    	    var appcode= batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue;   
    	    	var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue;  
        	    var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue;  
            
				document.getElementById('TxtAppName').value=name;			
				document.getElementById('TxtJobTitle').value=title;			
				document.getElementById('TxtAppId').value=appid;						
				document.getElementById('Submit').disabled=false;
				msg = "<font color='green'>Valid title</font>";
				tb = document.getElementById('ErrMsgId');
				tb.innerHTML=msg;
			}

       }
    }
}


*/

function loadComboPerformance(ctr) {

	var pass=ctr.value;
//	alert(pass);
	
	if (pass=="0")
	{
		msg = "";
		tb = document.getElementById('ErrMsgId');
		tb.innerHTML=msg;
				
		document.getElementById('TxtAppName').value="";			
		document.getElementById('TxtJobTitle').value="";			
		document.getElementById('TxtAppId').value="";	
							
	}
	else
	{
	    var url = "../SmartHRM?actionS=ComboPerformance&ID= '"+pass+"'";
//		alert(url);
    	initRequest(url);    
	    req.onreadystatechange = performanceRequest;
    	req.open("GET", url, true);
	    req.send(null);
	}
}

function performanceRequest() 
{
    if(req.readyState == 4) {    
		
        if (req.status == 200) {
		
			var group = req.responseText;
//			alert(group+"   test");			
			if (group=="true")
			{
				msg = "<font color='red'>Add Marks for this Job Title</font>";
				tb = document.getElementById('ErrMsgId');
				document.getElementById('TxtAppName').value="";			
				document.getElementById('TxtJobTitle').value="";			
				document.getElementById('TxtAppId').value="";													
				document.getElementById('Submit').disabled=true;
				tb.innerHTML=msg;
			}
			else
			{
			    var batchs = req.responseXML.getElementsByTagName("Perform")[0];      
			    var batch = batchs.childNodes[0];
	    	    var appid= batch.getElementsByTagName("appId")[0].childNodes[0].nodeValue; 
	    	    var appcode= batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue;   
    	    	var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue;  
        	    var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue;  
            
				document.getElementById('TxtAppName').value=name;			
				document.getElementById('TxtJobTitle').value=title;			
				document.getElementById('TxtAppId').value=appid;						
				document.getElementById('Submit').disabled=false;
				msg = "<font color='green'>Valid title</font>";
				tb = document.getElementById('ErrMsgId');
				tb.innerHTML=msg;
			}

       }
    }
}




 
 

 
//-------------------- Unique------------
 
function chkUnique(ctr) {

	var pass=ctr.value;
    var url = "../SmartHRM?actionS=Unique&ID="+pass;


    initRequest(url);
    req.onreadystatechange = uniqueRequest;
    req.open("GET", url);
    req.send(null);
}

function uniqueRequest() 
{
    if(req.readyState == 4) {    

        if (req.status == 200) {
			var result = req.responseText;
			var tb = document.getElementById('DivAppCode');
			var sbutton = document.getElementById('submit_btn');
			var pbutton = document.getElementById('Pho_Button');
			if (result=="Valid Name")
			{
				tb.style.color="Green";
				sbutton.disabled=false;
				pbutton.disabled=false;				
			}				
			else
			{
				tb.style.color="Red";
				sbutton.disabled=true;
				pbutton.disabled=true;
			}
			tb.innerHTML = result;
        }
    }
}
 
 //----------------Result
 function loadResult(startLetter) {    	
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;  
	var result=document.getElementById('result').value;        
    var url = "../SmartHRM?actionS=JobResult&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter); 
    url=url+"&result="+result;
    initRequest(url);
    req.onreadystatechange = ResultViewRequest;
    req.open("GET", url, true);
    req.send(null);
}
function ResultViewRequest() 
{
    if(req.readyState == 4) {  
		ClearTables('performanceTable');
		if (req.status == 200) {

	         ResultDetails();

        }
    }
}
function ResultDetails() {
    var batchs = req.responseXML.getElementsByTagName("Performances")[0];      


	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";

	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var appid= batch.getElementsByTagName("appid")[0].childNodes[0].nodeValue;  
        var status= batch.getElementsByTagName("status")[0].childNodes[0].nodeValue; 
        var appcode = batch.getElementsByTagName("appcode")[0].childNodes[0].nodeValue; 
        var name= batch.getElementsByTagName("name")[0].childNodes[0].nodeValue; 
        var grade= batch.getElementsByTagName("grade")[0].childNodes[0].nodeValue; 
        var code = batch.getElementsByTagName("code")[0].childNodes[0].nodeValue; 
        var title= batch.getElementsByTagName("title")[0].childNodes[0].nodeValue; 
  		
  		if (status=="Q")
  			status="<strong><font color='#178507'>Qualified";
  		else
			status="<strong><font color='red'>Not Qualified";
			
       if(loop%2==1)
			str=str+"<tr class='MRow3'>";
		else
		    str=str+"<tr class='MRow2'>";	
		    
		
	    str=str+"<td width='160' class='boldEleven'>&nbsp;"
	    str = str + "<font class='boldEleven'><font color='blue'>"+grade+" Management</font>";	
		str=str+"<td width='100px' class='boldEleven'>&nbsp;"+appcode;
		str=str+"<td width='130px' class='boldEleven'>&nbsp;"+name;
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+title;		       
	    str=str+"<td width='100' class='boldEleven'>&nbsp;"+code;		
  		str=str+"<td width='100' class='boldEleven'>&nbsp;"+status;		

     }
     str=str+"</table>";
//  	alert(str);
     var tb=document.getElementById('performanceTable');
  	 tb.innerHTML=str   
			 
 } 	
 