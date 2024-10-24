<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
 		
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SpareIssued.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		var count;
		count=0;
		coffee1=document.forms[0].rowid;
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
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="SpareIssueAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Record");
		    return false;
		}
 	}



	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].rowid;
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
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="SpareIssueAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Record");
		    return false;
		}
 	}
	

 	function Delete()
	{

	var chkbox=document.forms[0].rowid;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
		{
			len++;
		}
	}

	if(len==0)
	{
		if(chkbox.checked)
		{
			document.frm.action="../SmartLoginAuth";
			return true;
		}
		else
		{
			alert("Select Any One Value");
			return false;
		}
	}
	else if(len>=1)
	{
		var name=confirm("Confirm to Delete?");
		if(name == true)
		{
				document.frm.action="../SmartLoginAuth";
				return true;
		}
		else
		{
			return false;
		}
	}	
} 	
 	 
</script>

<body    onLoad="LoadSpareIssued('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off" name="frm" method="post"   >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<table height="227" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr   >
				<td height="31"   >
				<div align="center" class="whiteMedium">SPARE ISSUED 
				  <%
				 	String branchid=""+session.getAttribute("INVCOMPANY"); 
				  String usertype=""+session.getAttribute("USRTYPE"); 
				
				%>
				</div>				</td>
			</tr>
			<tr   >
				<td   >
				<table width="100%" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
					<tr>
						<td width="18"  >Branch</td>
						<td width="19"  ><select name="branch" style="width:200"
							id="branch" onChange="LoadSpareIssued('0')">
							<option value="0">All</option>
							<%
 
						//if("F".equals(usertype))
								//out.println("<option value='0'>All</option>");		
				String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID not in("+Integer.parseInt(branchid)+")";

				String shipids[][] =  CommonFunctions.QueryExecute(sq);
				for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
						 
			   %>
						</select>
<script language="javascript">setOptionValue('branch','<%=""+session.getAttribute("INVBRANCH")%>')</script>						
						
						</td>
						<td width="37"  >Call type </td>
						<td width="37"  > <select
							name="calltype" id="calltype" class="formText135"
							onChange="LoadSpareIssued('0')" style="width:200">
                          <option value="0">All</option>
                          <option value="N">Not Qualified</option>
                          <option value="M">No Machine</option>
                          <option value="Q">Qualified</option>
                        </select></td>
						
                        <td>Day</td>
                <td><select name="day" id="day"  onBlur="LoadSpareIssued('0') ">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
						<td width="74"  >Month </td>
						<td width="89"><select name="month" class="formText135" id="month"
							onBlur="LoadSpareIssued('0')">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="50"  >Year </td>
						<td width="88"><select name="year" class="formText135" id="year"
							onBlur="LoadSpareIssued('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script></td>
					</tr>
				</table>				</td>
			</tr>
			
			<tr class="MRow1">
				<td   valign="top" class="footermenu" height="50">
				 
						<div id="SpareDemandTable" style="OVERFLOW:auto;width:100%;height:350px" class="boldEleven">						</div><br> 
						<div align="center" id="totRec"></div><br>				</td>
		  </tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:LoadSpareIssued('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="SpareDemand" />
		<input name="actionS" type="hidden" value="INVSpareIssueDelete" /></td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="3">
			<!--DWLayoutTable-->
			<tr>
				
			<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Issue" onClick="Add()" /></td>
				<!--<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="btnEdit" value="Modify"
					onclick="return Edit()" /></td>-->



				<%
		  
		  
		 if("F".equals(usertype) || ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
		  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit3" id="btnDelete" value="Cancel"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
				<td width="56"><input type="button" class="ButtonHead"
					 value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
