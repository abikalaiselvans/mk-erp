<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
<%@ page import="com.my.org.erp.bean.State"%>
<%
try
{
%>
<%@ include file="insert.jsp"%>

<%!
	String stateId,stateName;
    int i=0;
%>

<input name="path" id="path" type="hidden" value="<%=path%>">
<input name="qp" id="qp" type="hidden" value="<%=qp%>">

<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}

.style9 {
	color: #FFFFFF
}

.style10 {
	font-family: Verdana;
	font-size: 12px;
	color: #FFFFFF;
}

a:visited {
	color: #663366;
}

a:hover {
	color: #FF0000;
}

a:active {
	color: #0000FF;
}
-->
</style>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptStateName
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
			if (document.forms[0].OptStateName.checked) { count=1;}
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
	
 	function SEdit()
 	{		
		 var count;
		count=0;
		coffee1=document.forms[0].OptStateName
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
			if (document.forms[0].OptStateName.checked) { count=1;}
		}
		if(count==1){			
			 document.frm.action="StateAction.jsp?path=<%=path%>&qp=<%=qp%>";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	function SAdd()
 	{				
		document.frm.action="StateAction.jsp?path=<%=path%>&qp=<%=qp%>";
 	}	 
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
<body onpaste='return false;'>
<form AUTOCOMPLETE="off" name="frm" method="post">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<% 
	 
		ArrayList stateList=(ArrayList) session.getAttribute("stateList");
        	int totalRecord=stateList.size(); 
		
    %><input name="path" type="hidden" value="<%=qp%>"></td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="195" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign">
			<tr>
				<td height="31">
				<div align="center">STATE</div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="159" valign="top" class="footermenu">

				<div id="divscroll"
					style="OVERFLOW: auto; width: 100%; height: 250px"
					class="boldEleven">
				<table width='100%' class='boldEleven' id='myTable' cellpadding=2
					cellspacing=1 bgcolor='#9900CC'>


					<%
						String bgcolor1="#ccccc";
						String startLetter=""+request.getParameter("startLetter");
						String editlink="";
						if(startLetter.equals("null")) startLetter="";
						int count=1;  
						for(i=0;i<stateList.size();i++)
						{
							State state= (State)stateList.get(i);								
							String stateName=state.getStateName().toUpperCase();
							editlink="";
							if(stateName.startsWith(startLetter)||startLetter.equals(""))
							{
								editlink="StateAction.jsp?path="+path+"&qp="+qp+"&OptStateName="+state.getStateId()+"&action1=Edit";
								if(count%2==0)
									out.print("<tr class='MRow1'>");
								else
									out.print("<tr  class='MRow2'>");			
								count++;
								
					%>

					<td class="boldEleven" width="614"><input type="checkbox"
						name="OptStateName" value='<%= state.getStateId()%>'> <a
						href="<%=editlink%>"><font class="boldEleven"><%=state.getStateName()%></font></a>
					</td>

					<%
							}
	         			}
						if(count<=1) 
						{
							out.println("<center><br><br><br><font class='errormessage'>Data not found...</font></center>");
						}
						String dis="";
			  			if(stateList.size()==0) dis="disabled='disabled'";	
						if(count<=1) dis="disabled='disabled'";			
						stateId=request.getParameter("stateId");
										%>
					</tr>
				</table>
				</div>
				<br>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%
 String reqqry ="";
 reqqry = "StateView.jsp?path="+path+"&qp="+qp+"&startLetter=";
 %>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"null"%>'>All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"A"%>'>A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"B"%>'>B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"C"%>'>C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"D"%>'>D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"E"%>'>E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"F"%>'>F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"G"%>'>G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"H"%>'>H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"I"%>'>I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"J"%>'>J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"K"%>'>K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"L"%>'>L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"M"%>'>M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"N"%>'>N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"O"%>'>O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"P"%>'>P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"Q"%>'>Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"R"%>'>R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"S"%>'>S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"T"%>'>T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"U"%>'>U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"V"%>'>V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"W"%>'>W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"X"%>'>X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"Y"%>'>Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href='<%=reqqry+"Z"%>'>Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="State"> <input
			type="hidden" name="actionS" value="ATTstateDelete"> <input
			type="hidden" name="msg" value=""></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input class="ButtonHead"
					type="submit" onClick="SAdd()" name="action1" value="Add"></td>
				<td width="56" valign="top"><input class="ButtonHead"
					type="submit" onClick="return SEdit()" name="action1" value="Edit"
					<%=dis %>></td>

				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input name="Submit" type="submit"
					class="ButtonHead" onClick="return Delete()" value="Delete"
					<%=dis %>></td>

				<%
		 }
		 %>
				<td width="56" valign="top"><input type="button" name="Submit"
					class="ButtonHead" value="Close" accesskey="c"
					onClick="redirect('<%=closefile%>')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
