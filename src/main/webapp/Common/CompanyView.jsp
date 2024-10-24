<%@ page import="java.io.*,java.util.*" isErrorPage="true"
	errorPage="../error/index.jsp"%>

<%@ page import="com.my.org.erp.bean.AttCompany"%>
<%! 
   int i;
%>
<%@ include file="insert.jsp"%>

<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
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
.OnFont {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
	color: #FFFFFF;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="CompanyAction.jsp?path=<%=path%>&qp=<%=qp%>";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].companyId
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
			if (document.forms[0].companyId.checked) { count=1;}
			 
		}
		if(count==1){			
			document.frm.action="CompanyAction.jsp?path=<%=path%>&qp=<%=qp%>";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function Delete()
 	{	
 		
		var count;
		count=0;
		coffee1=document.forms[0].companyId;
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
			if (document.forms[0].companyId.checked) { count=1;}
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
 	
  function Validate()
  {
    /*
	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") && checkDate("fromdt","todt"))
		return true;
	else
		return false;	
	*/	
  } 
  
  function mainPage()
 {
 	document.frm.action="AttendanceMain.jsp";
 }
 	
</script>

<body onpaste='return false;'>
<form action="" method="post" name="frm" AUTOCOMPLETE="off"><br>
<br>

<table width="100%" border="0" cellpadding="1" cellspacing="1">
	<tr>
		<td width="754">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
    	
		ArrayList companyList=(ArrayList) session.getAttribute("companyList");
        i=companyList.size(); 
    %>
		</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="TableDesign">
			<tr>
				<td height="31">
				<div align="center" class="whiteMedium">Company Information</div>
				</td>
			</tr>
			<tr>
				<td height="31">
				<div align="center">
				<table width="100%" border="0" cellpadding="1" cellspacing="1"
					class="whiteMedium">
					<tr>
						<td width="10" class="bold1"></td>
						<td width="300">Name</td>
						<td width="300">Legal Name</td>
						<td width="98">City</td>
						<td width="165">Country</td>
						<td width="107">Email</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="127" valign="top" class="footermenu">
				<table width="100%" align="center">

					<tr>
						<td>
						<div id="divscroll"
							style="OVERFLOW: auto; width: 100%; height: auto"
							class="boldEleven">
						<%
		
		
		String bgcolor1="#ccccc";
		String startLetter=""+request.getParameter("startLetter");
		if(startLetter.equals("null")) startLetter="";
		int count=1;  
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		for(i=0;i<companyList.size();i++)
			{
			AttCompany company= (AttCompany)companyList.get(i);
			String cName=company.getCHR_COMPANYNAME().toUpperCase();
			if(cName.startsWith(startLetter)||startLetter.equals(""))
			{	
			if(count%2==0)
				
				out.print("<tr class='MRow1' >");
				
			else
				
				out.print("<tr class='MRow2' >");			
				count++;
				out.println("<td width='10' class='boldEleven'>"+(i+1));
				out.println("<td width='10' class='boldEleven'><input type='checkbox' name='companyId' value='"+ company.getINT_COMPANYID()+"' />");
				out.println("<td  width='300' class='boldEleven'>&nbsp;"+company.getCHR_COMPANYNAME());
				out.println("<td width='300' class='boldEleven'>&nbsp;"+company.getCHR_LEGALNAME());
				out.println("<td width='98' class='boldEleven'>&nbsp;"+company.getCHR_CITY());
				out.println("<td width='165'  class='boldEleven'>&nbsp;"+company.getCHR_COUNTRY());
				out.println("<td width='107'  class='boldEleven'>&nbsp;"+company.getCHR_EMAIL());
					
			   }
				}
				out.println("</table>");
				if(count<=1) 
						{
							out.println("<center><br><br><br><font class='errormessage'>Data not found...</font></center>");
						}
				String dis="";
				if(companyList.size()==0) dis="disabled='disabled'";			
				if(count<=1) dis="disabled='disabled'";			
										%>
						</div>


						<br>
						<div align="center"><font class='bolddeepred'>Total
						no of Records :: <%=i%> </font></div>
						<br>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%
	 String reqqry ="";
 reqqry = "CompanyView.jsp?path="+path+"&qp="+qp+"&startLetter=";
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
		<td><input type="hidden" name="filename" value="Company" /> <input
			type="hidden" name="actionS" value="COMcompanyDelete" /> <input
			name="path" type="hidden" value="<%=path%>"> <input name="qp"
			type="hidden" value="<%=qp%>"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>



		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<tr>


				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Add" accesskey="s"
					onClick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" <%=dis %> value="Edit"
					onclick="return Edit()" /></td>
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit3" <%=dis %> value="Delete"
					onclick="return Delete()" /></td>
				<%
	   }
	   %>
				<td width="56"><input type="button" class="ButtonHead"
					name="submit" value="Close" accesskey="c"
					onClick="redirect('<%=closefile%>')"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
