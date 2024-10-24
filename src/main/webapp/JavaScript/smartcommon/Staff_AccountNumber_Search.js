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
 

function subWindow(query)
{  
	 
	var width="800", height="400";
		var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}




var searchname="";
function LoadSearchStaff( )
{
	try
	   {
 	var search=document.getElementById('searchstaff').value; 
 	var bank=document.getElementById('bank').value;
 	
 	var f = true;
 	if(search=="")
 	{
 		var rs=confirm("Load all staff");
		if (rs==true)
			f = true;
		else
			f=false;
	}
	else
		f=true;		
			
 	if(f)
 	{
 		searchname =  search.toUpperCase(); 	
 		var url = "../SmartCommonAjax?stype=1&actionS=loadStaffAccountNumberSearch&search="+escape(search)+"&bank="+bank;
 		initRequest(url);
   		req.onreadystatechange = loadStaffAccountNumberSearchRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
	   }
	   catch(err)
	   {
		   alert(err)
	   }
}




	


function loadStaffAccountNumberSearch(ctr)
{
   
 	var search=ctr; 
 	var bank=document.getElementById('bank').value;
 	searchname =  search.toUpperCase(); 	
	var url = "../SmartCommonAjax?stype=2&actionS=loadStaffAccountNumberSearch&search="+escape(search)+"&bank="+bank;
	initRequest(url);
	req.onreadystatechange = loadStaffAccountNumberSearchRequest;
	req.open("GET", url, true);
	req.send(null);
   	
}


function loadStaffAccountNumberSearchRequest()
 {
	ClearTable('staffTable');
	ClearTabler('totalrecord');
    if(req.readyState == 4) 
    {
        
        
         if (req.status == 200) 
         {
        	 loadStaffAccountNumberSearchMessage();
        }
    }
}

function loadStaffAccountNumberSearchMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];
      	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+"<tr class='MRow1'> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Staff Id</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Staff Name</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Branch</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Department</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Mobile</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Bank</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Account Number</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>IFSC Code</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Status</div></td> ";
    str=str+"</tr> ";


     for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var StaffId = batch.getElementsByTagName("StaffId")[0].childNodes[0].nodeValue ;
        var StaffName = batch.getElementsByTagName("StaffName")[0].childNodes[0].nodeValue;  
        var BranchName = batch.getElementsByTagName("BranchName")[0].childNodes[0].nodeValue; 
        var DepartName = batch.getElementsByTagName("DepartName")[0].childNodes[0].nodeValue; 
        var DesigName = batch.getElementsByTagName("DesigName")[0].childNodes[0].nodeValue; 
        var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue; 
        var Company = batch.getElementsByTagName("Company")[0].childNodes[0].nodeValue; 
        var Termination = batch.getElementsByTagName("Termination")[0].childNodes[0].nodeValue; 
        var MiddleName = batch.getElementsByTagName("MiddleName")[0].childNodes[0].nodeValue; 
        
        var Bank = batch.getElementsByTagName("Bank")[0].childNodes[0].nodeValue;
        var Account = batch.getElementsByTagName("Account")[0].childNodes[0].nodeValue;
        var IFSC = batch.getElementsByTagName("IFSC")[0].childNodes[0].nodeValue;
        var Resigned = batch.getElementsByTagName("Resigned")[0].childNodes[0].nodeValue;
        
        if(Resigned == "T")
        {
        	str=str+"<tr bgcolor ='#d9534f'>";
        }	
        else
        	
        {
	       	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
        }
       	
		var t="";
		if("T"==Termination)
			t= "class = 'boldred'";
		else
			t= "class='boldgreen'";
		
        str=str+"<td   class='boldEleven'>"
       
       	var s = StaffId;
        
		s=s.replace(searchname,"9865043008");
		s = s.replace("9865043008","<b><span class='tMLAscreenHead'>"+searchname+"</span></b>");
		
        str=str+"<input type='checkbox' name='staffid' value='"+StaffId+"'>";
        str=str+"<font "+t+"><a href='StaffAccountNumberAction.jsp?staffid="+StaffId+"'>"+s+"</a></font>  </td>";
		
		str=str+"<td class='boldEleven'> "+StaffName  +"</td>";
		str=str+"<td class='boldEleven'>"+BranchName +"</td>";
		str=str+"<td class='boldEleven'>"+DepartName +"</td>";
		str=str+"<td class='boldEleven'>"+Mobile +"</td>";
		str=str+"<td class='boldEleven'>"+Bank +"</td>";
		str=str+"<td class='boldEleven'>"+Account +"</td>";
		str=str+"<td class='boldEleven'>"+IFSC +"</td>";
		if(Resigned == "T")
			str=str+"<td class='boldEleven'>Resigned</td>";
		else
			str=str+"<td class='boldEleven'>Live</td>";
		str=str+" </tr>";
		
		 
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('staffTable');
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
  	  
     
}

 