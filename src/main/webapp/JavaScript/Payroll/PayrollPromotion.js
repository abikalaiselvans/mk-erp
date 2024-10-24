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
function loadPromotion(startLetter) 
{
    var url = "../Payroll?actionS=PAYPromotion&startLetter="+startLetter ;
	initRequest(url);
    req.onreadystatechange = loadPromotionRequest;
    req.open("GET", url, true);
    req.send(null);
}



function loadPromotions(startLetter) 
{
    var url = "../Payroll?actionS=PAYPromotion&startLetter="+document.getElementById('search').value;
	initRequest(url);
    req.onreadystatechange = loadPromotionRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadPromotionRequest() 
{
    if(req.readyState == 4) 
    {    	
    	ClearTable('PromotionTable');
        ClearTabler('totalrecord');
        if (req.status == 200) 
        {		  	
          loadPromotionMessages();
        }
    }
}



function loadPromotionMessages() 
{   
    var batchs = req.responseXML.getElementsByTagName("Promotions")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
    str=str+" <tr class='MRow1'> ";
	str=str+"<td ><div align='center'>S.No</div></td> ";
	str=str+"<td ><div align='center'>Staff Id</div></td> ";
	str=str+"<td ><div align='center'>Staff Name</div></td> ";
	str=str+"<td ><div align='center'>Company</div></td> ";
	str=str+"<td ><div align='center'>Branch</div></td> ";
	str=str+"<td ><div align='center'>Department</div></td> ";
	str=str+"<td ><div align='center'>Designation</div></td> ";
	str=str+"<td ><div align='center'>No.of.Promotion</div></td> ";
	str=str+"</tr> ";
    
    for(loop = 0; loop < batchs.childNodes.length; loop++) {           		                           
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0]; 
    	var Staffname = batch.getElementsByTagName("Staffname")[0];
    	var Companyame = batch.getElementsByTagName("Companyame")[0];
    	var Branch = batch.getElementsByTagName("Branch")[0];
    	var Depart = batch.getElementsByTagName("Depart")[0];
    	var Desig = batch.getElementsByTagName("Desig")[0];  
    	var NoofPromotion = batch.getElementsByTagName("NoofPromotion")[0];    	  	   	
    	
    	if(loop%2==1)
			str=str+"<tr class='MRow2'>";
		else
		    str=str+"<tr  class='MRow1'>";
		    		
		str=str+"<td  class='boldEleven'><input type='checkbox' name='staffid' value='"+Staffid.childNodes[0].nodeValue+"'>"+(loop+1)+"</td>";
		str=str+"<td   class='boldEleven'>"+Staffid.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'><a href='StaffPromotionEdit.jsp?staffid="+Staffid.childNodes[0].nodeValue+"'>"+Staffname.childNodes[0].nodeValue+"</a> </td>";
		str=str+"<td  class='boldEleven'>"+Companyame.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+Branch.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+Depart.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+Desig.childNodes[0].nodeValue+"</td>";
		str=str+"<td  class='boldEleven'>"+NoofPromotion.childNodes[0].nodeValue+"</td>";
		str=str+"</td></tr>";
     }     
  	if(batchs.childNodes.length<1)
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('PromotionTable');
  	tb.innerHTML=str;
  	
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
  	 
  	 
} 