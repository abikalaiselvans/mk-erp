<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
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
<script language="javascript" src="../JavaScript/Account/Payements.js"></script>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="PayementsAdd.jsp";
 	}

	function IEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].expenseid;
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
			if (document.forms[0].expenseid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="PayementsEdit.jsp";
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
		coffee1=document.forms[0].expenseid
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
			if (document.forms[0].expenseid.checked) { count=1;}
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadPayments('0')"	>
<%@ include file="indexacct.jsp"%>
<form name="frm" action="" method="get">
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="19">
		<%
		String fyear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
		String y[] = fyear.split("-");
		String fyear1= y[0];
		String fyear2= y[1];
		String fsql = " SELECT (SUM(a.DOU_AMOUNT))-(SUM(b.DOU_AMOUNT)) FROM   acc_t_receipts   a ,acc_t_payments  b";
		fsql = fsql +" WHERE  a.DAT_DATE>='"+fyear1+"-04-01' ";
		fsql = fsql +" AND a.DAT_DATE<='"+fyear2+"-03-31' ";
		fsql = fsql +" AND b.DAT_DATE>='"+fyear1+"-04-01' "; 
		fsql = fsql +" AND b.DAT_DATE<='"+fyear2+"-03-31' "; 
		fsql = fsql +" AND a.INT_BRANCHID="+session.getAttribute("ACCBRANCH");
		fsql = fsql +" AND b.INT_BRANCHID="+session.getAttribute("ACCBRANCH");
		out.println(session.getAttribute("ACCBRANCH"));
		//out.println(com.my.org.erp.Account.CommonFunctions.currentBalance(""+session.getAttribute("ACCBRANCH")));
		%></td>
	</tr>
	<tr>
	  <td height="19"><table width="842" height="176" border="1" align="center"
			cellpadding="0" cellspacing="0"  
			style="border-width: 2px; border-color: #94C1E4; border-style: solid; ">
        <tr class="BackGround">
          <td height="22" class="BackGround"><div align="center"><span class="boldThirteen"> Payements </span> </div>
		    <div align="right">Cash as on Balance :: <b></b>
		  
		    </div></td>
        </tr>
        <tr class="BackGround">
          <td height="25" class="BackGround"><table width="475" border="0" align="center" cellpadding="0"
					cellspacing="0">
              <tr>
                <td class="copyright style3">Branch</td>
                <td class="copyright style3"><select name="branch" id="branch" onBlur="LoadPayments('0')">
                    <jsp:include page="Branchload.jsp" flush="true" />                
                </select>
                    <script language="javascript">setOptionValue('branch','<%=""+session.getAttribute("ACCBRANCH")%>')</script>                </td>
                <td width="87" height="19" class="copyright style3">Month ::</td>
                <td width="76"><select name="month" id="month"
							onBlur="LoadPayments('0')">
                    <%@ include file="../JavaScript/common/month.jsp"%>
                </select></td>
                <td width="50" class="copyright style3">Year ::</td>
                <td width="88"><select name="year" id="year"
							onBlur="LoadPayments('0')">
                    <%@ include file="../JavaScript/common/year.jsp"%>
                  </select>
                    <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
          </script></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="127" valign="top" class="footermenu"><table width="100%">
              <tr>
                <td><div id="divscroll" style="OVERFLOW:auto;width:100%;height:150px" 	class="boldEleven">
                     
                </div></td>
              </tr>
              <tr>
                <td class="bolddeepblue" align="center"><div align="center" id="totRec"></div></td>
              </tr>
          </table></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td height="19"><input name="filename" type="hidden" value="Payements" />
      <input
			name="actionS" type="hidden" value="ACCPayementsDelete" /></td>
	</tr>
	<tr>
	  <td height="19"><table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:LoadPayments('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
		<td height="19"><table border="0" align="center" cellpadding="3" cellspacing="3">
          <!--DWLayoutTable-->
          <tr>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Edit"
					onclick="return IEdit()" /></td>
            <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
            <td width="56"><input type="submit" class="buttonbold13"
					name="Submit3" id="btnDelete" value="Delete"
					onClick="return Delete()" /></td>
            <%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		}
		%>
            <td width="56"><input type="Button" class="buttonbold13"
					name="submits"  value="Close"   accesskey="c"  onClick="redirect('AccountsMain.jsp')" /></td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
