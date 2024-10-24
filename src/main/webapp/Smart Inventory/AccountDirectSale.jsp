<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
function  DCUpload(pono)
	{
		var f ="AccDCUploadUpload.jsp?pono="+pono+"&mode=DirectSales";
		newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
		newWindow.focus( );
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



function AccloadSwapSales(startletter) 
{
	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
    var customer=document.getElementById('customer').value; 
    var division=document.getElementById('division').value; 
    var Aflag=document.getElementById('Aflag').value; 
	var Accbranch=document.getElementById('Accbranch').value;
    var url = "../inventoryCustomer?actionS=INVACCSwapSale&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&customer="+customer+"&division="+division+"&Aflag="+Aflag+"&Accbranch="+Accbranch;
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
		  ASwapSalesMessages();
        }
    }
}


 function ASwapSalesMessages() {
    
    var batchs = req.responseXML.getElementsByTagName("directSales")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
     var sum=0;
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	{
		
		var batch = batchs.childNodes[loop];
        var salesno = batch.getElementsByTagName("salesno")[0].childNodes[0].nodeValue;
        var custname = batch.getElementsByTagName("custname")[0].childNodes[0].nodeValue;
        var saledate = batch.getElementsByTagName("saledate")[0].childNodes[0].nodeValue;
        var PStatus = batch.getElementsByTagName("PStatus")[0].childNodes[0].nodeValue;    
        var InvoiceStatus = batch.getElementsByTagName("InvoiceStatus")[0].childNodes[0].nodeValue;  
		var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue; 
		var NetAmount = batch.getElementsByTagName("NetAmount")[0].childNodes[0].nodeValue; 
       var Cancel = batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue; 
	   var Alias = batch.getElementsByTagName("Alias")[0].childNodes[0].nodeValue; 
	    var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue; 
		var Download = batch.getElementsByTagName("Download")[0].childNodes[0].nodeValue; 
		
		sum = sum+parseFloat(NetAmount); 
		if("Y" == Cancel)
			str=str+"<tr class='MRow3'>";
		else
		{
				if(loop%2==0)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";	
		}		
		str=str+"<td width='11%' class='boldEleven'>"+salesno +"</td>";
		str=str+"<td width='11%' class='boldEleven'>"+Division +"</td>";
		str=str+"<td width='11%' class='boldEleven'>"+Branch +"</td>";
		str=str+"<td width='11%' class='boldEleven'>"+saledate+"</td>";
		str=str+"<td width='11%' class='boldEleven' align='right'>"+NetAmount +"</td>";
		str=str+"<td width='11%' class='boldEleven'>"+Alias+"</td>";
		str=str+"<td width='11%' class='boldEleven'>"+custname .replace("98650" ,"&")+" </td>";
		str=str+"<td width='11%' class='boldEleven'>"+PStatus +" / " +InvoiceStatus +"</td>";

		if("Y" == InvoiceStatus  )
			str=str+"<td width='11%' class='boldEleven'><font class='boldgreen'>Received</font</td>"
		else
			str=str+"<td width='11%' class='boldEleven'><font class='bolddeepred'>Not Received</font</td>"
    	
		
		if("N" == Cancel)
		{ 
			str=str+"<td width='11%' class='boldEleven'><a href=\"AccDirectSalesStatusUpdate.jsp?salno="+salesno +"\"><font class=boldgreen>Accept</font></a>" ;
			
			if("N" == InvoiceStatus  )
				str=str+"<td width='11%' >&nbsp;</td>";
			else
				str=str+"<td width='11%' class='boldEleven'><a href=\"javascript:DCUpload('"+salesno +"')\"><font class=boldgreen>Upload Invoice</font></a>" ;
				
			var p = salesno ;
			p = replaceAll("/","_",p);
			
			 if(Download =="Y")
				str=str+"<td    width='11%' class='boldEleven'><a target='_blank' href='../uploadfiles/DCIMAGE/"+p+".pdf' download='"+salesno +".pdf' ><font class='boldgreen'>download</font></a> </td>";
				else
			 str=str+"<td width='11%' >&nbsp;</td>";
			 
			 
		}
		else
		{
			str=str+"<td class='boldEleven' align='center'><font class='bolddeepred'>Cancelled </font></td>";//<img src='../Image/report/cancel.gif' title='Cancelled Invoice'> 
			str=str+"<td class='boldEleven'>&nbsp;</td>";
			str=str+"<td class='boldEleven'>&nbsp;</td>";
		}		
		str=str+"</tr>"; 
		
		     
         
	}
		str=str+"<tr  class='MRow2'><td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%' class='boldEleven' align='right'><b>Total : </b></td>";
     str=str+"<td width='11%' class='boldEleven' align='right'><b>"+sum+"</b></td>";
     str=str+"<td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%'>&nbsp;</td>";
     str=str+"<td width='11%'>&nbsp;</td>";
	 str=str+"<td width='11%'>&nbsp;</td>";
	 str=str+"<td width='11%'>&nbsp;</td>";
	 str=str+"</table>"; 
	 
	 var tb=document.getElementById('SwapSalesTable');
  	 tb.innerHTML=str ;  
		
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	
  	 
}
</script>


