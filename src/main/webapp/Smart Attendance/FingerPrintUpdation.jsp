<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>
<%
	try
	{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 function Deletes()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count==1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth?filename=FingerPrint&actionS=ATTFPRegCancel";
				document.frm.submit();
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
 <table width="101%" align="center">
	
	
	<tr>
		<td height="21" colspan="6" align="center" class="bolddeepred">
		 	</td>
	</tr>
	<tr>
	  <td height="21" colspan="6" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
   </tr>
	<tr>
		<td height="80" colspan="6" align="center">
		
		
		<form name="frm" method="post">
		
		
		<table width="90%" height="177" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"  >
				<td height="28"  
					 ><div align="center" class="whiteMedium">Fingerprint Staffs Informations </div></td>
			</tr>

			<tr  >
				<td height="31" align="left" valign="middle"  >
				<table width="100%"  border="0" class="whiteMedium"
					  >
					<tr>
						<td  >Staff Id</td>
						<td  >Staff Name</td>
						<td >Company</td>
						<td  >Branch </td>
						<td > Department</td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td valign="top" bgcolor="#FFFFFF">
                  <div id="staffTable" style="OVERFLOW: auto;width:100%;height:250px">
<%
	String sql="SELECT a.CHR_EMPID,a.CHR_STAFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,b.CHR_OFFICENAME ";
	sql = sql +" FROM com_m_staff a ,  com_m_office  b ,com_m_depart c ,  com_m_branch f , com_m_company g  ,com_m_staffimage h";
	sql = sql +" where a.CHR_HOLD!='Y'  AND a.CHR_TYPE!='T' AND a.INT_COMPANYID =g.INT_COMPANYID  AND a.INT_BRANCHID =f.INT_BRANCHID ";
	sql = sql +" AND a.INT_DEPARTID = c.INT_DEPARTID AND a.INT_OFFICEID= b.INT_OFFICEID AND a.CHR_EMPID  =h.CHR_EMPID ORDER BY a.CHR_EMPID ";
	 
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	out.println("<table  width='100%'  border='0'>");
	for(int u=0;u<data.length;u++)
	{
		
		 out.println("<tr>");
		 out.println("<td   class='boldEleven'><input name='staffid' type='checkbox' value='"+data[u][0]+"'>"+data[u][0]+"</td>");
		 out.println("<td   class='boldEleven'>"+data[u][1]+"</td>");
		 out.println("<td   class='boldEleven'>"+data[u][2]+"</td>");
		 out.println("<td   class='boldEleven'>"+data[u][3]+"</td>");
		 out.println("<td   class='boldEleven'>"+data[u][4]+"</td>");
		 out.println("</tr>");
					
	}
	out.println("</table>");
%>
					
</div>
		</table> 	
		
</form>			 
	</tr>
	<tr>
		<td height="17" colspan="6"><input name="filename" type="hidden"
			id="filename" value="FingerPrint "> <input name="actionS"
			type="hidden" id="actionS" value="ATTFPRegCancel"></td>
	</tr>

	<tr>
		<td height="17" colspan="6">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
			
			
<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return Deletes()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>

			
				 
				<td width="56"><input class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')" /></td>
				
			</tr>
		</table>
		</center>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>



<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
