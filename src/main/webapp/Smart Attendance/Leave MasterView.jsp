<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><html>
<head>

<title> :: ATTENDANCE ::</title>



<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Attendance/LeaveMasterAjax.js"></script>
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


	
function LMEdit()
{		
  		var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		if(count < 1)
 	    {
 	       alert("Select Record to Edit");
 	       return false;
 	    
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false;
 	    }
 	    if(count == 1)
 	    {
		document.allowancefrm.action="StaffLeaveEdit.jsp";
		document.allowancefrm.submit();
		return true;
		}
 	}



 function LMDelete()
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
		
		if(count>=1)
		{			
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
 	
 	
 	 function mainPage()
	{
	 document.allowancefrm.action="AttendanceMain.jsp";
	 document.allowancefrm.submit();
    }
	function buttondisable()
{
		document.getElementById('Delete').disabled=true;
     	//document.getElementById('Edit').disabled=true;
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

<body  onpaste='return false;' onLoad="loadLeaveEntry('0')">
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
		<td height="23"  >&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="90%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="TableDesign"    
			 >
			<tr>
				<td width="923" height="20" colspan="20" align="left"
					valign="middle"   class="tablehead">
				<table width="740" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr>
						<td width="205"  ><!--<span  ><a
							href="LeaveType.jsp">Add Leave Type</a></span>--></td>
						<td width="115"  >E -
						Eligible </td>
						<td width="159"  ><strong>LT -
						Leave Taken </strong></td>
						<td width="261">&nbsp;</td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td height="30" colspan="20" align="left" valign="middle"
					 >
				<div align="center"  ><strong> <%
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
		 
			
    %> Leave</strong></div>				</td>
			</tr>
			<tr>
				<td height="20" colspan="20" align="center" valign="middle"
					  class="tablehead">
				<table width="90%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium"  >
					<tr>
						<td>Office</td>
						<td>
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office" tabindex="6" onChange="loadLeaveEntry('0')">
							<option value="0">All</option>
							
							
							<%
	String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('Office','<%=""+session.getAttribute("OFFICEID")%>')</script>	   </td>
						<td> Category </td>
						<td  ><span class="boldEleven">
						  <select name="Category" class="formText135" id="Category" onChange ="loadLeaveEntry('0')">
                            <option value='0' >All</option>
                            <%

String empcategoryData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST  FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
 	for(int u=0;u<empcategoryData.length;u++)
		out.println("<option value='"+empcategoryData[u][0]+"'>"+empcategoryData[u][1]+"</option>");
 %>
                          </select>
<script language="javascript">setOptionValue('Category','<%=""+session.getAttribute("CATEGORY")%>')</script>						  
						  
						</span></td>
						<td  >Department</td>
						<td  ><select name="dept" id="dept"
							class="formText135" onChange="loadLeaveEntry('0')">
							<option value="0">All</option>
							<%
		String sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
						</select></td>
						<td  >Year</td>
						<td  ><span class="boldThirteen"> <select
							name="year" class="formText135" id="year"
							onChange="loadLeaveEntry('0')">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						 var year1=d.getFullYear();
						 
						setOptionValue('year',year1);							
				//-->
            </script> </span></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td class="whiteMedium"  ><%
				String sql = "SELECT CHR_LEAVENAME FROM att_m_leavetype ORDER BY INT_LEAVEID";
				String Leaves[][]= CommonFunctions.QueryExecute(sql);
				String tb ="<table border='0' width='100%'  bordercolor='#EEEAFE' class='whiteMedium' cellpadding='2' cellspacing='2' align='center'>";
				tb= tb+"<tr><td width=50 align='center'><b>S.No</b></td><td width=100  align='center'><b>Staffid</b></td><td   width=150 ><b>Staff Name </b></td>";
				for(int u=0; u<Leaves.length; u++)
					tb= tb+"<td  colspan='2'><b>"+Leaves[u][0]+"</b></td>";
					
				tb = tb+"<tr><td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td>";
				for(int u=0; u<Leaves.length; u++)
					tb = tb+"<td   ><b>E</b></td><td><b>LT</b></td>";
				tb=tb+"</tr></table>";		
      			out.println(tb);	
			%>
			    <input name="leavelength" type="hidden" id="leavelength"
					value="<%=Leaves.length%>"></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF">
				<div id="LeaveTable" style="OVERFLOW: auto;width:100%;height:300px"></div>
				<br>
				<div id='totalrecord' align="center"></div>
				<br>			  </td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
    </tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffLeave"> <input name="actionS"
			type="hidden" id="actionS" value="ATTStaffMasterLeaveDelete">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('N')">N</a></div>			  </td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntry('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="40">&nbsp;</td>
    </tr>
	<tr>
		<td height="40">

		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="submit" onClick=Add() value="Add"></td>

				 

				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="mainPage()"><input name="Delete"  id="Delete" type="hidden" value="Delete"></td>
			</tr>
		</table>		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
