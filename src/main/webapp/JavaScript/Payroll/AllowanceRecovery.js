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
 

function loadAllowRecvs(startLetter) 
{
    var Search =document.getElementById('Search').value;
    var Office =document.getElementById('Office').value;
    var resigner ="N";
    if(document.getElementById('resigner').cheked)
    	resigner ="Y";
    else
    	resigner ="N";
    searchname=Search.toUpperCase(); 
    var url = "../Payroll?actionS=AllowanceRecovery&Search="+Search+"&startLetter="+startLetter+"&resigner="+resigner;
    url = url+"&Office="+Office;
	initRequest(url);
    req.onreadystatechange = loadAllowanceRequest;
    req.open("GET", url, true);
    req.send(null);
}



function loadAllowRecv(startLetter) 
{
    var Office =document.getElementById('Office').value;
    var resigner ="N";
    if(document.getElementById('resigner').cheked)
    	resigner ="Y";
    else
    	resigner ="N";
    
    var url = "../Payroll?actionS=AllowanceRecovery&Search=0&startLetter="+startLetter+"&resigner="+resigner;;
    url = url+"&Office="+Office;
    initRequest(url);
    req.onreadystatechange = loadAllowanceRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadAllowanceRequest() 
{
	ClearTable('AllowRecv');
	ClearTabler('totrec');
    if(req.readyState == 4) {    	
           
       if (req.status == 200) {		  	
          loadAllowanceMessages();
        }
    }
}

function loadAllowanceMessages() 
{  
    var loop=0;
  	var batchs = req.responseXML.getElementsByTagName("Rows")[0];
	var str="";
	str=str+"<table width='100%'   class='table table-bordered'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<tr class='MRow2'>";
	str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Emp Id</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Name</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Allowance</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Recovery</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Basic</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Added Allowance</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Other Allowance</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Gross</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Recovery</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>PF Calculation Type</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Employer PF</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Employer ESI</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>CTC</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Employee PF</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Employee ESI</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Profession Tax</b></td>";
	str=str+"<td class='boldEleven' align='center'><b>Take Home</b></td>";
	 
	//str=str+"<td class='boldEleven' align='center'><b>Appoinment Letter</b></td>";
	//str=str+"<td class='boldEleven' align='center'><b>Annexture</b></td>";
	str=str+"</tr>";
	
	var tot = batchs.childNodes.length;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
	{           		                           
	    var batch1 = batchs.childNodes[loop];
        var Staffid = batch1.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue;
    	var Staffname = batch1.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
    	var Type = batch1.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
    	var Allowanceflag = batch1.getElementsByTagName("Allowanceflag")[0].childNodes[0].nodeValue; 
    	var Recoveryflag = batch1.getElementsByTagName("Recoveryflag")[0].childNodes[0].nodeValue; 
    	var Basic = batch1.getElementsByTagName("Basic")[0].childNodes[0].nodeValue; 
    	var AddedAllowance = batch1.getElementsByTagName("AddedAllowance")[0].childNodes[0].nodeValue;
    	var OtherAllowance = batch1.getElementsByTagName("OtherAllowance")[0].childNodes[0].nodeValue;
    	var Gross = batch1.getElementsByTagName("Gross")[0].childNodes[0].nodeValue;
    	var Recovery = batch1.getElementsByTagName("Recovery")[0].childNodes[0].nodeValue;
    	var PF = batch1.getElementsByTagName("PF")[0].childNodes[0].nodeValue;
    	var ESI = batch1.getElementsByTagName("ESI")[0].childNodes[0].nodeValue;
    	var CTC = batch1.getElementsByTagName("CTC")[0].childNodes[0].nodeValue;
    	var usertype = batch1.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
    	var PFCalculationType = batch1.getElementsByTagName("PFCalculationType")[0].childNodes[0].nodeValue;
    	var EESI = batch1.getElementsByTagName("EESI")[0].childNodes[0].nodeValue;
    	var EPF = batch1.getElementsByTagName("EPF")[0].childNodes[0].nodeValue;
    	var ProfessionalTax = batch1.getElementsByTagName("ProfessionalTax")[0].childNodes[0].nodeValue;
    	var Takehome = batch1.getElementsByTagName("Takehome")[0].childNodes[0].nodeValue;
    	
    	
      	if(Type == "T")  	
    		str=str+"<tr  class='danger'>";
    	else
    	{
    		if(loop%2==1)
				str=str+"<tr class='success'>";
			else
		    	str=str+"<tr  class='success'>";
		}
		
      	if(Type == "T") 
      		str=str+"<td class='boldEleven'>"+(loop+1)+"</td>";
      	else
      		str=str+"<td class='boldEleven'>"+(loop+1)+".<input type='checkbox' name='staffid' id='staffid' value='"+Staffid+"'></td>";
      	
		str=str+"<td class='boldEleven'>"+Staffid+"</td>";
		var js ="<a href=javascript:AllowanceAdd('"+escape(Staffid)+"') ><font class='boldgreen'>"+ Staffname +"</font></a> "  ;
		
		if(   ( (usertype == "B")||(usertype == "F")  ) && (Type != "T") ) 
			str=str+"<td width='100' class='boldEleven'>"+js+"</td>";
		else
			str=str+"<td width='100' class='boldEleven'>&nbsp;"+Staffname+"</td>";
			
		str=str+"<td class='boldEleven'>"+Allowanceflag+"</td>";
		str=str+"<td class='boldEleven'>"+Recoveryflag+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+Basic+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+AddedAllowance+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+OtherAllowance+"</td>";
		if( (usertype == "B") ||  (usertype == "F") )
		{	
			str=str+"<td class='boldEleven' align='right'>"+Gross+"</td>";
			str=str+"<td class='MRow4' align='right'>"+Recovery+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+PFCalculationType+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+PF+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+ESI+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+CTC+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+EPF+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+EESI+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+ProfessionalTax+"</td>";
			str=str+"<td class='boldEleven' align='right'>"+Takehome+"</td>";
		}
		else
		{
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='MRow4' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			str=str+"<td class='boldEleven' align='right'>&nbsp;</td>";
			
		}
		
		//str=str+"<td class='boldEleven'><a target='_blank' href='../hrmCon?pageAction=appointment&empid="+Staffid+"'><font class='boldgreen'><spam class='badge'>Appointment Letter</spam></font></a></td>";
		//str=str+"<td class='boldEleven'><a target='_blank' href='../SmartLoginAuth?actionS=PAYAppointmentAnnexure&filename=Rept_JAppointmentAnnexure&rptfilename=PayrollAnnexure&reportType=pdf&ename="+Staffid+"'><font class='boldgreen'><spam class='badge'>Annexture</spam></font></a></td>";
		str=str+"</tr>";
		
	}
	str=str+"</table>";
	var tb=document.getElementById('AllowRecv');
  	tb.innerHTML=str;  
  	
    tb=document.getElementById('totrec');
 	tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
 	   
  	 	
}


function appoinmentLetter(staffid)
{  
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var query="../hrmCon?pageAction=appointment&empid="+staffid
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
	window.close();
}

  