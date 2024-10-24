<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>

<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript"
	src="../JavaScript/Attendance/AttendanceAjax.js"></script>

<script language="javascript">

function LeaveLink(query)
	{

		var f = "LeaveAssign.jsp?"+query;
		var width="405", height="320";
		var left = (screen.width/2) - width/2;
  		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbar=no,resizable=no,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		
  		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
		
		
		/*
		var width="375", height="250";
  		var left = (screen.width/2) - width/2;
  		var top = (screen.height/2) - height/2;
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbar=no,resizable=no,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;

  var msgWindow = window.open("","msgWindow", styleStr);
		*/

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
	//document.allowancefrm.action="StaffLeaveAdd.jsp";
	//document.allowancefrm.submit();
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

<body  onpaste="return false;" onLoad="loadLeaveEntry('0')">
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
							href="LeaveType.jsp"></a></span></td>
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
	    String req=""+request.getParameter("startLetter");
      
      
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


			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="25%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="boldEleven">
					<tr>

						<td><span class="boldEleven">Year ::</span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onBlur="loadLeaveEntry('0')">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> </span></td>
					</tr>
				</table>
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
						<div align="center"><strong><%=columnName[0].toUpperCase()%></strong></div>
						</td>
						<td colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[1].toUpperCase()%></strong></div>
						</td>
						<td colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[2].toUpperCase()%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[3].toUpperCase()%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[4].toUpperCase()%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[5].toUpperCase()%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[6].toUpperCase()%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[7].toUpperCase()%></strong></div>
						</td>
						<td height="26" colspan="2" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong><%=columnName[8].toUpperCase()%></strong></div>
						</td>
					</tr>
					<tr bgcolor="#6E8FBC">
						<td width="45" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="46" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="36" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="59" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="39" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="38" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="58" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="57" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="34" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="43" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="41" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="42" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="36" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="40" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="29" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="30" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
						<td width="24" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>E</strong></div>
						</td>
						<td width="25" height="16" align="left" valign="middle"
							    
							class="boldEleven">
						<div align="center"><strong>A</strong></div>
						</td>
					</tr>

					<% 		
        if("null".equals(req) || "AL".equals(req))
  		{       
        	str="SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff ";
  		}
        else
			str="SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_STAFFNAME LIKE '"+req+"%' ORDER BY CHR_STAFFNAME";
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
					if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=0";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				String leave2[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD2","INT_NOD2BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave2[0];
			    	u1 =leave2[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=1";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font  class='boldElevenlink'  >"+u1+"</font><a>");
					out.println("</td>");
    				
    				String leave3[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD3","INT_NOD3BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave3[0];
			    	u1 =leave3[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td   align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=2";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink' >"+u1+"</font><a>");
					
					out.println("</td>");
    				
    				
    				String leave4[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD4","INT_NOD4BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave4[0];
			    	u1 =leave4[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td   align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=3";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				
    				String leave5[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD5","INT_NOD5BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave5[0];
			    	u1 =leave5[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td     align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=4";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				String leave6[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD6","INT_NOD6BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave6[0];
			    	u1 =leave6[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td     align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=5";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink'  >"+u1+"</font><a>");
					out.println("</td>");
    				
    				
    				String leave7[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD7","INT_NOD7BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave7[0];
			    	u1 =leave7[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td    align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=6";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				
    				String leave8[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD8","INT_NOD8BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave8[0];
			    	u1 =leave8[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=7";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font  class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				String leave9[] =StaffRegistration.leaveRecordExist(empId,"INT_NOD9","INT_NOD9BALANCE").split("~");
    				m1=" ";u1=" ";
    				m1 =leave9[0];
			    	u1 =leave9[1];
			    	if(Double.parseDouble(m1)<0)m1="0";
			    	if(Double.parseDouble(u1)<0)u1="0";
			    	out.println("<td     align='left' valign='middle' class='boldEleven'>&nbsp;"+m1+"</td>");
    				out.println("<td  align='left' valign='middle' class='boldEleven'>&nbsp;");
					urlink="A="+u1+"&E="+m1+"&staffid="+empId+"&column=INT_NOD1&leave=8";
					out.println("<a href=javascript:LeaveLink('"+urlink+"')><font class='boldElevenlink' >"+u1+"</font><a>");
					out.println("</td>");
    				
    				out.println("</tr>");
					 
				 	
					 
				}
			}
			else
			{
				out.println("<tr height=50 bgcolor='#DCE4F9' class='bolddeepblue'>");
		    	out.println("<td  colspan=20 align=center><font color='#993300'> Record not found...in Starting letter '"+req+"'</font>");
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
				<div align="center"><a href="javascript:loadLeaveEntry('0')">All</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('A')">A</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('B')">B</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('C')">C</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('D')">D</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('E')">E</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('F')">F</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('G')">G</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('H')">H</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('I')">I</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('J')">J</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('K')">K</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('L')">L</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('M')">M</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('N')">N</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('O')">O</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('P')">P</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('Q')">Q</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('R')">R</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('S')">S</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('T')">T</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('U')">U</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('V')">V</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('W')">W</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('X')">X</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('Y')">Y</a></div>
				</td>
				<td>
				<div align="center"><a href="javascript:loadLeaveEntry('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="40">

		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
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
