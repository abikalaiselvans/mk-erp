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
function LoadSearchStaff(ctr)
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
 		var url = "../SmartCommonAjax?stype=1&actionS=loadStaffSearch&search="+escape(search);
 		initRequest(url);
   		req.onreadystatechange = StaffRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
}




	


function loadStaff(ctr)
{
   
 	var search=ctr; 
 	searchname =  search.toUpperCase(); 	
	var url = "../SmartCommonAjax?stype=2&actionS=loadStaffSearch&search="+escape(search);
	initRequest(url);
	req.onreadystatechange = StaffRequest;
	req.open("GET", url, true);
	req.send(null);
   	
}


function StaffRequest()
 {
	ClearTable('staffTable');
	ClearTabler('totalrecord');
    if(req.readyState == 4) 
    {
        
        
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
    str=str+"<tr class='MRow1'>";
    str=str+"<td   class='boldEleven' align='center'><b>Staff Id</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Staff Name</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Company </b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Branch</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Department</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Designation</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Mobile</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>&nbsp;</b></td>"; 
    str=str+"</tr>";
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
          
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
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
        str=str+"<font "+t+">"+s+"</font>  </td>";
		
		str=str+"<td class='boldEleven'> "+StaffName +"</td>";
		str=str+"<td class='boldEleven'> "+Company +"</td>";
		str=str+"<td class='boldEleven'>"+BranchName +"</td>";
		str=str+"<td class='boldEleven'>"+DepartName +"</td>";
		str=str+"<td class='boldEleven'>"+DesigName +"</td>";
		str=str+"<td class='boldEleven'>&nbsp;"+Mobile +"</td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:subWindow('StaffPhotoUpload.jsp?staffid="+StaffId+"')\"><font class='boldgreen'>Photo</font></a></td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:subWindow('StaffProfileUpload.jsp?staffid="+StaffId+"')\"><font class='boldgreen'>Resume</font></a></td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:subWindow('StaffAddressProofUpload.jsp?staffid="+StaffId+"')\"><font class='boldgreen'>Address Proof</font></a></td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:subWindow('certificateUpload.jsp?staffid="+StaffId+"')\"><font class='boldgreen'>Qualification</font></a></td>";
		str=str+"<td class='boldEleven'><a href=\"javascript:subWindow('StafffullFileUpload.jsp?staffid="+StaffId+"')\"><font class='boldgreen'>All</font></a></td>";
		str=str+"<td class='boldEleven'><a href='Staffidcard.jsp?staffid="+StaffId+"' target='_blank' ><font class='boldgreen'>Id Card</font></a></td>";
		str=str+"<td class='boldEleven'><a href='../SmartLoginAuth?actionS=GENRept_JIdCard&filename=Rept_JIdCard&rptfilename=IdCard&staffid="+StaffId+"' target='_blank' ><font class='boldgreen'>Id Card pdf</font></a></td>";
		
		str=str+" </tr>";
		
		 
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('staffTable');
  	 tb.innerHTML=str  ; 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
  	  
     
}

 