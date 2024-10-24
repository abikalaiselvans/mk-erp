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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

 
var searchname="";
function LoadSearchStaff( )
{
   try
   {
	 	var search=document.getElementById('searchstaff').value;
	 	var resigned="N";
	 	if(document.getElementById('resigned').checked)
	 		resigned="Y";
	 	var confirmation="N";
	 	if(document.getElementById('confirmation').checked)
	 		confirmation="Y"; 
	 	else
	 		confirmation="N";
	 	var modified="N";
	    if(document.getElementById('modified').checked)  
	    	modified="Y";
	    else
	    	modified="N";  
	    
	 	var f = true;
	 	if(search=="")
	 	{
	 		searchname="";
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
	 		var url = "../SmartCommonAjax?actionS=loadStaffSearch&stype=1&search="+escape(search)+"&resigned="+resigned+"&confirmation="+confirmation+"&modified="+modified;
	 		//alert(url);
	 		initRequest(url);
	   		req.onreadystatechange = StaffRequest;
	    	req.open("GET", url, true);
	   		req.send(null);
	   	}	
   }
   catch(err)
   {
	   alert(err)
   }
}
	
function StaffRequest()
{
    ClearTabler('totRec');
    ClearTable('staffTable');
    if(req.readyState == 4) 
    {
         if (req.status == 200) 
         {
          	StaffMessage();
        }
    }
}


function StaffMessage() 
{	
    try
    {
		var batchs = req.responseXML.getElementsByTagName("Staffs")[0];
	    var str=""; 
	    str=str+"<table width='100%'  class='table table-bordered'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
	   /* str=str+"<tr  class='active'>";
	    str=str+"<td width='10%'><div align='center'>Staff Id</div></td> ";
	    str=str+"<td width='10%'><div align='center'>Staff Name</div></td> ";
	    str=str+"<td width='10%'><div align='center'>Father Name</div></td> ";
	    str=str+"<td width='10%'><div align='center'> Branch</div></td> ";
	    str=str+"<td width='10%'><div align='center'> Department</div></td> ";
	    str=str+"<td width='10%'><div align='center'>Designation</div></td> ";
	    str=str+"<td width='10%'><div align='center'>Mobile</div></td> ";
	    str=str+"<td width='10%'><div align='center'>&nbsp;</div></td> ";
	    str=str+"<td width='10%'><div align='center'>&nbsp;</div></td> ";
	    str=str+"<td width='10%'><div align='center'>&nbsp;</div></td> ";
	    str=str+"</tr> ";*/
	    
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
	        var MiddleName = batch.getElementsByTagName("MiddleName")[0].childNodes[0].nodeValue; 
	        var Usertype = batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
	        var Bar = batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
	        var Rejoin = batch.getElementsByTagName("Rejoin")[0].childNodes[0].nodeValue;
	        var Approval = batch.getElementsByTagName("Approval")[0].childNodes[0].nodeValue;
	        var Employee = batch.getElementsByTagName("Employee")[0].childNodes[0].nodeValue;
	        var Modification = batch.getElementsByTagName("Modification")[0].childNodes[0].nodeValue;
		    
	        
	        
	        if(Approval == "N")
	        {
	        	str=str+"<tr class='warning'>";
	        }
	        else if(Modification == "Y")
	        {
	        	 
	        	str=str+"<tr class='warning'>";
	        }
	        else
	        {    
		        if("T"==Termination)
		       	 str=str+"<tr class='danger'>";
		        else
		        {   
			       	if(loop%2==1)
						str=str+"<tr class='active'>";
					else
					    str=str+"<tr  class='active'>";
		        }
	        }
			var t="";
			
			if("T"==Termination)
				t= "class = 'boldred'";
			else
				t= "class='boldgreen'";
			
	        
	       	var s = StaffId;
			s=s.replace(searchname,"9865043008");
			s = s.replace("9865043008","<b><span class='tMLAscreenHead'>"+searchname+"</span></b>");
			
		   str=str+"<td width='10%' class='boldEleven'><input type='checkbox' name='staffid' value='"+StaffId+"'>";
	       if(Rejoin=="Y")
	    	   str=str+"&nbsp;[ Rejoin ]";
			
			if(Usertype=="B" || Usertype=="F")
	        	str=str+"<a href=StaffRegistrationEdit.jsp?path=ATT&qp=ATT&staffid="+StaffId+" ><font "+t+">"+s+"</font></a> ";
	        else
	        	str=str+"<a href=StaffRegistrationEdits.jsp?path=ATT&qp=ATT&staffid="+StaffId+"><font "+t+">"+s+"</font></a> ";
	        str = str+"</td>";
	        
	        str = str + "<td width='10%' class='boldEleven'> "+StaffName+" </td>";
			str = str + "<td width='10%' class='boldEleven'> "+MiddleName+"</td>";
			//str = str + "<td class='boldEleven'> "+Company+"</td>";
			str = str + "<td width='10%' class='boldEleven'> "+BranchName+"</td>";
			str = str + "<td width='10%' class='boldEleven'> "+DepartName+"</td>";
			str = str + "<td width='10%' class='boldEleven'> "+DesigName+"</td>";
			str = str + "<td width='10%' class='boldEleven'> "+Mobile+"</td>";
			
			str = str + "<td width='10%' class='boldEleven'> ";
			str = str + "<div class='progress'> ";
			str = str + "<div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"+Bar+"' aria-valuemin='0' aria-valuemax='100' style='width:50'> ";
			str = str + "  "+Bar+"%  ";
			str = str + "</div> ";
			str = str + "</div> ";
			str = str + "</td>";
		  
			
			//str = str + "<td class='boldEleven'><a target='_blank' href=\"../Smart Common/Staffidcard.jsp?staffid="+StaffId+"\">Id Card</a> </td>";;
			
			if(Employee == "R")
				str=str+"<td width='10%' class='boldEleven'><font class='boldgreen'>REGULAR</font></td>"  ;
			else
				str=str+"<td width='10%' class='boldEleven'><font class='boldgreen'>NON REGULAR</font></td>"  ;
			
			
			if(Approval != "P")
			{	

				if( (Approval == "Y") &&(Modification == "N") )
					str=str+"<td width='10%' class='boldEleven'><font class='boldgreen'>&nbsp;</font></td>"  ;
				else if( (Approval == "N") && (Modification == "Y") )
					str=str+"<td width='10%' class='boldEleven'><button type='button' class='btn btn-warning btn-sm'>Modify</button></td>"  ;
				else
					str=str+"<td width='10%' class='boldEleven'><a href='StaffRegistrationVerification.jsp?staffid="+StaffId+"'><button type='button' class='btn btn-danger btn-sm'>Approval</button></a></td>"  ;
				
			}
			else
			{
				str=str+"<td width='10%' class='boldEleven'><font class='bolddeepred'>Incomplete, Please wait...</td>"  ;	
			}
			str = str + " </tr>";
	     }
	     str=str+"</table>";     
	  	 var tb=document.getElementById('staffTable');
	  	 tb.innerHTML=str  ; 
	  	 tb=document.getElementById('totRec');
	  	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font><br>"  ; 
  	  
    }
    catch(err)
    {
    	alert(err);
    }
}

 