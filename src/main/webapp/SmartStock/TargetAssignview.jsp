<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
 
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

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Stock/TargetAssignview.js"></script>

<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="TargetAssignAction.jsp";

 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].TargetAssignid
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
			if (document.forms[0].TargetAssignid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="TargetAssignAction.jsp";
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
		coffee1=document.forms[0].TargetAssignid
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
			if (document.forms[0].TargetAssignid.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadTargetAssign('0')">
<%
try
{
%>
<%@ include file="indexstock.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>

	<tr>
	  <td height="19"><form  method="post" name="frm" id="frm">
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><table width="100%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
              <tr class="BackGround">
                <td height="31" class="BackGround"><div align="center" class="boldThirteen">Target Assign </div></td>
              </tr>
              <tr class="BackGround">
                <td height="31" class="BackGround">
				
				<table width="100" border="0" align="center" cellpadding="5" cellspacing="0">
            <tr>
              <td class="boldEleven"><strong>Office</strong></td>
              <td class="boldEleven">
			  <select name="office" class="formText135 style3"	id="office" tabindex="1" onChange="loadTargetAssign('0')">
                  <%
			String officesql="SELECT INT_OFFICEID,CHR_OFFICENAME FROM  com_m_office  ORDER BY INT_OFFICEID";
			String officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(officesql);
			for(int x=0;x<officedata.length;x++)
				out.println("<option value='"+officedata[x][0]+"'>"+officedata[x][1]+"</option>");
			%>
                </select>              </td>
              <td class="boldEleven"><strong>Department</strong></td>
              <td class="boldEleven"><select name="dept" class="formText135 style5"	id="dept" tabindex="1" onChange="loadTargetAssign('0')">
                  <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(deptsql);
			for(int x=0;x<deptdata.length;x++)
				out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			%>
                </select>              </td>
              <td class="boldEleven"><strong>Year</strong></td>
              <td class="boldEleven"><strong>
                  <select name="Financialyear" id="Financialyear">
	<%
		String CurrentFinancialYear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
		String ydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_FINANCIALYEARID,CHR_FINANCIALYEAR FROM  com_m_financialyear ORDER BY INT_FINANCIALYEARID");
		for(int u=0;u<ydata.length;u++)
			if(CurrentFinancialYear.equals(ydata[u][1]))
				out.println("<option selected='selected' value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");
			else
				out.println("<option   value='"+ydata[u][0]+"'>"+ydata[u][1]+"</option>");	
			
	%>
    </select>
              </strong></td>
              <td>&nbsp;</td>
            </tr>
          </table>
				</td>
              </tr>
              
              <tr>
                <td height="127" valign="top" class="footermenu">
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven"></div>
				<br>
				<div id='totalrecord' align="center"></div>
				<br>
				</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
              <tr class="para">
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadTargetAssign('Z')">Z</a></div></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="296" border="0" align="center" cellpadding="1"
			cellspacing="1">
              <!--DWLayoutTable-->
              <tr>
                <td width="56" valign="top"><input type="hidden" name="filename" value="TargetAssign" />
                    <input type="hidden" name="actionS" value="STKTargetAssignDelete" /></td>
                <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
                <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"   value="Edit"	onclick="return Edit()" /></td>
                <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
                <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="Submit"   value="Delete"		onclick="return Delete()" /></td>
                <%
	   }
	   %>
                <td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('StockMain.jsp')" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
	  </form>	  </td>
	   
	  
	  	  </td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	
	
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>
