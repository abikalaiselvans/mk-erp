<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 

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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/Payroll/PayTaxValue.js"></script>
<script language="javascript">

function PayEdit()
{		

		obj = findObj("allowance"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		
  		var count=0;
 	    sel=document.forms[0].allowance;
		for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	       alert("Select Record to Edit");
 	       return false;
 	    
 	    }
		if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false;
 	    }
		
 	    if(count==1)
 	    {
			document.frm.action="SalaryBandEdit.jsp";
			document.frm.submit();
			return true;
		}
 	}
 
	function Add()
 	{		
		document.frm.action="SalaryBandAdd.jsp";
		
		//EmployeTransferAdd.jsp		
 	}
	
	
	function PayDelete()
 	{		
		
		alert("Could not deleted...");
		
		obj = findObj("allowance"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}
		var count;
		count=0;
		c1=document.forms[0].allowance;
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count>=1)
		{			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
				return true;			
			}
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
 	</script>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>

<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off" method="get"   name="frm">
<table width="100%" height="244" align="center" cellpadding="0" cellspacing="0">
	<tr>
	  <td height="18"><%@ include file="index.jsp"%></td>
    </tr>
	<tr>
		<td height="151" align="center"><br>
		<table width="95%" height="120" align="center" 	cellpadding="0" cellspacing="0" class="TableDesign"    >
			 
			<tr align="center" valign="middle" >
				<td height="28"  ><span class="style3">SALARY BAND
				    <input type="hidden" name="filename" value="SalaryBand">
                  <input type="hidden" name="actionS" value="PAYSalaryBandDelete">
</span></td>
			</tr>

			 
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="PayTaxvaluetable" style="OVERFLOW: auto;width:100%;height:auto">
				
				<%
				String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance   WHERE CHR_FLAG='Y'  ORDER BY INT_ALLOWANCEID");
				
				String salaryband=" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,  CHR_SPLITUPIN,INT_BASIC,  ";
				for(int u=0; u<AllowanceData.length;u++)
					salaryband = salaryband+AllowanceData[u][1]+", ";
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband + " FROM pay_m_salaryband	ORDER BY INT_SALARYBANDID ";
				//out.println(salaryband);
				String bandData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(salaryband);
				
							
					if(AllowanceData.length>0)
						if(bandData.length>0)
						{
							
							
							out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
							out.println("<tr class='MRow1'>");
							out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
							out.println("<td class='boldEleven'><b>SLAB NO</b></td>");
							out.println("<td class='boldEleven'><b>START</b></td>");
							out.println("<td class='boldEleven'><b>END</b></td>");
							 
							out.println("<td class='boldEleven'><b>AMOUNT / ( % ) </b></td>");
							out.println("<td class='boldEleven'><b>BASIC <span class='boldElevenlink'>  </span></b></td>");
							
							for(int u=0; u<AllowanceData.length;u++)
								out.println("<td class='boldEleven' align='center'><b>"+AllowanceData[u][2]+"</b><span class='boldElevenlink'>  </span></td>");
							out.println("</tr>");
							
							for(int u=0; u<bandData.length;u++)
							{
								if(u%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");	
								out.println("<td class='boldEleven'><input type='checkbox' name='allowance' id='allowance' value="+bandData[u][0]+"></td>");
								out.println("<td class='boldEleven'><a href='SalaryBandEdit.jsp?allowance="+bandData[u][0]+"'> Band - "+(u+1)+"</a></td>");
								out.println("<td class='boldEleven'>"+bandData[u][1]+"</td>");
								out.println("<td class='boldEleven'>"+bandData[u][2]+"</td>");
								 
								if("A".equals(bandData[u][3]))
									out.println("<td class='bolddeepred'>Amount</td>");
								else
									out.println("<td class='bolddeepred'>Percentage</td>");
								
								out.println("<td class='boldEleven' align='right'>"+bandData[u][4]+"</td>");
								for(int i=0; i<AllowanceData.length;i++)
									out.println("<td class='boldEleven' align='right'>"+  bandData[u][(i+5)]  +" </td>");
								
							}	
							out.println("</tr>");
							
							out.println("<tr  class='MRow1'>");
							out.println("<td class='boldEleven'  colspan='20'><font class='bolddeepred'>Total no of Records :: "+bandData.length+"</font><br></td>");
							out.println("</tr>");
							
							out.println("</table>");
						}
						else
						{
							out.println("<br><br><center><font class='boldeepred'><b>Data not found...</b></font></center>");
						}	
						
				%>
			  </div><br>				</td>
		</table>		</td>
	</tr>
	<tr>
		<td height="23"><%//=com.my.org.erp.common.SalaryFunctions.salaryBand('CISMAR2008003923',6000.00,'Y')%>&nbsp;</td>
	</tr>
	<tr>
		<td height="17" align="center">
		
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2" type="Submit" onClick="Add()" value="Add"></td>
				<td width="56"><input class="ButtonHead" name="Edit" type="Submit" onClick=" return PayEdit()" value="Edit"></td>
			<td width="56"><input class="ButtonHead" type="Button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>	
				
<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="hidden" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return PayDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>

 
				
			</tr>
		</table>
	<tr>
		<td height="20">
		 
		<%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>

</html>
<%
}
catch(Exception e)
{
}
%>