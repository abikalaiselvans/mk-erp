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


function loadAllCustomer()
{
	var sr=document.getElementById('search').value; 
	var verified=document.getElementById('verified').value;
	var customertype=document.getElementById('customertype').value;
	var customergroup=document.getElementById('customergroup').value;
	var url = "../inventory?actionS=INVAllCustomerData&startLetter="+sr+"&searchtype=2&verified="+verified +"&customertype="+customertype+"&customergroup="+customergroup;
	initRequest(url);
	req.onreadystatechange = AllcustomerRequest;
	req.open("GET", url, true);
	req.send(null);
	 
} 


function loadAllCustomers(start)
{
	loadAllCustomerss(start);
} 

var searchs="";
function loadAllCustomerss(val) 
{
	var verified=document.getElementById('verified').value;
	var customertype=document.getElementById('customertype').value;
	var customergroup=document.getElementById('customergroup').value;
	
	var url = "../inventory?actionS=INVAllCustomerData&startLetter="+val+"&searchtype=1&verified="+verified+"&customertype="+customertype+"&customergroup="+customergroup ;
	initRequest(url);
	req.onreadystatechange = AllcustomerRequest;
	req.open("GET", url, true);
	req.send(null);
}

function AllcustomerRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTable('CustomerTable');
        ClearTabler('totRec');
        if (req.status == 200) 
        {
         allCustomerDetails();
        }
    }
}

 
function allCustomerDetails() 
{

    var batchs = req.responseXML.getElementsByTagName("Customers")[0]; 
   	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
    str=str+"<tr class='MRow1'>";
    str=str+"<td ><div align='center'><b>S.No</div></td>";
    str=str+"<td ><div align='center'><b>Customer Name </div></td>";
    str=str+"<td ><div align='center'><b>Alias </div></td>";
    str=str+"<td ><div align='center'><b>Contact Person </div></td>";
    str=str+"<td ><div align='center'><b>City</div></td>";
    str=str+"<td ><div align='center'><b>District</div></td>";
    str=str+"<td ><div align='center'><b>State</div></td>";
    str=str+"<td ><div align='center'><b>Pincode</div></td>";
    str=str+"<td ><div align='center'><b>Phone</div></td>";
    str=str+"<td ><div align='center'><b>Email</div></td>";
    str=str+"<td ><div align='center'><b>Active</div></td>";
    str=str+"<td ><div align='center'><b>Verified</div></td>";
    str=str+"<td ><div align='center'><b>TAX Examption</div></td>";
    str=str+"</tr>";
	
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	
	    var batch = batchs.childNodes[loop];
        var CustomerId = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;        
        var CustomerName = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
        var Cperson = batch.getElementsByTagName("Cperson")[0].childNodes[0].nodeValue;
        var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;  
		var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;  
        var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;       
        var state = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;               	 
        var Email=batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue; 
        var Active=batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue; 
        var Verified=batch.getElementsByTagName("Verified")[0].childNodes[0].nodeValue;
        var Alias=batch.getElementsByTagName("Alias")[0].childNodes[0].nodeValue;
        var Pincode=batch.getElementsByTagName("Pincode")[0].childNodes[0].nodeValue;
        var taxexamption=batch.getElementsByTagName("taxexamption")[0].childNodes[0].nodeValue;
        var taxexamptionno=batch.getElementsByTagName("taxexamptionno")[0].childNodes[0].nodeValue;
        
       
		if(Verified == "N")
			str=str+"<tr class='MRow0'>";
		else
		{
	        if(loop%2==0)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
		}	
	 
		str=str+"<td   align=left class='boldEleven'><input type='checkbox' name='custid' value='"+CustomerId +"'>"+(loop+1)+".</td>";
		//str=str+"<td   align=left class='boldEleven'> "+CustomerName +" </td>";
		str=str+"<td   align=left class='boldEleven'><a href='CustomerInfoEdit.jsp?custid="+CustomerId +"'><font class='boldgreen'>"+CustomerName +"</font></a></td>";
		str=str+"<td   align=left class='boldEleven'>"+Alias +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Cperson +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+City +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+District +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+state +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Pincode +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Phone +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Email +"</td>";
		
		if("1" === Active )
			str=str+"<td   align=left class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td   align=left class='boldEleven'><font class='bolddeepred'>Inactive</font></td>";
		
			
		if("Y" === Verified )
			str=str+"<td   align=left class='boldEleven'><font class='boldgreen'>Verified</font></td>";
		else
			str=str+"<td   align=left class='boldEleven'><font class='bolddeepred'>Verification Pending</font></td>";
		
		//<a href=\"javascript:DCUpload('"+Pono +"')\"><font class=boldgreen>Upload Invoice</font></a>
		if("Y" == taxexamption )
			str=str+"<td   align=left class='boldEleven'><font class='boldgreen'>"+taxexamptionno+"</font></td>";
		else
			str=str+"<td   align=left class='boldEleven'><font class='bolddeepred'>&nbsp;</font></td>";
		
		
		  
		str=str+"</tr>";
		
     }
     str=str+"</table>";
     var tb=document.getElementById('CustomerTable');
  	 tb.innerHTML=str   
  	 str="<font color='red'>Total no of Records :: "  + loop+"</font>";  	
  	  	
  	 var tb=document.getElementById('totRec');  	 
  	 tb.innerHTML=str   
   
  	
}

