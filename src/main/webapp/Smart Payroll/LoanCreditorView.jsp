<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
 <%
 try
 {
 %>
 
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
<script language="JavaScript" src="../JavaScript/Payroll/LoanCreditAjax.js"></script>

<script language="javascript">

 	function Edit()
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
			document.frm.action="LoanCreditEdit.jsp";
			document.frm.submit();
			return true;
		}
 } 

 function Delete()
	{
		var chkbox=document.forms[0].id;
		var len=0;
			for(i=0;i<chkbox.length;i++)
			{
				if(chkbox[i].checked)
					len++;
			}
		if(!document.forms[0].id){
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
	
	
	function  Add()
 	{		
		document.frm.action="LoanCreditAdd.jsp";
		document.frm.submit();
		
 	}		
	
	 function close1()
 	{		
		document.frm.action="Payrollmain.jsp";
		document.frm.submit();
 	}
	
 	</script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadloanCredit('0')">
<form  AUTOCOMPLETE = "off"   method="post" name="frm">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table height="449" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   background="">
				<td height="28"    
					 ><div align="center" class="whiteMedium">Loan Credit</div></td>
			</tr>
			<tr>
				<td height="37" align="center">
				<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr>
						<td width="22%"></td>
						<td width="13%" align="center">Office</td>
						<td width="19%" >
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office"
							tabindex="6" onBlur="loadloanCredit('0')">
							<option value="0">All</option>
							<%
								
				
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 							%>
					  </select></td>
					  
					  <td width="17%">Loan Type</td>
					  <td width="29%">
					   <select name="loantype"  id="loantype" class="formText135" onChange="loadloanCredit('0')" > 
									  <option value="0">All</option>
									  <%
		String loandata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_LOANID,CHR_LOANNAME FROM  pay_m_loan ORDER BY CHR_LOANNAME ");
	 	if(loandata.length>0)
			for(int h=0;h<loandata.length;h++)
			out.print("<option  value='"+loandata[h][0]+"'>"+ loandata[h][1] +"</option>");
									%>
				        </select>	
					  
					  </td>
					</tr>
			  </table>			  </td>
		  </tr>
			<tr  >
				<td height="31" align="left" valign="middle"  >
				<table width="100%" border="0" class="whiteMedium"    cellpadding=2 cellspacing=1>
					<tr>
					  <td  width='4%' ><div align="center"><strong> </strong>S.No<strong></strong></div></td>
						<td  width='16%' ><div align="center">Emp Id</div></td>
						<td  width='16%' ><div align="center">Emp Name</div></td>
						<td  width='16%' ><div align="center">Date</div></td>
						<td  width='16%' ><div align="center">Loan Name</div></td>
						<td  width='16%' ><div align="center">Amount<strong class="bold1"></strong></div></td>
						<td  width='16%' ><div align="center">authorization<strong class="bold1"></strong></div></td>
					</tr>
				</table></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="loanCreditTable"
					style="OVERFLOW: auto;width:100%;height:300px"></div><br><div id="totrec"> </div><br>			  </td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
  </tr>
	<tr>
		<td height="23">
		
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadloanCredit('Z')">Z</a></div>				</td>
			</tr>
		</table>						<input name="filename" type="hidden" id="filename" value="StaffLoancredit"/>
				<input name="actionS" type="hidden" id="actionS" value="PAYStaffLoanCreditDELETE"/> 
				</td>
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
		<center>
		<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>

</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	
}
%>