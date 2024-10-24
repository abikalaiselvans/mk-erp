<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<%
try
{
%>
<html>
<head>

<title> :: AMC ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


 
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>


<script language="JavaScript">

function PEdit()
{		 
	try
	{
		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		 
		if(count==1)
		{			
			document.frm.action="AMCActionEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
	}
	catch(err)
	{
		alert(err.description)
	}	
}	
 	
	
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
	<form  AUTOCOMPLETE = "off"   name="frm" method="get" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
	
	

	<table height="215" align="center"
			cellpadding="1" cellspacing="1" class="TableDesign"  >
      <tr >
        <td height="31" ><div align="center" class="whiteMedium">CONTRACT INFORMATION </div></td>
      </tr>
      
      
      <tr class="MRow1">
        <td height="127" valign="top" class="footermenu"><br>
            <div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" align="center"	 >
            
                <%
String customerid= request.getParameter("customerid");
String Serviceitemid= request.getParameter("Serviceitemid");

String sql="";
sql =" SELECT ";
sql = sql + " a.INT_AMCID,a.CHR_AMCID,c.CHR_CUSTOMERNAME,b.CHR_SERVICEITEMNAME,a.CHR_SERIALNO,a.CHR_DESC,  ";
sql = sql + " DATE_FORMAT(DAT_UPDATION,'%d-%m-%Y'),DATE_FORMAT(DT_ENDDATE,'%d-%m-%Y'),INT_NOOFYEAR FROM  inv_m_serviceamc a,inv_m_serviceitems b,inv_m_servicecustomerinfo c ";
sql = sql + " WHERE a.INT_SERVICEITEMID= b.INT_SERVICEITEMID ";
sql = sql + " AND a.INT_CUSTOMERID =c.INT_CUSTOMERID ";
sql = sql + " AND a.INT_CUSTOMERID="+customerid;
sql = sql + " AND a.INT_SERVICEITEMID="+Serviceitemid;
sql = sql + " ORDER BY a.INT_AMCID ";
String readData[][] =CommonFunctions.QueryExecute(sql);
if(readData.length>0)
{
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr bgcolor='#ffffff'><td class='bolddeeplogin'><b>S.No</b></td>");
	out.println("<td class='bolddeeplogin'><b>Customer Name</b></td>");
	out.println("<td class='bolddeeplogin'><b>Pheriperals</b></td>");
	out.println("<td class='bolddeeplogin'><b>Serial Number</b></td>");
	out.println("<td class='bolddeeplogin'><b>Description</b></td>");
	out.println("<td class='bolddeeplogin'><b>Start Date</b></td>");
	out.println("<td class='bolddeeplogin'><b>End Date</b></td>");
	out.println("<td class='bolddeeplogin'><b>No of.Years</b></td>");
	out.println("<td class='bolddeeplogin'><b>&nbsp;</b></td>");
	
	for(int u=0;u<readData.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
		
		out.println("<td class='boldeleven'>"+(u+1)+"<input name='id' id='id' type='checkbox' value='"+readData[u][0]+"'/></td>");
		out.println("<td class='boldeleven'>"+readData[u][2]+"</td>");
		out.println("<td class='boldeleven'>"+readData[u][3]+"</td>");
		out.println("<td class='boldeleven'><a href='AMCActionEdit.jsp?action1=edit&id="+readData[u][0]+"'><font class='boldgreen'>"+readData[u][4]+"</a></font></td>");
		out.println("<td class='boldeleven'>"+readData[u][5]+"</td>");	
		out.println("<td class='boldeleven'>"+readData[u][6]+"</td>");	
		out.println("<td class='boldeleven'>"+readData[u][7]+"</td>");	
		out.println("<td class='boldeleven' align='right'>"+readData[u][8]+"</td>");	
		if("F".equals(session.getAttribute("USRTYPE")))
			out.println("<td class='boldeleven' ><a href='../SmartLoginAuth?filename=ServiceAMC&actionS=AMCServiceAMCDELETEs&id="+readData[u][0]+"'><font class='bolddeepred'>Delete</font></a></td>");	
		else
			out.println("<td class='boldeleven' >&nbsp;</td>");	
			
	}	
	out.println("</table>");
	out.println("</center>");
}

				%>
              </div>                   </td>
      </tr>
    </table>
</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><input name="filename" type="hidden" value="ServiceAMC" />
      <input name="actionS" type="hidden" value="AMCServiceAMCDELETE" />
	  <input name="action1" id="action1"  type="hidden" value="Edit">
      <table width="168" border="0" align="center" cellpadding="5" cellspacing="5">
      <tr>
        <td width="56">
		<input type="submit" class="ButtonHead" name="Edit" id="Edit" value="Edit" onClick="return PEdit()" /></td>
        
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
		
		
		
        <td width="56"><input type="button" class="ButtonHead" name="submit"  value="Close"   accesskey="c"  onClick="redirect('amc.jsp')" /></td>
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
}
%>