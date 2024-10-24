<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>



<html>
<head>

<title> :: PAYROLL ::</title>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Payroll/PayTaxdeduction.js"></script>
<script language="javascript">
function disable()
{
    document.getElementById('Edit').disabled=true; 
	document.getElementById('Delete').disabled=true;
}


function validate()
{
    if(checkNull("ename","Select Staff"))
    	return true;
    else
    	return false;
}

 
 	
function RAdd()
{		
	document.allowancefrm.action="Ptaxdeductionadd.jsp";
	document.allowancefrm.submit();
}	
function REdit()
{				
		
		var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }		 
 	     
 	    if(count==1)
 	    {
		document.allowancefrm.action="RivisionEdit.jsp";
		document.allowancefrm.submit();
		return true;
		}
 	}
	
 function RDelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].id
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.allowancefrm.action="../SmartLoginAuth";
				document.allowancefrm.submit();
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
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
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="LoadPayTaxdeduction('0')">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowancefrm">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="3" cellpadding="2">
			<tr>
				<td>
				<table align="center"
					cellpadding="1" cellspacing="1"   class="TableDesign">
					<!--DWLayoutTable-->
					<tr align="center" valign="middle">
 <td class="whiteMedium"   >
 <div align="center" class="whiteMedium">
 <div align="center">
<%
if("Y".equals(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_TAXDEDUCTIONEMP FROM m_institution WHERE INT_ID=1")[0][0]))
	out.println("Tax Deduction Employee List");
else
	out.println("Non Tax Deduction Employee List");
%>
 
 </div>
 </div> </td>
					</tr>
					<tr align="center" valign="middle">
 <td height="31"
 	  >
 <table width="86%" border="0" align="center" cellpadding="1"
 	cellspacing="1" class="whiteMedium"  >
 	<tr>
 	  <td  >Tax</td>

 		<td  >
 		
 		
 		<select name="tax" class="formText135" id="tax" onBlur="LoadPayTaxdeduction('0')">
                                  <option value="0">All</option>
                                  <%
		String taxdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ID,CHR_TAXNAME FROM pay_m_tax  ORDER BY CHR_TAXNAME");
		for(int u=0; u<taxdata.length; u++)
			out.print("<option value='"+taxdata[u][0]+"'>"+taxdata[u][1] +"</option>");
 	%>
                        </select> 		</td>
 		<td  >Office</td>
 		<td  >
 		<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
<select name="Office" class="formText135" id="Office"
 			tabindex="6" onBlur="LoadPayTaxdeduction('0')">
                                  <option value="0">All</option>
                                  <%
 		
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
 	%>
                        </select></td>
 		<td  >Month ::</td>
 		<td><span class="boldThirteen"> 
 		
 		<select name="month" id="month" onChange="LoadPayTaxdeduction('0')">
 			<option value="January">January</option>
 			<option value="February">February</option>
 			<option value="March">March</option>
 			<option value="April">April</option>
 			<option value="May">May</option>
 			<option value="June">June</option>
 			<option value="July">July</option>
 			<option value="August">August</option>
 			<option value="September">September</option>
 			<option value="October">October</option>
 			<option value="November">November</option>
 			<option value="December">December</option>
 		</select> 
 		
 		<script language='JavaScript' type="text/javascript">
				<!--			
 
 var today = new Date();
 var monthnum = today.getMonth();
 var monthname=new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
 var day=today.getDate();
 setOptionValue('month',monthname[monthnum]);
					
				//-->
          </script>
 		
 		</span></td>
 		<td><span  >Year ::</span></td>
 		<td><span class="boldThirteen"> <select name="year"
 			id="year" onChange="LoadPayTaxdeduction('0')">
 			<%@ include file="../JavaScript/years.jsp"%>
 		</select> <script language='JavaScript' type="text/javascript">
				<!--			
 var d=new Date()
 var month1=d.getMonth() + 1
 if(month1<10) month1="0"+month1;
 var year1=d.getFullYear();
  
 setOptionValue('year',year1); 	
				//-->
          </script> </span></td>
 	</tr>
 </table> </td>
					</tr>

					<tr>
 <td height="23"   >
 <table width="100%" border="0" class="whiteMedium">
 	<tr>
 		<td  >S.No</td>
 		<td  >Empid</td>
 		<td  >Staff Name</td>
 		<td  >Tax Name</td>
 		<td  >Month</td>
 		<td  >Year</td>
 		 
 	     
 	</tr>
 </table> </td>
					</tr>
					<tr bgcolor="#FFFFFF">
 <td height="23">
 <div id="PayTaxtable" style="OVERFLOW:auto;width:100%;height:300px"></div>
 <br>
				<div id="totalrecord" align="center"></div>
				<br> 
				 </td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
		  </tr>
			<tr>
				<td>
				<table border="0" align="center" cellpadding="2"
					cellspacing="2" class="TableDesign"  >
					<tr  >
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('0')">All</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('A')">A</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('B')">B</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('C')">C</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('D')">D</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('E')">E</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('F')">F</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('G')">G</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('H')">H</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('I')">I</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('J')">J</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('K')">K</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('L')">L</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('M')">M</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('N')">N</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('O')">O</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('P')">P</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('Q')">Q</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('R')">R</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('S')">S</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('T')">T</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('U')">U</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('V')">V</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('W')">W</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('X')">X</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('Y')">Y</a> </div> </td>
 <td>
 <div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxdeduction('Z')">Z</a> </div> </td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
		  </tr>
			<tr>
				<td>
				<table border="0" align="center" cellpadding="2" cellspacing="2">
					<tr>
 <td width="56"><input class="ButtonHead" name="button"
 	type="submit"  value="Add"   accesskey="s"   onClick="RAdd()"></td>
 
 <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return RDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>
 
 <td width="56"><input class="ButtonHead" type="button"
 	name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
 <td width="56"><input name="Edit" type="hidden"
 	class="buttonbold" id="Edit" value="Edit" onClick="REdit()"> </td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td><font size="1"><strong><font
 				color="#000000"><font size="1"><strong><font
 				color="#000000"><font size="1">
				  <input
 				type="hidden" name="filename" value="PayTax" />
                  <strong><font
 				color="#000000"><font size="1">
                  <input
 				type="hidden" name="actionS" value="PAYPayTaxDeductionDelete" />
                </font></font></strong></font></font></strong></font></font></strong></font></td>
			</tr>
		</table>

		<%@ include file="../footer.jsp"%>
		</form>
</body>

</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
