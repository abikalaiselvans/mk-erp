<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>

 <html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='PAY' ")[0][0]%></title>
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
<script language="javascript" src="../JavaScript/Payroll/IncomeTaxValue.js"></script>
<script language="javascript">

function Edit()
	{	
		obj = findObj("Incometaxvalueid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}

		var chkbox=document.forms[0].Incometaxvalueid;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					document.frm.action="IncomeTaxValueEdit.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="IncomeTaxValueEdit.jsp";
				return true;
			}
	}
	
	function Add()
 	{		
		document.frm.action="IncomeTaxValueAdd.jsp";
 	}
	
	
	 function Delete()
	{
		
		obj = findObj("Incometaxvalueid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}
		var chkbox=document.forms[0].Incometaxvalueid;
		var len=0;
			for(i=0;i<chkbox.length;i++)
			{
				if(chkbox[i].checked)
					len++;
			}
		if(!document.forms[0].Incometaxvalueid){
			alert("Select Any One Value");
			return false;
			}
		else if(len==0)
		{
			if(chkbox.checked)
			{
		    var name=confirm("Confirm to Delete?");

				if(name == true){
					document.frm.action="../SmartLoginAuth";
					return true;
				}
				else{
					return false;
				}
			}
			else{
				alert("Select Any One Value");
				return false;
			}
		}
		else if(len>=1)
		{
			var name=confirm("Confirm to Delete?");

			if(name == true)
			{

				document.frm.action="../SmartLoginAuth";
				return true;
			}
			else
			{
			return false;
			}
		}	
}		
	
 
	
 	</script>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style3 {color: #000000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadIncomeTaxValue('0')">
<form  AUTOCOMPLETE = "off" method="post"   name="frm" >
<table width="100%" height="285" align="center">
	<tr>
	
	
	
		<td height="151" align="center"><%
    String fooParameter = request.getParameter( "msg1" );
    if ( fooParameter == null )
    	{
	%>
 		
	<%
    	}else{
	%>
	<p><span class="bolddeepred">Record Can't Modify</span></p>
	<%}%>
	<br>
		<table width="90%" height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
				<td height="28" class="whiteMedium">INCOME  TAX DETAILS
					<input type="hidden" name="filename" value="IncomeTaxValue">
					<input type="hidden" name="actionS" value="PAYIncomeTaxValueDelete">
				</td>
			</tr>
			<tr>
				<td height="31" align="left" valign="middle">
				<table width="100%" border="0" class="whiteMedium"
					>
					
					<tr>
					  <td colspan="8" align="center">
					  <table width="293" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                        <tr>
                          <td width="151" align="center">Account Year</td>
                          <td width="142" class="boldEleven">
						  
						 <select name="Year" class="formText135" id="Year" onChange="LoadIncomeTaxValue('0')" >
						  <%@ include file="../JavaScript/accountyears.jsp"%>
						  </select><script language='JavaScript' type="text/javascript">
	<!--			
			var d=new Date();
			var month1=parseInt(d.getMonth() + 1);
			var year1=parseInt(d.getFullYear());
			var m="";
			if(month1<4)
				year1 = year1-1;
			if(month1<10) 
				m="0"+month1;
			
			setOptionValue('Year',year1);	
								
	//-->
</script>
						  </td>
                        </tr>
                      </table>
					  </td>
				  </tr>
					<tr>
					  <td width="16%" ><div align="center">S.No</div></td>
						<td width="18%"  ><div align="center">Account Year </div></td>
						<td width="16%" ><div align="center">Gender</div></td>
                        <td width="17%"  ><div align="center">From</div></td>
						<td width="16%" ><div align="center">To</div></td>
						
					  <td width="20%"  ><div align="center">Value % </strong></div></td>
					    <td width="13%"  ><div align="center">Description</div></td>
					</tr>
				</table>			  </td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="IncomeTaxvaluetable" style="OVERFLOW: auto;width:100%;height:200px"></div><br>
				<div id="totalrec"></div>
				</td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
    </tr>
	<tr>
		<td height="23"><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('0')">All</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('A')">A</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('B')">B</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('C')">C</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('D')">D</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('E')">E</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('F')">F</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('G')">G</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('H')">H</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('I')">I</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('J')">J</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('K')">K</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('L')">L</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('M')">M</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('N')">N</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('O')">O</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('P')">P</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('Q')">Q</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('R')">R</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('S')">S</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('T')">T</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('U')">U</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('V')">V</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('W')">W</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('X')">X</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('Y')">Y</a></div></td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadIncomeTaxValue('Z')">Z</a></div></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
    <tr>
		<td height="17" align="center">
		
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('Payrollmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>

</html>
