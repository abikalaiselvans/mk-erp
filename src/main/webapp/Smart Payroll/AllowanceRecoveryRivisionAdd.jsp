<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">

function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
     }     
   }
function mainPage()
	{
	    document.allow.action="Payrollmain.jsp";
		document.allow.submit();
		return true;
    }
	
	
	
</script>
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="init()">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowance" action="../SmartLoginAuth"
	onSubmit="return validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="564" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="545" valign="top">
					<table width="549" border="0" cellspacing="5" cellpadding="0">
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><%@ include
								file="../JavaScript/ajax.jsp"%></div>
							</td>
						</tr>

						<tr>
							<td height="19" colspan="2">
							<div align="right" class="boldElevenlink">* All fields
							should be in numeric format</div>
							</td>
						</tr>
						<tr>
							<td height="19" class="boldEleven">
							<div align="right">Effective Date</div>
							</td>
							<td><input name="effectdt" type="text" class="formText135"
								id="effectdt" size="15" onKeyPress="dateOnly(this)" /> <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" /> </a> <script language='JavaScript'
								type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['allowance'].elements['effectdt']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('effectdt'); 
						//-->
                       </script></td>
						</tr>
						<tr>
							<td width="40%" height="19">
							<div align="right" class="boldEleven">Increment
							&nbsp;&nbsp;&nbsp;</div>
						  </td>
						  <td width="60%">
<input name="increment"   onBlur="numbercheck('increment','should be a number value')"  type="text" class="formText135" id="increment" maxlength="10"> &nbsp;&nbsp;&nbsp;&nbsp;  
								
<script language="javascript">
	function ClearTablesss(ctr1)
	{
		 var str="&nbsp;";
		 var tb=document.getElementById(ctr1);	 
		 tb.innerHTML=str     
	}
	
	function loadPreviousTakeupss() 
	{
		alert();
		 
		
		 
		 
	
	}
	
	function loadPreviousTakeups( ) 
	{
		alert();
		 
		alert(checkNull("ename","Select Staff")); 
		/*if(checkNull("ename","Select Staff"))
	 	{
			var ename =document.getElementById('ename').value;
			var url = "../Payroll?actionS=PAYPreviousTakeups&empid="+ename ;
			alert(url);
			url = url+"&Office="+Office;
			initRequest(url);
			req.onreadystatechange = loadPreviousTakeups;
			req.open("GET", url, true);
			req.send(null);
		}
		else
			return false;*/
	}
	
	
	function loadPreviousTakeups() 
	{
		ClearTablesss('previoudallowance');
		ClearTablesss('previoudrecovery');
		//previoudallowance,previoudrecovery
		if(req.readyState == 4) 
		{    	
			ClearTablesss('previoudallowance');
			ClearTablesss('previoudrecovery');
			if (req.status == 200) 
			{		  	
			  loadPreviousTakeupsMessages();
			}
		}
	}
	
	
	
	
	function loadPreviousTakeupsMessages() 
	{  
		var loop=0;
		var batchs = req.responseXML.getElementsByTagName("Rows")[0];
		var str="<table>";
		 var str1="<table>";
		 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{           		                           
			var batch1 = batchs.childNodes[loop];
			var Basic = batch1.getElementsByTagName("Basic")[0]; 
			var Alength = batch1.getElementsByTagName("Basic")[0]; 
			var Rlength = batch1.getElementsByTagName("Basic")[0]; 
			str=str+"<tr><td width='100' class='boldEleven' align='right'>&nbsp;"+Basic.childNodes[0].nodeValue;
			 
		}
		str=str+"</table>";
		str1=str1+"</table>";
		var tb=document.getElementById('previoudallowance');
		tb.innerHTML=str;  
		
		 
		 
			
	}
</script>
							  <input type="checkbox" name="checkbox"   id="checkbox" value="checkbox" onClick="loadPreviousTakeupss()"></td>
						</tr>
						<tr>
							<td height="19" colspan="2">

						 
							 
									<div align="center" >
									<%
						String all ="Alowance";
						String sv ="";
						 
				  		String query = "Select CHR_ACODE,CHR_ANAME from pay_m_allowance order by CHR_ACODE";
						String datas[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(query);
						out.println("<table width='300'  align=1center1 cellpadding='2' cellspacing='2' class='TableDesign' ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>Allowance</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						for(int u=0; u<datas.length; u++)
						{
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							out.println(" <td class='boldEleven' align='left' >"+datas[u][1]);
							sv ="onBlur=\"numbercheck('"+(all+(u+1))+"','should be a number value')\"";
							out.println("<td align='left' ><input  class='formText135' type='text' name='"+(all+(u+1))+"' id='"+(all+(u+1))+"'   "+sv+" />" );
							out.println("<input  type='hidden' name='Aname"+(u+1)+"' value='"+datas[u][0]+ "' />" );
						}
						out.println("</table>");
						out.println("<input type='hidden' name='allowancelength' value='"+datas.length+"' />");
					%>
									</div>									 
								    
									
									
							 
							<div id="previoudallowance"></div> 
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							 
									<div align="center">
									<%
				  		String rec ="Recovery";
			  			query = "Select CHR_RCODE,CHR_RNAME from pay_m_recovery order by CHR_RCODE";
						String datas1[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(query);
						out.println("<table  cellpadding='2' cellspacing='2' class='TableDesign' ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>Recovery</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						for(int u=0; u<datas1.length; u++)
						{
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							out.println(" <td class='boldEleven'   align='left' >"+datas1[u][1]);
							sv ="onBlur=\"numbercheck('"+(rec+(u+1))+"','should be a number value')\"";
							out.println("<td  align='left' ><input  class='formText135' type='text' name='"+(rec+(u+1))+"' id='"+(rec+(u+1))+"' id='"+(rec+(u+1))+"'   "+sv+" />" );
							out.println("<input type='hidden' name='Rname"+(u+1)+"' value='"+datas1[u][0]+"' />" );
						}
						out.println("</table>");
						out.println("<input type='hidden' name='recoverylength' value='"+datas1.length+"' />");
				  %>
									</div>									 
								   <div id="previoudrecovery"></div> 
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td><input name="filename" type="hidden" id="filename"
								value="StaffAllowanceRecovery" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYAllowanceRecoveryRivision" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Rivision.jsp')" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="5"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="2"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>

			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%> <script
	language="javascript">
function validate()
{
    var l1 = "<%=datas.length%>";
	var l2 = "<%=datas.length%>";
	var s = "ename,";
	for(i=1;i<=parseInt(l1);i++)
		s = s+"Alowance"+i+",";
	for(i=1;i<=parseInt(l2);i++)
		s = s+"Recovery"+i+",";
	var v = s.split(",");
   	var flag =false;
	for( i=0; i<v.length-1; i++)
	{
		var chk =document.getElementById(v[i]).value;
		var ck = "Enter Data..."+v[i];
		if(checkNull(v[i],ck))
		{
		d=1;
		}
		else
		{
				return false;				
		}	
	}
}
</script></form>
</body>

</html>
