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


//Start -Kalaiselvan--------------------------UserName--------------------
function LoadUserName() 
{
	var uname = document.getElementById('userName').value;
    var url = "../Common?actionS=LoadUserName&userName="+escape(uname);
    initRequest(url);
	req.onreadystatechange = LoadUserNameRequest;
    req.open("GET", url, true);
    req.send(null);
}

function LoadUserNameRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	LoadUserNameMessages();
        }
    }
}


function LoadUserNameMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    	else
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById('UserTable');
  	 	tb.innerHTML=str  ; 
  	 
 }
//End -Kalaiselvan--------------------------UserName---------------------


//----------------------------------------
//searching staff by name
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
        str=str+"<a href=StaffRegistrationEdit.jsp?path=ATT&qp=ATT&staffid="+StaffId+"><font "+t+">"+StaffId+"</font></a>";
		var s = StaffName.childNodes[0].nodeValue;
		s=s.replace(searchname,"9865043008");
		s = s.replace("9865043008","<font class='search' ><b>"+searchname+"</b></font>");
		
		str=str+"<td  class='boldEleven'> "+s;
		str=str+"<td class='boldEleven'> "+MiddleName.childNodes[0].nodeValue  ;
		str=str+"<td  class='boldEleven'> "+Company.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+BranchName.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+DepartName.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+DesigName.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'><a href=\"../Smart Attendance/Staffidcard.jsp?staffid="+StaffId+"\">Id Card</a>";
		str=str+"</td></tr>";
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



//----------------------------------------








//Start -Kalaiselvan--------------------------Staff-------------------
function loadStaff(startLetter)
 {
   
 	var companyId=document.getElementById('company').value;   	
 	var branchId= document.getElementById('branch').value;   	
    var departId=document.getElementById('depart').value;     
    var desigId=document.getElementById('designation').value;       
    var url = "../Common?actionS=ATTstaff&departId="+escape(departId)+"&desigId="+escape(desigId)+"&branchId="+escape(branchId)+"&companyId="+escape(companyId)+"&startLetter="+escape(startLetter);  
	if (companyId != "0")
	{
	    initRequest(url);
    	req.onreadystatechange = searchStaffRequest;
	    req.open("GET", url, true);
    	req.send(null);
    }
	else
	{
	    ClearTables('staffTable');
	}
}	
 
function searchStaffRequest()
 {
    LoadingTables('staffTable');
    if(req.readyState == 4) {
        ClearTables('staffTable');
        document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true; 	 
         if (req.status == 200) {
          searchStaff();
        }
    }
}
function searchStaff() 
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
        
        
          
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		    
        var t="";
		if("T"==Termination.childNodes[0].nodeValue)
			t= "class = 'boldred'";
		else
			t= "class='boldgreen'";
			
        str=str+"<td class='boldEleven'>"
        str=str+"<input type='checkbox' name='staffid' value='"+StaffId+"'>";
        str=str+"<a href=StaffRegistrationEdit.jsp?path=ATT&qp=ATT&staffid="+StaffId+"><font "+t+">"+StaffId+"</font></a>";
		str=str+"<td class='boldEleven'> "+StaffName.childNodes[0].nodeValue  ;
		 
		
		str=str+"<td class='boldEleven'>&nbsp;"+Company.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven'>"+BranchName.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven'>"+DepartName.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven'>"+DesigName.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven'>&nbsp;"+Mobile.childNodes[0].nodeValue;
		str=str+"<td class='boldEleven'><a href=\"../Smart Attendance/Staffidcard.jsp?staffid="+StaffId+"\">Id Card</a>";
		str=str+"</td></tr>";
     }
     str=str+"</table>";     
  	 var tb=document.getElementById('staffTable');
  	 tb.innerHTML=str  ; 
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
//End -Kalaiselvan--------------------------Staff............................






//Start -Kalaiselvan--------------------------Branch-------------------
function LoadBranches( )
 {
 	var companyId=document.getElementById('company').value;   	
 	var url = "../attendance?actionS=ATTBranch&cpyid="+escape(companyId);  
	initRequest(url);
    req.onreadystatechange = BranchesRequest;
    req.open("GET", url, true);
    req.send(null);
     
}
 
function BranchesRequest()
 {
    if(req.readyState == 4) {
       ClearTables('BranchTable');
         if (req.status == 200) 
         {
           BranchesStaff();
        }
    }
}
function BranchesStaff() 
{	
   
    var batchs = req.responseXML.getElementsByTagName("Branchs")[0];   	    
	var str=""; 
	 
	str = "<select name='branch' id='branch'   class='bolddeepblue'><option value='-1' > All </option>";
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Branchid = batch.getElementsByTagName("Branchid")[0];
		var Branchname = batch.getElementsByTagName("Branchname")[0];
		var Selection = batch.getElementsByTagName("Selection")[0];
		 
		str=str+"<option value ='"+Branchid.childNodes[0].nodeValue+"'>"+Branchname.childNodes[0].nodeValue+"</option>";
	 }
     str=str+"</select>";  
      
      var tb=document.getElementById('BranchTable');
  	 tb.innerHTML=str  ; 
}
//End -Kalaiselvan--------------------------Branch............................














