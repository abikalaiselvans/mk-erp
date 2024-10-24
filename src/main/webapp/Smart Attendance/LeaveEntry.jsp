<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>

<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

function LeaveLink(query)
	{

		var f = "LeaveAssign.jsp?"+query;
		newWindow = window.open(f,"subWind",",,height=270,width=437,top=0,left=0");
		newWindow.focus( );

	}



function validate()
{
    if(checkNull("ename","Select Staff"))
    	return true;
    else
    	return false;
}
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
	
	
function Add()
{		
	document.allowancefrm.action="StaffLeaveAdd.jsp";
	document.allowancefrm.submit();
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
		document.allowancefrm.action="StaffLeaveEdit.jsp";
		document.allowancefrm.submit();
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
<form  AUTOCOMPLETE = "off"   name="allowancefrm" action="../SmartLoginAuth">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="23" class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="940" border="1" align="center" cellpadding="0"
			cellspacing="0"    >
			<tr>
				<td width="923" height="20" colspan="20" align="left"
					valign="middle"   class="tablehead">
				<table width="574" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="205" class="boldEleven"><span class="boldEleven"><a
							href="LeaveType.jsp">Add Leave Type</a></span></td>
						<td width="115" class="boldEleven"><strong>E -
						Eligible </strong></td>
						<td width="86" class="boldEleven"><strong>A -
						Available </strong></td>
						<td width="168">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="20" colspan="20" align="left" valign="middle"
					  class="tablehead"
					 >
				<div align="center" class="boldEleven"><strong> <%
	    String sl=""+request.getParameter("startLetter");
		if(sl.equalsIgnoreCase("null")) sl="A";
		String fs =StaffRegistration.leaveTypeValue();
		String column[] = StaffRegistration.leaveTypeValue().split("~");
		int fl= column.length;
		int al = 9-fl;
		String addfield="";
		if((fl+1)<10)
		{
			for(int u=(fl+1); u<=9; u++)
				addfield = addfield +"LEAVE"+u+"~";
		}	
		fs = fs+addfield;
		
		String columnName[]=fs.split("~");
		 
			
    %> Leave</strong></div>
				</td>
			</tr>
			<tr>
				<td>
				<div id="divscroll" style="OVERFLOW: auto;width:950px;height:190px">
				<table width="100%" border="0" cellpadding="1" cellspacing="2">
					<tr bgcolor="#6E8FBC" class="boldEleven">
						<td width="71" rowspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>Staff Id</strong></div>
						</td>
						<td width="75" rowspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>Staff Name</strong></div>
						</td>
						<td colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[0]%></strong></div>
						</td>
						<td colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[1]%></strong></div>
						</td>
						<td colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[2]%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[3]%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[4]%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[5]%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[6]%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[7]%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[8]%></strong></div>
						</td>
					</tr>
					<tr bgcolor="#6E8FBC">
						<td width="32" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="39" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="36" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="35" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="34" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="37" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="35" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="36" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="34" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="37" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="34" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="37" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="31" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="40" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="26" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="45" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="47" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="97" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
					</tr>

					<% 		
			str="SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_STAFFNAME LIKE '"+sl+"%' ORDER BY CHR_STAFFNAME";
			rs=st.executeQuery(str);
			String empName="";
			String empId="";
			String s="";
			String start="";
			String bgcolor="#E0E0E0";
			boolean lflag = false;
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
		    		out.println("<tr bgcolor='"+bgcolor1+"' class='boldEleven'>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>");
					out.println("<input type='checkbox' name='staffid' id='staffid'value='"+empId+"'>"+empId.toUpperCase()+"</td>");
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>"+empName.toUpperCase()+"</td>");
			    	
			    	String leave1[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD1","INT_NOD1BALANCE").split("~");
			    	String m1 =leave1[0];
			    	String u1 =leave1[1];
					String urlink="";
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&";
					out.println("<a href='javascript:LeaveLink("+urlink+")'><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				String leave2[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD2","INT_NOD2BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave2[0];
			    	u1 =leave2[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<a href='javascript:LeaveLink("+urlink+")'><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				String leave3[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD3","INT_NOD3BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave3[0];
			    	u1 =leave3[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td   align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				
    				String leave4[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD4","INT_NOD4BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave4[0];
			    	u1 =leave4[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td   align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				
    				String leave5[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD5","INT_NOD5BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave5[0];
			    	u1 =leave5[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td     align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				String leave6[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD6","INT_NOD6BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave6[0];
			    	u1 =leave6[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td     align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				
    				String leave7[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD7","INT_NOD7BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave7[0];
			    	u1 =leave7[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td    align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				
    				String leave8[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD8","INT_NOD8BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave8[0];
			    	u1 =leave8[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				String leave9[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD9","INT_NOD9BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave9[0];
			    	u1 =leave9[1];
			    	if(Double.parseDouble(m1)<1)m1="0";
			    	if(Double.parseDouble(u1)<1)u1="0";
			    	out.println("<td     align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					//urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1";
					//out.println("<a href='javascript:LeaveLink("+urlink+")'><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("<font class='boldElevenlink' >"+u1+"</font>");
					out.println("</td>");
    				
    				out.println("</tr>");
					 
				 	
					 
				}
			}
			else
			{
				out.println("<tr height=50 bgcolor='#DCE4F9' class='bolddeepblue'>");
		    	out.println("<td  colspan=20 align=center><font color='#993300'> Record not found...in Starting letter '"+sl+"'</font>");
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
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffLeave"> <input name="actionS"
			type="hidden" id="actionS" value="ATTStaffLeaveDelete">
		<table width="950" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=A">A</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=B">B</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=C">C</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=D">D</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=E">E</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=F">F</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=G">G</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=H">H</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=I">I</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=J">J</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=K">K</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=L">L</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=M">M</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=N">N</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=O">O</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=P">P</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=Q">Q</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=R">R</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=S">S</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=T">T</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=U">U</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=V">V</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=W">W</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=X">X</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=Y">Y</a></div>
				</td>
				<td>
				<div align="center"><a
					href="Leave MasterView.jsp?startLetter=Z">Z</a></div>
				</td>
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
					name="Button"  value="Close"   accesskey="c"  onClick="javascript:history.back()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>

</html>
