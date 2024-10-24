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


function loadBank()
{
	var sr=document.getElementById('search').value;
	var bankgroup=document.getElementById('bankgroup').value;
	var url = "../inventory?actionS=loadBanks&startLetter="+sr+"&searchtype=2&bankgroup="+bankgroup ;
	initRequest(url);
	req.onreadystatechange = loadBanksRequest;
	req.open("GET", url, true);
	req.send(null);
	 
} 


function loadBanks(start)
{
	loadBankss(start);
} 


var searchs="";
function loadBankss(val) 
{
	var bankgroup=document.getElementById('bankgroup').value;
	var url = "../inventory?actionS=loadBanks&startLetter="+val+"&searchtype=1&bankgroup="+bankgroup ;
	initRequest(url);
	req.onreadystatechange = loadBanksRequest;
	req.open("GET", url, true);
	req.send(null);
}

function loadBanksRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTable('CustomerTable');
        ClearTabler('totRec');
        if (req.status == 200) 
        {
        	loadBanksDetails();
        }
    }
}

 
function loadBanksDetails() 
{

    var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
   	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
    str=str+"<tr class='MRow1'>";
    str=str+"<td ><div align='center'><b>S.No</div></td>";
    str=str+"<td ><div align='center'><b>Group</div></td>";
    str=str+"<td ><div align='center'><b>Branch </div></td>";
    str=str+"<td ><div align='center'><b>BranchCode</div></td>";
    str=str+"<td ><div align='center'><b>IFSC</div></td>";
    str=str+"<td ><div align='center'><b>Address1</div></td>";
    str=str+"<td ><div align='center'><b>Address2</div></td>";
    str=str+"<td ><div align='center'><b>City</div></td>";
    str=str+"<td ><div align='center'><b>District</div></td>";
    str=str+"<td ><div align='center'><b>State</div></td>";
    str=str+"<td ><div align='center'><b>Pin</div></td>";
    str=str+"<td ><div align='center'><b>Mobile</div></td>";
    str=str+"</tr>";
	
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;
	    var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    var BranchCode = batch.getElementsByTagName("BranchCode")[0].childNodes[0].nodeValue;
	    var IFSC = batch.getElementsByTagName("IFSC")[0].childNodes[0].nodeValue;
	    var Address1 = batch.getElementsByTagName("Address1")[0].childNodes[0].nodeValue;
	    var Address2 = batch.getElementsByTagName("Address2")[0].childNodes[0].nodeValue;
	    var City  = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
	    var District  = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
	    var State  = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
	    var Pin  = batch.getElementsByTagName("Pin")[0].childNodes[0].nodeValue;
	    var Mobile  = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td   align=left class='boldEleven'><input type='checkbox' id='rowid'  name='rowid' value='"+Id+"'>"+(loop+1)+".</td>";
		str=str+"<td   align=left class='boldEleven'>"+Group +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Branch+"</td>";
		//str=str+"<td   align=left class='boldEleven'><a href='BankAction.jsp?action1=EDIT&rowid="+Id+"'><font class='boldgreen'>"+Branch+"</font></a></td>";
		str=str+"<td   align=left class='boldEleven'>"+BranchCode +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+IFSC +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Address1 +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Address2 +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+City+"</td>";
		str=str+"<td   align=left class='boldEleven'>"+District +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+State+"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Pin +"</td>";
		str=str+"<td   align=left class='boldEleven'>"+Mobile +"</td>";
		str=str+"</tr>";
		
     }
    
     str=str+"</table>";
     var tb=document.getElementById('CustomerTable');
  	 tb.innerHTML=str   
  	 str="<font color='red'>Total no of Records :: "  + loop+"</font>";  	
  	  	
  	 var tb=document.getElementById('totRec');  	 
  	 tb.innerHTML=str   
   
  	
}

