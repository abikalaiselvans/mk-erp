<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>

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
<style type="text/css">
<!--
.style3 {font-weight: bold}
.style4 {font-weight: bold}
.style5 {font-weight: bold}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" ></script>
<script language="javascript" src="../JavaScript/Inventory/BudgetAssign.js"></script>
<script language="javascript">
 function Add()
	{ 
		document.frm.action="BudgetAdd.jsp";
 	}

	function Edit()
	{	
		var chkbox=document.forms[0].id;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					document.frm.action="BudgetEdit.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="BudgetEdit.jsp";
				return true;
			}
	}
	
	
	
	
function Delete()
{

	var chkbox=document.forms[0].id;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
			len++;
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

<body    onLoad="loadBudgetAssign('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="get" name="frm"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="100" border="1" align="center" cellpadding="0" cellspacing="0"   class="BackGround">
        <tr>
          <td><div align="center"><strong>Budget</strong></div></td>
        </tr>
        <tr class="BackGround">
          <td><table width="100" border="0" align="center" cellpadding="5" cellspacing="0">
            <tr>
			<td><strong>Accessories</strong></td>
						<td>
						<select name="access" class="formText135"	id="access" tabindex="1" onChange="loadBudgetAssign('0')">
						<option value="0">All</option>
						<%
						String accdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM  inv_m_accessoriesgroup  ORDER BY CHR_GROUPNAME");
			for(int x=0;x<accdata.length;x++)
				out.println("<option value='"+accdata[x][0]+"'>"+accdata[x][1]+"</option>");
				
						%>
					</select>	
						</td>
			<td><strong>Department</strong></td>
              <td><select name="dept" class="formText135 style5"	id="dept" tabindex="1" onChange="loadBudgetAssign('0')">
			  <option value="0">All</option>
                  <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(deptsql);
			for(int x=0;x<deptdata.length;x++)
				out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			%>
                </select>              </td>
              <td><strong>Year</strong></td>
              <td><strong>
                  <select name="year" id="year"  onChange="loadBudgetAssign('0')">
                    <%
					java.util.Date dts = new java.util.Date();
					int ms = dts.getYear();
					%>
					<%
						  for(int i=2000;i<=2050;i++)
						  {
						   out.println("<option value="+i+">"+i+"-"+(i+1)+"</option>");
						  }
					  %>
                    </select>
                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('year',year1);							
				//-->
                  </script>
              </strong></td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
            <div id="BudgetTable" style="OVERFLOW:auto;width:900;height:260px"class="boldEleven"> </div>
          </div></td>
        </tr>
      </table></td>
    </tr>
	
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a
					href="javascript:loadBudgetAssign('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadBudgetAssign('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td valign="top"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick=" Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1" value="Edit"
					onclick=" return Edit()" /></td>
          <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Submit" value="Delete"
					onclick=" return Delete()" /></td>
          <% }%>
          <td width="56"><input name="Close" type="button"
					class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
	<tr>
		<td valign="top"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
		  <input
										type="hidden" name="filename" value="BudgetAssign" />
          <strong><font
										color="#000000"><font size="1">
          <input
										type="hidden" name="actionS" value="INVBudgetAssignDELETE" />
          </font></font></strong></font></font></strong></font></font></strong></font></td>
	</tr>
</table>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
