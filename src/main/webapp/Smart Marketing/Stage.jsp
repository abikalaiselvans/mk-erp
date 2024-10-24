<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<%
try
{
%>


<html>
<head>
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


<title> :: MARKETING ::</title>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Marketing/Stage.js"  ></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="StageAction.jsp";
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
			document.frm.action="StageAction.jsp";
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
		try
		{		
			
			obj = findObj("id"); 
			if(obj == null)
			{
				alert("Delete not available");
				return false;
			}



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
		catch(err)
		{
			alert(err);
			return false;
		}
 	}
 </script>
<body onselectstart="return false" onpaste="return false;" onCopy="return false"    onLoad="LoadStage('0')" >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
	  <td><div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='5' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='GAdd()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return GEdit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_MKT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	 
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'MarketingMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="31"  ><div align="center" class="whiteMedium">STAGE</div></td>
        </tr>
          
        <tr class="MRow1">
          <td  >
		  <div id="GroupTable" style="OVERFLOW:auto;width:100%x;height:300px" class="boldEleven"></div>
		  <br><div id="totalrec"></div> <br> 		  </td>
        </tr>
         
	     
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadStage('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
      <input type="hidden" name="filename" value="Stage" />
      <input type="hidden" name="actionS" value="MKTStageDelete" />
      </span></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
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
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>