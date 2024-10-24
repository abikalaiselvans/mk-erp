<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
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
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="VendorInfoAdd.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].vendorid
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].vendorid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="VendorInfoAdd.jsp";
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
		coffee1=document.forms[0].vendorid
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].vendorid.checked) { count=1;}
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

<body >
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="800" height="200" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">Vendor Details</div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="900" border="0" cellspacing="0" cellpadding="0">
					<tr class="BackGround">
						<td width="40" class="bold1">
						<div align="center">Id</div>
						</td>
						<td class="bold1" width="70">
						<div align="center">Date</div>
						</td>
						<td class="bold1" width="170">
						<div align="center">Vendor Name</div>
						</td>
						<td class="bold1" width="60">
						<div align="center">On Hold</div>
						</td>
						<td class="bold1" width="70">
						<div align="center">Quo Status</div>
						</td>
						<td class="bold1" width="100">
						<div align="center">Total Amount</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">
				<table width="100%">
					<tr>
						<td class="bolddeepblue" align="center">
						<div align="center">Total no of Records :: <%=com.my.org.erp.common.CommonInfo.intRecordCount("SELECT count(*) FROM  inv_m_vendorsinformation ")%></div>
						</td>
					</tr>
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<div id="divscroll" style="OVERFLOW:auto;width:900px;height:130px"
							class="boldEleven">
						<%
		  	try
			{ 
			String query ="SELECT * FROM  inv_m_vendorsinformation ";
			String order ="";
			String req =""+request.getParameter("startLetter").trim();
			
			if("null".equalsIgnoreCase(req) || "".equalsIgnoreCase(req))
				order= "";
			else if("AL".equalsIgnoreCase(req))
				order=" ORDER BY CHR_VENDORNAME";
			else 
				order= "WHERE CHR_VENDORNAME LIKE '"+req+"%'  ";
				
			query =query+ order;
			
			
			String tableData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(query);
			out.print("<table width='880' border='0' cellspacing='1' cellpadding='1'>");
			boolean bgflag = false;
			String branch ="";
			String sql ="";
			String active="";
			if(com.my.org.erp.common.CommonInfo.RecordExist(query))
			{
			 for(int u=0; u<tableData.length; u++)
			 {
				if(bgflag)
				{
					bgflag = false;
					out.print("<tr class='MRow1'>");
				}
				else
				{
					bgflag = true;
					out.print("<tr  class='MRow2'>");
				}				
				out.print("<td width='20' class='boldEleven'><input name='vendorid' type='checkbox' value='"+tableData[u][1].trim()+"'>"+tableData[u][1]+"</div></td>");
				out.print("<td width='123' class='boldEleven'>");
				out.print("<a href='VendorInfoEdit.jsp?vendorid="+tableData[u][1].trim()+"' class='boldEleven'>");
				out.print("<font color='#000000'>"+tableData[u][2]+"</font></a></div></td>");				
				out.print("<td width='94' class='boldEleven'>"+tableData[u][3]+"</td>");
				out.print("<td width='94' class='boldEleven'>"+tableData[u][5]+"</td>");
				out.print("<td width='118' class='boldEleven'>"+tableData[u][6]+"</td>");
				out.print("<td width='93' class='boldEleven'>"+tableData[u][10]+"</td>");
				out.print("<td width='90' class='boldEleven'>"+tableData[u][11]+"</td>");
				
				if("1".equals(tableData[u][14].trim()))
						out.print("<td width='66' class='boldEleven'>&nbsp;&nbsp;&nbsp;</td>");
				else
						out.print("<td width='66' class='boldEleven'>&nbsp;&nbsp;&nbsp;</td>");
				out.print("<td  width='83' class='boldEleven'>"+tableData[u][15]+"</td>");
				out.print("<td width='59' class='boldEleven' align='center'>"+tableData[u][18]+"</td>");
				out.print("</tr>");
			  }	
			 }
			 else
			 {
			 	out.println("<tr><td height=100><font color =red><center>Record not found ... "+req+"</center></font>");
			 } 
			out.print("</table>");
			 }
			 catch(Exception e)
			 {
			 }
		  %>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=AL">ALL</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=A">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=B">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=C">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=D">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=E">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=F">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=G">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=H">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=I">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=J">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=K">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=L">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=M">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=N">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=O">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=P">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=Q">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=R">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=S">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=T">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=U">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=V">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=W">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=X">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=Y">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="VendorInfo.jsp?startLetter=Z">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="VendorInfo" /> <input
			name="actionS" type="hidden" value="INVvendorInfoDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action1"  value="Add"   accesskey="s"   onclick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action12" value="Edit"
					onclick="return Edit()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="Submit3" value="Delete"
					onclick="return Delete()" /></td>
				<td width="56"><input type="submit" class="buttonbold"
					name="submit"  value="Close"   accesskey="c"  onClick="javascript:history.back()" /></td>
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
</table>

<%@ include file="../footer.jsp"%></form>
</body>
</html>
