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
	//document.StaffPromotion.action="StaffPromotionAdd.jsp";
	//document.StaffPromotion.submit();
	var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	       alert("Select Record to Promotion");
 	       return false;
 	    
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Promotion");
 	       return false;
 	    }
 	    if(count==1)
 	    {
		document.StaffPromotion.action="StaffPromotionAdd.jsp";
		document.StaffPromotion.submit();
		return true;
		}
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
		document.StaffPromotion.action="StaffPromotionEdit.jsp";
		document.StaffPromotion.submit();
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
				document.StaffPromotion.action="../SmartLoginAuth";
				document.StaffPromotion.submit();
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
<form  AUTOCOMPLETE = "off"   name="StaffPromotion" action="../SmartLoginAuth">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td class="bolddeepred">
		<div align="center">
		<%
		String error = ""+request.getParameter("staffid");
		
		if (error.equals("") || error.equals("null"))
		{
		}
		else
		{
			error = "Employee Promotion rtecord is not available in Staffid :: " +error;
			out.println("<font color=red>"+error+"</font>");
			
		}
	%>
		</div>
		</td>
	</tr>
	<tr>
		<td height="54">
		<table width="654" border="1" align="center" cellpadding="0"
			cellspacing="0"    >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28"  
					class="tablehead">
				<%
	    String sl=""+request.getParameter("startLetter");
		if(sl.equalsIgnoreCase("null")) sl="A";
    %> <span class="boldEleven"><strong>Employee
				Promotion</strong></span></td>
			</tr>
			<tr align="center" valign="middle">
				<td width="650" height="28"
					  class="tablehead">
				<div align="left">
				<table width="650" border="0" align="left" cellpadding="0"
					cellspacing="0"  
					  >
					<!--DWLayoutTable-->
					<tr  
						  >
						<td width="160" height="26" align="left" valign="middle"
							  "" class="boldEleven">
						<div align="left"><strong>Staff Id</strong></div>
						</td>
						<td width="160" align="left" valign="middle"  
							"" class="boldEleven">
						<div align="left"><strong>Staff Name</strong></div>
						</td>
						<td width="160" align="left" valign="middle"  
							"" class="boldEleven">
						<div align="left"><strong>&nbsp;Department</strong></div>
						</td>
						<td width="160" align="left" valign="middle"  
							"" class="boldEleven">
						<div align="left"><strong>Designation</strong></div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">

				<div id="divscroll" style="OVERFLOW: auto;width:650px;height:190px">
				<table border="0" align="left" cellpadding="0" cellspacing="0">

					<% 		
			str="SELECT CHR_EMPID,CHR_STAFFNAME ,INT_DEPARTID,INT_DESIGID FROM  com_m_staff  WHERE CHR_STAFFNAME LIKE '"+sl+"%' ORDER BY CHR_STAFFNAME";
			rs=st.executeQuery(str);
			String empName="";
			String empId="";
			String s="";
			String start="";
			String bgcolor="#b7e9ff";
			String bgcolor1="#ccccc";
			boolean bgflag=false;
			boolean aflag = false;
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
					//aflag =StaffRegistration.cessationRecordExist(empId.trim()) ;
					aflag=false;
					 
						
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
			    	out.println("<td width=162>");
			    	out.println("<input type='checkbox' name='staffid' id='staffid'value='"+empId+"'>"+empId.toUpperCase());
			    	out.println("<td width='175'><a title='Edit to full detais...' class='boldEleven' href='StaffPromotionEdit.jsp?staffid="+empId+"' ><font class='boldEleven'>"+empName+"</font>");
					out.println("<td width=162>"+com.my.org.erp.bean.Attendance.StaffRegistration.getDepartment(rs.getString("INT_DEPARTID")));
			    	out.println("<td width=162>"+com.my.org.erp.bean.Attendance.StaffRegistration.getDesigination(rs.getString("INT_DESIGID")));
					 
					 
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
		</td>
	</tr>
	<tr>
		<td height="23">
		<table width="650" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="boldEleven">
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=A">A</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=B">B</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=C">C</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=D">D</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=E">E</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=F">F</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=G">G</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=H">H</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=I">I</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=J">J</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=K">K</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=L">L</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=M">M</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=N">N</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=O">O</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=P">P</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=Q">Q</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=R">R</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=S">S</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=T">T</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=U">U</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=V">V</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=W">W</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=X">X</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=Y">Y</a></td>
				<td class="newsmenu"><a
					href="EmployePromotionView.jsp?startLetter=Z">Z</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="57"><input name="filename" type="hidden"
			id="filename" value="StaffPromotion" /> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffPromotionDelete" />
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input class="buttonbold14" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				<td width="56"><input class="buttonbold14" name="submit3"
					type="submit" onClick="return Edit();" value="Edit"></td>
				<td width="56"><input class="buttonbold14" name="submit3"
					type="Button" onClick="return Delete();" value="Delete"></td>
				<td width="56"><input class="buttonbold14" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
<%@ include file="../footer.jsp"%></form>
</body>

</html>
