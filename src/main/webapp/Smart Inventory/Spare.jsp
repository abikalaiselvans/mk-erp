<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
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
<script language="javascript" src="../JavaScript/Inventory/Spare.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="SpareActions.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].rowid
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
			document.frm.action="SpareActions.jsp";
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
		coffee1=document.forms[0].rowid
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

  
</script>
 <body onLoad="callloadSpare('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
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
		<table height="220" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
			  <td height="31" align="center"  ><table width="598" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <td class="boldThirteen">SPARE GROUP </td>
                  <td>
				  <select name="sparegroup" class="formText135"  id="sparegroup" onChange="callloadSpare('0')">
				 	<option value="0">All</option>
				  <%
				  String Data[][] =CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME FROM  inv_m_sparegroup  ORDER BY CHR_GROUPNAME");
				  for(int u=0;u<Data.length;u++)
				  	out.println("<option value='"+Data[u][0]+"'>"+Data[u][1]+"</option>");
				  %>
                  </select> 
				  <script language="javascript">setOptionValue('sparegroup','<%=request.getParameter("sparegroup")%>')</script>

				                   </td>
                  <td><span class="boldThirteen">Search Spare Name</span></td>
                  <td><span class="boldThirteen">
<input type="text" name="search" id="search" maxlength="20" size="20" class="formText135" onKeyUp="callloadSpares()" >
                  </span></td>
                </tr>
              </table></td>
		  </tr>
			 
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr  >
					  <td width="107"  >Group</td>
						<td width="107" height="0"  >
						<div align="left">Name</div>						</td>
						<td   width="250">Description</td>
						<td   width="150">
						<div align="left">Warranty(Yrs)</div>						</td>
						<td   width="150">Purchase Price</td>
						<td   width="150">
						<div align="left">Sales Price</div>						</td>
						<td   width="150">
						<div align="left">Active</div>						</td>
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 
						 
						
						
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven"></div>	
						<br><br><div align="center" id="totRec"></div>	<br>	<br>	
						
						
						
										</td>
		  </tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign"  >
        <tr >
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('0')">All</a></div></td>
		  <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloadSpare('Z')">Z</a></div></td>
        </tr>
      </table></td>
	</tr>
	<tr>
		<td></td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td><input type="hidden" name="filename" value="Spare" /> 
		<input
			type="hidden" name="actionS" value="INVSpareDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>

				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>
					
					
					<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit" id="Submit" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
		
		
				 
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>		</td>
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