<script language="javascript">
	function  Print(pono)
		{
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="AccDirectSalesStatusUpdate.jsp?salno="+pono  ;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
</script>
<body    onLoad="AccloadSwapSales('0')">
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
				<div align="center"><span class="boldThirteen"> SALES </span><span
					class="boldThirteen">( ACCOUNT ) </span></div>				</td>
			</tr>
			<tr  >
				<td height="25"  >
				<table width='100%'  class='whiteMedium'  id='myTable'     cellpadding=2 cellspacing=1 >
					<tr  >
						<td width="10" height="19"  ><span
							 >Branch</span></td>
						<td colspan="3"  ><span class="boldThirteen">
						<select name="Accbranch" id="Accbranch"
							onChange="AccloadSwapSales('0')" style="width:200">
							<option value="0">All</option>
							<%
			   	String branchid=""+session.getAttribute("INVCOMPANY"); 
				  
								
				String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID not in("+Integer.parseInt(branchid)+")";

				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
				for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
						 
			   %>
						</select> 
						<script language="javascript">setOptionValue('Accbranch','<%=""+session.getAttribute("INVBRANCH")%>')</script>						

						</span></td>
						<td colspan="2"  >Customer</td>
						<td colspan="2"  ><select name="customer"
							id="customer" class="formText135"
							onChange="AccloadSwapSales('0')" style="width:200">
							<option value="0">All</option>
							<jsp:include page="LoadCustomer.jsp" />
						</select></td>
					</tr>
					<tr  >
						<td height="19"  >Month </td>
						<td width="11"  ><select name="month"
							id="month" onBlur="AccloadSwapSales('0')">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="21"  >Year </td>
						<td width="22"  ><select name="year"
							id="year" onBlur="AccloadSwapSales('0')">
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
						<td width="43"  >Division</td>
						<td width="44"  ><select name="division"
							class="formText135" id="division" tabindex="1"
							onChange="AccloadSwapSales('0')">
							<option value='0'>All</option>
							<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
						</select></td>
						<td width="44"  >Status</td>
						<td width="44"  ><select name="Aflag"
							id="Aflag" onBlur="AccloadSwapSales('0')">
							<option value="0" selected="selected">All</option>
							<option value="1">Received</option>
							<option value="2"  >Not Received</option>
						</select></td>
					</tr>
				</table>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr  >
						<td width='11%'><div align="center">Sale No</div></td>
						<td width='11%'><div align="center">Division</div></td>
						<td width='11%'><div align="center">Date</div></td>
						<td width='11%'><div align="center">Net amount</div></td>
                        <td width='11%'><div align="center">Alias</div></td>
						<td width='11%'><div align="center">Customer Name</div></td>
						<td width='11%'><div align="center">Status</div></td>
						<td width='11%'><div align="center">View</div></td>
						<td width='11%'><div align="center">Payment</div></td>
					</tr>
				</table>
				</div>				</td>
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
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('0')">All</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('A')">A</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('B')">B</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('C')">C</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('D')">D</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('E')">E</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('F')">F</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('G')">G</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('H')">H</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('I')">I</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('J')">J</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('K')">K</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('L')">L</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('M')">M</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('N')">N</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('O')">O</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('P')">P</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('Q')">Q</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('R')">R</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('S')">S</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('T')">T</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('U')">U</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('V')">V</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('W')">W</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('X')">X</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('Y')">Y</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:AccloadSwapSales('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<div align="center"><input name="Submit2" type="button"
			class="ButtonHead" value="  Close  "
			onClick="redirect( 'InventoryMains.jsp')" />
		</div>		</td>
	</tr>
	<tr>
		<td>
		<%
	
	%>		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
