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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
  
 

 function loadStaff(startLetter)
 {
   try
   {
	 	var companyId=document.getElementById('company').value;
	 	var branchId= document.getElementById('branch').value;
	 	var departId=document.getElementById('depart').value;
	    var desigId=document.getElementById('designation').value;
	    var resigned="";;
		obj = findObj("resigned");
		if(obj == null)
			resigned="N";
		else
			resigned =document.getElementById("resigned").value;
		var url = "../Payroll?actionS=loadStaff&departId="+escape(departId)+"&desigId="+escape(desigId)+"&branchId="+escape(branchId)+"&companyId="+escape(companyId)+"&startLetter="+escape(startLetter)+"&resigned="+resigned;  
	    initRequest(url);
    	req.onreadystatechange = searchStaffRequest;
	    req.open("GET", url, true);
    	req.send(null);
	   
   }
   catch(err)
   {
	   alert(err);
   }
}	
 
function searchStaffRequest()
{
    ClearTabler('totRec');
    ClearTable('staffTable');
    if(req.readyState == 4) 
    {
        //document.getElementById('Delete').disabled=true;
     	//document.getElementById('Edit').disabled=true; 	 
        if (req.status == 200) 
        {
         //tb.innerHTML="<font class='bolddeepred'> Loading Data</font>";
		 var tb=document.getElementById('staffTable');
		 tb.innerHTML="<font class='bolddeepred'> Loading Data</font>"; 
		 searchStaff();
        }
    }
}


function searchStaff() 
{	
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
		var str=""; 
		str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
		for(loop=0; loop<batchs.childNodes.length; loop++)
		{
			var batch = batchs.childNodes[loop];
	        var StaffId = batch.getElementsByTagName("StaffId")[0].childNodes[0].nodeValue;
	        var StaffName = batch.getElementsByTagName("StaffName")[0].childNodes[0].nodeValue;  
	        var BranchName = batch.getElementsByTagName("BranchName")[0].childNodes[0].nodeValue; 
	        var DepartName = batch.getElementsByTagName("DepartName")[0].childNodes[0].nodeValue; 
	        var DesigName = batch.getElementsByTagName("DesigName")[0].childNodes[0].nodeValue; 
	        var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue; 
	        var Company = batch.getElementsByTagName("Company")[0].childNodes[0].nodeValue; 
	        var Termination = batch.getElementsByTagName("Termination")[0].childNodes[0].nodeValue; 
	        var Usertype = batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
	         if("T"==Termination )
	        	 str=str+"<tr class='MRow3'>";
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
				
	        str=str+"<td width='11%' class='boldEleven'><input type='checkbox' name='staffid' value='"+StaffId+"'>";
	       if(Usertype=="B" || Usertype=="F")
	        	str=str+"<a href=StaffBasicAction.jsp?path=ATT&qp=ATT&staffid="+StaffId+">"+StaffId+"</a> ";
	        else
	        	str=str+"<a href=StaffBasicAction.jsp?path=ATT&qp=ATT&staffid="+StaffId+">"+StaffId+"</a> ";
	        str=str+"</td>";
	       
	        
	        str=str+"<td  width='11%' class='boldEleven'> "+StaffName+"</td>"  ;
			str=str+"<td  width='11%' class='boldEleven'>&nbsp;"+Company+"</td>"  ;
			str=str+"<td  width='11%' class='boldEleven'>"+BranchName+"</td>"  ;
			str=str+"<td  width='11%' class='boldEleven'>"+DepartName+"</td>"  ;
			str=str+"<td  width='11%' class='boldEleven'>"+DesigName+"</td>"  ;
			str=str+"<td  width='11%' class='boldEleven'>&nbsp;"+Mobile+"</td>"  ;
			str=str+"</tr>";
	     }
	     
	  	 var tb=document.getElementById('staffTable');
	  	 tb.innerHTML=str  ; 
	  	 
	  	 tb=document.getElementById('totRec');
	  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
	  	 
	  	 if(batchs.childNodes.length <1)
	  	 {
	  				str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
				    str=str+"</table>";
	     }
	     
	}
	catch(err)
	{
		alert(err);
	}
	 
}  

