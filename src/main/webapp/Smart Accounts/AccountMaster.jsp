<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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

<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Account/AccountMaster.js"></script>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="AccountMasterAction.jsp";//CreditDebitGroupAction.jsp
 	}

	function GEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="AccountMasterAction.jsp";
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
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="AccountMaster('0')" >

<%@ include file="indexacct.jsp"%>
<form name="frm" method="get">
 <p>&nbsp;</p>
 <table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
        <tr class="BackGround">
          <td height="31" class="BackGround"><div align="center"><span class="bold1">Account Master </span></div></td>
        </tr>
         
        <tr class="BackGround">
          <td height="31" class="BackGround">
		  
		  
              <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr class="BackGround">
                  <td colspan="2" class="bold1"><table width="219" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td class="bold1">Account Group</td>
                      <td class="boldEleven"><select name="accountgroup" class="formText135" id="accountgroup" onChange="AccountMaster('0')">
					  <option value="0">All</option>
					  <%
					  String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ACCOUNTGROUPID,CHR_ACCOUNTGROUPNAME FROM acc_m_accountgroup ORDER BY CHR_ACCOUNTGROUPNAME ");
					  for(int u=0; u<data.length;u++)
					  	out.println("<option value='"+data[u][0]+"'>"+data[u][1]+"</option>");
						
					  %>
						
                      </select>
                      </td>
                    </tr>
                  </table></td>
                </tr>
                <tr class="BackGround">
                  <td class="bold1">S.No</td>
                  <td class="bold1" align="left"><div align="left"> Group Name</div></td>
                </tr>
              </table>
			  
         </td>
        </tr>
        <tr>
          <td class="bolddeepblue"></td>
        </tr>
  <tr>
          <td class="bolddeepblue">
  
  <div id="AccountMasterTable" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven"></div>
  <br><div id="totalrec"></div>
  <br>
	</td>
    </tr>				
    <table width="100%">
      <tr>
        <td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
      </tr>
      <tr>
        <td> 
        <td width="50" class="boldEleven" align="center"> </td>
        <td class="boldEleven">                   </td>
      </tr>
       
      
    </table>
 
   
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
	  <td height="19"><table width="100%" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:AccountMaster('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td height="19"><input type="hidden" name="filename" value="AccountMaster" />
        <input type="hidden" name="actionS" value="ACCAccountMasterDelete" /></td>
  </tr>
	<tr>
		<td height="19"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top">
			<input type="Submit" class="buttonbold13" name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Edit"  
					onclick="return GEdit()" /></td>
            <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Submit" id="Delete" value="Delete"  
					onclick="return RDelete()" /></td>
            <%
		}
		%>
            <td width="56"><input type="Button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('AccountsMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
	
	
</table>
 <p>&nbsp;</p>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
