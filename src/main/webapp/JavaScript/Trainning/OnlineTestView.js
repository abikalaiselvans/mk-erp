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
	 var str="<br><br><center><font color=red><b>Data not found<b></font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}
  
function ClearTabler(ctr1)
{
	 var str="<br><br><center><font color=red><b>Total no of records : 0 <b></font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str  
}
 
 
 
 
  
function loadOnlineTestDetails (startLetter) 
{    
	var mon=document.getElementById('month').value; 	
	var yr=document.getElementById('year').value;  
	var type=document.getElementById('type').value; 
	var result=document.getElementById('result').value; 
	var url = "../SmartTrainning?actionS=loadOnlineTestDetails&mon="+escape(mon)+"&yr="+escape(yr)+"&startLetter="+escape(startLetter)+"&type="+type+"&result="+result 
     
	initRequest(url);
    req.onreadystatechange = loadOnlineTestDetailsRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadOnlineTestDetailsRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTable('applicationTable');
        ClearTabler('totrec');
        if (req.status == 200) 
        {
			loadOnlineTestDetailsDetails();
        }
		 
		
    }
}
function loadOnlineTestDetailsDetails()
 {
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];  
    
	var str=""; 
    str=str+"<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr  class='MRow1'> ";
	str=str+"<td class='bold1' >S.No</td> ";
	str=str+"<td class='bold1' >Emp Id</td> ";
	str=str+"<td class='bold1' >Emp Name</td>  ";
	str=str+"<td class='bold1' >Test name</td> ";
	str=str+"<td class='bold1' >No of question</td> ";
	str=str+"<td class='bold1' >Duration ( minutes )</td> ";
	str=str+"<td class='bold1' >Date </td> ";
	str=str+"<td class='bold1' >Result</td> ";
	str=str+"<td class='bold1' >Noofattempt </td> ";
	str=str+"<td class='bold1' >View / Print </td> ";
	str=str+"</tr> ";
	  

      	 	
              
             
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var empid = batch.getElementsByTagName("empid")[0].childNodes[0].nodeValue;
	    var empname = batch.getElementsByTagName("empname")[0].childNodes[0].nodeValue;
	    var testname = batch.getElementsByTagName("testname")[0].childNodes[0].nodeValue;
	    var noofquestion = batch.getElementsByTagName("noofquestion")[0].childNodes[0].nodeValue;
	    var duration = batch.getElementsByTagName("duration")[0].childNodes[0].nodeValue;
	    var percentage = batch.getElementsByTagName("percentage")[0].childNodes[0].nodeValue;
	    var date = batch.getElementsByTagName("date")[0].childNodes[0].nodeValue;
	    var result = batch.getElementsByTagName("result")[0].childNodes[0].nodeValue;
	    var noofattempt = batch.getElementsByTagName("noofattempt")[0].childNodes[0].nodeValue;; 
	    var testid = batch.getElementsByTagName("testid")[0].childNodes[0].nodeValue;;
	    
		
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	

	    str=str+"<td align='left' class='boldEleven'>";
	    str=str+"&nbsp;"+(loop+1)+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+empid+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+empname+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+testname+"</td>";		
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+noofquestion+"</td>";		
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+duration+"</td>";
		str=str+"<td align='left' class='boldEleven'>&nbsp;"+date +"</td>";
		if("P" == result)
			str=str+"<td align='left' class='boldEleven'><font class='boldgreen'>PASS</font></td>";
		else
			str=str+"<td align='left' class='boldEleven'><font class='bolddeepred'>FAIL</font></td>";
	    str=str+"<td align='left' class='boldEleven'>&nbsp;"+noofattempt +"</td>";
	    str=str+"<td align='left' class='boldEleven'>";
	    str=str+"<a href='OnlineTestResult.jsp?applicantid="+empid+"&testid="+testid+"' target='_blank'><font class='boldgreen'>View</font></a>";
	    str=str+"&nbsp;&nbsp;/&nbsp;&nbsp;";
	    str=str+"<a href='OnlineTestResultPrints.jsp?applicantid="+empid+"&testid="+testid+"' target='_blank'><font class='boldgreen'>Print</font></a>";
	     str=str+"</td>";
	    
	}

     str=str+"</table>";
     var tb=document.getElementById('applicationTable');
  	 tb.innerHTML=str   
	
  	 tb=document.getElementById('totrec');
 	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
 	
 
 } 	
 
 
  