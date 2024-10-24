var isIE;
var req;
var names;

function getElementY(element){
	var target1Top = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} else if (element.y) {
		target1Top += element.y;
    }
	return target1Top;
}

function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
//--------------------Clear Select ---------------------
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
function ClearTable(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	// var tb=document.getElementById('totRec');	 
  	// tb.innerHTML="Total no of Records :: 0"    
  	 
}


 
//CheckUnique(this,'soValid','com_m_staff','CHR_EMPID')
function CheckUnique(sval,divId,tableName,filedName) 
{
	var id = sval.value;
	var url = "../Common?actionS=CheckUnique";
	url=url+"&id="+escape(id);
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);	
	initRequest(url);	
	dId=divId;	
	req.onreadystatechange = CheckUniqueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function CheckUniqueRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
			CheckUniqueMessages();
        }
    }
}
function CheckUniqueMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table width=50 >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
        	{
	    		document.getElementById('Submit').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('Submit').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById(dId);
  	 	tb.innerHTML=str  ; 
 }
 

//--------------Branch FOR STAFF AJAX--------by NPR-----------------------
function loadBDStaff(sval) {
    var id=document.getElementById('company').value;   
    var url = "../attendance?actionS=ATTbranch&id="+escape(id)+"&startLetter="+escape(sval);   
    initRequest(url);
    req.onreadystatechange = branchSRequest;
    req.open("GET", url, true);
    req.send(null);
}
function branchSRequest() 
{
    if(req.readyState == 4) {    
       clearSelect('branch');
       var _targ=document.getElementsByName('branch')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('No Record found..','-1');      
       ClearTables('staffTable');
        if (req.status == 200) {
          branchSDetails();
        }
    }
}
function branchSDetails() {
    var batchs = req.responseXML.getElementsByTagName("branches")[0];      
	var _targ=document.getElementsByName('branch')[0];       
    _targ.options.length=0;	
      _targ.options[0]=new Option('All','0');
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("branchName")[0];        
        var batchId = batch.getElementsByTagName("id")[0];
        _targ.options[(loop+1)]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
      }		
	_targ.options.length=loop;
	_targ.selectedIndex=0;
}

//----------------------------------Holidays----------------------------------------------


//----------------------------------Ot----------------------------------------------

