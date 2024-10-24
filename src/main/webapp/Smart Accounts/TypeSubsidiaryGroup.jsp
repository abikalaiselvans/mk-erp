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

 
<style type="text/css">
<!--
.style3 {font-size: 10px}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Account/TypeSubsidiaryGroup.js"></script> 
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="TypeSubsidiaryGroupAction.jsp";//CreditDebitGroupAction.jsp
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
			 
			document.frm.action="TypeSubsidiaryGroupAction.jsp";
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadTypeSubsidiaryGroup('0')" >
<p><br>
  <br>
  <%@ include file="indexacct.jsp"%>
</p>
<p>&nbsp;</p>
<form name="frm" method="get">
 <table width="706" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
        <tr class="BackGround">
          <td height="31" class="BackGround"><div align="center">  SUBSIDIARY GROUPS ( LIST OF GROUPS) </div></td>
        </tr>
        <tr class="BackGround">
          <td height="31" class="BackGround"><table  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td class="bold1">Sub Group </td>
              <td><select name="group" id="group" class="formText135" onChange="LoadTypeSubsidiaryGroup('0')" onBlur="LoadTypeSubsidiaryGroup('0')">
				<option value="0">All</option>
				<%
				String sql = "SELECT INT_TYPESUBGROUPID,CHR_TYPESUBGROUPNAME FROM  accc_m_typesubgroups ORDER BY CHR_TYPESUBGROUPNAME" ;
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				for(int u=0;u<data.length;u++)
					out.println("<option value='"+data[u][0]+"'>"+data[u][1]+"</option>");
				%>
              </select>
              </td>
            </tr>
          </table></td>
        </tr>
         
        <tr class="BackGround">
          <td height="31" class="BackGround">
		  
		  
              <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr class="BackGround">
                  <td width="19%" class="bold1">S.No</td>
                  <td width="35%" align="left" class="bold1">Subsidiary </td>
                  <td width="46%" align="left" class="bold1"><div align="left"> Group Under </div></td>
                </tr>
              </table>         </td>
        </tr>
        <tr>
          <td class="bolddeepblue"></td>
        </tr>
  <tr>
          <td class="bolddeepblue">
  
  <div id="divTable" style="OVERFLOW:auto;width:100%;height:auto" class="boldEleven"></div>
  <br>
  <div id="totalrec"></div>
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
	  <td height="19"><table width="600" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:LoadTypeSubsidiaryGroup('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td height="19"><input type="hidden" name="filename" value="TypeSubsidiaryGroup" />
        <input type="hidden" name="actionS" value="ACCSubsidiaryGroupDelete" /></td>
  </tr>
	<tr>
		<td height="19"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top">
			<input type="Submit" class="buttonbold13" name="action1" id="Add" value="Create" onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Alter"  
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
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
