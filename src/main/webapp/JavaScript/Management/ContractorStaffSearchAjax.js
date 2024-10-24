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
 
 
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
 function loadContractStaff(startLetter)
 {
 	var companyId=document.getElementById('company').value; 
    var departId=document.getElementById('depart').value;     
    var desigId=document.getElementById('designation').value; 
    var url = "../management?actionS=MGTstaff&departId="+escape(departId)+"&desigId="+escape(desigId)+"&companyId="+escape(companyId)+"&startLetter="+escape(startLetter);  
 
	
		initRequest(url);
    	req.onreadystatechange = searchContractStaffRequest;
	    req.open("GET", url, true);
    	req.send(null);
    
}	
 
function searchContractStaffRequest()
 {
    //LoadingTables('ContractstaffTable');
    if(req.readyState == 4) {
        ClearTable('ContractstaffTable');
		ClearTabler('totRec');  
 
         if (req.status == 200) {

          contracsearchStaff();
        }
    }
}
function contracsearchStaff() 
{	
    var batchs = req.responseXML.getElementsByTagName("ContracStaff")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
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
		str=str+"</tr>";
     }
      	 
 	 str=str+"</table>";     
  	 var tb=document.getElementById('ContractstaffTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML="<center><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font></center>"; 
 
     
}  