function ClearTb(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
function ClearTb(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


//----------------------------------Compensation----------------------------------------------
function loadCompensation(startLetter) 
{	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var Office=document.getElementById('Office').value;
    var url = "../attendance?actionS=ATTCompensation&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter)+"&Office="+Office;
	initRequest(url);
	req.onreadystatechange=CompensationRequest;
    req.open("GET", url, true);
    req.send(null);
}
function CompensationRequest() {
    if(req.readyState == 4) {    	
        ClearTabes('compensationTable'); 
		document.getElementById('Edit').disabled=true;  		
        if (req.status == 200) {		  	
          CompensationMessages();
        }
    }
}
function CompensationMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("compensations")[0];   
    var str=""; 
	str=str+"<table width='954' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	    
	    var batch = batchs.childNodes[loop];
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var Companyname = batch.getElementsByTagName("Companyname")[0].childNodes[0].nodeValue;
        var Branchname = batch.getElementsByTagName("Branchname")[0].childNodes[0].nodeValue;     
        var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue; 
        var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue; 
//        var CompensationName = batch.getElementsByTagName("CompensationName")[0].childNodes[0].nodeValue;  
//        var CompensationFromDate = batch.getElementsByTagName("CompensationFromDate")[0];            
//        var CompensationToDate = batch.getElementsByTagName("CompensationToDate")[0];            
        var NoDays = batch.getElementsByTagName("NoDays")[0].childNodes[0].nodeValue;        

		var smonth=document.getElementById('month').value;
    	var syear=document.getElementById('year').value;        
         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td width='140' class='boldEleven'><input name='staffid' id='staffid' type='checkbox' value='"+Empid+"'/>&nbsp;"+Empid;

//		str=str+"<td width='160' class='boldEleven'>&nbsp;"+Staffname;

		str=str+"<td width='160' class='boldEleven'>&nbsp;<font color='blue'>";
		str=str+"<a href=CompensationEdit.jsp?month="+smonth+"&year="+syear+"&staffid="+Empid+">"+Staffname+"</a></font>";

		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Companyname;
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Branchname;
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Depart;
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Desig;
//		str=str+"<td width='100' class='boldEleven'>&nbsp;"+CompensationName;
//		str=str+"<td width='100' class='boldEleven'>"+CompensationFromDate.childNodes[0].nodeValue;
//		str=str+"<td width='100' class='boldEleven'>"+CompensationToDate.childNodes[0].nodeValue;
		str=str+"<td width='80' class='boldEleven' align='center'>"+NoDays;
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;     
     }	
     str=str+"</table>";
     var tb=document.getElementById('compensationTable');
  	 tb.innerHTML=str   
}
function ClearTabes(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//----------------------------------Shift Allocation----------------------------------------------





function loadShift(startLetter) 
{	
	var mon=document.getElementById('Month').value;
    var yea=document.getElementById('year').value;        
    var url = "../attendance?actionS=ATTShift&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange=ShiftRequest;
    req.open("GET", url, true);
    req.send(null);
}
function ShiftRequest() {
    if(req.readyState == 4) {  
    document.getElementById("btnEdit").disabled=true;  	
        ClearTab('shiftTable');       
        if (req.status == 200) {		
        	
          ShiftMessages();
        }
    }
}
function ShiftMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("shifts")[0];
    if(batchs!=null)
    {   
    var str=""; 
	str=str+"<table width='954' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	    
	    var batch = batchs.childNodes[loop];
	    var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue;
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    var Companyname = batch.getElementsByTagName("Companyname")[0].childNodes[0].nodeValue;
        var Branchname = batch.getElementsByTagName("Branchname")[0].childNodes[0].nodeValue;     
        var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue; 
        var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue; 
              
		var smonth=document.getElementById('month').value;
    	var syear=document.getElementById('year').value;           
         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td width='140' class='boldEleven'><input name='stafftid' id='stafftid' type='checkbox' value='"+Empid+"'/>&nbsp;"+Empid;
		str=str+"<td width='160' class='boldEleven'>&nbsp;";
		str=str+"<a href=ShiftAllocationEdit.jsp?month="+ smonth + "&year="+ syear +"&stafftid="+Empid+">"+Staffname+"</a>";
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Companyname;
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Branchname;
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Depart;
		str=str+"<td width='110' class='boldEleven'>&nbsp;"+Desig;
    }
    
    if(batchs.childNodes.length<1)
    {
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    document.getElementById("btnEdit").disabled=true;
    }
    else
    {
     document.getElementById("btnEdit").disabled=false;
    }
    var tb=document.getElementById('shiftTable');
  	tb.innerHTML=str;  
  	}
  	else
  	{
  	 	ClearTab('shiftTable');   
  	 	document.getElementById("btnEdit").disabled=true;
  	 	}
}






function ClearTab(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


 
function ClearTable1(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//End  - Author :: Kalaiselvan -----------------------On Duty Attendance-----------------------------





//Start -Kalaiselvan--------------------------Leave Entry---------------------
//End -Kalaiselvan--------------------------Leave Entry---------------------------



//Start -Kalaiselvan--------------------------Query Execution---------------------
function loadDateDiff()
{
	var d1=document.getElementById('fromdate').value;  
	var d2=document.getElementById('todate').value;  
	if((d1 != "") &&(d2 != ""))
	{
    	var url = "../attendance?actionS=AttQuery&d1="+escape(d1)+"&d2="+escape(d2);;
		initRequest(url);
		req.onreadystatechange = DateDiffRequest;
    	req.open("GET", url, true);
    	req.send(null);
    }
    else
    {
    	alert("invalid Date format..");
    }	
}

function DateDiffRequest() {
    if(req.readyState == 4) {  
    	ClearTable1('queryTable');  	
        if (req.status == 200) {		  	
         	DateDiffMessages();
        }
    }
}
function DateDiffMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Dates")[0];   
    var str=""; 
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
        var Day = batch.getElementsByTagName("Day")[0];
	    var d = parseInt(Day.childNodes[0].nodeValue);		
		var db=parseInt(document.getElementById('limit').value); 
		var Eligible =parseInt(document.getElementById('Eligible').value);  
		var Available =parseInt(document.getElementById('Available').value);
		var remain = Eligible-Available;
		if((d>db)||(d>=remain))
		{
			str=str+"<font color='red'><b><center>Limit Exceeded...</center></b></font> ";
			document.getElementById('todate').value = "";
			document.getElementById('check').value = "false";
		}
		else
			document.getElementById('check').value = "true";
			
	 }
     if(batchs.childNodes.length<1)
    	str=str+" <center>Data not found...</center> ";
    
      var tb=document.getElementById('queryTable');
  	 tb.innerHTML=str  ; 
  	 
 }
 







 


function ClearTabless(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
function LoadingTables(ctr1)
{
	 var str="<font style='font-style: oblique;font-size: 16px;color:blue' class='boldEleven'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function ClearTablesss(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


 