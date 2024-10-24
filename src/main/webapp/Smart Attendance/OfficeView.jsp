<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ include file="index.jsp"%>
 
<%!
	String OfficeId,OfficeName;
%>
<%@ page import="com.my.org.erp.bean.Attendance.Office"%>

<%
try
{
%>
<html>

 

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
<script language="javascript">    
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptOfficeName
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
			if (document.forms[0].OptOfficeName.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				//document.frm.submit();
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
 	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptOfficeName
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
			if (document.forms[0].OptOfficeName.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="OfficeAction.jsp";
//			document.frm.submit();
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	function Add()
 	{				
		document.frm.action="OfficeAction.jsp";
//		document.frm.submit();
 	}
 	function mainPage()
	{
	    document.frm.action="../RemoveSession";
    }
</script>

<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>

		<table width="800" height="220" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<tr>
			  <td height="30" align="center"  class="whiteMedium">OFFICE</td>
		  </tr>
			<tr>
				<td height="30" align="center"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
                  <tr>
                    <td width="74%" class="whiteMedium" style="font-weight: bold"><div align="center">OFFICE NAME </div></td>
                    <td width="26%" class="whiteMedium" style="font-weight: bold"><div align="center">SHORT NAME </div></td>
                  </tr>
              </table></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="152">
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px">
				<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >
					 
						<% 
      		
		 
			 
      		int count=1;      
			ArrayList OfficeList=(ArrayList) session.getAttribute("OfficeList");
			for(int i=0;i<OfficeList.size();i++)
			{
				Office office= (Office)OfficeList.get(i);
				if(count%2==0)
					out.print("<tr height='25' class='MRow1'>");
				else
				    out.print("<tr  class='MRow2'>");			
	 	 	 	count++;

			 	out.println("<td class='boldEleven'><input type='checkbox' name='OptOfficeName' value='"+office.getOfficeId()+"'>");
		 		out.println("<a href=OfficeAction.jsp?OptOfficeName="+office.getOfficeId()+"&action1=Edit><font class='boldEleven'>"+office.getOfficeName()+"</font></a>");
				out.println("<td class='boldEleven'>"+office.getOfficeshortname());
			    out.println("</tr>");
			}
			 
			String dis="";
			
			 if(OfficeList.size()==0) dis="disabled='disabled'";
			OfficeId=request.getParameter("OfficeId");
			 
%>
				</table>
			  </div><br><br>				</td>
			</tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		<table width="317" align="center">
			<tr>
				<td width="56"><div align="center"><input class="ButtonHead" type="submit"
					onClick="Add()" name="action1" value="Add"></div>				</td>
				<td width="56">
				<div align="center"><input class="ButtonHead" type="submit"
					<%=dis %> onClick="return Edit()" name="action1" value="Edit">
				</div>				</td>
				<%
	 String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>


				<td width="56">
				<div align="center"><input name="submit" type="submit"
					class="ButtonHead" onClick="return Delete()" value="Delete"
					<%=dis %>></div>				</td>

				<%
}
%>
				<td width="56">
				<div align="center"><input class="ButtonHead" type="submit"
					name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"></div>				</td>
			    <td width="69"  ><input type="hidden" name="filename"	value="Office"> <input type="hidden" name="msg"	value="">
			    <input type="hidden" name="actionS"	value="ATTOfficeDelete"></td>
			</tr>
		</table>		</td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>



