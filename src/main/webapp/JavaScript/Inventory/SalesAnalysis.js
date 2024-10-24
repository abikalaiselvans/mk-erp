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
 
  
var pperiod="";
//INVTargetAssignCGroup
function loadSalesAnalysisGroup(divisionid) 
{
	var yea=document.getElementById('year').value;   
	var Branch=document.getElementById('Branch').value;   
	var period=document.getElementById('period').value;  
	var division=document.getElementById('division').value;
	var payType=document.getElementById('payType').value;  
	pperiod= period;
	//Branch,division,period,payType,year
	var url = "../inventory?actionS=loadSalesAnalysisGroup&year="+escape(yea)+"&Branch="+Branch+"&period="+period+"&division="+division+"&payType="+payType+"&divisionid="+divisionid;     
	 
	initRequest(url);
    req.onreadystatechange = SalesAnalysisGroupRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SalesAnalysisGroupRequest() 
{
    if(req.readyState == 4) 
    {    	
    	ClearTable('TargetTable');
    	ClearTabler('totRec')
        if (req.status == 200) 
        {		  	
          SalesAnalysisGroupMessages();
        }
    }
}

function SalesAnalysisGroupMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
    var loop = batchs.childNodes.length;
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    var str1="";
    
    
    if("1" === pperiod)
    {
     	str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>APR</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>MAY</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>JUN</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>TOTAL</strong></td>";
    }
    else if("2" === pperiod)
    {
     	str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>JUL</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>AUG</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>SEP</strong></td>";
         str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>TOTAL</strong></td>";
    }
    else if("3" === pperiod)
    {
     	str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>OCT</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>NOV</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>DEC</strong></td>";
         str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>TOTAL</strong></td>";
    }
    else if("4" === pperiod)
    {
     	str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>JAN</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>FEB</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>MAR</strong></td>";
         str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>TOTAL</strong></td>";
    }
    else if("5" === pperiod)
    {
     	str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>APR</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>MAY</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>JUN</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>JUL</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>AUG</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>SEP</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>OCT</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>NOV</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>DEC</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>JAN</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>FEB</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>MAR</strong></td>";
        str1=str1+"<td class='boldEleven' colspan='2' align='center'><strong>TOTAL</strong></td>";
    }
    
    if(batchs.childNodes.length>0)
    {
    	 str=str+"<tr class='MRow1'><td  rowspan='2' align='center'><strong>S.NO</strong></td>";
         str=str+"<td class='boldEleven' rowspan='2' align='center'><strong >DIVISION</strong></td>";
         str=str+str1;
         str=str+"<tr class='MRow1'><td  align='center'>No of Invoice</td>";
         str=str+"<td  align='center'>Invoice Amount</td>";
         str=str+"<td  align='center'>No of Invoice</td>";
         str=str+"<td  align='center'>Invoice Amount</td>";
         str=str+"<td  align='center'>No of Invoice</td>";
         str=str+"<td  align='center'>Invoice Amount</td>";
         str=str+"<td  align='center'>No of Invoice</td>";
         str=str+"<td  align='center'>Invoice Amount</td>";
         if("5" === pperiod)
         {
			str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
			str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         	str=str+"<td  align='center'>No of Invoice</td>";
         	str=str+"<td  align='center'>Invoice Amount</td>";
         }
         
 	}
 	else
 	{
 		str = str+"<tr bgcolor=#ffffff><td ><span class='boldred'><center>Data not found...</center></span></td></tr>"
 	}
 	
 	
 	
 	if("5" != pperiod)
 	{
 		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Divname = batch.getElementsByTagName("Divname")[0];
        	var Month1 = batch.getElementsByTagName("Month1")[0];
        	var AmtMonth1 = batch.getElementsByTagName("AmtMonth1")[0];
        	var Month2 = batch.getElementsByTagName("Month2")[0];
        	var AmtMonth2 = batch.getElementsByTagName("AmtMonth2")[0];
        	var Month3 = batch.getElementsByTagName("Month3")[0];
        	var AmtMonth3 = batch.getElementsByTagName("AmtMonth3")[0];
        	var Totalnumber = batch.getElementsByTagName("Totalnumber")[0];
        	var TotalAmount = batch.getElementsByTagName("TotalAmount")[0];
        	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
		    	str=str+"<tr  class='MRow2'>";		
			str=str+"<td>"+(loop+1)+"</td>";
		
			str=str+"<td class='boldEleven'>"+Divname.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+Month1.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth1.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+Month2.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth2.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+Month3.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth3.childNodes[0].nodeValue+"</td>";;
			str=str+"<td class='boldEleven' align='right'>"+Totalnumber.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+TotalAmount.childNodes[0].nodeValue+"</td>";
			 
     	}
     }
     else
     {
     	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Divname = batch.getElementsByTagName("Divname")[0];
        	var Month1 = batch.getElementsByTagName("Month1")[0];
        	var AmtMonth1 = batch.getElementsByTagName("AmtMonth1")[0];
        	var Month2 = batch.getElementsByTagName("Month2")[0];
        	var AmtMonth2 = batch.getElementsByTagName("AmtMonth2")[0];
        	var Month3 = batch.getElementsByTagName("Month3")[0];
        	var AmtMonth3 = batch.getElementsByTagName("AmtMonth3")[0];
        	var Month4 = batch.getElementsByTagName("Month4")[0];
        	var AmtMonth4 = batch.getElementsByTagName("AmtMonth4")[0];
        	var Month5 = batch.getElementsByTagName("Month5")[0];
        	var AmtMonth5 = batch.getElementsByTagName("AmtMonth5")[0];
        	var Month6 = batch.getElementsByTagName("Month6")[0];
        	var AmtMonth6 = batch.getElementsByTagName("AmtMonth6")[0];
        	var Month7 = batch.getElementsByTagName("Month7")[0];
        	var AmtMonth7 = batch.getElementsByTagName("AmtMonth7")[0];
        	var Month8 = batch.getElementsByTagName("Month8")[0];
        	var AmtMonth8 = batch.getElementsByTagName("AmtMonth8")[0];
        	var Month9 = batch.getElementsByTagName("Month9")[0];
        	var AmtMonth9 = batch.getElementsByTagName("AmtMonth9")[0];
        	var Month10 = batch.getElementsByTagName("Month10")[0];
        	var AmtMonth10 = batch.getElementsByTagName("AmtMonth10")[0];
        	var Month11 = batch.getElementsByTagName("Month11")[0];
        	var AmtMonth11 = batch.getElementsByTagName("AmtMonth11")[0];
        	var Month12 = batch.getElementsByTagName("Month12")[0];
        	var AmtMonth12 = batch.getElementsByTagName("AmtMonth12")[0];
			var Totalnumber = batch.getElementsByTagName("Totalnumber")[0];
        	var TotalAmount = batch.getElementsByTagName("TotalAmount")[0];

        	if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
		    	str=str+"<tr  class='MRow2'>";		
			str=str+"<td>"+(loop+1)+"</td>";
		
			str=str+"<td class='boldEleven'>"+Divname.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month4.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth4.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month5.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth5.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month6.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth6.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month7.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth7.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month8.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth8.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month9.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth9.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month10.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth10.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month11.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth11.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month12.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth12.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month1.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth1.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month2.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth2.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Month3.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+AmtMonth3.childNodes[0].nodeValue;
			str=str+"<td class='boldEleven' align='right'>"+Totalnumber.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+TotalAmount.childNodes[0].nodeValue+"</td>";
     	}
     }	
     
     str=str+"</table>";
     
     var tb=document.getElementById('TargetTable');
  	 tb.innerHTML=str ;
  	 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	
}		


 