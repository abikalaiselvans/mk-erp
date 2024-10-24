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
	 var str="<font class='errorMessage'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
var searchname="";
function LoadSearchStaffs(ctr)
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
 		searchname =  search.toUpperCase(); 	
 		var url = "../Common?actionS=ATTstaffsearch&search="+escape(search);
  		initRequest(url);
   		req.onreadystatechange = StaffRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
}
	
function StaffRequest()
 {
    LoadingTables('staffTable');
    if(req.readyState == 4) 
    {
        ClearTables('staffTable');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML=" "  ; 
        document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true; 	 
         if (req.status == 200) 
         {
          	StaffMessage();
        }
    }
}

function StaffMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Staffs")[0];
      	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
   
     for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var StaffId = batch.getElementsByTagName("StaffId")[0].childNodes[0].nodeValue;
        var StaffName = batch.getElementsByTagName("StaffName")[0];  
        var BranchName = batch.getElementsByTagName("BranchName")[0]; 
        var DepartName = batch.getElementsByTagName("DepartName")[0]; 
        var DesigName = batch.getElementsByTagName("DesigName")[0]; 
        var Mobile = batch.getElementsByTagName("Mobile")[0]; 
        var Company = batch.getElementsByTagName("Company")[0]; 
        var Termination = batch.getElementsByTagName("Termination")[0]; 
        var MiddleName = batch.getElementsByTagName("MiddleName")[0]; 
          
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		var t="";
		if("T"==Termination.childNodes[0].nodeValue)
			t= "class = 'boldred'";
		else
			t= "class='boldgreen'";
		
        str=str+"<td    class='boldEleven'>"
        str=str+"<input type='checkbox' name='staffid' value='"+StaffId+"'>";
        str=str+"<a href=StaffRegistrationEdit.jsp?path=ATT&qp=ATT&staffid="+StaffId+"><font "+t+">"+StaffId+"</font></a></td>";
		
		var s = StaffName.childNodes[0].nodeValue;
		s = s.replace(searchname,"9865043008");
		s = s.replace("9865043008","<font class='search' ><b>"+searchname+"</b></font>");
		alert(s);
		str=str+"<td  class='boldEleven'> "+s+"</td>";
		str=str+"<td class='boldEleven'> "+MiddleName.childNodes[0].nodeValue  +"</td>";
		str=str+"<td  class='boldEleven'> "+Company.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+BranchName.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+DepartName.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+DesigName.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'><a href=\"../Smart Attendance/Staffidcard.jsp?staffid="+StaffId+"\">Id Card</a> </td>";
		str=str+" </tr>";
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('staffTable');
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Toal no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
  	 if(batchs.childNodes.length <1)
  	 {
  		document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true; 	 	 	 
     }
     else
     {
  		document.getElementById('Delete').disabled=false;
     	document.getElementById('Edit').disabled=false ; 
     }
     
}

 