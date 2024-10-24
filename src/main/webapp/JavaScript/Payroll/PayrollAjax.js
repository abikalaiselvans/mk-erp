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
	 var str="<br><br><br><br><center><font class='bolddeepred'>Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
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
 
function loadRivision(startLetter) {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var Office=document.getElementById('Office').value;        
    var url = "../Payroll?actionS=PAYRivision&month="+escape(mon)+"&year="+escape(yea)+"&startLetter="+startLetter+"&Office="+Office;
	initRequest(url);
	req.onreadystatechange = loadRivisionRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadRivisionRequest() {
    if(req.readyState == 4) {    	
        ClearTable('rivisionTable');
        document.getElementById('Delete').disabled=true;
        document.getElementById('Edit').disabled=true;  
        if (req.status == 200) {		  	
          loadRivisionMessages();
        }
    }
}
function loadRivisionMessages() {   
    var batchs = req.responseXML.getElementsByTagName("Rivisions")[0];   	    
	var str=""; 
    str=str+" <table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    for(loop = 0; loop < batchs.childNodes.length; loop++) {           		                           
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue; 
    	var Staffname = batch.getElementsByTagName("Staffname")[0];
    	var Companyame = batch.getElementsByTagName("Companyame")[0];
    	var Branch = batch.getElementsByTagName("Branch")[0];
    	var Depart = batch.getElementsByTagName("Depart")[0];
    	var Desig = batch.getElementsByTagName("Desig")[0];
    	var Rivision = batch.getElementsByTagName("Rivision")[0];
    	var Effect = batch.getElementsByTagName("Effect")[0];
    	
    var smonth=document.getElementById('month').value;
    var syear=document.getElementById('year').value;        
    
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";		
		
		str=str+"<td width='138'><input type='checkbox' name='staffid' value='"+Staffid+"'>"+Staffid;
		str=str+"<td width='200' class='boldEleven'><a href='RivisionView.jsp?staffid="+Staffid+"&Month="+smonth+"&Year="+syear+"'>"+Staffname.childNodes[0].nodeValue+"</a>";
		str=str+"<td width='125' class='boldEleven'>"+Companyame.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Branch.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		str=str+"<td width='50'  class='boldEleven'>"+Effect.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     
  	 if(batchs.childNodes.length >0)
  	 {
  	 	document.getElementById('Delete').disabled=false;
     	document.getElementById('Edit').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true;
     
     }	
     str=str+"</table>";
     var tb=document.getElementById('rivisionTable');
  	 tb.innerHTML=str    	 
}
//End :: LoadRivision		Author	::	Kalaiselvan.k

//Start :: LoadAdvance		Author	::	Elam
function ClearTables(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



function loadMessBill(startLetter) {
    var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../Payroll?actionS=PAYMess&month="+escape(mon)+"&year="+escape(yea)+"&startLetter="+startLetter;
	initRequest(url);
    req.onreadystatechange = loadMessRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadMessRequest() {
    if(req.readyState == 4) {    	
        ClearTabless('MessTable');      
        if (req.status == 200) {		  	
          loadMessMessages();
        }
    }
}
function loadMessMessages() {   
    var batchs = req.responseXML.getElementsByTagName("Messes")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven' cellpadding='2' cellspacing='2'>";  		                        
    for(loop = 0; loop < batchs.childNodes.length; loop++) {           		                           
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0]; 
    	var Staffname = batch.getElementsByTagName("Staffname")[0];
    	var Companyame = batch.getElementsByTagName("Companyame")[0];
    	var Branch = batch.getElementsByTagName("Branch")[0];
    	var Depart = batch.getElementsByTagName("Depart")[0];
    	var Desig = batch.getElementsByTagName("Desig")[0];    	
    	var MessAmt = batch.getElementsByTagName("MessAmt")[0];
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		str=str+"<td width='100'  class='boldEleven'><input type='checkbox' name='staffid' value='"+Staffid.childNodes[0].nodeValue+"'>"+Staffid.childNodes[0].nodeValue;
		str=str+"<td width='160' class='boldEleven'><a href='MessBillEdit.jsp?staffid="+Staffid.childNodes[0].nodeValue+"'>"+Staffname.childNodes[0].nodeValue+"</a>";
		str=str+"<td width='100' class='boldEleven'>"+Companyame.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Branch.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		str=str+"<td width='50'  class='boldEleven'>"+MessAmt.childNodes[0].nodeValue;
		str=str+"</td></tr>";
     }
     
  	  if(batchs.childNodes.length<1)
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('MessTable');
  	tb.innerHTML=str;   	
}
function ClearTabless(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//End :: LoadRivision		Author	::	Elam


//End :: LoadTransfer		Author	::	Elam

function ClearTablesss(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 

//Start :: Allowance and Recovery		Author	::	NPR   Date :: 28/03/2007
//---------------------------------------------------------------------------
var searchname;

//---------------------------------------------------------------------------------------





//--------------------------------------------------------------------------------------
function loadRelivingStaff() 
{    
	var month=document.getElementById("Month").value;
	var year=document.getElementById("Year").value;     
    var url = "../Payroll?actionS=PAYReliving&month="+month+"&year="+year;
    initRequest(url);
    req.onreadystatechange = loadRelivingRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadRelivingRequest() 
{
	if(req.readyState == 4) 
    {
    
    	var _targ=document.getElementsByName('ename')[0];
    	_targ.options.length=0;	
    	_targ.options[0]=new Option("Select","0");
	    _targ.selectedIndex=0;
    	if (req.status == 200) 
        {
        
          	var batchs = req.responseXML.getElementsByTagName("Relvs")[0];   	    
			_targ.options.length=0;	
    		_targ.options[0]=new Option("Select","0");
    		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		    {
	    		var batch = batchs.childNodes[loop];
		        var Staffid = batch.getElementsByTagName("Staffid")[0];
	    	    var StaffName = batch.getElementsByTagName("Staffname")[0];
	    	    _targ.options[loop+1]=new Option(StaffName.childNodes[0].nodeValue,Staffid.childNodes[0].nodeValue);
	    	}
		 	_targ.options.length=(loop+1);
			_targ.selectedIndex=0;
			    
	    	 
        }
        _targ.onchange();
     }
}

function ClearTab(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
function LoadingTab(ctr1)
{
	 var str="<font class='boldEleven'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//End :: LoadRivision		Author	::	Elam
