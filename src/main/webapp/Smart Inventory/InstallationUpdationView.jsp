 <%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

 

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript">

function Add()
	{ 
		try
		{
			
			obj = findObj("salesid");
			if(obj == null)
			{
				alert("Sales Number not available...");
				return false;
			}
		
			var count;
			count=0;
			coffee1=document.forms[0].salesid;
			txt=""
			for (i=0;i<coffee1.length;++ i)
			{
				if (coffee1[i].checked)
				{
				count=count+1;
				}
			}
			if(count==0)
			{
				if (document.forms[0].salesid.checked) { count=1;}
			}
			if(count==1){			
				document.frm.action="InstallationUpdation.jsp";
				return true;
			}
			else
			{
				alert("Select Only one Value");
				return false;
			}
			
		}
		catch(err)
		{
			alert(err);
		}		 
 	}




var isIE;
var req;
var names;

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

function LoadInstallationUpdation(startletter) 
{
	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
    var customer=document.getElementById('customer').value; 
    var division=document.getElementById('division').value; 
    var status=document.getElementById('status').value; 
	var branch=document.getElementById('Accbranch').value;
    var url = "../inventoryCustomer?actionS=INVLoadInstallationUpdation&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&customer="+customer+"&division="+division+"&status="+status+"&branch="+branch;
	
    initRequest(url);   
    req.onreadystatechange = ADirectSwapRequest;
    req.open("GET", url, true);
    req.send(null);
}
function ADirectSwapRequest() 
{
    if(req.readyState == 4) 
	{   
		ClearTable('SwapSalesTable'); 	
		  ClearTabler('totRec');
        if (req.status == 200) 
        {	
			 	  	
          LoadInstallationUpdationMessages();
        }
    }
}
 
 function LoadInstallationUpdationMessages() 
 {
    
    	var batchs = req.responseXML.getElementsByTagName("directSales")[0];   	    
		var str=""; 
    	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
		str=str+"<tr class='MRow1'> ";
		str=str+"<td class='boldEleven'><b>S.No</b></td> ";
		str=str+"<td class='boldEleven'><b>Sale No</b></td> ";
		str=str+"<td class='boldEleven'><b>Customer Name</b></td> ";
		str=str+"<td class='boldEleven'><b>Contac Person</b></td> ";
		str=str+"<td class='boldEleven'><b>Contact Phone</b></td> ";
		str=str+"<td class='boldEleven'><b>Serial No</b></td> ";
		str=str+"<td class='boldEleven'><b>Assign Date & Time</b></td> ";
		str=str+"<td class='boldEleven'><b>Engineer Id</b></td> ";
		str=str+"<td class='boldEleven'><b>Status</b></td> ";
		str=str+"<td class='boldEleven'><b>Upload</b></td> ";
		str=str+"<td class='boldEleven'><b>Download</b></td> ";
		str=str+"</tr> ";
     	var sum=0;
	 	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{
			var batch = batchs.childNodes[loop];
			var salesid = batch.getElementsByTagName("salesid")[0].childNodes[0].nodeValue;
			var salesno = batch.getElementsByTagName("salesno")[0].childNodes[0].nodeValue;
			var custname = batch.getElementsByTagName("custname")[0].childNodes[0].nodeValue;
			var contactperson = batch.getElementsByTagName("contactperson")[0].childNodes[0].nodeValue;
			var contactphone = batch.getElementsByTagName("contactphone")[0].childNodes[0].nodeValue;
			var serialno = batch.getElementsByTagName("serialno")[0].childNodes[0].nodeValue;
			var assigndate = batch.getElementsByTagName("assigndate")[0].childNodes[0].nodeValue;
			var assignempid = batch.getElementsByTagName("assignempid")[0].childNodes[0].nodeValue;
			var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
			var file = batch.getElementsByTagName("file")[0].childNodes[0].nodeValue;
			
			
								
								
			if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
				str=str+"<tr  class='MRow2'>";		
			if("Y" == Status)
				str=str+"<td class='boldEleven'> "+(loop+1)+".</td>";
			else
				str=str+"<td class='boldEleven'><input name='salesid' id='salesid' type='checkbox' value='"+salesid+"' />"+(loop+1)+".</td>";
			str=str+"<td class='boldEleven'>"+salesno+"</td>";
			str=str+"<td class='boldEleven'>"+custname+"</td>";
			str=str+"<td class='boldEleven'>"+contactperson+"</td>";
			str=str+"<td class='boldEleven'>"+contactphone+"</td>";
			
			str=str+"<td class='bolddeepred'>"+serialno+"</td>";
			str=str+"<td class='boldEleven'>"+assigndate+"</td>";
			str=str+"<td class='boldEleven'>"+assignempid+"</td>";
			 
			if("A" == Status)
			{
				str=str+"<td class='boldEleven'>Assigned</td>";
				str=str+"<td class='boldEleven'>&nbsp;</td>";
				str=str+"<td class='boldEleven'>&nbsp;</td>";
			}
			else if("P" == Status)
			{
				str=str+"<td class='bolddeepred'>Postponed</td>";
				str=str+"<td class='boldEleven'>&nbsp;</td>";
				str=str+"<td class='boldEleven'>&nbsp;</td>";

			}
			else
			{
				str=str+"<td class='bolddeepred'>Closed</td>";
				str=str+"<td class='boldEleven'><a href=\"javascript:InstallUpload("+salesid+",'"+salesno+"'  )\"><font class=boldgreen>Upload</font></a>" ;
				if(file =="Y")
					str=str+"<td width='50' class='boldEleven'><a href='../uploadfiles/CCFR/"+salesid+".pdf' download='"+salesid+".pdf' ><font class='boldgreen'>download</font></a> ";	
				else
					str=str+"<td class='boldEleven'>&nbsp;</td>";	

			}
				
			str=str+"</tr>"; 
	}
		
	
	str=str+"</table>"; 
	var tb=document.getElementById('SwapSalesTable');
	tb.innerHTML=str ;  
	
	
	str="<br><center><font class='bolddeepred'>Total no of Records : "  + loop+"</font></center><br>";
  	var tb=document.getElementById('totRec');
  	tb.innerHTML=str  
	 
}


