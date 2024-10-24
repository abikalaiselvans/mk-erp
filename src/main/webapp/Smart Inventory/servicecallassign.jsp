<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/serviceCallAssign.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ServiceCallAssignAdd.jsp";
 	}

	function SEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Bookingid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].Bookingid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceCallAssignEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function RDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Bookingid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].Bookingid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
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
 	

 	function PageBack()
	{
	     //future enhancement
    }
 	
  function Validate()
  {
    /*
	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") && checkDate("fromdt","todt"))
		return true;
	else
		return false;	
	*/	
  } 
 	
</script>

<body    onLoad="LoadAMCCallAssign('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="189" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
			  <td height="31"  >
				<div align="center" class="boldThirteen">Service call Assign Details &nbsp;&nbsp;&nbsp;</div>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<table border="0" align="center" cellpadding="3" cellspacing="3" class="whiteMedium">
					<tr>
					  <td valign="top"  >Branch</td>
					  <td><select name="branch" id="branch"  class="formText135"   onChange="LoadAMCCallAssign('0')"  >
                          <%
			   	String branchid=""+session.getAttribute("INVBRANCH"); 
				String suertype=""+session.getAttribute("USRTYPE"); 
				if("F".equals(suertype) )  
				{
					out.println("<option value='0'>All</option>");								
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  ";
					String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}
				else
				{
					
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID = "+branchid;
					String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}	
				 
			   %>
                      </select></td>
					  <td  ><strong>Service Center </strong></td>
					  <td  ><strong>
                        <select name="servicecenter" class="formText135"  id="servicecenter"   onChange="LoadAMCCallAssign('0')" >
                          <option value="0">All</option>
                          <%
				String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                        </select>
                      </strong> </td>
					  <td height="28"  >Call Status</td>
					  <td><select name="callstatus" class="formText135" id="callstatus"  onChange="LoadAMCCallAssign('0')" >
                        <option value="0" >All</option>
                        <option value="C" >Completed</option>
                        <option value="P" >Pending</option>
                        <option value="N" >New Call</option>
						<option value="R" >Cancelled / Rejected</option>
                      </select></td>
					  <td  ><span  >Month</span></td>
					  <td><span class="boldThirteen">
					    <select name="month" class="formText135" id="month" onChange="LoadAMCCallAssign('0')">
                          <option value="0">All</option>
						  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                        </select>
					  </span></td>
					  <td  ><span  >Year</span></td>
					  <td><span class="boldThirteen">
					    <select name="year" class="formText135" id="year" onChange="LoadAMCCallAssign('0')">
                          <%@ include file="../JavaScript/Inventory/year.jsp"%>
                        </select>
                        <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                        </script>
					  </span></td>
				    </tr>
				</table>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				
				<br>
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto"
							 ></div>
				<br>
				 				</td>
		  </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('0')">All</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('A')">A</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('B')">B</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('C')">C</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('D')">D</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('E')">E</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('F')">F</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('G')">G</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('H')">H</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('I')">I</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('J')">J</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('K')">K</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('L')">L</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('M')">M</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('N')">N</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('O')">O</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('P')">P</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('Q')">Q</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('R')">R</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('S')">S</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('T')">T</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('U')">U</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('V')">V</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('W')">W</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('X')">X</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('Y')">Y</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallAssign('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="ServiceCallAssign" />
		<input name="actionS" type="hidden" value="INVServiceCallAssignHistoryDELETE" /></td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				 
				<td width="56" valign="top"><input name="Edit" type="submit"
					class="ButtonHead" id="Edit" onClick="return SEdit()"
					value="Edit" /></td>
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input name="Delete" type="submit"
					class="ButtonHead" id="Delete" onClick="return RDelete()"
					value="Delete" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='Delete'>");
		}
		%>
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
