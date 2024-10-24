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
	//document.EmployeTransfer.action="EmployeTransferAdd.jsp";
	//document.EmployeTransfer.submit();
	
		var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	       alert("Select Record to Transfer");
 	       return false;
 	    
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Transfer");
 	       return false;
 	    }
 	    if(count==1)
 	    {
		document.EmployeTransfer.action="EmployeTransferAdd.jsp";
		document.EmployeTransfer.submit();
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
		document.EmployeTransfer.action="EmployeTransferEdit.jsp";
		document.EmployeTransfer.submit();
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
				document.EmployeTransfer.action="../SmartLoginAuth";
				document.EmployeTransfer.submit();
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
<form  AUTOCOMPLETE = "off"   name="EmployeTransfer" action="../SmartLoginAuth">
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
			error = " No Employee Transfer is not available in Staffid :: " +error;
			out.println("<font color=red>"+error+"</font>");
			
		}
	%>
		</div>
		</div>
		</td>
	</tr>
	<tr>
		<td height="54">
		<table width="600" border="1" align="center" cellpadding="0"
			cellspacing="0"    >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="5"
					  bgcolor="#FFFFFF"
					class="boldEleven"><strong> <%
	    String sl=""+request.getParameter("startLetter");
		if(sl.equalsIgnoreCase("null")) sl="A";
    %> Employee Transfer </strong></td>
			</tr>
			<tr align="center" valign="middle">
				<td height="28" colspan="5"
					  bgcolor="#FFFFFF"
					class="boldEleven">
				<table width="700" border="0" cellpadding="0" cellspacing="0">
					<tr bgcolor="#FFFFFF">
						<td width="148" height="26" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Staff Id</strong></div>
						</td>
						<td width="179" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Staff Name</strong></div>
						</td>
						<td width="136" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Department</strong></div>
						</td>
						<td width="84" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Desigination</strong></div>
						</td>
						<td width="132" align="left" valign="middle"
							   class="boldEleven">
						<div align="left"><strong>Date of Joining&nbsp;</strong></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr align="center" valign="middle">
				<td height="28" colspan="5" bgcolor="#FFFFFF" class="boldEleven">

				<div id="divscroll" style="OVERFLOW: auto;width:100%;height:190px">
				<table border="0" align="left" cellpadding="0" cellspacing="0">


					<% 		
			str="SELECT CHR_EMPID,CHR_STAFFNAME,DT_DOJCOLLEGE,INT_DESIGID,INT_DEPARTID FROM  com_m_staff  WHERE CHR_STAFFNAME LIKE '"+sl+"%' ORDER BY CHR_STAFFNAME";
			rs=st.executeQuery(str);
			String empName="";
			String empId="";
			String doj="";
			String desigid="";
			String deptid="";
			String s="";
			String start="";
			String bgcolor="#b7e9ff";
			boolean aflag = false;
			boolean rflag = false;			
			boolean flag = false;
			double advAmount=0;
			String bgcolor1="#ccccc";
			boolean bgflag=false;
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
					doj =""+rs.getString("DT_DOJCOLLEGE");
					desigid=""+rs.getString("INT_DESIGID");
					deptid=""+rs.getString("INT_DEPARTID");
					
					if(doj.equals("null"))
						doj=" ";
						aflag=false;
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
			    	out.println("<td width=148>");
			    	out.println("<input type='checkbox' name='staffid' id='staffid'value='"+empId+"'>"+empId.toUpperCase());
			    	out.println("<td width='179'><a title='Edit to full detais...' class='boldEleven' href='EmployeTransferEdit.jsp?staffid="+empId+"' ><font class='boldEleven'>"+empName.toUpperCase()+"</font>");
					out.println("<td width=140>&nbsp;"+com.my.org.erp.bean.Attendance.StaffRegistration.getDepartment(deptid));
					out.println("<td width=90>&nbsp;"+com.my.org.erp.bean.Attendance.StaffRegistration.getDesigination(desigid));
					out.println("<td width=132>&nbsp;"+doj);
					 
				}
			}
			else
			{
				out.println("<tr height=15 bgcolor='#b7e9ff' class='bolddeepblue' bgcolor='#FFFFFF'>");
		    	out.println("<td width=700 bgcolor='#FFFFFF'colspan=5 align=center><br><br><br><font class='bolddeepred'> Record not found...in Starting letter '"+sl+"'</font>");
			}
			 
		%>
				</table>

				</div>
				</td>
			</tr>
		</table>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffTransfer" /> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffTransferDelete" />
		<table width="700" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=A" class="Alphalink">A</a>
				</div>
				</div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=B" class="Alphalink">B</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=C" class="Alphalink">C</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=D" class="Alphalink">D</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=E" class="Alphalink">E</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=F" class="Alphalink">F</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=G" class="Alphalink">G</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=H" class="Alphalink">H</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=I" class="Alphalink">I</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=J" class="Alphalink">J</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=K" class="Alphalink">K</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=L" class="Alphalink">L</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=M" class="Alphalink">M</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=N" class="Alphalink">N</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=O" class="Alphalink">O</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=P" class="Alphalink">P</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=Q" class="Alphalink">Q</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=R" class="Alphalink">R</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=S" class="Alphalink">S</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=T" class="Alphalink">T</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=U" class="Alphalink">U</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=V" class="Alphalink">V</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=W" class="Alphalink">W</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=X" class="Alphalink">X</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=Y" class="Alphalink">Y</a></div>
				</td>
				<td>
				<div align="center"><a
					href="EmployeTransferView.jsp?startLetter=Z" class="Alphalink">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="40">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input class="buttonbold14" name="submit2"
					type="submit" onClick="return Add()" value="Add"></td>
				<td width="56"><input class="buttonbold14" name="submit32"
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
