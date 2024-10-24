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
 
    
 
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTables(ctr1)
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
 
var searchname="";
function LoadContractorSearchStaff(ctr)
{

 	var search=document.getElementById(ctr).value; 
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
 		var url = "../management?actionS=MGTstaffSearch&search="+escape(search);
 		initRequest(url);
   		req.onreadystatechange = MGTStaffRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
}
	
function MGTStaffRequest()
 {
    LoadingTables('ContractstaffTable');
    if(req.readyState == 4) 
    {
        ClearTables('ContractstaffTable');
		ClearTabler('totRec');  
         if (req.status == 200) 
         {
          	MGTStaffMessage();
        }
    }
}

function MGTStaffMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("ContracStaffsearch")[0];
	var str=""; 
    str=str+"<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";  
   
     for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var StaffId = batch.getElementsByTagName("StaffId")[0].childNodes[0].nodeValue;
        var StaffName = batch.getElementsByTagName("StaffName")[0].childNodes[0].nodeValue;
		var Company = batch.getElementsByTagName("Company")[0].childNodes[0].nodeValue; 
        var DepartName = batch.getElementsByTagName("DepartName")[0].childNodes[0].nodeValue; 
        var DesigName = batch.getElementsByTagName("DesigName")[0].childNodes[0].nodeValue; 
        var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue; 
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
				
        str=str+"<td width='11%' class='boldEleven'><input type='checkbox' name='staffid' id='staffid' value="+StaffId+">"+(loop+1)+"</td>";
        str=str+"<td  width='15%' class='boldEleven'><a href=ContractorEdit.jsp?staffid="+StaffId+">"+StaffName+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+Company+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+DepartName+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+DesigName+"</td>";
		str=str+"<td  width='15%' class='boldEleven'>&nbsp;"+Mobile+"</td>";
		str=str+" </tr>";
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('ContractstaffTable');
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
  	 
     
}

 