function  InstallUpload(salesid,salesno )
	{
		var f ="InstallationUpdationUpload.jsp?salesno="+salesno+"&salesid="+salesid ;
		newWindow = window.open(f,"subWind",",,height=500,width=600,top=0,left=0");
		newWindow.focus( );
	}



</script>

 
<body    onLoad="LoadInstallationUpdation('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="256" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="22"  >
				<div align="center"><span class="boldThirteen"> INSTALLATION UPDATION</span></div>				</td>
			</tr>
			<tr  >
				<td height="25"  >
				<table width='100%'  class='whiteMedium'  id='myTable'     cellpadding=2 cellspacing=1 >
					<tr  >
						<td width="56" height="19"  ><span
							 >Branch </span></td>
						<td colspan="3"  ><span class="boldThirteen">
						<select name="Accbranch" id="Accbranch" onChange="LoadInstallationUpdation('0')"  style="width:200px">
							<option value="0">All</option>
							<%
			   	String branchid=""+session.getAttribute("INVCOMPANY"); 
				  
								
				String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID not in("+Integer.parseInt(branchid)+")";

				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
				for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
						 
			   %>
						</select> </span></td>
						<td colspan="2"  ><div align="right">Customer</div></td>
						<td colspan="2"  ><select name="customer" id="customer" class="formText135" onChange="LoadInstallationUpdation('0')" style="width:200px">
							<option value="0">All</option>
							<jsp:include page="LoadCustomer.jsp" />
						</select></td>
					</tr>
					<tr  >
						<td height="26"  >Month </td>
						<td width="150"  ><select name="month"
							id="month" onBlur="LoadInstallationUpdation('0')">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
					  </select></td>
						<td width="127"  >Year </td>
						<td width="104"  ><select name="year"
							id="year" onBlur="LoadInstallationUpdation('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
					  </select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
                </script></td>
						<td width="60"  >Division</td>
						<td width="113"  ><select name="division"
							class="formText135" id="division" tabindex="1"
							onChange="LoadInstallationUpdation('0')">
							<option value='0'>All</option>
							<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
					  </select></td>
						<td width="213">Status</td>
						<td width="221"><select name="status" id="status" onBlur="LoadInstallationUpdation('0')">
							<option value="0" >All</option>
							<option value="P" >Postponed</option>
							<option value="A" selected >Assigned</option>
							<option value="Y" >Closed</option>
							
					  </select></td>
					</tr>
				</table>				</td>
			</tr>
			 
			<tr class="MRow1">
				<td height="127" valign="top"  >
				 
						<div id="SwapSalesTable" style="OVERFLOW:auto;width:100%;height:300px"  ></div>						 
						<br>
						<div align="center" id="totRec"></div>
				<br>						 		</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr  >
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('0')">All</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('A')">A</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('B')">B</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('C')">C</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('D')">D</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('E')">E</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('F')">F</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('G')">G</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('H')">H</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('I')">I</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('J')">J</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('K')">K</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('L')">L</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('M')">M</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('N')">N</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('O')">O</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('P')">P</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('Q')">Q</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('R')">R</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('S')">S</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('T')">T</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('U')">U</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('V')">V</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('W')">W</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('X')">X</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('Y')">Y</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadInstallationUpdation('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<div align="center">
		  <table width="112" border="0" cellspacing="2" cellpadding="2">
            <tr>
				<td width="56" valign="top"><input type="submit" class="ButtonHead" name="action1" value="UPDATE" onClick=" return Add()" /></td>
                 <td width="56" valign="top"><input name="Submit2" type="button" class="ButtonHead" value="CLOSE" onClick="redirect( 'InventoryMains.jsp')" /></td>
            </tr>
          </table>
		  
		</div>		</td>
	</tr>
	<tr>
		<td>
		 	</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
