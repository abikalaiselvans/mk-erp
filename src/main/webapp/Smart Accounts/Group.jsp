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
<script language="javascript" src="../JavaScript/Account/Group.js"></script>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="GroupAdd.jsp";//CreditDebitGroupAction.jsp
 	}

	function GEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].groupid
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
			if (document.forms[0].groupid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="GroupEdit.jsp";
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
		coffee1=document.forms[0].groupid
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
			if (document.forms[0].groupid.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Group('0')" >

<%@ include file="indexacct.jsp"%>
<form name="frm" method="get">
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
		<td width="1000" height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19"><table width="600" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
        <tr class="BackGround">
          <td height="31" class="BackGround">
		  <table width="283" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td class="bold1">Group</td>
              <td class="bold1"> 
                <select name="group"  id="group" class="formText135" onChange="Group('0') ">
                  <option value="0">All</option>
				  <option value="C">Credit</option>
				  <option value="D">Debit</option>
				  <%
				  	//String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				  %>
                </select>
              
              </td>
            </tr>
          </table>
		  </td>
        </tr>
         
        <tr class="BackGround">
          <td height="31" class="BackGround">
		  
		  
              <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr class="BackGround">
                  <td class="bold1"></td>
                  <td class="bold1" align="left"><div align="left"> Group Name</div></td>
                </tr>
              </table>
			  
         </td>
        </tr>
        <tr>
          <td class="bolddeepblue"><div id="totalrec"></div></td>
        </tr>
  <tr>
          <td class="bolddeepblue">
  
  <div id="GroupTable" style="OVERFLOW:auto;width:600px;height:130px" class="boldEleven"></div>
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
					href="javascript:Group('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a
					href="javascript:Group('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td height="19"><input type="hidden" name="filename" value="Group" />
        <input type="hidden" name="actionS" value="ACCGroupDelete" /></td>
  </tr>
	<tr>
		<td height="19"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top">
			<input type="Submit" class="buttonbold13" name="Add" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Edit"  
					onclick="return GEdit()" /></td>
            <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Submit" value="Delete"  
					onclick="return Delete()" /></td>
            <%
		}
		%>
            <td width="56"><input type="Button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('AccountsMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
	
	
</table>
 
<%@ include file="../footer.jsp"%>
</body>
</html>
