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
 		var url = "../SmartCommonAjax?stype=1&actionS=loadStaffPFESIClaims&search="+escape(search) ;
 		initRequest(url);
   		req.onreadystatechange = loadStaffPFESIRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
	   }
	   catch(err)
	   {
		   alert(err)
	   }
}




//loadStaffAccountNumberSearch


function loadStaffPFESI(ctr)
{
   
 	var search=ctr; 
 	searchname =  search.toUpperCase(); 	
	var url = "../SmartCommonAjax?stype=2&actionS=loadStaffPFESIClaims&search="+escape(search) ;
	initRequest(url);
	req.onreadystatechange = loadStaffPFESIRequest;
	req.open("GET", url, true);
	req.send(null);
   	
}


function loadStaffPFESIRequest()
 {
	ClearTable('staffTable');
	ClearTabler('totalrecord');
    if(req.readyState == 4) 
    {
        
        
         if (req.status == 200) 
         {
        	 loadStaffPFESIMessage();
        }
    }
}

function loadStaffPFESIMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];
      	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+"<tr class='MRow1'> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Staff Id</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Staff Name</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>PF</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>PFtype</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>PFnumber</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Nominee</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>ESI</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>ESIType</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>ESINumber</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Claim Status</div></td> ";
    str=str+"<td><div align='center' class='boldEleven'><b>Claim date</div></td> ";
    str=str+"</tr> ";

    
     for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var StaffId = batch.getElementsByTagName("StaffId")[0].childNodes[0].nodeValue ;
        var StaffName = batch.getElementsByTagName("StaffName")[0].childNodes[0].nodeValue;  
        var PF = batch.getElementsByTagName("PF")[0].childNodes[0].nodeValue; 
        var PFtype = batch.getElementsByTagName("PFtype")[0].childNodes[0].nodeValue; 
        var PFnumber = batch.getElementsByTagName("PFnumber")[0].childNodes[0].nodeValue; 
        var Nominee = batch.getElementsByTagName("Nominee")[0].childNodes[0].nodeValue; 
        var ESI = batch.getElementsByTagName("ESI")[0].childNodes[0].nodeValue; 
        var ESIType = batch.getElementsByTagName("ESIType")[0].childNodes[0].nodeValue; 
        var ESINumber = batch.getElementsByTagName("ESINumber")[0].childNodes[0].nodeValue; 
        var Resigned = batch.getElementsByTagName("Resigned")[0].childNodes[0].nodeValue; 
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue; 
        var Claimdate = batch.getElementsByTagName("Claimdate")[0].childNodes[0].nodeValue; 
         	
         
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		var t="";
		if("T"==Resigned)
			t= "class = 'boldred'";
		else
			t= "class='boldgreen'";
		
        str=str+"<td   class='boldEleven'>"
       
       	var s = StaffId;
        
		s=s.replace(searchname,"9865043008");
		s = s.replace("9865043008","<b><span class='tMLAscreenHead'>"+searchname+"</span></b>");
		
        str=str+"<input type='checkbox' name='staffid' value='"+StaffId+"'>";
        str=str+"<font "+t+"><a href='Staff_PFandESI_ClaimAction.jsp?staffid="+StaffId+"'>"+s+"</a></font>  </td>";
		
		str=str+"<td class='boldEleven'> "+StaffName +"</td>";
		str=str+"<td class='boldEleven'>"+PF +"</td>";
		str=str+"<td class='boldEleven'>"+PFtype +"</td>";
		str=str+"<td class='boldEleven'>"+PFnumber +"</td>";
		str=str+"<td class='boldEleven'>"+Nominee +"</td>";
		str=str+"<td class='boldEleven'>"+ESI +"</td>";
		str=str+"<td class='boldEleven'>"+ESIType +"</td>";
		str=str+"<td class='boldEleven'>"+ESINumber +"</td>";
		str=str+"<td class='boldEleven'>"+Status +"</td>";
		str=str+"<td class='boldEleven'>"+Claimdate +"</td>";
		 
		
		str=str+" </tr>"; 
		
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('staffTable'); 
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
  	  
     
}

 