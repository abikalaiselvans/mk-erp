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
<script language="javascript" src="../JavaScript/Stock/Tax.js"></script>

<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="TaxAction.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Taxid
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
			if (document.forms[0].Taxid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="TaxAction.jsp";
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
		coffee1=document.forms[0].Taxid
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
			if (document.forms[0].Taxid.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadTax('0')">
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
                <td height="31" class="BackGround"><div align="center" class="boldThirteen">TAX</div></td>
              </tr>
              <tr class="BackGround">
                <td height="31" class="BackGround"><table width="100%"    border='0' class='boldEleven' cellspacing=1 cellpadding=2>
                    <tr  class='MRow1'>
                      <td  class='bold1' align='center'><div align='center'>S.No</div></td>
                      <td  class='bold1' align='center'><div align='center'> Name</div></td>
                      <td  class='bold1' align='center'><div align="center">Value</div></td>
                      <td  class='bold1' align='center'><div align='center'>Description</div></td>
                    </tr>
                </table></td>
              </tr>
              
              <tr>
                <td height="127" valign="top" class="footermenu">
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:130px" class="boldEleven"></div>
				<br><div id='totalrecord' align="center"></div>
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
					href="javascript:LoadTax('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTax('Z')">Z</a></div></td>
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
                <td width="56" valign="top"><input type="hidden" name="filename" value="Tax" />
                    <input type="hidden" name="actionS" value="STKTaxDelete" /></td>
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
