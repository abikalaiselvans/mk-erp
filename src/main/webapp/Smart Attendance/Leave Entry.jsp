<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>

<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Attendance/LeaveMasterEntryAjax.js"></script>

<script language="javascript">

function LeaveLink(query)
	{

		
		var f = "LeaveAssign.jsp?"+query;
		var width="600", height="450";
		var left = (screen.width/2) - width/2;
  		var top = (screen.height/2) - height/2;
		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbar=no,resizable=no,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		
  		newWindow = window.open(f,"subWind",styleStr);
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
.style4 {font-weight: bold}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body  onpaste='return false;' onLoad="loadLeaveEntrys('0')">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth">
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
	  <td height="54"><table border="0" align="center" cellpadding="0"
			cellspacing="0" class="TableDesign"
			 >
        <tr>
          <td width="854" height="20" colspan="20" align="left"
					valign="middle"   class="tablehead"><table width="574" border="0" cellpadding="0" cellspacing="0" class="whiteHead">
              <tr>
                <td width="205"  ><a
							href="LeaveType.jsp"></a></td>
                <td width="115"  ><strong>E -
                  Eligible </strong></td>
                <td width="120"  ><strong>L.T -
                  Leave Taken </strong></td>
                <td width="134">&nbsp;</td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="25" colspan="20" align="center" valign="middle"
					class="tablehead"><table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="0" class="whiteMedium">
              <tr>
                <td><strong class="boldThirteen">Office</strong></td>
                <td><span  >
                  <%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				
			  %>
                  <select name="Office" class="formText135" id="Office"  onChange="loadLeaveEntrys('0')">
                    <option value="0">All</option>
                   <%
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
	  </select><script language="javascript">setOptionValue('Office','<%=""+session.getAttribute("OFFICEID")%>')</script>	
                </span></td>
				
				<td> Category </td>
						<td  ><span class="boldEleven">
						  <select name="Category" class="formText135" id="Category" onChange ="loadLeaveEntrys('0')">
                            <option value='0' >All</option>
                            <%
 
String empcategoryData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST  FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(empcategoryData.length>0)
 	for(int u=0;u<empcategoryData.length;u++)
		out.println("<option value='"+empcategoryData[u][0]+"'>"+empcategoryData[u][1]+"</option>");
 %>
                          </select>
<script language="javascript">setOptionValue('Category','<%=""+session.getAttribute("CATEGORY")%>')</script>						  
						  
						</span></td>
				
                <td><span  ><strong>Department</strong></span></td>
                <td><select name="dept" id="dept" class="formText135" onChange="loadLeaveEntrys('0')">
                    <option value="0">All</option>
                    <%
		String sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
                </select></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>			<select
							name="year" class="formText135" id="year" onChange="loadLeaveEntrys('0')"
							>
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						 var year1=d.getFullYear();
						 
						setOptionValue('year',year1);							
				//-->
            </script>			</td>
                <td>Search</td>
                <td><input name="search" type="text" class="formText135" id="search" onKeyUp="loadLeaveEntrys('0')"></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="25" colspan="20" align="left" valign="middle"
					  class="tablehead"
					 ><div align="center"  ><strong>
              <%
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
		 
			
    %>
              <span class="whiteHead">Leave</span></strong></div></td>
        </tr>
        <tr >
          <td height="31" class="MRow1" ><%
				String sql = "SELECT CHR_LEAVENAME FROM att_m_leavetype ORDER BY INT_LEAVEID";
				String Leaves[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
				String tb ="<table    width='100%'  bordercolor='#ffffff'  cellpadding='2' cellspacing='1'>";
				tb= tb+"<tr><td      align='center' width='200' ><b>Staffid</b></td><td  width='220' align='center'><b>Staff Name </b></td>";
				for(int u=0; u<Leaves.length; u++)
					tb= tb+"<td  colspan='2'   width='100' align='center'><b>"+Leaves[u][0]+"</b></td>";
				tb = tb+"<tr><td   >&nbsp; </td><td   >&nbsp; </td>";
				for(int u=0; u<Leaves.length; u++)
					tb = tb+"<td   align='center' width='50'bgcolor='#FFE4C4'><b>E</b></td><td bgcolor='#D2E7E8'   width='50' align='center'><b>L.T.</b></td>";
				tb=tb+"</tr></table>";		
      			out.println(tb);	
			%>
              <input name="leavelength" type="hidden" id="leavelength"
					value="<%=Leaves.length%>"></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"><div id="LeaveTable" style="OVERFLOW: auto;width=auto;height:300px"></div><br>
		  <div id="totRec"></div>
		  <br></td>
        </tr>
      </table></td>
	</tr>
	<tr>
		<td height="23"></td>
	</tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffLeave"> <input name="actionS"
			type="hidden" id="actionS" value="ATTStaffLeaveDelete">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadLeaveEntrys('Z')">Z</a></div>				</td>
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
				<td width="56"><input name="Edit" type="hidden"
					class="ButtonHead" id="Edit" onClick="return Edit();" value="Edit"></td>
				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')"></td>
				<td width="56"><input name="Delete" type="hidden"
					class="ButtonHead" id="Delete" onClick="return Delete();"
					value="Delete"></td>
			</tr>
		</table>		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
