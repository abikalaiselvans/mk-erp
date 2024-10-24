<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
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
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII"/>
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Payroll/LoanBalanceAjax.js"></script>
<script language="javascript">

 	/*function AEdit()
	{		
  		
		alert("Dont Modify the Advance, Kindly do the Cash Return Screen...")
		return false;
		var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }  	
 	    if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
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
			document.Advancefrm.action="AdvanceEdit.jsp";
			document.Advancefrm.submit();
			return true;
		}
 } */


/*function ADVEdit()
	{		
  		var count=0;
 	    sel=document.forms[0].id;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }  	
 	    if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
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
			document.Advancefrm.action="LoanDebitEdit.jsp";
			document.Advancefrm.submit();
			return true;
		}
 } 



 function ADelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
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
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count==1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.Advancefrm.action="../SmartLoginAuth";
				document.Advancefrm.submit();
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
 	}*/
	
	function ADVEdit1()
 	{		
		document.Advancefrm.action="LoanDebitAdd.jsp";		
 	}		
		
	function AAdd()
 	{		
		document.Advancefrm.action="LoanCreditAdd.jsp";		
 	}		
	
	 
	
 	</script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadAdvance('0')">
<form  AUTOCOMPLETE = "off"   method="get" name="Advancefrm">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   background="">
				<td height="28"    
					 ><div align="center" class="whiteMedium">Loan Balance</div></td>
			</tr>
			<tr>
				<td height="31" align="center">
				<table width="78%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
					<tr>
						<td width="23%" align="center">Office</td>
						<td width="31%">
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office"
							tabindex="6" onBlur="loadAdvance('0')">
							<option value="0">All</option>
							<%
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
							%>
					  </select></td>
					  
					  <td width="23%">Loan Type</td>
					  <td width="23%"><select name="loantype"  id="loantype" class="formText135" onChange="loadAdvance('0')" > 
									  <option value="0">All</option>
									  <%
		String loandata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_LOANID,CHR_LOANNAME FROM  pay_m_loan ORDER BY CHR_LOANNAME ");
	 	if(loandata.length>0)
			for(int h=0;h<loandata.length;h++)
			out.print("<option  value='"+loandata[h][0]+"'>"+ loandata[h][1] +"</option>");
									%>
			          </select></td>
					</tr>
				</table></td>
		  </tr>
		<tr>
			<td height="31" align="left" valign="middle"  >
				<table width="100%" border="0" class="whiteMedium"    cellpadding=2 cellspacing=1>
					<tr>
					    <td  width='4%' ><div align="center"><strong> </strong>S.No<strong></strong></div></td>
						<td  width='16%' ><div align="center">Staff Id</div></td>
						<td  width='16%' ><div align="center">Staff Name</div></td>
						<td  width='16%' ><div align="center">Loan Name</div></td>
						<td  width='16%' ><div align="center">Credit Amount</div></td>
						<td  width='16%' ><div align="center">Debit Amount</div></td>
						<td  width='16%' ><div align="center">Balance<strong class="bold1"></strong></div></td>
					</tr>
				</table>
			</td>
		</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				   <div id="AdvanceTable" style="OVERFLOW: auto;width:100%;height:300px"></div><br><div id="totrec"> </div>			  
				</td>
		</table></td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
  </tr>
	<tr>
		<td height="23"><input name="actionS" type="hidden" id="actionS"
			value="PAYAdvanceDelete" /> <input name="filename" type="hidden"
			id="filename" value="EmpAdvance" />
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadAdvance('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="submit" onClick="AAdd()" value="Credit"></td>
				<td width="56"><input class="ButtonHead" name="submit3" type="submit" onClick="ADVEdit1()" value="Debit" ></td><!--redirect('LoanDebitAdd.jsp')-->
				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	
}
%>