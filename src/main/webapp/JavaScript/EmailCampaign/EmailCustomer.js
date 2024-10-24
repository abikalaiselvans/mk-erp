var isIE;
var req;
var names;

 
function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
 
function ClearTable(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 
function LoadEmailCustomer(startLetter)
 {
 	
 	var group= document.getElementById('group').value;
 	var company= document.getElementById('company').value;
 	var branch= document.getElementById('branch').value;
 	var department= document.getElementById('department').value;
 	var designation= document.getElementById('designation').value;
 	var newsletter= document.getElementById('newsletter').value;
 	var active= document.getElementById('active').value;
 	var url = "../EmailCampaignAJAX?actionS=LoadEmailCustomer&startLetter="+escape(startLetter)+"&group="+group+"&company="+company+"&branch="+branch+"&department="+department+"&designation="+designation+"&newsletter="+newsletter+"&active="+active;
    initRequest(url);
	req.onreadystatechange=EmailCustomerRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function EmailCustomerRequest() {
    if(req.readyState == 4) {    	
        ClearTable('GroupTable');  
        var tb=document.getElementById('GroupTable');
  	 	tb.innerHTML="" ;
  	 	
  	 	var tb1=document.getElementById('totalrec');
  	 	tb1.innerHTML=" " ;
  	 	
  	 	
		document.getElementById('Edit').disabled=true; 
		document.getElementById('Delete').disabled=true;   		
        if (req.status == 200) 
        {		  	
          EmailCustomerMessages();
        }
    }
}
function EmailCustomerMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	str=str+"<tr class='MRow1'>";
    str=str+"<td  class='bold1'>S.No</td>";
    str=str+"<td  class='bold1'><div align='left'>Group Name</div></td>";
	str=str+"<td  class='bold1'><div align='left'>Company Name</div></td>";
	str=str+"<td  class='bold1'><div align='left'>Branch Name</div></td>";
	str=str+"<td  class='bold1'><div align='left'>Address</div></td>";
	str=str+"<td  class='bold1'><div align='left'>STD</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Phone</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Mobile</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Fax</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Department</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Designation</div></td>";
    str=str+"<td  class='bold1'><div align='left'>ContactName</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Email</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Newletter</div></td>";
    str=str+"<td  class='bold1'><div align='left'>Status</div></td>";
    str=str+"</tr>";
                
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var GroupName = batch.getElementsByTagName("GroupName")[0].childNodes[0].nodeValue;
	    var CompanyName = batch.getElementsByTagName("CompanyName")[0].childNodes[0].nodeValue;
	    var BranchName = batch.getElementsByTagName("BranchName")[0].childNodes[0].nodeValue;
	    var Address = batch.getElementsByTagName("Address")[0].childNodes[0].nodeValue;
	    var STD = batch.getElementsByTagName("STD")[0].childNodes[0].nodeValue;
	    var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
		var Mobile  = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    var Fax = batch.getElementsByTagName("Fax")[0].childNodes[0].nodeValue;
	    var Department = batch.getElementsByTagName("Department")[0].childNodes[0].nodeValue;
	    var Designation= batch.getElementsByTagName("Designation")[0].childNodes[0].nodeValue;
	    var ContactName= batch.getElementsByTagName("ContactName")[0].childNodes[0].nodeValue;
	    var Email= batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
		var Newletter= batch.getElementsByTagName("Newletter")[0].childNodes[0].nodeValue;
		var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;

        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
		str=str+"<td  class='boldEleven'>&nbsp;"+GroupName;
		str=str+"<td  class='boldEleven'>&nbsp;"+CompanyName;
		str=str+"<td  class='boldEleven'>&nbsp;"+BranchName;
		str=str+"<td  class='boldEleven'>&nbsp;"+Address;
		str=str+"<td  class='boldEleven'>&nbsp;"+STD;
		str=str+"<td  class='boldEleven'>&nbsp;"+Phone;
		str=str+"<td  class='boldEleven'>&nbsp;"+Mobile;
		str=str+"<td  class='boldEleven'>&nbsp;"+Fax;
		str=str+"<td  class='boldEleven'>&nbsp;"+Department;
		str=str+"<td  class='boldEleven'>&nbsp;"+Designation;
		str=str+"<td  class='boldEleven'>&nbsp;"+ContactName;
		str=str+"<td  class='boldEleven'>&nbsp;"+Email;
		if(Newletter =="B")
			str=str+"<td  class='boldEleven'>&nbsp;Both";
		else if(Newletter =="T")
			str=str+"<td  class='boldEleven'>&nbsp;Technical";
		else if(Newletter =="P")
			str=str+"<td  class='boldEleven'>&nbsp;Product";
			
		
		if(Status =="Y")
			str=str+"<td  class='boldEleven'>Active";
		else 
			str=str+"<td  class='boldEleven'><font color='red'><b>Inactive</b></font>";
		
		 
  }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     	document.getElementById('Delete').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     	document.getElementById('Delete').disabled=true;
     
     }	
	 str=str+"</table>";
     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font color='red'>Total no of Records ::</font>"+batchs.childNodes.length+"</center>"; 
     	
}












//Load company
function LoadSelectEmailCompany(ctr)
 {
 	var url = "../EmailCampaignAJAX?actionS=LoadSelectEmailCompany&id="+escape(ctr.value);
    initRequest(url);
	req.onreadystatechange=SelectEmailCompanyRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
  function SelectEmailCompanyRequest() {
    if(req.readyState == 4) { 
    	 if (req.status == 200) 
        {		  	
           	var _targ=document.getElementsByName('company')[0];       
   			 _targ.options.length=0;
    		_targ.options[0]=new Option('Select','0'); 
         	 SelectEmailCompanyMessages();
        }
    }
}
function SelectEmailCompanyMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('company')[0];       
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





//Load Branch



function LoadSelectEmailBranch(ctr)
 {
 	var url = "../EmailCampaignAJAX?actionS=LoadSelectEmailBranch&id="+escape(ctr.value);
    initRequest(url);
	req.onreadystatechange=SelectEmailBranchRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
  function SelectEmailBranchRequest() {
    if(req.readyState == 4) { 
    	 if (req.status == 200) 
        {		  	
          var _targ=document.getElementsByName('branch')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  
          SelectEmailBranchMessages();
        }
    }
}
function SelectEmailBranchMessages() 
{	 
    
    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('branch')[0];       
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


