<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function Add()
{		
	document.Cessationfrm.action="CessationAdd.jsp";
	document.Cessationfrm.submit();
}	


function Edit()
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
		document.Cessationfrm.action="CessationEdit.jsp";
		document.Cessationfrm.submit();
		return true;
		}
 	}



 function Delete()
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
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.Cessationfrm.action="../SmartLoginAuth";
				document.Cessationfrm.submit();
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
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="Cessationfrm" action="../SmartLoginAuth">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>
		<div align="center" class="bolddeepred">

		<div align="center">
		<%
		String error = ""+request.getParameter("staffid");
		
		if (error.equals("") || error.equals("null"))
		{
		}
		else
		{
			error = " No Employee Cessation is not available in Staffid :: " +error;
			out.println("<font color=red>"+error+"</font>");
			
		}
	%>
		</div>
		</div>
		</td>
	</tr>
	<tr>
		<td height="54">
		<table width="650" border="1" align="center" cellpadding="0"
			cellspacing="0"    >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="4"
					  bgcolor="#FFFFFF"
					class="tablehead">
				<%
	    String sl=""+request.getParameter("startLetter");
		if(sl.equalsIgnoreCase("null")) sl="A";
    %> <span class="boldEleven"><strong>Employee
				Cessation</strong></span></td>
			</tr>
			<tr align="center" valign="middle">
				<td height="28" colspan="4"
					  bgcolor="#FFFFFF"
					class="tablehead">
				<table width="650" border="0" cellpadding="0" cellspacing="0">
					<tr  >
						<td width="183" height="26" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Staff Id</strong></div>
						</td>
						<td width="218" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Staff Name</strong></div>
						</td>
						<td width="125" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Cessation</strong></div>
						</td>
						<td width="120" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Date</strong></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr align="center" valign="middle">
				<td height="28" colspan="4" bgcolor="#FFFFFF" class="tablehead">
				<div id="divscroll" style="OVERFLOW: auto;width:100%;height:190px">
				<table border="0" align="left" cellpadding="0" cellspacing="0">
					<% 		
			str="SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_STAFFNAME LIKE '"+sl+"%' ORDER BY CHR_STAFFNAME";
			rs=st.executeQuery(str);
			String empName="";
			String empId="";
			String s="";
			String start="";
			String bgcolor="#b7e9ff";
			boolean aflag = false;
			String bgcolor1="#ccccc";
			boolean bgflag=false;
			
			boolean rflag = false;			
			boolean flag = false;
			double advAmount=0;
			int rcount=0;
			while(rs.next())
				rcount =rcount +1;
			if( rcount>0)
			{
				rs=st.executeQuery(str);
				while(rs.next())
				{	
					empName = ""+rs.getString("CHR_STAFFNAME");
					empId = ""+rs.getString("CHR_EMPID");
					aflag =StaffRegistration.cessationRecordExist(empId.trim()) ;
					
					if(aflag==false) 
						 ;	
					else
						bgcolor="#fff0ff";	
						
					if(bgflag)
					{
						bgflag = false;
						bgcolor1="#FFFFFF";
					}
					else
					{
						bgflag = true;
						bgcolor1="#EEFFEE";
					}	
		    		out.println("<tr bgcolor='"+bgcolor1+"' class='bolddeepblue'>");
			    	out.println("<td width=183>");
			    	out.println("<input type='checkbox' name='staffid' id='staffid'value='"+empId+"'>"+empId.toUpperCase());
			    	
					out.println("<td width='179'><a title='Edit to full detais...' class='boldEleven' href='CessationEdit.jsp?staffid="+empId+"' ><font class='boldEleven'>"+empName.toUpperCase()+"</font>");
					
					
					if (aflag)
					{
						out.println("<td width=125><font color=green><b>"+"Y</b></green>");
						String dt =StaffRegistration.getCessation(empId);
						out.println("<td width=120>"+dt);
					}
					else
					{
						out.println("<td width=125><font color=red>"+"N</font>");
						out.println("<td width=120>&nbsp;");	
					}
					 
				}
			}
			else
			{
				out.println("<tr height=15 bgcolor='#b7e9ff' class='bolddeepblue'>");
		    	out.println("<td  colspan=4 align=center><font color='#993300'> Record not found...in Starting letter '"+sl+"'</font>");
			}
			 
		%>
				</table>

				</div>
				</td>
			</tr>
		</table>
	</tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffCessation" /> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffCessationDelete" />
		<table width="650" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="boldEleven">
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=A">A</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=B">B</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=C">C</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=D">D</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=E">E</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=F">F</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=G">G</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=H">H</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=I">I</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=J">J</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=K">K</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=L">L</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=M">M</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=N">N</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=O">O</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=P">P</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=Q">Q</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=R">R</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=S">S</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=T">T</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=U">U</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=V">V</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=W">W</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=X">X</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=Y">Y</a></td>
				<td class="newsmenu"><a
					href="Employee Cessation.jsp?startLetter=Z">Z</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="40">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input class="buttonbold" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				<td width="56"><input class="buttonbold" name="submit3"
					type="submit" onClick="return Edit();" value="Edit"></td>
				<td width="56"><input class="buttonbold" name="submit3"
					type="Button" onClick="return Delete();" value="Delete"></td>
				<td width="56"><input class="buttonbold" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
<%@ include file="../footer.jsp"%></form>
</body>

</html>
