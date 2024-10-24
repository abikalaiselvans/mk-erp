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

 
 
 function loadCessation(startLetter) 
{         
   
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var mode = document.getElementById('mode').value;
	var ndc = document.getElementById('ndc').value;
    var exitinterview = document.getElementById('exitinterview').value;
    var url = "../Payroll?actionS=PAYCessation&startLetter="+startLetter+"&type=1&ndc="+ndc+"&exitinterview="+exitinterview+"&month="+month+"&year="+year+"&mode="+mode;
    initRequest(url);
    req.onreadystatechange = loadCessationRequest;
    req.open("GET", url, true);
    req.send(null);
}
  
function loadCessations(startLetter) 
{         
	var ndc = document.getElementById('ndc').value;
	var mode = document.getElementById('mode').value;
	var exitinterview = document.getElementById('exitinterview').value;
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var url = "../Payroll?actionS=PAYCessation&startLetter="+document.getElementById('search').value+"&type=2&ndc="+ndc+"&exitinterview="+exitinterview+"&month="+month+"&year="+year+"&mode="+mode;
	initRequest(url);
    req.onreadystatechange = loadCessationRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadCessationRequest() 
{
	
    if(req.readyState == 4) 
    {
        ClearTable('CessationTable');
        ClearTabler('totRec'); 
        if (req.status == 200) 
        {		  	
          loadCessationMessages();
        }
    }
}

function loadCessationMessages() 
{
	try
	{
		
	    var batchs = req.responseXML.getElementsByTagName("Terms")[0];   	    
		var str=""; 
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  		                        
	    str=str+"<tr class='MRow1'> ";
	    str=str+"<td  align='center'><b>S.No</b></td> ";
	    str=str+"<td align='center'><b>Staff Id</b></td> ";
	    str=str+"<td align='center'><b>Staff Name</b></td> ";
	    str=str+"<td align='Center'><b>Branch</b></td> ";
	    str=str+"<td align='Center'><b>Joinning Date</b></td> ";
	    str=str+"<td align='Center'><b>Resign Date</b></td> ";
	    str=str+"<td align='Center'><b>TerminationType / Mode</b></td> ";
	    str=str+"<td align='Center'><b>NDC / ResignLetter</b></td> ";
	    str=str+"<td align='Center'><b>Exit Interview</b></td> ";
	    str=str+"<td align='Center'><b>Resign Letter</b></td> ";
	    str=str+"<td align='Center'><b>Export</b></td> ";
	    str=str+"<td align='Center'><b>Progress</b></td> ";
	    str=str+"</tr> ";
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {           		                           
		    var batch = batchs.childNodes[loop];
	        var Staffid = batch.getElementsByTagName("Staffid")[0].childNodes[0].nodeValue; 
	    	var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;
	    	var Companyame = batch.getElementsByTagName("Companyame")[0].childNodes[0].nodeValue;
	    	var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
	    	var Depart = batch.getElementsByTagName("Depart")[0].childNodes[0].nodeValue;
	    	var Desig = batch.getElementsByTagName("Desig")[0].childNodes[0].nodeValue;  
	    	var DDate = batch.getElementsByTagName("DDate")[0].childNodes[0].nodeValue;
	    	var Pfdate = batch.getElementsByTagName("Pfdate")[0].childNodes[0].nodeValue;  
	    	var NDCstatus = batch.getElementsByTagName("NDCstatus")[0].childNodes[0].nodeValue;  
	    	var Exitinterview = batch.getElementsByTagName("Exitinterview")[0].childNodes[0].nodeValue;
	    	var Bar = batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
	    	var DOJ = batch.getElementsByTagName("DOJ")[0].childNodes[0].nodeValue;
	    	var Issue = batch.getElementsByTagName("Issue")[0].childNodes[0].nodeValue;
	    	var TerminationType = batch.getElementsByTagName("TerminationType")[0].childNodes[0].nodeValue;
	    	var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
	    	var Mode = batch.getElementsByTagName("Mode")[0].childNodes[0].nodeValue;
	    	
	    	 
	    	
	    	if(loop%2==1)
				str=str+"<tr class='MRow2'>";
			else
			    str=str+"<tr  class='MRow1'>";
			
	    	if(Exitinterview =="N")
	    		str=str+"<td   class='boldEleven'><input type='checkbox' name='staffid' value='"+Staffid+"'>"+(loop+1)+".</td>";
	    	else
	    		str=str+"<td   class='boldEleven'>"+(loop+1)+".</td>";
	    
	    	
	    	str=str+"<td  class='boldEleven'>"+Staffid+"</td>";  		
			
	    	if(Exitinterview =="Y")
				str=str+"<td  class='boldEleven'>"+Staffname+"</td>";
			else
				str=str+"<td   class='boldEleven'><a href='CessationEdit.jsp?staffid="+Staffid+"'>"+Staffname+"</a> </td>";
			
			str=str+"<td class='boldEleven'>"+Branch+"</td>";
			//str=str+"<td class='boldEleven'>"+Depart+"</td>";
			str=str+"<td class='boldEleven'>"+DOJ+"</td>";
			str=str+"<td class='boldEleven'>"+DDate+"</td>";
			//str=str+"<td class='boldEleven'>"+TerminationType Pfdate+"</td>";
			if( ("Abscond" == TerminationType) && (Exitinterview !="Y") )
				str=str+"<td class='boldEleven'><a href='../SmartLoginAuth?filename=StaffCessation&actionS=PAYStaffExitInterview&staffid="+Staffid+"'><font class='boldgreen'>Close Exit Interview</font></a> "+TerminationType+"/"+Mode+"</td>";
			else
				str=str+"<td class='boldEleven'>"+TerminationType+" / " +Mode +"</td>";
			
			if((NDCstatus =="Y")  )
				str=str+"<td class='boldEleven'><font class='boldgreen'>CLOSED </font> </td>";
			else
				str=str+"<td  class='boldEleven'><font class='bolddeepred'>Pending</font>  ";
			
			if(Exitinterview =="Y")
				str=str+"<td class='boldEleven'><font class='boldgreen'>Finished</font></td>";
			else
				str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
			
			
			
			if(Issue =="N")
				str=str+"<td class='boldEleven'><font class='bolddeepred'>Not Issue</font></td>";
			else
				str=str+"<td class='boldEleven'><font class='boldgreen'>Issued</font></td>";
			
			
			if(Issue =="N" && Exitinterview =="Y" && NDCstatus =="Y")
			{
				str=str+"<td class='boldEleven'>";
				str=str+" <a target='_blank' href ='PrintResignLetter.jsp?empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>View</font></a> ";
				str=str+" / <a target='_blank' href ='Rept_JExportResignLetter.jsp?empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>Export</font></a> ";
				
				//str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=StaffCessation&actionS=PAYStaffCessationPDF&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>PDF</font></a>";
				str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=Rept_JExportResigningLetter&actionS=PAYRept_JExportResigningLetter&reportType=pdf&rptfilename1=ResigningLetter_lesser6Monthsnew&rptfilename2=ResigningLetter_greater6Monthsnew&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>PDF</font></a>";
				
				str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=Rept_JExportResigningLetterWord&actionS=PAYRept_JExportResigningLetter&reportType=rtf&rptfilename1=ResigningLetter_lesser6Monthsnew&rptfilename2=ResigningLetter_greater6Monthsnew&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>Doc</font></a>";
				 
				str=str+" / <a target='_blank' href='ResignletterIssue.jsp?Staffid="+Staffid+"'><font class='boldgreen'>Issue</font></a> ";
				str=str+"</td>";
			}
			else if(Issue =="Y" && Exitinterview =="Y" && NDCstatus =="Y" && usertype =="F")
			{
				str=str+"<td class='boldEleven'>";
				str=str+" <a target='_blank' href ='PrintResignLetter.jsp?empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>View</font></a> ";
				str=str+" / <a target='_blank' href ='Rept_JExportResignLetter.jsp?empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>Export</font></a> ";
				
				//str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=StaffCessation&actionS=PAYStaffCessationPDF&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>PDF</font></a>";
				str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=Rept_JExportResigningLetter&actionS=PAYRept_JExportResigningLetter&reportType=pdf&rptfilename1=ResigningLetter_lesser6Monthsnew&rptfilename2=ResigningLetter_greater6Monthsnew&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>PDF</font></a>";
				str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=Rept_JExportResigningLetterWord&actionS=PAYRept_JExportResigningLetter&reportType=rtf&rptfilename1=ResigningLetter_lesser6Monthsnew&rptfilename2=ResigningLetter_greater6Monthsnew&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>Doc</font></a>";
				
				str=str+"</td>";
			}
			else
				str=str+"<td class='boldEleven'>&nbsp;</td>";
			
			/*if ((Exitinterview =="Y") && (NDCstatus =="Y") )
			{
				str=str+"<td class='boldEleven'>";
				str=str+" <a target='_blank' href ='PrintResignLetter.jsp?empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>View</font></a> ";
				str=str+" / <a target='_blank' href ='Rept_JExportResignLetter.jsp?empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>Export</font></a> ";
				str=str+" / <a target='_blank' href ='../SmartLoginAuth?filename=StaffCessation&actionS=PAYStaffCessationPDF&empid="+Staffid+"' style='text-decoration:none'><font class='boldgreen'>PDF</font></a>";
				if(Issue =="N")
					str=str+" / <a target='_blank' href='ResignletterIssue.jsp?Staffid="+Staffid+"'><font class='boldgreen'>Issue</font></a> ";
				str=str+"</td>"; 
			}
			else
				str=str+"<td class='boldEleven'>&nbsp;</td>";
			*/
			
			str=str+"<td class='boldEleven'><progress class='progressBarContainerClass' value='"+Bar+"' max='100'></progress></td>";
			
			str=str+"</tr>";
	     }     
	  	if(batchs.childNodes.length<1)
	    	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
	    str=str+"</table>";
	    var tb=document.getElementById('CessationTable');
	  	tb.innerHTML=str; 
	 	 tb=document.getElementById('totRec');
	  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
	}
	catch(err)
	{
		alert(err);
	}
}

  