function loadDistrict(startletter)
 {
	var id=document.getElementById('state').value;  
	var search = document.getElementById('txtSer').value;  
    var url = "../Common?actionS=ATTdistrict&search="+escape(search)+"&id="+escape(id)+"&startletter="+escape(startletter);
	 
	initRequest(url);
	req.onreadystatechange = searchDistrictRequest;
    req.open("GET", url, true);
    req.send(null);
}

function searchDistrictRequest()
 {
    if(req.readyState == 4) 
    {
        ClearTables('districtTable');
     	 str="Total no of Records :: 0";
	  	 var tb=document.getElementById('totRec');
  		 tb.innerHTML=str   
  	     if (req.status == 200) 
  	     {
          searchDistrictMessages();
        }
    }
}


function searchDistrictMessages() 
{
	var id=document.getElementById('state').value;  
    var batchs = req.responseXML.getElementsByTagName("districts")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var district = batch.getElementsByTagName("districtId")[0];
        var districtName = batch.getElementsByTagName("districtName")[0];                               
		var editlink=""; 
    	var path=document.getElementById('path').value; 
    	var qp=document.getElementById('qp').value; 
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		tempId=district.childNodes[0].nodeValue;
		str=str+"<td width='100px'  align='left' class='boldEleven'> <input type='checkbox' name='districtId' value='"+tempId+"'>"+(loop+1);		
		str=str+"<td >";
		editlink="DistrictAction.jsp?action1=Edit&districtId="+tempId+"&state="+id+"&path="+path+"&qp="+qp;				
		str=str+"<a href='"+editlink+"'><font class='boldEleven'>"+districtName.childNodes[0].nodeValue;
		str=str+"</font></a>";		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true; 	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
    	document.getElementById('btnEdit').disabled=false ; 	 
     }
     var tb=document.getElementById('districtTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
}













//Load District
function LoadSelectDistrict(ctr)
 {
 	var url = "../Common?actionS=LoadSelectDistrict&State="+ctr.value;
 	initRequest(url);
	req.onreadystatechange=SelectDistrictRequest;
    req.open("GET", url, true);
    req.send(null);
     
}
 
function LoadSelectDistricts(ctr)
 {
 	var url = "Common?actionS=LoadSelectDistrict&State="+ctr.value;
 	initRequest(url);
	req.onreadystatechange=SelectDistrictRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function SelectDistrictRequest() 
 {
    if(req.readyState == 4) 
    { 
    	var _targ=document.getElementsByName('dist')[0];       
    	_targ.options.length=0;
    	_targ.options[0]=new Option('Select','0'); 
    	if (req.status == 200) 
        {		  	
          SelectDistrictMessages();
        }
    }
}
function SelectDistrictMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('dist')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
    var str=""; 
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
	 	
}




 //End ------------------------------District----------------------------





 




//----------------------------------------
//searching 
 
function LoadSearch(ctr)
 {
    var choice =document.getElementById('tb').value;
    var search=document.getElementById(ctr).value;
    if(choice == "")
    {
    	alert(" Choice yout category")
    }
    else  if(search == "")
    {
    	alert(" Enter search data...")
    }
    else
    {
    	searchname =  search.toUpperCase(); 	
 		var url = "../Common?actionS=INVsearch&search="+escape(search)+"&choice="+choice;
  		initRequest(url);
   		req.onreadystatechange = SearchRequest;
    	req.open("GET", url, true);
   		req.send(null);
   	}	
}
	
function SearchRequest()
 {
    LoadingTables('SearchTable');
    if(req.readyState == 4) {
        ClearTables('SearchTable');
         if (req.status == 200) {
          SearchMessage();
        }
    }
}

function SearchMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Fieldss")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";  
    str=str+"<tr bgcolor='#DCE4F9' >"
    
     for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	     
	    var batch = batchs.childNodes[loop];
        var Field1 = batch.getElementsByTagName("Field1")[0];
        var Field2 = batch.getElementsByTagName("Field2")[0];  
        var Field3 = batch.getElementsByTagName("Field3")[0]; 
        var Field4 = batch.getElementsByTagName("Field4")[0]; 
        var Field5 = batch.getElementsByTagName("Field5")[0]; 
        var Field6 = batch.getElementsByTagName("Field6")[0]; 
        var Field7 = batch.getElementsByTagName("Field7")[0];
        var Field8 = batch.getElementsByTagName("Field8")[0];
           
          
       	if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
	 
		var s = Field1.childNodes[0].nodeValue;
		s=s.replace(searchname,"9865043008");
		s = s.replace("9865043008","<font class='search' ><b>"+searchname+"</b></font>");
		str = str+"<td width=200 class='boldEleven'>"+s+"</td>";
		str = str+"<td width=125 class='boldEleven'>"+Field2.childNodes[0].nodeValue+"</td>";
		str = str+"<td width=125 class='boldEleven'>"+Field3.childNodes[0].nodeValue+"</td>";
		str = str+"<td width=125 class='boldEleven'>"+Field4.childNodes[0].nodeValue+"</td>";
		str = str+"<td width=125 class='boldEleven'>"+Field5.childNodes[0].nodeValue+"</td>";
		str = str+"<td width=125 class='boldEleven'>"+Field6.childNodes[0].nodeValue+"</td>";
	    }
     str=str+"</table>";  
        
  	 var tb=document.getElementById('SearchTable');
  	 tb.innerHTML=str  ; 
  	  
     
}



//----------------------------------------



